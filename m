Return-Path: <linux-kernel+bounces-856980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D54FBE593A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 23:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C3F35E0821
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 21:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10E22DF15A;
	Thu, 16 Oct 2025 21:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALq4jmSC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2977821ADB9
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 21:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760650465; cv=none; b=mgl8EKgfahQT+5movE5v2CXY4WtsjFRIy4Tu8xvA6drPf8B0gIAcy5l/J0sShaPBgE99CQFU6iRu8JT6A2GNMBwpcWvk//d3TlvO2fG8yNmWhGg5cSSM2w+1k/v5ItsqYKxjYxrIM8YDtWRbYUBOC+1wD/7u2/OHG8v3Y2ssCMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760650465; c=relaxed/simple;
	bh=t8i29yMFw14O7UW+NuIa/whegX7O+/aFxl+ee2KJWa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ff1i5RtsS+wQNpu5oiQFxoLvZAUW1mYAcJWfuBPzcJwhodXno6/fBmqwQzf0bG2eyrXMpDgaIgtdtARsjIeNruGZwA+LFXUJQ427hS67A2mhbQjQrKGf8UA5gpVWr2SNd/BMy9B1FTr6fepjqlOHJb1QIS4TZHZWBPPe4Nk9agM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALq4jmSC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7697C4CEF1;
	Thu, 16 Oct 2025 21:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760650464;
	bh=t8i29yMFw14O7UW+NuIa/whegX7O+/aFxl+ee2KJWa0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ALq4jmSCOw6vIiLhSpvGwUsNg3WxFKKySIp8olOUXkBQZRGcKi7BZN3cyHvr5kyWC
	 Jt8DtrYFTAbolCKdGYeCDfeo6m3g3Mmk0xHLeCE+EUAM0r/coQkBSN84HlGUK5LNaa
	 Re/REg8pdmS7elg0dGqVloL6VOO6bHO4EN5ifyPprtRTMIytlm8e/b/bKRj9y7ncx2
	 nY2LimYQUklw2mz9JuZ7eGENcLTnQPZaTfIjkcw9ZtZgfvolt6ATxww8lsidd4YbYy
	 lwsM1R3eu9Zlj1yghbPjtPkRCQaqsWgcoXf8jYCICtCzlawnSDpVYiRzKpe5NGZONf
	 tU9b4JfQ3SiYQ==
Date: Thu, 16 Oct 2025 14:34:22 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: David Kaplan <david.kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Peter Zijlstra <peterz@infradead.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Alexander Graf <graf@amazon.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 03/56] cpu: Reset global mitigations
Message-ID: <fxgzzp3yokq24swgfkokdnqb7jf53s3na2wjitr5koiamfizgm@d7uvxnuzkebd>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-4-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251013143444.3999-4-david.kaplan@amd.com>

On Mon, Oct 13, 2025 at 09:33:51AM -0500, David Kaplan wrote:
> +#ifdef CONFIG_DYNAMIC_MITIGATIONS
> +void __weak arch_cpu_reset_mitigations(void)
> +{
> +}
> +
> +void cpu_reset_mitigations(void)
> +{
> +	smt_mitigations = SMT_MITIGATIONS_AUTO;
> +	cpu_mitigations = CPU_MITIGATIONS_AUTO;
> +	attack_vectors[CPU_MITIGATE_USER_KERNEL] = true;
> +	attack_vectors[CPU_MITIGATE_USER_USER] = true;
> +	attack_vectors[CPU_MITIGATE_GUEST_HOST] = IS_ENABLED(CONFIG_KVM);
> +	attack_vectors[CPU_MITIGATE_GUEST_GUEST] = IS_ENABLED(CONFIG_KVM);
> +	arch_cpu_reset_mitigations();
> +}
> +#endif

Considering this will have no effect on other arches (or even on x86 at
this point in the series), should CONFIG_DYNAMIC_MITIGATIONS depend on
an arch-specific CONFIG_HAVE_DYNAMIC_MITIGATIONS?

Then the weak function can be removed (and weak functions should be
avoided anyway, IMO).

-- 
Josh

