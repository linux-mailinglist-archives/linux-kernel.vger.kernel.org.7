Return-Path: <linux-kernel+bounces-774414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DD7B2B1E9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2982E7A32D2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F152741CB;
	Mon, 18 Aug 2025 19:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OhqGs1q2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Guiz44cW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD01274B46
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 19:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755546879; cv=none; b=eCXEQqDtZzKldH9Aayt0qFp8IDCzYHFRxHYz8pEFqM6YRCI2q/QdU7ubBkqNodrCsiQcFdrp7tP5Lq+2/yTgvPNXiZZfALecjQzD/HHf+hfghgEx3L56OVmK+cQOMtYDo1Krjr0FOMqH4iYHnwltKVZERJxgDyi7ZwnNQHwuXe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755546879; c=relaxed/simple;
	bh=AjBkWERY+/aj14vFb/9D5lKJgIo1+n5GRGra2HiPZWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/Nw187kNWpGET+p6lgzUsdzHRrBMFWSTzphUb9lBlziIynslj+I+0bDvjUhJUxtEe2v4Dwa1DyRQ7KvitO25QQ1SU6DZg5P3akTLQ4WfyaOMWXz9jMl989XD6DoKXG7XEMpTiAodj5n924ZoiDx9nUkOkLjc745MWFmXB243IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OhqGs1q2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Guiz44cW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Aug 2025 21:54:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755546875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8EK6IbAY+H2krDZaq2z6lx6oUhFKs1mi/bb3jmcT0s0=;
	b=OhqGs1q2x6BUB1tCpFb1yyr1uJTDEMb2MBzXG2zrNpvkxeYgEhDquSNkA4irjOznROy7xV
	UBns1E3WNMGpT39d7QOYTz52Q2hu3JONqXGm5S2ytDcYUQxWwcU+0u4yEOIcR9ggKXV5/N
	1qyIssejXDxE67c7TOTWfcjhKxBhPDOMuj2O8dphdG/YYC7yMa/5w8Xp8rAFG6uwskct2K
	G05jGoW+S+PFNxaH5aeAzoe6gby0CMHIhtD2cwH5rvMiNYOqD86dcjYxlLQzohVQosz8Xk
	bIr5eR3EqjgGA74RKNQ4rdzpwgCYmSpK6gcRELgo/uO0TiPGdSK5YXZMQrAjWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755546875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8EK6IbAY+H2krDZaq2z6lx6oUhFKs1mi/bb3jmcT0s0=;
	b=Guiz44cWsxNuhpSyEaYfpKUgUYq7exqPCGNjMjWZMvPh1jQ19Fdjwx2MqLeDLI7SN0daOU
	tbGyKvKgKa3EDPAw==
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
Message-ID: <aKOE-FzHy0JatC8I@lx-t490>
References: <20250815070227.19981-1-darwi@linutronix.de>
 <20250815070227.19981-8-darwi@linutronix.de>
 <aJ9TbaNMgaplKSbH@google.com>
 <aKMvTrrKYgJNWX8L@lx-t490>
 <aKN0debsio7ocitW@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKN0debsio7ocitW@google.com>

Hi,

On Mon, 18 Aug 2025, Sean Christopherson wrote:
>
> Why not?  Like C structs, there can only be one variable sized array, i.e. there
> can't be multiple "n" subleafs.  If the concern is calling __cpuid_subleaf_n()
> with i < start, then I don't see how embedding start in the structure name helps
> in any way, since 'i' isn't a compile-time constant and so needs to be checked at
> runtime no matter what.
>

Hmmm...

I can indeed find the offset of the dynamic 'leaf_0x.._n' subleaf storage
by CPP tokenization, since the CPUID table will be in the form:

    struct leaf_0x0_0           leaf_0x0_0[1];
    struct leaf_0x1_0           leaf_0x1_0[1];
    struct leaf_0x2_0           leaf_0x2_0[1];
    struct leaf_0x4_0           leaf_0x4_0[8];
    struct leaf_0xd_0		leaf_0xd_0[1];
    struct leaf_0xd_1		leaf_0xd_1[1];
    struct leaf_0xd_n		leaf_0xd_n[62];
    struct leaf_0x16_0          leaf_0x16_0[1];
    struct leaf_0x80000000_0    leaf_0x80000000_0[1];
    struct leaf_0x80000005_0    leaf_0x80000005_0[1];
    struct leaf_0x80000006_0    leaf_0x80000006_0[1];
    struct leaf_0x8000001d_0    leaf_0x8000001d_0[8];

I was also kinda worried about the different subleaf semantics:

    struct leaf_0x4_n		=> starts from subleaf 0
    struct leaf_0xd_n		=> starts from subleaf 2

But, hopefully it would be clear when looking at the generated header in
total.

Still: for the API you're proposing, I'll need to generate an error for
things like:

    cpuid_subleaf_n(c, 0xd, 0);
    cpuid_subleaf_n(c, 0xd, 1);

which could not have happened in the API I proposed earlier.  But... I
can let the XML files generate some symbols in the form:

    LEAF_0x4_n_MIN_SUBLEAF	0
    LEAF_0xd_n_MIN_SUBLEAF	2

and generate an error (once) if the passed subleaf is less than the
minimum.  I can also generate that error (once) at compile-time if the
given subleaf was a compile-time constant.

Maybe there's a cleaner way for detecting this subleaf lower-bound error,
I will see; what's important now is the API implementation feasibility...

=> Then, we can have:

API Summary
~~~~~~~~~~~

For CPUID leaves with static subleaves:

    cpuid_leaf(_cpuinfo, _leaf)
    cpuid_subleaf(_cpuinfo, _leaf, _subleaf)

For CPUID leaves with dynamic subleaves:

    cpuid_subleaf_n(_cpuinfo, _leaf, _idx)

New SGX snippet
~~~~~~~~~~~~~~~

At arch/x86/kernel/cpu/sgx/main.c:

    const struct leaf_0x12_n *l;

    for (int i = 0; i < ARRAY_SIZE(sgx_epc_sections); i++) {

        l = cpuid_subleaf_n(0x12, i + SGX_CPUID_EPC);

	// Use l->subleaf_type, etc. as appropriate
    }

New KVM snippet
~~~~~~~~~~~~~~~

At arch/x86/kvm/cpuid.c:

    const struct leaf_0xd_n *l;

    for (int i = XFEATURE_YMM; i < ARRAY_SIZE(xstate_sizes); i++) {

	l = cpuid_subleaf_n(c, 0xd, i);

        // Use l->xsave_sz, l->xsave_offset, etc. as appropriate
    }

This looks much better indeed; for both KVM and SGX :-)

Thanks a lot!

--
Ahmed S. Darwish
Linutronix GmbH

