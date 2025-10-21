Return-Path: <linux-kernel+bounces-863358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF1DBF7A76
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 453F9506CD0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A66D3491EB;
	Tue, 21 Oct 2025 16:27:01 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E353491F8
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761064021; cv=none; b=RmHfvxjLwFt8Y46V7wqCBGDtIMlKcmuLCMpnFTAtahpNsKpOGn779mW41FgFi8URuwmnyiWVP+rE9j3BDvumj1JAzgeOkLEEH9MkuSE0nUChD3mnFQhTw5O8oQDj9RERvPduWem1HJ3tlxv7Zr8HZA9RFv7N9QKZG39LdY5w8MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761064021; c=relaxed/simple;
	bh=UJrHEvcSfi/Pka2cgWnZ3GgnBH7EVZquQA2PoG2f1vg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cNs1lk+89IpuCM9b9v25H1yPOuCEHoJ4FSFoECQPzKTb/zDZ9BKTF/8ckzqWg/DkHheP0H+jeuo7Jo46Bnkn0E6aFt9QrZ+2QaeUG1latDLDycYgxCoyAoe4jM9Hkf6sg3kKiG6z66mEqyGmTXL50x/5sQaJl46zPosNyziWv6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-430db6d36c6so95778345ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:26:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761064018; x=1761668818;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pFdC+aSTmJfkazoCMziwNnodu4GwgClZcM8jfns2mRc=;
        b=manfSOzpPms638sUdtGywAG5N1TfNejzZNASUifYGlK9bwfHu/EYn7DJG/bYfz4Tbf
         ibDGn00ftVU5Jkbomz9yB9e/d9Wk09FhRnB1mXZflZgl0Z/1iPVlkkYHURJ6QgW9oGt4
         RHzacWPVFhaNlULt5VMKtX2u0q59ITqSQSaO3QlsKLkhqAVe6VizGpk1EjbxEgthEsI2
         i/CsFF2+3hKLoP9FbddLHL9RlUWsYS2sXr7hs0/hTNfSSj7jHMQ7CSB+0Pf7c5QOpYbS
         EJDC3oBbeg9cL5IYsNXuad4lLipHI5LPYjtr3YuXdwQbtiH4hij/Qv6nXVcB/c+HcXmU
         sDQw==
X-Gm-Message-State: AOJu0Yw7pDL7knGR9f2zC6jb2lu1+w4EuKMHClknzqM29dWDWAF7ybSz
	2hGR0NReQzbBeGwP8nbUeBn7xs98IY+BmdLj5cHnGiXA6AJdxPTFs5KiCRwJo3ZIieVnsmoXu+w
	BS+On8Qfz7gXldvFL9Up4f7FfhGwsLc6tmvJQNox7nDFS8Sx1GfdBbhCGAv29uw==
X-Google-Smtp-Source: AGHT+IExqRJuHMdWm4oqScDfjCwF+h4BUlmYlDFFwMuP1PgIslh+gllR0FhSzvM3zHhc+/iQPZVsBCiXpRaGRg+Z8E8PMx1aoBsT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b02:b0:427:a3ef:5701 with SMTP id
 e9e14a558f8ab-430c5232b53mr279873095ab.14.1761064018604; Tue, 21 Oct 2025
 09:26:58 -0700 (PDT)
Date: Tue, 21 Oct 2025 09:26:58 -0700
In-Reply-To: <68f6a4c8.050a0220.1be48.0011.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f7b452.a70a0220.3bf6c6.0008.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [bpf?] WARNING in bpf_bprintf_prepare (3)
From: syzbot <syzbot+b0cff308140f79a9c4cb@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [bpf?] WARNING in bpf_bprintf_prepare (3)
Author: chandna.sahil@gmail.com

On Mon, Oct 20, 2025 at 02:08:24PM -0700, syzbot wrote:
>Hello,
>
>syzbot found the following issue on:
>
>HEAD commit:    a1e83d4c0361 selftests/bpf: Fix redefinition of 'off' as d..
>git tree:       bpf
>console output: https://syzkaller.appspot.com/x/log.txt?x=12d21de2580000
>kernel config:  https://syzkaller.appspot.com/x/.config?x=9ad7b090a18654a7
>dashboard link: https://syzkaller.appspot.com/bug?extid=b0cff308140f79a9c4cb
>compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
>syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=160cf542580000
>C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=128d5c58580000
>
>Downloadable assets:
>disk image: https://storage.googleapis.com/syzbot-assets/2f6a7a0cd1b7/disk-a1e83d4c.raw.xz
>vmlinux: https://storage.googleapis.com/syzbot-assets/873984cfc71e/vmlinux-a1e83d4c.xz
>kernel image: https://storage.googleapis.com/syzbot-assets/16711d84070c/bzImage-a1e83d4c.xz
>
>The issue was bisected to:
>
>commit 7c33e97a6ef5d84e98b892c3e00c6d1678d20395
>Author: Sahil Chandna <chandna.sahil@gmail.com>
>Date:   Tue Oct 14 18:56:35 2025 +0000
>
>    bpf: Do not disable preemption in bpf_test_run().
>
>bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=172fe492580000
>final oops:     https://syzkaller.appspot.com/x/report.txt?x=14afe492580000
>console output: https://syzkaller.appspot.com/x/log.txt?x=10afe492580000
>
>IMPORTANT: if you fix the issue, please add the following tag to the commit:
>Reported-by: syzbot+b0cff308140f79a9c4cb@syzkaller.appspotmail.com
>Fixes: 7c33e97a6ef5 ("bpf: Do not disable preemption in bpf_test_run().")
#syz test

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 1b61bb25ba0e..6a128179a26f 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1021,7 +1021,9 @@ u32 bpf_flow_dissect(struct bpf_prog *prog, struct bpf_flow_dissector *ctx,
  		     (int)FLOW_DISSECTOR_F_STOP_AT_ENCAP);
  	flow_keys->flags = flags;
  
+	preempt_disable();
  	result = bpf_prog_run_pin_on_cpu(prog, ctx);
+	preempt_enable();
  
  	flow_keys->nhoff = clamp_t(u16, flow_keys->nhoff, nhoff, hlen);
  	flow_keys->thoff = clamp_t(u16, flow_keys->thoff,
-- 

