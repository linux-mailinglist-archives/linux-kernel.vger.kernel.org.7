Return-Path: <linux-kernel+bounces-823516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B6AB86B53
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80D391C846E0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A472D73B2;
	Thu, 18 Sep 2025 19:35:09 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD63D528
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 19:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758224109; cv=none; b=EvYkifxOoJnHLTVG9zO3Fs0g+ifwlZRWmxDEUFrrilO9peAJTULTBO1wftt00F2oxd+4Eh7p5EinBOR4YwFGy/T1ZjpJLzb+Uwgw12NMDRaNYkRXkI/shTU5590abgUfbKLabU4yquSjKtZ1u83hFxrjngvIyLshKrf7YQgdJ4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758224109; c=relaxed/simple;
	bh=sPkBU1nDyCkSyLQKmZ4RlHzT2QokMe2yIRpOmhI9co4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=a9YOlaXDTYQDu0Cqn/nTl8Bc9PusnzuL/a0LJiLJXVGykKleP0K8xdlmkPjKGigEx6YUES2nlkFAASrss0i3Za2gANVsrxlR2m02JRqly03QDQMSJ2QXkUGn9Sp/H5Bei9qfff7fBTjjsTz9Yu6aerrXwy0qmA1Aw47JPDIUFmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-424122b50aeso14135005ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758224107; x=1758828907;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FP2yXxwXp4O3NZnhi4S/6nC7WECV4xsQF6DiuwSkHAg=;
        b=ZdNsznqcmZjOkdLNFRiB/YbmTXBuJ8gH4ZGo9UUYikV/RzdY7JoMz3dFd2UBWUjtxO
         Crb/tg25HuW1yj0uV8qtwot6hDtWQJXTVfFFnTOvCGJDrdbNNvjZryyTn5Or6iWscHhR
         6UdPsLj2uEez2FfzkKHg7ZPsR43UqQEKwv/OHDe7vxvqnsn5eVN999bxqOXD3viKwfSi
         wcMVHNVsWAVxQsIHNUGa4p2VyQflpyxaWs/sm7N7SVAh3nJPdBDuQJIhWQdiG4/sS2/a
         vIYRXU2KLs73TrULJGKPxM1jDujkK51anvQ/6B2vobsfNIpTwlDCrnF9bAk4cO76UDrB
         wJag==
X-Gm-Message-State: AOJu0Yx2q5Ce5ieIacfmkONApuap8KOwvxGST8ZDLKQ2hnW5Z9t5oQ1m
	ggBb6JxyY7/khnnay+wS5ol6S9MDnwPoTFf8uY0tXeDeoGlXWxg1hYLim1B5E7R6EE6+BSgxJZB
	ugGLoQ7foOA/zvtkWVKDrQvWxd17HjqGcvJ2J99gtGHFuQ9Nlh8lLzjvuvFc=
X-Google-Smtp-Source: AGHT+IEWkWvuFHRFeNW4ddknB8TVhJVrLeYul46fVW5AjqlHjdwzd7qDNdkqkoIYoffnObZqe1frmU9KSMoUXT70xXWQTMsVvB0M
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b26:b0:424:7dfa:6c05 with SMTP id
 e9e14a558f8ab-424819a9bacmr12954005ab.23.1758224106842; Thu, 18 Sep 2025
 12:35:06 -0700 (PDT)
Date: Thu, 18 Sep 2025 12:35:06 -0700
In-Reply-To: <68cb3c62.050a0220.50883.002b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cc5eea.050a0220.28a605.000c.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [ntfs3?] KMSAN: uninit-value in ntfs_read_hdr (3)
From: syzbot <syzbot+332bd4e9d148f11a87dc@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [ntfs3?] KMSAN: uninit-value in ntfs_read_hdr (3)
Author: sidharthseela@gmail.com

Signed-off-by: Sidharth Seela <sidharthseela@gmail.com>
Reported-by: syzbot+332bd4e9d148f11a87dc@syzkaller.appspotmail.com

#syz test
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 1bf2a6593dec..3c44af1af9a0 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -718,7 +718,7 @@ static struct NTFS_DE *hdr_find_e(const struct ntfs_index *indx,
 				  const struct INDEX_HDR *hdr, const void *key,
 				  size_t key_len, const void *ctx, int *diff)
 {
-	struct NTFS_DE *e, *found = NULL;
+	struct NTFS_DE *e = NULL, *found = NULL;
 	NTFS_CMP_FUNC cmp = indx->cmp;
 	int min_idx = 0, mid_idx, max_idx = 0;
 	int diff2;
-- 
2.47.3


