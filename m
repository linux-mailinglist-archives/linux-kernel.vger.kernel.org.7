Return-Path: <linux-kernel+bounces-849031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CDABCF0AD
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 08:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E82BA19A516B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 06:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B601821CC4B;
	Sat, 11 Oct 2025 06:52:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED513D6F
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 06:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760165527; cv=none; b=uUrJWQnWNNc7wPd6y/ljmg2PlzHqwPQuetO1PnfJ2Hl9Hx1q0q7zNy6E/D7Y1oN8hwvDuw8EKSGPxCli1GzKYJ9BaFDseUX6/ZFYBcVSHVxZscVAwvrhkXua5gnfxl4Vy/x4zNqj0xTe2h8SENfMrQk8RnZC9r2VvUuaPdZA+3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760165527; c=relaxed/simple;
	bh=hQodxI56GXZhXXsn1t/LSw5kX99EnYpr7QJS/GLaz0k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=V/tTMiUnC/7VkpdPDlcG3suhpPum145S5ZnMrSnOHSmpgvTKOwfI9R9G2iXeychx4wrTBBt+bQD48RB+kEhPSsbDHOuF6cSIGB1+j6mX/u+yJXjAoHyD5HWRvYO+Cf54XCNVegqx934KLKlx6Z+uLV/yKswUVKuTyv56d/vO1nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-42486b1d287so220887975ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 23:52:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760165524; x=1760770324;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JLm7A6hf1W4lXH1uuIDcogesc/sbx+V1jAWgILy6mCA=;
        b=tkS9TdHyvjlASyFVrBU0vC++d3TOKOA09IdrWGustZYQt32LhKiG/a8ZXm81EJfLe1
         Z9MNuPpC/+Wm13UG8CkByHKvFqwqgACYZ5X6aKbGc6l4wkguZGRBOeaMRZZKtytoQLev
         tpvs0hXQfa+n56L6SEaNYL3mo6Djmf2lE3kRuvMGe2iUrnMc0cxVN4tMZa5v7LXDGb54
         g66NBfGakDIGW5GwxhCcSHjykHmOhaM9tndObvIrovGLwEIpCyWmKQyPPMNaLKHk//8l
         CFzGsez2mh7CbCj13tw0Qbvlfz+6Hq365FETL3rWKh9HfVmtmOaTJn8BQdLGW8FVj2u6
         qH4g==
X-Forwarded-Encrypted: i=1; AJvYcCUJwHK2UQirDncWu6xsLvGGTLnBIdao8iz9SqTW3D5RxBtUijy3x+L56wJn8se2p9n07qIqJPv1k6cH+RU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzseSIUXmq9tdumBDXXkSkoXdipEa+QmG/6F8eqLsgiY9SJjjh8
	6gZbOHm7JdOPKBFptzY5/AyC76m9e+yiLUYGbVolhIRRPp1fd1No/tzTqp70LDfKLSKRIxAdScZ
	c0ccRu8FNwMCvhxPpdkBIQB4NGdEw3AG74V/CsiTrHhT3ny81cI/tQsVJNCA=
X-Google-Smtp-Source: AGHT+IFoeXimuKuU8VmJ8GaCureNJChkiLIhKaffDqOxisGeqWHM1vEKnXovKi5m+rBvCpqWnERfApUHoi3UR9YwEf/+lZH0kUre
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:270a:b0:42e:72b5:f900 with SMTP id
 e9e14a558f8ab-42f872c0da6mr165813055ab.0.1760165523816; Fri, 10 Oct 2025
 23:52:03 -0700 (PDT)
Date: Fri, 10 Oct 2025 23:52:03 -0700
In-Reply-To: <CACGkMEvXKYK2tWs=XuM9L=SzZfPwuiKPpd1CpBQq9APJUthRuw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e9fe93.a70a0220.b3ac9.0003.GAE@google.com>
Subject: Re: [syzbot] [virt?] upstream test error: KMSAN: use-after-free in vring_map_one_sg
From: syzbot <syzbot+ac856b8b866cca41352c@syzkaller.appspotmail.com>
To: jasowang@redhat.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ac856b8b866cca41352c@syzkaller.appspotmail.com
Tested-by: syzbot+ac856b8b866cca41352c@syzkaller.appspotmail.com

Tested on:

commit:         07394736 Merge tag 'for-6.18/hpfs-changes' of git://gi..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=60ff1a9f60b0f77d
dashboard link: https://syzkaller.appspot.com/bug?extid=ac856b8b866cca41352c
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11361b34580000

Note: testing is done by a robot and is best-effort only.

