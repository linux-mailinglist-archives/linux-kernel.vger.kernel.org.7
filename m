Return-Path: <linux-kernel+bounces-864102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE223BF9E8D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A79EF466E9A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 04:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DF42D193B;
	Wed, 22 Oct 2025 04:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwm5t3cm"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C239262815
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761106072; cv=none; b=Hz+z5U97iN1097dH9KU/EP6gJk90yOtPQmwHWFOaSjRt4geNVdcKKlB+s1yuj250OFyxbFdODO6DXzmkKDec9HYWhC2gsCLbD0lGRc61kg5rOMoUrgMBapdbDxR01yV/UQAKsFuXzqWDHuKwL2LrniQyVnntaupkz+wkak/siX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761106072; c=relaxed/simple;
	bh=MW4it84Oe/dptYdFMqsXjx3kV/biDh03d8d64XgDmRw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pw+E5ooE0/3p/R5yrL9Kt18tyclmW59T66rWHQRR0fzSEwIMX8kMauspIzp7r+QE1sIDWmvygjbNGsYw2FeEc0/UwsxLqfWN1rNU7T/tjb9QyPUdYpQ4JqA2sye3NVwxEQZVF1T0aLrdRfAinn1U5adBVHBXpKppMnjnjaxCPvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cwm5t3cm; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-430ca4647c7so23346975ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 21:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761106069; x=1761710869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OEw5FbM3fIxysAn/HQ5qF+JSuajA12j38hiocn2pFY4=;
        b=cwm5t3cm1hRHihqOBNWEEcJS6PIEzbVRd9e9t0JEbF27S1OoPbG0p3em7oreN8PlsH
         i9/4f9NmRPjCm+gD/th02pVl5s4+m1f2SO882nmdzOjNDlSucuTxBdlNYThdJsGdRbSS
         YDSplIVRFFB2FqJj3gtMUXBc6qxRiAfIhuty2k2H9eI/+bpN0BIir++ot1c2NGmZh7iD
         BiN15QEfsgOEFTXfs9pfPNkDDVLCTFKp9uIx5zMq/K2ixav2v0Ns8fehnpZVUbFjmBkZ
         QCMAUMCcQnnr1A67lWNqzNd6FJQyWjXshNpPv0lIZimvEHZtUF8z19lzOsp0L5u+8hec
         ss7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761106069; x=1761710869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OEw5FbM3fIxysAn/HQ5qF+JSuajA12j38hiocn2pFY4=;
        b=BFVuscmAotEmDSTJasAS0pDbleKksT3Qsk/ZGZSQCAqzpIwEz+vXJWwZTZAXml1o0N
         FlrUHR6gko81Rc/gxojm8EUk22UxaHG7vb28XJk0qaUZZ7JMKCinJLa/PZKersdLOZam
         F5rk8H/nv7dkX1y39GO54ad8p6/UoGHL15yKcJVIvKHWYQVbxYgDt72jwUdx5n6F1gOJ
         bgiANX9b1wuBNo8zuKpFNC4sXQ0mw65nk0qXp+kbqHENSi9Jtb01brGH65cjECgG4biU
         lvKgLhSv9OObbrLdWT6tXBA0MzjdnjJukdqoZvtLXI5ebwcVBfOzJta+cJ84XAbHH61v
         Qbmw==
X-Forwarded-Encrypted: i=1; AJvYcCXYeWhgPF4RGHFZG9oR5RKOrKtdQ/MaKSpnAvOMNH3+w/GWqDud0C3KM4+6L9bZfbyKMyFEHOcPlcpkjHk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4nTt5abr95ORCUEgjSEqnz0Vx1VuMQtRaqcOK7AvZFR0wnbtI
	D5yEP617Hk6Y7cs0xbhXNNZY6+SjazdgLnYxt1I+wrVzygE6VWCLlK5s
X-Gm-Gg: ASbGncv/qZn9kVfl+NJ1aE6LykboPZUflbaYUDlNaREeyWPnUsHYfbxqd2bqDjAKllx
	WM0Z/UTi39eivIoT6feXfB/GDdBVCulsIKW7IhiDP9598vekD0/jXaK/QgeQZzERcCM/WAmrBZm
	ILfJUNaoewmrIrkETh7GJf8/H/WpGmaF5Wwg2HZXjrsBop3GAcEJxEkD/Qsu/7+bjeH9sy76Pm0
	XpgZJn1ek8iibCDpbq+9DSBKQSMd9PzhVg8iaabB1WhzVFLhxEqVztnV162giTT65vdhx1ilNnG
	XQbUznxxO93+i/x1KSYMpaqMsnruWAQDgmIuPLkuLCFPCzVSAAyZSTClXnoYlqKZjTM0W/mnzbc
	EDZwXchgBleQqiKzNazY/r7RUcmfpkXE++3/+fXZEm0/Y9Jp0RxCjHHUdg4w/6JbkbSgf59E3xx
	7zkkFKr5Afn0y+XcErd/svQVZmzATG+xtcDXqzoGsUVdVDlfhrioBXjCd3b4aldEDqMz1upRc5z
	NbrFQaTLy1YbptCa/MdpjZHUQ==
X-Google-Smtp-Source: AGHT+IHycVsOrBUODML9NXrlWEyYylPn+mFR0f8GM0RC+6bm0D8tC29dIctmGREmTFZcZ0hx5duVJg==
X-Received: by 2002:a05:6e02:16ce:b0:42f:9e92:a434 with SMTP id e9e14a558f8ab-430c52b5a2cmr232223235ab.21.1761106069589;
        Tue, 21 Oct 2025 21:07:49 -0700 (PDT)
Received: from abc-virtual-machine.localdomain (c-76-150-86-52.hsd1.il.comcast.net. [76.150.86.52])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a973ea40sm4752982173.31.2025.10.21.21.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 21:07:49 -0700 (PDT)
From: Yuhao Jiang <danisjiang@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Aaron Lu <aaron.lu@intel.com>,
	Hans de Goede <hansg@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuhao Jiang <danisjiang@gmail.com>
Subject: [PATCH] ACPI: video: Fix use-after-free in acpi_video_bus_put_devices()
Date: Tue, 21 Oct 2025 23:07:42 -0500
Message-Id: <20251022040743.2102717-1-danisjiang@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code contains a use-after-free vulnerability due to missing
cancellation of delayed work during device removal. Specifically,
in acpi_video_bus_remove(), the function acpi_video_bus_put_devices()
is called, which frees all acpi_video_device structures without
cancelling the associated delayed work (switch_brightness_work).

This work is scheduled via brightness_switch_event() in response to
ACPI events (e.g., brightness key presses) with a 100ms delay. If
the work is pending when the device is removed, it may execute after
the memory is freed, leading to use-after-free when the work function
acpi_video_switch_brightness() accesses the device structure.

Fix this by calling cancel_delayed_work_sync() before freeing each
acpi_video_device to ensure the work is fully completed before the
memory is released.

Fixes: 67b662e189f46 ("ACPI / video: seperate backlight control and event interface")
Cc: stable@vger.kernel.org
Signed-off-by: Yuhao Jiang <danisjiang@gmail.com>
---
 drivers/acpi/acpi_video.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 103f29661576..5b80f87e078f 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1974,6 +1974,7 @@ static int acpi_video_bus_put_devices(struct acpi_video_bus *video)
 
 	mutex_lock(&video->device_list_lock);
 	list_for_each_entry_safe(dev, next, &video->video_device_list, entry) {
+		cancel_delayed_work_sync(&dev->switch_brightness_work);
 		list_del(&dev->entry);
 		kfree(dev);
 	}
-- 
2.34.1


