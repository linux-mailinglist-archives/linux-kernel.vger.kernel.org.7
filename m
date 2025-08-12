Return-Path: <linux-kernel+bounces-764927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FF0B228D2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55A5E3BCBFB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30A4283138;
	Tue, 12 Aug 2025 13:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OagxA+Kd"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691AB227E83
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 13:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755005546; cv=none; b=Pv65psNE1Qd6THruRGZSiJ7UwT8BVcGTAV1fUt6gIkOKLRZz22SSw4NWDjhq34vubkt06DvlmFxF8BrwhQ4+Ru49hwpAmGo9LOgwMHvZGWVTe/SwWxP04rrJp/rT67bhz32lSXpbgW4w961LXXnz9M0/ZB6sPABqF5D12761qp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755005546; c=relaxed/simple;
	bh=97DZ8nBHALwhUra4p+uJuSqwJI3vH9u6tlHUwXfe+5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ULZEB/nWcj/8pjIyfktxnoUqoOpU03dD6gx0h+Js4LBYi2xs2Ew8lXF77z2rufibnB1mFfQtGEUELPYjrG+Mq8dQ3YBiJ0onkMcnMkfjOLY+1zWtDQkiWUGwerXu8Chz98CKOEaEB2rAT3c5iMAX3NuyhisPB1wD47n85yrffIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OagxA+Kd; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-435d0a95c56so116131b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 06:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1755005542; x=1755610342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qKMJP6DIKNaNb9e/aM/CY6qYW/+/BiIO2tSY1DOCRC0=;
        b=OagxA+Kd1v/6rH6tdS8O3DVchj8koLoeEE1kTdE/LG6K4aQqxbVXEKaHvJF58cFOrO
         /tTjTlm1Z4ekgbJmujLVyIqFc6f7runN2pmDsGQOps5eJC6G+BBTpRbMf1wNoff9McmC
         OtzJF88xCfOcPQ6CG6A/8NmNFjfl4ynsWBxu2Hg0joOCP7tvrXj0CkRz35iJBMrHg4Hs
         71gPSPJjzMRXLas16iP9Y4Riyujw7sw5OBAOF+yymLPCR/3utSQgrSHxy5jTxZ5Z03Da
         B2TNL9vsjbEGmn+uHSu1sqD22rDpI4Kl3VzlyNbT1ZfdrPVM8beqnWe/CjYoXWQvERPA
         8shQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755005542; x=1755610342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qKMJP6DIKNaNb9e/aM/CY6qYW/+/BiIO2tSY1DOCRC0=;
        b=iCGsebHjmqGVwSdyBGjMP3WcUCCIOVdO88tQCt0oHLC901PymGVqNzYYupjfQMXWWC
         itrnv16jjzVVGYn40xh2kmwxgvkIdBq0qreOT/NJa8ffBtKwQsZ6M4uVh8quFEtFL8QU
         GQ5NW3gwEfA2C4MevDRiwmXuLjs9XA4iWtc8lJiHLgIjUnlqLksfo7ddk0a2P+k8iF6s
         FO4jnGBRYgqZcnZ/iW0iZ3tYu4FipL2d9Cn4320kGhU8gy/85rPtdpm/XJ0KR36NNCn2
         vC81+3Ed76NJII63hJaTbHUf2Cupf1gJ4RN67yHydxcEDIIVQQEEb0dekh6SJixtIPJ1
         TvRw==
X-Forwarded-Encrypted: i=1; AJvYcCXyLACewaxuqCop+lry/p/Q9n2xjnvVV3WfU1mza8oTnL1naZD7SKb3aFsYlq7yYPDnZosaRzxymUfFZV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5ojR7JSE/WBoVFqqbnVIbXh4Q+JMx73wgMyLLLVbWfrrGiBIR
	2coRnoGlyB06itgNII6jMV+NpxgZBU6JaYS0jWk385IEMnTEVMuyQE6KD/1BLi1lMdgriGyKMwe
	d+ypWZHSES+N98HAhmfkXGM4lDxUlQaCxdrLWk+DWNPMz/O9wTrl+ZROSyA==
X-Gm-Gg: ASbGnct9vroqkMG804FIy+Nml26ogAWNaTKsFdFrKhYEPNbG0IsLdHvTuNWztxr/VBq
	YQ36tC7YPFv5vqjvGTuHeYe3vUd0zIQXbuv+b2id01mh5UbASxMmgAdK9rJDL6ZnGFjSifR4OoJ
	YFvdh/lk9OOBZ9q4MReWK9y3dGxGYi3i/BvPDvYxYurFRQ7xL83Tdl77QBvE910VaFlKxmZQOJ/
	WPsm45TMO24LdSeRWZd
