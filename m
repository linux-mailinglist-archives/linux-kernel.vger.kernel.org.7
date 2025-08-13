Return-Path: <linux-kernel+bounces-766559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F04B2481A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EADF564C1A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1C52F7454;
	Wed, 13 Aug 2025 11:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ZcORFi1n"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0ED2F658E
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 11:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755083529; cv=none; b=Jdw1mHsBr+PiYF1o8zh96TB+rAZAJBGFfahEQR7tYMKhO75kFjsdf4nLcVwgRJbdRTKPjxXLL+nvSx1+rLYM5dGgbXnP8CYxbobJWrE/LSXiQ12B4EDzQVz0I9kkzG+oVnwOet8wDYPEjh70NR1BUNlQamGEdJiE5wWUcTsZ94A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755083529; c=relaxed/simple;
	bh=RumpcH5saDr5rkkWY4Eh5pUdJgJSDjmpI3Loqz8eqTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZbvlckcvRBDDBo7G3jhpnD8+uupENe/hJmTAARBkauMgrylgiNmWwUO9qh7pWHAUQObgm+w2OdnCqmqbmM/CPsH+Fk9H99FP8svbxigy6OuOyx9Dyo7RBdmhMW41O085hVdLnmyFA8ajtuzBN+JYgoQi1ZCN7ymA3f9AkkVc8zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ZcORFi1n; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-33245e653bbso42041451fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 04:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755083525; x=1755688325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmXBa8hN6ZqYSD6brjbzokdUq7mqfbKeLxh7E9vySvQ=;
        b=ZcORFi1nTclepfN8dNuXpHBnGHeidqazTFAH/xxKUkFhzZBTVERRzuqpNz0wiN2RqG
         AyNjugQoJyZ8DJz4mcw2B9WO3/XqRiZgEljCwwS/MyVSRhuH4ivb2d3sQLiFvuRa5SP2
         gyRCvZuj6loipHtuMemWNDu7fufnBV1PhYLa2mj7wQXq469zu0evjLKVaIjZ98p8nCJc
         XMhDhTSO/8AJZiBc6leu7lD+/c94Z5gQDJqsIyZPyFOxfyFnePbhDhx4kXS4ys8798FA
         BL8mEleUaDZihhhUTu4oWUZ2UlNai/eZsXAYgLImJ/OqXwtOfb8ycgkiNi2m5/dARFb5
         2xRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755083525; x=1755688325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bmXBa8hN6ZqYSD6brjbzokdUq7mqfbKeLxh7E9vySvQ=;
        b=Yw52ErYHpuucJb7tHqxuNVQ4oWdDRGs5xjeY8cS9VUX1JUFQCIJCyAEbXusR6SGXV/
         cCAb6fjZ6njbA3j0RYEbRXJLDrEQYQGZD6cc/z5gx5sZ78hyDdZbyTKU2VIODYw8dvhj
         4uIXT9NJ1zHxy1SI2zp23nLuPADjRXeGs9qbs7e8094gsCMrlzVs8LfTXvD5O1RKnvMN
         kGG1xwqCj7CnoXHmlK05Qh+wzw7DV5jzt2F5sRVGvG15s+iOt71c+qMF6KANl14HJbjL
         TyPl2KYw7zIHLhWVwZt+2yfMmlQ5wpMrQIBH4Ahxc5JGLdkNGuNRveAjF3gHxG+mkgAw
         yoVA==
X-Forwarded-Encrypted: i=1; AJvYcCU5oU+FUIXBoT/ngk2QaCasLwmC5kFTe1J86HnjG7b3YlEjqpleUk6m+sw9rNHRUmgnkRhADC8M92mH2Z0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyweZPEOEvwz1PcWvHlWlMbnBh2Fo4PiN04k1XLDDZNZasTwwVx
	L4lLZp7ILyVrQ4sG7oYD+bbJdCeuchBZ99HnklhGYKEEhBbTpJqMdD3VxOnCxUUrODSYTR2r/UI
	aMy49YOlOlfo0fSwQPsOoGQNL7qdHfVpl0+9cjWAOKw==
