Return-Path: <linux-kernel+bounces-843210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64713BBEA22
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 18:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 606D73C0FF7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 16:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3130A1B0437;
	Mon,  6 Oct 2025 16:22:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206B32DECD3
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 16:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759767726; cv=none; b=nMGXhf0UVx3TFk1vztLCnJeQ6apNspiyH15aRMe52dCXuxc818SaIZD4irGP6LtPKifk30sLrHuykL6e8jT3cykHG7YmNQSC/Lo8jRkLr1PtnahaD7y5IgFDTskm7gUvVhx5nRCHPje8SKUQ8QgJ3ffmNvu+pNIx4nJKIKSPBx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759767726; c=relaxed/simple;
	bh=Ee/+ABuJh94CrA02HDb+n4dQOWB1lmoH2fOtBhVyoO0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=orwR9qBrVUoTucNihH4FfWbdKmyZCjr71IP1v0vhRqbDqqAggIOOdIedBawA4Wmvbnds7pUeogVYNG41AMhgYKSu7B1KRN/bWpUrzQULKn08qdxumoMppliYiitncbqKudQ6YPnInX4JQIuPLAI3Dy5XSJXjyofvovkkTpQUhTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42e71d1a064so52521515ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 09:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759767723; x=1760372523;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WA/rCoVPUBAH5k3/VcJGnIH9X9Oqzz4FzqkB4ychuLI=;
        b=eooUEjhjJ+5dKK7RKfuc2so4I2rvzCj2EJFvofLCpeqdiuPG3+b3FwSji6ebos4S00
         qAyTWwLOAS1T6b6ukUhe8slYHF6QcsTkQ+DcMqLDaY+Pw9gt31pwSmqcl6ED9v0ytSGj
         iE1++UEsW51M5NVcY5XlEG9UN2RyFrYQNTqsSklOmoOOlBumS0VHa+HsXZd9m9/v3pab
         EQJJZhPPPbZe6Z8sWUf8+L4Mz9+QutbMORDLnCbykbumduy8suqbiqXcE7fLDHugBcXI
         RingtGWprBGtfbfB9C3rnv0c+hlnoWUEhSnGyFb2ZqVFbMA37I9NYV0ITcrBqgGbUBkk
         hNbA==
X-Gm-Message-State: AOJu0YxVyd5mqWwfe7buu0O05n49dq6Bupk/EDbUC00Fs+ur+g6/h44v
	v3wdm8L3hpabEeMOF2xIo+mW9fJI/LTFZKhXHyNmIzcDqboVZDnvvk/XC+DA2ozTOCoT33HfoBc
	yxO3DxdZnV9hYS3wnBH5O6/AHCrd661uYYrw6fxGAHz//gsKOPvhRSoiippE=
X-Google-Smtp-Source: AGHT+IGTCRpwpICDbBCsc1a1XItHF13cLHkF9J7nZn4P3X7Pr5bgYw/WFyU7CYFIoVdh9ljAk3gr4gdtjOo5UzF9/u79i8/NUZng
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e8:b0:424:1e39:bf0b with SMTP id
 e9e14a558f8ab-42e7ad0acd1mr141239165ab.8.1759767723171; Mon, 06 Oct 2025
 09:22:03 -0700 (PDT)
Date: Mon, 06 Oct 2025 09:22:03 -0700
In-Reply-To: <CABGqKE12ATMeEx-EasTDyV-pQK9sLKKwBjhus7bMUNgRM64o_Q@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e3ecab.a00a0220.298cc0.0464.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] KMSAN: uninit-value in attr_set_size
From: syzbot <syzbot+83c9dd5c0dcf6184fdbf@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, nirbhay.lkd@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+83c9dd5c0dcf6184fdbf@syzkaller.appspotmail.com
Tested-by: syzbot+83c9dd5c0dcf6184fdbf@syzkaller.appspotmail.com

Tested on:

commit:         4a715314 Add linux-next specific files for 20251006
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15612304580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=78e3a0444ed8b621
dashboard link: https://syzkaller.appspot.com/bug?extid=83c9dd5c0dcf6184fdbf
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16e395cd980000

Note: testing is done by a robot and is best-effort only.

