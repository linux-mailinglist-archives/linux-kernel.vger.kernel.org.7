Return-Path: <linux-kernel+bounces-772233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF06B2903B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 21:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6623E1C27E28
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 19:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F8021171D;
	Sat, 16 Aug 2025 19:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4NKYckz"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F59D1369B4
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 19:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755372421; cv=none; b=hvJq3R2+DDr55esIVgv4VMosig2dnMg+uimsLePKwSNNxIT6nS8MQOWdSw548981bYeqlGCFw9xwGTAN53ZyuIetncHdU4hUbVG1TReVaVsNfjqW2YwYZYSrrYfTjwkz3xjocoFjvZ/Ilj5EdzkhwdZqczHfk8vnecRwvISqNCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755372421; c=relaxed/simple;
	bh=59i1KdYhQyBZVdxkknxZoC4bc2XLAJo0pGyhgxyMoCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c02KAFfFMcYOmNyYQzb/SPRYC1CV11QjyQQ4TB+jrwUtZExk56/PSKZexGGyRb1dBKqOiJqb+ARqIvS0hIS63oNyxGqSiNQsKr5BO5ZgkGVoRaKdDMoFSKXHI8xv6B3pbjFCSkYcO7lkeAd8MsAr0UvZD+LaFSssTqKIOgx2/rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4NKYckz; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-32326e09f58so3309673a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 12:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755372419; x=1755977219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98v+GQR37jUZrrhIVoXs1bpSTPReJ+eLN39iwkIPiQ0=;
        b=M4NKYckzzt3FaZ2n94dToZJtc60vPPFD8P+NjJ+TGE8Lpj/QJ7Q5+KHCK4YxNlqqTE
         zHQFq97Oiq3iTbPJfFU4n5G+khUlvxtKVLuBlq9yh/Hk5mPxZi0+CX21r3ad/ugdN4x9
         k4Omevak69Je/EYbrhPeQqGD1iQQ1kjs8hWm2raQ3MDv7Z4Oj4N7tlSu3k2uIBdNLUAY
         rNx+VyI9Lw92YrA/qawzz++m3C1UXseca+MyiNJtgrCKPRjuT6IDjL22ntrzWoy4AaXt
         nXFKiZy0y0Ld7TiotDb9dPBKJpdw23sRGqQDlTGvGlCksR5P5YMN6OXh9oBTZ3FL30D3
         qNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755372419; x=1755977219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98v+GQR37jUZrrhIVoXs1bpSTPReJ+eLN39iwkIPiQ0=;
        b=FQq7mUHCPvZcG4IvumSIEJ8vGUgG6AgH/0yBPuvA0y5ld7aejtLdKSsZEM9khoY6Az
         m4WqvYOZeYaLMhYnyP7lwa82YyoX0ih279W5WmmhWRlLvhWM5uLDv03GBHWJPi00kmGe
         8JEIcLZnmLXkUvBRPMeQFsMWQXdOuy564Hst5JLLgMIuBVuhQtk9eZN8dAaZNd5IoG4Y
         AQ5pQ2ov/w1CBDMWFVoH+69mciSUtLl+6Vch4PaF5hJAxk80TqTsudOKgYhcvyHNEdf1
         9DSHZ7t9I9qfHMbx7oCz8ZUh5vPzSRpDdAA1nIAve5pelMumVoS+Jo8PgverIS83xM/Y
         RnBw==
X-Forwarded-Encrypted: i=1; AJvYcCU03MXPIrFWoG5dZivALmrwYBSfbAqpHBytxzI2f+4t7sniuwZjPrXXpEDCicdU4rnfdZ1JZwZYvWkl7+w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb9WfPOEdvVFLnRmN3jdQRmITa3rvESyRbOW+70JT+CseNUxLP
	5Mc13F7fDZbwzYCCwWjqCCQDbiF+o1tQDXaA62ptuxm4pIyFlx4N363F5WLKRoqFFo0+LARsV16
	huFisJhqP49/yQe3eZDfzGxLjFDuljp4=
X-Gm-Gg: ASbGncvJEF/m8ngv2oDcg0+XRBZW62s0eL9Pp0MFcElx22vEsrq42NJlCnl38Y6b2gZ
	Kp6D3hp1S303WATKYpYeSLev0wyAz4dhuMdrzdUytuo147IHbjfMq3+g4FuvIl+GbMt+Z6rxpyp
	opY5qliCFnV2O0O/gjq4sgZfKeD7UsPdOMd3AyniYK15bW1hEqSMoTBf/6U2hGqv3/6O/kwPMRQ
	l1yWXI=
