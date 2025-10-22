Return-Path: <linux-kernel+bounces-865955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DABBFE69B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 00:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FF0C4E7279
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 22:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F4530595B;
	Wed, 22 Oct 2025 22:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvHQN306"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ECC305051
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 22:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761172100; cv=none; b=WRkkOPzhxZGfPcgbBFEbBQcaQFVBKWTar/bxRnV+lVmjlaiIBQHBq7d8jaoDba+FIJSBQH1r01rVs/6/U6nEDYQJFceSNK4esRKw6kL+jiLIMlwThsL42T0McPvTDa0M42otsX9QOAFT1PYwVO4317omm7HnD0UcNgF/vztJ1D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761172100; c=relaxed/simple;
	bh=isfyGf+q4j0GyX+Zx0JQ48+InVacVB/eM3aODMGSFN8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SpylKkfVEE9XpZRDLrRuaRmkuS/1fZSxY6eEy49OvzwOKk13JovZRkbMfAKC9cukuAshM8jV4+H1yxlFwPyrUkwXiCdZQtmz9dKcJamiTwASMPNeomBq05GA3rrVlQ39Yx9ciU5UlQR5AVQOOEo6xOZwCnaUu8gH8bWxQL1/dWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MvHQN306; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-63c4c346bd9so215772a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761172097; x=1761776897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2VBBjigv3CT5N8O/I+Hvzhx/gBfj5BueEjexvjIc/bI=;
        b=MvHQN3066CnON4zduJPOui+fSTJeKGpDQPrDlqGEnrR0Q1KZTzklnCzk5a53q5oC5M
         f6l2WmJtUK/eqU5b/3RZVQd6suKyJ6uqXkXTWzKiBTlP4FlRqzpHtWDzMY4eA7YInqUx
         CMf3C9YntD0edXEzM0Ew92/MxAULk2wHrhA7lrmVIk+AWpMx8w27B/dePZyDCT1xc6Sb
         jPBFK5IT51wv8awZbArc+swy92Hl9b1O0GIXKfls+P0wyAHIQm+K3w5LjR/oZ06vJzfj
         YzlPvRrQCkDo6ulIId5+M6ezwRi7DmH4dnit0UAwuPoFBILrSmYu7g8rx81IPwxWUvPK
         9Kug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761172097; x=1761776897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2VBBjigv3CT5N8O/I+Hvzhx/gBfj5BueEjexvjIc/bI=;
        b=dVK3daQKph7Fwwx0BBpmBQR0dEWBjtq421x5KkCfDnUYpsFhGUgaQ1e2/pxm5/t9ot
         kPZCFyhR6EHKuqGtH9ozi6gmZL1JPBdgl3lzJAhBdzxOLUwX0DY7bCgSb3ug9yGziTXY
         QAUH462qP6CdVrvb62w9R385vNyEVMohr4E53fNtniKaBWtmT/t8rAJRgz6aURqMrqfF
         iUg3JMIqf2n2Z9Wltit4G32s1Tk3P3yOwtbquhc6dJXS60AE74dYN2gh9n9ECaVew648
         Ti9Qt0cn95UAWPaqc/PCAujcTrM1MauxIQSQ09I7gtOnEyKlsUL/STZLicABlxhWU0o4
         putQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBKrxnosMSTjDGHR7XmdnGHpfyUEK6bSKvxJFOd3PvJtRt4fya1PJvKv4WIRkG9mz0C06NxGBE4wQ1M8c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2zT0ZFVnLtptDpPJ+usNc/xC/OzSz0gf06D72nQKfZzvA0uod
	bv76uM78jJTGkB5OTlDt3NYZkkxDwjFs915z8pbXpm0K1ku/jFSVbATz
X-Gm-Gg: ASbGncsUovPxGjMyuXwtTznN61Jw1VkCY//UM11OGoxfwzTUXZU2yOGZZmOiN7ZmUgb
	RI1/nHYV0UK2xiezbsvaMklJ+gbKFZJcUOIFoBWNfglCuO7cYZjzzqJWt8tBMMYhCJlB5MsAK7g
	BRrdjLCT9sWEh4iCyNg4GzY/eYFxDwjJOKR/TwJngB/N5xpHXRVQw4+lk05N2MXmn7GH9vBF083
	wIlbtKw9pfO2+fszxws07hK6y/JuHP/ydt0fOmUPf2dJIhHt5Wwh0j6mKL+I97DLGOAtAAuVpid
	7mUnb7fD2hp4aEcLVR9s//c572Z5R6UNa27fOxrXVOxVEKvOKnZqeEmY78MnqFYknQyNQsBc/8B
	VdmrOFigcUi7WR3wWEqFLJ96IV510hExJZiKyqEdJYyDgOq1UvjHccRtbMdnsOhNFCeFSC/gmHz
	OklQ==
