Return-Path: <linux-kernel+bounces-775794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C5DB2C4C3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C4EF84E16C5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADA333A038;
	Tue, 19 Aug 2025 13:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2FlgTQfO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X+eu/lpf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39D32C11EF
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755609044; cv=none; b=QJbeVQshk6t4us904xEzj2Gbt06zEftj7LU7XRb5LhdWNfz8fNEYZwvUTCDLg8MpLl0CPBeWzbrryA1aOinFTMO05uwHyCApm1qxWL7sMgmtRiCCNdYP1DJ7jfvUV1pk2BShLO4F8bAXrfoEPgb39ErPNwJhNbaaSMrhI7GnsMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755609044; c=relaxed/simple;
	bh=gm4mULLxDIMzLjNtBnmeLVtsvF7EvUM8pRExo0ZVER8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GU2NhODaOCRrO4z7oleZfknjxuYKbKvKwHumiPX7o2oZh38zRMqqhh3ga458T7TlV04nZGEqsk5fWeq2T21Jk0lthjNi94JibS6KsERiCOgl5GOlg4asombQhoBR7XLiee+fS3D8hlHONUucIznqG+0AG8Zmnh8SwfXCbGd4W6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2FlgTQfO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X+eu/lpf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 19 Aug 2025 15:10:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755609040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gBnrtJihTPDwjkAr8dxaZpEzEO+3yDxGlV0TvYmlzDY=;
	b=2FlgTQfO+1MtrIz6VWUgvJgwYY+JajVC2ggSmW4/mAz4VObAZVeKgcWfaXrVvbVDEgtDRa
	3nP8QBdxoA4EmkHgeM8FXeAjVOo64Oq18Y5g/Okajh8lIRu11WJXONYLe5R0Tm25VGmfHg
	RNY7GTndxtXsIh/LmrddqGE2ACbPqsoJi1PojlEaDBp+mHz5/22CLpB57FoQJCUbAaAiTR
	LUmXecm/kUc2EgDkLcUbTMbpOiOtF0ZKu+PRxTEv1Zup29R+pmoclzxduKyS6y7k1ldkvX
	1Y8KSQgq7A5Zrxnsy+5aPyxu67Vi5M2wnTkPr+rt6/MxecFcuqEemKdu97ddQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755609040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gBnrtJihTPDwjkAr8dxaZpEzEO+3yDxGlV0TvYmlzDY=;
	b=X+eu/lpf1hsuhSYeCjOzwAa4F3uFPFlJijhGuhhmlqgoKwnzUUrBmBsWkRpfj1Y/51v0P1
	wujXkpXeIG2gECCA==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Sean Christopherson <seanjc@google.com>
Cc: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sohil Mehta <sohil.mehta@intel.com>,
	John Ogness <john.ogness@linutronix.de>, x86@kernel.org,
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 07/34] x86/cpuid: Introduce a centralized CPUID data
 model
Message-ID: <aKR3zjxsM7xQZ_g8@lx-t490>
References: <20250815070227.19981-1-darwi@linutronix.de>
 <20250815070227.19981-8-darwi@linutronix.de>
 <aJ9TbaNMgaplKSbH@google.com>
 <aKMvTrrKYgJNWX8L@lx-t490>
 <aKN0debsio7ocitW@google.com>
 <aKOE-FzHy0JatC8I@lx-t490>
 <aKObRk0Ze1_LVqWj@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aKObRk0Ze1_LVqWj@google.com>

Hi,

