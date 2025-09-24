Return-Path: <linux-kernel+bounces-829824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA350B97FC0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 03:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A51F24C0015
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 01:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBCD1DB95E;
	Wed, 24 Sep 2025 01:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuBwAsZD"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C551C27
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 01:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758676569; cv=none; b=Ku4Zn9WQCfyU6QnxGjrLVL91tCTeMPBHcQnTpu7Gx0tm9mVCu3T4NvA05HBVzT67+Jf2sXjBnNSkXqGUD7o/R+dAZS37UY2UvHJypTb3sfQCuiuaIV4DSAKDdGOD6CihgBWBNaF1JxhQvUgujIeCtZ42rC+IAhXn24WPIsRHIqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758676569; c=relaxed/simple;
	bh=AwRt98PLF+0uNY1wnFqWynqXeGH365J0oHAiztHFnH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bXiA5wA0wm7EKZ6JVN2Ll7CZJbKdjx/qJc8lwTbcYf06Ljape6+AlBA3ha6apWJ2yb+FjQNQhHon1gMkJVetHKD+mkJ3rWm+D9CrjARmFMigKOg99SnheFYuhQAP2MOC9rLlJ1Mmo8ytiJqxEFB+b53gYRbg0s/O+3Xu+F006i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JuBwAsZD; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-77f358c7b8fso341415b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 18:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758676567; x=1759281367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CmYWM8Z/roMtlrp5aO89HRVded3LToe4TxL6a/RxYVM=;
        b=JuBwAsZDV8bxKw2V8nhnIVTWY1wWutWmAhVw6qN2UbXCKA9NXu7RIqLmUTTki90TjF
         anXdaAcAfBhq3SH+RhN8nYdyCF3uR3krbuxBBHZt+HitBfXNKIWS2pPtDXLv+FwgzkRt
         5ONrXm1LEeP25h0MfVKGeYH8uk8kxRJO6om1e9zUmZb8i/PAXX+jnBsdpE84h8KddCfx
         ribQeWBG99ISSQWHdy+Z4Ea16YpADZHv+eyymHIxnINKt9/M6u4U3Vwp6i+exdLN6r5h
         lt9hMEUPumMtSuvCEL16qyDvDtweOrEyUSHqBWCr5PD30H4wSLW2voSAZGRFEVMiYugA
         +tKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758676567; x=1759281367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CmYWM8Z/roMtlrp5aO89HRVded3LToe4TxL6a/RxYVM=;
        b=Wz/gx32Tbg2B0bIbXkQ0ASTD68nZZvg9aGL/hIENYl66/kAjvj+oDpBdFya+wYYyHd
         iiqPc5FQWU2/Yi3Q5UQGPmEnmFR+xnX+xG58fY0U/Y6p+jeYZahTNNvXQwaasoiDu2G9
         uEUguV87acZz86kj9AcbCy6JMjgvzmKx/vl1B7DMZEjv9E4ndS3so8XGwV5xQPTad9MY
         8VykkoQNiBlw5Gz7ngIilj9MLGhXEX8D+4eWogkLmFps5qMcub3lOPmZy0xH5VWvZa1d
         kwncrviPWY/hy6uGUX7YdEARpgktK2ysZM1yTdneG2K8xQFk4uJ1wUICM7tf4xFHfAdt
         7JUA==
X-Forwarded-Encrypted: i=1; AJvYcCV4ermESDMa0bKfpE6J30v7+G/solcrLu2FzJpiabiqqDLJgskABoyIw6I6GBQoz9iYkjY5KBU7LiwTeEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMdVf8jVLF2NCT2dhRtFzhDJZ1WQF0hjvjcbmPIelkuLRPIcrV
	cWN8H9SpkJzv1ClXu594KCKaJXIDh6fq1UrwZNxmhNDFfa4Bl/WPZw33utEU8ifhvww=
X-Gm-Gg: ASbGncu72cMtiWhVamrKVELAHp/yZgg7wMq9RwNzpWgshpTg7XOd6vXWHrbUMOzXQHy
	Nu9pNcL2BOmx9D70SEPbLjLc11Z4D6oyvhg+HFe8uN9p7GpmGWBOWz44wVqqsYw1HJblBGnjZwS
	6Nf2e3dLYflFVWWcNY4lBEF2E/0WhL+uWbCuHwSzQG1io6zTRd7exxP53ecx8hzFnZ/t973ZiLu
	DFpqQBNnATy5Jh+zFnVixWxWLM3uHzJZQ1BSboLjxDbg8Cgzem5yyBt9efSTfMccEGxp5GE0ttD
	5JVE75J78TTni3BF4lSe+bNVswY8hs5l1u3RYeFgDECeeY9yUg8lwtozpO3fr0HFkpbNZtoE96v
	MXKLnKykSabsEvIkwWbA+AAVgmcCcDsCg5eRVCdjptRATeCPCRv9XnU/hy8BJ6OkKzQx33i5puY
	a7nJD1YJ4TC3tHJLgz8eLqi65Rd8HbbNM=
X-Google-Smtp-Source: AGHT+IF2K4ME6oNGnHPP6a6Wh//Hbt1hnABF98AbnESIlitVBHjYmmiLru3v79EEvbaMsrGAJWCvsg==
X-Received: by 2002:a17:903:230b:b0:267:8b4f:df36 with SMTP id d9443c01a7336-27ec13cce7cmr6823895ad.29.1758676567287;
        Tue, 23 Sep 2025 18:16:07 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:a860:817b:dcc:3e4a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980368fe3sm169878605ad.151.2025.09.23.18.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 18:16:06 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: tytso@mit.edu
Cc: adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+fd3f70a4509fca8c265d@syzkaller.appspotmail.com
Subject: [PATCH] ext4: fix allocation failure in ext4_mb_load_buddy_gfp
Date: Wed, 24 Sep 2025 06:46:00 +0530
Message-ID: <20250924011600.1095949-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix WARNING in __alloc_pages_slowpath() when ext4_discard_preallocations()
is called during memory pressure.

The issue occurs when __GFP_NOFAIL is used during memory reclaim context,
which can lead to allocation warnings. Avoid using __GFP_NOFAIL when
the current process is already in memory allocation context to prevent
potential deadlocks and warnings.

Reported-by: syzbot+fd3f70a4509fca8c265d@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
Tested-by: syzbot+fd3f70a4509fca8c265d@syzkaller.appspotmail.com
---
 fs/ext4/mballoc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 5898d92ba19f..61ee009717f1 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5656,9 +5656,11 @@ void ext4_discard_preallocations(struct inode *inode)
 	list_for_each_entry_safe(pa, tmp, &list, u.pa_tmp_list) {
 		BUG_ON(pa->pa_type != MB_INODE_PA);
 		group = ext4_get_group_number(sb, pa->pa_pstart);
+		gfp_t flags = GFP_NOFS;
+		if (!(current->flags & PF_MEMALLOC))
+			flags |= __GFP_NOFAIL;
 
-		err = ext4_mb_load_buddy_gfp(sb, group, &e4b,
-					     GFP_NOFS|__GFP_NOFAIL);
+		err = ext4_mb_load_buddy_gfp(sb, group, &e4b, flags);
 		if (err) {
 			ext4_error_err(sb, -err, "Error %d loading buddy information for %u",
 				       err, group);
-- 
2.43.0


