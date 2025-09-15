Return-Path: <linux-kernel+bounces-817860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB05B5878F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 00:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21B1C1AA76B2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 22:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A924D2D46B7;
	Mon, 15 Sep 2025 22:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STvMmTiB"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2372C236D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 22:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757975673; cv=none; b=hhgPUzC+5MlGuFMKhlh2C6x687L4yWe5KrANId2STZwHgMAsZZB5e+BXJl+EQQ0/mjnK9qbDQ7mTfLV+LzpBHNbqzX8Rk1WP1Vr6XI22FARydmhoSeqbstyVH3FOyB+kpbUdIdeYRMtXPfCDqe3l9+4JaiCAFqvf/IwZdsEnYGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757975673; c=relaxed/simple;
	bh=6579veiTkGV2/lYHARJuh4EC8LZB48bk3/wE8rYugJE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nVn8O+wyZLW0gX4iYYPpj8TSp2/clRNmye+elSV0iYwoUE325FtSrbfsqgI5XitcYYPVtZG3mR/9X8yzi9g1zPMLkUSpu+Km1l7jqmt09icvDvyXqDYCbI2CsRfTpLXvvesmUA0tRXFx6l7Nz7GgB8Eby0uZak/PUgRAKOlK6lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STvMmTiB; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2445805aa2eso40938005ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757975671; x=1758580471; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uKpnrxplEah/+KvC4DDszG3TyPQEFacClkTFr5MjA+4=;
        b=STvMmTiBZ3GQiC5Hd8eaWWVGkvVI3wNd3Ovau6Ws0SKzGp838ICJZuzN7TaylSquGb
         FqM3r7HcoIryC5AICQdEE5AZt73bVDVvhuVnscDCtIbxCvrJLcfrrqyVpSBYJPMoIw+W
         enDpRGovFvBdEelp8f2Cfr4PAo5tzS5+wl9dEknVLI4h8lz57ickBzaRwpgKkB/MsNex
         yTwF+QPGTwJsmJCYPgertN/L+Nmo8OnItVaLsgD5pQ1E+nuYf0P1ZcMitEAkI/lZLkwy
         NNFZTKMjajOt+SOSk8MCNyv5fGN50plrfQKsxxeItOsjoDMdVOTYQURPv1gYX0NIvFq2
         rREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757975671; x=1758580471;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uKpnrxplEah/+KvC4DDszG3TyPQEFacClkTFr5MjA+4=;
        b=E6WCCV64DsdyOTsjFlaz205spQe4PsXkRHSa7mKVM1hVPBIVwVogJTK7XYJbfuwPyE
         /fE/RgkzT2B+JK/2xqQT4sBeSGDveizMmCYfeMHADN//UgT+2dns3Gqowe2xrWCA7iD5
         GyfWuKiljumQe5l7wYZDPTISAxVnhUIm3hspj8ysIbTVpu6naVCruRMqduh+PLvrxzD6
         vTvi2Lt9sqkk7IZ9eEvPcBCpFCcdn8BNeDi79zeFYARctGeL2coYJ8Nt+XxHSa9ztr3F
         mpOlyeAAPeduXyjt31DaOy78bw0imLwl9FrmKI23is2U0FyInJfPuTz5qNUBBNS+KR5Z
         bMmw==
X-Forwarded-Encrypted: i=1; AJvYcCVbsI4t5MQZ8ntSw3ilNmCin1wgRvahDtJvR8jeK+miQ4KcsHEhG0kHsJ+fEwJrXHpwM/2sYwkRo2gp2SQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFgxNEvbSDjNnZxl7SvIXkQY/i3917uV/NRtqQzQOJM79fnF9o
	feV9oiYPGsTrtGv9ACSM+AJ+Suszg95lEtF0jj8AZzx/JNio6Qcq312p
X-Gm-Gg: ASbGnctg5069GkG/xhlpq/AxXOJmnJJx8NbxYSzkZFTKMjpp2UV5X9HKOg0//5KpYr7
	hUfigBuMEe1IK3cmbolcc6MRqIiSW4Hf+yUOSBxbTo8l3jt65bsMjIbiohueuGwDlqTsOSaNljn
	yhlPgeEuCV6glc3cZGguBVv3L9soRTvpayvNxqvUP5hYft1soDuwUGV/XKCvzG6oo6tFgbpcNZe
	6Eu1qzkLeNCgYCOLeKOkoGMnubTh36vsmD/+xHcj6soHf42YnrxwJvRpNehBIxk+qvivR7zhv3M
	a8frgf54mAQc/oUwTg7F8Hfr1+XYMXV+w1GPWjOl7q+NCMxNB7vqhkJbKWcHyzXk0EzUpAiKjsD
	LrIBGl8ODCm8F1urKbdTZjQASArI6S41REpZZURk0IdwSBuOT179+Vkz5mrdszt2ujjsSXw==
