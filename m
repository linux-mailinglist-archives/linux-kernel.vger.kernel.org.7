Return-Path: <linux-kernel+bounces-774111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A00B2AEC0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C4A2680B78
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2D426F299;
	Mon, 18 Aug 2025 17:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ndOqgRK3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iYyrUX4t"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20755343D90
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 17:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755536408; cv=none; b=N90SMnQNBlIuU/Lr7uz3pvlX99F022C7wBfF7sPDCykhNKPneYteGXQ3oFplbM8j8VIVsXJ6Ij9IVHUfe7BSF8+/NGtHY5U5BhlKA3a9nyT0d8uuyoYRKF2U5VXc/s2MCMoD1qAxcLjPcGvJHoAXv1jVsaNbagnD4xYAYZEaH8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755536408; c=relaxed/simple;
	bh=uHO+5UGTXCFLqgCRByT85ahgS97z/GDSSKPRDkUM38U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNuGynf9wQmG+vXDapmo+IWLGDOWSWM+3fcSzpcpl21cbcQJkImPJgwKHGY0kiv1I4NS3j4ktmIscq0wHVIp8sCi8XuthElif6p0DgfyM2Zp+o6i2SWF/gSfW0/Dd1bEjwDDFo3qd2TE68Nw/KLY5dQscnBvt34W2QitB+69VpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ndOqgRK3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iYyrUX4t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Aug 2025 19:00:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755536405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JK2fvOJ8FC8e7QmXUAN4QIVvXniykVvupKasMJEv4gA=;
	b=ndOqgRK3QwBf/a4UVfQNsCj01ioiTN8y78gBmTSstl+7E55Ud45VMYR87WSRknb8NuLZDS
	DcgRD2V2c3UhxC8UvXMRX8MSOWlP/3p9kYjqel7yZcZRRP29uvvbDTg+YtMXAIsO5cmjxe
	y/AZlgzWM6gVBYyA2cGoJxqNAiflgBry+YI3yKzdwbcqLns96GTq3P6gnUdqCcR5DLA4f+
	H96TWw+awYF/e6Czsm9B93LX1E4T1h8gOvW6Jw4a/OloYHQDPSCfOr0kBjsJlwXZgVuPiZ
	1uzY3foKfpd8TIKJyx29Tm8Pf32BfsqrEfoV/3sVHZbFkqtXzhZidJEG1/BZRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755536405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JK2fvOJ8FC8e7QmXUAN4QIVvXniykVvupKasMJEv4gA=;
	b=iYyrUX4tDYZZbGshEPoPtj185dTaHhL6He9GUWrrPVKiKx2k7oEUq4mDVJPleI/omeiSHd
	cJY1XcQ2+JqfYJCg==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Dave Hansen <dave.hansen@intel.com>, Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Sean Christopherson <seanjc@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sohil Mehta <sohil.mehta@intel.com>,
	John Ogness <john.ogness@linutronix.de>, x86@kernel.org,
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 28/34] x86/cacheinfo: Use parsed CPUID(0x80000005) and
 CPUID(0x80000006)
Message-ID: <aKNcE7D_s9D7spvR@lx-t490>
References: <20250815070227.19981-1-darwi@linutronix.de>
 <20250815070227.19981-29-darwi@linutronix.de>
 <4a680b7d-2ecb-4579-a5ea-b612c08ebefa@intel.com>
 <e9620899cc52cd45c090c939898be8787ff84df6.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e9620899cc52cd45c090c939898be8787ff84df6.camel@infradead.org>

Hi!

On Mon, 18 Aug 2025, David Woodhouse wrote:
>
> How about automatically building the cast into the macro invocation...
>
> #define cpuid_leaf(c, l) ((struct cpuid_leaf_ ## l *)__cpuid_leaf(c, l)
> #define cpuid_lead_index(c, l, i) ((struct cpuid_leaf_ ## l ## _ ## i) __cpuid_leaf_index(c, l, i)
>

There are zero casts needed by this model.  From patch 07/34 ("x86/cpuid:
Introduce a centralized CPUID data model"), the access CPUID parser APIs
just dissolve into:

    const struct leaf_0x7_0 *l7_0;
    const struct leaf_0x7_1 *l7_1;

    l7_0 = cpuid_subleaf(c, 0x7, 0);
                         |   |   └────────┐
                         |   └─────────┐  |
                         *             *  *
                        &c.cpuid.leaf_0x7_0[0]

    l7_1 = cpuid_subleaf(c, 0x7, 1);
                         |   |   └────────┐
                         |   └─────────┐  |
                         *             *  *
                        &c.cpuid.leaf_0x7_1[0]

where, for example, the data type of 'c.cpuid.leaf_0x7_0[0]' is native
'struct leaf_0x7_0', and so on.

The per-CPU CPUID table(s) are built in a /fully-typed/ form:

    struct leaf_0x0_0		leaf_0x0_0[1];
    struct leaf_0x1_0		leaf_0x1_0[1];
    struct leaf_0x2_0		leaf_0x2_0[1];
    struct leaf_0x4_0		leaf_0x4_0[8];
    struct leaf_0x16_0		leaf_0x16_0[1];
    struct leaf_0x80000000_0	leaf_0x80000000_0[1];
    struct leaf_0x80000005_0	leaf_0x80000005_0[1];
    struct leaf_0x80000006_0	leaf_0x80000006_0[1];
    struct leaf_0x8000001d_0	leaf_0x8000001d_0[8];

Then, the exported CPUID parser APIs do some CPP tokenization magic to
access such fully-typed data -- no casting needed.

The only exception is raw EAX->EDX register access:

    /**
     * cpuid_leaf_regs() - Access parsed CPUID data in raw format
     * @_cpuinfo:	CPU capability structure reference ('struct cpuinfo_x86')
     * @_leaf:		CPUID leaf, in compile-time 0xN format
     *
     * Similar to cpuid_leaf(), but returns a raw 'struct cpuid_regs' pointer to
     * the parsed CPUID data instead of a "typed" <cpuid/leaf_types.h> pointer.
     */
    #define cpuid_leaf_regs(_cpuinfo, _leaf)				\
	((struct cpuid_regs *)(cpuid_leaf(_cpuinfo, _leaf)))

But the usage of this raw-access API is very limited.  This is by design,
as one of the purpose of this work was to ensure type safety and avoid
call-site bit fiddling.

Thanks!

--
Ahmed S. Darwish
Linutronix GmbH

