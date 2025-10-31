Return-Path: <linux-kernel+bounces-879355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5FAC22EB3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 02:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DE15B4EABD2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 01:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B071266565;
	Fri, 31 Oct 2025 01:51:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9A225DAFF
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 01:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761875464; cv=none; b=hKZeRuNAinVQ1BGApJZz9NZB5EsoennDdPnCexgoBu2mhYtMluvwhPtfujdZPRtaw6ByzEa0Jw1OeCn8m43Q0wjaUTo4UQBZyDutCWtRmXaWHWIOOvNaNCJK08ZLfSsLpFZXDrYCBu7Gi6yGASmLhbp27BMmJZugITWITYySSOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761875464; c=relaxed/simple;
	bh=LSRLGPJueQvsaaMr+T5kVjZzLY/Fd/DaoGNn0pULWME=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lnw6t8bH70ONWU4+TTXJspzlG6CiLbtRHXfs5qBb6dwdkpMim2pah5B6lEE+Cn1OHTY5Z5yRsG1Mxg/7hCGxJ/kZennI/tITz4/wF4XeqnNOU45hdDt3vQ1JAUbuYe1+52/HfS4HBeEBdnZn0SZDb7ffiPb0ReZ7viCJ/G9DPYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-43300f41682so18574955ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 18:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761875462; x=1762480262;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wRXwkZoSwVeNxvrZi/Q06t3VEhjxwv/14vBpnToGkqI=;
        b=FRwdDg+39FC1m10i8SM2y71NfAHwHO8GKiQLTlWbL1nWMNRTleGUM6jGzUuDoFSXUT
         W0A/g9aTGXmmT0KvSaGAcm4tWaNoMYVA3B798qKLZFoDvyuhteuubU1pPa4GTlUyVLTW
         C/iTqtnYJkZMBERWLkJvnWAHmfLOG+7i5OLaNJxuU0jKzNevldny17+IeFb3GGO50X4T
         Bh8Q+AZ14jHPyYGY97Obn61eYLqwEn+4CGbDf05DNwpAKA21CI4W0e+tSDuHy+ijO3sz
         /WTdWx3iAwWVNKKXRvItOS2Phb+jElUS7gjB15mQ4ndlJyDeLCbyiPbt7wAQkVq716Eg
         ZEIg==
X-Gm-Message-State: AOJu0YyapePL8ozkfAiYvPg9BwO0etMlTx7i5GEyf8jG72nUuZbnFKBs
	3Jo3jetGWyUF9/BPO3oj8/kQJOgY9A+vwsWTDU9MI9xKnqBP1Ft7dWrIlhbWtMTqkmeZTxHHRqU
	fFznnV31S4fem+FeeHGI54QI4oLUyXYTdsqV5Au6/ZZ7lfukUPIGopUuUw38=
X-Google-Smtp-Source: AGHT+IH0oZXQ8USupQjTSgupHwuZ7DVv4N+hjEbIpsl6Z6A73yyNihd3kVQiHWggtQ4aGs717bSoNiFMUBgnayqRWjxeX7lSKzSa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3303:b0:430:d448:eb41 with SMTP id
 e9e14a558f8ab-4330d1ea0e1mr32793735ab.31.1761875462552; Thu, 30 Oct 2025
 18:51:02 -0700 (PDT)
Date: Thu, 30 Oct 2025 18:51:02 -0700
In-Reply-To: <aQQLJtqY44w1iD2b@orbyte.nwl.cc>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69041606.050a0220.32483.0233.GAE@google.com>
Subject: Re: [syzbot] [netfilter?] WARNING in __nf_unregister_net_hook (9)
From: syzbot <syzbot+78ac1e46d2966eb70fda@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, phil@nwl.cc, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+78ac1e46d2966eb70fda@syzkaller.appspotmail.com
Tested-by: syzbot+78ac1e46d2966eb70fda@syzkaller.appspotmail.com

Tested on:

commit:         12a7c6a9 Merge tag 'nf-next-25-10-30' of https://git.k..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12f74e14580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5683686a5f7ee53f
dashboard link: https://syzkaller.appspot.com/bug?extid=78ac1e46d2966eb70fda
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11b3cbcd980000

Note: testing is done by a robot and is best-effort only.

