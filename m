Return-Path: <linux-kernel+bounces-754237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA890B19058
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 00:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA16D17BDE3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 22:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078272749D1;
	Sat,  2 Aug 2025 22:33:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48505134A8
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 22:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754173985; cv=none; b=IUoqmfu1QmgfIS+OIzyhCn3T6GTvMOH+sc30MZm1lA2Jll6P4mhTFkSubGWMswxqLqKGd60JM5PoI9oc58xMzeaeU8jQ21YDD+RQDJwcRGNnTOUQQAvmdTGHZRp6UW8slVxLDj/eJtYeiwzdnyDyeqrE8qEtSAEjAR244ZJqj+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754173985; c=relaxed/simple;
	bh=PnmMZ++thId+hSIX9J+iI9msXwzPmd5WxYeS/UyTV6g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QSYq/OHIyTkRU3tQtgQoTxLEAvLwhdfKVM9wfZNQWyRaCtqFrPbgZmnzUlC5WUVywh23OOdliyHR05Bow7lMvhSntRUjVIfhOearbbQyktXNUAn4iHBEUob8K4vsUBv/G0UKH+Wj4zZkMhTDskwXNy1M7mVo1vXOhj+QR+sP6P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3e3d462b81cso28298735ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 15:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754173983; x=1754778783;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XmhbiNUKAm2HKOYAA3geJm2RFvyymJDVeTOJRwpZsNw=;
        b=YIEpbxnOUN+Xfp1LtiYUtRZzVVNcKh8BCgjE5N47kwsCveCEfoblfufL3QGHFinyy1
         BapwShJbt5amV92UV+gUTVjFJME3dT52rjJEtUDPiJxgp5oqHFWd4pcQQhPS8GbNTbHz
         EkskdEibcgOlYlv/ynIQU8KaMzswKEGQhzo3MdYB62nSOhF/TdWGuskqYEnV8YmzBQap
         17QIxxwHXuj2SCVS1qeZUfVa16QriM3Aorzdb8NpVSy0tjB0MrYUv4+HuBpLmDB29ejO
         S1McnUeIBNDUj/+Irr+LC3bLls+Pfo+LtbVc8vrpnfmlutXuAVpvUnmzfLULtlqYeEJ/
         t6fw==
X-Gm-Message-State: AOJu0Yy/naH+8x8Ljb1KOYmsAJT51WJzNqRds0tz3O9DathafzYWDdKO
	Koc7VpMUKnXYY88NhMBQVqR2dMJ0wskSsn8ElKZnoZ7/LBG/fNOSnsA3IkDS/j4Vnt3zqkflu+2
	csfqQQYqG+xBqcihPgjBoXwwHdtEY0uvdp4MX911e58WjwDXonxFUvp4SOk0=
X-Google-Smtp-Source: AGHT+IFPwkp+crqmGkkIz96SGhW9pwjSanj6ZVV/7ujTYi6XaV96PgIkwR3giC9t4b49Bshy785mnKQvaDOz/mmK1xRfSUYedC5W
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b0b:b0:3e4:117d:68b3 with SMTP id
 e9e14a558f8ab-3e4160fb7a9mr88462735ab.2.1754173983476; Sat, 02 Aug 2025
 15:33:03 -0700 (PDT)
Date: Sat, 02 Aug 2025 15:33:03 -0700
In-Reply-To: <CALkFLLLFkpaTLff6E4wUA-fYBZM69u0azLF+frYZrf9eSuRzJQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688e921f.050a0220.f0410.0145.GAE@google.com>
Subject: Re: [syzbot] [block?] possible deadlock in __del_gendisk
From: syzbot <syzbot+2e9e529ac0b319316453@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	ujwal.kundur@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

block/genhd.c:743:19: error: use of undeclared identifier 'set'
block/genhd.c:745:17: error: use of undeclared identifier 'set'


Tested on:

commit:         186f3edf Merge tag 'pinctrl-v6.17-1' of git://git.kern..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=921f306d77438390
dashboard link: https://syzkaller.appspot.com/bug?extid=2e9e529ac0b319316453
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=120b0aa2580000


