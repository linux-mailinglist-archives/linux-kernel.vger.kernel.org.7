Return-Path: <linux-kernel+bounces-771988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB90B28D89
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 14:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B7CAAA05BD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 12:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CD8238C0B;
	Sat, 16 Aug 2025 12:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EU42HziR"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A8023A9B3
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 12:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755345889; cv=none; b=HAG6HgPuYL741OMHDeT9dz2fY1qAl62AX3+FCwlI9EZq4LHxWwoG15yThB/Q+c2MQd9qdQdIicJ55HRu80stDzJqwFa1HvpVQNInQ2oYMYwWKos/d0Gv2Lw80yGG+HjOUwBwI6FjB0Bf0bNe4he89XTfD7g5sXK1GzOqSnZINec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755345889; c=relaxed/simple;
	bh=mulRtUHIc8N/PIE49kqXvQyyxUYOjPvvgXlMpQ3e0+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VVxNiUB12kNjQRFs96iFPhd2nX73+ckeL/r9K+J2MqmF46FRQzYqUFWAVii9sQWwub76+lJtstWVd3wzLfwcFALx8Tv6Vg+5afaQe+V1E0P7gDjFiUK5sIPfUCG8FoyRg070VZ9ZyjX+yLvBit6LfCYCR9odQNspZIap9gAMA+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EU42HziR; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32326de9f4eso2515530a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 05:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755345887; x=1755950687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRXV44PwQfVfLgImJrTaANIWIbJbHaU92U/BzopGLSg=;
        b=EU42HziRA7BEvoHO2cKlQIMSEfeniIGWhK++CxVBH4OQTNC8/w2PqXzpf4O9KWnyIh
         PwWSyXKGftiQdBTpVaLLVsURwM/2mgrXoGI/pyu8H+sNIra6e3wzYYOunfLpIywH1FdA
         zwJ/CmmuSRsk92K8xdDE8oRHtT/Ws/dLe9sSAEe9kDtTe1mXmErVNSRK7MTR+frhygOX
         7NVMxN+n6BvCZ6HFV55KtLwhmpYV7L7dQRH2uEZ+/oIF1a4HGjWaa6CYfRsSBfFqrYNm
         nPyVfkqRtFvb2smPVYehB9eIxNcA07KAzoq3B7Hwuo1t65ThNzIHBElHwcuXSbO7+N9L
         u4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755345887; x=1755950687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IRXV44PwQfVfLgImJrTaANIWIbJbHaU92U/BzopGLSg=;
        b=ie9WWnQx7EVcZnKQZILQkJVcPrQ5M5AOjWjfAgtV2OY90Dnqd9gtGdBM+UePQ5RPCg
         WMWB3UhMmTwrKy1NcFQ5d0JPuuLocM8doQgXDQ4Bk6VV+FJRuE4pKcR47gCFC/YWRW8A
         4rx3g1WZgWcHuJzT46iNoxS66XlA4VsCu7zHV8ty4P+viUsaLlHaD2BwA+6aARlyH2Lx
         kQDOIAIjxkdKAl77NNh2u/1CJ3alPg6584Y2r07CAZYqq2sz7i4Cl4EdmNkj0iudLIMD
         ++P0JDfIXAY7fXlDt5gK4xJy5BiLKXzXXKW54zbUtO6ttDElOFdzPWULKuuF8j+E19rt
         eX/A==
X-Forwarded-Encrypted: i=1; AJvYcCXTYbAizRXfFzpsAoZDFmOI8BP3CWpN+PUiUVy19cDn35cM1s5kM1RRsOy/F5pS+oVNz6rr6mmIAWB7a9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNPNfG4CeBqr+ku12RubOT3vUFz07A6kG5JjeAdNPQFVQ9CIAV
	0Bt3ffMlyAakdP7lNwOGqDZmwX6+NlhFn57bSh9sOzVCi2XZDPpPB7JogtgU3gSzDtZDb1k4G2T
	VNMm25wGOrWq7vo6OOK/xlz79OIWIp48=
