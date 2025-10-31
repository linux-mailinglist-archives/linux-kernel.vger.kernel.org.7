Return-Path: <linux-kernel+bounces-880392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2C2C25AC7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCE981A646A7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1A734FF6A;
	Fri, 31 Oct 2025 14:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INfepiow"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F249834D4EA
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761921819; cv=none; b=RgzMBks1ku/sDmJE4roqB2vE2mxdhoayhH2RAax8d7iADlm0q+E5ONGKTPwUr3dwTJdmMCGgk1Wk+wzSdE8zvFjmprT8ktdTV6KapDb6iCw+PxlxkPh/cfMbsZr6Ndpuct11qBNQ+dIBXusWe3Y9cVG4lG1KWMBMgZ9CIPWe1lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761921819; c=relaxed/simple;
	bh=8IPyz7Lhv5KyWKaq5zE+9UfU8/iIcWDO5jzXmbQ5cxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J4xN5g8+RL5M08CjEfWmyOazc0QygQUjbbwy+z7nbMJBogTwtcmTwM9wJ5X/KC1Jo2oWwicPeYEl2CoFJinA4CoH/+vlNwwahRlq873BURyi1vngLRCS45wJfmxORIhwclswwh+OIbHkxXf5xw3a7xIXgW44ZSbXrpiBqgaPxJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INfepiow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90577C19421
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761921818;
	bh=8IPyz7Lhv5KyWKaq5zE+9UfU8/iIcWDO5jzXmbQ5cxY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=INfepiowY+amdCjQUKz50Ct+nJhS8b9zZSoNT9eVulgNszw0t9qEGx8GEDHWc2Ww4
	 tMqdTXxZs722W8v8XFp8iiyiPVWDrwsyoed8pinm+1xdGFMQ/pP3ER0+j3Xryro47z
	 DwBVLHkBdqERR+PYz49jBlhrqvqpY0gaf1PE8/zloUD+HXnNPSEopNOsdJY5csTdyY
	 AbdLF/5chO5JSAyjH3yjmXaAW1nka867cQS/F0I5el6XIeVAO3khU0sYwCoCOkJyBE
	 pIaO7lzFUWIz5Urn4tUHHRmnaROM9a9dReMT1X7VeDGxT1JdXyvMPqU1qq9fdrEO+L
	 nQrL62r561+aQ==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-378d50e1cccso25064531fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:43:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW272e4a5ZWCKM0gAXgZm6p4QytOTWPkAj8abpTPNK+JLcyItTWSjN+QLWRLgqR321ZVqRIuBb+C7PB0ts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/lFNclWju7NQt8HAg9cbd9XtbmNX9+YAM7BgtrZ0NwngdNyhu
	TMYuWwXcdwIZLGP4zE6sfoXHhU5QScqhMIortWb5eAM3tN8zlEzAUvML08Hd5fzkk43Rfdxr4UC
	xdskbyOIveBu2dGvspYdkTJasuqLiTmg=
X-Google-Smtp-Source: AGHT+IHaX6XhxpDmLWs98ej5e7lEgF0NryAzLIKNDpZXgeVs0xi4zEdB6QqREU+IxX5eVFFIElk4wyYP4z3FjdnOlm4=
X-Received: by 2002:a2e:a54c:0:b0:375:d6a3:d0b3 with SMTP id
 38308e7fff4ca-37a18dcd2eamr13190561fa.32.1761921816771; Fri, 31 Oct 2025
 07:43:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028105637.769470-1-usamaarif642@gmail.com>
 <20251028105637.769470-3-usamaarif642@gmail.com> <20251031144002.GMaQTKQnpp2u493ZZS@fat_crate.local>
