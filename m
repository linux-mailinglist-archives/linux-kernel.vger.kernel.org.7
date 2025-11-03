Return-Path: <linux-kernel+bounces-882353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B1AC2A3E8
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 08:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BEFBD348085
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 07:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7535296BB7;
	Mon,  3 Nov 2025 07:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dVqvSxGm"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509C48BEC
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 07:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762153581; cv=none; b=o1OibNF6Sh36Spcg0aKBQVcRdzU2dJuz12Vm5E/xXoper17g7H2KmOxT9RYWURkMDIJJQnI1fnyzDO1T/xn3jSX78D4vhuujMJnn+JzrGJmojW2Sq5+ULKXV19KZVuP/hVwUUtH8vrL6aIWM2JdgF3POtJmLcT590lqEqM7sNQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762153581; c=relaxed/simple;
	bh=V9kZk7aDttowYt2sRVc1YEbJxKJWumtA/NFXWZXBdXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QGJevBOm3qXQGhHmbqMhgjMlSefaEmLpMo1VPDtt3G6g42Iw4HX4CGETs76iqDXSBZWcCyb3TBBkZ/q3hlVReDHgShLv75JeDE7jKppZgaBxkTdtC3iFvqmJWp9UzSrZRbyXiayxlxBUi7DCp3jOjqqnStltvkfEfQbzP01g98A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dVqvSxGm; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-932dfe14b2eso3951250241.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 23:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1762153578; x=1762758378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tM0Sqypkfd4cHla6u/iD2a2fQj8h1TXcjtOfoShr5LM=;
        b=dVqvSxGmh1DyHvJdEpaw45aLqAXuk+vmlRpaWznpFjgax4ce+OysMbv6Zx74he7tGr
         30jvG2oYGdfksYX+GP6SRTtWaz4v8nA/fnB3fBe/+e7UkVYZuJLza4r+WXl3GMoxJP6y
         oTHxd/d0PQGFMQoNGK+xPi51/ngGGkf4YHGNkRbjAj3l2X9yEFCVvYS6O9P7wfyIDY27
         jm06utD3cePpaaSEU0HZk4JD0GCnsgYCjf+wIond5ezuNLwX/qeJFNNofYancD64mwNQ
         iyV8ToIQ8UUAFzWLGKldH8TkvTUqNifZjjCgPAuIXkcD3TJxdTB1/zIHPqPQa8s/aemS
         ucnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762153578; x=1762758378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tM0Sqypkfd4cHla6u/iD2a2fQj8h1TXcjtOfoShr5LM=;
        b=g1Yyn1M7ZE0s2oIg+xNOkU2XN/6qWqMhizQbeTAV2jz7qxJ2NX7n/aB8sj6Y7ljRVG
         8xVbtZrAscxnqgKAUXOf1vLw/IRPAtmef7Hkfzk+kc5P9wsPwtwjfwrbtuuFZonvUPP1
         OoMYBNDqkAzRVV7K4IPSkyPEmeQxaVSyvqoPbiQ4hEjUBxPonz0U3IIrL0Q5v/tZgu0U
         nU6TAxI8UtwpXjtx19ShAkm+FU0uhS2dyiHQ3vkasfT0WXk7eMvD3ARPUuDRlpm6CHxE
         sFQM6b+MJEYUxIRD87d2VAE//22S42MNHoci5XyitH+Bc+ODPcTCeBBcSRLxbQ/8MEvs
         GsEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyyh6peRYf9pUlou15/9gF02hEBGvy+atsAoWxTdE2qz54GavFnTeZhQzpr8GocdkotYCiCVJe5FC7c20=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5iRMFf+Qa9wC4jVz7iJCRcczCvoSZH3LblFpzHUQLGZW77xKW
	NfNdIH4UKLRn877Yd3rIRhwJODBjkR/82h8BeS3yll6v2A0OtVzRCy/cOG4oRUlipdgFdX7V/t/
	gRGYXqPLtH5VPZbzmdvJEuRog4kWKQGtTZ8WDTbjLlw==
