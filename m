Return-Path: <linux-kernel+bounces-806380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 946EDB495C8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD8D34C39CB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1913115AD;
	Mon,  8 Sep 2025 16:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="BUFHA77e"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D082310784
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 16:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349640; cv=none; b=J0A3sqMN+Hwu4+PI9htAWwE5NyAz+0reXHjQyo0KXcwjlGgQsN7IGqfLf1W6QnLLjQVkswiOEw5tTEdb3E15AtmVqxi4/6PFxHgnhAf5G34kmrDlj6aV6ymQ3yeY6kmy8FQdB4PUlIXXeR8vttXZFNHuzhH4EYh41NVmfLRTxuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349640; c=relaxed/simple;
	bh=+vkaI5ZT9MLlnriDLDmEJpD4xCCxTT2lOxENtw3F3ks=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hLbhkxDKkSuIJuFhKcqubO9vzvwBzDA2alWnjp2XGzE8KdOVMvL/arQwBqtZob5jabGRjk1mmYozohnOiAmajrEh3eREs+JQd6oezhbmVVq60byg831kunp50XHshrEQ2Q49FTpeFoFKFYb3D38l9qIwr2OUJWO1oUUF2PyVFys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=BUFHA77e; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-726549f8161so42866626d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 09:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1757349637; x=1757954437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7aH48sARri1tjmPkaUxfeb9p/pVFZ0oqSNGlJ0Jei0U=;
        b=BUFHA77eDhnv4MFUrkSvMDfP9hmvD66Pyt4+WSU6tLMe9vWga4oMqi3UkH1SpdbRxb
         0qwY6fmEhMm3KgTTjTRQDHWd/42TNKhJfT7+YDJZXzTSpLxAtUYdC13wzjjBPaQQqTJF
         9u88GnJx2HXbyltmRKLwpRg74sVo+LvC+YpDkqX2CFR9nQtl1m3TqcZkmmazHOOvzBi1
         uFEhrHHXF32L4viF6EWu7kOsm4KZNsyuK5w7loOB8hbFQcJCNZdq6Dk85BN1gmfzL4oW
         klI5CxDfwdGv/NmO+5Kk+4dNAXzNxSX1TW4zRfZJwKlxKSa5Tqx/b6Py6BQvuk3W/1Oi
         pwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757349637; x=1757954437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7aH48sARri1tjmPkaUxfeb9p/pVFZ0oqSNGlJ0Jei0U=;
        b=Et4gY1OtyeT+fUR9igS3YkfGJHQhLp4PwnvbGBT9w763NMVhms5xAnPKJsLOBl2ANT
         QxdgyfCR+Wk0VyiqubzV/nFGqy1NGUn2lXz1ZpgyYqycaUXO35N4SrXqoslyRzzmWlR/
         /OKox7YElbW9bhMvEqVEXmmqiOimuzvC7mxsf39PRApbPx9UQWhIdhIdTQq+lvxy/cjU
         mjvZmGGMs2CW3kx8cuAeKq+dQZE+vkRB3zomnFsKdCWbO8oUPMTyrs75xaOi/l+ams95
         K/1cJUDzjHZ9ZWTDFB+VD+Vf7Mhlg3qbo+Wyi1Nu0fTA8ytSwNskErDLnJ0lwbb64juO
         2RoA==
X-Forwarded-Encrypted: i=1; AJvYcCUEHcNPiPOFoiuQBP+ouRHEcvXA9Z8X5gJcsueuaQe5b8ab2eZdFti4F9FQ3KW/G0dHXZAQbWnSJoj16aI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOXY2oMa6XEN6/g11gArWF1DYoPdjlEeI0EvBG/+qEQSTaWd7n
	edjzvJIe993+nDSmmmgHrYYNOWMKcNxggHStGLJUDrbjc7RBHzSkC8R99l1sn12rVXo=
X-Gm-Gg: ASbGncvxOEKweotE1xDrYprGtLdyAURGnicjfmbNaBuO7DtyZh5S+AfwK/phh/m8d92
	LS4ALAKm4L7yfsObSoQMORsVbMk3J/wAev0Y/f3XVMowuBPz8ZWh9naFsk/1lN621g44GrW8Ywx
	4p7Asj8BwxY9F4F1jPaT8Gr0IwXAChcZwbpaIuTSsG3rV/M1+Y8/vApWd47/iNOY1j1TLABlW1n
	MqKpqNO6OIUTT3KOCDWyjBRrjlSm6T+fCFat2x26oW9EY6gAiUQn9KttZNntOeauMRf8URHnV5c
	/ezpu4lB9MJN/wfQgweeHoTsMBKd5c9p0OXghBre6NEU5UNnLydmravEAw9lgMFY5e3bkGcVa+y
	3WHafQTLSDVGx47kKnYNC2xfDcs2XYiu1lKjIBOgsDLlfEtC+
X-Google-Smtp-Source: AGHT+IHeCs3mzJUVBUfpFzvIyt6k/471lMNGsYJ3oUPFdyt4l+rbrBgDca6rTrRLdwfp8Xxp21VYmA==
X-Received: by 2002:ad4:5965:0:b0:72c:3873:2e43 with SMTP id 6a1803df08f44-739322fe85dmr113949406d6.25.1757349637220;
        Mon, 08 Sep 2025 09:40:37 -0700 (PDT)
Received: from ethanf.zetier.com ([65.222.209.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-72a2d06b9b5sm88751706d6.70.2025.09.08.09.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 09:40:36 -0700 (PDT)
From: Ethan Ferguson <ethan.ferguson@zetier.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com,
	yuezhang.mo@sony.com
Cc: cpgs@samsung.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: [PATCH v6 0/1] exfat: Add support for FS_IOC_{GET,SET}FSLABEL
Date: Mon,  8 Sep 2025 12:40:27 -0400
Message-Id: <20250908164028.31711-1-ethan.ferguson@zetier.com>
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

v6:
Moved creating new volume label dentry out of
exfat_get_volume_label_ptrs.
Use exfat_find_empty_entry to allocate new volume label dentry.
Better usage of hint_femp.
Use ALLOC_FAT_CHAIN in root directory.
Only allocate new volume label dentry when the label length > 0.
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

 fs/exfat/dir.c       | 162 +++++++++++++++++++++++++++++++++++++++++++
 fs/exfat/exfat_fs.h  |   7 ++
 fs/exfat/exfat_raw.h |   6 ++
 fs/exfat/file.c      |  80 +++++++++++++++++++++
 fs/exfat/namei.c     |   2 +-
 5 files changed, 256 insertions(+), 1 deletion(-)

-- 
2.34.1


