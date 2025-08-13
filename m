Return-Path: <linux-kernel+bounces-766630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A82AFB24937
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ABD2567A24
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472A82FE59E;
	Wed, 13 Aug 2025 12:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="LoJLhoB1"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA3A2F5323
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 12:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755087010; cv=none; b=L0fepzY23jz+L2+ul+tRX0qFPFCySry+mHGdeUDiVW3jDUzREGc+89tB+tqXPQ2YLqfpeJnymOpkiEd3sstz875q9LN5cdS/S5FWRoAip4La2S/vcd6Hz4GpJMTBZiyyZgiSbme98HHyga2wCKSkY+auuCDM5xYcbAOyRN6kri8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755087010; c=relaxed/simple;
	bh=XqGc7loUPHomIK0COGyJwSokh+fgd0ZLjYg/V2Jl0t8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMjmOS+JEWPpb80a35vFSKYnFy2YlUCj0ryQkCMK32PymWiLblWw7Qgtp7lqH1U5v552PVqodfSG2oOTqa93jNfMi4/ylE9HRvXozJAkajKG6dYw0Ip370sqlpdLwBxxa0JVh/BGf6JjDoeqv59IbAHFb8AJWJU0p99QS3/wKGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=LoJLhoB1; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76bd7676e60so5545385b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 05:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755087008; x=1755691808; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/ctp2F52pKzxtNKgofgxeub03+NpKxh47PZGccoc1Vw=;
        b=LoJLhoB1UHDUGTyvCtgRVm0kPYTEzVjiX+fg300VJMh8w9dBKZglGBNnP+l0H7A/9p
         UtltRyB5wwygYaHSBu7OStq/bmnuPiHJdwkxhNSrNRo8QANIBl3B+ytkuRTbFtThnSJs
         F6O8eF+WURFyTXV3K0vchc+y0ClrqzRC3m63I+kZl3BxppQ7mLrqui8ej6i6grXN4S/e
         s3s0RH+NKbVlrq+gOijYbuhFMCkwDsi4TsvF05OGh4qTR9K/7+FvuYNLAEo6Up+3/tF0
         uzR/X5Bqq3ukEnqGEVygmWb54WPs+dJzyKGERGoEnog//oKAxgRLQuESLH+hjNk/EjUM
         bkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755087008; x=1755691808;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ctp2F52pKzxtNKgofgxeub03+NpKxh47PZGccoc1Vw=;
        b=bHna5Xao4Bkg/VpNmAM5BmNgAj5XMSLRpcTxT0rf1FalOC0j0MTPRYXxVNWZqigl0V
         PMd1VtoVro6onplspqR6BareCvUjLHM8vXL31xhXnKxtdR390KNrxgvK3mIflYEelIkm
         HwvBbDATrOSY0xCIE0aF4oSS8UJYmKSivWHxA4n6to+gppkCYl6FqrJY3q3qmNtNhkZC
         WXXQ6HWlfdMmcZ260CIHf+mr88fH5r2BksGWkWzS18uj2lrCfhkNxH4boGzN6Wlv59wy
         jq9ud78e09MCXrbdugq2sa8QGi64IvO9jADgiBbP/9Grz10bUzYlYEQBojS/EdZ3Huj0
         CRBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFmZxDL+Q7ZRUXzl4cfkC4lTUnLxRDjy6oOm1WEC51uxuEwumB2R1gR6xkKYut8OHYHMpHooss7rYx5QQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YznM1/4giNbWmsmLpnSdgoVpL9vu7npyFH1KDKM+9mzPvThNZmR
	woeJ501R48+nTTyY8WNqj4zQi0KkwGgNfN6/XoF9OVrgMR2KJhkFl8kWTEELe8anvQE=
X-Gm-Gg: ASbGncsV6yiy85Q8jxWor57vrEOcz8Xl3j3JJBT7I4Oec1BbU5+WWRvdQjaxyhv6m6h
	JaQ3nq/+NSKLQnBeJdyhYVFy0wsE40stiKbQbg5hCY8wZy8HRCRJfrhx7+QGQDWdo8CLCGGkw/J
	1hYkJ7D/hHlS4acW/2zXrsNrefdiwKXActLoPAwy56XXoBIR5QtkhSZOmw3/oUuqhW5yzRaxxZM
	qJSFOdHlB/8MJmaxHGh2AiiZmJivC/U532TaSXZDHIg3zzOPNJRRN2WOk+K5ovGq+Fz9K7Xvuc6
	uoKXRTqZUgnLBqzwo5szScCtq1+6jkxO+Olq3sxjhonBfRL4v4M1mKhnZatydvUubmA+QsZlIk5
	IgzFRcO3A0XNSShJfzmgRafH2dw0=
