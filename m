Return-Path: <linux-kernel+bounces-887142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4A7C37604
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 19:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5D3B3B6AFD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 18:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E928C29A300;
	Wed,  5 Nov 2025 18:45:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E7629AB02
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 18:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762368306; cv=none; b=TW9lwHgaCzmUMyJaBnMBNEo1VrXNhvFMRrX7AuU1J95hvbwYW3fKnY2kQ23ehFLk4GmFOMKzrfEx8u66FfyBZKwcY79YweshZ7J2JvEy4oFZjPLPDu2FFJS1aWVm2fMcWcKFaMX0uXsxGVqGOiXyMzQSetWXiSY01xc8U3CKljQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762368306; c=relaxed/simple;
	bh=q54dNgo6K5UOR96Tf4ngFctDUlBxCu8oDOzaeRNHx90=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=m9sLR4cs+HJ6KXiitomdOSji4hy1CMMigny8Mw6jwchGbE5QCjOj+fV5gIyFudwpIms02gYA0BpGjLZ7CV4pztZZ0ai3jc4nnJ8pSe3Ir4CPhH9p8VvLPl9tK9pLG8vHjnS+8BwfvDFvL/nRtvqmlJo3Whv6iEYpfXVP08uZ9TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-93e8db8badeso7533139f.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 10:45:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762368303; x=1762973103;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kUEEF9SSZgYEPSraNuyYiMnRT2c/zWLiADfJil5r+dM=;
        b=qn2CRyGcasly6hnNce7WVYuf0tO6ljU07hLSxFl5SHpaWjUf87ELEEDYwgYvhGRVwT
         vB3Ss5+AGbo+4U2dV7ME+tM83z84GCjD2vkbtULxe+mndXD6qzUEiGfiJqklza9zE751
         xqXyIxzw9bQttVKtDPjMASARfABng27G4T9Ytu00VGBcrKyzxy188ExfphaKCg/ZWw/R
         HyVPAEvkNnhCdeyfcvVn27XlHIOWzrivUI7iJWYc5sR3he2mjWUs7bIwnnQqs+cQtuPW
         cwyd9NFDo7nvqTm3leq25+GkdonJMtQQev17IdCC8gGbnlBj0wKEF2cbRUbSJSxrVNFW
         4YWg==
X-Forwarded-Encrypted: i=1; AJvYcCUFeWnSmp6NL37O4HoUOrwe1cF0taQ+ezYVdTkuuOOa4yI9DvNm1tEWoxBifSVvnTi5WlALLVSvrI5YzD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHvAP8VWZmDTJuWZCyn0ZRTIeb8P5RMfIObq4f00ar6/xvaFIG
	5KyoI6F9wq+jfKoU4ZiK8wNitzILD6HWMjTlAGf1IWox/ovPYXitmovc6VsYVgAmvEvSxHY70zv
	wENpivTYAavreIGzlDX171Inhf1/v1DUdJnDNjvV0O6Ikc6QXn/lxzWkKnag=
X-Google-Smtp-Source: AGHT+IGPswf6wkub0m8m8oViVUve53pMcZxJyBV/j6u5WHYHxMJ+7d3Fm+Z1EWlLj0UpTtbYMLUQG0aUogTnwoxo9dk9bTbSzX1d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2b13:b0:945:8eeb:14ab with SMTP id
 ca18e2360f4ac-94869e2265emr657047839f.9.1762368303030; Wed, 05 Nov 2025
 10:45:03 -0800 (PST)
Date: Wed, 05 Nov 2025 10:45:03 -0800
In-Reply-To: <c2d8fc24-08a7-47fe-8f68-cc9bbe6c55a4@linux.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690b9b2f.050a0220.2e3c35.000c.GAE@google.com>
Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
From: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, yanjun.zhu@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com
Tested-by: syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com

Tested on:

commit:         1c3df6de RDMA/core: Fix WARNING in gid_table_release_one
git tree:       https://github.com/zhuyj/linux.git v6.17_fix_gid_table_release_one
console output: https://syzkaller.appspot.com/x/log.txt?x=10908532580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c614fa9e6f5bdc1
dashboard link: https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