On Mon, 18 Aug 2025, Sean Christopherson wrote:
>
> Not sure "cleaner" is the right word, but if you really want to add
> compile-time sanity checks, you could put the actual definitions in a
> dedicated header file that's included multiple times without any #ifdef
> guards.  Once to define "struct cpuid_leaves", and a second time to
> define global metadata for each leaf, e.g. the first/last subleaf in a
> dynamic range.
>
...
> @@ -432,7 +432,10 @@ static inline u32 cpuid_base_hypervisor(const char *sig, u32 leaves)
>  #define cpuid_subleaf_index(_cpuinfo, _leaf, _idx)			\
>  ({									\
>  	__cpuid_assert_leaf_has_dynamic_subleaves(_cpuinfo, _leaf);	\
> -	__cpuid_table_subleaf_idx(&(_cpuinfo)->cpuid, _leaf, 0, _idx);	\
> +	BUILD_BUG_ON(__builtin_constant_p(_idx) &&			\
> +		     ((_idx) < CPUID_LEAF_ ## _leaf ## _N_FIRST ||	\
> +		      (_idx) > CPUID_LEAF_ ## _leaf ## _N_LAST));	\
> +	__cpuid_table_subleaf_idx(&(_cpuinfo)->cpuid, _leaf, n, _idx);	\
>  })
>
...
> -#define CPUID_LEAF(_leaf, _subleaf, _count)			\
> -	__CPUID_LEAF(leaf_ ## _leaf ## _ ## _subleaf, _count)
> +#define CPUID_LEAF(_leaf, _subleaf)			\
> +	__CPUID_LEAF(leaf_ ## _leaf ## _ ## _subleaf, 1)
> +
> +#define CPUID_LEAF_N(_leaf, _first, _last)		\
> +	__CPUID_LEAF(leaf_ ## _leaf ## _n, _last - _first + 1)
> +
> +
>
...
> +
> +#undef CPUID_LEAF
> +#undef CPUID_LEAF_N
> +#define CPUID_LEAF(_leaf, _subleaf)
> +#define CPUID_LEAF_N(_leaf, _first, _last)		\
> +	CPUID_LEAF_ ## _leaf ## _N_FIRST = _first,	\
> +	CPUID_LEAF_ ## _leaf ## _N_LAST  = _last,
> +
> +enum cpuid_dynamic_leaf_ranges {
> +#include "leaf_defs.h"
>  };
...

Thanks a lot for jumping-in and posting code on top; really appreciated!

Yes, I'm doing a new 'x86-cpuid-db' release now.

It will generate <asm/cpuid/api/leaf_types.h> in below form; showing only
the dynamic CPUID leaves here:

    struct leaf_0x4_n { ... };

    #define LEAF_0x4_SUBLEAF_N_FIRST		0
    #define LEAF_0x4_SUBLEAF_N_LAST		31

    struct leaf_0xb_n { ... };

    #define LEAF_0xb_SUBLEAF_N_FIRST		0
    #define LEAF_0xb_SUBLEAF_N_LAST		1

    struct leaf_0xd_n { ... };

    #define LEAF_0xd_SUBLEAF_N_FIRST		2
    #define LEAF_0xd_SUBLEAF_N_LAST		62

    struct leaf_0x10_n { ... };

    #define LEAF_0x10_SUBLEAF_N_FIRST		1
    #define LEAF_0x10_SUBLEAF_N_LAST		2

    struct leaf_0x12_n { ... };

    #define LEAF_0x12_SUBLEAF_N_FIRST		2
    #define LEAF_0x12_SUBLEAF_N_LAST		9

    // ...

    struct leaf_0x8000001d_n { ... };

    #define LEAF_0x8000001d_SUBLEAF_N_FIRST	0
    #define LEAF_0x8000001d_SUBLEAF_N_LAST	31

    struct leaf_0x80000026_n { ... };

    #define LEAF_0x80000026_SUBLEAF_N_FIRST	0
    #define LEAF_0x80000026_SUBLEAF_N_LAST	3

IMO, these are a clean set of symbols.  They are in the same header file
because Ingo would like to keep the header structure simple (and 100%
agreement from my side; especially not to hit any ugly generated files
version mismatches later).  That is:

    arch/x86/include/asm/cpuid/
    ├── api.h
    ├── leaf_types.h				// One auto-generated file
    └── types.h

The _SUBLEAF_N_FIRST/LAST symbols reflect below CPUID XML database lines:

    leaf_04.xml:        <subleaf id="0" last="31">
    leaf_0b.xml:        <subleaf id="0" last="1">
    leaf_0d.xml:        <subleaf id="2" last="62">
    leaf_10.xml:        <subleaf id="1" last="2">
    leaf_12.xml:        <subleaf id="2" last="9">
    ...
    leaf_8000001d.xml:	<subleaf id="0" last="31">
    leaf_80000026.xml:	<subleaf id="0" last="3">

In current release, the last="" attribute is called array="", but that's
an implementation detail. The new attribute name is much more clear
(thanks for the _FIRST/_LAST suggestion); it fits current semantics.

Then, everything else, like the snippet you posted (slightly adapted):

> +	BUILD_BUG_ON(__builtin_constant_p(_idx) &&			\
> +		     ((_idx) < LEAF_ ## _leaf ## SUBLEAF_N_FIRST ||	\
> +		      (_idx) > LEAF_ ## _leaf ## SUBLEAF__N_LAST));	\

would work perfectly out of the box.

To give freedom to the Linux Kernel code though, the kernel's own per-CPU
CPUID tables can have storage areas less than

    LEAF_M_SUBLEAF_N_LAST - LEAF_M_SUBLEAF_N_FIST + 1

For example:

    struct leaf_0x0_0           leaf_0x0_0[1];
    ...
    struct leaf_0x4_0           leaf_0x4_0[8];		// 8 < 32
    ...
    struct leaf_0x8000001d_0    leaf_0x8000001d_0[8];	// 8 < 32

That should be OK, and is by design.  The BUILD_BUG_ON() snippet above
can easily be adapted with a ARRAY_SIZE().

After all that (which is not much extra atually, thanks to the XML symbol
generation), we can have pretty nice compile- and run-time safety for the
new API:

    cpuid_subleaf_n(_cpuinfo, _leaf, _idx)

The other CPUID parser APIs:

    cpuid_leaf(_cpuinfo, _leaf)
    cpuid_subleaf(_cpuinfo, _leaf, _subleaf)

already have total compile-time safety due to the zero-casting.

This is all is pretty neat.  Thanks again!

Kind regards,
Ahmed

