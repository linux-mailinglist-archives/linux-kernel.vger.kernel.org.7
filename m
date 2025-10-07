Return-Path: <linux-kernel+bounces-844807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C89BC2D37
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 00:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 49FBD4E66C1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 22:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668D1257AFB;
	Tue,  7 Oct 2025 22:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fGPdVxVi"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEE21E3DCD
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 22:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759875191; cv=none; b=YbsCj9FcVQurdVo1dqkwL2V0Df4kOcRLsiaVv+jhSPXoQoWxvh+e6l2EdtlvYrrw5cL/U7nrOoUCuzj0bAu2mwEysmRVW2EohJUglx3OeNzyo0pqtpOGD0ehkIPowhsBOZ+rR2dEqkcnkfd93QXClqhfEYjncXev/3eDXlvHigs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759875191; c=relaxed/simple;
	bh=/JKwIr6zv1pXMrRZHdEdO3a3LZeUbA78PaqKqzhpf7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clCJes+Ch/rCiGlgU+uT68/VwAswKpKovrPmAbDJEUFcpXVWVcFU9ZaMF8JQwaVTRW0lLA1xR3PjrF8Cr0bSBgBqDOtLk5I4h2FQEryl1qym3kZ3q4cK7+kpoPuyyhFL//y5sZkPAlfOWNhXFLKa8x8sft+J+5DZJnSfxR6oaPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fGPdVxVi; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5D80040E01C9;
	Tue,  7 Oct 2025 22:12:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id CuAPF9cv7W10; Tue,  7 Oct 2025 22:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1759875173; bh=HAByoYOP1m7Qph5r1LaTTjv+7eaVTKZbGVM/d8PPyI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fGPdVxVi/rDlJF8sK+S7mRybj+A/sAqmm57DvXumP7RLb6b8C4t5PQ2tyOyRmy8Uw
	 zO66XLdDfxDK+d1qDvoF9h8YYVpMoMzFLqLLlhiefH3lSN6n04jlpHtQlPKzoqnDd/
	 Ui4RNxbjfvzSmApFKqMWzcuy7q0XMvFXLIfbuHrdk/Uc9DRPjQQqL2aWo5a95rt1bM
	 5pYI3Wo7OAhRHBQd39i3IshPRhIeNQlfBt6FJsZXMfc6qe6y7D8VfR5eUDTgcayW+v
	 fMFYiasW9qPMUSHZhkUeV5FdiLf2yQaD//WHSzP11neaQ5lJL8QyMOcfkCjR5VRilh
	 glFWRgkua3/JA82DxoxQeOLjhsLveR+7UvHs1R//QBJrNP2zVw4QXqSg+BrG/awuNA
	 hMeS4lguESYzfqLYgZxTPiJwGVguRVj5XejnuyCuw//Priy6FPNSTpJ2ZzT6BeM3S5
	 rFgOlJ/TBQ8BhmnV4XW8yh3OqfPdY93Xe6gg8cq5+JXganOpp4FFLbFeoGt7sR2zjK
	 IlUIh4IR4+dANpUbJsnc0hcSw2q+e78g/PuwR1HslyRogycM/9IVpzz8E4XMHGRZB2
	 EPiPA+Zng+wFHcAaUn5fB2sRDmLylXorwC+ApiHM+JOY2fQvv7vim93Ll1kfuj09R/
	 dyj2sUl2+5r/IHH7kna5ifJg=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id B2BFE40E00DE;
	Tue,  7 Oct 2025 22:12:41 +0000 (UTC)
Date: Wed, 8 Oct 2025 00:12:29 +0200
From: Borislav Petkov <bp@alien8.de>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: "Kaplan, David" <David.Kaplan@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Klaus Kusche <klaus.kusche@computerix.info>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/bugs: Qualify RETBLEED_INTEL_MSG
Message-ID: <20251007221229.GAaOWQTadGWlZSeAo_@fat_crate.local>
References: <20251003171936.155391-1-david.kaplan@amd.com>
 <20251006131126.GBaOO__iUbQHNR6QhW@fat_crate.local>
 <LV3PR12MB9265B9AA81E01A539214764A94E3A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20251006140442.GDaOPMemqB7SRJSHWL@fat_crate.local>
 <20251007182257.ywrqrrhgrtrviila@desk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251007182257.ywrqrrhgrtrviila@desk>

On Tue, Oct 07, 2025 at 11:22:57AM -0700, Pawan Gupta wrote:
> Even when CPU mitigations are disabled there is still some handling
> required for mitigations like GDS that requires a write to MSR to ensure
> correct behavior.

When mitigations are compiled out there are no mitigations by definition. So
whatever you're talking about must be something else which should happen in
vendor code.

> IMO, rather than targeting the mitigation enabling code it might make more
> sense to compile out the actual mitigations scattered accross the kernel.
> This may also improve performance by reducing the code footprint, and can
> also help getting a cleaner disassembly.

Probably... however, it needs to be done smartly because sprinkling ifdeffery
and turning what is an already unreadable mess into a bigger abomination,
won't fly. Perhaps split out the mitigations glue into separate compilation
units and build-disable them... we'll see.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

