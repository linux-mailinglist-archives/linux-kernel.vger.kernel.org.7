Return-Path: <linux-kernel+bounces-803980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1DFB46831
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 03:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C5535848CA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 01:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E5E1B0414;
	Sat,  6 Sep 2025 01:58:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508491CD2C
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 01:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757123886; cv=none; b=O3cn87aDFRzTyCxW3TNKUQyz+Xxvk3u1vy/0T9i7v6LOQZFNwo2IWaX+X1lCApPUu36v0bYLExiIqDQWBixMvkvs5kfANAMG3TJ3wIz2W1OuEXAUAE78AUi85w/OZMCQpU6rsweuzHzySKdzoDcOOyIwxBdGxvpR9IRUEknDtDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757123886; c=relaxed/simple;
	bh=huAbnfu87JLJJSl4U7UELqiT8AbsdYCfrTKng7zURFY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kKs2ehFFN3QEGAE4DgXM0GoZerf79RKs+DYNE6D2BrRpOtYuk9dsNVaaAOnnOFjUn2kP2cqDIZJwZqdX5DgC93nm6BH3SsNsUMbrCjgG2fMgI3OxYmOFQw9eKycVDhMLFChrAWQCo/+nZqKsWUj0nioZkjOCQ9PbV+iBAFkPE7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3f2a2b1357cso68574525ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 18:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757123884; x=1757728684;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YTXtF8OtfC1LmLHyZ2eP6LGT2rApcz0JyxdPwyLyFDw=;
        b=uUJUNER1Ufnuf+NXP9CRzoTckR9FH3w+PxC+hxgMGGtTfYeUKF7yl37ZMVkNZvC7jF
         o5xqBhpTKZn6FTZNz6hcmGHEHdSvgr0YzEr+Z/7fXt1QIQ0Mwc+vW8bfiP90XEueGhvE
         ZqDqpVhjmGneIoAbGaF+/Utp0KmZ76bGO2NDWmdAjG1DCb3i03tnoG0BA2WqXQEmo2N6
         M7XN7ZIAWsGk5lgTJjJEUix7zKsRBQL8WFM3mZ0NffDjlD8Lm24yHw6rlQyC97FPKfUS
         CXU62bJQ38LHLl3Nt8QW0hWvEw33y6MvYdu7EZXq73eaSGtx+/6/w1GeMgmgj8UP6QHT
         BhGw==
X-Forwarded-Encrypted: i=1; AJvYcCXaS3uJrJPxk5HCCV4e5gr/A74Sl/LIsY86DvMv1ox/Ajd6jicZBsjKVTT8jFZCcnUCiO9QZvafTCAKEIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWY1qbIBgE0fs6xzbo65M5M71ZkIbbJcUx4g51I5uAI9/vlTfM
	13uiilfmcI5x7wRjBbPsojTQdCN3ZdvD2Oqe3OjH1vzpeozZkyXxo2Sgyvcss9ouOvyD3/PEnNQ
	pPY9l0HnPpgnZZTNoUjQw99gHT7TTrDJ5qctFBjY3XrCg8kyA/FPJ+VX2dg8=
X-Google-Smtp-Source: AGHT+IEwcyKSBjlQbrJidpoGpux8ea5Full4/ob/ekOyhM8HdkklWUh85hzxTCDARaYSTNzJTOwSapgxSepqIItLaYE0jAkXUxye
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1487:b0:3f6:dc32:df0e with SMTP id
 e9e14a558f8ab-3fd877837cfmr16180435ab.27.1757123884561; Fri, 05 Sep 2025
 18:58:04 -0700 (PDT)
Date: Fri, 05 Sep 2025 18:58:04 -0700
In-Reply-To: <68bacb3e.050a0220.192772.018d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68bb952c.a00a0220.eb3d.001b.GAE@google.com>
Subject: Re: [syzbot] [bpf?] WARNING in reg_bounds_sanity_check (2)
From: syzbot <syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, paul.chaignon@gmail.com, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 0df1a55afa832f463f9ad68ddc5de92230f1bc8a
Author: Paul Chaignon <paul.chaignon@gmail.com>
Date:   Tue Jul 1 18:36:15 2025 +0000

    bpf: Warn on internal verifier errors

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13652962580000
start commit:   d69eb204c255 Merge tag 'net-6.17-rc5' of git://git.kernel...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10e52962580000
console output: https://syzkaller.appspot.com/x/log.txt?x=17652962580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d4703ac89d9e185a
dashboard link: https://syzkaller.appspot.com/bug?extid=c950cc277150935cc0b5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17da1962580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=103a1962580000

Reported-by: syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com
Fixes: 0df1a55afa83 ("bpf: Warn on internal verifier errors")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