X-Google-Smtp-Source: AGHT+IFKy4BxL63HMi3F50TzZgIj7aS//0dgKOpQCa8zsKJgTdxjsokDGki3wOZJJ9x2140UA9Oyog==
X-Received: by 2002:a17:906:ee8c:b0:b3f:1028:a86a with SMTP id a640c23a62f3a-b6472d5bbb7mr2707762666b.3.1761172096233;
        Wed, 22 Oct 2025 15:28:16 -0700 (PDT)
Received: from eray-kasa.. ([2a02:4e0:2d06:1636:dfb5:40c5:809c:aa06])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d51417523sm28512966b.50.2025.10.22.15.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 15:28:15 -0700 (PDT)
From: Ahmet Eray Karadag <eraykrdg1@gmail.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com
Cc: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org,
	Ahmet Eray Karadag <eraykrdg1@gmail.com>,
	syzbot+55c40ae8a0e5f3659f2b@syzkaller.appspotmail.com,
	Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Subject: [RFC RFT PATCH] ocfs2: Invalidate inode if i_mode is zero after block read
Date: Thu, 23 Oct 2025 01:27:53 +0300
Message-ID: <20251022222752.46758-2-eraykrdg1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A panic occurs in ocfs2_unlink due to WARN_ON(inode->i_nlink == 0) when
handling a corrupted inode with i_mode=0 and i_nlink=0 in memory.

This "zombie" inode is created because ocfs2_read_locked_inode proceeds
even after ocfs2_validate_inode_block successfully validates a block
that structurally looks okay (passes checksum, signature etc.) but
contains semantically invalid data (specifically i_mode=0). The current
validation function doesn't check for i_mode being zero.

This results in an in-memory inode with i_mode=0 being added to the VFS
cache, which later triggers the panic during unlink.

Prevent this by adding an explicit check for i_mode == 0 within
ocfs2_validate_inode_block. If i_mode is zero, return -EFSCORRUPTED to signal
corruption. This causes the caller (ocfs2_read_locked_inode) to invoke
make_bad_inode(), correctly preventing the zombie inode from entering
the cache.

---
[RFC]:
The current fix handles i_mode=0 corruption detected during inode read
by returning -EFSCORRUPTED from ocfs2_validate_inode_block, which leads to
make_bad_inode() being called, preventing the corrupted inode from
entering the cache. This approach avoids immediately forcing the entire
filesystem read-only, assuming the corruption might be localized to
this inode.

Is this less aggressive error handling strategy appropriate for i_mode=0
corruption? Or is this condition considered severe enough that we *should*
explicitly call ocfs2_error() within the validation function to guarantee
the filesystem is marked read-only immediately upon detection?
Feedback and testing on the correct severity assessment and error
handling for this type of corruption would be appreciated.
---

Reported-by: syzbot+55c40ae8a0e5f3659f2b@syzkaller.appspotmail.com
Fixes: https://syzkaller.appspot.com/bug?extid=55c40ae8a0e5f3659f2b
Co-developed-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Signed-off-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Signed-off-by: Ahmet Eray Karadag <eraykrdg1@gmail.com>
---
 fs/ocfs2/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index 14bf440ea4df..d4142ff9ce65 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1456,6 +1456,12 @@ int ocfs2_validate_inode_block(struct super_block *sb,
 		goto bail;
 	}
 
+	if (unlikely(le16_to_cpu(di->i_mode) == 0)) {
+		mlog(ML_ERROR, "Invalid dinode #%llu: i_mode is zero!\n",
+                           (unsigned long long)bh->b_blocknr);
+		rc = -EFSCORRUPTED;
+		goto bail;
+	}
 	/*
 	 * Errors after here are fatal.
 	 */
-- 
2.43.0