X-Google-Smtp-Source: AGHT+IH0C1/qTJWpzJOf6elM3dBIKaaS5s0expNMa5K6zOI/s22YABkFFQ9Tsn3lSLcl6u9YJxSYzQ==
X-Received: by 2002:a05:6a00:848:b0:748:f854:b765 with SMTP id d2e1a72fcca58-76e20c9a0dcmr4330521b3a.4.1755087007920;
        Wed, 13 Aug 2025 05:10:07 -0700 (PDT)
Received: from sunil-laptop ([106.51.199.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfe9003sm31729375b3a.125.2025.08.13.05.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 05:10:07 -0700 (PDT)
Date: Wed, 13 Aug 2025 17:39:58 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: =?utf-8?B?6Z6g5paH6b6Z?= <juwenlong@bytedance.com>
Cc: yunhui cui <cuiyunhui@bytedance.com>, rafael@kernel.org,
	lenb@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>,
	Rahul Pathak <rpathak@ventanamicro.com>
Subject: Re: [External] Re: [PATCH] ACPI: RISC-V: CPPC: Add CSR_CYCLE for
 CPPC FFH
Message-ID: <aJyAlqd3U5Jq9ipy@sunil-laptop>
References: <20250515094301.40016-1-cuiyunhui@bytedance.com>
 <CAEEQ3w=XqoKmVu1kvc5XUbGbQJsHVkRx=T65tXvYEYo0HCTcnQ@mail.gmail.com>
 <aJs-aPH32OxpzR3G@sunil-laptop>
 <CAEEQ3wnHFPBPC0U59rDBJaZYxJ24uJzJ7NDQO0gfmVqoiQwNOw@mail.gmail.com>
 <aJtKZhvNX0p3obFw@sunil-laptop>
 <CAEEQ3wmomscuAzuiRyJu4ha8tiM=s1Y-ytQROPTWr1DScMNL3g@mail.gmail.com>
 <aJwiXKWXik8BmpL8@sunil-laptop>
 <CAHEos+Msmta3o-HvXoigmJGbD48333Kh8tU3j2D=w_G8gL+OQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHEos+Msmta3o-HvXoigmJGbD48333Kh8tU3j2D=w_G8gL+OQw@mail.gmail.com>

On Wed, Aug 13, 2025 at 12:06:11AM -0700, 鞠文龙 wrote:
> Hi Sunil，
> 
> > From: "Sunil V L"<sunilvl@ventanamicro.com>
> > Date:  Wed, Aug 13, 2025, 13:28
> > Subject:  Re: [External] Re: [PATCH] ACPI: RISC-V: CPPC: Add CSR_CYCLE for CPPC FFH
> > To: "yunhui cui"<cuiyunhui@bytedance.com>
> > Cc: <rafael@kernel.org>, <lenb@kernel.org>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <linux-acpi@vger.kernel.org>, <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>, "Anup Patel"<apatel@ventanamicro.com>, "Rahul Pathak"<rpathak@ventanamicro.com>, <juwenlong@bytedance.com>
> > Hi Yunhui,
> >
> >
> > On Wed, Aug 13, 2025 at 11:23:39AM +0800, yunhui cui wrote:
> > > Hi Sunil,
> > >
> > > On Tue, Aug 12, 2025 at 10:06 PM Sunil V L <sunilvl@ventanamicro.com> wrote:
> > > >
> > [...]
> > > > > > >
> > > > > > > The purpose of cppc_ffh_csr_read() is to calculate the actual
> > > > > > > frequency of the CPU, which is delta_CSR_CYCLE/delta_CSR_XXX.
> > > > > > >
> > > > > > > CSR_XXX should be a reference clock and does not count during WFI
> > > > > > > (Wait For Interrupt).
> > > > > > >
> > > > > > > Similar solutions include: x86's aperf/mperf, and ARM64's AMU with
> > > > > > > registers SYS_AMEVCNTR0_CORE_EL0/SYS_AMEVCNTR0_CONST_EL0.
> > > > > > >
> > > > > > > However, we know that CSR_TIME in the current code does count during
> > > > > > > WFI. So, is this design unreasonable?
> > > > > > >
> > > > > > > Should we consider proposing an extension to support such a dedicated
> > > > > > > counter (a reference clock that does not count during WFI)? This way,
> > > > > > > the value can be obtained directly in S-mode without trapping to
> > > > > > > M-mode, especially since reading this counter is very frequent.
> > > > > > >
> > > > > > Hi Yunhui,
> > > > > >
> > > > > > Yes, but we anticipated that vendors might define their own custom CSRs.
> > > > > > So, we introduced FFH encoding to accommodate such cases.
> > > > > >
> > > > > > Thanks,
> > > > > > Sunil
> > > > >
> > > > > As mentioned earlier, it is best to directly read CSR_XXX (a reference
> > > > > clock that does not count during WFI) and CSR_CYCLE in S-mode, rather
> > > > > than trapping to SBI.
> > > > >
> > > > No. I meant direct CSR access itself not SBI. Please take a look at
> > > > Table 6 of RISC-V FFH spec.
> > > >
> > > > > drivers/acpi/riscv/cppc.c is a generic driver that is not specific to
> > > > > any vendor. Currently, the upstream code already uses CSR_TIME, and
> > > > > the logic of CSR_TIME is incorrect.
> > > > >
> > ACPI spec for "Reference Performance Register" says,
> >
> >
> > "The Reference Performance Counter Register counts at a fixed rate any
> > time the processor is active. It is not affected by changes to Desired
> > Performance, processor throttling, etc."
> >
> >
> > > > CSR_TIME is just an example. It is upto the vendor how _CPC objects are
> > > > encoded using FFH. The linux code doesn't mean one should use CSR_TIME
> > > > always.
> > >
> > > First, the example of CSR_TIME is incorrect. What is needed is a
> > > CSR_XXX (a reference clock that does not count during WFI).
> > >
> > > Second, you mentioned that each vendor can customize their own
> > > implementations. But should all vendors' CSR_XXX/YYY/... be added to
> > > drivers/acpi/riscv/cppc.c? Shouldn’t drivers/acpi/riscv/cppc.c fall
> > > under the scope defined by the RISC-V architecture?
> > >
> > No. One can implement similar to csr_read_num() in opensbi. We didn't
> > add it since there was no HW implementing such thing. What I am
> > saying is we have FFH encoding to support such case.
> >
> >
> > > >
> > > > > It would be best to promote a specification to support CSR_XXX, just
> > > > > like what has been done for x86 and arm64. What do you think?
> > > > >
> > > > Wouldn't above work? For a standard extension, you may have to provide
> > > > more data with actual HW.
> > >
> > > This won’t work. May I ask how the current upstream code can calculate
> > > the actual CPU frequency using CSR_TIME without trapping to SBI?
> > > This is a theoretical logical issue. Why is data needed here?
> > >
> > As I mentioned above, one can implement a generic CSR read without
> > trapping to SBI.
> >
> >
> > > Could you take a look at the "AMU events and event numbers" chapter in
> > > the ARM64 manual?
> > >
> > As-per ACPI spec reference performance counter is not affected by CPU
> > state. The RISC-V FFH encoding is sufficiently generic to support this
> > requirement, even if the standard CSR_TIME cannot be used. In such
> > cases, an alternative CSR can be encodeded, accessed via an OS-level
> > abstraction such as csr_read_num().
>        As-per ACPI Spec，Both Reference performance counter register
> and Delivered Performance Counter are affected by CPU
> state。From ACPI Spec，“The Reference Performance Counter Register
> counts at a fixed rate any time the processor is active.”
>
> “The Delivered Performance Counter Register increments any time the
> processor is active, at a rate proportional to the current performance
> level, taking into account changes to Desired Performance”
> “ Processor power states include are designated C0, C1, C2, C3, . . .
> Cn. The C0 power state is an active power state where the CPU executes
> instructions. The C1 through Cn power states are processor sleeping
> states where the processor consumes less power and dissipates less
> heat than leaving the processor in the C0 state”. So the time csr can
> not meet this requirements.we need another csr, but not availiable for
> now.Either implement it as vendor-specific or create a community
> extension for all？
>
It is upto the interpretation. I am not sure what is "active" or
"etc" in the below statement.

"The Reference Performance Counter Register counts at a fixed rate any
time the processor is active. It is not affected by changes to Desired
Performance, processor throttling, etc."

Second, I don't see an issue if both reference and delivered counters
increment irrespective of idle state because ultimately the ratio
delta(delivered)/delta(reference) matters which will be same in either
case.

Thanks,
Sunil


