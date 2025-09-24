Return-Path: <linux-kernel+bounces-830428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BECEEB99A22
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAAEC189A71D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1A82FF658;
	Wed, 24 Sep 2025 11:45:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E432FF15E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758714306; cv=none; b=AS+D5uH8UDAc1SfFe9AH6uoh/I0Y8491hiFTIbd+mqif3DTOpOvs7vAIH+fzjh75MkQgYmCVyH2HATLi21iVNzs1Pz4nRjfacWIOzNevaTKSxD19/0RPuP/PnEkzxaTcF1PDhzNSzeUm7XwdnSYZ0dmPuDgsxbNOIWGEon8ivEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758714306; c=relaxed/simple;
	bh=Yrcsd8VHASCL7kovs2Sev744mIde5OuCkuRno8k+M58=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Jy7JDf5lgAx2XQXxxBhumB67BMKN/rxkeFHvQBdZqd+okaVH7QpBBj0gFGG2EPSRoOE0NJyM033j9u/lFyMcedy8jCqWhDPWJDw8eRh2z94PGRvZZ+7Iupssy4PJDUYAaSQcAAecxqCTVcSwgEUvbNFBSipf8cjxDhTHDOpnUdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4241c41110eso170648435ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 04:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758714304; x=1759319104;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h6RUhjeBg+r98dOkWbUuhcNQsS5tfRdJADvlJXhg/8k=;
        b=HltjjQlOk1vgLabtwx9396yrUwfLpSeifBlRrxVyQy/osBaYIg0DJmFBMEoN+ISY8B
         Bic12z5X55k/GoCp4NmjWRPrX9tMvpDxVlyIHT3vEavQJrGM2vINuOYC77lJZq6dGnLR
         56w4S5E/FP4uoEemo4zWFMhfgiWLf20K5SzSNoaBYTmb6bAoHMQy6dik9jTYrtr6ZUZx
         NQN8ZzKdXUtS4iTzbbT7yR7fuhut8B3BukreCltDMTsslT32xTZP0oOq1MKDefHHhfEZ
         cqqk37nTekZU2lnqkfkNJjuukq/n1PpmSrJUoMGQhjbybEL0p7tORY5luEZ5XbRlGjJV
         hxbA==
X-Forwarded-Encrypted: i=1; AJvYcCWcCLdWIxfn5vO0Q2LMRHG9wdyh92HGXNBcreq9ZD4WYljDdh6M5/w5CNHy85aGRmFgFii7olHbZJPxMzE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6H1yEzOagTgxedZhbu0dSUt1NpTnqE8j7wnf6D165IOmo5pKu
	0On7rG8rWJJjzmu3qrN0Y1xUjGdKXZk3qAq8HErpbs7vlwgRiUSqCgbgOc5cqv0ODx1whExJb6z
	RObM3DgntOBeu3+/3QdSIVGdzc1kAzkrC+DXI4z5il0+GaGJ09gZKOjgIlgs=
X-Google-Smtp-Source: AGHT+IE8U1UAVT6NFxguD6FnZmPOF/KR+bn3/Mwo/y9/atBxlVWBtz2TFkyHcYt1SfGp+OQ5z/opiRm0rdXz+U7xXbntVNEbA4QC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:194b:b0:423:fd07:d3f6 with SMTP id
 e9e14a558f8ab-42581e7eb70mr85643375ab.15.1758714303742; Wed, 24 Sep 2025
 04:45:03 -0700 (PDT)
Date: Wed, 24 Sep 2025 04:45:03 -0700
In-Reply-To: <tencent_97B86EC86EF2CC8B67CDC6C3D2D9C6754906@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d3d9bf.a70a0220.1b52b.02ca.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING: bad unlock balance in namespace_unlock
From: syzbot <syzbot+0d671007a95cd2835e05@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+0d671007a95cd2835e05@syzkaller.appspotmail.com
Tested-by: syzbot+0d671007a95cd2835e05@syzkaller.appspotmail.com

Tested on:

commit:         ce7f1a98 Add linux-next specific files for 20250923
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14d0a142580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=91ae0b9529ab8226
dashboard link: https://syzkaller.appspot.com/bug?extid=0d671007a95cd2835e05
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=174f2142580000

Note: testing is done by a robot and is best-effort only.

