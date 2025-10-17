Return-Path: <linux-kernel+bounces-858728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C597BEB9AD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 22:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AA5CA34E0D3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 20:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC87C335093;
	Fri, 17 Oct 2025 20:13:41 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC11347FDF
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 20:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732010; cv=none; b=hvNNnd28H5xLDlHCYCTtM/dVTLnPAcwq9oKIUB3RaDppGJgPjsukzG40xS3hF+jPS7Su18U/gSskmevG2I2ucggwjxR2sToix2fmy7J829j8B2+XyFyjbWdD7M61ntfvmA06QkKvsnQm28JtQIkGR3ugrMBfEBd0ZGfwLGt+YpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732010; c=relaxed/simple;
	bh=wf8FZ7UkrGZhVzDURCcHK1AVDU4NTOH2OfPEUNSQsAk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GT6g+hDfW6pKW6Z+4Mqcb2+z0ZIX64OaO/e+NhM1xMWA/GlRYRqojHeYhYjul7N78Y3jygscjug0onc01psIzD4cLljHm+k8vJ3nrK2mpRL8MeMAbMuLTd8yLy5R8fe1GNlhDSy/xIhtitTZsvLqyAbP+ZhsYc1Ki1l8+Kj8zSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430ca53080bso9956245ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:13:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760731994; x=1761336794;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mYseOr+clmvNv4ljvsx7+jJfkZZ0cNdjxSYDU9oQWu4=;
        b=j/5WqlPfTHLElLacBDAL3J3lzOUDUueqIgGHDrH13hd90oUogmLOZGU/VToOE4YcLZ
         BVO+I7sfD9XGhR/RaUhuLTjwcAAN2X/PbRO3Zy6+qwTR+E1iN+QSdA2MGvs5VpzVY1E1
         /z1qjX/06J8Mzo33AoHxHXlxnLlOUYhhtEPZeVkLdqYQU7Hi9jxEJ/AKucc1yfURXdfE
         p2yNH89Ta8+jnwF/JM+FFOpbucW47zr6HTb07V//gvRGhK9pE8rDWwo968y613LT1zhY
         idbnhn1zXf9RhRFcRUdV3sh3l5m2WM+eOEbbODBXN3ki5HjYWUCgd4xmRiFaaU6O9Yte
         GbIw==
X-Gm-Message-State: AOJu0YxGJMR4stcjcjRTdC7EpdZ6YrRUMybbJdgmZp+kA7lkcLMgEv0P
	T1ozei5EB1zKLts8HkmRWUnYPf557txobW00lnLM0y1CQQNHQTsnS0oaYQjntU8ea2JhNWAluBv
	3mTGEiFHMTksaOsUczrS1gBU2kR/u2NKfMUBM/k7/QcgXIdqKNt5/tKM6Zmo=
X-Google-Smtp-Source: AGHT+IHTjtbqn4lfmizrdIuL9XzC3TVbUuHDX3PAb6Zo2ma7qFHYfKuxf+MfZQsnaH/rJcRyw+zyJXCJ5ZHnAH+RzybWcs5SeARB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda3:0:b0:3f3:4562:ca92 with SMTP id
 e9e14a558f8ab-430c525f51dmr80052455ab.10.1760731994024; Fri, 17 Oct 2025
 13:13:14 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:13:14 -0700
In-Reply-To: <68f1c794.a00a0220.361615.000f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f2a35a.050a0220.91a22.0429.GAE@google.com>
Subject: Forwarded: UBSAN: shift-out-of-bounds in dbAllocAG (3)
From: syzbot <syzbot+4b717071f1eecb2972df@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: UBSAN: shift-out-of-bounds in dbAllocAG (3)
Author: hsukrut3@gmail.com

#syz test
---
 fs/jfs/jfs_dmap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index cdfa699cd7c8..76f4b9322034 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -1372,6 +1372,12 @@ dbAllocAG(struct bmap * bmp, int agno, s64 nblocks, int l2nb, s64 * results)
 	dcp = (struct dmapctl *) mp->data;
 	budmin = dcp->budmin;
 
+	if (unlikely(budmin < 0)) {
+		jfs_err("JFS: dmapctl corruption: budmin=%d", budmin);
+		release_metapage(mp);
+		return -EIO;
+	}
+
 	if (dcp->leafidx != cpu_to_le32(CTLLEAFIND)) {
 		jfs_error(bmp->db_ipbmap->i_sb, "Corrupt dmapctl page\n");
 		release_metapage(mp);
-- 
2.43.0


