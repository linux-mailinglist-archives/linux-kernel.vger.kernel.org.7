Return-Path: <linux-kernel+bounces-887836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D597BC39313
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 06:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DBF83B6FFA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 05:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B162D8773;
	Thu,  6 Nov 2025 05:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lo6Yx/mK"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A4D2D5410
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 05:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762408467; cv=none; b=I9SgZ8Se6hjUvizmwhxkwwEkHAQrXtPva5mJO3+MWHVpqd6BgrJodSXIMx529sqRWp3J956yCz9tyMnVV1cgv7xRncNgP7izBD9ayo4xTmnvQ7prVS10Sp4rTspC6PSH4W47OldP7GkfQK6jO9HPtqFPjm5Uy301CSuOs3Dh9aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762408467; c=relaxed/simple;
	bh=dSWBBBWYKlfD6DTf/xJCvME7WLo0qUOU7g3Zr51S4jY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iMh+MhWQmBfF4Be+hZ2qQv9i1aCSGunp9zY1cyHilC6bTCAHUrdg+ZuMIHeOhw5nZHOKCXRnfXvqxXzUqvuAyhDzQzT4ObichqSJjyJglvNW2ao1YCDCAYNOXRB4zGlAIDbahSrk+Qf0VGMNJ+a+KhHLtOjpp42BFPnDA6FOqJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lo6Yx/mK; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2952048eb88so7909945ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 21:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762408465; x=1763013265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CeNNU3zakAOXs/yWODz5gzeTeAq5p633IpP2qw5Jk7I=;
        b=Lo6Yx/mKE4u8puQtm9CMpLCpUA7sdKDE7aGj4iEwAlXdj6IMZvVUWkN7g4HZpraO5i
         EKrvq+gavZmXF8u4ccBdQLIQBUTtzthqFJfqaGkStzsVDeobroZdxgSAMplJLU08bQ+S
         ovdaqGIUkFn7kCO7OpYdXg1RyJV+IU+KJAZqtaYxFyarKZbZAmnXtQUG5KpAjalvSRkH
         G51Nn5IL8dXBT495Mf25NRasRfZVVp5nLLB4xbnU9LCOadHUP0dMnvd5ulGPyf+T1cJs
         0ByPxPqnS2AMr5T3lguFDWNTcAleHWod6QPOtknhWTUDqkCFX6mgaip7baLkP9jVvm63
         l+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762408465; x=1763013265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CeNNU3zakAOXs/yWODz5gzeTeAq5p633IpP2qw5Jk7I=;
        b=qVpQffCsXKbrvA/AhQkgfjxtezq35aNsYG3VmVfHGVXLbeP9S+xaxrM2nHCAXFqMoz
         itLAqInwnlkZNgzedg2gSf3AaCLeveA+4cd+GPz6jPMOWBYCX7mvcAI+g9qLmN+TYO0H
         33m0Yi+xN/o3rfUMO49Cm8daxfF4VmZ92WD7pQujnyJg+wuVlQsQgmhJtJU/cJj9ws/G
         3YMam+Cg1/HLpkmICotau3jlXMijJuf3iMqS3HBSMUEM0T+fnl6L9WHdPGMh5CS9FOM3
         hfQw4RUZlzjxdP9+QYtbFJ1udAXLluFUX1G44PjRFC/T7RferSb3CoqLgrd28HUxjW3f
         88GA==
X-Forwarded-Encrypted: i=1; AJvYcCWt5f7Jo+vsopIaZVV/TsKMpBLm+MpFYD7cDWCXS/bHoYcHysvW8pu83zx2s9rwt7jh6+inHNlYWthcgkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTR36Pfh3P0UuGvVTDvYRR+yaWjW3oIb6LsBBQeF8c0BYqDGo0
	Jujs8EAvhNPxU2y8B2itQ5mEgW8xMitn5Zyq+4KVJJhT1l8kP6/o+T+R
