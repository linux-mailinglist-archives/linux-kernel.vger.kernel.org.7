Return-Path: <linux-kernel+bounces-739969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE56FB0CD9E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 01:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1A1A3AFBEF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 23:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29152459D5;
	Mon, 21 Jul 2025 23:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FzjFUEVi"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B84A243374
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 23:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753139548; cv=none; b=Cd0N+3X23qHajQphoDe/+HTRXl+fDge56FmS58X4chrPJCR8pHkiTrhyJ4JpH5KCf+dNNHuWNytfcA5cSOTrl95Wyjb4YwQzEVYNYenD33s+hRwpDR/dodR0Edwy5aC64RvVDxPG1VQVXHzP9CgJufHU/ct3V5ws0MGz87r2vKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753139548; c=relaxed/simple;
	bh=+peRbsX085O1mKWreNc3/k1tEOAGP4yBvFZmg8nUawM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mmz9IzS6M53GEGznZJXSQ5aaz4cSIwrRnKe3YAjv+TaResRBOpS8UG8Dg72lezQjgjJI3zvmHhzqPBNzmE0sqMgc/dZFDOa8KFD9dtlWetRzj8YxkYvXgYs9wD1Rm8dnnJ6mgD3/uIp5b7F+s2yZcIQRkX448Lvbsy/eC4NLYLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FzjFUEVi; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b3508961d43so4422555a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 16:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753139545; x=1753744345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=li3Yrow4Uxqk6gKzqzAXyvooU4J0GTr8icWLGoorw7I=;
        b=FzjFUEVi97Zz3SL+M97hclRh4Z5vJDLKI2e0oX6teROnWG3wKp6Q3AIpQDVjPAi3Do
         luDgdy593WaABt8VNjOjUjJWnKD1Yvss+KzXvFA5TrV7wSPZl2fHyMLtSfM+WFoId5ID
         XOLs0WN3Y/Fzc9frNFfwFLLtGRJ18IkNb8VCLaw/rMLm1Iu9eRt8EGluV/jTkUtam/ek
         DpF7HGkT3eA6pan/V4PWgJUkRKv5hc1d3IkAYQya1lnULNxSHTd1tJTAVctRHrUu5d5O
         Uq50n++YA1QifNaY+csqhcwyRLrURSWO5plGYk652NaMyiLFCdWwJUF1hYsg1gjEKaC0
         b0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753139545; x=1753744345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=li3Yrow4Uxqk6gKzqzAXyvooU4J0GTr8icWLGoorw7I=;
        b=TEcTDow74lf6dScCwSSx4mI/yiVBNmgunPPBWj+xaiw2CtmHY6hSypnEmepJj8jhsT
         fl1k3Rn+3QzTFcRoooprDmz5eYnW14p4jFgOSzKZ0Z+JTi6h3TKs6GwoppcpXfdiz5Hf
         6jJCtQn9r1le4WTbBe24lgzCe9cW7BvbsCyFHLMqH9YBygMrJyz0ioL91t6MWo2bOGGS
         pNwNrYDHmshuhWKJJsSntGqbu0X/jjSVLsx/Y81RGt3rzOV1d0MI6PtGNtNqV6l+ezT9
         nrl4CeVg6KWHZ3qw7IbJrrtu5cKrtZRKrk7Op+WjCKIQNbUJ24NwnYGWu/n09sNqe7ey
         TBhg==
X-Forwarded-Encrypted: i=1; AJvYcCUSAh1ENjJVIDCOi97WQ/2fH9yJ33SK32EXRwf9aKuoa4e2j/Sz2yjyG5V0e/CnlfIjHiSZ4cgM/2sUhF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoTu1SFzLVUrFcUmrp7I2eAImey5no7KRs3fCjYtmzDnmf2aQq
	V03Pi+Fr/q62xFyev3Hvx1VXkxVkZ0i6U3Gr7wosuzJ9gHjQK9OJbIPgdpGXZFkHCTXP5i/I7v8
	fdidLa/qBsNN8TJbhRJ+qf6H6whnuiFR5bsTwM1Oe
X-Gm-Gg: ASbGncvQ13sV0aY05bm671i87NSQpMbA10jay2sWYHT6N0bKDO5NiFBOUThCSNgScDU
	GDxkQ8qm8Mz9Dv5/GrqCXcBHdlzi9dr1JuvSTjlOxU72nek0VN56xuFOGjRfRI8Rcf09PWCvPry
	pMpHaBJWNrlboq+viJnjAazHT/Yin1Dca81TdR02nYEveCxSuoob2FCMvEWd4JoSOFdFS3tEYgG
	zHiyI+pVmEX/0e6b73H2Xg+AfBVL84N9FFIsQ==
