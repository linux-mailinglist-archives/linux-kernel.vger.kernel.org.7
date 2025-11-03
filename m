Return-Path: <linux-kernel+bounces-883625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CC43EC2DE87
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 20:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 382334E1D92
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 19:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E394320386;
	Mon,  3 Nov 2025 19:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="V4w2lXKg"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DE621E0BB
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 19:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762198319; cv=none; b=AHND5npW58cP3ub8G2Dh23Fu/79lTi4X/oUSVxPk0fKNg9olbQVE63edA5TNU70CXh/DWvt4hBqBiDbxW9AJ2tk3C5B25TtsokDAExW1ArolM8gsFQsoeDUGwCWu4UnqZ9QbiuBQElxmuQu5dPuzwiozLGjwi91Bncn1DGT2VVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762198319; c=relaxed/simple;
	bh=DXBqzhK29AzCTllJI66AsvQTIMyf+kRsPoBGiScXlXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cIu8OA7bXYezpSXfb98Eak97V9dKlBOJxMAwg6rxE5sRjg2qYP0AgU+BkYEJiIhpdyfNlIZ9jQj4GUMoj4rodIRbc9EVCG3iMJp+lKUUmoOqKhP8xnv2Os9kLM8VSdN1JCy89PK31P/l1fMmxaaJQJlxa9L9JtYA33X+HigY+hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=V4w2lXKg; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A527A40E01CD;
	Mon,  3 Nov 2025 19:31:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id o-9TDGnvldGz; Mon,  3 Nov 2025 19:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762198310; bh=z4O+2wyoWXHjofRhWOFPC9iD87/WYawZY76kC8rYaCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V4w2lXKgK3xm2SUmm+dZqXGWDTgYVn6CPQDFqLgZs6uYPjxGBVFKxIGsuu7YBMZgv
	 5QiuWaqt0o3ymLNvKZ+QUxd+dWqxou8gm7/WrI6CocpXgDmiLsQ1lwN/+bgkT1lAYU
	 Tohv8d1ndT6oxzIO0Cf043h3Q9uyt9Hoj6raPKNzbvIdI0wSoStCxNKQ8YRQ5kiFk1
	 1EQPspeanMYDIF+5oTP64XjGwYX6gW5r0LqmjkADSgFbhV1Ny2uECFnGRy1gcG2dKV
	 cPOsEP47aRKushJjB1hG6SVCtL/BnieJC9VknRGxsbFc9NuELZK6LaC2kFLdj20XWI
	 SLa7DJ+sYreTWSmOc21NJcNxgAAzwQidHvyCWG0D4lyoVljgA+5YXvEIXqKwvKNw86
	 61N/SSYt3FeHKJIMS+xOAmJbkfdgkkmXCznmrsco8W8/BZ+bAYbZtj30AqR1RWD3GJ
	 CakT0sDk5jpO7IO84FKzBWUonAEcAZ70Zl7M9nKfkzrv/EYZcosUFkQTQVAcaN7d3M
	 sNlquKsv0CtS8LDDcJs5+mfop8+FotBgHz8ZmBl7GBhob2w/EXfsKVFVh8wI3wZTWP
	 lDBk45gee64wQnEZOqZXbS2rHhsuvFAGGt0txYnnA1TKa0NxKJt0y7s37p9j0EdP4o
	 o/vqTUZW3JoDhYpKVgAgn+jk=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 1069940E01A5;
	Mon,  3 Nov 2025 19:31:38 +0000 (UTC)
Date: Mon, 3 Nov 2025 20:31:30 +0100
From: Borislav Petkov <bp@alien8.de>
To: David Kaplan <david.kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, Alexander Graf <graf@amazon.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 05/56] x86/bugs: Reset spectre_v2 mitigations
Message-ID: <20251103193130.GQaQkDEquEnEwb_cwC@fat_crate.local>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-6-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251013143444.3999-6-david.kaplan@amd.com>

On Mon, Oct 13, 2025 at 09:33:53AM -0500, David Kaplan wrote:
> Add function to reset spectre_v2 mitigations back to their boot-time
> defaults.
> 
> Signed-off-by: David Kaplan <david.kaplan@amd.com>
> ---
>  arch/x86/kernel/cpu/bugs.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 9d5c6a3e50e1..0430635bb17d 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -2477,6 +2477,24 @@ static void __init spectre_v2_apply_mitigation(void)
>  	}
>  }
>  
> +#ifdef CONFIG_DYNAMIC_MITIGATIONS
> +static void spectre_v2_reset_mitigation(void)

Yeah, the reset should definitely be a single function - this ifdeffery around
every single one is going to become yucky.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

