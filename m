Return-Path: <linux-kernel+bounces-617713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA93BA9A4BA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 09:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CD9F923BF0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 07:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C081E5219;
	Thu, 24 Apr 2025 07:48:29 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BC71BC07B
	for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 07:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745480909; cv=none; b=DyC9gqEBlEPdXKfZ+S/hbKXqDd8hSw+R0ie2PCTcbPj34AJ04yukQyC/xAuVEqlvzoeMeo08tFSjlUkq2L6UKn+IPbtpVrBws1OPOtBHVQxYxOqFLlmIYamsiXgKNKA5JfjLy7FMdtZev1YganMeRPVL5PS0AQy0yfa1IDCr9p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745480909; c=relaxed/simple;
	bh=svru1N4+9HP6clJb4juZ6a1oIPHGLBdHICZaGQvJQOk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Y7iNQEYQzpEtYYF+ZCOglRILzAuRBExiMUhA6aV7nuZeFD23pnFhXjbmkVB8U8tnavmQBkjz/BTCS0t3/lz/Lm7z+9gKwziERY83AZb1PtLexGtVbqSIFtNjKo2QjYbWy16L3PsDRmZbBfHRvQGF8uMq2afc/Xs8JaD0UqYq/QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d9099f9056so18197675ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 00:48:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745480907; x=1746085707;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EyJl6r6OZz/+a7pHM+1QZtQvrTo3HwL1nTMBQN3lL6Y=;
        b=uNPq9vnVKn+ApAuFcr7xmoJkTOXMnuMQtE9PnpjgxwvIQ5n9qQgqdndXB7o0k/0xUF
         dpwKAHMazjFTCF81COJgFkalunr9U9nA/bpWXQYxDoM9O0aPu2H0YAuxd91or6FB2hn3
         HEYeyrjYhKRXZQ2UXPwN/c7GkxaZh7FzHJGXxGml+wglcbgIeFoCM2Ha+fFhqssc9wMM
         AuTnFP+cAYSdGANVvCq4ogF7/zFhzZ33uUN9yAnbtb68PDq3hNgZ4v4g+7n3oDFxwq3S
         jzwwbmtYGI5bL6eIUH6YtgsFGyurA+oxPg2Z1VjDr09kCPNxybYudD2NczgS1WOiNvcu
         c/1A==
X-Forwarded-Encrypted: i=1; AJvYcCXCxN/M/qWjDbRxWUKoSW1F9rYMMsr8PiF+2WFJenyfdBU1jV8CzykAsI33S3NgkKMNvEqrG7EsrZzkygM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpqlXs0gUwdEZ8Fy5hYoqgBIHH1By75ar6eGDbpgFY954hE0AB
	aSzIdHTXELYQM47+y9iAGxlcGq7/rV70KS+rPyASzkpMbG5oHRoocaJafCdGikHWKXE4MT/wJz5
	JfNS4Wn9K0+i9E6Fy8y4XqLIhaVgUQGvdnw7VSiAMVI7P75Pdxp7PNcQ=
X-Google-Smtp-Source: AGHT+IHzUNzXP2deS4l0cUszwq/xaCvriu6jPvej6Sn3tNmutEBPu2Rpfb4hLdnmsWpxJdYOHvj+UF8zZnHuc3Ks6zKomcqZVnPE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd81:0:b0:3d8:2085:a188 with SMTP id
 e9e14a558f8ab-3d930393d8cmr17194595ab.1.1745480907023; Thu, 24 Apr 2025
 00:48:27 -0700 (PDT)
Date: Thu, 24 Apr 2025 00:48:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6809eccb.050a0220.317436.0047.GAE@google.com>
Subject: [syzbot] Monthly bpf report (Apr 2025)
From: syzbot <syzbot+list764e216efbc06fb2844c@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bpf maintainers/developers,

This is a 31-day syzbot report for the bpf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bpf

During the period, 3 new issues were detected and 5 were fixed.
In total, 25 issues are still open and 290 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 2116    Yes   WARNING in bpf_map_lookup_percpu_elem
                  https://syzkaller.appspot.com/bug?extid=dce5aae19ae4d6399986
<2> 253     Yes   INFO: rcu detected stall in sys_clone (8)
                  https://syzkaller.appspot.com/bug?extid=c4c6c3dc10cc96bcf723
<3> 11      No    KASAN: slab-use-after-free Read in sk_filter_trim_cap
                  https://syzkaller.appspot.com/bug?extid=b4bc25bfaad44df51f05
<4> 6       No    general protection fault in drain_mem_cache (3)
                  https://syzkaller.appspot.com/bug?extid=18139576507d899c8066
<5> 5       No    KASAN: slab-out-of-bounds Read in bpf_inode_storage_free
                  https://syzkaller.appspot.com/bug?extid=eff9059eb9bb5f59b754

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

