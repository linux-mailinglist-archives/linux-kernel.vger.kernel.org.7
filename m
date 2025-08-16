Return-Path: <linux-kernel+bounces-771993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 269D2B28D94
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 14:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA88BB02885
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 12:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D3D2C3745;
	Sat, 16 Aug 2025 12:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XT3aNHo/"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F59E23A9B3
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 12:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755346145; cv=none; b=VsnaiB3geVX3gR3n9zyGFUZRIeWbj2qe18JRE5S6SlWLICp9ijsmhAXWjYpfYX3t6lquXhw27k9EDAIcq5sthR1vC3LJcbw1iuZQWYtOuTPW2pADx9Fk3w41oAF2J3n26AzZrMbsiIXGgCO0E9FkNNZgNgJJpvNDOgJNswcGVyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755346145; c=relaxed/simple;
	bh=BQdz+cKs2UWpsQOgF/cnv3rmWkafkRt5BNXEXOjrnnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mQtFgESRREkQnZ2o+zvVvFU26vx0jz5WvawdFpmywhX4JLP5V+bB6JYEZ97/bBp4auB1D8FzjsFs5A3SYyL1PBbUPuY5t+T1dcQ1i/72P6bFYOIzggUdt4083OpsrLmi5rpPVs8ut3ERY+uaB26jnSpeYfrj9BpayOiTfDoauSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XT3aNHo/; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-323266d38c2so2848406a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 05:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755346143; x=1755950943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpVPKqIMRjG1jIEoidUQhmTjxrFW4mTmhNofpOPcJ/Q=;
        b=XT3aNHo/omfO7WuRZccUrdrGN/N5HdCajSdTnWBdaZ52wBP1bGaXeoishbtqVF9vQS
         UXreEwxzz00rN5nbYj/HVlpk0G2TEuVolj8F6wLDNjO4qFAb5VnSMwGatSKS/dEUyYru
         hjoflaP1N2EGAJCAwagHt0448/JYNKsK0wT3LrnJXs0UmL5G+kBOB5bYIoAVBaYo9/lw
         AS15xe+p1Z1rTSGfHdtXY2QVN9Xd4WZ4PbZil8zYQZsdKdM/Qfqpec6Nf6uerrBKB2V8
         9nm6H6utdhPp/dx5+ZwEniC8haOjYPcfVYgDVWTsFZrbfJ5ovW4gK7z80i+YKNYJiddj
         el5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755346143; x=1755950943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wpVPKqIMRjG1jIEoidUQhmTjxrFW4mTmhNofpOPcJ/Q=;
        b=H2EhbFPE5ZOaYHHs1adwVsoYlw2YgnJjWVfUkC77SYWbug+mpXJfxuXXXNhD860DnE
         Xz7gCJkhTyK3ENs26agj2ZNlIB3KARtsqicxTQZdgACBHroddJe57V/1bRCpT2V51wEI
         24sr9w/Jatnfzk+diFe5WZhRc9R1JfuZxgQRKD5opQZFde+pZTrkVI78BhQ1LbCpBUbg
         l8W+a6ZvSlK45vwim8CJHiOc3ecislJ9ir+iVcdnu57Pck9RVIWypssH6BD5EV94IWAY
         lJjSvhwFteasgzb/ft/axNekH8MwP3lcUKamqxKeVxY47hlzq+vCJS2XDvXTS8zC2BKE
         dt/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXhYKx1dYnZweS4BsvicW2nTs8bruAcdJKllSeSWgq7NyIs1xUG6WgCK6s1jUa8WpJLDepAKfYUyZWnCvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIFfOkLZva7m/S9QeAORwMYR0aTeUpvGIBcODo+LJ88BUy+bRr
	nrAyQs7ViMNwLwVtetWA8Bf+b4QAr5PcGZUKtaKoKFFX5XM17oxqUgO+6mvr96JRWDrMlfBWwQj
	ByG3VI6oBUnrPOWAkIr3CtFU14C3ORfY=
X-Gm-Gg: ASbGncuFmgCPtLlmr8R2Cy9Ba3F6zJ5qcSXQ/RnjNkgK49IvokjOdvC089HBsIDUQMz
	622a+Tsy4lG6+fBT9XD9rloRltFAdIqAj+ctQ59b06374BSFrkuyBkOu8fYkzWO0/mAjHJbM3wn
	RLG12mi6yVgXIHDrOgjzso5FX9/S+SCG0snScw4b+LKXspG1c4KyAIupFBVSHZlVlmmMsslATcK
	BfG5f8=
