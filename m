Return-Path: <linux-kernel+bounces-802664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DFFB4554D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0195158221C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EE030DD21;
	Fri,  5 Sep 2025 10:48:08 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753712E8B85
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 10:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757069288; cv=none; b=lKic29SuD5sny9wN/MatbqOe/loVD2ccmj8iy9A1GCX2i8Q3NjhjUvJZz93cl3eS3xbTMS7XzYsUZAmyX20MyhVHykm/8kr7ilEO/oNEkyMpMbXSoOSet/oBaInw3Cieku2s0hvGKYnRgbsBfUKmbsop1CFT/IGs9KnBFmVOMKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757069288; c=relaxed/simple;
	bh=NmYKRAAmq6S9/OlEpo6/iUNc8QiidY1CJ9QsoS/Qjik=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bBNZEwx/yqjQYeZMAmpVHWBrCFnz7ndIB+1q8gEJ3eMdmcSCPNVUpF5lxCj82kJ+LhqxVsJvc72PS7whRg4MviqwnONqIan+WSihW5GwnY7UCAxuWRl9vH0ZAINyOhL7R9rUmliuXVH47h151EYYgBVXjf3usA27LM9XAwe0LT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-886e347d26bso264875139f.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 03:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757069285; x=1757674085;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8rYsdGmrF6iYwCUNd1971cTTtCRjr0XxFrK/sEXkTUg=;
        b=kHbhUYU8BKHUPiHOwzHJ1W6vcDg3w5ATkWgRnxZPUYj/n55C0OkasfKYQNK96BTQJ4
         me+8ywyTXzjaibN/zmlOl5Tv7HKLWc69LKrcCNuSVyn5xwNR/QyjbmcOzZ7YGJS9fpG/
         fp84qI63TCFp1Ox5W2bvxIZUnWwsndZefmb22ErGUamrmGK/QdMBNmjN6Heb50GMVMtl
         BnYhAw+ts2Iwi8DZeBsMxp05JFYJ1q67ck3ogfG3xQQCNoKRRs/MiMntrxyWQq2nTslN
         pcytoSIGzxjBpH3YsBVdCx63ldyOAGDcZ/0c5HGHLHjfM/QsJhEQp/8tDomyhk62grfV
         UfPw==
X-Forwarded-Encrypted: i=1; AJvYcCVsF+WiWzNVLkgWLIdQslYxhTX+vJvxpbl3NbOm3g7KNKpslDaD6V8qPZeTO76As3ou6xvs3/ULA94HHdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpiQzVrBcI7tN3NBTa5qNHNQZ5vIPJLZ3h+Cqv/OxTDl2SBJYk
	DqY0YrDlkZhv/SM1I7Td+QsnbZ8NWPRhv84mEfEK4Nbf+WCkNOwqLGLFLanJkHKPWOrwEaLI6MD
	/Ly1lITacTMr4aQ1DxYhRkIW0NGPzlMom0UxbfBHkaSFxRdfKpISBbNngAww=
X-Google-Smtp-Source: AGHT+IEEVqzPOhxCpPpHKlGrgT5f2MUOn4yyJ6sp4ZmwI2NMNbAtYmdpd/SxIRa4CgBpUT8AHoH6G+6763nAOE2lWUYDoaq6eth8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:486:b0:883:fc4a:ea55 with SMTP id
 ca18e2360f4ac-88767e26eb8mr470147239f.3.1757069285644; Fri, 05 Sep 2025
 03:48:05 -0700 (PDT)
Date: Fri, 05 Sep 2025 03:48:05 -0700
In-Reply-To: <6177c4fd-227a-4dc1-89cc-eec44300f6fa@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68babfe5.a00a0220.eb3d.0011.GAE@google.com>
Subject: Re: [syzbot] [io-uring?] KASAN: null-ptr-deref Read in io_sqe_buffer_register
From: syzbot <syzbot+1ab243d3eebb2aabf4a4@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, axboe@kernel.dk, david@redhat.com, 
	io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1ab243d3eebb2aabf4a4@syzkaller.appspotmail.com
Tested-by: syzbot+1ab243d3eebb2aabf4a4@syzkaller.appspotmail.com

Tested on:

commit:         bfd07c99 fixup: mm/gup: remove record_subpages()
git tree:       https://github.com/davidhildenbrand/linux.git nth_page
console output: https://syzkaller.appspot.com/x/log.txt?x=15a5a134580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=366a4ffc91f4ab4
dashboard link: https://syzkaller.appspot.com/bug?extid=1ab243d3eebb2aabf4a4
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

