Return-Path: <linux-kernel+bounces-846591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B167BC871D
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 12:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C80819E655C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 10:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F1F2D5C9E;
	Thu,  9 Oct 2025 10:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZI5Syt8f"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D05E158DAC
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 10:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760005178; cv=none; b=IGk2gv2iwxSDJzTIN+beAx6XSmED3sVATjUzcsTxM2cuRka3WltYPbGrkFl8QaACgYZMHz0NRiDvARjPngfFDHo7DOFh1lKdP8e0UoZ+nXjloc4x+JRZPvoKA6IQoelT6ZRhs3uTFneXtzVZjruyQYbssZFG9dIxZmrq/nUjib8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760005178; c=relaxed/simple;
	bh=UqOEmpCMIZ3/g0sOblDzE+Qs0dHYBb5YgOuosdYsyZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNtT0hIiHOViItiElv8rMgk01OFuOR6HgfcuduFaPcgubQfjPx0U/ArKpD8ptjiAsIyXE36apeTmFkoQocCtU5wj2Dd6rwsmk5lbP/acWexUZJbcdzuEKiXkmzBPE3ReiTocJejyWVt2odv1qL2HfVFVsSQJGkJ9vUwFLvyvQ/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ZI5Syt8f; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E409F40E0194;
	Thu,  9 Oct 2025 10:19:33 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id LuT8qDPnpEI6; Thu,  9 Oct 2025 10:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1760005170; bh=k39MqihlSR0rYREOYPOk8WM9bA/sp+vNqIaDrsc+gts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZI5Syt8fr8perqf+kuHGcx1MgAjYY7zapKSrC8O73O2SDbeJ1BvJDSi5wZrjuVJbs
	 3UKdGGw6iTYmGgGIwiYCojhuf1RdNEJZ710vJxKng5x4JdxxlAoZxsKaXcz9yicJJD
	 8g/40tnyV4MJ0mrnEKrca9pzsXCvbtXPOakFNOokoNbLYiHs63DMVd9sVsktFMVd86
	 BDmCFxwuS7q174Q8mdu2+k5NdO/c4wppRY4hC1LjMnbMfKlx9/VcIFfqr2rya4LnHX
	 1DaVhihDukJPwerGZFNyqXRcSID1zM7fM39HAyI1coVHF5Qe1Ru0FmcQ+QVDq3jC0N
	 Kie05D/GlMkCSjkV40ztv/8ewMW+QFmPqG7gSgZNW/S+spxpgSQaBQaLmjAFe5mOZl
	 NYVf2hLP8q0V2Hk+PeOyOAQhtTezK/HSdh1yABQbE3qhdLNVGt1ZuJgQKzAjpYbTtY
	 ffTc4bpWMpRnyBUJjgicBueOMr2tsgsfuIBQBkaJdisXnlh2szeVi3Eh+GlyxnABFr
	 RAs2Qb31cCIJumg/49ReASSyr/c6fYcb1M4TAeT0IYk4GWzIxTbXWLuFalzBco/zpZ
	 79d8HnkK57sPlfJ6ZPPE7BZ1UNsWySERKNtWUWllb2e+GG1aOZpsovWdMQ6RJukTJE
	 X332sgHBuZxVLKfLfO2xd4oM=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 7495040E00DD;
	Thu,  9 Oct 2025 10:19:19 +0000 (UTC)
Date: Thu, 9 Oct 2025 12:19:18 +0200
From: Borislav Petkov <bp@alien8.de>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	"Kaplan, David" <David.Kaplan@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Klaus Kusche <klaus.kusche@computerix.info>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/bugs: Qualify RETBLEED_INTEL_MSG
Message-ID: <20251009101918.GBaOeMJgpbGuG9Pr8s@fat_crate.local>
References: <20251003171936.155391-1-david.kaplan@amd.com>
 <20251006131126.GBaOO__iUbQHNR6QhW@fat_crate.local>
 <LV3PR12MB9265B9AA81E01A539214764A94E3A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20251006140442.GDaOPMemqB7SRJSHWL@fat_crate.local>
 <20251007182257.ywrqrrhgrtrviila@desk>
 <20251007221229.GAaOWQTadGWlZSeAo_@fat_crate.local>
 <20251007230821.5shpa3pusyzaohb2@desk>
 <sb7p6quwxkn4w4etgsxlqd6fcsia4xobf73d3fnybxafxrmvwi@ajg5lkdxtnfy>
 <20251008102136.GAaOY7MBd4_VBPBNtG@fat_crate.local>
 <mnokj2q3ytnar4x2zhcazfaqrnxz353dsdczjgr7hxirlsf6pm@bn4ed3eou44p>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <mnokj2q3ytnar4x2zhcazfaqrnxz353dsdczjgr7hxirlsf6pm@bn4ed3eou44p>

On Wed, Oct 08, 2025 at 06:07:02PM -0700, Josh Poimboeuf wrote:
> I think almost anything which removes the "MITIGATION" from the name
> would be an improvement.  The build enablements really are a different
> kind of thing compared to the runtime defaults and it's confusing to
> intermingle them together.
> 
> The "UGLY" was tongue in cheek, but it does have a nice ring to it.
> 
> Maybe CONFIG_BUILD_INDIRECT_THUNKS or so.

Right, makes sense.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

