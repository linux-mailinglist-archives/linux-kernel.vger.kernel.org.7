Return-Path: <linux-kernel+bounces-844205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CE538BC14C4
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 14:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8DE2E4F51AB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 12:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429752D46C0;
	Tue,  7 Oct 2025 12:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWkV1kks"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2162747B
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 12:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759838566; cv=none; b=s+b5ZcWZW7bUKFwvaIDJtW7f07kKx2WWjlErktjRvWey3vJBoubhRHMXyyf3I5E7IKTPpllYIlWuEufrCuRSaGsD0xa4sX5l9HnPOe7dP2lkYHMDMiJdFhap3z86bjH4vZa2nQj3UcGtrJOsiWDn/UnHWvffTwtE2da8iaH8+ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759838566; c=relaxed/simple;
	bh=Uwp3nwYdT5m3y+GC1rhzb2llx5N1PSDN35+YggAT3wU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=be+AVoraIsjS1drdivfPgV+o/OasNnqK/vGDKptXsmG9QGLToNU+zibxBp8fYKf8e5du+SWphTlS5CWIoHjGVYOo4zbPhipV3tLs3qMsMIaaiT+FjR5+E+lOhW6WrjTjiERhcIpETHVKKmTFvnXuPnUZXkQC3ABON+ukXec0YMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWkV1kks; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-77f1f29a551so7823579b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 05:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759838564; x=1760443364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JgNr+tNHQ+i3V3EeAoz19ucV8GtWzNyxdtEJ6ZWd2ac=;
        b=jWkV1kksfGeHm99Z9icR7b9wxeAxETa2pYlIBFW1g4GgGu/uGHikJKBHhLTUdZHkuy
         0qI/DBQ5I/emuAw05ft0OrE9FG60tCPFyaQtSXW+rWgxETRw9p6TmLJZ+jmIrtjyERJG
         UM0F6hio/uLNm7+5PljO8aKBdhcIsGm9FgULUfi2P+8G+x4x5S35kXqou1nT7nYmQQtc
         IDNROkmIfOz4BKrgWYXx18e4NhKOtouTPycwXf819pK1h64e+t/rUnVbjcj0vDgyzJuA
         CzY0+Q6H3NseKvwaP1KOGNKi6c99CYTgBoXMTgjYSf3rmkmn/4TV594FfN1QqzTMNTCB
         7CEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759838564; x=1760443364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JgNr+tNHQ+i3V3EeAoz19ucV8GtWzNyxdtEJ6ZWd2ac=;
        b=UUY1B+nKwyFGVIehTm1RAH6iPheHjBfEULG2ar03QnRh3IdiBWLWNuYucWBXezC5G3
         nsdv4GWSn2sYAGW1e71PEbFeHeNSl7S9YLrk0K+16pNu6Wnb19q7at+itcv8FIBVvmph
         bzjrcv2Pl9622fktQFXo/Ld+6EhW+870eFtXK7bEmkDe7jcD0cZvDS9PfuTzr7gVnu8N
         qtyIdRtPfs2Y3YsNUAWno0oCfja6NgJNdy92fai19LLtyyl8Rfj0rjLC8frvo8GuNIDl
         CC3mpX1Ex79C91cLPhBV1S2qvtUXWUzqQRameuH7XqOWt8UbHdr08eHIecXKNmEL0oVS
         /ogA==
X-Forwarded-Encrypted: i=1; AJvYcCUYpz4WxQfc/Rza1Q2Z+/dMFpYzhVu3TVq1mnYiWJ1vrzrUAXi8oP1knnoclzBA7p/CxWt79yxismvg14I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN9thK5yV0sxU4DWDkxlXfKLAbE8se0Nn81IzfqWHbKWMnhgwL
	dNXUNSGSPUh9yFM+p66nLEz4FUmxy8cQStPOABz6RENSQbMO4R8eFLWC
X-Gm-Gg: ASbGncvVqNncpIqv0s99yGb9jdtDnAtGB6b87BYQHtP+Og8JpxW3mcO24bSBoK5v0qT
	LQVS8262MJ5C1l/ZdrhjmCvU/GaZF/UWBAJftNpD2BUMvv7v5vOwxDP8wreQByISngBDnrCGHpD
	F6e2Zyqt3D1sl0bvrQYlN0FeDSKMplDgwuuZ3zE6XefOVg2pUQhE/uDyTUg6l2BXz7BZIpl3VFC
	d23jHN+aPPjnXi25uoKBBix9PAu/MA1n5KEYEXHpgHLDnc0qqJVxmg63qPq1eJ7M6rx9oHZUwzh
	R+pMvbvq8pSPSw2fHfQGv4vLqfT2mCU9dDCaHExPUZWPLAkBSOqdC4tR0ZUq0Lp3FvkBMNNEebF
	6OQiQ3D5v+1n/wHET4q7ZZNyIsfY60Et/dM1ZQIcEm32y/GbYCirQnXdsU2PcDiUxO2ET4JmpSN
	8q0zcMogAt+g==
X-Google-Smtp-Source: AGHT+IEH0lwuWZr6GCDo27FSqSdbMpk6OfccoJ01s3tCPMDu0jm17zp/Dvn0v63vGajLxGA+vGAGDw==
X-Received: by 2002:a17:902:f792:b0:28d:1939:f9c8 with SMTP id d9443c01a7336-28e9a5bf4c4mr200401165ad.26.1759838563859;
        Tue, 07 Oct 2025 05:02:43 -0700 (PDT)
Received: from weg-ThinkPad-P16v-Gen-2.. ([2804:30c:166c:ce00:71cf:b339:3993:4f8a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a701c061sm19510269a91.22.2025.10.07.05.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 05:02:43 -0700 (PDT)
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: "Geoffrey D . Bennett" <g@b4.vu>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Subject: [PATCH] ALSA: usb: fpc: replace kmalloc_array followed by copy_from_user with memdup_array_user
Date: Tue,  7 Oct 2025 09:00:57 -0300
Message-ID: <20251007120057.21918-1-pedrodemargomes@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace kmalloc_array() followed by copy_from_user() with
memdup_array_user() to improve and simplify fcp_ioctl_set_meter_map().

No functional changes intended.

Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
---
 sound/usb/fcp.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/usb/fcp.c b/sound/usb/fcp.c
index 5ee8d8b66058..11e9a96b46ff 100644
--- a/sound/usb/fcp.c
+++ b/sound/usb/fcp.c
@@ -641,12 +641,9 @@ static int fcp_ioctl_set_meter_map(struct usb_mixer_interface *mixer,
 		return -EINVAL;
 
 	/* Allocate and copy the map data */
-	tmp_map = kmalloc_array(map.map_size, sizeof(s16), GFP_KERNEL);
-	if (!tmp_map)
-		return -ENOMEM;
-
-	if (copy_from_user(tmp_map, arg->map, map.map_size * sizeof(s16)))
-		return -EFAULT;
+	tmp_map = memdup_array_user(arg->map, map.map_size, sizeof(s16));
+	if (IS_ERR(tmp_map))
+		return PTR_ERR(tmp_map);
 
 	err = validate_meter_map(tmp_map, map.map_size, map.meter_slots);
 	if (err < 0)
-- 
2.43.0


