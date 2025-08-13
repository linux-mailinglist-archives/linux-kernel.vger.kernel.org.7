Return-Path: <linux-kernel+bounces-766089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC14B2422D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14DED17C0B5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFA02D5A0C;
	Wed, 13 Aug 2025 07:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WvM71BXW"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963E31D5CFB
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755068775; cv=none; b=dAeg8XnHESogY00lgTwh0MwdblsC3XsvUYeK0GRIs84vbs3F0Gn6Bbxa7MlAqrIHw7EJTmb7SEeROK6JC0s7+yKJkHlLtZBW3xKNSwuv5GSYLEcfHKxbRv/7ujZj0d6r+Y8hOi+0FmD4aXKEH85+CRapEf2PagMcVT5rs6J7j0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755068775; c=relaxed/simple;
	bh=PtdSp5iWVtuUEXNcYV6uE6O/YEoT4qmJW+fDKi6l7jM=;
	h=In-Reply-To:From:Mime-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XyUvzJisY7qvGMqIgMRFxkakU9yl6hZcoVlcZ3/D5xaM/99jTH9uYqPcmQs7xyjF88yZIFJsmrq5Jv3j4ZdZbt7Ngx1+PaP17H1CMRekdZlLsVDwiRKEcQxIw5ys0GAHrkvgsx7zZTwt//Gz4aAEBN/vMHCt6HIwAew2cw4Ln9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=WvM71BXW; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-717b580ff2aso62506397b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 00:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1755068772; x=1755673572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:from:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PtdSp5iWVtuUEXNcYV6uE6O/YEoT4qmJW+fDKi6l7jM=;
        b=WvM71BXWbwrVSn5BDBotKONSPe4o2j4v1Iu1AC0fzY7En8IVzCVIzdmHEfnxFiOV/5
         gma+AfG+HWMft1PWgk+WYdAyJ+whv4O6ceO7tyMRs7H07XvBvMxE/UNmKBK7j2CeukAZ
         bUe6NYeNOjSocz5n8y9ztE/D/GZfVkYBGDOBT6Mgz+o/gkDC6aCH0iepCY5PKBO9w6ql
         JRDovcdiwXq02jnwvk2QTcDqbRlxQtBYcZr9TAm/hmAxnVCHSMi/tF6uimzFC6zAavC+
         2cdvDa/AE6gd7nGSVD1cHiT28D4WNDJVBMP6+vi600+9Gnan8F4VKmoe+3lseqDW12vy
         N5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755068772; x=1755673572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:from:in-reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PtdSp5iWVtuUEXNcYV6uE6O/YEoT4qmJW+fDKi6l7jM=;
        b=WgIVGkidCoRQbuA2t2QxWNECZcrpwnbn9CecS3m6NgvjqwNVKC0e9tHWVeU6ow4bFW
         IZk4T5DDeLDfVDvhi2jLUcp+jJCp2vlHjbyukmwTozFyLCXB9rs6sSFbOzM00KJHlsLp
         8Djrsm3G80ROJZ+sBHNTxApI5MD25ndUt0HbMTfzb4K6Xoq+EcHGRn1PxQOj9njyQIc8
         r4mbQYktBcXS1gEC1jOAzP4AmFJZYAjw4iQIZaGBefzcrHBz3oHwq4zO35xavjJzrkno
         8lT/nJF3vDK9IlCFI4zRRNA6uuHYR5Ker43W7srRe98j3o8CWLi4HNWUVqZngrKGL8pb
         dqeg==
X-Forwarded-Encrypted: i=1; AJvYcCVGB4aTtqXQq+8MyCap+VOKJWisMuGmpypC68/5IDqXq+BTYFNYBIIzOhh40alIPDHYnia3xSznEtTpuCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YybOc2KmJS/jXyMaFYTliVt3eBiaBUBHgV0b6Hq7JeWunBuWEq+
	+3mg6yQjlmpIc2UnI0WKupFtyd030qT3xkJ/AoCSsJ6xq7GkB01p/2KRrNRUaqUy0Sj6jIYFCnM
	UbIab+8jCDX2TGUoSVDYO3PrrVJDl7K8bVgSuakz2tOAwDylT9tqz
