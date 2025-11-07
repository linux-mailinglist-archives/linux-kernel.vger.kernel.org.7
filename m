Return-Path: <linux-kernel+bounces-890826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 502B5C410D4
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 18:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3057189625D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 17:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF63334C24;
	Fri,  7 Nov 2025 17:36:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E323224AF7
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 17:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762536965; cv=none; b=XY4zCJ2NBzjwbJ/1ZB8Ip8IGzoH1ZPHJPbrxBspzMdqPJFBBhIHKV90/bWXeAfD+DDYtnHNfVYjM793AVD8GSyEDAIPp9Wam0VFZf7ek/d23V4Ue2KbhIRoBdswOaogRhNG3/XyPs2iD7pk13E8acW6Y4G7ro1jOuD2d5dWdh/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762536965; c=relaxed/simple;
	bh=hhcVNclrRlDWdAyMtcmSMqqrVt/4rtKTFpnXfMnqtjU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=II+g78mNWXqOLs5+9pzkxR7jCwn2hItZEy34vOyz2+/ehOtrGUAnHEkpdYDhtlt36Oejhgy4FhEQvSPFghziDKY1qVdf6gBFQ7GGWCF4NStdqQ5XXDKrqeVQI5E2KZLXK+VLHVA+z2proHooP/wEK/d6koa9GDCD21jTtAYCLus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-43330d77c3aso33032635ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 09:36:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762536962; x=1763141762;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QLosnNpzKxnPjxB45qBPLE2C54FnPBfHn4s/OTYMrZg=;
        b=n2EjCxM3EbhzmwddhZq1i031Ef+oKAzyMeLxidGUJ/PsFUMm1Xw8SChXLFPOcnf7vr
         eFvkOO5d7gR+AzjTA7z8ITRWTm9UV86oTZ4d9JwbPKRqTASGJcU5jeQ++FfuTaPQNZ1D
         mfd6C7hluWE5eeodtmwVkt1vud3ELkCIxEPP0rxr3qs6TcrVRRG1xP3kuTwUYNIW0pwQ
         EjnB3nM4Iwlj4FVcoCi/9/IgflqOGUabr6UqhGRkArXk9VsQbQyQz7Gd3ZqlD8jAr3qd
         +//5t6UBffxMnuJywi+4XmRQTM5wlvUcJtrT9r71zrJrR1Zh0HGXL1eJiOiUCPF57ZCD
         ubUA==
X-Forwarded-Encrypted: i=1; AJvYcCU6t14b8uxxEU1jD++X9Cw/uBYOsWbiqx29O6PuV15vuivIfOJd99OHef3BAly1qBzGILUk4XAnUhsV3GI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH1f9nifkmw7H7XvakJAzfXyx2EUK1DHO1sJG20Y01gH10CgHl
	WElwxUNHAMYWIoZtTK8jb2PmdjsbovqSicuKEtxQ7C+7Yjx5zyou0MEYGnViTqcVUYrvjzYZkQt
	i20d6JYChi4UtWh0MBGeCETYf0QIHwyyLOlxJQk2l7JHC5heAAM0/DJSJnCk=
X-Google-Smtp-Source: AGHT+IFDqUqSlStkyaedPPL2C3W3wSzVF71mP+wrY217vJHYhzaI0hjbVio1OQHGcx/rf9iS2CXOqzyzLIbhwAl75zd1MnnmKTtF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4c:0:b0:433:5736:968f with SMTP id
 e9e14a558f8ab-43367df3cd3mr4953745ab.13.1762536962654; Fri, 07 Nov 2025
 09:36:02 -0800 (PST)
Date: Fri, 07 Nov 2025 09:36:02 -0800
In-Reply-To: <CAJ9gUkF9p18DjsCWf6yatsv5jstKbUx_PcqdgKaHk1bs5XxfKA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690e2e02.a70a0220.22f260.0059.GAE@google.com>
Subject: Re: [syzbot] [scsi?] UBSAN: shift-out-of-bounds in sg_build_indirect
From: syzbot <syzbot+270f1c719ee7baab9941@syzkaller.appspotmail.com>
To: kshitijvparanjape@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

././include/linux/compiler_types.h:603:45: error: call to '__compiletime_assert_1195' declared with attribute error: max(((1UL) << 12), size) signedness error


Tested on:

commit:         da32d155 Merge tag 'gpio-fixes-for-v6.18-rc5' of git:/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=40c8b8384bc47ab0
dashboard link: https://syzkaller.appspot.com/bug?extid=270f1c719ee7baab9941
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16cd7012580000


