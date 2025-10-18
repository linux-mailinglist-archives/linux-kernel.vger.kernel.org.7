Return-Path: <linux-kernel+bounces-859291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDF1BED3BD
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 18:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70ECF5E2803
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 16:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5B42206A7;
	Sat, 18 Oct 2025 16:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KD8vw0jA"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F64F40855
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 16:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760804176; cv=none; b=S/lKY3SDzE8knsFK1+yCe4aaXsmyU/w7FK0b1d9LL+W8OM5lbPUbYRcTYBRybJMmUs3zaFVJ8T1+gJuaJ21yisIFqJrujRInSlRfWr2w6RlFyA7rQrgO9sIWf+cGyUaIOZiRR6DPo88JxdrEExhp+sjkhdCKZCMYD3IDrLDs1l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760804176; c=relaxed/simple;
	bh=+3gAvnzI+cuGaiZxUWSd19HgWxd+NZJ02iVRQAzsYdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sn6zZcVVcBhyc2SE3SRRAJh2YKcNzuPc+wgLAvUbPIc/JGBx+coW/ul2ze97aiLjHSk/b5bu2tM3R9mWiKQfyZW+liG5vwqJmLsxDkAExverXRLTR0suB0pWLtpYSUzU0Luq/WXSnv+pZdsUuL+7Q1wCj4FOfO8j/pXplijJcXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KD8vw0jA; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-78af743c232so2544769b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 09:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760804175; x=1761408975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wSdDV+77YGHONmky4lHEZ+t4EXPNjUiuSFX0q2ZUFEE=;
        b=KD8vw0jA6LbOB0yYtLSAvEiEIg4SQQzOyaW5A7vGAKpGHSxxbjdQj8Ztp/uhCZQ6Rz
         Nr+ZHDgawr0rhfZlVec3HR5KvSZH7/uqsqP4JfDrcMWgZfCwVCTOknQ+AETd7TKoV70K
         LEyLPAS/76izq4Rsy2C4PNmzOdHpNKBtNGgwF9xQWaCuTqiROU2HJLSkyrupwcUvGgPy
         HxAGsvnhSELo1q3b9UhOi2NQJQ+GA0j3bjvLN9074oLQuGZeNLUAD9M/5PmAblO5iJ9J
         Gus7WNeAt+BbSm3S8DHD0L8/WjscXgnL+CpCNqCAK/6abIpjMWRuj8ZxoC4HhKGrbX1Q
         oVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760804175; x=1761408975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wSdDV+77YGHONmky4lHEZ+t4EXPNjUiuSFX0q2ZUFEE=;
        b=qkTTp9shvVV4GHcrhndVhGUoyVBWMelbJ/t4GxqcDVynyKgF3bIwPfpfZMcpWiX3gn
         lDIqsjv6s+DEGeoxJ+Abks1eE41FaoPyVIvxPM+fFITeiwQMTaMULokeJ9O+tEO0uIUd
         7KgJrslfjvJx0/uN4BgICg5ILixnzhO0x83M2Xu50+9n66HL27FSKHKGtUqlohmYdFY0
         4TKBvqC0a3orvVOHFIZEHSIX+MKvDxnys9n0vovCGVat/e+exchb5GDEvEFBbRdxtF9b
         L5OWaOdmVcLjdSuEPbIUzU7wcaIgSKR9SNOQDj2j6qeuVS0nSIwrK8G5h+UaF1qYEhiP
         Yqrw==
X-Forwarded-Encrypted: i=1; AJvYcCUr65Ma0FYEMgnmw+iAhbO//motkof8lYCJFdZ78w+RguCx5EdurNkeNVdLn85kgR440OTJxpEXnsF89aA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtFPajswCj8h7uk2g7Jr2CkVYW9k3H1OPBiYrLDNVIWxR+R2H1
	Q+yCniSyIu02di66MmTmd0ZxwEv3EJNtClwVHwI4ZcSK6e+yVZOGgnb4cy8cvtPq
