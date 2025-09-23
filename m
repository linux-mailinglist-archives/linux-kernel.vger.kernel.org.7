Return-Path: <linux-kernel+bounces-829279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0F2B96AF5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C28CD7A5BC6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F1627EFFB;
	Tue, 23 Sep 2025 15:58:08 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5806D26B2C8
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 15:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758643087; cv=none; b=qTXOocEaAoGd06KrJCFLVhBf2sozUz3UBh3hgnlihSb3lSA+mBBtrDnY+9AcJfKdJG6GjEtoQe26REFqLGhp7SYDb7FwXIKJICv3SVxk26KGeanhitTJzYL/+UxoH0GF+qgO3V7J//hI4A3aIKdU9He3ggVygrc6yVontW6QFJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758643087; c=relaxed/simple;
	bh=woAIztdjnkWsI3kG6tkhBOkZyi41NDx8CF2CBgba7ls=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TxZzPlV30fWMvJSUDWupRVrFP8gIapnh+ZshRLoygEsIPv4wbuLDOpxn50pPZXGrvXkPugalqRc3C+qNEzHGkfT/qfFqY5kkgNFIVCQlomxGr/67caUxQp1RJ55c4q8QcIwJK/MjZwP+Z8ak7byD6fPmkY6SG8pOmd+JIHHpA4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-4248adc62e0so45853955ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:58:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758643085; x=1759247885;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8SzN1hJ9zwcq7Owdef6rySnxXSj+9v4/sJv1hYSwlPU=;
        b=p6RrOJNQa5g5EAIywL3fk2JCHptVWXtc3llLAoUi/XpIZIzp/6dFQDtM2wseqR/F4b
         HUKPwmhVW6lP6qNI2JR8lVwD/QtDO3qGJzm3Bb7uJcWi94utjbArNymXCyUhtXeQ5++Q
         a5DkREQmddQnYaikS9WGKKRT0ippxo+jCzjWaGUyeP1uIgZGucGYNcwvP2NuR8WSqm0h
         71XQN82QsNGKmH5FEM1dHczyLtGkd9wvJU2Gw2ctdLEnz/Uic/NMI+m+2KOADnHfJsw2
         leGTwi314Y6n9uY27SbuavP7EpkxJlP8xiLDKlCYwwPw/VkSkTs/3Qwc4zadRPqFdWST
         oEKg==
X-Gm-Message-State: AOJu0YxdLUF+RO3jbizxsDJ6FL1WJ8kp7T9kkSYQdFtnKsTwCIaOJ9EY
	Xc2ZZ/jIxWEkSglIAkv5RdwAi7a9tSEN6nWEqxf0llTUVhLPGmI0iaVKtJ9xE+7Ph0dmlakX/qE
	axnFygoM9VDP/L2wV+AwjOVpJGJ4jp/mXeBopB7hsV2glsLFI1AZiQfBc180=
X-Google-Smtp-Source: AGHT+IEirHAKO/fIIvLt6n1d+84N99C8JIGGh9EkTd82VtjDX/5bOjLRyzRkotGPArRQhsA3sznS3gFkqQfiz+PkFxeaWadEEj6v
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4802:b0:425:8ac8:f594 with SMTP id
 e9e14a558f8ab-4258ac8f6c5mr6490605ab.16.1758643085456; Tue, 23 Sep 2025
 08:58:05 -0700 (PDT)
Date: Tue, 23 Sep 2025 08:58:05 -0700
In-Reply-To: <CAPrAcgPeCYaif6SrZxQTg82A-BRK8aJ0uKU92jPuBzh_VaPubQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d2c38d.a70a0220.1b52b.02b2.GAE@google.com>
Subject: Re: [syzbot] [mm?] [net?] WARNING in max_vclocks_store
From: syzbot <syzbot+94d20db923b9f51be0df@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viswanathiyyappan@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+94d20db923b9f51be0df@syzkaller.appspotmail.com
Tested-by: syzbot+94d20db923b9f51be0df@syzkaller.appspotmail.com

Tested on:

commit:         cec1e6e5 Merge tag 'sched_ext-for-6.17-rc7-fixes' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15060d34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=595e5938a1dd5b4e
dashboard link: https://syzkaller.appspot.com/bug?extid=94d20db923b9f51be0df
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11c7b8e2580000

Note: testing is done by a robot and is best-effort only.

