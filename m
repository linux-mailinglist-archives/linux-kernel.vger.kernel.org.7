Return-Path: <linux-kernel+bounces-730920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FC1B04C75
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 01:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5524F4A381F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 23:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC87622F76E;
	Mon, 14 Jul 2025 23:39:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A1C2561D1
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 23:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752536345; cv=none; b=p4abatdLBWOQt44WWkaWVjftf9DtorQIIDbihUTQegpc9Ir+tR555DfIq/Epr25F52Q/1aIWH2sWFIhzfWHRf6MKo4092Qp2r7vcdphP31afD3umF4mJ4m8F2S8SmL0gok6gxAei2IxHkVu8Jufqw2KS6wL19V13BSq/5f2sapE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752536345; c=relaxed/simple;
	bh=JA7JIyohv6KpJIi6c3GqiTQVtKiGdSnXxxLH47r7J40=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=n76hKpZGayAhrFdWUJqXuxqCVr5WlTPAHbqnqL9iiK4tJzo95AL1d95e6ltukPDf7+1zjBa4hXKjTlQeQtKBrU7rropBB/CiAGJIrGtHU+ck4f/MhsO6DNStJrerbPhHXTcWQPOQgLmn+8gaJ6URVQ9ybg075uXoTYqZ+v7+syA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-86cfea700daso455028239f.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 16:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752536343; x=1753141143;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s/pz0JPSLrwcXULwEX8WsSET6ZklGL5HqsXo8ZbZ+FI=;
        b=qU6eUL+G4w5SRjtw62tBtNPhk1tnVjasL8XGOxOG9ac9u4wOudtrPrd32Co0SDeDkT
         moqev675vLEHhMAPceRqTSbOhw+AnwSrSpSJOMwb+B/hyqjkj1Gp0Nf9oFrPzKJdPCeH
         BoQcSrZf3DMc2RLmwOsStt16MtDA4FGyAsHG458csoNQHCuCS4H+/QFsagmuwEgocAK0
         H8hoCCbwWXJAffpFjODAXiIxlRhLy2ScJ0cxkRPgychpgiRW3AIs/TqjJZPj261dcAE1
         I6Wt161cGzOYP9C8qoFW74d9jWKlKSxUlxDL647f+GL0PHGtwE7Orb6+6vEwLqjeHsvG
         kqPw==
X-Forwarded-Encrypted: i=1; AJvYcCXYO6Zf4h22z+FRwT6TzdddBJbD62N13qB2/Jju5iHBwl5T0E+WhbGFIq7yThAytcCcbRPg6S1oATXHzoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwokgo6+8w0KfnqnGd2HdJ7upqcKsbgwis4j9ldii2cbqG87CJ
	I1paMJpQtOa5fDLDaFZbtjrP0uFc26ZvNlDdogpOiPuou1VWuZuqwDD4M46ZCJcgnT7Ys/RL7mq
	1bCzMyR/ntiex+lZAi0I2dJh+OoEh3Qos26wrejnck5zxSjvGYVbCFemIdpI=
X-Google-Smtp-Source: AGHT+IHNPx8IATVQPVtElxwALygbQqQ0jiz1LbPETazjmI4hxou9gdLHNtXOyxwUb9iJ/3mq1wLYBv977x2xRxgNM7Tfid9P98bc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:7402:b0:873:35c8:16f9 with SMTP id
 ca18e2360f4ac-8797882781amr1362237939f.8.1752536343204; Mon, 14 Jul 2025
 16:39:03 -0700 (PDT)
Date: Mon, 14 Jul 2025 16:39:03 -0700
In-Reply-To: <9008807c-58c6-4b2d-b227-545882436ec6@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68759517.a70a0220.18f9d4.0010.GAE@google.com>
Subject: Re: [syzbot] [cgroups?] WARNING in css_rstat_exit
From: syzbot <syzbot+8d052e8b99e40bc625ed@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, hannes@cmpxchg.org, inwardvessel@gmail.com, 
	linux-kernel@vger.kernel.org, mkoutny@suse.com, shakeel.butt@linux.dev, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file kernel/cgroup/cgroup.c
patch: **** unexpected end of file in patch



Tested on:

commit:         347e9f50 Linux 6.16-rc6
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=84eae426cbd8669c
dashboard link: https://syzkaller.appspot.com/bug?extid=8d052e8b99e40bc625ed
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16e3fd82580000


