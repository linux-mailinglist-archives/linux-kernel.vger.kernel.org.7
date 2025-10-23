Return-Path: <linux-kernel+bounces-867645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C36C032E8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 21:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95EC91A65A47
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 19:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6B634D91C;
	Thu, 23 Oct 2025 19:30:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3B634D4E2
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 19:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761247805; cv=none; b=iD2f3eYSpdnMW9I6GTFF1LBYP5mH2FYGNG0nPT3F6MUeWYgneVgvtaxUpKYZg93hnKJefryN/RSGvTOEpn7BZP6o8t0O5Pwr4/Q3i6yPl4wdyZid9IbzC73k5TVvWuIUbBFrl6Z3HXon6YaSmfyOl1ivd+GG02PnbApT0So8bZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761247805; c=relaxed/simple;
	bh=tOwPbnAxIcisvw20shTxZzzq63lsPFNjZHsmqCSJq1I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Cb43D3LwIeE5+XH5pkRokitogVXVTdqbrMPdZ4zHkNs6QBcaiFx2jhLcYePSYEDqhA6ZBAKy60PfQv++O1yzus4ZXT8eWW67+rjnrMcRTT58VoDTJ9aDD1QYdUSOKF8u8zPdjHAsDEvyLEPENDBgHAhuffa1I3yg00SsVmbv/9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430c6b6ce73so34766345ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761247802; x=1761852602;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jAyL0oJs2yHnkUAJXTr3P8wcSdnTH1GzJwJA7jc78E0=;
        b=V8AGt2UQ2LJFwtSBPNFYOw5ENAbrnw3gafo0qQqVE+hjC3in6Hu97Z+muCeBOZQOFe
         KJtbLjgFPV3tAGl7UvUTxLjX2fqC8KxIHKFV0+0vxvoWPxzwvJhuTrIgp9lNUL0KofHf
         NAxY+jpMlu7h+WM0DPW1J6gLuabJ0w5AWf3fASH1mUvam9BiBGOP5+RH7TzuLigeGPDb
         ehW3F2S9oBqrHIkZvJUVk2Li5tXaF59dLSTIJwa+6ONeEkEn+pDZ1h6Dp+wwvRwUwjUL
         TP1cwvP4jnL9Cv0aRQAYgglStMqIVrINpYpwQcATci8a1THXxRQh1aFPa02VhHP2iMeO
         Fltg==
X-Gm-Message-State: AOJu0YyjuJOmXUF3z+SXR1TYdmEVTi1qo69pQYjD5JQ45cjIdCZA5zUi
	T8TYvMLHUY4L/RBFnJJrrO03Z8GQ8JaI5nmrXC/Fr1gJNvJTLuYmpxpVIQhWinXc1YMFjPKqK8h
	UrFEP8W4bKFbZvxaKZfCZQG7kujWG91j1X5N0i2C/u3DrDbqJRa7ZKgTxYH4=
X-Google-Smtp-Source: AGHT+IFLbG5qxiXV5NdVJl27UdeSeZFgdbXQLof1s5oRAdRcc82LbJFeZgGrm40VTUZ78lMXCyR2weHNwyhlszCPAWv8H9+ET6SR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e06:b0:430:ad98:981b with SMTP id
 e9e14a558f8ab-430c520929emr308960785ab.5.1761247802109; Thu, 23 Oct 2025
 12:30:02 -0700 (PDT)
Date: Thu, 23 Oct 2025 12:30:02 -0700
In-Reply-To: <CABGqKE0V6YyycVUXMkOK8vQGKeuF1Nq5ddu_RbiTaCBmpxtsQQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fa823a.050a0220.346f24.0082.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] WARNING: ODEBUG bug in gfs2_fill_super
From: syzbot <syzbot+19e0be39cc25dfcb0858@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, nirbhay.lkd@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+19e0be39cc25dfcb0858@syzkaller.appspotmail.com
Tested-by: syzbot+19e0be39cc25dfcb0858@syzkaller.appspotmail.com

Tested on:

commit:         aaa9c355 Add linux-next specific files for 20251022
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12430c92580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23800dfb58d22855
dashboard link: https://syzkaller.appspot.com/bug?extid=19e0be39cc25dfcb0858
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15ad2e7c580000

Note: testing is done by a robot and is best-effort only.

