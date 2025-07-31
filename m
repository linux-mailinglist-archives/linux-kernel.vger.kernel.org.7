Return-Path: <linux-kernel+bounces-752189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 925ADB17241
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 845A63ABB76
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B872D0C61;
	Thu, 31 Jul 2025 13:43:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CA92C3277
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 13:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753969387; cv=none; b=hZ2aYYhimeqiM6/X/cZx0KiGPiWs9RhOu9zFSADd0GVRJKvUkYDZev/6zRPLuxafO3cidLjmNqQ4Pbmem8UksfMPhOeADMcfMqaqDXtifMKR/Pd3HoLrSo9fh1b9yy9M3heZsHhbBMX4GGyjEz3+WKct3LmO5M2k3dcx+3CRU/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753969387; c=relaxed/simple;
	bh=kx5UBa/rUKpCxax1gh5Ps5wlCy/DVnwNhn9buNehuFE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=q5BLI9f7BjyBLKX2npRNXS2ldvf0o/zZck8qFzKSa4MzCAEW0NcUD5nhff1RzjTWu0K3I1FGRtbcQmB1g2aCfCLtu7mkur0BanGOQ4KSeiC0Ac4siIE1HvyWrV4ZlqsHWgnPrdK02y9jAt2qkxQrPOYOsGohfwfBup81CLHSXWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-87c1d1356f3so81752539f.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 06:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753969385; x=1754574185;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ndZt07l6ODlNg9Eyb1VPeXSebetlFLG+Q/xDsuh5QtU=;
        b=RMXwGyTz0i3GKaZmUc97dEGCNx2xZBtp9Tf0+7S7lClP7dNNljTOg6/ACwnvBW0M40
         YLDxott+S8iGjf+cT7FCGdnNLJQnXtvPA/wOUJzBvqHopunbO7Kcy/xzhrJ/tLFak/sH
         pZJHImsQHBKkukE1xzmZNaYNi4erG9TDolMj1nzQni/HmjjhCTgeaahVX+Z9dgUff+Si
         D2y2O6ZKuy/6XzdsaQQMM9/2Z3F02bz0qOwejxOeyvKmw/wvvSJtqJlIYZE/gAKRfika
         hKkSoljSJ6/tWoxsek5R5Nc1N3BAY8L6pIOAbDB/HTBQ2Alc1vkh+t1JWkor3O+MGpWR
         UJAg==
X-Forwarded-Encrypted: i=1; AJvYcCWnDIDQvo+qsy352AEhioNsqFTln72AaACFOynhtY+pvcIqIj5E3gNfzSm+D9ogrBYHlxZmSSKLTy24dcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLQg2GaHb0t47C4bcpqApKSo/79BvJPAkwXTcD0HAHabElg9Yk
	Sr4zB32dgRMT6bOsYfNv+lRBVrtpZ9RGL3m87wyJMzWM0FfthwE4vhBMhXayb8SAYLporVaCGlU
	fuHakXPft0WJ0vsY3CTGuuqeV+pZ0ZAin1Bp7nf3cN8HvgH57y+2+kSbcOk4=
X-Google-Smtp-Source: AGHT+IG7a22P54eB4UEoXzr0FAh4e0qa0CWa28Cd5Dwml2c1EWeCPmY9UJ+C086GKeXQ53ArF6VNZiT4F/nuHaB62ulyeCkYa1lo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2b13:b0:86c:cf7e:d85d with SMTP id
 ca18e2360f4ac-88138c1bed6mr1356042439f.12.1753969385155; Thu, 31 Jul 2025
 06:43:05 -0700 (PDT)
Date: Thu, 31 Jul 2025 06:43:05 -0700
In-Reply-To: <688ae0bf.050a0220.5d226.0011.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688b72e9.050a0220.5d226.0018.GAE@google.com>
Subject: Re: [syzbot] [bpf?] WARNING in convert_ctx_accesses
From: syzbot <syzbot+ccac90e482b2a81d74aa@syzkaller.appspotmail.com>
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17d6aca2580000
start commit:   e8d780dcd957 Merge tag 'slab-for-6.17' of git://git.kernel..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1436aca2580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1036aca2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d32de89be62206c8
dashboard link: https://syzkaller.appspot.com/bug?extid=ccac90e482b2a81d74aa
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=131049bc580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11cc2cf0580000

Reported-by: syzbot+ccac90e482b2a81d74aa@syzkaller.appspotmail.com
Fixes: 0df1a55afa83 ("bpf: Warn on internal verifier errors")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

