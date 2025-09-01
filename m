Return-Path: <linux-kernel+bounces-795368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FA7B3F0D5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 00:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 938DF483CB8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 22:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7A1273D77;
	Mon,  1 Sep 2025 22:10:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0182274B31
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 22:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756764607; cv=none; b=G3fBvYD1BZqmWeo6MlpGOAOV7c6KJRZeUX3sFWq503frpt2Mtm+kLFHUiSllH8RJxamNUMssnXyXvlr+CQwzyzmKIC/dsbeQoimgsCvu814Jm2BO0Fs3/OV4jAJK/PHaM2EYeT/jVeESIHuaTiNG2gCHrsqrV2MbGERt66nOjfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756764607; c=relaxed/simple;
	bh=p0kMM4y7F6N7P9lmCZgTWs3ZjOeXgQCDCsLCsQtEfe0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=scxoo9wDQsEcL6mk1BAhgkwF8a9p9FL320q2B+/pu/+nP+Bl7mMx5ikYwRps/c0L7xGHuzuMJ8nnAwrXHuHD0jJ6s1I+Bqz60A5wFZ2ftUJiujntMRJH/gG4XEiKBslqa5kYw/OQ3Oar7KIzg0J2tUCpKd8muq79sgD1hD9TqL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-886e347d2afso399612539f.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 15:10:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756764605; x=1757369405;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rONquuup1tA/FntPWjZbG/timt5LNSvQmqhWL+HMBzU=;
        b=CPYpnEoiOsWS2v4lChg3ARoQm/9tY5WBV5Q7ZSdTUWajzq/BAjLRrwhU4aJ5gqOeC1
         zME4lcWN0iycaSfTRZg7Fs+C5I+jl2lBt3ds4ECskNEa471ahSGb2vevxKvNEYpl8xvc
         u1/OPW0hnAJXTW6Ldwe/YlscpJztsKeKxllqNTbJdfOmd4wpQtuksYYKpUnHYCUylFtU
         sYRAS1N1kSCYdthaQBKs2jr0TQ2VBfJAuVPxgk1R8Ux536uB+LS0PpzP+EHR1iXqw5yS
         CmSD3bJsIxFBTTKu1pnLQGA8j8lVvhDQn9ClNZeZPcEx+YsOhtif3DWROoHHh1NAyrpR
         vGJg==
X-Forwarded-Encrypted: i=1; AJvYcCUpVN/6kBHD47J8UVy6hTegy+w2OKlcmHC+1FmY4PVhVigvsqYkyIwFpca/epIirPezJebnsCruay2JCo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzcQhoD4j+57owDZqE+xTHBd5hEYmOWzPPC5Ma2+9/j7xDakBe
	SRUyf5MMv2x4W12MTryHULH1RYJF5+vJ5b8jLayvAVqaYAGkVAR30mZ3MhgoB3KvwzoYcgVCd0j
	rvyDs8gYsDcL1ES2br/pvZOlZMJ1n65zFVUuwScLSERASn18LYVcg1GxSYeM=
X-Google-Smtp-Source: AGHT+IEwWIM0KR32k0CrIYVm5MqXLqvHyE40n+Jbcb7UVXKXi5zhmdRI/WfQizUkVs9bev2AbFsAxIgzU7Q7sbXwGYhdaNj7lYwg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa2:b0:3f0:78c3:8fc5 with SMTP id
 e9e14a558f8ab-3f400097882mr176361265ab.5.1756764604779; Mon, 01 Sep 2025
 15:10:04 -0700 (PDT)
Date: Mon, 01 Sep 2025 15:10:04 -0700
In-Reply-To: <68ac9fd3.050a0220.37038e.0096.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b619bc.050a0220.3db4df.01c5.GAE@google.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in __bpf_ringbuf_reserve (2)
From: syzbot <syzbot+fa5c2814795b5adca240@syzkaller.appspotmail.com>
To: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	haoluo@google.com, hffilwlqm@gmail.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@linux.dev, memxor@gmail.com, netdev@vger.kernel.org, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 27861fc720be2c39b861d8bdfb68287f54de6855
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Thu Aug 21 16:26:00 2025 +0000

    bpf: Drop rqspinlock usage in ringbuf

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=167eee34580000
start commit:   dd9de524183a xsk: Fix immature cq descriptor production
git tree:       bpf
final oops:     https://syzkaller.appspot.com/x/report.txt?x=157eee34580000
console output: https://syzkaller.appspot.com/x/log.txt?x=117eee34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c321f33e4545e2a1
dashboard link: https://syzkaller.appspot.com/bug?extid=fa5c2814795b5adca240
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=142da862580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1588aef0580000

Reported-by: syzbot+fa5c2814795b5adca240@syzkaller.appspotmail.com
Fixes: 27861fc720be ("bpf: Drop rqspinlock usage in ringbuf")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

