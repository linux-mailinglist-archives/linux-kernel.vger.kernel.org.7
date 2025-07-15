Return-Path: <linux-kernel+bounces-731490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9D9B0551D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21A625616D0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9561E273808;
	Tue, 15 Jul 2025 08:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="kMmQmNQy"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A4825D55D
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 08:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752568725; cv=none; b=cDXopJ03AvW55/34iKigglC/JNUFDvc+vgsTDOmIXFJIPYxRO7lFL51edTRRmzbeKfiOQspkThCW9iv3RYO0lYL5eL1wCRZ4Gq+VO/2OTYnsRb+8/7mm/duBOgpzIPp8SxYxb0MinJFd6/cJiIE07+w0xYZTjR77eTace3o7AI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752568725; c=relaxed/simple;
	bh=c6LJj3udj0J3UootvIgB6zfzZvQZ47urSurRtPXKJ8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CB5MMLxk4J7bIF6O1vb3Jbyg5BVJTy2DDHmoSStP0/nAmUo7NocUPaQJR9gOwmooHwPQVHK4MC/yq2Jbw8+z7Ub9uZKYAWrwjiQsv6L4Gtb0vtd8EjVB8lCEB8tWqifeD/2/fEh5ZAtNLQEnVFgqI4IxsyAwtKuh/tUbUk/c6ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=kMmQmNQy; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1973F40E0216;
	Tue, 15 Jul 2025 08:38:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ripCVEZ_vT8z; Tue, 15 Jul 2025 08:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1752568718; bh=4A5vVxA2en17yEgK87oBpQ+FmmPPz4Eo7oPnmKuCKAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kMmQmNQykSg69IRQRksRLWW1aZsVriIcboXip+rJIPXUuC/M5K8yzG/2XsHdOitl7
	 nt7DK1ZM11okvx9GZWDjV63xWjuFRLkVJUfwKaDEZgxL5M2DjMmETaqkbjKrFFVIQU
	 Z+t2TB8DCYh/2VZlSBDFY/UFnFJ979AstMRHilaW4bs3jqjXWmgJ1lL6igWdRftate
	 RQ+fzl1Bi6aTSKVpqtntKf3d1ZTAbe9ZLecJyUzK5tL0lCJD7BEBR/j6B+jcfivSON
	 biv2OUuGdsdCmOJu+DTQ1LLku2Z51NTVcnNgXc3kW4IJbpcliZZTRozd/QZNcue4gJ
	 1qiLV4yd4RRuYYCr5zKYvGlEKXiu99WfJ+Rwyf049qjvojH8kwnWpFF5a04pb4/ENn
	 To+9zKPJQNqWt/4DJjNdFWvfdXR68aHJU9N5TvnXwtoGzEt4GeVgx6gZ8kiuqyNK7o
	 +iGxjtYrOaHOHXkAZOorchJOzszwmMn1ssZmvJI5KiXnf9DFE8SbdHaSTDYAf3mKxh
	 1jPCsUHPkx8jgP8kyw/Y5jjUzkN6t8rvMyAJsMoUTcQ5zDweh+5GXrPWLaREzKoiP0
	 t8GjC4rsGf8KDI3+Bv+j2uHDdJQUgEkUTAb2LQe6x0TWdSwSdeq0CtLYJ8HDR+0U6j
	 rCiWevlgdeVwjKcjNjZZGlcw=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C2E0D40E015D;
	Tue, 15 Jul 2025 08:38:28 +0000 (UTC)
Date: Tue, 15 Jul 2025 10:38:27 +0200
From: Borislav Petkov <bp@alien8.de>
To: Sean Christopherson <seanjc@google.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, santosh.shukla@amd.com
Subject: Re: [PATCH] x86/sev: Improve handling of writes to intercepted
 GUEST_TSC_FREQ
Message-ID: <20250715083827.GBaHYTg9eU55LcHKR1@fat_crate.local>
References: <20250711041200.87892-1-nikunj@amd.com>
 <20250714104424.GGaHTfiFxI_pf-vhRn@fat_crate.local>
 <aHUTMiEJ-nd76lxM@google.com>
 <76e0988d-279f-be58-51d9-621806dbb453@amd.com>
 <aHUfecs9UJPx0v_C@google.com>
 <20250714161639.GLaHUtZwleS3COfxxX@fat_crate.local>
 <aHUx9ILdUZJHefjZ@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aHUx9ILdUZJHefjZ@google.com>

On Mon, Jul 14, 2025 at 09:36:04AM -0700, Sean Christopherson wrote:
> Or as Tom suggested, return ES_EXCEPTION and let the kernel's normal machinery
> WARN on the bad WRMSR.

Ack.

> Because as you note below, the MSR read should succeed.  __vc_handle_secure_tsc_msrs()
> is invoked if and only if secure TSC is enabled for the guest.  If RDMSR #VCs,
> then the hypervisor has decided to intercept GUEST_TSC_FREQ despite enabling and
> advertising secure TSC to the guest.  The guest kernel can either continue on
> with degraded security (potentially dangerously so) or panic/terminate.  

Aha, I guess we do want to panic here...

> > The APM says:
> > 
> > "Guests that run with Secure TSC enabled may read the GUEST_TSC_FREQ MSR
> > (C001_0134h) which returns the effective frequency in MHz of the guest view of
> > TSC. This MSR is read-only and attempting to write the MSR or read it when
> > outside of a guest with Secure TSC enabled causes a #GP(0) exception."
> > 
> > So what is the established protocol for reading non-existent MSRs?
> 
> Looks like Linux-as-a-guest will request emulation from the hypervisor.  What
> the hypervisor does is completely unknown, at least as far as the guest is
> concerned.  E.g. the hypervisor could return an error (i.e. "inject" a #GP), or
> it could provide garbage (on RDMSR) and drop writres.

I see.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