X-Google-Smtp-Source: AGHT+IEE9w0eDr0giKjZk20A1Pk3m05SaMmyflvdhQBUu+6YJyhI0rlrRT7NjlqjdN10aXpuWTwvHAh+BYrz/XNiSAo=
X-Received: by 2002:a17:90b:4b0d:b0:31f:11d6:cea0 with SMTP id
 98e67ed59e1d1-323421589e3mr9199868a91.27.1755372419504; Sat, 16 Aug 2025
 12:26:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729174332.3acd1a86@gandalf.local.home> <CAFLxGvxZJv_A+YKCxVcd4yxPXLhHD5L9VzkvbFKPytxXc5vWaw@mail.gmail.com>
 <aKCLGvmPLPwjyw13@shell.armlinux.org.uk>
In-Reply-To: <aKCLGvmPLPwjyw13@shell.armlinux.org.uk>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Sat, 16 Aug 2025 21:26:47 +0200
X-Gm-Features: Ac12FXzdBhCoG8V0CvvyVhmTbw1btQP3UQhsuJyyoAGbjZ60mJ7mUJQTmo-IeOg
Message-ID: <CAFLxGvwPwrG6KVsF=hKn1SmbC0yjLVjm6h8t1+qFE0GkO7rUbQ@mail.gmail.com>
Subject: Re: [GIT PULL] runtime verification: Updates for 6.17
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Steven Rostedt <rostedt@goodmis.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	LKML <linux-kernel@vger.kernel.org>, Gabriele Monaco <gmonaco@redhat.com>, 
	Nam Cao <namcao@linutronix.de>, John Kacur <jkacur@redhat.com>, 
	Tomas Glozar <tglozar@redhat.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 16, 2025 at 3:44=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
> > With this change:
> > [    2.943690] Kernel panic - not syncing: VFS: Unable to mount root
> > fs on unknown-block(0,0)
> > [    2.950101] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted
> > 6.17.0-rc1 #176 NONE
> > [    2.950509] Hardware name: Generic DT based system
> > [    2.950865] Call trace:
> > [    2.951722]  unwind_backtrace from show_stack+0x18/0x1c
> > [    2.953111]  show_stack from dump_stack_lvl+0x54/0x68
> > [    2.953312]  dump_stack_lvl from vpanic+0xf8/0x388
> > [    2.953526]  vpanic from __do_trace_suspend_resume+0x0/0x50
>
> Please lookup the value of __do_trace_suspend_resume in System.map.

Hm, I see it twice in System.map, both times non-global.
$  grep __do_trace_suspend_resume System.map
c0303098 t __do_trace_suspend_resume
c03c5758 t __do_trace_suspend_resume

>
> >
> > With commit  3f045de7f5 "panic: Add vpanic()" reverted:
> > [    2.680077] Kernel panic - not syncing: VFS: Unable to mount root
> > fs on unknown-block(0,0)
> > [    2.690241] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted
> > 6.17.0-rc1-dirty #177 NONE
> > [    2.690832] Hardware name: Generic DT based system
> > [    2.691339] Call trace:
> > [    2.692530]  unwind_backtrace from show_stack+0x18/0x1c
> > [    2.694283]  show_stack from dump_stack_lvl+0x54/0x68
> > [    2.694536]  dump_stack_lvl from panic+0x110/0x31c
> > [    2.694944]  panic from mount_root_generic+0x1fc/0x2ac
>
> Also please lookup mount_root_generic.

$ grep mount_root_generic System.map
c1c01814 T mount_root_generic

>
> > Maybe it changes the stack layout enough such that dump_stack() on
> > ARM32 is no longer
> > able to walk it? I'm using gcc 15.1.1, if this matters.

In the meanwhile I tried also with gcc 8.5, same problem.

> Also please check whether you're using frame pointers or the unwinder
> (CONFIG_UNWINDER_FRAME_POINTER or CONFIG_ARM_UNWIND).

With CONFIG_UNWINDER_FRAME_POINTER the stack trace is sane,
so only CONFIG_ARM_UNWIND is broken.
I kind of expected it the other way around...

--=20
Thanks,
//richard

