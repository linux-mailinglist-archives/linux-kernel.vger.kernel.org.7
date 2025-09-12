Return-Path: <linux-kernel+bounces-813114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B37B540DC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 05:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98BCB17B735
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 03:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B14239E9A;
	Fri, 12 Sep 2025 03:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="Lyy/LcKE"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB942264C8
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757647599; cv=none; b=DJITNQzsEp+ZPiMlvWc+aya0QGnodwb22dWlvy8ucPGlzhymSKQ5+apLiTxZWfX7XCzs86Itgw7rkPQh1fOx4ciwh5rH45Odxnd2lxwI0GCT9aeN5KmFBJMwy4DuYxT9NFSkMY3J6Z75I5/JrYvQwTLPEc5tG+CoNdKc9XdTExk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757647599; c=relaxed/simple;
	bh=WoQ6z9quahn2OSBOqtcKWk0eGkNESupJ3iBVqZTm0xw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GNFwy0skqE7JVcEgT7uLE1QdFzLRLhSxIaimXhU6oJHVPpTPORQXp/ulEWqUpQ5hjCplIaK9yZ4Zv6DFqEUkPrau6tJ6X5FOy2ZoZxECFyrH6XpMh58mNUjca/9IVdghFBMnM/+dq6zGWkURF0CjePMiYBu+h25wF4howArNBtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=Lyy/LcKE; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-7221ce7e814so11661216d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 20:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1757647595; x=1758252395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4kVzdyrDOCzYvNzB91+jleTLDE1xgg7hanprf2gGI3s=;
        b=Lyy/LcKENnDeiL+1JtZK5/nO6/ryCORiHYtzRZLBWJrYk9CpUuznjejHmafl3dbjXI
         X1pTFpI0kogURAWzFgYjVudBb8fLNDJGZpiPrVBGV+uahAHSXuo6i2IOHEigQixJI5TE
         ErVv0aho5S2Pxl9NaTdp1uoFBRfg806msaZseXXdbkMMJ4xHVYMOFsdAN/CfW04MyU+9
         ShEvaGWm165f0wfvuMNPX+vWATrGcbQFDmPE40M7tVEg7TuuiajVrAjOqoOcq4Em7bp0
         ic/0Ok+97vrIxptU6OAjR6FAgSoHJWA8vVNHrCyoh0AaZqiexrNU8U2lHiTkjB0pUVNk
         5aJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757647595; x=1758252395;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4kVzdyrDOCzYvNzB91+jleTLDE1xgg7hanprf2gGI3s=;
        b=Ove6V0TAJuxMEnPGQ1LbW627x3Rg5XQKgnngvoszWftOo9VsAxnuUJYU9TpnMWOfBy
         OdLDwjP0V6Y2RqB+bmFePxzZrgpDoegFYemxBmWEMIN+h27bFIX4j86KYdMteQ/Z7Hfg
         DcZfJs7GJXL8EbUcXx1LYDhuSRYq6PYh/E3FaCVe6YSroG1Nh5HOK45xKNu3S/FuIHsC
         5ycp+XrMu4ghI7CrIyDuuO5EvJTXoabxkMsoeU0ruYlC23Y5tIeL61nkz06kaVsIke18
         X4UQajL0pDM5DuVbCrSszpr3qDYxk5/D7lDQnh59lTtx+4Q8uK0sLCL46fs0+UAZz1w9
         GGhA==
X-Forwarded-Encrypted: i=1; AJvYcCU7otSr1LfXBP9b0Ori4H23oBGzb3uykFwg1SX8nhlXsMEGqVWg+oNgIWfW+WL+R2/N2XcoC8CybHnj53A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGknnAOEzVWORZnxPClBs+VQ4IQ2zs8ZYUEa7SuAu00ymLdaT5
	QD7KTss71wpW8JCZdHaNLVH3NsIzksQokCwzyLb10hK517U/oiD0HYvoxujVgXUKV38=