In-Reply-To: <20251031144002.GMaQTKQnpp2u493ZZS@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 31 Oct 2025 15:43:25 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEwfYqTG2R8m8+t=DLFsBY3wxSm1b70DyK2gu_TF-L4wQ@mail.gmail.com>
X-Gm-Features: AWmQ_blJUfruneDE2dzygVriOJUi9BYISDmjBiX9xKWV9cyDsAujcjwJjl7MD8M
Message-ID: <CAMj1kXEwfYqTG2R8m8+t=DLFsBY3wxSm1b70DyK2gu_TF-L4wQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] efi/libstub: Fix page table access in 5-level to
 4-level paging transition
To: Borislav Petkov <bp@alien8.de>
Cc: Usama Arif <usamaarif642@gmail.com>, dwmw@amazon.co.uk, tglx@linutronix.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org, 
	apopple@nvidia.com, thuth@redhat.com, nik.borisov@suse.com, kas@kernel.org, 
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, kernel-team@meta.com, 
	Michael van der Westhuizen <rmikey@meta.com>, Tobias Fleig <tfleig@meta.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 Oct 2025 at 15:40, Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Oct 28, 2025 at 10:55:57AM +0000, Usama Arif wrote:
> > When transitioning from 5-level to 4-level paging, the existing code
> > incorrectly accesses page table entries by directly dereferencing CR3
> > and applying PAGE_MASK. This approach has several issues:
> >
> > - __native_read_cr3() returns the raw CR3 register value, which on
> >   x86_64 includes not just the physical address but also flags Bits
> >   above the physical address width of the system (i.e. above
> >   __PHYSICAL_MASK_SHIFT) are also not masked.
> > - The pgd value is masked by PAGE_SIZE which doesn't take into account
> >   the higher bits such as _PAGE_BIT_NOPTISHADOW.
> >
> > Replace this with proper accessor functions:
> > - native_read_cr3_pa(): Uses CR3_ADDR_MASK properly clearing SME encryption
> >   bit and extracting only the physical address portion.
> > - mask pgd value with PTE_PFN_MASK instead of PAGE_MASK, accounting for
> >   flags above physical address (_PAGE_BIT_NOPTISHADOW in particular).
> >
> > Fixes: cb1c9e02b0c1 ("x86/efistub: Perform 4/5 level paging switch from the stub")
> > Co-developed-by: Kiryl Shutsemau <kas@kernel.org>
> > Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> > Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> > Reported-by: Michael van der Westhuizen <rmikey@meta.com>
> > Reported-by: Tobias Fleig <tfleig@meta.com>
> > ---
> >  drivers/firmware/efi/libstub/x86-5lvl.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> allmodconfig build:
>
> ld: error: unplaced orphan section `__bug_table' from `drivers/firmware/efi/libstub/x86-5lvl.stub.o'
> ld: error: unplaced orphan section `.altinstructions' from `drivers/firmware/efi/libstub/x86-5lvl.stub.o'
> ld: error: unplaced orphan section `.altinstr_replacement' from `drivers/firmware/efi/libstub/x86-5lvl.stub.o'
> ld: Unexpected GOT/PLT entries detected!
> ld: Unexpected run-time procedure linkages detected!
> ld: Unexpected run-time relocations (.rela) detected!
> ld: drivers/firmware/efi/libstub/x86-5lvl.stub.o: in function `efi_5level_switch':
> x86-5lvl.c:(.text+0x13e): undefined reference to `pv_ops'
> ld: x86-5lvl.c:(.text+0x14d): undefined reference to `pv_ops'
> ld: drivers/firmware/efi/libstub/x86-5lvl.stub.o:(.altinstr_replacement+0x1): undefined reference to `BUG_func'
> ld: arch/x86/boot/compressed/vmlinux: hidden symbol `pv_ops' isn't defined
> ld: final link failed: bad value
> make[3]: *** [arch/x86/boot/compressed/Makefile:116: arch/x86/boot/compressed/vmlinux] Error 1
> make[2]: *** [arch/x86/boot/Makefile:96: arch/x86/boot/compressed/vmlinux] Error 2
> make[1]: *** [arch/x86/Makefile:308: bzImage] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
>

This code should be using native_pgd_val() not pgd_val().

