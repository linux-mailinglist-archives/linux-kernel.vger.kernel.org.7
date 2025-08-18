Return-Path: <linux-kernel+bounces-773728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB78B2A7BC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ABE817F0D7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1072206AF;
	Mon, 18 Aug 2025 13:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EYuHFWKH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yTnoPfbn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1FE1F4177
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755524949; cv=none; b=alKwMjnLLepATEBKZyQXEaTaeV/iK93C8nqQi9x+/OTQ4GvO6vd4ViyKNLUQh/0zwRVj8bgamdgo7N3Zkyl325zFXUyFzczlULONC7KvHLRaFkR/IdolInuKsbuxzHQb5MiEbpEDMMOaYSAeJwVa8BNcxi4MeMXOKoW0rcsNxIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755524949; c=relaxed/simple;
	bh=irpuInIcTBcDJKOsw++EYv/f6G5MNBcuwSrPyrjjvpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYXaGwx2lRRJ9eBesQ8rIqsT1mt2Gmz2WNfBRMtdKCEpAQXLN/125RKU6Tjqryxc1oOghrCJvSyKo6xfrHcW18XojLAwwaIcMTyw/x45v69SRu93rpsJLadS3xTc4evLls5rdPv1GlLUpsT1A763B78TS/wuSSIFGt1qHeihdaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EYuHFWKH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yTnoPfbn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Aug 2025 15:49:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755524945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BxFjMKZWZrjA/Q2sRWad+Q3znnfgN6cMMTYAA4e8uHA=;
	b=EYuHFWKHWXKoEhTVNsQQQLh0GKtmAMCWh3ykX4yCxWHa1oKD4+33KkcuZP9lE180PwxZhE
	Loqze/aMBiZnrR1+r9FsfGLWVtjn9OraSttGP3NSLC7A5AQ+wM+EhcTq9HTYZfXNrzlmyW
	4poh5dP5BxKNykZU7Aibt+J3uyrJtTiOCOINLyGnT4iZsrWQR5EFTBo55uNZuMVDJn36P9
	USOAsQG1kZbSYIDC9hNTWfD0WUlhziWlUjv91zHESur1+y3dhsVgAJDkss9wegH5JXrW1P
	wcTV0RdBkl6L2/kb70jRpS283V2ITVULB5zzkcjhhS88X0xOTIsxCqrd6kB4CA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755524945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BxFjMKZWZrjA/Q2sRWad+Q3znnfgN6cMMTYAA4e8uHA=;
	b=yTnoPfbnNxoQylgS80SqsgFZpG5I/HGvF1yU8633vHo2UqkRqnlei98LyAUkePIivhDYLL
	TGZLYAfXCW2vHjCw==
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
Message-ID: <aKMvTrrKYgJNWX8L@lx-t490>
References: <20250815070227.19981-1-darwi@linutronix.de>
 <20250815070227.19981-8-darwi@linutronix.de>
 <aJ9TbaNMgaplKSbH@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aJ9TbaNMgaplKSbH@google.com>

Hi!

