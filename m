Return-Path: <linux-kernel+bounces-765930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A952B2402F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8DB3687098
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 05:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A392BE7AF;
	Wed, 13 Aug 2025 05:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="hQmyiYqA"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB93289802
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 05:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755062887; cv=none; b=pngRTqZ0DpsDwlXCaD6OYhf/r3tUCUc89tLD9GpkKG+ZZbZUGb5yMWloawPsisCpaW0NPiEol+71QNHuMXxOj12T9T+B58A64qoAtYg8d4oQ7tIZVlRS6GK4s8ky5vr9Q6HO8DX8+puLwIJE3Q+nBlPr4oxbmTArfaaBhMUSJSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755062887; c=relaxed/simple;
	bh=I/9aELgKiKPnQtUz0VoPV56Xdz80tFsmydQ5Ipts5N8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aAxG8g1PBtTUKFybODNKiS5SPZYdJPHV2GNEqwQG7rJDu1sO0lJ88mmp+yExXsnR3AV2yQwiGwaoVds8B4fMAwCFbo+rctrzBSdfT8BDLZJOmFZnAs7prPcRKL+6hRwuBoWycdQw3Z+IMjKatyZxVMEPBqe/xUpx8NvQJi7TkD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=hQmyiYqA; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76bd2b11f80so5730729b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 22:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755062885; x=1755667685; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aju9Ezzu25BAlOrE4njOpI382Aihv6lGd4Ptk5SgQ+U=;
        b=hQmyiYqAuUGkv+m3k1gzbsFsz5c2YmHmYF/qhfI5H0XTQ2vVgvThD3lJZMBG3C/zX9
         NAVfIGOJ6SkCRbpk/ZLRrFxuDxetVArDykXKxOycfP22vsD/N2PQjLk8qrEdYzezvwKN
         dBn9G9OBs0AdE0F/eEn7SDIesQYCGUTdMlyEhR0sUKekIbsY/TW8b1aKUBx5MKKy+oGU
         HZPq4sW3RcgpppW/1ARoeV+6HlVWaF6iKdFP28jeAhta616aqGM4dOoYeh1MBAFd3cN5
         FGPMC6Ccseou7O8eGQfJ42/s3oArEuvQ0B5rwmgkatOFX9T+JctK0+WpKDds7AqfDJ7p
         2FoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755062885; x=1755667685;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aju9Ezzu25BAlOrE4njOpI382Aihv6lGd4Ptk5SgQ+U=;
        b=ZNpI8gz2fcxbCaaNkIIgGIrI7VnWv0VymHUQ5MQkAqe1CtW58W6z1NxKF1vqgkIwVZ
         UQ/J5CzUQ/yrD7GwU3xYZabxPB783L6uqXQSE6UOmYJJSDLC1VplyURcKy4oMndz0Qs6
         4qjYGeX85fGhWzabEbfzTWy8rEqRvrHh9X3eyCunrWh0/cL+VuDPebBtazvsCo509dV4
         Gw9bfOTaRoCoV5fx13Nme9QWISFr+Z5i1xPtNnbDhbs3KCrBSVI+8Z7z5U+g+24INMMb
         je9ejOAdFMsbY5pBA8Ao0d6QyHE9Y1IDQBweQcu6EvAuoLDBmWJgYoRyzvFPyQCTCnyI
         6QUw==
X-Forwarded-Encrypted: i=1; AJvYcCWRtdRPoQU64eLKWjuIT2XX3OtxBhZmrMJPU9iq/fzwZPVW5TyM4RCid9T/bDjIu6EgDEv+IFDERQChoz0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5P+PPa4EQTVTi0Sfe6vNkWYFfiSYh8/s0Ze/Kr1MCrHcnBfXL
	G60/il3g1pC5Y9V6l98nMu3hGAA8EGO4XKlgbD8Fxl0QioXpIL7qrlAIqA+T1alDaDc=
X-Gm-Gg: ASbGncuqhgiu7DUxOnoQlT8tB2nJGl4NcvAaVQQUjtxWhEFfVqf0M8HduW6dN13Q0yd
	cDtWGm8+dbuav+1/dAn8CF0OV4QA0cwj6nSve+AVA/yQ2mBO3jeHMHCPn3unyE7i2l8nK0x2TL/
	E/o6I5QkOX5AzJwqkLHRHdL/JQu8QlIICBHW4PfrQ1WKhalP7gRPfi4bPyNbwmwIwwwntVxWPM+
	A34yDlw3VcMtAUQSMvOvHtP/8jM1NewySQ9P2QCQBWQul/Ilut54acVoirMup1o9Uu7+n6lHhXR
	k3L2GO4G/0/VO65NH6n9ReLLh+LOh5ZmSuAZrvw83xoV79BTwnl7aclzgyieo+nVhx35H/3NTgy
	oXznSj7kRVUH15E+35+BlMpr1q+w=
X-Google-Smtp-Source: AGHT+IEWD1QrQHf15aacA8d3X+YH/g3HK5aeIT/ZRzGKWWsB4ySfzVLYRddBV3zOTrXlbUObhnp0Dw==
X-Received: by 2002:a17:902:c94c:b0:23f:d8e4:ded2 with SMTP id d9443c01a7336-2430d219063mr30698875ad.53.1755062885395;
        Tue, 12 Aug 2025 22:28:05 -0700 (PDT)
