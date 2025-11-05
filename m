Return-Path: <linux-kernel+bounces-886345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 082D9C354C9
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 12:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 740C44EEE7F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 11:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EDF30FC31;
	Wed,  5 Nov 2025 11:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qna4VVlm"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63A130F80A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 11:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762341001; cv=none; b=UV8PCChH5ey6/4iwJQCiw/uyoE1jfMCemWoPS61MHBc0gYabwVJCGs7e7FMbjWblUVfyBUujrTUZxB/gECNWvTAe1a5xsQWdc6T00ORUt/4ZLR4QskHwYYWxIEosZuTkJ5Oy7Nn6yoAeiy9nq2CqFMZHhghRNsv+1mHv/5a8Hjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762341001; c=relaxed/simple;
	bh=/Mzq3xJjoScnLlS/YQOCszoPa9oiwh8nNoNQlaFG2vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bh3JdnpD1nfjgR+Gymgl7ugpz5DCzNQ1Bmb+Mn2vL34XIidWEA4JZkJrrgVns4k+wXrMeJFOgfHOkOhzIkSwbHxeH8Xu8zk+2e83z5siCWR5T/CCkFtbbp6RYHVayIXen1lne2HPgTFixrjMwfPsidYCWi+xZyyjoO8vrJ0VrIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qna4VVlm; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47109187c32so34230445e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 03:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762340998; x=1762945798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7tqhsuXnKDfa3LKYm+5yorAhNtlPrbMypXt017HtZM=;
        b=Qna4VVlm5gyPqBFq97q1+93h0D2Q+UGMQKN7MdTrXeX6W72haL5hwtU1KErtd9HCv6
         h1bWW6Ga8gozXMhsHBy192i3sXCaPDwC58f9G/wCDdeJZ2jDVW6+d2iJA/e4Ht6f/vMZ
         13FNJhdvj3RL1BAoWCiaqOjY2OxJxpDuOhyfw+JHJHhR3tjGk8Dkbz1c2L6VkHYUerMJ
         Am4GRZiVcl7Cl613zfXto8jMGA8P/M8QhrcCc/t9X2euJn0v3go8DuJUP9obI1BmO07h
         v/tY+/Lo3WxY5iuFBQKAKCTbHGdDhQuyZExrVHEdDIYQoQnf78YkKxAcDrZu3zhk6bEn
         rtjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762340998; x=1762945798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s7tqhsuXnKDfa3LKYm+5yorAhNtlPrbMypXt017HtZM=;
        b=MeUadqT4Z75M8VVPo/J5OWnFnRwnt2708WAcZdb4gWoSxTNX7DbGysBqDZ3rgx9OhS
         VzyQHTlxo0XM4tZ1/Xz3RAQ7ox036zqR1JTORYykWdkRM2lBDJVfTX4ldAkyzYNaGLO6
         5Ys/kG00s2I3VyXBtelPJ+jGAUV445K3+4oNrRmY74JW86adP3g4awbcIzbQLIeaW4zl
         leG9y31CKEIyotkwHAy8FCe3wvJRszKZSxcQRRz/xBFa0PP3hcEpaf017X96+xwjYm+k
         /Uy+2Lzijs2rr7ICMEhGx2okNWWeVAK+YXs3GPTG5IClAbcSe8q8SQIw5QOFWGEtpAgP
         uS7Q==
X-Gm-Message-State: AOJu0Yz9h5L5x5EWAFcyoDzlfJWPNPsX7QpFwYDAIkCzupnQGQORLTYd
	xDyZlQnE69Msi0bGhd9ES03E6ni+nsgxq4pxN9WEsWkFMyFKHI8DaNnA
