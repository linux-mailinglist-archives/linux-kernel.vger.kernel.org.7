Return-Path: <linux-kernel+bounces-838663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 363C7BAFDD3
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 11:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B8097A2D38
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 09:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187232D94B4;
	Wed,  1 Oct 2025 09:30:08 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FC52D8795
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 09:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759311007; cv=none; b=Hri/gqF2H76xeVc9Z4CZ8FT8gc/NTbGrXKvLVb57qkggplafL/xr4aHHMvuc4ViPt4nvdfOHORIpnqMVyR4lZ7D/1MYEUH2DRrGIX9ZsT5LsUWTA9ocN94IWkoSk5XrUdYhV4LP2V6Fji/EyLusGc5jxi1833pB34CraiI929Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759311007; c=relaxed/simple;
	bh=7IdksFICc5IuOWEXd7aUzwYkTHW+Bmy8yNN8EQFwoIY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=h0ofJ4+O1JtescPLCFbs0i3MtbXfmr7E2Z315UM/14hQVc4nl5TZr2396/w2Is3NTvj0D0eo3D12IUl96b296pJMwzxSjQ54ymRwGy2vZq1/libSy053uXXbmiJJvz7xxvuFKTbaAkU+Rf1/zeX5RySJabodVuKfvIbAl5n8SNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42575c5c876so100138205ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 02:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759311003; x=1759915803;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qeL1halpTk1lPXz1iLxLY/NDHJ3J8ZXOjg5TCEIi5Dc=;
        b=gw6Crv9XxlKQxesHIybaB3KOTMK6Enwd+Oslj3Ei11vGK6+BkTboBhvoNkf+dK8LwQ
         DqU3dsmd+lBK+OSvW+FnrfJ1oBOqBpCsb/ZzCxAL0cuNuvWu+8ezB7KW5KmpXg8dGkha
         24ied4AdzwKKgn0J8Jx62crydNBOCYqcUr8I/wbdnQAC+OfMo9Bg2FtWFJkKjQcoCxAN
         X5FUf9OXaxlOJx2aaZbnk6bJjZfBaUp82WO2IBZkHz5NsQe+yhJH34XMppyDWowIUwhT
         XkEqFmdKCoH372iMwKSlpQeT9W0CRNx7uOxAeD9U7l/WOn8lkN3/SoQlJY2OcchxSMPJ
         xrOA==
X-Forwarded-Encrypted: i=1; AJvYcCXwnT8kkS5ImWzEb2Z7q5/jdlyz9l1fcCCmWueCimSC01889bFPvEhZ1ctu0iepZZGs65LXeXCQmQ5EW4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgJBZYne32BQjVEUV2MPTk/w6vHfz5CY4n6d2hJiH/yN12YJ1w
	LD9nz5FNxrRUpoEWRHacj6CK4pwvoYUFDAYzK/eArSI0FMi+fJo3GiO2XgGRhbaUK0kmPN0RhVH
	EcYqNJ94PGJVbcHttIm3qY8Icmn3RFalU5LCTPBIgFeAUMtbWZOW2nwz2VZo=
X-Google-Smtp-Source: AGHT+IFm5GqoDeqx08yXxQeSmC04SdpI5Ytia/nKRuqZWzVfZXUrEWpdnRj38wlMGuS0R4OVPzsSPLEgB5xsSfsL8HXJ36sIVqoo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a26:b0:426:3ab1:74b2 with SMTP id
 e9e14a558f8ab-42d81664ce3mr32362935ab.16.1759311003261; Wed, 01 Oct 2025
 02:30:03 -0700 (PDT)
Date: Wed, 01 Oct 2025 02:30:03 -0700
In-Reply-To: <20251001085853.1672001-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dcf49b.a00a0220.102ee.0055.GAE@google.com>
Subject: Re: [syzbot] [isofs?] VFS: Busy inodes after unmount (use-after-free) (3)
From: syzbot <syzbot+1d79ebe5383fc016cf07@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1d79ebe5383fc016cf07@syzkaller.appspotmail.com
Tested-by: syzbot+1d79ebe5383fc016cf07@syzkaller.appspotmail.com

Tested on:

commit:         50c19e20 Merge tag 'nolibc-20250928-for-6.18-1' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1172a334580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cfc4e6ee70d55834
dashboard link: https://syzkaller.appspot.com/bug?extid=1d79ebe5383fc016cf07
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=129e0a7c580000

Note: testing is done by a robot and is best-effort only.