X-Gm-Gg: ASbGncvheEubSqtbb9r1JIeuNQ9ODd9UsrA4VHDNw/6vTq8n6+DcMJmac//B6CLbSFO
	2finvrclVUShVIHp5N4pdY62XGFW3fokFkAfMjgaYRvR96ls+1WDM4fyxxmUPIAMg6oXMrYwqX1
	DY4HVYgSRQ4wmWB7/OsVQcSDGLj7imLUYg6O/ngZNvtnDc5tGjCOqXhYcv04L1aQljTmromYa4Z
	9Y6MH4CxqWtSMjdW8fqXXY6RLssSVSyEeBinvC/N1Xto1B4Fw+n7d4+p4cH0+F1bj4wAQtQ/Q==
X-Google-Smtp-Source: AGHT+IHs7mrx8xpghTxCygkbFuODwxkRSqgnQiUmt0E1D8mvwqeld1pU1o4DKGqdJdKB++BoFlBnzksyDL+T6NFPCRk=
X-Received: by 2002:a05:6102:3f4d:b0:5d7:e0ea:8d25 with SMTP id
 ada2fe7eead31-5dbb136920cmr3565508137.38.1762153578086; Sun, 02 Nov 2025
 23:06:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030135652.63837-1-luxu.kernel@bytedance.com> <CAJF2gTTi1=LfmCaMi9vzvUdcqRDqRDRVJ3KEPWdHamk6N01R0w@mail.gmail.com>
In-Reply-To: <CAJF2gTTi1=LfmCaMi9vzvUdcqRDqRDRVJ3KEPWdHamk6N01R0w@mail.gmail.com>
From: Xu Lu <luxu.kernel@bytedance.com>
Date: Mon, 3 Nov 2025 15:06:07 +0800
X-Gm-Features: AWmQ_bmSmZSzIQbr9n7toOdwbaCLdxgSh2Kz3cYihKFgvG7bBn-obgRM3r47pBw
Message-ID: <CAPYmKFtW+T0+=3uVHukTN0BDMMszAez+d342NMRC1xJOmFvVrQ@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH v1 0/4] riscv: mm: Defer tlb flush to context_switch
To: Guo Ren <guoren@kernel.org>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	apatel@ventanamicro.com, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Guo Ren,

On Mon, Nov 3, 2025 at 11:44=E2=80=AFAM Guo Ren <guoren@kernel.org> wrote:
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
> Great result!
>
> I've some questions:
> 1. Do we need an accurate address flush by a new queue of
> flush_tlb_range_data? Why not flush the whole asid?

Flushing the whole address space may cause subsequent tlb misses.
Consider such a case: there is only one user mode thread frequently
running on the target hart. When the user thread falls asleep and cpu
context switches to idle thread, another thread of the same process
running on another hart modifies the mapping and needs to perform tlb
flush. The first user mode thread will encounter a large number of tlb
misses when it resumes. I want to try to balance the ipi count and tlb
misses.

> 2. If we reuse the context_tlb_flush_pending mechanism, could
> mmapstress01 gain the result better than ~46k?

Besides lazy tlb flush, another way to reduce ipi overhead is to clean
mm_cpumask. And it does gain a better result for mmapstress01. I have
sent a patch[1] which clears mm_cpumask whenever flushing all tlb of a
certain asid and it reduces the ipi count from ~98k to 268.

As was mentioned in the previous email, in the next version, I will
supply the mm_cpumask clear procedure. Specifically, I will flush all
tlb of an asid and clear mm_cpumask whenever it hasn't been scheduled
after enough context switches.

[1] https://lore.kernel.org/all/20250827131444.23893-3-luxu.kernel@bytedanc=
e.com/

> 3. If we meet the kernel address space, we must use IPI flush
> immediately, but I didn't see your patch consider that case, or am I
> wrong?

Nice catch! Forgot to add the kernel ASID judgment logic in the
shoulded_ipi_flush function. I will supply it in the next version.

I have considered canceling ipi and deferring the tlb flush to the
next time target hart enters the s mode if the target hart is now
running in user mode. But there are too many kernel entry points to
consider, especially now we have sse. For kernel tlb flush, it may be
more secure to send ipi. Thanks.

Best Regards,
Xu Lu

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