Received: from sunil-laptop ([106.51.199.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef658esm317511125ad.3.2025.08.12.22.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 22:28:04 -0700 (PDT)
Date: Wed, 13 Aug 2025 10:57:56 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: rafael@kernel.org, lenb@kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>,
	Rahul Pathak <rpathak@ventanamicro.com>, juwenlong@bytedance.com
Subject: Re: [External] Re: [PATCH] ACPI: RISC-V: CPPC: Add CSR_CYCLE for
 CPPC FFH
Message-ID: <aJwiXKWXik8BmpL8@sunil-laptop>
References: <20250515094301.40016-1-cuiyunhui@bytedance.com>
 <CAEEQ3w=XqoKmVu1kvc5XUbGbQJsHVkRx=T65tXvYEYo0HCTcnQ@mail.gmail.com>
 <aJs-aPH32OxpzR3G@sunil-laptop>
 <CAEEQ3wnHFPBPC0U59rDBJaZYxJ24uJzJ7NDQO0gfmVqoiQwNOw@mail.gmail.com>
 <aJtKZhvNX0p3obFw@sunil-laptop>
 <CAEEQ3wmomscuAzuiRyJu4ha8tiM=s1Y-ytQROPTWr1DScMNL3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEQ3wmomscuAzuiRyJu4ha8tiM=s1Y-ytQROPTWr1DScMNL3g@mail.gmail.com>

Hi Yunhui,

On Wed, Aug 13, 2025 at 11:23:39AM +0800, yunhui cui wrote:
> Hi Sunil,
> 
> On Tue, Aug 12, 2025 at 10:06 PM Sunil V L <sunilvl@ventanamicro.com> wrote:
> >
[...]
> > > > >
> > > > > The purpose of cppc_ffh_csr_read() is to calculate the actual
> > > > > frequency of the CPU, which is delta_CSR_CYCLE/delta_CSR_XXX.
> > > > >
> > > > > CSR_XXX should be a reference clock and does not count during WFI
> > > > > (Wait For Interrupt).
> > > > >
> > > > > Similar solutions include: x86's aperf/mperf, and ARM64's AMU with
> > > > > registers SYS_AMEVCNTR0_CORE_EL0/SYS_AMEVCNTR0_CONST_EL0.
> > > > >
> > > > > However, we know that CSR_TIME in the current code does count during
> > > > > WFI. So, is this design unreasonable?
> > > > >
> > > > > Should we consider proposing an extension to support such a dedicated
> > > > > counter (a reference clock that does not count during WFI)? This way,
> > > > > the value can be obtained directly in S-mode without trapping to
> > > > > M-mode, especially since reading this counter is very frequent.
> > > > >
> > > > Hi Yunhui,
> > > >
> > > > Yes, but we anticipated that vendors might define their own custom CSRs.
> > > > So, we introduced FFH encoding to accommodate such cases.
> > > >
> > > > Thanks,
> > > > Sunil
> > >
> > > As mentioned earlier, it is best to directly read CSR_XXX (a reference
> > > clock that does not count during WFI) and CSR_CYCLE in S-mode, rather
> > > than trapping to SBI.
> > >
> > No. I meant direct CSR access itself not SBI. Please take a look at
> > Table 6 of RISC-V FFH spec.
> >
> > > drivers/acpi/riscv/cppc.c is a generic driver that is not specific to
> > > any vendor. Currently, the upstream code already uses CSR_TIME, and
> > > the logic of CSR_TIME is incorrect.
> > >
ACPI spec for "Reference Performance Register" says,

"The Reference Performance Counter Register counts at a fixed rate any
time the processor is active. It is not affected by changes to Desired
Performance, processor throttling, etc."

> > CSR_TIME is just an example. It is upto the vendor how _CPC objects are
> > encoded using FFH. The linux code doesn't mean one should use CSR_TIME
> > always.
> 
> First, the example of CSR_TIME is incorrect. What is needed is a
> CSR_XXX (a reference clock that does not count during WFI).
> 
> Second, you mentioned that each vendor can customize their own
> implementations. But should all vendors' CSR_XXX/YYY/... be added to
> drivers/acpi/riscv/cppc.c? Shouldn’t drivers/acpi/riscv/cppc.c fall
> under the scope defined by the RISC-V architecture?
> 
No. One can implement similar to csr_read_num() in opensbi. We didn't
add it since there was no HW implementing such thing. What I am
saying is we have FFH encoding to support such case.

> >
> > > It would be best to promote a specification to support CSR_XXX, just
> > > like what has been done for x86 and arm64. What do you think?
> > >
> > Wouldn't above work? For a standard extension, you may have to provide
> > more data with actual HW.
> 
> This won’t work. May I ask how the current upstream code can calculate
> the actual CPU frequency using CSR_TIME without trapping to SBI?
> This is a theoretical logical issue. Why is data needed here?
> 
As I mentioned above, one can implement a generic CSR read without
trapping to SBI.

> Could you take a look at the "AMU events and event numbers" chapter in
> the ARM64 manual?
> 
As-per ACPI spec reference performance counter is not affected by CPU
state. The RISC-V FFH encoding is sufficiently generic to support this
requirement, even if the standard CSR_TIME cannot be used. In such
cases, an alternative CSR can be encodeded, accessed via an OS-level
abstraction such as csr_read_num().

Thanks,
Sunil