On Fri, 15 Aug 2025, Sean Christopherson wrote:
>
> IMO, the end result is quite misleading for leaves with "repeated" entries.  0xd
> in particular will be bizarre due to its array starting at ECX=2.  E.g.
> cpuid_subleaf_index() straight up won't work (without lying) due to hardcoding
> '0' as the subleaf.
>
> #define cpuid_subleaf_index(_cpuinfo, _leaf, _idx)			\
> ({									\
> 	__cpuid_assert_leaf_has_dynamic_subleaves(_cpuinfo, _leaf);	\
> 	__cpuid_table_subleaf_idx(&(_cpuinfo)->cpuid, _leaf, 0, _idx);	\
>                                                              ^
>                                                              |
>
> And then the usage would be similarly bizarre, e.g.
>
> 	for (i = XFEATURE_YMM; i < ARRAY_SIZE(xstate_sizes); i++) {
> 		struct cpuid_xstate_sizes *xs = &xstate_sizes[i];
> 		struct cpuid_0xd_2 *c = cpuid_subleaf_index(..., 0xD, i - 2);
>
> 		...
> 	}
>
> Even the cases where the array starts at '0' look weird:
>
> 	const struct leaf_0x4_0 *regs = cpuid_subleaf_index(c, 0x4, index);
>
> because the code is obviously not grabbing CPUID(0x4).0.
>
> And the subleaf_index naming is also weird, because they're essentially the same
> thing, e.g. the SDM refers to "sub-leaf index" for more than just the repeated
> cases.
>
> Rather than define the structures names using an explicit starting subleaf, what
> if the structures and APIs explicitly reference 'n' as the subleaf?  That would
> communicate that the struct represents a repeated subleaf, explicitly tie the API
> to that structure, and would provide macro/function names that don't make the
> reader tease out the subtle usage of "index".
>
> And then instead of just the array size, capture the start:end of the repeated
> subleaf so that the caller doesn't need to manually do the math.
>
> E.g.
>
> 	const struct leaf_0x4_n *regs = cpuid_subleaf_n(c, 0x4, index);
>
> 	struct cpuid_0xd_n *c = cpuid_subleaf_n(..., 0xD, i);
>

Thanks a lot for all these remarks.  I was indeed struggling with good
names for the array indexing case, so the above was really helpful.

In this v4 iteration, I did not add a CPUID parser API for the cases
where the subleaves are repeated but do not start from zero.  Not for any
technical reason, but to avoid having kernel APIs with no call sites.

What I internally have is:

  /**
   * __cpuid_subleaf_index() - Access parsed CPUID data at runtime subleaf index
   * @_cpuinfo:	CPU capability structure reference ('struct cpuinfo_x86')
   * @_leaf:	CPUID leaf in compile-time 0xN format; e.g. 0x4, 0x8000001d
   * @_subleaf:	CPUID subleaf in compile-time decimal format; e.g. 0, 1, 3
   * @_idx:	Index within CPUID(@_leaf).@_subleaf output storage array.
   *		Unlike @_leaf and @_subleaf, this index value can be provided
   *		dynamically.
   * ...
   */
  #define __cpuid_subleaf_index(_cpuinfo, _leaf, _subleaf, @_idx)	\
  ...

Thus, the arch/x86/kvm/cpuid.c loop you quoted would be tokenized as:

    const struct leaf_0xd_2 *ld;
    for (int i = 0; i < ARRAY_SIZE(xstate_sizes) - XFEATURE_YMM; i++) {
        ...
        ld = __cpuid_subleaf_index(c, 0xd, 2, i);
	                           |   |   |  └───────┐
                                   |   |   └────────┐ |
                                   |   └─────────┐  | |
                                   *             *  * v
        ld =                      &c.cpuid.leaf_0xd_2[i];
        ...
    }

I actually agree that, in this case, types like "struct leaf_0xd_2" are
deceiving... Let's divide the problem in two.

Easy case: Subleaves start repeating from subleaf = 0
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This would be the CPUID leaves:

    x86-cpuid-db/db/xml (tip)> git grep 'id="0" array='
    leaf_04.xml:        <subleaf id="0" array="32">
    leaf_0b.xml:        <subleaf id="0" array="2">
    leaf_18.xml:        <subleaf id="0" array="32">
    leaf_1b.xml:        <subleaf id="0" array="32">
    leaf_1f.xml:        <subleaf id="0" array="6">
    leaf_8000001d.xml:	<subleaf id="0" array="32">
    leaf_80000026.xml:	<subleaf id="0" array="4">

For example, patch 24/34 ("x86/cacheinfo: Use parsed CPUID(0x4)"):

    static int
    intel_fill_cpuid4_info(struct cpuinfo_x86 *c, int index, ...)
    {
	const struct leaf_0x4_0 *regs = cpuid_subleaf_index(c, 0x4, index);
	...
    }

In that case, we might actually generate leaf data types in the form:

    struct leaf_0x4_n { ... };

And have the access macros called cpuid_subleaf_n():

    static int
    intel_fill_cpuid4_info(struct cpuinfo_x86 *c, int index, ...) {
    {
	const struct leaf_0x4_n *regs = cpuid_subleaf_n(c, 0x4, index);
	...
    }

I think this indeed looks much much better.

I will do that for v5 of the model.

Hard case: Subleaves start repeating from subleaf > 0
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This would be the CPUID leaves:

    x86-cpuid-db/db/xml (tip)> git grep 'id="[1-9][0-9]*" array='

    leaf_0d.xml:    <subleaf id="2" array="62">
    leaf_10.xml:    <subleaf id="1" array="2">
    leaf_12.xml:    <subleaf id="2" array="30">
    leaf_17.xml:    <subleaf id="1" array="3">

For something like CPUID(0xd), I cannot just blindly define a 'struct
cpuid_0xd_n' data type.  We already have:

    struct leaf_0xd_0 { ... };
    struct leaf_0xd_1 { ... };
    struct leaf_0xd_2 { ... };

and they all have different bitfields.  A similar case exist for
CPUID(0x10), CPUID(0x12), and CPUID(0x17).

But, we can still have:

    struct leaf_0xd_0	{ ... };
    struct leaf_0xd_1	{ ... };
    struct leaf_0xd_2_n	{ ... };

With this, the CPUID(0x12) call site at kernel/cpu/sgx/main.c can change
from:

    u32 eax, ebx, ecx, edx;

    for (i = 0; i < ARRAY_SIZE(sgx_epc_sections); i++) {
        ...
	cpuid_count(SGX_CPUID, i + SGX_CPUID_EPC, &eax, ...);
    }

to:

    const struct leaf_0x12_2_n *l;

    for (i = 0; i < ARRAY_SIZE(sgx_epc_sections); i++) {
        ...
	l = __cpuid_subleaf_n(0x12, 2, i);
    }

And the aforementioned KVM snippet would be:

    const struct leaf_0xd_2_n *l;

    for (int i = 0; i < ARRAY_SIZE(xstate_sizes) - XFEATURE_YMM; i++) {
        l = __cpuid_subleaf_n(c, 0xd, 2, i);
    }

I'm open for better names than __cpuid_subleaf_n() for this.  The only
constraint with any suggested name is that I need to have 0xd and 2 both
passed as CPP literals.

API Summary
~~~~~~~~~~~

For CPUID leaves with static subleaves:

    cpuid_leaf(_cpuinfo, _leaf)
    cpuid_subleaf(_cpuinfo, _leaf, _subleaf)

For CPUID leaves with dynamic subleaves:

    cpuid_subleaf_n(_cpuinfo, _leaf, _idx)
    __cpuid_subleaf_n(_cpuinfo, _leaf, _subleaf, _idx)

Sounds good?

>
> Tangentially related, having to manually specific count=1 to CPUID_LEAF() for
> the common case is also ugly.  If a dedicated CPUID_LEAF_N() macro is added to
> specificy the start:end of the range, then CPUID_LEAF() can just hardcode the
> count to '1'.  E.g.
>
> struct cpuid_leaves {
> 	CPUID_LEAF(0x0,		 	0);
> 	CPUID_LEAF(0x1,			0);
> 	CPUID_LEAF(0x2,		 	0);
> 	CPUID_LEAF_N(0x4,		0,	7);
> 	CPUID_LEAF(0xd,			0);
> 	CPUID_LEAF(0xd,			1);
> 	CPUID_LEAF_N(0xd,		2,	63);
> 	CPUID_LEAF(0x16,	 	0);
> 	CPUID_LEAF(0x80000000,		0);
> 	CPUID_LEAF(0x80000005,		0);
> 	CPUID_LEAF(0x80000006,		0);
> 	CPUID_LEAF_N(0x8000001d,	0,	7);
> };
>

This is much better; will do.

Thanks!

--
Ahmed S. Darwish
Linutronix GmbH

