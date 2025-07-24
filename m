Return-Path: <linux-kernel+bounces-743424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4E5B0FE7E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 03:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1010F587673
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 01:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A14190664;
	Thu, 24 Jul 2025 01:53:01 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAD04A28
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 01:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753321980; cv=none; b=An5HR5SJMs949XzKh72WQTzYIquIh1kk3EYwbT+5jsnRY/Za78V1vXNy4Y8/sclLs30ycRAG5dPDU1N8vIFsp0H/UXdYCjqLg3WvBdE3HtQY14uLwRbiJoHK0botRagqEZDU7fAaRpW5GsJu4Q+2JaBnR0TjQM/EKtJ50zOSDJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753321980; c=relaxed/simple;
	bh=+hdRcW+vANXIi65jGxEz+XmwLLQgAmE1hMZ56CRLIQQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MRFkESh8w4E/BS4hVoTPbQBs4qV3uj1URll+CdkoInyAy52eUCH5gi6p6kMkDgjsetTbGU/YFt/fA3Co2fGev0tURdaTtjV+Yak2KzyM5z3w4XQppvvTntvYPJlr7T+kutPmzZV+Fwl7lbeU1tWeFRbh1j74voq9kZSfZWpTD4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3e3a4a835dfso4860475ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 18:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753321978; x=1753926778;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2U5wnocwdcINYeVFrOulMMpjFkOT5Q0pcJeDzB4l8iU=;
        b=I4d1GdGqH3eMPCTP5Rskd2uZtbPeDdq60r9+QXfX2of2QoRdRGYfi0RiYhehDrlOeZ
         q9Ms9Rjfl6crAxkxYUpyCGbHKx5SRH6hnraCjdHO8r2gK5vjCuCHOUQL18B4bAqc8oXY
         NmnJmotm5TWJLsDXYEmPTtyBpoT8BetgIk5vmSdBZDquUlkmaA2N1tj67I0YZKIfYeL7
         D+GjaqLlmZA+5oKQzJG+ZkRFT3tHYyBtiGyS1BCYglIunV/+8OMfDgV2EKUKsoUCX5cR
         36Vklf0xBHmwtuhUVkX/MththLzVaGyaPwNP6pNee9FpWzvphr9iVPnwxvlX9mDdD7gK
         x8Zw==
X-Gm-Message-State: AOJu0Yy8bNVNpJs45j6ipcaP4HpUWlD2TEsz30cU7IWfnJDipCEsKqPr
	xcgIMIz0/YhS03V6k9yxgKzV17IrlM0d+WFcwUVhlEWiZ+hu3uN4C+/YTjaV1oufssqKgIcF31a
	sghEc9B1ff6W8C0j3OSfeRFP2EkFECacyfQo+9Lk5y8WomvetiS4ElHvGpY4=
X-Google-Smtp-Source: AGHT+IG7SUvBAr+wUgtbHBw+Oxg+gB1evsRB5uNc8DXrFPfL/dtJA+WA4Vhe1S/Uh0H7t0i2UnlTyqxLkW8ZMA7JMMToS9zEaSpW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3c04:b0:3e2:98b8:e102 with SMTP id
 e9e14a558f8ab-3e3455b6f39mr94390345ab.18.1753321978450; Wed, 23 Jul 2025
 18:52:58 -0700 (PDT)
Date: Wed, 23 Jul 2025 18:52:58 -0700
In-Reply-To: <68811963.050a0220.248954.0005.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688191fa.a00a0220.2f88df.0008.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [hfs?] KASAN: out-of-bounds Read in hfs_bnode_move
From: syzbot <syzbot+41ba9c82bce8d7101765@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [hfs?] KASAN: out-of-bounds Read in hfs_bnode_move
Author: lizhi.xu@windriver.com

#syz test

diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
index cb823a8a6ba9..58c5cc7adf70 100644
--- a/fs/hfs/bnode.c
+++ b/fs/hfs/bnode.c
@@ -134,7 +134,7 @@ void hfs_bnode_move(struct hfs_bnode *node, int dst, int src, int len)
 	void *ptr;
 
 	hfs_dbg(BNODE_MOD, "movebytes: %u,%u,%u\n", dst, src, len);
-	if (!len)
+	if (len <= 0)
 		return;
 	src += node->page_offset;
 	dst += node->page_offset;

