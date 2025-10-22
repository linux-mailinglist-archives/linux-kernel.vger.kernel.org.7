Return-Path: <linux-kernel+bounces-866010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26155BFE987
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 01:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9AD03A5F8E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 23:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5339B2C86D;
	Wed, 22 Oct 2025 23:36:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590A51F4262
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 23:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761176166; cv=none; b=Txo3l8Gf1WMdYGo/9dlomvERMOmVIIc3FTcZg4CbYGSqL8qaClJNmPKtPe8x6TGr7QmZwP66Ojiuk/DHU5EP52AeMkyrz4cqBoFnwavHAmxVMuTZTPtRNe8w8MyDVsFhir5Qp4oubGjjB0hryHdDEXz4HMYDBoFfOPb+2Buuieg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761176166; c=relaxed/simple;
	bh=xfIHxZrokgkU2Dmp7imnhABH+qNhSC9oFV2rCkAHbWM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XXY2wkB7YQkfVo2ZcocGZ1+3v2XtVgyb1MNtVziulgrmzl2y0djEADRKKoUrex7Q8aPHUwttuSvY7QccNN6TmbNZMyZ66rtFEtCRq7ytkKRSzXKsciTQqH4ycr3th9OMGEHkIkgSSxq0PHt6S9YpkKnyGYGrjIKzzRSyCjz/Wr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-431d8643856so9602635ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:36:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761176164; x=1761780964;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ugav9BXtkgCb2+s32kw2iT+Z+ALeZu9+3I1xCg6t/Ag=;
        b=SBPnFh+2Hylw0FSuUNBr6dzr892kETG+wFNhQnvhcoEhkiXNFP9QcBBgx1xX3KHlKz
         Gdwx9ZOUK1Yi0/yCgIEud/S36vR17s2OpvKUOSeVBjHSDInnvRMkSUGPr7Q/f59ln1I6
         jVlU4OIXN5XbZwgwIOnNAeypNKeMA+fB6063udQkRsYeLiqDCXaSdFgpiAHcnIvl26E/
         SplMWKyNBr7Q48+h6ioPUbay+dsTicR36EkhXu6fFH2yugMAdzfif1GKn80U2GGiVOKX
         rp5D2FlW7SNSOS3BWP8ZPmElzOE2mjROhU2ihgyBiliuMGnHYlbJURaOWwfU/BXnDcoe
         L0yg==
X-Forwarded-Encrypted: i=1; AJvYcCW9MPlAnGk1GEbq1XUFz9RyxOVJPgiw4ZsDxlNlRyyl7ImR0aQuqt8PK8vTO3eJ85UeVUlhK8qe4hSi+fU=@vger.kernel.org
X-Gm-Message-State: AOJu0YylDfYHZZkn4BOcFNgiq2vOmoAr3JUjFqet/1Tz5ahnqegUb6t/
	pyFRiBRvt9dAtXr42YFaaJ9C5M2vxnghBu+E6XujQXt9uzB+jNXwHJn++ZyI8SeYXXUD1Oj5CgN
	r6GNMK4QDr812AIR9UlSDzLoy23usQprnLAcusTYa+yZ8sztc1wd7zMgg0m0=
X-Google-Smtp-Source: AGHT+IET8j0MNTy7o8WRp1UuO4fezmvpM3H1sVGt2IHquYvYTweldSFTLNoK+ngVur6DV509C5JsygPxgKvLFCa6q0fyJfJL9CjW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3d87:b0:430:e5a4:6f33 with SMTP id
 e9e14a558f8ab-431dc1e26f7mr8773965ab.15.1761176164478; Wed, 22 Oct 2025
 16:36:04 -0700 (PDT)
Date: Wed, 22 Oct 2025 16:36:04 -0700
In-Reply-To: <CAHc6FU4_mSRbUxKJMq0e-UObNGu8Y3sVk-mATwgJ76B0+o_+Jg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f96a64.a70a0220.3bf6c6.002d.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] general protection fault in gfs2_thaw_freeze_initiator
From: syzbot <syzbot+18b8ec796f5bcc9ea482@syzkaller.appspotmail.com>
To: agruenba@redhat.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+18b8ec796f5bcc9ea482@syzkaller.appspotmail.com
Tested-by: syzbot+18b8ec796f5bcc9ea482@syzkaller.appspotmail.com

Tested on:

commit:         a7f1196a gfs2: Get rid of had_lock in gfs2_drevalidate
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git for-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12c0ad42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79f8c6bdee6738c0
dashboard link: https://syzkaller.appspot.com/bug?extid=18b8ec796f5bcc9ea482
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

