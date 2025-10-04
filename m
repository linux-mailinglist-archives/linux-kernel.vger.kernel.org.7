Return-Path: <linux-kernel+bounces-841882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4124BB8767
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 03:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A6584E176F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 01:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6002AE89;
	Sat,  4 Oct 2025 01:04:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79CA34BA22
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 01:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759539845; cv=none; b=dgCiRNinnfwd0qInH30tTNPK4rbb1Rithu7QZdg1sA20v62KjLXeTQeIpOSFoPDjtAa9G6vnX+WWinzofy8biJe32sivcN/BUrDikeNH95oLDjuoNkURKcrGoHawLShn8yFvU4+60MnshDtluEzWe2XupbTXOcfllTHx0rRtOrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759539845; c=relaxed/simple;
	bh=SOcgETh5xeubM838LXHr8nv9pfekOTux79h+0vKGLd0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HbMWl+Atha4iu/VVTBPo4uqPkONW6DRocgfKPylGZxwgoS+RwQHNpY01UyQQtVGlSekdoaWHfYj9ntkXnA14PbOMTsWtHa21rC+Sm7na4cIQJRwMrDaaGs4xJ89sjmcxMwDFMEpLP7zGTYrxwiGuH1Pfl7HCwbUEjK+qQRwp+kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-90efeb58159so353467439f.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 18:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759539843; x=1760144643;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HBSZwqSDmh1BSWgw4JtT806Jg7bQjBuA+gVX18qZT4E=;
        b=B0+23akZtnVSQ+5rWSi1HsxTxQzfXOThZO5Elge/QBPi1A6srsRyphjn/hyREre0au
         8G+/80sNL2YgfQ3qxzzAcUGfnQ0f1ahU5lqbQU+9VJT3F2Eq4JemEgdNqSmdaATPJu/m
         9l8VMLXXMpy/4ERnh9EaA79P1DdHfX6SIQYoQimAjCZsNVW6kSBRv4ULsXmdoH+VpCmc
         PkItjAsqnA8bQUagacmYEqTGoEhhxWMeyKGJUMpUcSP2l0clT8Q7OU/wRDYXypASHoEC
         OzRC5bKdlFbbQ6Cg8YUu699yIxwn9JQrsTbJ9QUGkd/FQowcPNJ4Ku3oZKVDFasNafjp
         mM7w==
X-Forwarded-Encrypted: i=1; AJvYcCWIb+krLlZLVVU1x34979oY4bEiNvBpAubTBxo2wNePpEfWdnh1z8GcTcEhDlHEMc/qZiYycToNYYBj2hs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIR+Vrnb8fiRNqu4vaf2UcbyISxIqZhAzIzsw9PhzdUimPDkVT
	5Fn0IZ3IMcsMqNDnMjq+jyhfFRSUPI/q6ww5DoheBGswhHefANFhocy5pvaJbYG5Ld/sqJEk6EQ
	8gURb7MzoXSd9uQWPHaKaM9RqYvXiazJAstZYH+5gLy+TRkXAAy/J7yWxEbo=
X-Google-Smtp-Source: AGHT+IG5JM3/o6FGfsB9hA9pW+iiPTtSAdodFWPBkviXe5k4KQ+1mesDPtmy+8ZNmTIw34B4iexXbVyss3CJ246tUdhyhjSRaavg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca0d:0:b0:42e:6e3a:3075 with SMTP id
 e9e14a558f8ab-42e7ad84876mr59415045ab.21.1759539843090; Fri, 03 Oct 2025
 18:04:03 -0700 (PDT)
Date: Fri, 03 Oct 2025 18:04:03 -0700
In-Reply-To: <68c6c3b1.050a0220.2ff435.0382.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e07283.a00a0220.102ee.0118.GAE@google.com>
Subject: Re: [syzbot] [fs?] kernel BUG in qlist_free_all (2)
From: syzbot <syzbot+8715dd783e9b0bef43b1@syzkaller.appspotmail.com>
To: bigeasy@linutronix.de, boqun.feng@gmail.com, bp@alien8.de, 
	brauner@kernel.org, clrkwllms@kernel.org, dave.hansen@linux.intel.com, 
	davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, hpa@zytor.com, jack@suse.cz, kprateek.nayak@amd.com, 
	kuba@kernel.org, kuniyu@google.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, luto@kernel.org, 
	mingo@redhat.com, ncardwell@google.com, neil@brown.name, 
	netdev@vger.kernel.org, pabeni@redhat.com, peterz@infradead.org, 
	rostedt@goodmis.org, ryotkkr98@gmail.com, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de, viro@zeniv.linux.org.uk, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 3253cb49cbad4772389d6ef55be75db1f97da910
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Thu Sep 4 14:25:25 2025 +0000

    softirq: Allow to drop the softirq-BKL lock on PREEMPT_RT

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17566a7c580000
start commit:   7f7072574127 Merge tag 'kbuild-6.18-1' of git://git.kernel..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14d66a7c580000
console output: https://syzkaller.appspot.com/x/log.txt?x=10d66a7c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b78ebc06b51acd7e
dashboard link: https://syzkaller.appspot.com/bug?extid=8715dd783e9b0bef43b1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ba76e2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17741ee2580000

Reported-by: syzbot+8715dd783e9b0bef43b1@syzkaller.appspotmail.com
Fixes: 3253cb49cbad ("softirq: Allow to drop the softirq-BKL lock on PREEMPT_RT")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

