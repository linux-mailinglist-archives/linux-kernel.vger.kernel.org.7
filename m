Return-Path: <linux-kernel+bounces-773926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB550B2AC43
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50E5C7AD202
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6C32512E6;
	Mon, 18 Aug 2025 15:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OTjjYTFJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AebxJxuG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD5F24E4C6
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 15:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755530094; cv=none; b=LbwrDm+EEZAK09AT+rg2sTy1caDDtmLhcWxtR1/ZcciMpOXbpezNge559nskjDSmy4hlR4tFbc/JhNFld3cimIBrzDkBWDdHScsoaFzJdi7vrfE+xbRX6w4m8xuxg8dPXcqPCPDJaKOLPZ6SepwqxieBIpNoY/R0LiGSguw/wTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755530094; c=relaxed/simple;
	bh=O6aTlMjnDiIFzMitmclGJsYDjPXGvGHf475d82Bm3LA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLRkdj8BLCJseoCAUlbAOilfx0cI/oqzAH9L2E2ml9CBTfRhOWk2briCYU9WLo04YjQdu22jjWtQbQgqeaHZUoNGPcDdz42plhqIQM1r8CSeaVfRIU5f9P7NyIHFmbEgsGjQyVK/uZfWttGb8VBLLQM4lgGiiQ2UXCJdHpD4lGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OTjjYTFJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AebxJxuG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Aug 2025 17:14:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755530091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NOjgkoXz2OJkl1SQS5nGgXmhcpxnRfnVH+2MCIzyCr0=;
	b=OTjjYTFJcrkRSCwwpZFD27b3FoL3qXDDbwg6aU/4I6sD2ZGrg4cB/+NylemMmmHeXVyuC1
	+SryT3Xl8IBtoZ2/2FtPHreMr9p/ZKNzRjR6QGIe75o7q/xmIttpV01udHktc4FoswD+3c
	yfElSmrptL2GIr++k71IfXNfLdkN1yMbncHUDtwzpBjoEI0/qf3WXfhF4gbHqWFEfYS9Kr
	WlRmVQp0VwcOX8p+YELgwaQ8PFl7kLLl6902BV+AwMCpX0MZnrk7sdPvNT4t/Vy2oV3Esr
	jfOKy6NGAWEzu/x60Kr5lewWKjSItDovshmlwVkAbyKaGQmBeuzMn+mULv/6JQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755530091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NOjgkoXz2OJkl1SQS5nGgXmhcpxnRfnVH+2MCIzyCr0=;
	b=AebxJxuGDUPUEaVAMnHvWQbgEv+KZH95RErUBe2ZcSoW4ATWcQgO+gcp48fnH6DzrFKBRz
	N74UOXMupUunJuDg==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Sean Christopherson <seanjc@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sohil Mehta <sohil.mehta@intel.com>,
	John Ogness <john.ogness@linutronix.de>, x86@kernel.org,
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 02/34] ASoC: Intel: avs: Include CPUID header at file
 scope
Message-ID: <aKNDZ3mWYUABwOzJ@lx-t490>
References: <20250815070227.19981-1-darwi@linutronix.de>
 <20250815070227.19981-3-darwi@linutronix.de>
 <20250818145646.GGaKM_Ltrggbwkj2TB@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818145646.GGaKM_Ltrggbwkj2TB@fat_crate.local>

Hi Boris,

On Mon, 18 Aug 2025, Borislav Petkov wrote:
>
> I'm guessing that:
>
> https://lore.kernel.org/r/aGv8AWwHbi5seDxi@lx-t490
>
> still needs to happen yet?
>
> Because I don't see it in this set...
>

Yeah, I discovered that I need to do the X86_FEATURE integration within
the CPUID model before touching the CPUID(0x15) call sites.

Quoting the cover:

  State of Affairs: By now, all CPUID leaves which do not interact with
  the X86_FEATURE mechanism(s) has been transformed to the CPUID model.
  Remaining leaves have dependencies on X86_FEATURE.

  For example, some callsites _directly_ enumerate CPUID(0x15)
  [ART_CPUID_LEAF / CPUID_LEAF_TSC] even though that leaf has important
  dependencies on X86_FEATURE_ART and its tsc_async_resets flag.

  The CPUID parser work will not propagate such call sites brokedness and
  will integrate the X86_FEATURE infrastructure within it first.

As I mentioned in the Bhyve thread, this shall also include a directed
acyclic graph of dependencies for the X86_FEATURE flags themselves:

  https://lore.kernel.org/lkml/aKL0WlA4wIU8l9RT@lx-t490

v5 should cover this.

Thanks!

--
Ahmed S. Darwish
Linutronix GmbH

