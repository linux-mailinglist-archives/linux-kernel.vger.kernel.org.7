Return-Path: <linux-kernel+bounces-666711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5718AC7ADA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 May 2025 11:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FE894E36AA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 May 2025 09:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430F621C198;
	Thu, 29 May 2025 09:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xMwwPT9R"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADD82147F5
	for <linux-kernel@vger.kernel.org>; Thu, 29 May 2025 09:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748510161; cv=none; b=GkYXx7kUvEe7lbKSwRmoK3r+aOIJKhzRmQo4j7IVjEFKiQxEjRqSFriO6RIQ4S8ynw0jtlCbtWtruHAga+dbh/8ZV0RHm1Bi94l8iTQkL/7QRfwFYb0KkitVhFtHlUULs828+MJBH/3K0jYXr65Bfd1xyRt27aEbvzAOzOurzgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748510161; c=relaxed/simple;
	bh=dgQwzlZ78BgpNxIj5EI6KF5CPzlkbHaCeBBTWQKGv/M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CLRCWxmUzDR2U8AIQc6AtLQy8N+bYpdKugmz+ilvSUqCztTOA7xy6eaDsKVn2Zh9lTojg3LVzEXFwBgs/JN6qN8vUXt6LaJZEz1vJ8ayBv193BFBwUSRZYWuTh6MD6LkVRI3/Y+H14T+08YsTIrJ4mDdGcHiMIyrEm8n1eAgxLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xMwwPT9R; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-450d37d4699so1104915e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 May 2025 02:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748510157; x=1749114957; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ri4BKapRmsthsSzIIgwhod8a8EzAqSCrIVP+j9E6hD4=;
        b=xMwwPT9R9QelsDYEcjdDnBsV2+gZuw3WE8Tr/QSMsxSWrRBypvsABR0rhNXC8uCiXL
         rl6ziNmLSosXiiIl46kGUx4pLXtK+VPNLwBA96pt6q90JHZigZy8DwujbSO3vbJXLI6y
         JxA4LrQcNdcbmXZ/rGGAvk6uhwZvkUeiUyNexR7WhfDs5NBuni209c2IkMC/2GDGhDGW
         vJfVThmUIMnTuangLjNs/FqKY2rdAfbkQ154+op8LFQ6MbkDrzIGx9Rwfq5JHcKSLDFL
         Ng4zmoUxOMAxd+gdezPE3M1CpYNkwF240qscVpnrHjA/MlVOM6W6rYuCgRhrwWW58fgM
         KGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748510157; x=1749114957;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ri4BKapRmsthsSzIIgwhod8a8EzAqSCrIVP+j9E6hD4=;
        b=cv5FF39J+ceOMpNIwQLTJaMxGKiTEBOZ2yj8LSVo1FSdOdVA5NtrZJbWe5FFji9jzE
         6l+GMmkrU3sE8VoNOGW47vSjMRQKi1p02Be73p65RG8TJ+TkVaFB3vUxkx8H9vc33jI0
         BiGqa9DAHt8RH9AhXwiRPs9QrZfFF+DoiMdwWs1MYenvUkcX556mGXqZqy4Mxaa66X7A
         IJ++vOkkBA4Fg5xKhek2fKbfNgQINZpqPCdEZqwtTKbcmP81d1QDro/gdo4AWItOTsue
         pLJ8c3Kf19dKKZ7v4HaBps6Z+zrJyEJromtMRTvBuj/J1PlutuUmzXi/X176eH1swxmw
         FIWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGWX/LPDqrsA3eL/wHKzMczxTK6CKbGYd47hSPg+Y2Cd8XLNDoe4LvodWbrvrrUMIx7ae9NY5pAgvo308=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEb0tJvEgvY7YoWQLUbpzaDUABPPOCCzemsRCp0PRUXgdt8a9h
	K9ABuhyuNPeJ3XIrOdOhWrmw95KlPnpodhh8PsZrmihiCQAOOXHeuMv0QO4+t06DTiuY40iA5nU
	Xt3n3
