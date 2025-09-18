Return-Path: <linux-kernel+bounces-821891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AE9B828FD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 03:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F0317201A2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 01:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8856A243956;
	Thu, 18 Sep 2025 01:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="QTNBG51p"
Received: from mail-oa1-f100.google.com (mail-oa1-f100.google.com [209.85.160.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945D223ABB3
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 01:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758160239; cv=none; b=TUQ1LH3AELp+1FZMwqeisTtrLHAayZ8R+dA4HthOk0QobYKkrqEISu6DU65eswdPyBdDXvP5SAIMhhsDN5FAYWTXyllHymiFaPg83KL9mV9SATQo/r57XW98QazQT9DlA8+UU1ftusemm7oiVnNPJcdFN3XAWJHFc0jI9GKiGE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758160239; c=relaxed/simple;
	bh=8fCwSybfSb+ztMiEZfG9Uw8IwGt/oQT1hKJDe6hJClA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+yUtL+7y0ow/POsCEb0zRGAWm1+NCm6oHx/ui6mDZhuR1DHw4YCvj7gnPzoqGbOz+fO71vZ4dfxF4jc7lEflLmKFXykwVHVtZd+za3mqG+IHdjvhqLgeSGBedIYYJ0SrJjFpA3pGvsnCgCEK6wb/hkGl1o2mx5SFWEQde4DLhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=QTNBG51p; arc=none smtp.client-ip=209.85.160.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-oa1-f100.google.com with SMTP id 586e51a60fabf-3293984d2e9so97906fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 18:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758160237; x=1758765037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Hlg0LwnvqE1ZMcyukI63UK6V6Dmpb/JL+/bnCbL9es=;
        b=QTNBG51p/hP85+GWjau3NYEheZiYjP2oXDNYlaMjdZBbJuFOTzUq3zTjmzugMMocU4
         IcL084OIYrVqkjKjGlaMrULqjbTiYacGsEcBlj/s2lzmKs5UjQgKRxj3POFd76aPqrKL
         FA8PJdCIOCnqDRVmRPa++zO5vmzmxDHP8PV4+cI2MnT3eX3fEbF6C0VH9SNzQvLM6lrE
         OLjCl3xOpmAH1EC+rLOOjGWuWwPTVgseeibFUEnQLUsFtUEsxirhj8GvkxqTWm6Wnt6l
         fWHhznitS5k0BSZ13nNL4haCrvndc3pZ3zLYaamLQr4ex8i9TqT7WEHqNs6PBc7/Cc3G
         kGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758160237; x=1758765037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Hlg0LwnvqE1ZMcyukI63UK6V6Dmpb/JL+/bnCbL9es=;
        b=pvkYphDxpWJi4N/69gjFKjmVuh2m2iWOoY/PR2ABVTV++QRMdxyR+HDPPeQGVWW/Z8
         Jbt//YS1OuJOKBneWk/hiGUBQxeAyPeBd5uMId9Fyuy+yOI3/4agedbP6HJqfAjpCeHq
         fjmXYds7qQBAWpZbyazbzkn5PIOHLksZ76UXaOrNa+h7m5TUy1TaJWwxd2abY1qzXOCD
         9i5mI4MSbFsY5FA5PYk3AaKbDatqZ7CY9VTuzEyFUgEuUAFKSuM/nWrtR7+wXjPnhBcT
         qT2n5sMsXbM/wKlSLmrBYN+GXiF7gqt21UwOZhlmPSx1iFEz7Ov8sXRM+Xc74sIQXeTK
         BWHA==
X-Forwarded-Encrypted: i=1; AJvYcCXRi0VpNVPL8agDrvZnCeRaqO7aoaFAKSxput7XiLCfszpHug0iDCzVfdEl9ZqoeOfMJoaWk9q5ymEdLJo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd50hLvCFVJofDaHTd2p9AIsuEUhbPuhQ/YS7qw9FRQ5VoSRTT
	blIq+jE1BuXqeUT1Vada6SzCxK3DiPp0/ZPcWBwEaYv53D/f8bRAc92ym8+IU0r1e9lU9K7issS
	jdwYiUDF6a1oySk6mKBVut9z/iC+cJTZu0YHrYuRW4tncqb8lcdSP
X-Gm-Gg: ASbGncvte6QAT0yPSCPlIt4bml2a1UKX+VOIQymoQ9SEqhoe+nPTSqirr+9fn5Np10m
	xVTx7sMs78etTKqYdiAgmXxuqd+0l8L6kDwK3EN7NuoLQX6FFazznqPmEM/cTD8a+UP9NHZta5m
	sQbl5nM+tld4TFT/F7RYEnnGCGu1A0zYnGOYojA3BYS5gGYFc1zdULNbIUv5a3qpUYv+gL28MDB
	+ZheGUHazVGkbShUo/xofS4lCMi7SGC6ObXyv279pH9phy8hWkoX6I1v9eLuEcPMuFrl3vNSRCl
	1p8cY0IXDtT6QyWeqwW8f3TZzYfzsIvDNwbtFWlQMTi0qFOylVGZmdAzNw==
X-Google-Smtp-Source: AGHT+IH05i5HOyeOVNivDI54AuJFBG+1BVvOmWfCFFlEmT1TpgGivNz5pQWfiOVxR1apuSbY+NQLUExwZi6T
X-Received: by 2002:a05:6870:320f:b0:30b:81f6:6bc4 with SMTP id 586e51a60fabf-335c024c218mr1080971fac.6.1758160236712;
        Wed, 17 Sep 2025 18:50:36 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-336e4892c35sm122214fac.11.2025.09.17.18.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 18:50:36 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 04C1C340508;
	Wed, 17 Sep 2025 19:50:36 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 00DD7E41B42; Wed, 17 Sep 2025 19:50:35 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 05/17] ublk: don't dereference ublk_queue in ublk_ch_uring_cmd_local()
Date: Wed, 17 Sep 2025 19:49:41 -0600
Message-ID: <20250918014953.297897-6-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250918014953.297897-1-csander@purestorage.com>
References: <20250918014953.297897-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For ublk servers with many ublk queues, accessing the ublk_queue to
handle a ublk command is a frequent cache miss. Get the queue depth from
the ublk_device instead, which is accessed just before.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 04b8613ce623..58f688eac742 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2331,11 +2331,11 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 	if (q_id >= ub->dev_info.nr_hw_queues)
 		goto out;
 
 	ubq = ublk_get_queue(ub, q_id);
 
-	if (tag >= ubq->q_depth)
+	if (tag >= ub->dev_info.queue_depth)
 		goto out;
 
 	io = &ubq->ios[tag];
 	/* UBLK_IO_FETCH_REQ can be handled on any task, which sets io->task */
 	if (unlikely(_IOC_NR(cmd_op) == UBLK_IO_FETCH_REQ)) {
-- 
2.45.2


