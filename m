Return-Path: <linux-kernel+bounces-731498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7A4B0553F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3AFC4A020B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03827275851;
	Tue, 15 Jul 2025 08:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HZqbTlJm"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF6A26D4F2
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 08:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752569055; cv=none; b=usFv1g6ln1SWe3SFqca9FEw26IL4r3e2HFXsDp2tGSB1jxVpol4W+Fe5RboEfnzDfdfZ0KJqAAuvJFmtW4FRTAepuRRD6o4Y2CYGrn1TyMooT3Qd5kXmpxt613Mw6WcwAtnmzVK6Qe0p/xW4feI+AuaN47PsrTncBQbtVe609Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752569055; c=relaxed/simple;
	bh=mcToWc/fr0EQqM/JyKziVPnwRXDMtItq5cFsngYeYt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XixHkKaw0n1iQOHnHq+zdqYfvB+nrHNza6g8QpLGiIb8vhwXYzEINdjCgN2tF6A9I1t6veSNQgK8BmejB/xHi0heSnZoCEpoYGKhqj+4kvVR29ADcREpLspOUdPqbIS9wDFoGXjcyr8qa0zuItVvho3UZYyRScI2chrm8n1PVJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HZqbTlJm; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 430F340E0208;
	Tue, 15 Jul 2025 08:44:11 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bOcSNm5eBAze; Tue, 15 Jul 2025 08:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1752569047; bh=VcSPNt8XxO+CqQOBaxqM7aIo4wT0QVt30q8qKGhmaLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HZqbTlJm/HLiD0H0POWqE/3Ollw2X1szzn/rvba6feuoyDJFT8i4dwi9aVG8E28S4
	 M4UMBPCE/DJHCG22cspZe8D81YVos0Cp7YdKeEB4v3fZa5DuzgkbBreXMsLzKS+2Pj
	 0CF6k37Yrp4RnqRbhWiAz18RTGL6ObX+Q/pjtF7TG7COrHrwBsSTntEzHKzRqBtEcY
	 S9kqeIxyalco18ro7uUGGihZ4qqx1ZyrlRqxCBuhXQcULA13h92lteiNe5Ov+DOA05
	 pk9iEruqMwinWyqxhJWZZa2QeLBrFARdSP25fMI+7A2Xd+/j3X39GnxSCMUViiTqOg
	 9pAFFbT6SX71oWHyXGGdmfTZT5fXTNHa4lR9KbSLxPn3DZtlc1TlBEwfRYNHJq9xoh
	 sA8hB6992XNg3EGsAHiQahLiIPLoXBcSgxivrHYfl0GIPJe+QUMgkIc/JhMy9kQazX
	 4bXReL3zN0zrqS3jgXDbBk2rBnaTe8vi99JAcBI4tTIkP7bVIAUVn9wkYugoVXH78F
	 Yj5EawYHp4WAJTDk5xlxecaZIGsLonavvB6yibAH65VTOMAXubRCUDHS65LzaCO9KE
	 2QqM0yPUJ4DePH0ZlUn1Y3WNrsNTIx8fcCueln5nEZ+CZqKtJsfvUpe0/L3aJtqLca
	 /SekVSWt/r5Ul441nqM3ge2s=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B7C7B40E015D;
	Tue, 15 Jul 2025 08:43:58 +0000 (UTC)
Date: Tue, 15 Jul 2025 10:43:57 +0200
From: Borislav Petkov <bp@alien8.de>
To: Nikunj A Dadhania <nikunj@amd.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com,
	santosh.shukla@amd.com
Subject: Re: [PATCH] x86/sev: Improve handling of writes to intercepted
 GUEST_TSC_FREQ
Message-ID: <20250715084357.GCaHYUzeqvBxJyGVsg@fat_crate.local>
References: <20250711041200.87892-1-nikunj@amd.com>
 <20250714104424.GGaHTfiFxI_pf-vhRn@fat_crate.local>
 <aHUTMiEJ-nd76lxM@google.com>
 <76e0988d-279f-be58-51d9-621806dbb453@amd.com>
 <aHUfecs9UJPx0v_C@google.com>
 <20250714161639.GLaHUtZwleS3COfxxX@fat_crate.local>
 <aHUx9ILdUZJHefjZ@google.com>
 <85jz49x31p.fsf@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <85jz49x31p.fsf@amd.com>

On Tue, Jul 15, 2025 at 08:37:38AM +0000, Nikunj A Dadhania wrote:
>   Currently, when a Secure TSC enabled SNP guest attempts to write to
>   the intercepted GUEST_TSC_FREQ MSR (a read-only MSR), the guest kernel
>   #VC handler terminates the SNP guest by returning ES_VMM_ERROR. This
>   response incorrectly implies a VMM configuration error, when in fact
>   it's a valid VMM configuration to intercept writes to read-only MSRs,

Not only valid - it is the usual thing the HV does with MSRs IMHO.

>   unless explicitly documented.
> 
>   Modify the intercepted GUEST_TSC_FREQ MSR #VC handler to ignore writes
>   instead of terminating the guest. Since GUEST_TSC_FREQ is a guest-only
>   MSR, ignoring writes directly (rather than forwarding to the VMM and
>   handling the resulting #GP) eliminates a round trip to the VMM.

Probably.

But I think the main point here is that this is the default action the HV
does.

> Add a
>   WARN_ONCE to log the incident, as well-behaved guest kernels should
>   never attempt to write to this read-only MSR.
> 
>   However, continue to terminate the guest(via ES_VMM_ERROR) when

ES_EXCEPTION

>   reading from intercepted GUEST_TSC_FREQ MSR with Secure TSC enabled,
>   as intercepted reads indicate an improper VMM configuration for Secure
>   TSC enabled SNP guests.

It is getting close to the gist of what we talked yesterday tho.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