X-Gm-Gg: ASbGncvMm11sB4sbpRWheFlZIbdiiN3kkDWZktCoJ382EoBK4Pg1TzZqSX2WyIwsSb0
	oXY8VFYaYgAYyM43EIFDOxzhy+S+aZCqY/JtNhKN2jbtwRRtzp4BnH7eAs0jaEs+CTQPKQrtBB5
	AHcHcecTf+M0FTORYFs2h2PDjSZgw9eXD++AvYswQYy30kKp4LSnywBgUqHGnSJkiaUYLyfMCRZ
	Q7eaXGKb6ZAtnI1tV8QG0D+ojE6E8h1cxccr4v4v+DFidb9/cdk2ANdkPCTNhZaG8Vt9ViH5qL3
	U+kCvw2/u8j5WlbXzMaM1c2dpSvwXMqLDC8mBq43by7sap/zALq4UwU0KuaADRROw5RgoUyvd5r
	HUKKkZHLQfLCdbG4pjIuqPgE7K8HH/5L8ed04SBTm0pQbBu0l
X-Google-Smtp-Source: AGHT+IHwOPvghqdNM8F4zeNwWMV1Im3cKI9MoG9jNGONp6ffStJObi0wHmwwCeO/lc6VKRzZIUTtjA==
X-Received: by 2002:a05:6214:301a:b0:71b:9c1f:cf12 with SMTP id 6a1803df08f44-767c59f7793mr18114526d6.58.1757647594897;
        Thu, 11 Sep 2025 20:26:34 -0700 (PDT)
Received: from ethanf.zetier.com ([65.222.209.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-763c19e7faesm20195776d6.72.2025.09.11.20.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 20:26:34 -0700 (PDT)
From: Ethan Ferguson <ethan.ferguson@zetier.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com,
	yuezhang.mo@sony.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cpgs@samsung.com,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: [PATCH v7 0/1] exfat: Add support for FS_IOC_{GET,SET}FSLABEL
Date: Thu, 11 Sep 2025 23:26:18 -0400
Message-Id: <20250912032619.9846-1-ethan.ferguson@zetier.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for reading / writing to the exfat volume label from the
FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL ioctls.

Implemented in similar ways to other fs drivers, namely btrfs and ext4,
where the ioctls are performed on file inodes.

v7:
Accepted changes from Yuezhang Mo <Yuezhang.Mo@sony.com>
* More accurate hint femp setting
* Logic simplification
* Reduced buffer_head usage
v6:
Moved creating new volume label dentry out of
exfat_get_volume_label_ptrs.
Use exfat_find_empty_entry to allocate new volume label dentry.
Better usage of hint_femp.
Use ALLOC_FAT_CHAIN in root directory.
Only allocate new volume label dentry when the label length > 0.
Link: https://lore.kernel.org/all/20250908164028.31711-1-ethan.ferguson@zetier.com/
v5:
Change behavior to only allocate new cluster when no useable dentries
exist.
Leverage exfat_find_empty_entry to handle this behavior, and to set
inode size.
Update inode hint_femp to speed up later search efforts.
Link: https://lore.kernel.org/all/20250903183322.191136-1-ethan.ferguson@zetier.com/
v4:
Implement allocating a new cluster when the current dentry cluster would
be full as a result of inserting a volume label dentry.
Link: https://lore.kernel.org/all/20250822202010.232922-1-ethan.ferguson@zetier.com/
v3:
Add lazy-loading of volume label into superblock.
Use better UTF-16 conversions to detect invalid characters.
If no volume label entry exists, overwrite a deleted dentry,
or create a new dentry if the cluster has space.
Link: https://lore.kernel.org/all/20250821150926.1025302-1-ethan.ferguson@zetier.com/
v2:
Fix endianness conversion as reported by kernel test robot
Link: https://lore.kernel.org/all/20250817003046.313497-1-ethan.ferguson@zetier.com/
v1:
Link: https://lore.kernel.org/all/20250815171056.103751-1-ethan.ferguson@zetier.com/

Ethan Ferguson (1):
  exfat: Add support for FS_IOC_{GET,SET}FSLABEL

 fs/exfat/dir.c       | 158 +++++++++++++++++++++++++++++++++++++++++++
 fs/exfat/exfat_fs.h  |   7 ++
 fs/exfat/exfat_raw.h |   6 ++
 fs/exfat/file.c      |  52 ++++++++++++++
 fs/exfat/namei.c     |   2 +-
 5 files changed, 224 insertions(+), 1 deletion(-)

-- 
2.34.1


