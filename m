Return-Path: <linux-kernel+bounces-849166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30434BCF53C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 14:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B278189D909
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 12:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551708479;
	Sat, 11 Oct 2025 12:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLvDFj8u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDA93D76
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 12:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760185779; cv=none; b=UHUyjBFooXhXUp7G7TjoDfJLFiqnKtDOZvqLhhRuNXpkQr5JXpvXXaAmcF0nLHmxysURcSLVarYSFBZ4/v6YXw5EbQk0wHDr5uazAv/RrFB/O6QJjGq31J8VMSRpfh9RH5kNdp7LKb2XSc8jZzvLiqTiD/rs9LDFpxb695oM1Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760185779; c=relaxed/simple;
	bh=AJyI+USEssROQGBUbngOEIFkwlQ+dvsaob5VOR+LxJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PGE0ZN/1QxT1PjeFQYt2NIUMU08hVMoHy/5OOjpjyzausVO7hNKtfq5EP7pj8sochysquPnkhHHjWVQynJr4Bqz5iXJb4pFwCBV/DA4g/QsyVjmu0p3jWP1Y2wQnlRP1JIevR4uSug2xTGiD+iwbt2lkIga6D+eO1aYV5HPUSDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLvDFj8u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416FCC116C6
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 12:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760185779;
	bh=AJyI+USEssROQGBUbngOEIFkwlQ+dvsaob5VOR+LxJI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WLvDFj8uIbnjx4YwUngLF9ZAI6ZEPhWusSlbTsmxXnpXMIXTgs6D2YAnb6I1sgbyp
	 /S4fB4bQFIbE6AAIYi3OuR/XKTXqRB9GHgiO4ikjYjaFvH7w3r/LUdtSdzUyUr7kQh
	 w7SdZgCosB3lQNXXtMEpby7NHxh3/hBpkDLGXyp3bOIb+Ab1+Ls9FKZlrSGP15X9dU
	 LDpegdYALRd1FqHJKhklXDMRZIGJMWWgTug9qszpe76PTvjaSA/mU10jtNutxWGB1C
	 vBaUmgvjxYqouRqcMAjkr/kxxNioq0ZoTGMJm47t6CbrWYpS+JxClsx/G27MUmsXE7
	 M0m2k85pfZiYw==
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7b97ce4fc60so937095a34.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 05:29:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVSwLSjHkvUXN6PZnZlUQjuNr4UJFjSTdsxHHyooS48r9iDsxpqZT8LoclNNQF8qLkJajb38fIGyAPTxbg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8ROCyFKT+rEJEYIZayBp7DRCbkjQrU4PcCQXOMUIEDdVpXdbJ
	0vmjHdMTC3IFjSLkTayXyaDS9BnzjFma/p5FNe/bUg6l74gdfDd5NAWgXlYWGiRrcSK4mlV+/jC
	5EMHj8lgWpheY88Z15uiUPCZFnSp4Op0=
X-Google-Smtp-Source: AGHT+IGMhLvweltXd/z9viHewXgalSXCevVEspM2R9C/Jv3qQPUruwLZfqpzE4MJQKCOMiPC/2Dz2gwfPhYkxh05uuA=
X-Received: by 2002:a05:6808:4fd1:b0:43f:7dee:468b with SMTP id
 5614622812f47-4417b34652fmr6615070b6e.4.1760185778571; Sat, 11 Oct 2025
 05:29:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3914183.kQq0lBPeGt@rafael.j.wysocki> <20251011085052.1237082-1-tianyaxiong@kylinos.cn>
In-Reply-To: <20251011085052.1237082-1-tianyaxiong@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 11 Oct 2025 14:29:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gitV7vk1=-1r57SPaQLFnNLXMrXowKMzvm1ebmhse0-g@mail.gmail.com>
X-Gm-Features: AS18NWCg7K1uiOjaOJA2fXNOZxoWBCp2PR-KSKbvja-gfWA5lGdlvioFfGVd9s4
Message-ID: <CAJZ5v0gitV7vk1=-1r57SPaQLFnNLXMrXowKMzvm1ebmhse0-g@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] cpufreq: intel_pstate: Simplify the energy model
 for hybrid systems
To: Yaxiong Tian <tianyaxiong@kylinos.cn>
Cc: rafael@kernel.org, christian.loehle@arm.com, dietmar.eggemann@arm.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, lukasz.luba@arm.com, 
	srinivas.pandruvada@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 11, 2025 at 10:51=E2=80=AFAM Yaxiong Tian <tianyaxiong@kylinos.=
cn> wrote:
>
> > Since em_cpu_energy() computes the cost of using a given CPU to
> > do work as a product of the utilization of that CPU and a constant
> > positive cost coefficient supplied through an energy model, EAS
> > evenly distributes the load among CPUs represented by identical
> > one-CPU PDs regardless of what is there in the energy model.
> >
> > Namely, two CPUs represented by identical PDs have the same energy
> > model data and if the PDs are one-CPU, max_util is always equal to the
> > utilization of the given CPU, possibly increased by the utilization
> > of a task that is waking up.  The cost coefficient is a monotonically
> > increasing (or at least non-decreasing) function of max_util, so the
> > CPU with higher utilization will generally get a higher (or at least
> > not lower) cost coefficient.  After multiplying that coefficient by
> > CPU utilization, the resulting number will always be higher for the
> > CPU with higher utilization.  Accordingly, whenever these two CPUs
> > are compared, the cost of running a waking task will always be higher
> > for the CPU with higher utilization which leads to the even distributio=
n
> > of load mentioned above.
> >
> > For this reason, the energy model can be adjusted in arbitrary
> > ways without disturbing the even distribution of load among CPUs
> > represented by indentical one-CPU PDs.  In particular, for all of
> > those CPUs, the energy model can provide one cost coefficient that
> > does not depend on the performance level.
>
> But if the cost is a constant that does not depend on performance levels,
> then the energy increment for running a waking task on these CPUs would b=
e
> the same. For example, for a task with utilization u, whether it is place=
d
> on CPU A or CPU B, since the cost is the same, the energy increment gener=
ated
> would be identical. In this case, EAS should not perform load balancing
> between them.

Right, what matters is the delta between base_energy and energy
including the waking task utilization.

I got confused somehow, sorry for the noise.