X-Gm-Gg: ASbGncsMzYk3tDLKO+JLAyFWOOLkgcbAvQR3n/L7AdZn9Vjg41Bzwwfw36bhQ4kGGfc
	mYMqbFujkY9U18nfXB7D6V8aODmdBgN/Q4rVlceSP9XPOl+bWpXxhmMmTGrZCbCAHlaTwLZIP+t
	/jiMO/mZoZ5rkN0bNfnvTXlP0LfNq542fwq8XHhqAp8Vg7is8BaCrbqL09E41bC5DdCfPmmV0j4
	B/cBTlqFIGhKW8ei9MnXu1edEn9GWAT7E7eIYiFVbyCFpiXdQ9f6JO/sEiPf5s+D2kwf+3qSqBD
	UDUo4OfBLW3ZmYrj9Mti9nlbQXxWAmaqQq5PDIb6e2xS02DasO1Ajpx9MTXByX2yG9WchDzEEV6
	2giNUjMkQD1j3A6s75MekA0VpN/YsVq7Lm5EL0wqZyu6vKSEnYyhhUpQybJud2NGGkNEmAV5Use
	GWgZ+Pw6KBN+k=
X-Google-Smtp-Source: AGHT+IHJpcEdw1607F+Ey1V4LbwjmDQawpeGTA8lma3MVtT0pEJj48H/kPwEqm38rL5rx3ziZa4wPw==
X-Received: by 2002:a05:600c:3487:b0:471:115e:9605 with SMTP id 5b1f17b1804b1-4775ce3d8a1mr28339055e9.35.1762340997771;
        Wed, 05 Nov 2025 03:09:57 -0800 (PST)
Received: from localhost.localdomain ([46.10.223.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477558c42adsm39728415e9.4.2025.11.05.03.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 03:09:57 -0800 (PST)
From: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	khalid@kernel.org,
	stable@kernel.org,
	"Nikola Z. Ivanov" <zlatistiv@gmail.com>
Subject: [PATCH v4 1/2] f2fs: Rename f2fs_unlink exit label
Date: Wed,  5 Nov 2025 13:09:42 +0200
Message-ID: <eb59e101f0b201afb65cb40b38e1b1598039ac82.1762339963.git.zlatistiv@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762339963.git.zlatistiv@gmail.com>
References: <cover.1762339963.git.zlatistiv@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename "fail" label to "out" as it's used as a default
exit path out of f2fs_unlink as well as error path.

Signed-off-by: Nikola Z. Ivanov <zlatistiv@gmail.com>
---
 fs/f2fs/namei.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index b882771e4699..40cf80fd9d9a 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -552,21 +552,21 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 
 	if (unlikely(f2fs_cp_error(sbi))) {
 		err = -EIO;
-		goto fail;
+		goto out;
 	}
 
 	err = f2fs_dquot_initialize(dir);
 	if (err)
-		goto fail;
+		goto out;
 	err = f2fs_dquot_initialize(inode);
 	if (err)
-		goto fail;
+		goto out;
 
 	de = f2fs_find_entry(dir, &dentry->d_name, &folio);
 	if (!de) {
 		if (IS_ERR(folio))
 			err = PTR_ERR(folio);
-		goto fail;
+		goto out;
 	}
 
 	if (unlikely(inode->i_nlink == 0)) {
@@ -575,7 +575,7 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 		err = -EFSCORRUPTED;
 		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
 		f2fs_folio_put(folio, false);
-		goto fail;
+		goto out;
 	}
 
 	f2fs_balance_fs(sbi, true);
@@ -585,7 +585,7 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 	if (err) {
 		f2fs_unlock_op(sbi);
 		f2fs_folio_put(folio, false);
-		goto fail;
+		goto out;
 	}
 	f2fs_delete_entry(de, folio, dir, inode);
 	f2fs_unlock_op(sbi);
@@ -601,7 +601,7 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 
 	if (IS_DIRSYNC(dir))
 		f2fs_sync_fs(sbi->sb, 1);
-fail:
+out:
 	trace_f2fs_unlink_exit(inode, err);
 	return err;
 }
-- 
2.51.0