X-Gm-Gg: ASbGncsTSW6mSdBvroVL0oRMhNfWRQMlRl7Txwp6Wb1UlQAvStr1d6kEcu4qtKe/ENN
	qGGGqKgmGo6Dtyv4zb0sb+w0sOWcZTDo2FMe8qstPWVzL1Fz7bOOGh743Wkl4vSaGrU+PHHqEUp
	eurbaZLntuEx9L4v0WQSE0p4ie+uygPeDZo7lylt/TjzIx5TEdO9wnS1tNIKQ597GPD7ytav53k
	D1mmgUYdg==
X-Google-Smtp-Source: AGHT+IFkYZGQ5UFq1DJG7B9DaXbAuz5u07Muc6GRQPoHlZABQ/34BaErIiBBF7gbzS0pwX3itRbzkH2ORAtbA9O+iQA=
X-Received: by 2002:a05:690c:6a82:b0:71a:2299:f0d8 with SMTP id
 00721157ae682-71d4e4459d7mr24656527b3.16.1755068772357; Wed, 13 Aug 2025
 00:06:12 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 13 Aug 2025 00:06:11 -0700
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 13 Aug 2025 00:06:11 -0700
In-Reply-To: <aJwiXKWXik8BmpL8@sunil-laptop>
From: =?UTF-8?B?6Z6g5paH6b6Z?= <juwenlong@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250515094301.40016-1-cuiyunhui@bytedance.com>
 <CAEEQ3w=XqoKmVu1kvc5XUbGbQJsHVkRx=T65tXvYEYo0HCTcnQ@mail.gmail.com>
 <aJs-aPH32OxpzR3G@sunil-laptop> <CAEEQ3wnHFPBPC0U59rDBJaZYxJ24uJzJ7NDQO0gfmVqoiQwNOw@mail.gmail.com>
 <aJtKZhvNX0p3obFw@sunil-laptop> <CAEEQ3wmomscuAzuiRyJu4ha8tiM=s1Y-ytQROPTWr1DScMNL3g@mail.gmail.com>
 <aJwiXKWXik8BmpL8@sunil-laptop>
Date: Wed, 13 Aug 2025 00:06:11 -0700
X-Gm-Features: Ac12FXwQ0nQlJfTEa1i-AjJVhuSoyHeH0mTWy48-Ivil9TUTsXgw1E4zWGClHkE
Message-ID: <CAHEos+Msmta3o-HvXoigmJGbD48333Kh8tU3j2D=w_G8gL+OQw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] ACPI: RISC-V: CPPC: Add CSR_CYCLE for CPPC FFH
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: yunhui cui <cuiyunhui@bytedance.com>, rafael@kernel.org, lenb@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>, 
	Rahul Pathak <rpathak@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sunil=EF=BC=8C