X-Google-Smtp-Source: AGHT+IFp3igzfT7b1x3uF1SAPKkko31LrckBVY3utWnFQOzj4rT/By0igPlF7ebUUtoB7GfI+bWiHnizZ34PAMUOVsA=
X-Received: by 2002:a17:90a:d885:b0:312:1ae9:152b with SMTP id
 98e67ed59e1d1-32341ef042emr7422913a91.23.1755346143115; Sat, 16 Aug 2025
 05:09:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729174332.3acd1a86@gandalf.local.home> <CAFLxGvxZJv_A+YKCxVcd4yxPXLhHD5L9VzkvbFKPytxXc5vWaw@mail.gmail.com>
In-Reply-To: <CAFLxGvxZJv_A+YKCxVcd4yxPXLhHD5L9VzkvbFKPytxXc5vWaw@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Sat, 16 Aug 2025 14:08:51 +0200
X-Gm-Features: Ac12FXzUD_KlGTJO48C4AJyU8X77ErffxNXRapw8zgoVTkT6cKIJJkmQhQZdRig
Message-ID: <CAFLxGvxxXPnF2BjoHycORATma_JUbMFET+z6YGD=YJgzESBO6w@mail.gmail.com>
Subject: Re: [GIT PULL] runtime verification: Updates for 6.17
To: Steven Rostedt <rostedt@goodmis.org>, Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, 
	Gabriele Monaco <gmonaco@redhat.com>, Nam Cao <namcao@linutronix.de>, 
	John Kacur <jkacur@redhat.com>, Tomas Glozar <tglozar@redhat.com>, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[Re-sending with Russel's correct mail address]

On Sat, Aug 16, 2025 at 2:04=E2=80=AFPM Richard Weinberger
<richard.weinberger@gmail.com> wrote:
>
> [Adding ARM folks]
>
> On Tue, Jul 29, 2025 at 11:43=E2=80=AFPM Steven Rostedt <rostedt@goodmis.=
org> wrote:
> > Linus,
> >
> > Runtime verification changes for 6.17
>
> [...]
>
> > - Add a vpanic() to allow for va_list to be passed to panic.
>
> This change is causing a regression on ARM32.
> panic() no longer shows a proper stack trace.
>
> With this change:
> [    2.943690] Kernel panic - not syncing: VFS: Unable to mount root
> fs on unknown-block(0,0)
> [    2.950101] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted
> 6.17.0-rc1 #176 NONE
> [    2.950509] Hardware name: Generic DT based system
> [    2.950865] Call trace:
> [    2.951722]  unwind_backtrace from show_stack+0x18/0x1c
> [    2.953111]  show_stack from dump_stack_lvl+0x54/0x68
> [    2.953312]  dump_stack_lvl from vpanic+0xf8/0x388
> [    2.953526]  vpanic from __do_trace_suspend_resume+0x0/0x50
>
> With commit  3f045de7f5 "panic: Add vpanic()" reverted:
> [    2.680077] Kernel panic - not syncing: VFS: Unable to mount root
> fs on unknown-block(0,0)
> [    2.690241] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted
> 6.17.0-rc1-dirty #177 NONE
> [    2.690832] Hardware name: Generic DT based system
> [    2.691339] Call trace:
> [    2.692530]  unwind_backtrace from show_stack+0x18/0x1c
> [    2.694283]  show_stack from dump_stack_lvl+0x54/0x68
> [    2.694536]  dump_stack_lvl from panic+0x110/0x31c
> [    2.694944]  panic from mount_root_generic+0x1fc/0x2ac
> [    2.695399]  mount_root_generic from prepare_namespace+0x200/0x258
> [    2.695723]  prepare_namespace from kernel_init+0x20/0x140
> [    2.695974]  kernel_init from ret_from_fork+0x14/0x28
>
> The change itself looks fine, so I suspect it uncovers a deeper
> problem with panic().
> Maybe it changes the stack layout enough such that dump_stack() on
> ARM32 is no longer
> able to walk it? I'm using gcc 15.1.1, if this matters.
>
> To reproduce the issue using qemu, build a multi_v7_defconfig zImage and =
run:
> qemu-system-arm -m 512 -M virt -kernel arch/arm/boot/zImage
> -no-reboot -nographic -append "console=3DttyAMA0 panic=3D1"
> It will fail to mount a rootfs and panic.
>
> --
> Thanks,
> //richard



--=20
Thanks,
//richard

