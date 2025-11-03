Return-Path: <linux-kernel+bounces-882247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC90C29FC4
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 04:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5359188F13E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 03:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9DB2882CD;
	Mon,  3 Nov 2025 03:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpMZNyB1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1BF1684B0
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 03:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762141480; cv=none; b=gRd1dY+1j+iSPM3jMjsb3IJxXswuyv4lFjX3KW0Zb7+oLu6JJReAxFkHxolrbEFRvSXYhJmaA4AVCR2ZtslqhUF8ycJbFgXb+MIvRdOsZN/FzKmlmNDmutvukoHjTf0NELPFzDKdGyZFIMGN5FFD1AJ+2NTbNYoVCPbPc5Hbp+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762141480; c=relaxed/simple;
	bh=4AFAXNkKcaOcnR6vhsrUWpV/8CEIBLI5x/Z+Qu0dr9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DvZEN9MgXCtMCLeA8zaqPEOoLOgqhm7DYk2W+zJKsCgF58NAJUqmHqaywJHwmQLYIy/xr8VkvDcr7f6EHH+0KsSnJ3/hijfwxTlWs25ziwtgVBh7KI4LfFlNW6Sbnez5pzK/bXVGfrweY2DHxNari0MHsIuBbA41pbe9FHxEEls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpMZNyB1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1528EC16AAE
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 03:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762141480;
	bh=4AFAXNkKcaOcnR6vhsrUWpV/8CEIBLI5x/Z+Qu0dr9s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OpMZNyB1V9/sPoyFYBmL5a0tN0c3kh2fFdpJ1v2ON3XehRykZ+K1BJadGRWkHs/uU
	 LoR/MmFnfONaGTT+KZHiHJc8+eHjOMyKlVFYnpm5jA9UewIECy1z1cTlhUnm6t5HWg
	 SGJexdV2zvzq8CCe+Id+ksP3WkzFgJYJ88LcJRNQVz6fQbgGuJ0V91FT2TdCsd//KD
	 JoJg4+kLR0z6EZyTi9Gg7Q8mEOhXJ9ufYydTRNFgdJLH1ADXX4FEwrk5bt+Am5mVFU
	 WxUc9RL5W07YmAxzuaoLqXOB3Mi69q9R1yECxMCbFRVOMNTt41Y7hHN/lWKD6LV3sB
	 j6/HnEgJPFYdA==
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-429c7869704so1753306f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 19:44:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVZd8VLZ+Hyv95cMe8tbVcUwsfK0Zsx3wHE50aAOYssNbBGT5frwb68bYo3lexmhlrsgyussqYuR78OT4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg1d7JLi1+abwCsc36vcxeVdj8hDdvJACoQSUpp5r7ARcTtxQX
	mLc0AhftQPBTN+b8Dh6VViyzYAbPkk08EBWXcN22pQbdb2BLew/IB0GQDHO4EZESrocxW9NJPaU
	JFmDeDl450MlPmnsaZnQUu8IlSvLItcI=
X-Google-Smtp-Source: AGHT+IEkRmRc5XeVSedzsO4yQqj7NniTjW7qsPuRsj/aC6ozhk5nvDc1TGdpavdkBKeAP/hE69r2ZNcp3d3iH5d7qY8=
X-Received: by 2002:a5d:5d11:0:b0:425:825d:2c64 with SMTP id
 ffacd0b85a97d-429bd6801aamr8766463f8f.17.1762141478635; Sun, 02 Nov 2025
 19:44:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030135652.63837-1-luxu.kernel@bytedance.com>
In-Reply-To: <20251030135652.63837-1-luxu.kernel@bytedance.com>
From: Guo Ren <guoren@kernel.org>
Date: Mon, 3 Nov 2025 11:44:25 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTi1=LfmCaMi9vzvUdcqRDqRDRVJ3KEPWdHamk6N01R0w@mail.gmail.com>
X-Gm-Features: AWmQ_bkMtbGH4DczTxT6oIArwMuBPA1I5yu6EgbGTXcignxiYJGggRhy2O4V1C8
Message-ID: <CAJF2gTTi1=LfmCaMi9vzvUdcqRDqRDRVJ3KEPWdHamk6N01R0w@mail.gmail.com>
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
Great result!

I've some questions:
1. Do we need an accurate address flush by a new queue of
flush_tlb_range_data? Why not flush the whole asid?
2. If we reuse the context_tlb_flush_pending mechanism, could
mmapstress01 gain the result better than ~46k?
3. If we meet the kernel address space, we must use IPI flush
immediately, but I didn't see your patch consider that case, or am I
wrong?

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

