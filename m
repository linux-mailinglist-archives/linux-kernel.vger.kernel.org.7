Return-Path: <linux-kernel+bounces-783523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E41B32E96
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 11:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A0A017199A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 09:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DFA237713;
	Sun, 24 Aug 2025 09:06:15 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F60922AE65
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 09:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756026375; cv=none; b=DxE+WZNJWZ6l42wNZ69fUlQkeD6Y50YUJo0/fTubyVq/72xlUjJS4KKZYTsBxWSPxaQxJdTewoe5g4LmxC9FLkwVThSKn3L6vjpqD7F5RRSOLzrA5IkMUzR+49ASsUpv5rhDgy7ESIk8/Zn7FXqsEWxezDfT+hk20NSge68tGLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756026375; c=relaxed/simple;
	bh=N4hhKefvyUDBQqQSEiLmCKfrRisbRJekjvt5u3rVYSU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aU7NeduksitxDrTORXFWAtOV2yPfER/Zbd4NQKC2/M82wIN5pX5ZwcRb3iFWBhuULr02HpDQCXCYkP3q16tq7FKmOdcDVKnbIGPPS+Rbkq/DSNZdCP7d+Cy6gySHsbUa9Ns+tIiRwHPpGQLhmPY7i9O/AngErYAx+k6RxvniqV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-88432d9d5c1so368547139f.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 02:06:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756026373; x=1756631173;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N4hhKefvyUDBQqQSEiLmCKfrRisbRJekjvt5u3rVYSU=;
        b=FhChKoG3H/qniWXbVpSiRkWOz8mrfMTUnFZTgQxCDu0QVGbYJjLN6dtQw4gWEr0aJ4
         siUpPHlANQYVsIdTSlSldfNrCRHsqqyfW8LJ7Y5ZdT+HXmW+KQDTl147/UXXVrYSve7R
         ZHZ7HdXGZ99gw1dMksxSHlD1R58hAAI/SFIcaY6YytxYvwKy/VQhhAnTJjvKy05XyqEt
         1w8ByEEzDRvaqxw/X1u1Vg71K7ELLb1N4J2DQyGhzMf1Go5mhegqqgrmmGoeQdocMq8X
         ZrlzYaa7DcWxSd0dVih6DdV1tBk+R4xJ8aFn1Me88F8oB1IwQNACOuwToesoXGjwvTcS
         mq5A==
X-Gm-Message-State: AOJu0Yw9FWRi1/NgwGRiLYsrMQeDLeGW0ng+KIijWJgbJt4n/pTgnaOE
	utwQFIM6jy/xOVSCig+dFljjiVM+NtbKFGU6JAb0+0ZFimW59RwfDxbULQzhO2rrUTVY+HtEZ3q
	wnKKmDJqp5agXJJKhGbSvKU2XB9MEgWrQ7QzhdBMt0LZM+faQov+KKOtQvjs=
X-Google-Smtp-Source: AGHT+IFs1WRnIkwqcEZWk6eDaG+h55z+C9i4tVlwoTXwSD/qV9sR0RIe9zWRGFcBfkAd2hadDe+oVLfpty04KrATycEmLzEu1MRv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd86:0:b0:3ec:7e74:36c6 with SMTP id
 e9e14a558f8ab-3ec7e7438dbmr3854495ab.0.1756026372840; Sun, 24 Aug 2025
 02:06:12 -0700 (PDT)
Date: Sun, 24 Aug 2025 02:06:12 -0700
In-Reply-To: <68a6ed12.050a0220.3d78fd.0021.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68aad604.a00a0220.33401d.03c2.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [netfilter?] WARNING in nf_reject_fill_skb_dst
From: syzbot <syzbot+b17c05ecb64771a892d1@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [netfilter?] WARNING in nf_reject_fill_skb_dst
Author: fw@strlen.de

#syz-fix: netfilter: nf_reject: don't leak dst refcount for loopback packets

