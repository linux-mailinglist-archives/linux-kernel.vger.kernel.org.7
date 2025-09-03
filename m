Return-Path: <linux-kernel+bounces-799233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB98B428B8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 20:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C5ED1BA251E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 18:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87E72C21F6;
	Wed,  3 Sep 2025 18:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="RNG3T+bw"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FF02D47E4
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 18:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756924413; cv=none; b=fZMck4OIh/FUOVBAf/5/Rb/uEjoA29C+PYXaJGPg3kc+fAVnJ1CRNAxXpDcLeov3OUtxCPOUm5YZO8IWIDUyHVC3KmKvzfneccbeNuEA2ie2d+QCj5Oym97roQXPOl6w6MuBqoeLAJyCpO72nGuKU+KdBlBOeeJzMIy7n0gfIIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756924413; c=relaxed/simple;
	bh=0qgglxasLkzPr6XRpOEKv7fQ2J/IzxLLXQTec8udKmU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qldP3Pq8rJPF7YR9dvAWba6XBTtXeQWw6wgyV+3nxABjN5RrituvGM8M9tx8gwtJpdAy7URHFjaxf9sxFdL/0j8KCoou4hr9Rw4QI9PXYMGlsS3ObdiYrj08Hf6mwa/SZEIPizjS92ZKgV6ixnrxXaCl5EzFzYq2IxC5EORY13w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=RNG3T+bw; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-7211b09f649so1027686d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 11:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1756924410; x=1757529210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S879IOAS7I2KrrMY7ilhyLTemY3z54jAwRhHsZnwFTo=;
        b=RNG3T+bwgjM6CDFIZsb93nDEtjxJmAeY6MhmKlu9mgsgW3g/qGOEQ04FPZ+SYV7/9C
         HZFZITicOu9KRSNVpEoNGj59GMOVpxwYItKnD9V1UYVbT2sxL2XfzHOLGMxq4v+8njlA
         NAEDIxaLbqFjbHg914/euxGuS+OYOZ3HEKYI4M8vAtZ1h+48oSO46V5L6Mee2VVx5MVM
         WVJmYtrxR0n9KhC1cLlvT05Em/BNYBylcmPRbPaBBIYZzPa3XkaebvkU43z/EYCOLRWc
         Aw+gtQ4njMljl5Wp9PDLOYnnBnz8TL+UxpAMantc401e7iJxQXQAhQKbFaAUNdWs6hvM
         LJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756924410; x=1757529210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S879IOAS7I2KrrMY7ilhyLTemY3z54jAwRhHsZnwFTo=;
        b=d745mthBS1ktj6OrXu/TlpGLW0tkO/hAbNd6cE1zx2/k9AGqgUu7s71+dXXCJ0pgaW
         P5do/Gd/k5tzrl1wm9l2pOBVoz4gp1Tm6HqgC6sZYbTF006TzgVDXBgls1Cr8UwcEpSD
         k4zESW0NU410uhF2cnY4v/sCx/xR6UdAyuPE0kc6xAExT5yt/JQkzlCGbY/gwSExTM80
         IJAr/vxsvSmULt44uXIKMpgZc7PUmPFDflHM0Rd0DRDyj5E6YEO/DrOQRAh9WiH0uOwZ
         4JBmQ9ysjVza8bhGavO4QooGn+lIoxr/5QQnzw65U9c4PODVRnxjTU9HFQVGf8/tBEXm
         VHOw==
X-Forwarded-Encrypted: i=1; AJvYcCUwYhosylmuKcbDiABVlbfAO5ecSaHz3J9GnBLLZeQcTkVZrTtLvHsQY3f1euds2r3hD2qXtsY/aE+VBWk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw53+Bqfn3VVd0wn4sBBTxidS7A7tJEjyeq86/tA+CdqsOzq7JK
	2U7EC5V+av+hmQf+XIAVTUiQi9wyXXroKP4evXnppZBJjBMZEnt/nVwGzQhZK6yhc7E=
X-Gm-Gg: ASbGnctPeaeQ+J8qFe0hzYqqazWDb6dj+MrIhwkGLCKJLpxkv9eUbLnfpWCoN4zE+cq
	0Uz/OjU43EiZzYc2JZhki+fKZNRA4ES7WwomBqqFQ7odbl/PTJmU+aTgyc2biQAcLOouLRysPMu
	g8KDSeqInpzvXlOXRKR+S+n1QzTNL6yBCzNBns8qigtFDixqQrIT7Xc6IH3nBntVQxXrh+Z0igr
	7GZjraKZ0g4DQErE6agCgWfB63EU7OimrZrrF0uKnVSK6ze3fDx4G+ka/SANeB+mKNkgUP4nCxo
	PHZbQg9kOxmn2x+AbZFeqk6oK5bKEcaTabl7LYLm1OTbmZxn0ryTF0hHaauXL6NZKkRlu88Poy1
	tHvM3Ls+yC5e14zp1UH8HMktahZKOU6q/PLvsuw==
X-Google-Smtp-Source: AGHT+IHf52BqKSn+x2MgFKInih4yT+Gwmue5zsea2Bfw0PtVlqwJUW1IjdXrNUhs6WCY1OjVT8eXUg==
X-Received: by 2002:a05:6214:2e85:b0:722:25e8:b488 with SMTP id 6a1803df08f44-72225e8c257mr45633516d6.27.1756924409618;
        Wed, 03 Sep 2025 11:33:29 -0700 (PDT)
Received: from ethanf.zetier.com ([65.222.209.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-72160017b64sm28699916d6.55.2025.09.03.11.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 11:33:28 -0700 (PDT)
From: Ethan Ferguson <ethan.ferguson@zetier.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com,
	yuezhang.mo@sony.com
Cc: cpgs@samsung.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: [PATCH v5 0/1] exfat: Add support for FS_IOC_{GET,SET}FSLABEL
Date: Wed,  3 Sep 2025 14:33:21 -0400
Message-Id: <20250903183322.191136-1-ethan.ferguson@zetier.com>
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

v5:
Change behavior to only allocate new cluster when no useable dentries
exist.
Leverage exfat_find_empty_entry to handle this behavior, and to set
inode size.
Update inode hint_femp to speed up later search efforts.
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

 fs/exfat/exfat_fs.h  |   7 ++
 fs/exfat/exfat_raw.h |   6 ++
 fs/exfat/file.c      |  80 +++++++++++++++++++++
 fs/exfat/namei.c     |   2 +-
 fs/exfat/super.c     | 165 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 259 insertions(+), 1 deletion(-)

-- 
2.34.1


