Return-Path: <linux-kernel+bounces-688010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13445ADAC52
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 11:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAB683A5CF0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 09:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C08273D64;
	Mon, 16 Jun 2025 09:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HSeaY88n"
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BF61FDA
	for <linux-kernel@vger.kernel.org>; Mon, 16 Jun 2025 09:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750067370; cv=none; b=ett9JZ7BFC+ZkPlWHctoDyHfr1erFKymuOt91hKUonbukoxKKag0ScWxGGQ1bFuODUuycJyI1ZYqunRcoYYfaAGYgbYh+jG2E1tinft6NZu630CVa++YO0OW3zZEMQ13qx+yyMens19iWrHtAJIkfuCj75xluhM310+aYbEOrRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750067370; c=relaxed/simple;
	bh=3XGHzncw96rNFVh/2YuVc16b66eZSnlC5UHBqfXaBic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oiOfEqJI5hHg/rvJtV9iSgTFsKxtjGzZd9/YgHtDIwwOH8uvcjMF5Kp4oOkHkP1WTPMPfmSaYqavvUZwLqbIH7vx5hLmrEVSK42kxUj8o1+XUH/sEdLubkchOtsGRwzniJ8CfioLvh9lJQV96HBHSVvyt4qkx52jM9yhjBpilEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HSeaY88n; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-3a361b8a664so4349595f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jun 2025 02:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750067365; x=1750672165; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TXZ3a247HoOIY5lsLgQP3E0mLsYbNYMz2FvpATMhvR4=;
        b=HSeaY88nB407+LGmRP6QzcTMn5DF8c16/75EZbCVdMWtzL2jaUxbAr+V1whQqvgriT
         mbJhUCFbnShfw+RrClODL/FH47ap/WZ9zqsuFB7WgP3uzc4qwSn9gyVz+F7b05nKxPep
         dqpL2z3fHVliPOXPdclPBHyaMZetl8b5IjD6ByNgdwg7LOAWolw2TxLKQsg8LoMBjMjJ
         L5e9oO3bzbMHIfyjd8cGaOJBka1ogPVYkuTcYv6K8cEqx6zRlAo9NZ/dBWvovEiG1voW
         Tqmp3WxlLF0XN2vxPDf6vUGxaJGfVp9HSwmTmY06Lyjm3sGwEQElFrxOkXFWNQ/44LZd
         nZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750067365; x=1750672165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXZ3a247HoOIY5lsLgQP3E0mLsYbNYMz2FvpATMhvR4=;
        b=OvSEHf1JhjuG8u3gSzDb0xYhY4XGMiPSHARyedGX9Qrz6wfXZZ4V1QB6nsJfD4wQdc
         FvwJNsZ0szf01WQivqT9VmMkPYszVWQLWRG7ITa8uoe2HMeqpsMuTi0/BBMAqPbfSa9t
         INCJD5QCVZum8cvQBtAHl4mIKuy9s/BasOh2T14wVxDcvxcnoFEJ4zrNTWTIkp+Buleq
         asc/oa8cd0BEAH/C26DaezpypIICPfnZ81nxjneIrv5di3tkn0IJ55t4It+31mjUTOjL
         ZaxyU7Zy0I4u0HtJt45dDWLUE3WR4khyBoSAdVujuJV7ng128qXMvzC5q/CpaVwftqyT
         f3TA==
X-Forwarded-Encrypted: i=1; AJvYcCWAaVPcmZoZjAElSYSHntSINvW1c2FOT/Wwoz+S3jS9cYAI8ayRVYuKfDikhc1Ar5RsbB9DjLoXSUjG+28=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo4njADnK9g/9W9EfZXAc9/uzXFD/GP74NDUHushYTs7ijHDGi
	7eclU7JDLpJAAcMYC4Umq5wAhUJKt/64ONgHvffal/qbmmX8RxAoVMhawopX4q0gxa8=
X-Gm-Gg: ASbGncvin1aLZxY/33CbMa22awd/fFCwRcfZmoo/GbIon6sjqWAEyQJrUXinU96mGzk
	DY8uQaH+EgMXuwIZtj6NAS/FFHTSQaLaLi5ne3pSEhWt5k/DyptDhVLUeQSHR5DLXjfqynj2dAT
	dWen9HVCoTGa2rhcztvTb9D4YnpJnXIAF41EpPd62MWykMTMUXUtp9I394sK6Cg/jxVm632rjPO
	b7RkZ+NUJ0RaWvcjChSWKnvS2deCxNP1/rygBUzDeAdUAcOroM4iE7JnTBr+MqFmm7yGvs+gXe4
	xMhIY8q1UD+LWplLR4b1wnEM7am/Pe32QyoyCzayApehpFWpGIgosmNbgA7m/Izp
