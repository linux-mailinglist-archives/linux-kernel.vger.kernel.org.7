Return-Path: <linux-kernel+bounces-782169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA44CB31C3D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F04301D64F08
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AC3312800;
	Fri, 22 Aug 2025 14:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ja+P0SEO"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B32F2FE564
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 14:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755873036; cv=none; b=knQqCrVCVD/PEijDdbFT970PVoqJmhPVl8l2+14BclDkBQ6Eq06YCgP046GDEoAjMmlisjw/nT6iUfKFY05T9gJTl3QBPKO8meN3PP7vZnXhVqMWfjAlLhOxaYWvCXOKHnHsHEdvyrsz/W1Th3zggnxN51454MHux86y+j+hYWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755873036; c=relaxed/simple;
	bh=lx+9ptkXridgKN2DcXJ3RabXFLqdxt/swF+dtu7ZgjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMozSMrowS+yffx3tGGP1vH4VhFQwRdvbwKCjdX/VeoJMxOoNgUYOeFc0ZVUKTnaSkUMcOA0bzuDGnmON7erhkAoRg/26tj2zTe80E1do54m+NN4yxNi6Jwz6ljV71jz1WdGeFlQvcGkDcWxQ+SH0gPDahQ6wf5bHunUa/Rh4gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ja+P0SEO; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E9FC940E0286;
	Fri, 22 Aug 2025 14:30:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2CILZFRwk500; Fri, 22 Aug 2025 14:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1755873028; bh=y3OUvwJblg9g40ohiszRM90iEA+TKXTmh3i2dLoQEsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ja+P0SEOYwQoAUgEnnTjHOqdWpQBvDWpk1sFeN1g1uytCx8V29h7cQl3BubFC/5NO
	 ejTxnanyvU10ymlgD72fdoQ/I6LcnMANeKMGnsaE0+ICqapLbRUPGRipOJSftc8Yoe
	 ZcJWhHiK45Tbkb8JXqkrjdCa+xG7X6BT/WPkaaXS8MDnDjLHVHJAcEcVcmXxUzqkPb
	 8lDe49jLY2Q2jI5lhpyJKNH9XsYNdJwrTS5rtnNQUzmhcGmty1vK8rWlsvPi21UVVo
	 5Dt1WTbmForAUGKt3N7zKUTSVkZHtJcEl648UTEtx2f5rU+GFa2I+lBjPr4TITHj2r
	 O424GRuwDS0FSKX7+Vm4GLstGQg1askqwf1YjtdsJc1vgnlxWHBjhANxeN5bDZx4uM
	 EyNJ6JbvVHBH/2fxI85v2c43qu0zU4DIl/EP66A6PXNzIU6Lg56SEfSXXirehpVpfe
	 nsFDfLFr7xiIe7WiZPk0jfrC0TDUeJjDtu9114dgJ81E4pbl8GX6N6VqlNlOYmBvDH
	 99+ZXhyMThhsnoovGOiErruXdwvtOFGBtY+z4lZs+qUtZ//M7MUa/SGmQFitNuKGG0
	 me1gvA0Zezf5efvYDWGPZRmm6XXtpqx4k8Gn/N7Sm9zqfPlA2q9lvteMeSIjkYLTjC
	 sl+67Ca1K//tfiBmG5B21rlM=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8147940E00DD;
	Fri, 22 Aug 2025 14:30:18 +0000 (UTC)
Date: Fri, 22 Aug 2025 16:30:12 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kaplan, David" <David.Kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] x86/bugs: Use early_param for spectre_v2
Message-ID: <20250822143012.GFaKh-9DsBRQfapi87@fat_crate.local>
References: <20250819192200.2003074-1-david.kaplan@amd.com>
 <20250819192200.2003074-3-david.kaplan@amd.com>
 <20250822114918.GQaKhZPrvA7zP33TX4@fat_crate.local>
 <LV3PR12MB9265EFE40F2C8EB7C15BBD06943DA@LV3PR12MB9265.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <LV3PR12MB9265EFE40F2C8EB7C15BBD06943DA@LV3PR12MB9265.namprd12.prod.outlook.com>

On Fri, Aug 22, 2025 at 02:12:55PM +0000, Kaplan, David wrote:
> It could, but I felt this was a way to logically separate the code vs having
> one giant function.  All the code in spectre_v2_check_cmd() does one thing:
> verifies if the chosen command is possible on this system.  The rest of
> spectre_v2_select_mitigation() then uses the cmd to actually pick
> a mitigation.
> 
> Since these were two distinct flows, I thought having a separate function
> made sense to make the code more readable.  But that was just my opinion,
> I won't object if you want to inline it.

Right, since we're making all the mitigations handling uniform, I'd prefer to
have the same code pattern here too. The function does get a bit big but it is
clear that it does two things: (1) checks the command before it (2) selects
the mitigation. And the others do the same so...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

