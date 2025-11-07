Return-Path: <linux-kernel+bounces-889713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CC0C3E4BB
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 04:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 835233ACE96
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 03:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C243322FE0A;
	Fri,  7 Nov 2025 03:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QyfXIyWn"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE582040B6
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 03:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762484602; cv=none; b=Z6tvo7XXoqKq68zkcXBZBJ3RNAPjzmFFzHNrY2nFQSI8mNFDNddbIx+ItvkNciqt+GIXnNRlWScM+I6BerUP458JjIrBN9iqqAtxOkT2fd3q+VdTDhKbo85NDwu56Offr2w2jmSdSXi6Hy0FanhNZIW0PBds9DC4M8WczM9Z154=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762484602; c=relaxed/simple;
	bh=Z+oXLy8iNUgOcsespwiutXubLwQjvouxXGCbipu0sOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eDa9H+ohB909NKrBiLCwCIjajGseV64k5Ixr/026vd6vrCBTK4f5HXTiDZdAGEozAVtKjlUhcqqfz9rkRUw5NIiTVNITpTJI4VzAimJVQj3GW6OxGkm7f6l0jNd63ohkBYsCmzYssVF7geIdHKZ8zVY8G4JyStDX/a5SX0tC+TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QyfXIyWn; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-93514afb23dso178809241.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 19:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1762484599; x=1763089399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IroOHHwKYkiVIAKakQ8I70mb4O9KcHsXhYng7ogWZ7Y=;
        b=QyfXIyWnAKOyZMy0dBSAtC2CL+r0ytcJfuP1CeTlHU2vmKhyeyIh7WTvVJHKGraapm
         DNOXckS366cDOL6pf/r/NSPpcyeUcsHfsD0Xp3lskhupYX903E4sz1nqV1cZN+mF5zUi
         Sq/KSP74ZcjU/zQ81yDtyHMlg+7VtNn26HQtUH3MrN9W8ndnqqUDePb1xBmR4rzL+yww
         HN/+oiMZEm4Bg0VUTbf8qBreRVZCNQ19fmCa0wpMQWm4Dct/ZCA3bk8cdSwBFeTtHxqW
         Yr4pX8WyP2tCGZ2Qhe2i3OuhkpHm9m+R/IDGO0dfhqhXxhsg0eX1KLqRHACSel7SLI/a
         GaoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762484599; x=1763089399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IroOHHwKYkiVIAKakQ8I70mb4O9KcHsXhYng7ogWZ7Y=;
        b=MGSUEA1vhd+N+Aiy5fzm/n6BaXfezF2dPh8mYGhTEBUphCY8HhzbB0p5A+qQM5mjGD
         IgpPVTxFDxF38vcbXKQ3SIeabp08XgUMpn6OgUVPJ8K9VvaXkEYILm5iIZxwTBHwXX82
         1WU1GfGEY2K+DMXdURhJFE98YtYRJ4fo4/KL3ffrpUww8DEPoEYkik7Kpj6UFV3rYW4F
         7Oze1E0YIXE71Tb6NgJ5qc7f91QQgy9RTk1nAKknqd1/3tly1Jtfrk9UP5vaXsjgB4Yy
         ZMywARWslMTFWk6auncTOOSYB0Qi793cozpVErZJz9DvqM1AplijR6NsantxMjsqlsM6
         3omg==
X-Forwarded-Encrypted: i=1; AJvYcCV+pS7qFP1g8mIp5uT49A8yu7ts2X2nMTzj4XfhdGSoap+EWlkemMCvk+g8AdAkswsGAvcFcVA8LVnktvY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7LA0nsm/PBOoAtUFLUjjL3GP5hqaS5d5UJ0GNKWh19lZvSyIH
	xCmO5iOd3SGZAQ+B0fgjYDPR6dl+TqVhDTM6RtPCsIZ7kLn0Amr/IRpJHPqRFqOtEEeGN4KGW0U
	TOiNg+yZyumxKxreLaZbbzeiTKyXTmRNYCKQUkm777g==