X-Google-Smtp-Source: AGHT+IF75Opbei0pOtMtFSYOAxsp8zj+N82lGQSRfSLagQ6UXFksL0Qth/N+YhLBTfQy9h6H44nrbm/bU7sjHpb/61c=
X-Received: by 2002:a05:6808:4f2b:b0:435:73d6:a3c5 with SMTP id
 5614622812f47-435c91d0663mr2191038b6e.28.1755005542352; Tue, 12 Aug 2025
 06:32:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515094301.40016-1-cuiyunhui@bytedance.com>
 <CAEEQ3w=XqoKmVu1kvc5XUbGbQJsHVkRx=T65tXvYEYo0HCTcnQ@mail.gmail.com> <aJs-aPH32OxpzR3G@sunil-laptop>
In-Reply-To: <aJs-aPH32OxpzR3G@sunil-laptop>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Tue, 12 Aug 2025 21:32:10 +0800
X-Gm-Features: Ac12FXzZDx2qdp0GWoD-x1Xk1VxI9-W9Mj81VMSYnU8MQ8i6GLOZDnFvumFdIFA
Message-ID: <CAEEQ3wnHFPBPC0U59rDBJaZYxJ24uJzJ7NDQO0gfmVqoiQwNOw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] ACPI: RISC-V: CPPC: Add CSR_CYCLE for CPPC FFH
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: rafael@kernel.org, lenb@kernel.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>, 
	Rahul Pathak <rpathak@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sunil,


On Tue, Aug 12, 2025 at 9:15=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> On Tue, Aug 12, 2025 at 07:25:44PM +0800, yunhui cui wrote:
> > Hi Sunil,
> >
> > On Thu, May 15, 2025 at 5:44=E2=80=AFPM Yunhui Cui <cuiyunhui@bytedance=
.com> wrote:
> > >
> > > Add the read of CSR_CYCLE to cppc_ffh_csr_read() to fix the
> > > warning message: "CPPC Cpufreq: cppc_scale_freq_wokrfn: failed
> > > to read perf counters".
> > >
> > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > ---
> > >  drivers/acpi/riscv/cppc.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/acpi/riscv/cppc.c b/drivers/acpi/riscv/cppc.c
> > > index 4cdff387deff6..c1acaeb18eac3 100644
> > > --- a/drivers/acpi/riscv/cppc.c
> > > +++ b/drivers/acpi/riscv/cppc.c
> > > @@ -69,11 +69,14 @@ static void cppc_ffh_csr_read(void *read_data)
> > >         struct sbi_cppc_data *data =3D (struct sbi_cppc_data *)read_d=
ata;
> > >
> > >         switch (data->reg) {
> > > -       /* Support only TIME CSR for now */
> > >         case CSR_TIME:
> > >                 data->ret.value =3D csr_read(CSR_TIME);
> > >                 data->ret.error =3D 0;
> > >                 break;
> > > +       case CSR_CYCLE:
> > > +               data->ret.value =3D csr_read(CSR_CYCLE);
> > > +               data->ret.error =3D 0;
> > > +               break;
> > >         default:
> > >                 data->ret.error =3D -EINVAL;
> > >                 break;
> > > --
> > > 2.39.2
> > >
> >
> > The purpose of cppc_ffh_csr_read() is to calculate the actual
> > frequency of the CPU, which is delta_CSR_CYCLE/delta_CSR_XXX.
> >
> > CSR_XXX should be a reference clock and does not count during WFI
> > (Wait For Interrupt).
> >
> > Similar solutions include: x86's aperf/mperf, and ARM64's AMU with
> > registers SYS_AMEVCNTR0_CORE_EL0/SYS_AMEVCNTR0_CONST_EL0.
> >
> > However, we know that CSR_TIME in the current code does count during
> > WFI. So, is this design unreasonable?
> >
> > Should we consider proposing an extension to support such a dedicated
> > counter (a reference clock that does not count during WFI)? This way,
> > the value can be obtained directly in S-mode without trapping to
> > M-mode, especially since reading this counter is very frequent.
> >
> Hi Yunhui,
>
> Yes, but we anticipated that vendors might define their own custom CSRs.
> So, we introduced FFH encoding to accommodate such cases.
>
> Thanks,
> Sunil

As mentioned earlier, it is best to directly read CSR_XXX (a reference
clock that does not count during WFI) and CSR_CYCLE in S-mode, rather
than trapping to SBI.

drivers/acpi/riscv/cppc.c is a generic driver that is not specific to
any vendor. Currently, the upstream code already uses CSR_TIME, and
the logic of CSR_TIME is incorrect.

It would be best to promote a specification to support CSR_XXX, just
like what has been done for x86 and arm64. What do you think?

Thanks,
Yunhui