X-Google-Smtp-Source: AGHT+IEmmRlr02esgCxSPNx2p+XONpaMNZybWASMjiFRhiTMSvJVXgZpa8lHtUZWHTieDrvu7A91mA==
X-Received: by 2002:a5d:5c84:0:b0:3a4:f7e6:2b29 with SMTP id ffacd0b85a97d-3a572399119mr7462973f8f.5.1750067365008;
        Mon, 16 Jun 2025 02:49:25 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4534172d2b0sm70178835e9.35.2025.06.16.02.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 02:49:24 -0700 (PDT)
Date: Mon, 16 Jun 2025 11:49:22 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: syzbot <syzbot+8d052e8b99e40bc625ed@syzkaller.appspotmail.com>
Cc: cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org, 
	JP Kobryn <inwardvessel@gmail.com>
Subject: Re: [syzbot] [cgroups?] WARNING in css_rstat_exit
Message-ID: <vjqyx3bkhyomb6zafk5xmjpfsitmqll3wcoean3orwpl7vkgb3@pbo33km36ek2>
References: <684c5802.a00a0220.279073.0016.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bhfvnkwvhzxzqock"
Content-Disposition: inline
In-Reply-To: <684c5802.a00a0220.279073.0016.GAE@google.com>


--bhfvnkwvhzxzqock
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [syzbot] [cgroups?] WARNING in css_rstat_exit
MIME-Version: 1.0

+Cc: JP

On Fri, Jun 13, 2025 at 09:55:30AM -0700, syzbot <syzbot+8d052e8b99e40bc625=
ed@syzkaller.appspotmail.com> wrote:
> Hello,
>=20
> syzbot found the following issue on:
>=20
> HEAD commit:    27605c8c0f69 Merge tag 'net-6.16-rc2' of git://git.kernel=
=2E..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D103b1e0c580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D89df02a4e09cb=
64d
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D8d052e8b99e40bc=
625ed
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40
>=20
> Unfortunately, I don't have any reproducer for this issue yet.
>=20
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/79ab1e186123/dis=
k-27605c8c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/d37bf85b966d/vmlinu=
x-27605c8c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/eed2865abf8f/b=
zImage-27605c8c.xz
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+8d052e8b99e40bc625ed@syzkaller.appspotmail.com
>=20
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 5887 at kernel/cgroup/rstat.c:497 css_rstat_exit+0x3=
68/0x470 kernel/cgroup/rstat.c:497
> Modules linked in:
> CPU: 0 UID: 0 PID: 5887 Comm: kworker/0:5 Not tainted 6.16.0-rc1-syzkalle=
r-00101-g27605c8c0f69 #0 PREEMPT(full)=20
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 05/07/2025
> Workqueue: cgroup_destroy css_free_rwork_fn
> RIP: 0010:css_rstat_exit+0x368/0x470 kernel/cgroup/rstat.c:497
> Code: 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 0e 01 00 00 49 c7 8=
5 70 05 00 00 00 00 00 00 e9 00 ff ff ff e8 c9 07 07 00 90 <0f> 0b 90 e9 3e=
 ff ff ff e8 bb 07 07 00 90 0f 0b 90 e9 30 ff ff ff
> RSP: 0000:ffffc9000b6afbc0 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffff888057c7a800 RCX: ffff888124754000
> RDX: ffff8880308b8000 RSI: ffffffff81b514e7 RDI: ffffffff8df26da0
> RBP: ffff888057c7a808 R08: 0000000000000005 R09: 0000000000000007
> R10: 0000000000000000 R11: 0000000000000001 R12: ffff888057c7a820
> R13: 0000000000000000 R14: 0000000000000003 R15: dffffc0000000000
> FS:  0000000000000000(0000) GS:ffff888124754000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b31b10ff8 CR3: 0000000079092000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  css_free_rwork_fn+0x80/0x12e0 kernel/cgroup/cgroup.c:5449
>  process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
>  process_scheduled_works kernel/workqueue.c:3321 [inline]
>  worker_thread+0x6c8/0xf10 kernel/workqueue.c:3402
>  kthread+0x3c5/0x780 kernel/kthread.c:464
>  ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
>=20
>=20
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>=20
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>=20
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>=20
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>=20
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>=20
> If you want to undo deduplication, reply with:
> #syz undup

--bhfvnkwvhzxzqock
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaE/ooAAKCRB+PQLnlNv4
CKZVAQDPnkV0M65AIbXljJXGDlbDU2H9cQ4ecMIexjR/n+YEwwEA3EBPow7yy/1B
VFSYcIpv4QzV1Jo8a0ml0gAyNrfL1Ac=
=x1ow
-----END PGP SIGNATURE-----

--bhfvnkwvhzxzqock--