X-Gm-Gg: ASbGnctX8Hwtuucz5EBuWG/5Uqz5UQ//A+BDx2mZdKZRszsL885pd/dtmqaDmHJFVp7
	dAghVlWLCmOQWh74Tiix5vGa24rHXw8Q9MjBTWb2Y8G3FaDyttWHnhjpgn3APWsgcpUDrcqiBEf
	U4ljGBC2kVw8gxkjzqGOqV6GCsWuFu/gsHO/i3Kzo3+qdE2zjpP5tN0nwNtKFx1UH6r/R7KWTgV
	S2VR1c=
X-Google-Smtp-Source: AGHT+IEW1BFzCpzoqiXUOA9dcgpirpe98DZsv4T2hWuFQBIy8Cc9tbAXcYnphe1Vm1b/ToGV0aR8irsU9X8+iz/50nA=
X-Received: by 2002:a17:90b:5643:b0:321:9536:4b69 with SMTP id
 98e67ed59e1d1-3234223a401mr7394867a91.27.1755345886931; Sat, 16 Aug 2025
 05:04:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729174332.3acd1a86@gandalf.local.home>
In-Reply-To: <20250729174332.3acd1a86@gandalf.local.home>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Sat, 16 Aug 2025 14:04:34 +0200
X-Gm-Features: Ac12FXwfJHuPg0toK2krfbOjtNVdPZv0eGEVf1bRzqtiV5xVp7KgQjTukRbf9iY
Message-ID: <CAFLxGvxZJv_A+YKCxVcd4yxPXLhHD5L9VzkvbFKPytxXc5vWaw@mail.gmail.com>
Subject: Re: [GIT PULL] runtime verification: Updates for 6.17
To: Steven Rostedt <rostedt@goodmis.org>, rmk+kernel@arm.linux.org.uk
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, 
	Gabriele Monaco <gmonaco@redhat.com>, Nam Cao <namcao@linutronix.de>, 
	John Kacur <jkacur@redhat.com>, Tomas Glozar <tglozar@redhat.com>, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[Adding ARM folks]

On Tue, Jul 29, 2025 at 11:43=E2=80=AFPM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
> Linus,
>
> Runtime verification changes for 6.17

[...]

> - Add a vpanic() to allow for va_list to be passed to panic.

This change is causing a regression on ARM32.
panic() no longer shows a proper stack trace.

With this change:
[    2.943690] Kernel panic - not syncing: VFS: Unable to mount root
fs on unknown-block(0,0)
[    2.950101] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted
6.17.0-rc1 #176 NONE
[    2.950509] Hardware name: Generic DT based system
[    2.950865] Call trace:
[    2.951722]  unwind_backtrace from show_stack+0x18/0x1c
[    2.953111]  show_stack from dump_stack_lvl+0x54/0x68
[    2.953312]  dump_stack_lvl from vpanic+0xf8/0x388
[    2.953526]  vpanic from __do_trace_suspend_resume+0x0/0x50

With commit  3f045de7f5 "panic: Add vpanic()" reverted:
[    2.680077] Kernel panic - not syncing: VFS: Unable to mount root
fs on unknown-block(0,0)
[    2.690241] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted
6.17.0-rc1-dirty #177 NONE
[    2.690832] Hardware name: Generic DT based system
[    2.691339] Call trace:
[    2.692530]  unwind_backtrace from show_stack+0x18/0x1c
[    2.694283]  show_stack from dump_stack_lvl+0x54/0x68
[    2.694536]  dump_stack_lvl from panic+0x110/0x31c
[    2.694944]  panic from mount_root_generic+0x1fc/0x2ac
[    2.695399]  mount_root_generic from prepare_namespace+0x200/0x258
[    2.695723]  prepare_namespace from kernel_init+0x20/0x140
[    2.695974]  kernel_init from ret_from_fork+0x14/0x28

The change itself looks fine, so I suspect it uncovers a deeper
problem with panic().
Maybe it changes the stack layout enough such that dump_stack() on
ARM32 is no longer
able to walk it? I'm using gcc 15.1.1, if this matters.

To reproduce the issue using qemu, build a multi_v7_defconfig zImage and ru=
n:
qemu-system-arm -m 512 -M virt -kernel arch/arm/boot/zImage
-no-reboot -nographic -append "console=3DttyAMA0 panic=3D1"
It will fail to mount a rootfs and panic.

--=20
Thanks,
//richard