X-Gm-Gg: ASbGnctcuDgGJJs/JA/4Uf9C/xmjqaMJI7IvouZxuGcD7u0wnXazFzN+dz6B3lFcvMI
	y368JWevt7YhLUdwN7KP8dU59ouvN97nrPoa61IabahAufe581bCsE7ycuBMwP+zD+MjbXzC2h1
	lN0gPH/GHVA3ej2NwNRgKW4GXyPEQPboH8n2Y4IstIT8+AC0jGNC0c2Cm8XvH6l4mEb53ws6pLE
	pwj5m0rkXvnX05Zq3R0Ugt+3aVMBd5bd+42MF7Z2SWKK1/L5FHFP92BPuwtmfvk711EFwfboYZm
	KBSatTgDNTOf01CuWQ4HG2ziD0VxBZxIyW0/RPwCT5m6Y0jZ8j9VOSsjlKg5tHIR4MfZQe+0psz
	o7xjSz4FmvDi2gesoiBsaqFCYXmLSOOkobqSz/g4Jh6a9jxnuvFGcr62GS6C2VNKxm9e12mWI2q
	A/QxMErfWEd8MmylPh2cyptKDacaAKnJRMu5PVHpYuzc17gmpeoL9JkAjzA+Jb0ByFEZA=
X-Google-Smtp-Source: AGHT+IHYI+FFaaDvVpaxlIAX/sl/GzLTAOyuwL7XHMuLFvxKBqk1F72Br/+q3CnnYmwEGgo8GUd0nw==
X-Received: by 2002:a17:902:e88e:b0:24b:25f:5f81 with SMTP id d9443c01a7336-290c9ca72bcmr105157945ad.17.1760804174643;
        Sat, 18 Oct 2025 09:16:14 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:f9a4:de93:6765:f5dd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d598asm30006445ad.63.2025.10.18.09.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 09:16:13 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com
Subject: [PATCH] ext4: fix inline data overflow when xattr value is empty
Date: Sat, 18 Oct 2025 21:46:06 +0530
Message-ID: <20251018161606.412713-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a file has inline data with an xattr entry but e_value_size is 0,
ext4_prepare_inline_data() incorrectly uses the theoretical maximum
inline size (128 bytes) instead of the actual current capacity (60 bytes
from i_block only). This causes it to accept writes that exceed the
actual capacity, leading to a kernel crash in ext4_write_inline_data_end()
when the BUG_ON(pos + len > EXT4_I(inode)->i_inline_size) is triggered.

This scenario occurs when:
1. A file is created with inline data
2. The file is truncated, leaving an xattr entry with e_value_size=0
3. A write is attempted that exceeds i_block capacity (>60 bytes)

The bug occurs because ext4_prepare_inline_data() calls
ext4_get_max_inline_size() which returns the theoretical maximum (128)
even when the xattr value space is not allocated. This leads to:
- ext4_prepare_inline_data() thinks the write will fit (120 < 128)
- Does not return -ENOSPC
- Inline write path is taken
- ext4_write_inline_data_end() detects overflow and crashes

The fix checks e_value_size in ext4_prepare_inline_data():
- If e_value_size is 0: xattr exists but has no data, cannot expand,
  use actual current capacity (i_inline_size)
- If e_value_size > 0: xattr has data, expansion possible,
  use theoretical maximum (ext4_get_max_inline_size)
- If no xattr entry: use theoretical maximum

This ensures the capacity check accurately reflects available space,
triggering proper conversion to extents when needed and preventing
the overflow crash.

Reported-by: syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f3185be57d7e8dda32b8
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ext4/inline.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 1b094a4f3866..3a3aa2d803db 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -413,7 +413,30 @@ static int ext4_prepare_inline_data(handle_t *handle, struct inode *inode,
 	if (!ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA))
 		return -ENOSPC;
 
-	size = ext4_get_max_inline_size(inode);
+	if (ei->i_inline_off) {
+		struct ext4_iloc iloc;
+		struct ext4_inode *raw_inode;
+		struct ext4_xattr_entry *entry;
+
+		ret = ext4_get_inode_loc(inode, &iloc);
+		if (ret)
+			return ret;
+
+		raw_inode = ext4_raw_inode(&iloc);
+		entry = (struct ext4_xattr_entry *)
+			((void *)raw_inode + ei->i_inline_off);
+
+		if (le32_to_cpu(entry->e_value_size) == 0) {
+			ext4_find_inline_data_nolock(inode);
+			size = ei->i_inline_size;
+		} else {
+			size = ext4_get_max_inline_size(inode);
+		}
+
+		brelse(iloc.bh);
+	} else {
+		size = ext4_get_max_inline_size(inode);
+	}
 	if (size < len)
 		return -ENOSPC;
 
-- 
2.43.0