X-Google-Smtp-Source: AGHT+IGQ7pSiimR5YXL8QycRMi8OMI59ZvWOwr/cnQ7GI5YxuakT2T1+t1UKM5ZiCpb4E2/yrkMtAw==
X-Received: by 2002:a17:902:f602:b0:266:2e6b:f5a9 with SMTP id d9443c01a7336-2662e6bf902mr74474245ad.20.1757975671372;
        Mon, 15 Sep 2025 15:34:31 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:1da5:13e3:3878:69c5? ([2620:10d:c090:500::4:283f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-265819a6193sm50361505ad.55.2025.09.15.15.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 15:34:30 -0700 (PDT)
Message-ID: <81bb1cf72e9c5f56c92ab43636a0626a1046d748.camel@gmail.com>
Subject: Re: [syzbot] [bpf?] WARNING in maybe_exit_scc
From: Eduard Zingerman <eddyz87@gmail.com>
To: syzbot <syzbot+3afc814e8df1af64b653@syzkaller.appspotmail.com>, 
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, 	haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, 	linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, sdf@fomichev.me, 	song@kernel.org,
 syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Date: Mon, 15 Sep 2025 15:34:28 -0700
In-Reply-To: <68c85acd.050a0220.2ff435.03a4.GAE@google.com>
References: <68c85acd.050a0220.2ff435.03a4.GAE@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-09-15 at 11:28 -0700, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    f83ec76bf285 Linux 6.17-rc6
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D137d0e4258000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D8f01d8629880e=
620
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D3afc814e8df1af6=
4b653
> compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binuti=
ls for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D104a947c580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D14467b6258000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/be9b26c66bc1/dis=
k-f83ec76b.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/53dc5627e608/vmlinu=
x-f83ec76b.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/398506a67fd8/b=
zImage-f83ec76b.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+3afc814e8df1af64b653@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> verifier bug: scc exit: no visit info for call chain (1)(1)
> WARNING: CPU: 1 PID: 6013 at kernel/bpf/verifier.c:1949 maybe_exit_scc+0x=
768/0x8d0 kernel/bpf/verifier.c:1949

Both this and [1] are reported for very similar programs:

<this>                                      <[1]>
---------------------------------------------------------------------------=
-----------------
(b7) r0 =3D -1023213567                       (b7) r0 =3D -1023213567			=
=09
(bf) r3 =3D r10				    (bf) r3 =3D r10				=09
(07) r3 +=3D -512				    (07) r3 +=3D -504				=09
(72) *(u8 *)(r10 -16) =3D -8		    (72) *(u8 *)(r10 -16) =3D -8		=09
(71) r4 =3D *(u8 *)(r10 -16)		    (71) r4 =3D *(u8 *)(r10 -16)		=09
(65) if r4 s> 0xff000000 goto pc+2	    (65) if r4 s> 0xff000000 goto pc+2	=
=09
(2d) if r0 > r4 goto pc+5		    (2d) if r0 > r4 goto pc+5		=09
(20) r0 =3D *(u32 *)skb[60673]		    (20) r0 =3D *(u32 *)skb[60673]		=09
(7b) *(u64 *)(r3 +0) =3D r0		    (7b) *(u64 *)(r3 +0) =3D r0		=09
(1d) if r4 =3D=3D r4 goto pc+0		    (1d) if r4 =3D=3D r4 goto pc+0		=09
(7a) *(u64 *)(r10 -512) =3D -256		    (7a) *(u64 *)(r10 -512) =3D -256		=
=09
(db) lock *(u64 *)(r3 +0) |=3D r0		    (db) r0 =3D atomic64_fetch_and((u64 =
*)(r3 +0), r0)=09
(b5) if r0 <=3D 0x0 goto pc-2		    (b5) if r0 <=3D 0x0 goto pc-2		=09
(95) exit				    (95) exit				=09

So, I assume it's the same issue. Looking into it.

[1] https://lore.kernel.org/bpf/68c85b0d.050a0220.2ff435.03a5.GAE@google.co=
m/T/#u


> Modules linked in:
> CPU: 1 UID: 0 PID: 6013 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(f=
ull)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 08/18/2025
> RIP: 0010:maybe_exit_scc+0x768/0x8d0 kernel/bpf/verifier.c:1949
> Code: ff ff e8 cb 8e e7 ff c6 05 0a b5 bf 0e 01 90 48 89 ee 48 89 df e8 f=
8 41 fb ff 48 c7 c7 a0 9b b5 8b 48 89 c6 e8 59 33 a6 ff 90 <0f> 0b 90 90 e9=
 4e ff ff ff e8 0a ee 4d 00 e9 7f f9 ff ff 4c 8b 4c
> RSP: 0018:ffffc900041bf500 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: ffff888079840000 RCX: ffffffff817a4388
> RDX: ffff88807d3f8000 RSI: ffffffff817a4395 RDI: 0000000000000001
> RBP: ffff888079846328 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000000 R12: 1ffff92000837ea7
> R13: 0000000000000000 R14: ffff88805cf87400 R15: dffffc0000000000
> FS:  000055557c9b5500(0000) GS:ffff8881247b2000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055557c9b5808 CR3: 0000000073b4d000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  update_branch_counts kernel/bpf/verifier.c:2040 [inline]
>  do_check kernel/bpf/verifier.c:20135 [inline]
>  do_check_common+0x20cc/0xb410 kernel/bpf/verifier.c:23264
>  do_check_main kernel/bpf/verifier.c:23347 [inline]
>  bpf_check+0x869f/0xc670 kernel/bpf/verifier.c:24707
>  bpf_prog_load+0xe41/0x2490 kernel/bpf/syscall.c:2979
>  __sys_bpf+0x4a3f/0x4de0 kernel/bpf/syscall.c:6029
>  __do_sys_bpf kernel/bpf/syscall.c:6139 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:6137 [inline]
>  __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:6137
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xcd/0x4e0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fd1d078eba9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffee0400aa8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 00007fd1d09d5fa0 RCX: 00007fd1d078eba9
> RDX: 0000000000000048 RSI: 00002000000017c0 RDI: 0000000000000005
> RBP: 00007fd1d0811e19 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fd1d09d5fa0 R14: 00007fd1d09d5fa0 R15: 0000000000000003
>  </TASK>
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