X-Gm-Gg: ASbGncvM1zrPqzARVXZMdxCNfdTUZSUzI9dd1gJMDZLatR/XvRYXjySOH4xElRWt0nJ
	WE5l5FkeXrYQPkhdt+HQYc6DFxCRwKm8OX3nEiHFA69hQoUqQlG2k71PqU2exLBdoyT3hdv7MNl
	2/9SfZta9mT3JhlRFebD+OoERj9fVG6nPyef4DhHSLu4R10LVQwzDNTg5+6Nb5Q/z11J64kROJk
	qxV1wkRyMvuyp2n/H+32g9aBe/PorzGl9IkA6HYXnSC6T2lCgLJ7q41dBBtZnbYP9HPZv3CLxDv
	iFevZiZdzfR3g/ZogCIY3aU0vsb7HlhinW3wyMbqAzROpUmSOVxLZqqnU+8JN8RCToPKYl8Qudo
	HnBWoesYHeEaDrQDPzCkoEdz9lDligxbICY821WZXji8a4wLuNIcTXmMcpihY8L5Znc7px/LCI1
	Vrgd0r5zP7W6M0MAISNcQtuGM=
X-Google-Smtp-Source: AGHT+IH+TDqjcsT4LgnsJNDYdaPUbOW4zaulnASJiwtAFqEUZlSphmRmwHYwXI4vF3z+DMqsOeG7SQ==
X-Received: by 2002:a17:902:f550:b0:295:9db1:ff3b with SMTP id d9443c01a7336-2962ad0c562mr89323605ad.6.1762408464968;
        Wed, 05 Nov 2025 21:54:24 -0800 (PST)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651cc6595sm14513195ad.98.2025.11.05.21.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 21:54:24 -0800 (PST)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id 071F7802F6;
	Thu,  6 Nov 2025 13:57:21 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: richard@nod.at,
	chengzhihao1@huawei.com,
	miquel.raynal@bootlin.com,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH 1/1] mtd: ubi: skip programming unused bits in ubi headers
Date: Thu,  6 Nov 2025 13:49:40 +0800
Message-Id: <20251106054940.2728641-2-linchengming884@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251106054940.2728641-1-linchengming884@gmail.com>
References: <20251106054940.2728641-1-linchengming884@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

This patch prevents unnecessary programming of bits in ec_hdr and
vid_hdr that are not used or read during normal UBI operation. These
unused bits are typcially already set to 1 in erased flash and do not
need to be explicitly programmed to 0 if they are not used.

Programming such unused areas offers no functional benefit and may
result in unnecessary flash wear, reducing the overall lifetime of the
device. By skipping these writes, we preserve the flash state as much as
possible and minimize wear caused by redundant operations.

This change ensures that only necessary fields are written when preparing
UBI headers, improving flash efficiency without affecting functionality.

Additionally, the Kioxia TC58NVG1S3HTA00 datasheet (page 63) also notes
that continuous program/erase cycling with a high percentage of '0' bits
in the data pattern can accelerate block endurance degradation.
This further supports avoiding large 0x00 patterns.

Link: https://europe.kioxia.com/content/dam/kioxia/newidr/productinfo/datasheet/201910/DST_TC58NVG1S3HTA00-TDE_EN_31442.pdf

Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
---
 drivers/mtd/ubi/io.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mtd/ubi/io.c b/drivers/mtd/ubi/io.c
index a4999bce4..c21242a14 100644
--- a/drivers/mtd/ubi/io.c
+++ b/drivers/mtd/ubi/io.c
@@ -868,6 +868,8 @@ int ubi_io_write_ec_hdr(struct ubi_device *ubi, int pnum,
 		return -EROFS;
 	}
 
+	memset((char *)ec_hdr + UBI_EC_HDR_SIZE, 0xFF, ubi->ec_hdr_alsize - UBI_EC_HDR_SIZE);
+
 	err = ubi_io_write(ubi, ec_hdr, pnum, 0, ubi->ec_hdr_alsize);
 	return err;
 }
@@ -1150,6 +1152,11 @@ int ubi_io_write_vid_hdr(struct ubi_device *ubi, int pnum,
 		return -EROFS;
 	}
 
+	if (ubi->vid_hdr_shift)
+		memset((char *)p, 0xFF, ubi->vid_hdr_alsize - UBI_VID_HDR_SIZE);
+	else
+		memset((char *)p + UBI_VID_HDR_SIZE, 0xFF, ubi->vid_hdr_alsize - UBI_VID_HDR_SIZE);
+
 	err = ubi_io_write(ubi, p, pnum, ubi->vid_hdr_aloffset,
 			   ubi->vid_hdr_alsize);
 	return err;
-- 
2.25.1


