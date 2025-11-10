Return-Path: <linux-kernel+bounces-893685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A537C481A1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F4B34EF86F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD7E328602;
	Mon, 10 Nov 2025 16:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jz7HLTG1"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C788B326D6F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792711; cv=none; b=T8Zb/e6cdmHP2HQyUAQLM35YVUtVmGGWtW26bWOhU69euM4/49R6AV6ZY8Gs/NZ+myC1qRUfRnxVPMwVRKPtAsWGJHPjphjniz6OWI24TX4zNpfDPzZiS1+Xf25OFyWdvKXXVMFzjG7D9SRHanEDpXorxINab4tr9QpkjX2ChpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792711; c=relaxed/simple;
	bh=NtWnINBt3sM6GiXGdKHci0gX7e3BpDT+7lx59+8Zdus=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WXCMYtqDCzEqce95KNZYPiMBrAbMSeu9Eu5mEu9rLhkuIErNc1ruUZfoYPqZoi3sOP0Vi0ImkoLle6R+yUoupEfwZfuDRXHWwPsDczWkaoS9AdUE8maCqbgwpdeAoDZe0q6djorQyMlAHiNh6JjMLaHfPXt/Wy41xmMu1/JjwiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jz7HLTG1; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-640a503fbe8so5822245a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762792708; x=1763397508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=crySnOU0BCzQMPPEF+Im0cShC+HGRCGDJ0MSVHJMWYg=;
        b=Jz7HLTG1UVYjcpQz7csEmnd+Oa87xqpup0PgaUOZ9+/xnwBe/+4qtTX1zJNtEFb9RS
         /jt9YI722uZvxQo1W1Tz8Swb3/Hqaja9d/370e+s+WX5cVu2blOEruTNQyFuhIinue5v
         thQc0WIts1C2Ldm2FMRcjqFzHj5kHBEaObpmewjtbp3bIgOWLWiG+uramKWSclBWT01Y
         pChFA+y3z9yqR3CO7PLZOw+WsB2Rreu9u7HiadMlk/oh6QgRncUJm8l/q4l2IDYLrAui
         dphML3/i03GT50PjxlQG4fuJvsBDsgLRwvUs/2MQKB0Hr6eXYMQRvs1UDPw1beo/73CD
         H9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792708; x=1763397508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crySnOU0BCzQMPPEF+Im0cShC+HGRCGDJ0MSVHJMWYg=;
        b=o8LzwKYJY73ZP0hSKTN6LHcEJkg5dKYvw1z5PH3XgTCCzz8kgo5temlYrmapKMj2Fo
         bxRMztD+D9FFpu7MtDe50dX+zVhRxyDxx5wF+BOIuTW+vPHUiuPo2Jo8P95w97gNrX09
         fTkAZPludhrkxxcEztTNIpgsefeP9hGvSjqbrNIJuWBCTfZvuYBwRJEMkOeBOAOVN/LM
         NdWXNFtA6MVJYgV4M46L966M18pkPzDaEcJ3wJ4lrsiOvO+Kk6ehS/NzpHw1fFcl7aA2
         fs355Tpd/EZ3mZqSYhVJGDRbzFABatIKTCZn6G+0h5gLfftrwNWU4ANw6tIA+rHDzVzX
         9+gg==
X-Forwarded-Encrypted: i=1; AJvYcCX52a+77rpLG3s1vtaUIapKiIKpbPxh/zDFT5+myum3aCucKsoclsshXtEHBcjUR00mPbwGk0Ak9ITWmKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwURZLlzQNT8KNrOSoDs1yAwnAk4XokEWGIgH2w+z6pY1ElOcyz
	ibUg8TH7KRd3b0dHzdqdCdY1E9xRk/apo/t0DOYog3INkjkL+j1OMDcj
X-Gm-Gg: ASbGnctvuR4OcOqMXXWz96rnDMgS8ZEEH8BU7M565Tanc+E5EC3rmhrkjq62uecrNsN
	PbYxLWk+GA4IHGxIBrjMD2VvQpY6fPPwkCqE3Kwq7XxxdKTWP5Ax5/LORSaOklEUmwyI3gVds/N
	2/ovtuXYpvYpYzALUr5QZQW1uNvLs93n9HRlVVmR0tFRAfTari1yeMMTP0a/ZKPHSV2spGYO5aa
	himZlmzGWqRol3dDf790BNNzn7AKA9HgfgeUWRYtsQcue58hA3V9tU3xJvKDgGrsMh1lpES++eH
	XPIFvFACmuuqw+Ipyf3Jfy2xiI4WeOUm9+GTzU/xdngR1nOqvl8GftIHaE0qzYKRUOCow2xM9Cm
	OheRg8fLml64hLNqU1ouo5q7R66T+0KYF2q6tlfsIbj3mDq9EMJM2ukerBCxJx9KJSdwBR0qjRj
	Zw7FVIGhFdTaeZ52RBHttmzSZjelWvaLd9oEHtV51l36cqZLMN