X-Gm-Gg: ASbGncuGUMN2J/pExcxAGBF4y2IpSjakHfDWhdosClUytKIYZJ0aiyr9JMo3ZVj9Gt2
	AXDFWHD9HLlWW93+oJcmopp+H6KoP5Y4FkYgo+Nmp6k2r12jP9OuoF4qaLZD6wrhghwTbhyzQmt
	E3KfeG3ACpIe7MpVppXgQpDbHEWfIA6YFWBL0pEbmX3WdYIBqIMEUDCUJe8z74Ju4UefvzeUS52
	kpv+VPC/JAHKzdowlg=
X-Google-Smtp-Source: AGHT+IGEd6r2waO01iAvkk51fhRlxRdDrqcSDTW7/vuRbJY8YjAVRsk+nLOcZIVIYul5gLr7NlHXTJZ+irwpMk0V3Qs=
X-Received: by 2002:a2e:a987:0:b0:32b:3cf5:7358 with SMTP id
 38308e7fff4ca-333e9b56166mr8243791fa.28.1755083525285; Wed, 13 Aug 2025
 04:12:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515094301.40016-1-cuiyunhui@bytedance.com>
 <CAEEQ3w=XqoKmVu1kvc5XUbGbQJsHVkRx=T65tXvYEYo0HCTcnQ@mail.gmail.com>
 <aJs-aPH32OxpzR3G@sunil-laptop> <CAEEQ3wnHFPBPC0U59rDBJaZYxJ24uJzJ7NDQO0gfmVqoiQwNOw@mail.gmail.com>
 <aJtKZhvNX0p3obFw@sunil-laptop> <CAEEQ3wmomscuAzuiRyJu4ha8tiM=s1Y-ytQROPTWr1DScMNL3g@mail.gmail.com>
 <aJwiXKWXik8BmpL8@sunil-laptop> <CAEEQ3wky3LXK=ge1wBkHD0ZWtwUF-aBn44EK0Uxa+_2DB1Giqw@mail.gmail.com>
In-Reply-To: <CAEEQ3wky3LXK=ge1wBkHD0ZWtwUF-aBn44EK0Uxa+_2DB1Giqw@mail.gmail.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Wed, 13 Aug 2025 16:41:51 +0530
X-Gm-Features: Ac12FXwij-HOOV9nmq9qu8pUNs3gWFC5Oqu4FRciyKhMhr0sOhIZGTI0U05OUcI
Message-ID: <CAK9=C2VOaAJZxCeM-5QPj5B-ie68LivJyQcM8KwKjdL9u00RJg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] ACPI: RISC-V: CPPC: Add CSR_CYCLE for CPPC FFH
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: Sunil V L <sunilvl@ventanamicro.com>, rafael@kernel.org, lenb@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Rahul Pathak <rpathak@ventanamicro.com>, 
	juwenlong@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 12:14=E2=80=AFPM yunhui cui <cuiyunhui@bytedance.co=
m> wrote:
>
> Hi Sunil,
>
> On Wed, Aug 13, 2025 at 1:28=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.c=
om> wrote:
> >
> > Hi Yunhui,
> >
> > On Wed, Aug 13, 2025 at 11:23:39AM +0800, yunhui cui wrote:
> > > Hi Sunil,
> > >
> > > On Tue, Aug 12, 2025 at 10:06=E2=80=AFPM Sunil V L <sunilvl@ventanami=
cro.com> wrote:
> > > >
> > [...]
> > > > > > >
> > > > > > > The purpose of cppc_ffh_csr_read() is to calculate the actual
> > > > > > > frequency of the CPU, which is delta_CSR_CYCLE/delta_CSR_XXX.
> > > > > > >
> > > > > > > CSR_XXX should be a reference clock and does not count during=
 WFI
> > > > > > > (Wait For Interrupt).
> > > > > > >
> > > > > > > Similar solutions include: x86's aperf/mperf, and ARM64's AMU=
 with
> > > > > > > registers SYS_AMEVCNTR0_CORE_EL0/SYS_AMEVCNTR0_CONST_EL0.
> > > > > > >
> > > > > > > However, we know that CSR_TIME in the current code does count=
 during
> > > > > > > WFI. So, is this design unreasonable?
> > > > > > >
> > > > > > > Should we consider proposing an extension to support such a d=
edicated
> > > > > > > counter (a reference clock that does not count during WFI)? T=
his way,
> > > > > > > the value can be obtained directly in S-mode without trapping=
 to