X-Google-Smtp-Source: AGHT+IGSlvqDxTRRJkQqtf4hvvV7KYTdebiMP+w38PyzSvhpseEo8lX+pnso50QM9KIimhueaXkUm8Tqe0OVIgM3GWg=
X-Received: by 2002:a17:90b:520a:b0:313:d346:f347 with SMTP id
 98e67ed59e1d1-31cc26143c1mr20619523a91.35.1753139544680; Mon, 21 Jul 2025
 16:12:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202507200931.7a89ecd8-lkp@intel.com> <20250721230018.3844892-1-kuniyu@google.com>
In-Reply-To: <20250721230018.3844892-1-kuniyu@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 21 Jul 2025 16:12:13 -0700
X-Gm-Features: Ac12FXzgZ91TFkYczQzKNEdydx7cKJzNzkwaAKyY78t5qzxxwRysdTn1wx2M3pQ
Message-ID: <CAAVpQUBROuDa2mSaq4AR9c9WO8W=Ziyv9CoH2kijPjTvq-gr8g@mail.gmail.com>
Subject: Re: [linus:master] [neighbour] [confidence: ] f7f5273863: Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]SMP_KASAN
To: oliver.sang@intel.com
Cc: edumazet@google.com, gnaaman@drivenets.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, lkp@intel.com, netdev@vger.kernel.org, 
	oe-lkp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 4:00=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> From: kernel test robot <oliver.sang@intel.com>
