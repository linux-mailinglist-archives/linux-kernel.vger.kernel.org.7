Return-Path: <linux-kernel+bounces-888308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B7511C3A783
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 12:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 974A6500300
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 11:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09042E8E09;
	Thu,  6 Nov 2025 11:06:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAEF1E22E9
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 11:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427165; cv=none; b=qJnjc6yqmUaw+OGufmHgxy8fAPCrEsbPjahQchnLPhnF/OXQhZGLi+62Ayajz6OFmFSBs+gHCMsXDBpwM64dtKvLB+1sHR55FLsJQIeGInLfsJFTmgYpQgPlzCcqxXAoj1RIUL4FitDV2UkdOfStMlouzECG9PVHN8v1M6Ixq3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427165; c=relaxed/simple;
	bh=MDxxMhIORU1N6H7vl53fjvMx/eCJgCUEAWu06Xd4fyo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TXEm61Xrq1Vbgk52dj2zS3tmb+4l/VLi9AQC/GQrWIby0qfUinTqPOTiyNI7OL0Yrs14iaqmZQoNX01HGDDIAeAq3t9bU4gx/E5dI4AmaqDFgKZhF+fyCahUs47h1tLSAb3N+XBZc7Xpmh1rgyZRs7l8fmNsvMEGcmy6gy9FjuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-43322c01a48so2052845ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 03:06:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762427163; x=1763031963;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7YLmpBcJQQJc3uvBPyux9aBsbuqfkQpqtFUsIwakHSk=;
        b=dHjXrHS6ORlIyeUIMlyvEGBpzwDYAZspzXcPlzNaN/6NnltCTOj1ELSY+Q8MDaJXBm
         FdTGksQCHNSipmx3Zjo5oNSGBedYh1KUjPy+/S5Oi5N0MMXmIhe3RVlOKCcmnOO6eiY8
         RCYQ1XGLqQ6h31FO1quKf5heG+ll4rgJTFqQ8eFHbpiFTUi55c7Xs4Y+Pe+z/Fhye7Ej
         mI7DK4/7cu21mjgI0x79/b5ZtdtV+Dtr7AQs10/wqWey+rIkZkF6lszB/Q5K8KYhj3vl
         jvAS79rboTMvLUaAke29YMiWMeup39B5wQxdqppsa78WKGlbsEUMqJUq8sJLA/kNA+8B
         52Ag==
X-Forwarded-Encrypted: i=1; AJvYcCXLZyIS1tK9WgeoDCENNPGhxlN7lJdyUptABoNE6Q/bU6Isg2j92inJT9I1IJ+54U00/SgpB0bfvQcoScs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA7DOAz884cHSulFDaLbEWqF9lP6Ex1OIKtEHrMjxkxmuBG5tw
	pEkHkPG+B0kj7lMNvipAR1PDtVilGDeuoYwYeizGt2BBGyynM7RGbcaPbFM8TK8D06DR6PFEUTG
	+pdR8+D+ViXa/ojPfncG6aOeUsXysIzLiELfLg/NRTFsvw2HWUU8B43TIpBs=
X-Google-Smtp-Source: AGHT+IE/u/KUDmfVhtAT+bF/JPkOxMXgQqhGjaEF35rveLN7I4NxGZIDTM47S3PtW6CsTFA7cmt9IEyen43RF5wsFZCo3/mO09du
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1567:b0:433:2400:2eef with SMTP id
 e9e14a558f8ab-4334ee78384mr39296765ab.13.1762427163097; Thu, 06 Nov 2025
 03:06:03 -0800 (PST)
Date: Thu, 06 Nov 2025 03:06:03 -0800
In-Reply-To: <6774bf44.050a0220.25abdd.098a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690c811b.050a0220.3d0d33.014d.GAE@google.com>
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in filemap_map_pages
From: syzbot <syzbot+14d047423f40dc1dac89@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, chandan.babu@oracle.com, david@redhat.com, 
	hdanton@sina.com, jgg@ziepe.ca, jhubbard@nvidia.com, kas@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-xfs@vger.kernel.org, peterx@redhat.com, 
	syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 357b92761d942432c90aeeb965f9eb0c94466921
Author: Kiryl Shutsemau <kas@kernel.org>
Date:   Tue Sep 23 11:07:10 2025 +0000

    mm/filemap: map entire large folio faultaround

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12658532580000
start commit:   b19a97d57c15 Merge tag 'pull-fixes' of git://git.kernel.or..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=292f3bc9f654adeb
dashboard link: https://syzkaller.appspot.com/bug?extid=14d047423f40dc1dac89
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12399442580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: mm/filemap: map entire large folio faultaround

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