> > > > > > > M-mode, especially since reading this counter is very frequen=
t.
> > > > > > >
> > > > > > Hi Yunhui,
> > > > > >
> > > > > > Yes, but we anticipated that vendors might define their own cus=
tom CSRs.
> > > > > > So, we introduced FFH encoding to accommodate such cases.
> > > > > >
> > > > > > Thanks,
> > > > > > Sunil
> > > > >
> > > > > As mentioned earlier, it is best to directly read CSR_XXX (a refe=
rence
> > > > > clock that does not count during WFI) and CSR_CYCLE in S-mode, ra=
ther
> > > > > than trapping to SBI.
> > > > >
> > > > No. I meant direct CSR access itself not SBI. Please take a look at
> > > > Table 6 of RISC-V FFH spec.
> > > >
> > > > > drivers/acpi/riscv/cppc.c is a generic driver that is not specifi=
c to
> > > > > any vendor. Currently, the upstream code already uses CSR_TIME, a=
nd
> > > > > the logic of CSR_TIME is incorrect.
> > > > >
> > ACPI spec for "Reference Performance Register" says,
> >
> > "The Reference Performance Counter Register counts at a fixed rate any
> > time the processor is active. It is not affected by changes to Desired
> > Performance, processor throttling, etc."
> >
> > > > CSR_TIME is just an example. It is upto the vendor how _CPC objects=
 are
> > > > encoded using FFH. The linux code doesn't mean one should use CSR_T=
IME
> > > > always.
> > >
> > > First, the example of CSR_TIME is incorrect. What is needed is a
> > > CSR_XXX (a reference clock that does not count during WFI).
> > >
> > > Second, you mentioned that each vendor can customize their own
> > > implementations. But should all vendors' CSR_XXX/YYY/... be added to
> > > drivers/acpi/riscv/cppc.c? Shouldn=E2=80=99t drivers/acpi/riscv/cppc.=
c fall
> > > under the scope defined by the RISC-V architecture?
> > >
> > No. One can implement similar to csr_read_num() in opensbi. We didn't
> > add it since there was no HW implementing such thing. What I am
> > saying is we have FFH encoding to support such case.
> >
> > > >
> > > > > It would be best to promote a specification to support CSR_XXX, j=
ust
> > > > > like what has been done for x86 and arm64. What do you think?
> > > > >
> > > > Wouldn't above work? For a standard extension, you may have to prov=
ide
> > > > more data with actual HW.
> > >
> > > This won=E2=80=99t work. May I ask how the current upstream code can =
calculate
> > > the actual CPU frequency using CSR_TIME without trapping to SBI?
> > > This is a theoretical logical issue. Why is data needed here?
> > >
> > As I mentioned above, one can implement a generic CSR read without
> > trapping to SBI.
> >
> > > Could you take a look at the "AMU events and event numbers" chapter i=
n
> > > the ARM64 manual?
> > >
> > As-per ACPI spec reference performance counter is not affected by CPU
> > state. The RISC-V FFH encoding is sufficiently generic to support this
> > requirement, even if the standard CSR_TIME cannot be used. In such
> > cases, an alternative CSR can be encodeded, accessed via an OS-level
> > abstraction such as csr_read_num().
>
> So what you're saying is that we should submit a patch like this, right?
>
> diff --git a/drivers/acpi/riscv/cppc.c b/drivers/acpi/riscv/cppc.c
> index 440cf9fb91aab..953c259d46c69 100644
> --- a/drivers/acpi/riscv/cppc.c
> +++ b/drivers/acpi/riscv/cppc.c
> @@ -66,16 +66,8 @@ static void cppc_ffh_csr_read(void *read_data)
>  {
>         struct sbi_cppc_data *data =3D (struct sbi_cppc_data *)read_data;
>
> -       switch (data->reg) {
> -       /* Support only TIME CSR for now */
> -       case CSR_TIME:
> -               data->ret.value =3D csr_read(CSR_TIME);
> -               data->ret.error =3D 0;
> -               break;
> -       default:
> -               data->ret.error =3D -EINVAL;
> -               break;
> -       }
> +       data->ret.value =3D csr_read_num(data->reg);
> +       data->ret.error =3D 0;
>  }
>
> If that's the case, the robustness of the code cannot be guaranteed,
> because the range of CSRs from different vendors is unknown.

ACPI FFH is allows mapping to any CSR.

>
> Since each vendor will define their own CSRs, why not formalize them
> into a specification?

The _CPC objects in the ACPI table point to platform specific mechanisms
of accessing CPPC CSR so it can point to a vendor specific CSR.

Regards,
Anup

