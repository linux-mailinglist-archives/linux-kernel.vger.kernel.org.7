Return-Path: <linux-kernel+bounces-868002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DEEC041ED
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 04:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6F223A6EDF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 02:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A4E25487B;
	Fri, 24 Oct 2025 02:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J469gO5Y"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AA51A3172
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761273113; cv=none; b=prS+IphUmpi3VUfYaki95eFq+/hqmBaUAzSapW1PrSU8ba+fH2xh0n/XkMtiVpeXvVBguiFnBGLz6DH14pbSDc+fcZJt7XSCVhS7XAMl4eUvnlLYyCR6xjFOlYLQMiqNONJZKL0nf5wl2LimwZ/u5YAa1dsXuDzWgiMzgK+mXpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761273113; c=relaxed/simple;
	bh=mB+Sz698UKnQG2Of9PMiBc4sskjxEz1TZXLMejF+Bgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bf6mJDT7XhzSmDQb/5P98koJi2tzTi23ASa5Bi+2omMbAaAN4ebuTFsvrsLQdAyYTsjD/FvXTqWdNnZliFyNXHJTvnKcWI0m0lgwkjN53L9TxdL9EPYuA+M5Y6rx9a8SnyBUGdUsYFjM9zMH+0rQA8THb6K5cZ2NQjcv4yR+6HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J469gO5Y; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b6d402422c2so358867566b.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 19:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761273110; x=1761877910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vucv2+AArBiVxHEjmAULkpSApHonysQt9coOVU0c3uU=;
        b=J469gO5YNnYmxKk1EKKKRmejrgzAR64lq13epqZCGAG90VGLlRRC7iQZJ3e+HbFfzQ
         Wohatz3qxgAZ3dombSS2caJgYCw2DMct7lvU/jCZc7iSzjkQNN6ge/xPYIPY2oZoLou8
         JgiP0rxxmNeiVbXX4AiTb+DSSJ7Zc8D2UjhI2+umBtAM9l8JEosKYhnVcc8KMnFwsF+K
         6uUmsp7xYkzpvC482SjW0YrY32F1ZJg2ta2Zh4iWoC/2H4gfZhyijTmu//Ze2+IwfC1T
         0aYIzJqRaFAnalIjn1eFVkQlSYjvkaour9szMtpq++inncOfbKr7Jy3vIRWYcNPr8HPM
         G/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761273110; x=1761877910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vucv2+AArBiVxHEjmAULkpSApHonysQt9coOVU0c3uU=;
        b=u5dgOg/m7AlW5nfk537xGTGM9txv7fP8r1/lFtzdElMb+PenejdPZ0eRxEqxLkczxL
         5otWeXKN1M8FvdMgrYvOocrq7XPFV3hxvmW3kOfahYSm7y7FUc9Ty4v3t12OWX1/P656
         6LWHlAl9+vXPBaaWmVuuLWxRhvnOhKFI6QnitEjwgAiq2jHxu6sJUckXKWclAfo+p9PQ
         kmfaVyPdI2JrEIN6VEGdkRdKXAcQqecdzQx+F8u66PRV5bieVsCXDxQSdqzkbWR49256
         CSlvMRvft7HMdeEOQxzLh50c6glvQce7b42EE3DWqox3WtLW/0j8T0bta3fJAQBIrR4C
         6YVw==
X-Forwarded-Encrypted: i=1; AJvYcCX7u/bzGJ4A6YBTtlIc8J/8oPYzGMhyvV6aELyuzFpLDZ1o4Jkg2P1qZApTMBB6YYz6ihIhk8ns0dDEp28=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXU8vPY+jdEIUEX9Pa/twDHQdk9nt9HrrihqCo/kP+Ug5imjVw
	OxOYe+CMDo3tba7VCDA7eQlZF0HW0XVihYbNKRcAiELOWU4ZREUR5mtv
X-Gm-Gg: ASbGnctmbBSt6/oqk0jf36DrFAf2upFubf2mBLvw/rP6ZBYN+EDUvW0qLXv99p5IE+U
	4bMu1QvcZT2uzLgmRyR4350douTe7gHSu+7kh+aFBokaElHWeoZpRlFuMgO1i+1xInwIDeITipP
	Li4olDZ3pHHx8LTa8f/630aC5EY40wqLGBSotewj6VPjiqW4cP8ep9Ia+FWslbFfHF43ilRgJuV
	bARoPp09GCJDknykOjNfbzjKIBNIkkIqeOIbIloj8upTrHEM9OuA/DNv8WBQtgkC26M4NoU1oFC
	om8gCXHRy4V37+LtR0hzdLNgRduEGS3YoExHy1GV6GmlEQkQo7K8kjT8RMcNrfiAX3kE/UsliHc
	/W1qV0/jFONKCvHYd0ejIQbWBydsnIzLZZTLOte175ov7mqtEdju5wFsu6xDSp2hFVAyo4twP2G
	AaaBMcmdsfPvDa
X-Google-Smtp-Source: AGHT+IFqr0OGMyRPm4LvrFPZEOmm/DXOx7zylQHcHqhS9CvytEP058sbN2a+w/3eikBWJAEa++c9yQ==
X-Received: by 2002:a17:907:3f1f:b0:b6d:5003:8746 with SMTP id a640c23a62f3a-b6d50038937mr592991666b.21.1761273109902;
        Thu, 23 Oct 2025 19:31:49 -0700 (PDT)
Received: from eray-kasa.. ([2a02:4e0:2daa:1585:2b9a:69d4:d466:5f63])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d511f8634sm385725066b.29.2025.10.23.19.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 19:31:49 -0700 (PDT)
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
Subject: [PATCH v2] ocfs2: Invalidate inode if i_mode is zero after block read
Date: Fri, 24 Oct 2025 05:30:57 +0300
Message-ID: <20251024023056.29275-2-eraykrdg1@gmail.com>
In-Reply-To: <20251022222752.46758-2-eraykrdg1@gmail.com>
References: <20251022222752.46758-2-eraykrdg1@gmail.com>
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
v2:
 - Reviewed how ext4 handling same situation and we come up with this
   solution
---
Reported-by: syzbot+55c40ae8a0e5f3659f2b@syzkaller.appspotmail.com
Fixes: https://syzkaller.appspot.com/bug?extid=55c40ae8a0e5f3659f2b
Co-developed-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Signed-off-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Signed-off-by: Ahmet Eray Karadag <eraykrdg1@gmail.com>
---
 fs/ocfs2/inode.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index 14bf440ea4df..6c936f62b169 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1455,7 +1455,15 @@ int ocfs2_validate_inode_block(struct super_block *sb,
 		     (unsigned long long)bh->b_blocknr);
 		goto bail;
 	}
-
+	if (di->i_links_count == 0) {
+		if (le16_to_cpu(di->i_mode) == 0 ||
+			!(le32_to_cpu(di->i_flags) & OCFS2_ORPHANED_FL)) {
+			mlog(ML_ERROR, "Invalid dinode #%llu: i_mode is zero!\n",
+			           (unsigned long long)bh->b_blocknr);
+			rc = -EFSCORRUPTED;
+			goto bail;
+		}
+	}
 	/*
 	 * Errors after here are fatal.
 	 */
-- 
2.43.0