X-Gm-Gg: ASbGncs6n10q58c6JpIhylotbK2XRKofvsqrxkyl3vkMBPfhpKfy2vcHD2t+IRSNica
	toa/hvLiz6UaVSmBLJdnYXN2PaNyeF7tTsh1bFKjoPdcHJ6CvkYR3Bns46Cs/IVfEJQaYuAGY6D
	gRgK9JQukX7NvSYFtswUYkxsUINYnxtyTU8SE1GPETu6U/gVB70oKPMddBcRgEOb8Dzn57KHSsN
	UPXu419F0CQpgpG0/D1z6z6h54A7Yvk6wUGqrXiOk3JEEUAgbH0dQg/7DvO0tQPpcFYEZ5HIi9m
	xQ8gJusy
X-Google-Smtp-Source: AGHT+IHYxdX8uI6XTg2hpwUlTY+AGxtiKgpLWOxoD+YcGsGPPNadx5W9DaiEtKxbj4fY31N8+HaRLrzXWfnL9LKVtA0=
X-Received: by 2002:a05:6102:ccb:b0:534:cfe0:f85b with SMTP id
 ada2fe7eead31-5ddb22561a2mr722708137.20.1762484599334; Thu, 06 Nov 2025
 19:03:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030135652.63837-1-luxu.kernel@bytedance.com> <CAJF2gTQ8TGWQWU8rKstGwuEz1hE97cgwzNsugzKzxwJdd-TNDg@mail.gmail.com>
In-Reply-To: <CAJF2gTQ8TGWQWU8rKstGwuEz1hE97cgwzNsugzKzxwJdd-TNDg@mail.gmail.com>
From: Xu Lu <luxu.kernel@bytedance.com>
Date: Fri, 7 Nov 2025 11:03:07 +0800
X-Gm-Features: AWmQ_blu0vLpTSKdzSVtCk3uQ59k-Xep1rAbenoTFJjftixB__jtRfFIz-1szOM
Message-ID: <CAPYmKFuopwQcDeCymuavTgC8crGg7Jb5Bs=hbnTtFvM+9X8HKg@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH v1 0/4] riscv: mm: Defer tlb flush to context_switch
To: Guo Ren <guoren@kernel.org>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	apatel@ventanamicro.com, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 9:56=E2=80=AFAM Guo Ren <guoren@kernel.org> wrote:
>
> On Thu, Oct 30, 2025 at 9:57=E2=80=AFPM Xu Lu <luxu.kernel@bytedance.com>=
 wrote:
> >
> > When need to flush tlb of a remote cpu, there is no need to send an IPI
> > if the target cpu is not using the asid we want to flush. Instead, we
> > can cache the tlb flush info in percpu buffer, and defer the tlb flush
> > to the next context_switch.
> >
> > This reduces the number of IPI due to tlb flush:
> >
> > * ltp - mmapstress01
> > Before: ~108k
> > After: ~46k
>
> Could you add the results for these two test cases to the next version?
>
> * lmbench - lat_pagefault
> * lmbench - lat_mmap

Roger that. Thanks for your supplement.

>
> Thank you!
>
> >
> > Future plan in the next version:
> >
> > - This patch series reduces IPI by deferring tlb flush to
> > context_switch. It does not clear the mm_cpumask of target mm_struct. I=
n
> > the next version, I will apply a threshold to the number of ASIDs
> > maintained by each cpu's tlb. Once the threshold is exceeded, ASID that
> > has not been used for the longest time will be flushed out. And current
> > cpu will be cleared in the mm_cpumask.
> >
> > Thanks in advance for your comments.
> >
> > Xu Lu (4):
> >   riscv: mm: Introduce percpu loaded_asid
> >   riscv: mm: Introduce percpu tlb flush queue
> >   riscv: mm: Enqueue tlbflush info if task is not running on target cpu
> >   riscv: mm: Perform tlb flush during context_switch
> >
> >  arch/riscv/include/asm/mmu_context.h |  1 +
> >  arch/riscv/include/asm/tlbflush.h    |  4 ++
> >  arch/riscv/mm/context.c              | 10 ++++
> >  arch/riscv/mm/tlbflush.c             | 76 +++++++++++++++++++++++++++-
> >  4 files changed, 90 insertions(+), 1 deletion(-)
> >
> > --
> > 2.20.1
> >
>
>
> --
> Best Regards
>  Guo Ren

