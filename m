Return-Path: <linux-kernel+bounces-834569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E629EBA4F5B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 21:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 439401C23DA5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 19:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5EB27A46F;
	Fri, 26 Sep 2025 19:25:16 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C721E7C2D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 19:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758914715; cv=none; b=UcQMcycbzf9YBRQOJU36elrJQSmqCDLl1VtJs2Kzn02+yH+gL5djuqtLuyVdm/udmPVpicFHJ3hM4N39m8gjg/479F3dcrKr31pKFfwts1vCZWZQTiC5f96E40u4xunFlGtKYnk6OJhI7NIy2GrFV63d3VpIrznd6qQcPpGGXSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758914715; c=relaxed/simple;
	bh=AjsE0OtOFuiz0tzZGEdBNtjAlV08uWShNc5qCZ2cK/Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RHg3Bbvp/MbJsrRiv4dPl+Z8xiKT7+FrUoZGiCxijAkhN5/Yb9DneJJ6TKuahlmvQQkYHH0xMq0lFMLy360HewnRN2Hh+V2YtEigDRk/QIwTiCeMOuLhO1L9gT1dwu54OuEVl5PPLLqkEZQ+OGO/KmV5ruIdMuovaiQZYCvpzig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-889b8d8b6b7so415054239f.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 12:25:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758914713; x=1759519513;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YvFuA4434kRn74Cvfh+GZ/UGjhC11w1l7b/adwnKRIU=;
        b=EwUYmlURZnNKOEJokWRxy+7xUD7NRCzGADbeGt8nozlPnq3NJ0prSqmfOaRdFo6q3c
         /juYKuxPtPjQg40FtXyTQUksi+uFb3ytcOC4EHU8UPHmSD0VDnMKV+I9ZNfFICge2CLr
         FKpp5tl6H/VHOJs7L0kP9gg1BbNHZTwkzwKGGAe7qj9cHi+7Q4Kd0WCeVG2llLBBbI1q
         CRG71b/HLndHz1dL5vgy9BtT4w7fAUNxNaH1Mfq7QkfuTr/SednHTqLcItOCpSRX+foU
         WSeDWzVywJ0LGj2rGduUcMgXHPnjzGm8nHjw8ReXSVMpTasL5lQKKcAXSDa7sSO8+HDT
         rjxQ==
X-Gm-Message-State: AOJu0YznjyZt+xAsfIt2+ClNo2+7zNCf+sPPzajdV+hN33Iey9EL0ryS
	FQnW4KkXJYGSM1yr/5+/Cs2e6POsV57h1+3U+N1sBujt2ZromaMyr2JSjhH9Cz/cCOptrSy5xgh
	aJjsCsCxfLVNp+vT2NYLwId4bNpUsPDAMUSefoa7RtFGZ34LOBxL5PlALEFo=
X-Google-Smtp-Source: AGHT+IEAr0Fv+uRRK+SVL2zkZ23IvA1A7ugWcC3ZbDn0yGSgkyjysQ/Yl76Twxcr2GvqHgR5UTe3Fyfk5FEhcKiniSOdIDiHqI4/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24c:0:b0:424:8535:651c with SMTP id
 e9e14a558f8ab-425c12dcfd3mr105684405ab.3.1758914713594; Fri, 26 Sep 2025
 12:25:13 -0700 (PDT)
Date: Fri, 26 Sep 2025 12:25:13 -0700
In-Reply-To: <0000000000001c59010612fd7c60@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d6e899.050a0220.25d7ab.0199.GAE@google.com>
Subject: Forwarded: KMSAN: uninit-value in hfsplus_strcasecmp
From: syzbot <syzbot+e126b819d8187b282d44@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: KMSAN: uninit-value in hfsplus_strcasecmp
Author: rampxxxx@gmail.com

#syz test

---

diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
index 901e83d65d20..75f1c029c2ed 100644
--- a/fs/hfsplus/bfind.c
+++ b/fs/hfsplus/bfind.c
@@ -18,7 +18,7 @@ int hfs_find_init(struct hfs_btree *tree, struct
hfs_find_data *fd)

       fd->tree = tree;
       fd->bnode = NULL;
-       ptr = kmalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
+       ptr = kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
       if (!ptr)
               return -ENOMEM;
       fd->search_key = ptr;