> Date: Sun, 20 Jul 2025 16:12:07 +0800
> > Hello,
> >
> > kernel test robot noticed "Oops:general_protection_fault,probably_for_n=
on-canonical_address#:#[##]SMP_KASAN" on:
> >
> > commit: f7f52738637f4361c108cad36e23ee98959a9006 ("neighbour: Create ne=
tdev->neighbour association")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >
> > [test failed on linus/master      f4a40a4282f467ec99745c6ba62cb84346e42=
139]
> > [test failed on linux-next/master d086c886ceb9f59dea6c3a9dae7eb89e780a2=
0c9]
> >
> > in testcase: boot
> >
> > config: x86_64-randconfig-123-20250718
> > compiler: clang-20
> > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m=
 16G
> >
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> >
> >
> > +----------------------------------------------------------------------=
------------+------------+------------+
> > |                                                                      =
            | a01a67ab2f | f7f5273863 |
> > +----------------------------------------------------------------------=
------------+------------+------------+
> > | BUG_RAWv6                                                            =
            | 7          |            |
> > | WARNING:at_mm/slab_common.c:#kmem_cache_destroy                      =
            | 7          |            |
> > | RIP:kmem_cache_destroy                                               =
            | 7          |            |
> > | UBSAN:signed-integer-overflow_in_include/linux/atomic/atomic-arch-fal=
lback.h     | 7          |            |
> > | Oops:general_protection_fault,probably_for_non-canonical_address#:#[#=
#]SMP_KASAN | 0          | 7          |
> > | KASAN:null-ptr-deref_in_range[#-#]                                   =
            | 0          | 7          |
> > | RIP:neigh_flush_dev.llvm                                             =
            | 0          | 7          |
> > | Kernel_panic-not_syncing:Fatal_exception_in_interrupt                =
            | 0          | 7          |
> > +----------------------------------------------------------------------=
------------+------------+------------+
> >
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202507200931.7a89ecd8-lkp@inte=
l.com
> >
> >
> > [   21.205230][    T1] systemd[1]: RTC configured in localtime, applyin=
g delta of 0 minutes to system time.
> > [   21.328503][    T1] NET: Registered PF_INET6 protocol family
> > [   21.412618][    T1] IPv6: Attempt to unregister permanent protocol 6
> > [   21.433405][    T1] IPv6: Attempt to unregister permanent protocol 1=
36
> > [   21.443410][    T1] IPv6: Attempt to unregister permanent protocol 1=
7
>
> Probably this is IPv6 module unloading path (init failed).
>
> Then, neigh_table_clear() calls neigh_ifdown() with dev=3DNULL,
> which is not handled in neigh_flush_dev().

I noticed the full stack trace was uploaded here and saw it was
during module initialisation.
https://download.01.org/0day-ci/archive/20250720/202507200931.7a89ecd8-lkp@=
intel.com


[   21.205230][    T1] systemd[1]: RTC configured in localtime,
applying delta of 0 minutes to system time.
[   21.328503][    T1] NET: Registered PF_INET6 protocol family
[   21.412618][    T1] IPv6: Attempt to unregister permanent protocol 6
[   21.433405][    T1] IPv6: Attempt to unregister permanent protocol 136
[   21.443410][    T1] IPv6: Attempt to unregister permanent protocol 17
[   22.737430][    T1] Oops: general protection fault, probably for
non-canonical address 0xdffffc00000001a0: 0000 [#1] SMP KASAN
[   22.738764][    T1] KASAN: null-ptr-deref in range
[0x0000000000000d00-0x0000000000000d07]
[   22.739736][    T1] CPU: 1 UID: 0 PID: 1 Comm: systemd Tainted: G
             T  6.12.0-rc6-01246-gf7f52738637f #1
[   22.740972][    T1] Tainted: [T]=3DRANDSTRUCT
[   22.741513][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   22.742641][    T1] RIP:
0010:neigh_flush_dev.llvm.6395807810224103582+0x52/0x570
[   22.743530][    T1] Code: c1 e8 03 42 8a 04 38 84 c0 0f 85 15 05 00
00 31 c0 41 83 3e 0a 0f 94 c0 48 8d 1c c3 48 81 c3 f8 0c 00 00 48 89
d8 48 c1 e8 03 <42> 80 3c 38 00 74 08 48 89 df e8 f7 49 93 fe 4c 8b 3b
4d 85 ff 0f
[   22.745585][    T1] RSP: 0000:ffff88810026f408 EFLAGS: 00010206
[   22.746292][    T1] RAX: 00000000000001a0 RBX: 0000000000000d00
RCX: 0000000000000000
[   22.747239][    T1] RDX: 0000000000000000 RSI: 0000000000000000
RDI: ffffffffc0631640
[   22.748176][    T1] RBP: ffff88810026f470 R08: 0000000000000000
R09: 0000000000000000
[   22.749092][    T1] R10: 0000000000000000 R11: 0000000000000000
R12: 0000000000000000
[   22.750004][    T1] R13: ffffffffc0625250 R14: ffffffffc0631640
R15: dffffc0000000000
[   22.750956][    T1] FS:  00007f575cb83940(0000)
GS:ffff8883aee00000(0000) knlGS:0000000000000000
[   22.752016][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   22.752799][    T1] CR2: 00007f575db40008 CR3: 00000002bf936000
CR4: 00000000000406f0
[   22.753770][    T1] DR0: 0000000000000000 DR1: 0000000000000000
DR2: 0000000000000000
[   22.754687][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0
DR7: 0000000000000400
[   22.755620][    T1] Call Trace:
[   22.756076][    T1]  <TASK>
[   22.761164][    T1]  __neigh_ifdown.llvm.6395807810224103582+0x44/0x390
[   22.763825][    T1]  neigh_table_clear+0xb1/0x268
[   22.768510][    T1]  ndisc_cleanup+0x21/0x38 [ipv6]
[   22.769257][    T1]  init_module+0x2f5/0x468 [ipv6]
[   22.770010][    T1]  do_one_initcall+0x1ba/0x628
[   22.788113][    T1]  do_init_module+0x21a/0x530
[   22.788469][    T1]  load_module+0x2550/0x2ea0
[   22.788823][    T1]  __se_sys_finit_module+0x3d2/0x620
[   22.790672][    T1]  __x64_sys_finit_module+0x76/0x88
[   22.791060][    T1]  x64_sys_call+0x7ff/0xde8
[   22.791408][    T1]  do_syscall_64+0xfb/0x1e8
[   22.796085][    T1]  entry_SYSCALL_64_after_hwframe+0x67/0x6f
[   22.796513][    T1] RIP: 0033:0x7f575d6f2719
[   22.796860][    T1] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00
00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b
4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b7 06 0d 00 f7 d8
64 89 01 48
[   22.798127][    T1] RSP: 002b:00007fff82a2a268 EFLAGS: 00000246
ORIG_RAX: 0000000000000139
[   22.798728][    T1] RAX: ffffffffffffffda RBX: 0000557827b45310
RCX: 00007f575d6f2719
[   22.799306][    T1] RDX: 0000000000000000 RSI: 00007f575d584efd
RDI: 0000000000000004
[   22.799880][    T1] RBP: 00007f575d584efd R08: 0000000000000000
R09: 0000557827b47b00
[   22.800463][    T1] R10: 0000000000000004 R11: 0000000000000246
R12: 0000000000020000
[   22.801038][    T1] R13: 0000000000000000 R14: 0000557827b470e0
R15: 00007f575dbb4270
[   22.801615][    T1]  </TASK>
[   22.801878][    T1] Modules linked in: ipv6(+)

