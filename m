Return-Path: <linux-kernel+bounces-752844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7452BB17B82
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 05:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E424D1C27524
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 03:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780331494DB;
	Fri,  1 Aug 2025 03:48:44 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989F72C9A
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 03:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754020124; cv=none; b=Pug7+T9AhtpdlRXl9skEYULg1mZ6mejfIlqzO7QMm9XQmVwCiMRaKnuU9gbroG+x6+C6G6XgrcoV9kEgGAN4KZBkYxB13hmaIFaKe/N+tYKz6GA9IAi/Uz2X3jMZs/5hrPjGmYypmfOT+FUVuHbdbz+L8ZkXQ794XVqvxR99iDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754020124; c=relaxed/simple;
	bh=hJJoJOiZOFqrxZimmA543CNtS//7HntSV6ri0mlfLfo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GykiSNQMvagLjT656W9H+/7ZCarhEbTdplNGR+4mH7Ziurf9MCKwHyzaAn3ga1MFCVSMow3o5DcgzmZIGvszYs7lJQQsSxd9ueEs/WPHqH+Ou9+ZkvIpQLco6LxQYTyFs+EphOmJV+vhAL5AAW25FPwf3iTgtCh7mFq/Et4kkdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-86a5def8869so243471139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 20:48:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754020122; x=1754624922;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zuMDpJhzDRBxSwymVg5YcWnq/tur7nnQX9C2MTNCgMI=;
        b=pTlY/RjOyxLpXTc0HpJTXxzFcUVs3WjYvdxGy+CSG6SWv4VZsCbgoRlxcPqF4RSNNa
         WD1SpeYLUAO+X42c2CKnzZNCBpJcDiYJA3fGQFQpOY8ngjDDqU+2MPkcEJyxBIWZexD3
         KkuY1+GhbkeZoclCCZWOUFQbJBYmjdxnZYLbIcuCMn1kAP10MSd+7ct8CzCVYQ97IF+s
         u+0+dhuQ9qqC73O5+rUFXR5arPwVJNlUNbMok0goicAenaJeWm3BDgGeHDPAZkKq6p8q
         6a/y9O0w3Zdmy1t0A9+ZSFzNMv6/DWsKVFx7jDIjOzDMnaDjlH/qBRCeQ7T+HaNPiCOX
         OqJg==
X-Gm-Message-State: AOJu0YwC+WUwZxuDLX2Z9hc6cEQW/9ZMXLzOt6m0xP4ElOI1ovSfRbk0
	t3HveMoQ7UxeFPthLaaGzUKwJSMJHBFHMUhQVEJE2wvDnETrGqmaD+Rmb8/p+s16FaQ8WH/kQfT
	DABZx7yOjVe48ZvDaW5T1Z2QZC4Jo6fiVHRU9Q5W4enhGsINvcEW92mCgO1s=
X-Google-Smtp-Source: AGHT+IED9I0cK10w5ZauJp9nu4KTVqNz15JJa0XtPvHq5lM5OA6TPbEsi6HnhTDVCCOhHZGFrQOG7lUfptDYVQpxldSsFkv0ijAg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c22:b0:3e2:a8e9:89cd with SMTP id
 e9e14a558f8ab-3e40d736feamr22241365ab.13.1754020121811; Thu, 31 Jul 2025
 20:48:41 -0700 (PDT)
Date: Thu, 31 Jul 2025 20:48:41 -0700
In-Reply-To: <688bb19a.a00a0220.26d0e1.004d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688c3919.a00a0220.26d0e1.005b.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [gfs2?] KASAN: null-ptr-deref Write in gfs2_trans_add_revoke
From: syzbot <syzbot+f2b9fe431c853e793948@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [gfs2?] KASAN: null-ptr-deref Write in gfs2_trans_add_revoke
Author: lizhi.xu@windriver.com

#syz test

diff --git a/fs/gfs2/trans.c b/fs/gfs2/trans.c
index 075f7e9abe47..d1a34f928a18 100644
--- a/fs/gfs2/trans.c
+++ b/fs/gfs2/trans.c
@@ -314,7 +314,7 @@ void gfs2_trans_add_meta(struct gfs2_glock *gl, struct buffer_head *bh)
 
 void gfs2_trans_add_revoke(struct gfs2_sbd *sdp, struct gfs2_bufdata *bd)
 {
-	struct gfs2_trans *tr = current->journal_info;
+	struct gfs2_trans *tr = bd->bd_tr;
 
 	BUG_ON(!list_empty(&bd->bd_list));
 	gfs2_add_revoke(sdp, bd);

