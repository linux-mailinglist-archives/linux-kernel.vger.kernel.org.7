Return-Path: <linux-kernel+bounces-889661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 63302C3E2B7
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 02:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 96A694E7281
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 01:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD822F9DBE;
	Fri,  7 Nov 2025 01:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ic3brTNw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D914B2F616C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 01:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762480568; cv=none; b=KEwciknEB/kTFjzkL4sGcVWIM5yoaAjA5bqAOwPd2aD8/mQ3ZYosKwd2/DuCl6wwo1urGlUWkJRxsVht+NIgytAeW0an6/1kX5gGcYzZxBtvbnkKF5/J+kpV1RAXg8QE+eLhnnoBg+JhCR0qMCJHCgwip4VSvGWNp++8VpGmNp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762480568; c=relaxed/simple;
	bh=U/5Gf2mYzxk1MNILsZoteKsMvo2KOHGu8VCc+rGrsOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HWTTRkI/8pLr3x0j+iq8NTink7F6pP7dwnZSPIzCVNoa9WbSeljV5M3uZtLSbgJns0ieRx2sCGC+WAJqbK4iR3KDyXpqe1EWXeQ0RU8EHLRIVbsBaCvnPb6Fh/o0LPLqSG4Iv8DU5kr0PlOqhed7IZsVvsS3vm+NSNHco0rEbzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ic3brTNw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DCBC2BC86
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 01:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762480567;
	bh=U/5Gf2mYzxk1MNILsZoteKsMvo2KOHGu8VCc+rGrsOg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ic3brTNwMLAorC+gxpbXti0fu+4P39P7xNE+9926SDPuVywzTMGimRlXqEcqXcj2q
	 w42JjQdQz7opAzxMRkARQUheMXtwU+tLteVfeWXLG7jw9YPut1dinZVQvnQ1XpeM7a
	 QL20di+/SejW8D1vwmB4FxLZ0oWaVqoYthUHDABkE+Zainu5ERUuWcihhdk+AdbFgr
	 NuEfgntV9bJ7CnLPyBqYESlojSf+s8o3UNcZSAce5QeEoGErFfflsZ3MeLpb6cCpO4
	 wI4i0U0Rwl3lKDxe4RKyFfM3AuIjDsfp35y/svfSWuEpXbYw3DR7LfArNS6Mo4SArz
	 +mY0rGY7CtPmg==
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so1085035e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 17:56:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUfPvRJvrKX/QR7QbQAO2PS26XPjGLl7G86JIu4/l0JCdgXP1j+VdCLHkpD7oDjp5zzU3tRsc8AT5G8Nos=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGuyfDkrwRXuloiR6bQObl8MqO2tlmh+JNw90R2jEnpJiuM9Tz
	owSZ5ImTX00qNtBHO1PnwR1ofAnDYe9gE94hd7bmGwxScl30VG3pj3L+S5IG1pzsl/VQLcfcw87
	v+p8U8eqXSGVyabs7YjRTGzs445QrN/U=
X-Google-Smtp-Source: AGHT+IEor+2dI4OqNs5NW5mjQ+1lwHQyr994AWzvFdgZaaQu0e1GxyccqrO1isGGhTB8B5q5jbjQHSC3VP0rbLBjI84=
X-Received: by 2002:a05:600c:444b:b0:477:3543:3a38 with SMTP id
 5b1f17b1804b1-4776bca7d60mr8818545e9.1.1762480565818; Thu, 06 Nov 2025
 17:56:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030135652.63837-1-luxu.kernel@bytedance.com>
In-Reply-To: <20251030135652.63837-1-luxu.kernel@bytedance.com>
From: Guo Ren <guoren@kernel.org>
Date: Fri, 7 Nov 2025 09:55:53 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ8TGWQWU8rKstGwuEz1hE97cgwzNsugzKzxwJdd-TNDg@mail.gmail.com>
X-Gm-Features: AWmQ_blwsNd28hWAF_kEz2l_K99GqHJ9hzdELZe5cCqxZ2WTM89bjodhPLNmRQU
Message-ID: <CAJF2gTQ8TGWQWU8rKstGwuEz1hE97cgwzNsugzKzxwJdd-TNDg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/4] riscv: mm: Defer tlb flush to context_switch
To: Xu Lu <luxu.kernel@bytedance.com>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	apatel@ventanamicro.com, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 9:57=E2=80=AFPM Xu Lu <luxu.kernel@bytedance.com> w=
rote:
>
> When need to flush tlb of a remote cpu, there is no need to send an IPI
> if the target cpu is not using the asid we want to flush. Instead, we
> can cache the tlb flush info in percpu buffer, and defer the tlb flush
> to the next context_switch.
>
> This reduces the number of IPI due to tlb flush:
>
> * ltp - mmapstress01
> Before: ~108k
> After: ~46k

Could you add the results for these two test cases to the next version?

* lmbench - lat_pagefault
* lmbench - lat_mmap

Thank you!

>
> Future plan in the next version:
>
> - This patch series reduces IPI by deferring tlb flush to
> context_switch. It does not clear the mm_cpumask of target mm_struct. In
> the next version, I will apply a threshold to the number of ASIDs
> maintained by each cpu's tlb. Once the threshold is exceeded, ASID that
> has not been used for the longest time will be flushed out. And current
> cpu will be cleared in the mm_cpumask.
>
> Thanks in advance for your comments.
>
> Xu Lu (4):
>   riscv: mm: Introduce percpu loaded_asid
>   riscv: mm: Introduce percpu tlb flush queue
>   riscv: mm: Enqueue tlbflush info if task is not running on target cpu
>   riscv: mm: Perform tlb flush during context_switch
>
>  arch/riscv/include/asm/mmu_context.h |  1 +
>  arch/riscv/include/asm/tlbflush.h    |  4 ++
>  arch/riscv/mm/context.c              | 10 ++++
>  arch/riscv/mm/tlbflush.c             | 76 +++++++++++++++++++++++++++-
>  4 files changed, 90 insertions(+), 1 deletion(-)
>
> --
> 2.20.1
>


--=20
Best Regards
 Guo Ren

