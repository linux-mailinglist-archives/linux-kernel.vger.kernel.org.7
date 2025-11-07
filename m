Return-Path: <linux-kernel+bounces-889579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6D9C3DF44
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 01:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D31353A7E76
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 00:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E973421ABDC;
	Fri,  7 Nov 2025 00:12:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0961F2135C5
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 00:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762474325; cv=none; b=kpbtP1xypN/iRxUTvdEUK56IKbJEwJu8ZMByeQ+KhRhMb7cwFpPjkINpJCmQ7VONExPGFUNq5HFgj9ehv/cEKDK0cQ/xFpGAkFnWJbR+Tr2O6F6u8RQKllngdaI7l+o865bSL+dK2IBrO6RF52CsFD2uEcrELjiC9E6RA6/mEGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762474325; c=relaxed/simple;
	bh=aVdPYmzSKWOH/QKiXcBzKUG/kuPP4RUbIPFsSXqcIP8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GmzP1UsTdSltud5m6KUz2QxJe9aZOE0GB4+jKhrjCVYDJ1hKq9XAdCBsFobHT2Yby/9EiblBTL1gb51SPiyWYBevW6JmI1g1i0kKzHLsNGDxr4/Mys/AqvAsQ/gEz62Q/EpN6R4FzLQa2zDjgin8nLgTTj1A4mPXNlFva19/CU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-433296252f8so5879765ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 16:12:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762474323; x=1763079123;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/spXl3uuTsx8sDbawOIWZLwy7Gm9R+Wn63YjTrF8mdY=;
        b=WIMHx/IGrLJNiUhk3GPGxkX5D5rI3Ygfmz0SF9S1T6H196qQTGO8k4ROBIYN85CuK5
         O1sCpQ0yIWhurjEmspDm9sj2H9aSlz96mwxhXh+8CLenbLWiz6ice5SkAuFQoA+aWGTt
         GwwSxV6UDslbAbp+0G9X15uVkPueKp1R4+ECYHn3hrP4wGkFugnoaJU+R+bxyr+NvynR
         JVQquxgDPGrfAGSJrBlvP9flNJpXucutgiY1Fr6stRNsTXf6973CFXcbn7OBA05NeMJ4
         mdYMSChcZaGSVhpjLDLtR38fTf7NEkBiSBtkJQk78zho9k/9hpFkT0tGDolvVCFh9B0b
         cAYw==
X-Forwarded-Encrypted: i=1; AJvYcCXCjhvmTCaXf3/ASS67ubOsixbCsDM+TNYCZWzPsxEzm8JsmfzppTBAD+CxQXSmNCVqYiJ7F4d3wrqTUnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ618a3ZLci8tvLNRNScItsuCyprsBzueZubIhtHDYDnFAk9X0
	tGldq73thxpOIFktmfAsP9rAYUfL/b2JAAIdo3QdEZmQ8NRSSZYYvTXKcGPKtpWLG337UI2KGDr
	h6gwnJhLNYEXKFzhlas4OvpgWXnIkSpB3FMcUAxB0NeIt65oLpKw2aXrP5fo=
X-Google-Smtp-Source: AGHT+IHpSZmQHjj2xw1LrKSeIaGiCVAzshnJrIOP1c7YWbQBC1A1pEDfCWPYVr4zh9uN5K/DzxzgdlImZ3ehmMsUuPeiL8wG0i9C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:144d:b0:433:4f9c:96a7 with SMTP id
 e9e14a558f8ab-4335f3d09f6mr22415875ab.10.1762474323196; Thu, 06 Nov 2025
 16:12:03 -0800 (PST)
Date: Thu, 06 Nov 2025 16:12:03 -0800
In-Reply-To: <20251106235128.8908-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690d3953.a70a0220.22f260.0011.GAE@google.com>
Subject: Re: [syzbot] [sound?] [usb?] KASAN: slab-out-of-bounds Write in copy_to_urb
From: syzbot <syzbot+bfd77469c8966de076f7@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-usb@vger.kernel.org, 
	lizhi.xu@windriver.com, perex@perex.cz, syzkaller-bugs@googlegroups.com, 
	tiwai@suse.com, tiwai@suse.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+bfd77469c8966de076f7@syzkaller.appspotmail.com
Tested-by: syzbot+bfd77469c8966de076f7@syzkaller.appspotmail.com

Tested on:

commit:         a1388fcb Merge tag 'libcrypto-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1581d812580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=929790bc044e87d7
dashboard link: https://syzkaller.appspot.com/bug?extid=bfd77469c8966de076f7
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10ae2a58580000

Note: testing is done by a robot and is best-effort only.

