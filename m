Return-Path: <linux-kernel+bounces-722436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACEFAFDAB1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 974643B40E6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DD2253350;
	Tue,  8 Jul 2025 22:11:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2748AD21
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 22:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752012666; cv=none; b=lI3luEyqpZ4NS4Gsef9C2VP2lbie8RR3Z8XgnzhNvyV3QUGcVtdk1R43Ua6eADqhgev6UbEDxoL85s2XZusO7HLvl1o4bjDGfKPJjq6EZN5SkItuABRNNoB5LL4DNSn+/ppgfxMUTOnhr978OMOO38dh3/Yqadxn10sEr2AOza0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752012666; c=relaxed/simple;
	bh=KXDA83ZiDXISN4tZBtQNbfUmGJROqq3LQYJ87Wpz870=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jSkf6aVb756InPqpE95kP5QjXrSD6MByyP5nRyGHfnpnm53YBgHSdUUZA8b+Glp+sfUxxpVe5zuteETvqXZEn8rpCRexo3/LEX0NAl8guMkeJkIIemF1gC4pgHAt1XEU9i/dyuoAE4INglYlx0S9xVtddomZr07MDVGkhf4a2Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3df33d97436so4377095ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 15:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752012664; x=1752617464;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IbxIKRYiLLlWIozFDG0FU1H875efsEVNFgyk7i+C5sc=;
        b=tm9nSDmeNRMksVx+s88rezYIE2VHMMzuPbse5DtsCHJHlkzvbkrrph6ByFiPI1DBF6
         Rvao2jm0RN9mUYv292Auq9vM/GcnGR8p5C1bV/BVKTC4safBfrs6mh34QLUWbpT0rkVm
         SC1mw71rQ3WmSxl2kjvXz9nzyrCvKUyKjljkK/d80lDBJuv4UVr01k7ZvGhCC2pEmG8O
         J5fS7SeTX+90ZFpQ/CoGCeBdYWqVwT0GkU4bNbQxJL6Z14yTNE6hpESwxUdGfEvsibca
         YJgNWRBa3y4+exshh4gANybAreEXyeqWFd7MIrv4Di9LZFTJHSVq/pwjQUdjoyyHKbmz
         0wTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOQjAzHa2mYObimXNCP1o+pKjT5LCD0Wgilj5aEuEUDDATQhQq5yJKC3xi68+4ERswJNlD0fTfd2iIVHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrmjWRZ3RuuUh/qQPorhpmr5MxHFPDsQ7x/Cxfbf19vqR+Ye6f
	j1hjnnFjeNf47sALe47kkwAfdpooXFI3aGMeMVO/IZ+MDRmdwZTIUrimFAFEGfmjdLkuyRYZb/F
	qryxnSxvtIBFUIQgM0h1/sLHsxRfR1lEdFybOdFdx3El18LeQbhv7JoMrWpI=
X-Google-Smtp-Source: AGHT+IGBSDEPV7Qs0MTDCe42aw07FiTwokLQKCj/RmSQ+xcnhy82G/Dqlo3GGGcVJk7at4VE7sVJSLcP4Raz5WJB2Bm6SpubsqGI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1747:b0:3dd:bb7e:ca89 with SMTP id
 e9e14a558f8ab-3e154ff233fmr49433975ab.10.1752012664123; Tue, 08 Jul 2025
 15:11:04 -0700 (PDT)
Date: Tue, 08 Jul 2025 15:11:04 -0700
In-Reply-To: <CAF3JpA7yXEB_Fj3AMtFG1OYLX2g9P3LFQ5f3qSSEcheB4axVKg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686d9778.050a0220.1ffab7.001f.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in ni_rename
From: syzbot <syzbot+b0373017f711c06ada64@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	moonhee.lee.ca@gmail.com, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b0373017f711c06ada64@syzkaller.appspotmail.com
Tested-by: syzbot+b0373017f711c06ada64@syzkaller.appspotmail.com

Tested on:

commit:         58ba80c4 Add linux-next specific files for 20250708
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=122fd582580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bac86b8500d50c98
dashboard link: https://syzkaller.appspot.com/bug?extid=b0373017f711c06ada64
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10dc6bd4580000

Note: testing is done by a robot and is best-effort only.