> From: "Sunil V L"<sunilvl@ventanamicro.com>
> Date:=C2=A0 Wed, Aug 13, 2025, 13:28
> Subject:=C2=A0 Re: [External] Re: [PATCH] ACPI: RISC-V: CPPC: Add CSR_CYC=
LE for CPPC FFH
> To: "yunhui cui"<cuiyunhui@bytedance.com>
> Cc: <rafael@kernel.org>, <lenb@kernel.org>, <paul.walmsley@sifive.com>, <=
palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <linux-acpi@=
vger.kernel.org>, <linux-riscv@lists.infradead.org>, <linux-kernel@vger.ker=
nel.org>, "Anup Patel"<apatel@ventanamicro.com>, "Rahul Pathak"<rpathak@ven=
tanamicro.com>, <juwenlong@bytedance.com>
> Hi Yunhui,
>
>
> On Wed, Aug 13, 2025 at 11:23:39AM +0800, yunhui cui wrote:
> > Hi Sunil,
> >
> > On Tue, Aug 12, 2025 at 10:06=E2=80=AFPM Sunil V L <sunilvl@ventanamicr=
o.com> wrote:
> > >
> [...]
> > > > > >
> > > > > > The purpose of cppc_ffh_csr_read() is to calculate the actual
> > > > > > frequency of the CPU, which is delta_CSR_CYCLE/delta_CSR_XXX.
> > > > > >
> > > > > > CSR_XXX should be a reference clock and does not count during W=
FI
> > > > > > (Wait For Interrupt).
> > > > > >
> > > > > > Similar solutions include: x86's aperf/mperf, and ARM64's AMU w=
ith
> > > > > > registers SYS_AMEVCNTR0_CORE_EL0/SYS_AMEVCNTR0_CONST_EL0.
> > > > > >
> > > > > > However, we know that CSR_TIME in the current code does count d=
uring
> > > > > > WFI. So, is this design unreasonable?
> > > > > >
> > > > > > Should we consider proposing an extension to support such a ded=
icated
> > > > > > counter (a reference clock that does not count during WFI)? Thi=
s way,
> > > > > > the value can be obtained directly in S-mode without trapping t=
o
> > > > > > M-mode, especially since reading this counter is very frequent.
> > > > > >
> > > > > Hi Yunhui,
> > > > >
> > > > > Yes, but we anticipated that vendors might define their own custo=
m CSRs.
> > > > > So, we introduced FFH encoding to accommodate such cases.
> > > > >
> > > > > Thanks,
> > > > > Sunil
> > > >
> > > > As mentioned earlier, it is best to directly read CSR_XXX (a refere=
nce
> > > > clock that does not count during WFI) and CSR_CYCLE in S-mode, rath=
er
> > > > than trapping to SBI.
> > > >
> > > No. I meant direct CSR access itself not SBI. Please take a look at
> > > Table 6 of RISC-V FFH spec.
> > >
> > > > drivers/acpi/riscv/cppc.c is a generic driver that is not specific =
to
> > > > any vendor. Currently, the upstream code already uses CSR_TIME, and
> > > > the logic of CSR_TIME is incorrect.
> > > >
> ACPI spec for "Reference Performance Register" says,
>
>
> "The Reference Performance Counter Register counts at a fixed rate any
> time the processor is active. It is not affected by changes to Desired
> Performance, processor throttling, etc."
>
>
> > > CSR_TIME is just an example. It is upto the vendor how _CPC objects a=
re
> > > encoded using FFH. The linux code doesn't mean one should use CSR_TIM=
E
> > > always.
> >
> > First, the example of CSR_TIME is incorrect. What is needed is a
> > CSR_XXX (a reference clock that does not count during WFI).
> >
> > Second, you mentioned that each vendor can customize their own
> > implementations. But should all vendors' CSR_XXX/YYY/... be added to
> > drivers/acpi/riscv/cppc.c? Shouldn=E2=80=99t drivers/acpi/riscv/cppc.c =
fall
> > under the scope defined by the RISC-V architecture?
> >
> No. One can implement similar to csr_read_num() in opensbi. We didn't
> add it since there was no HW implementing such thing. What I am
> saying is we have FFH encoding to support such case.
>
>
> > >
> > > > It would be best to promote a specification to support CSR_XXX, jus=
t
> > > > like what has been done for x86 and arm64. What do you think?
> > > >
> > > Wouldn't above work? For a standard extension, you may have to provid=
e
> > > more data with actual HW.
> >
> > This won=E2=80=99t work. May I ask how the current upstream code can ca=
lculate
> > the actual CPU frequency using CSR_TIME without trapping to SBI?
> > This is a theoretical logical issue. Why is data needed here?
> >
> As I mentioned above, one can implement a generic CSR read without
> trapping to SBI.
>
>
> > Could you take a look at the "AMU events and event numbers" chapter in
> > the ARM64 manual?
> >
> As-per ACPI spec reference performance counter is not affected by CPU
> state. The RISC-V FFH encoding is sufficiently generic to support this
> requirement, even if the standard CSR_TIME cannot be used. In such
> cases, an alternative CSR can be encodeded, accessed via an OS-level
> abstraction such as csr_read_num().
=C2=A0=C2=A0 =C2=A0 =C2=A0 As-per ACPI Spec=EF=BC=8CBoth Reference performa=
nce counter register
and Delivered Performance Counter are affected by CPU
state=E3=80=82From ACPI Spec=EF=BC=8C=E2=80=9CThe Reference Performance Cou=
nter Register
counts at a fixed rate any time the processor is active.=E2=80=9D
=E2=80=9CThe Delivered Performance Counter Register increments any time the
processor is active, at a rate proportional to the current performance
level, taking into account changes to Desired Performance=E2=80=9D
=E2=80=9C Processor power states include are designated C0, C1, C2, C3, . .=
 .
Cn. The C0 power state is an active power state where the CPU executes
instructions. The C1 through Cn power states are processor sleeping
states where the processor consumes less power and dissipates less
heat than leaving the processor in the C0 state=E2=80=9D. So the time csr c=
an
not meet this requirements.we need another csr, but not availiable for
now.Either implement it as vendor-specific or create a community
extension for all=EF=BC=9F