X-Gm-Gg: ASbGnct4wm+cFtC1oENZJc2HGpimSZ03I84THv+ZfJ9ucC6osnIxEzqiutkBRWsoJFE
	w2nbhou5x3ZaGgsuViva8/5ThRSC0khAWk4aZo/jazALfqlfjAuQKsBEtnENJEFDOL1X62LB8RJ
	rLTlq/iDfXKYsxyotIclIuTAqmdiVRPaB5DuwXxSkFpCtQv2QtXoDvS23UFL4Ok6zaSYmXvsKv+
	sBeQK6jSTw7IDnSTXHF6lDK2LAMQRNZvt0mVZGE2oLlBsJh06U9C5nWpL+wsat4HCqr9Q8UJEz+
	qWzetsrwCskfLeP0AuXZ9ODJTnZJJMA8RgvzemwOoe4DgJVGqkXnDfYL39+DHqKoFWVRrMYw9EK
	Pogc7WqDM80HKncq4MAvaSX8l6FswfpSF6jTxGz+ysg==
X-Google-Smtp-Source: AGHT+IEJjdD4jVw4IBSE2F10tS3OahqEngmAPlCUh+JCF/Lrsh11gYsYhNMqeg1R7hRVjK3TitRUug==
X-Received: by 2002:a05:600c:34d2:b0:439:8c80:6af4 with SMTP id 5b1f17b1804b1-4507256216dmr43854925e9.19.1748510157028;
        Thu, 29 May 2025 02:15:57 -0700 (PDT)
Received: from [192.168.0.2] (host-80-116-51-117.retail.telecomitalia.it. [80.116.51.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450cfc348bdsm14318475e9.33.2025.05.29.02.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 02:15:56 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Subject: [PATCH 0/2] iio: adc: ad7606: enable Vdrive and Vrefin power
 supply voltages
Date: Thu, 29 May 2025 11:13:53 +0200
Message-Id: <20250529-wip-bl-ad7606-reference-voltages-v1-0-9b8f16ef0f20@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFElOGgC/x2NwQqDMBAFf0X23IW4NCn2V0oPMXnqgkRJigriv
 zd4HBhmTirIikLv5qSMTYsuqUL7aChMPo1gjZVJjFhjpeNdV+5n9vHljOOMARkpgLdl/vkRhcU
 Nz86Kia0Eqpm1Onrci8/3uv5EBNs2cgAAAA==
X-Change-ID: 20250529-wip-bl-ad7606-reference-voltages-26f49520d12c
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=595;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=dgQwzlZ78BgpNxIj5EI6KF5CPzlkbHaCeBBTWQKGv/M=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYsiwUA2RYpptFNLRc25xvkLwRQ/73+wm6cd8lmW8SJl+T
 m/DyZZtHaUsDGJcDLJiiix1iREmobdDpZQXMM6GmcPKBDKEgYtTACYSsJ6R4fiHFyfPcPnlaXr/
 8NmlUHH189aKdztb9HbMDT2TeaBSZTbD/0SN336yDou3TjBU6jFZVWISxsh2kLP3wZWFhtU7r/7
 VZQMA
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

Enable Vdrive and Vrefin power supply voltages. Related fdt properties
are already defined in ad7606 dt_schema.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
Angelo Dureghello (2):
      iio: adc: ad7606: enable Vdrive power supply
      iio: adc: ad7606: add enabling of optional Vrefin voltage

 drivers/iio/adc/ad7606.c | 9 +++++++++
 1 file changed, 9 insertions(+)
---
base-commit: aa1b3efb8425b572d67df2f5d47ee4ed25571428
change-id: 20250529-wip-bl-ad7606-reference-voltages-26f49520d12c

Best regards,
-- 
Angelo Dureghello <adureghello@baylibre.com>


