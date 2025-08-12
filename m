Return-Path: <linux-kernel+bounces-765610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92598B23ACA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 23:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3CC0188FE3E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 21:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAA22D12E1;
	Tue, 12 Aug 2025 21:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="PiyF49QS"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB59197A76
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 21:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755034655; cv=none; b=V1vt271r3LXl2klA3wFCyEcM5GiM4UAkKPmqszLK6IsoO4jf001JzqCrXfgloPmYwznRzYfJcezzKv+f2YP8KqaMC8rignNJt1WsziFe02pAgYLIWWczeY+YZOdIlAAOiH2zv0vZG3raOWQ9DaED8iiAj1NnmwEsIEH+fgOn+dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755034655; c=relaxed/simple;
	bh=vV2K2cHzTeb8HXCJjFIfoBtLEy3r9YqTI4+LVB5VJcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDZnofoDthzCQm2JhQVFJSFJbgnTnIOQk4152IY8oa3IBF7DEnDDf5x5Zw3JpdrZc0AGEXyBuPVMVavxh1+zkSTjJZhpSUqMNcIcG/Nk+Rw/fW/FNmIwsburH1qwn4LX/bdjpgibYjDvwCRox/7MB7c9s5KSlL9Rxgiapp9O/xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=PiyF49QS; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6D96B40E023D;
	Tue, 12 Aug 2025 21:37:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 7Nv_TGLk92Kp; Tue, 12 Aug 2025 21:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1755034646; bh=wsXJk9gKZlHDsHfw/Y728t+4pnIAoBDzUHny86gk1z4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PiyF49QSpcKiijnWHtF0F2II6t8xBTHX8zf5sHE+ldKO3HeG+eaeNNtV3MrF1j4lO
	 EPZ2bq2Wrj9yndpYBWM0mlnHIKjF1uhPF7IyHnjZ0IIIiXV2A5f+XdUwWeILvGmcFF
	 luA9RylEb50n5OnmdqtWFMPt/1MlPnF97Vc1gXEn4wsMANE4e3JvcsO1LFlvNqeB0m
	 EEcZjjIYTm1U9X+mrGRU3aQCUKaydiQTvXVjOOZXiufIQ0Q/7FtZGLkjHtL5iL1t4p
	 r/a62JU6tEjBRGRBlmL5fSdqG7Q8hdHfdWLe5eH8E6DIfTwO5kdmj2KL9oFPApHgco
	 zaO0RkGH+wAiPI4+jQ/dLplDlyX439/kAB8V4cduvlpdiGk8y6wXGOFN0UCIMLuFnE
	 c6+UrlQmNnp6yAuT3NnnksklT3+zOU5tAfNq5f6FMVYfLK8G5Cgxa1Pru0NtcxxkWo
	 Xs8bKlVBY14yWOZs2qgxTHlEb5W/VgLYUYQ2gChv7UBrewO+93P9f4n36yJLdDnwHI
	 yw47wVZbCPp3FA6jshwcLWXoeZtJgrDSg/kF2xLjZB7Eb2dXM+pNGmi4FwYrC8Sirn
	 SDhV/3MiagyEWFOL1u7AFpSlcbY8/iyQEvhqXMGpvHueoOTia+WW0tQE4BFAYZYgIf
	 T3EqU41kTLpveFLTDsNe+EwI=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B303940E00DC;
	Tue, 12 Aug 2025 21:37:19 +0000 (UTC)
Date: Tue, 12 Aug 2025 23:37:18 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/CPU/AMD: Perform function calls post ZEN feature
 check regardless
Message-ID: <20250812213718.GIaJu0DgbRbBq2mfDY@fat_crate.local>
References: <ee4e9ea71713cee72bb637e848c6a272f8a9e631.1753290066.git.thomas.lendacky@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ee4e9ea71713cee72bb637e848c6a272f8a9e631.1753290066.git.thomas.lendacky@amd.com>

On Wed, Jul 23, 2025 at 12:01:06PM -0500, Tom Lendacky wrote:
> Currently, if a ZEN family/model is not recognized in bsp_init_amd(), then
> function calls after the family/model check are skipped. This can prevent
> older kernels from enabling features on newer hardware, e.g., unrecognized
> new hardware won't enable SEV-SNP because bsp_determine_snp() is skipped.

bsp_determine_snp() relies partly on the family detection.

If all you care is calling it even without family detection, why don't you
pull it up, check c->x86 and be done with it?

But even then: we don't really care about older kernels on newer hardware
- that's why they get backports. We don't really think about backporting when
working upstream. Frankly...

So I'm sceptical about this.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

