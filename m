Return-Path: <linux-kernel+bounces-815260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C44E8B561D6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 17:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79AD03AD02E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 15:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0732EF665;
	Sat, 13 Sep 2025 15:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Jenf04KL"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C139C1D2F42
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 15:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757777930; cv=none; b=jEXo2VbwHMVnNRk4Fx4ccANDmHxvU78wWkijYDfCmId84Yoep0Q4mJ47l655bq1gGIxsNBx03jxl6+QOIb4RXdc7KLXPTv/IImqSY/N19Rjh/Go6YSg2pThdTiqgvnw6itk9CcHIQJVLuQ3RStyptp9ZxMm/eyjxFb0xtBnqciA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757777930; c=relaxed/simple;
	bh=o0cw+/qJxKGp2elo9Pj5/hwo0ZikAKWvnf03jBM/ZpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YviqaUr4j4lW5oZFrrdIss6wf579AUE7UppOJUoM5UtsuMafeO6JcQWf1H+w68vj12rn4i+0cH+daQw4FkwgLs5sqAeqzWj302Jk/DxeRJ+8xrfmx2+UJbSlD95781vzOivGK9qcjDFuadtHH/PR3aoLibVkScuCQgOgClSodRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Jenf04KL; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id ADBEF40E016D;
	Sat, 13 Sep 2025 15:38:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Ib2gsR-33tII; Sat, 13 Sep 2025 15:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1757777912; bh=skGE6wgtkUMYrL2N9sq+F2lmUxUSauNsHSu7QPkuGyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jenf04KLOButi6go1cPlVhXk8fZ2DzU5cizi+svctkXN0sgumdIK5tNtBiz86QeJf
	 zz6HLsyINHuaS/bODKNsJREtPILxHs9QneuyaKFIpnINfTKNWZH1Ov2L5HoByAd2vn
	 LrRsUzgGn+fynoP1rXp+SCkNk6QaN+76zkDoMXDyPRn6Tbp13eMNbBw1wzEw/dT6EL
	 22mYOmXPdYaIfzzRBO4QFLZO3nuzlNIeNpZhzAfcEItZ93oIRMKxfSFbxeTVAb4Lo0
	 tOf7rsRA9I4cfn+zWDYyKMeep5U4zPsxrsU5z5Mcs5jpITdPJ/q1HRh1VYwhVQ/Sn4
	 gUfqyXqCazqo2YALLJDIDg0JaYlwKOWpgf4zJyi+M14emolxFTWlEZXVqonnvMdT9a
	 1FlzeFeGqB+L/jpRAJpbWvuQDabs5+aRMyKFNWG441Ux0R/2FqovpQrLpt+PFcYbVu
	 M8DSrWVlVQ1EW6nC+jQckw8Pbp3P88ctvBanEaYkVMnt4wtgH+flgWMW7dbibc/QJ8
	 Q+ZXzTL7fZcrVGXyw8db3A+Kvd5vMm8I04097z8xXrn5go5urMLgWteVNqm//EiF6B
	 VKdbWXUT8IWb59GDIkLYUZwU9HtGWukfP0QOXhr8g0SpYdJiWFjG3TJ7HPeG+X7aiS
	 1gW/5Pk97dAYA/+QOLWJ0ynA=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 03EDA40E0163;
	Sat, 13 Sep 2025 15:38:22 +0000 (UTC)
Date: Sat, 13 Sep 2025 17:38:21 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Michael Roth <michael.roth@amd.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Sean Christopherson <seanjc@google.com>, stable@kernel.org
Subject: Re: [PATCH] x86/sev: Guard sev_evict_cache() with
 CONFIG_AMD_MEM_ENCRYPT
Message-ID: <20250913153821.GCaMWP7THDz6sL26bD@fat_crate.local>
References: <70e38f2c4a549063de54052c9f64929705313526.1757708959.git.thomas.lendacky@amd.com>
 <20250912204203.GEaMSFm2-N6lPteue5@fat_crate.local>
 <20250912204929.pls6245t746gtalr@amd.com>
 <20250912210201.GFaMSKSSvK55XIwR3e@fat_crate.local>
 <56877590-a7c8-4dbd-b334-ae9cbbf62bf1@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <56877590-a7c8-4dbd-b334-ae9cbbf62bf1@amd.com>

On Sat, Sep 13, 2025 at 09:29:47AM -0500, Tom Lendacky wrote:
> On 9/12/25 16:02, Borislav Petkov wrote:
> > On Fri, Sep 12, 2025 at 03:49:29PM -0500, Michael Roth wrote:
> >> I think that's actually the concerning thing. If someone built a guest
> >> kernel with CONFIG_KVM_AMD_SEV=y they might be under the impression that
> >> this is performing evictions when it's actually just a stub function.
> > 
> > That sooo needs to be in the commit message...
> 
> I can send a v2 or if you want to modify the commit message with the
> following:
> 
>  The sev_evict_cache() is guest-related code and should be guarded by
>  CONFIG_AMD_MEM_ENCRYPT, not CONFIG_KVM_AMD_SEV.
> 
>  CONFIG_AMD_MEM_ENCRYPT=y is required for a guest to run properly as an
>  SEV-SNP guest, but a guest kernel built with CONFIG_KVM_AMD_SEV=n would
>  get the stub function of sev_evict_cache() instead of the version that
>  performs the actual eviction. Move the function declarations under the
>  appropriate #ifdef.
> 
> Let me know.

Right, I had fixed it up locally already like this:

    The sev_evict_cache() is guest-related code and should be guarded by
    CONFIG_AMD_MEM_ENCRYPT, not CONFIG_KVM_AMD_SEV. Move the function
    declarations under the appropriate #ifdef otherwise a guest kernel built
    with CONFIG_KVM_AMD_SEV=n won't be doing proper evicting.

but you can send me your version on Monday.

When you do, can you pls rebase it ontop of -rc6 which Linus would have
released by then because this one needs to go up now and doesn't need to be
based ontop of tip/master and be against the x86/sev changes there.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

