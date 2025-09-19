Return-Path: <linux-kernel+bounces-824825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC074B8A3A6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E21A5A1464
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82A7314B9F;
	Fri, 19 Sep 2025 15:13:14 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083BE3164B5
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758294794; cv=none; b=d7aKPvumwKHwRJP7PF+ykoRCNyD5mTqbTivl4+TYM6xSjqDMbZO0L+6+I+KNLTyOu0PwJWEtkxSuFOij3GUYICz1ct8CmT98bPKaaARe/e9Q8b93p/6X9Cu0zjV/1P+0kkMlyRPH2Mbwy8czAw79ch54WJR3lb/REcmBGPU5uXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758294794; c=relaxed/simple;
	bh=Tt+hRZooDzLpwPZoAJVDMSCHMuIqNfWoy/TUKxU2GfQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Kke2QLslH/ng0ULZQIE+g2MahLMfHKGPY5wODefdexrrPy0FTFbR7aPEw76/Novvws27m8ezObg8S1RrmgI9oJ1KiMAZ8cQaXR/BmrD6xZ0xL6g8cDwxxfGW8YFUWGGeLKl/02sc1FUcDbj93PqkIuirC+YY41m6t7YKvEdHQI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-424861a90dfso11512435ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:13:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758294792; x=1758899592;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pdVbcA7nmK1fnCSLRQe6g3pMqB2Icbe7/rxf0Y74n4I=;
        b=puRtbKOYveb1K8zislEarlyIhZlDlBvudaxOmVlbmooqrG0pDv+2xVw0ExYVlm2S4v
         6Ui02r/M0TM7o0GEGo2/imm0AJo4qPQ6MZXYGeUhYJMJdr/I7i3Hi8vdrruC6M1hvSBX
         x+ERa3XC9XAUq8i+zG6tnOSW8euvZpvu3V8t7ilkqCDdZaezeRRjD6aTR9M/C7BHITOR
         igtQib5Nq0EAKtCvJht/zlUgDCUnuBaJtMOdPDiZzXDqj2cfgIxmbADvV9YaFgM7jUPP
         9Um+ujdnaGVvE77XWrl920b327eKdT+M6IwS7iWA5n/xWtxPJZIUJR9OWqc/roZogm1G
         2gGA==
X-Forwarded-Encrypted: i=1; AJvYcCW4cn1YKIIumXt/yb6sYL/whsJ7xG6Q76iLQhTH0HRpD/VIgOi0S6y8/gWuPi+91u2Q0u+sfNDXL21zznM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWl8ufJ0I84TxHr9OKFbb+e44jbbVtX9jffPI+RCl7tzHG90Ut
	nxBStWdL4tNEi72vuYAg3BgVOTH2Pu1GvN26T7mX0Ck97n1N7PrCkiIlmdvZMkpasU/iohB2WQw
	Nb8YFG9oAMvcQOttU3NIn3uhhHQ+i6Cwin/ZyYQWTAxGrQJgUCN60c32/tco=
X-Google-Smtp-Source: AGHT+IFIiUlKXGs3lu1PngiLaqqMui66INNfwYaJjXTuOGZYLDGxFw6Uuh2OsxLvLi27v0agrmaVGMRQIFpMuFzN864d8ZGPIRLk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8d:b0:423:fb73:315f with SMTP id
 e9e14a558f8ab-424818f7ff9mr62320655ab.6.1758294784388; Fri, 19 Sep 2025
 08:13:04 -0700 (PDT)
Date: Fri, 19 Sep 2025 08:13:04 -0700
In-Reply-To: <aM1moP0fr7GrlbWZ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cd7300.050a0220.13cd81.0000.GAE@google.com>
Subject: Re: [syzbot] [bpf?] WARNING in do_check (2)
From: syzbot <syzbot+e1fa4a4a9361f2f3bbd6@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, paul.chaignon@gmail.com, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+e1fa4a4a9361f2f3bbd6@syzkaller.appspotmail.com
Tested-by: syzbot+e1fa4a4a9361f2f3bbd6@syzkaller.appspotmail.com

Tested on:

commit:         a3c73d62 bpf: dont report verifier bug for missing bpf..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13928d04580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d8792ecb6308d0f
dashboard link: https://syzkaller.appspot.com/bug?extid=e1fa4a4a9361f2f3bbd6
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