X-Google-Smtp-Source: AGHT+IFRyFfuGUAUqh/iXGb40Q/6TuxBb/dJTSuyufllnYorj5TKU4oOweyogQ8JItcI/4Zi5gDSNA==
X-Received: by 2002:a17:906:dc8d:b0:b6d:c44a:b69b with SMTP id a640c23a62f3a-b72e04524d9mr835230466b.35.1762792707889;
        Mon, 10 Nov 2025 08:38:27 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bfa11367sm1112772166b.68.2025.11.10.08.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:38:27 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3] fs: add predicts based on nd->depth
Date: Mon, 10 Nov 2025 17:38:21 +0100
Message-ID: <20251110163821.1487937-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Stats from nd->depth usage during the venerable kernel build collected like so:
bpftrace -e 'kprobe:terminate_walk,kprobe:walk_component,kprobe:legitimize_links
{ @[probe] = lhist(((struct nameidata *)arg0)->depth, 0, 8, 1); }'

@[kprobe:legitimize_links]:
[0, 1)           6554906 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[1, 2)              3534 |                                                    |

@[kprobe:terminate_walk]:
[0, 1)          12153664 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|

@[kprobe:walk_component]:
[0, 1)          53075749 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[1, 2)            971421 |                                                    |
[2, 3)             84946 |                                                    |

Given these results:
1. terminate_walk() is called towards the end of the lookup. I failed
   run into a case where it has any depth to clean up. For now predict
   it is not.
2. legitimize_links() is also called towards the end of lookup and most
   of the time there 0 depth. Patch consumers to avoid calling into it if
   so.
3. walk_component() is typically called *with* WALK_MORE and zero depth,
   but these conditions are checked in this order and not predicted.
   Check depth first and predict it is 0.
4. link_path_walk() predicts not dealing with a symlink, but the other
   part of symlink handling fails to make the same predict. add it.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

v3:
- more predicts

This obsoletes the previous patch which only took care of
legitimize_links().

While this only massages the existing stuff a little bit, I'm looking at
eliding some work later. This is prep cleanup.

 fs/namei.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 2a112b2c0951..a3d86bd62075 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -785,7 +785,8 @@ static void leave_rcu(struct nameidata *nd)
 
 static void terminate_walk(struct nameidata *nd)
 {
-	drop_links(nd);
+	if (unlikely(nd->depth))
+		drop_links(nd);
 	if (!(nd->flags & LOOKUP_RCU)) {
 		int i;
 		path_put(&nd->path);
@@ -882,7 +883,7 @@ static bool try_to_unlazy(struct nameidata *nd)
 
 	BUG_ON(!(nd->flags & LOOKUP_RCU));
 
-	if (unlikely(!legitimize_links(nd)))
+	if (unlikely(nd->depth && !legitimize_links(nd)))
 		goto out1;
 	if (unlikely(!legitimize_path(nd, &nd->path, nd->seq)))
 		goto out;
@@ -917,7 +918,7 @@ static bool try_to_unlazy_next(struct nameidata *nd, struct dentry *dentry)
 	int res;
 	BUG_ON(!(nd->flags & LOOKUP_RCU));
 
-	if (unlikely(!legitimize_links(nd)))
+	if (unlikely(nd->depth && !legitimize_links(nd)))
 		goto out2;
 	res = __legitimize_mnt(nd->path.mnt, nd->m_seq);
 	if (unlikely(res)) {
@@ -2179,7 +2180,7 @@ static const char *walk_component(struct nameidata *nd, int flags)
 	 * parent relationships.
 	 */
 	if (unlikely(nd->last_type != LAST_NORM)) {
-		if (!(flags & WALK_MORE) && nd->depth)
+		if (unlikely(nd->depth) && !(flags & WALK_MORE))
 			put_link(nd);
 		return handle_dots(nd, nd->last_type);
 	}
@@ -2191,7 +2192,7 @@ static const char *walk_component(struct nameidata *nd, int flags)
 		if (IS_ERR(dentry))
 			return ERR_CAST(dentry);
 	}
-	if (!(flags & WALK_MORE) && nd->depth)
+	if (unlikely(nd->depth) && !(flags & WALK_MORE))
 		put_link(nd);
 	return step_into(nd, flags, dentry);
 }
@@ -2544,7 +2545,7 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 		if (unlikely(!*name)) {
 OK:
 			/* pathname or trailing symlink, done */
-			if (!depth) {
+			if (unlikely(!depth)) {
 				nd->dir_vfsuid = i_uid_into_vfsuid(idmap, nd->inode);
 				nd->dir_mode = nd->inode->i_mode;
 				nd->flags &= ~LOOKUP_PARENT;
-- 
2.48.1


