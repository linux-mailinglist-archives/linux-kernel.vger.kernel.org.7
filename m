Return-Path: <linux-kernel+bounces-726628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC48CB00FA2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 01:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FF5B4837D4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0602FCE1A;
	Thu, 10 Jul 2025 23:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="AHtOorpP"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91E028C02A;
	Thu, 10 Jul 2025 23:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752190026; cv=none; b=TKWdhSPpcR35muSugE+FN8NxwEfzHCJo41m6PyndIdblU/WppWaomszTExtYg8TxNz8/PiduQGGJrr2wRbeER9FwWdDiGbVYvsh1Q9ojgS/UV4ZIbUTK6umNG90iiJ/7qXxy+HmLsiudV0K8SwUf50vjP1BCloucXtEkYcwDSGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752190026; c=relaxed/simple;
	bh=JLxwcqB6Hsk8DPZYoYpM9/I7F2/i2+Vdq/+h2E4Qitw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHcigkTL8kydJNj11jj07GaQGlySYJ2Fp6f58wwdmeLFUjYV5Gwobz5q1Faj66oizGvs8pmvksvfK1CfljaiYSaNKdAUAAm1eGTsYetnl+B0sWdaBC8jp/Q4OzbOQDMEw+JKeVFyWbpWLD3kuJGM4Hyc5Sr+SZmfbJbqQGHaOb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=AHtOorpP; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0CB8340E0218;
	Thu, 10 Jul 2025 23:26:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id IbI8tFEc_mPW; Thu, 10 Jul 2025 23:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1752190010; bh=KwiUIakYJ6Mt6/DlTOES3FmAASt18hIJhtPvmUP6lW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AHtOorpPJkOUcFcdqqh8a70ewq9koBecvbfEmDdO+iHeUqvMlTTpKqH1B44cushMr
	 ENFTo/lxnIW4tn4gq26M2QYEDTAG0tN5HoHr9fbmrf5JjmwOF0v7Z0lvXceyP77iCT
	 uXREp/enJ1Ka0grq8lWaRF5GcNoGPGJOuwaPPG4i420YgNXLSrKnyDmYMRvVMgjr89
	 nHwDRGKKMkDj2rSmAbN4RyOVWXuNgiDUvL10MCO6EfcmVA5skh7CrBPRaTWOht1dq4
	 4mDdyqAwRFH4ExX5VnW+1yPfLAAAtGxusoJZOqqWQGYswP4sw2nlhNPKYihGr0qBPu
	 a8cYKXIA03zNDsrWdB7QBrAaDblX2bOGpTpUQfIX24ZW81Y6qWgu2nHjvsGQv0fqZL
	 eMxAKM9fPd7uoGeUKbcVdeXcbQNep0Twm2pioUOAxmf5+nKP2CeaPuGRo0PdPxVyrE
	 eBPynOylbsOdyM8WhBXzkH2xAB6Wk1tEkdzjZBuTkskl3F0BfAA8eJyW73XHp15oMr
	 1HO22jIoozzgIWjICPWsf07ep3yakL7raulsq6A9deXYSO9zX0H+z45oZ0xt+32Eql
	 SwuMOvU1odPkVp8Mlj7b4ePGMpJYrnXX8wJ7LqJ6t+R2SbZGWKzdFt7SzBnPK969UK
	 mrEtHePK8fXbd+H4LUnvVP/Y=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8CF4940E0163;
	Thu, 10 Jul 2025 23:26:12 +0000 (UTC)
Date: Fri, 11 Jul 2025 01:26:07 +0200
From: Borislav Petkov <bp@alien8.de>
To: Babu Moger <babu.moger@amd.com>
Cc: corbet@lwn.net, tony.luck@intel.com, reinette.chatre@intel.com,
	Dave.Martin@arm.com, james.morse@arm.com, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, akpm@linux-foundation.org, paulmck@kernel.org,
	rostedt@goodmis.org, Neeraj.Upadhyay@amd.com, david@redhat.com,
	arnd@arndb.de, fvdl@google.com, seanjc@google.com,
	thomas.lendacky@amd.com, pawan.kumar.gupta@linux.intel.com,
	yosry.ahmed@linux.dev, sohil.mehta@intel.com, xin@zytor.com,
	kai.huang@intel.com, xiaoyao.li@intel.com, peterz@infradead.org,
	me@mixaill.net, mario.limonciello@amd.com, xin3.li@intel.com,
	ebiggers@google.com, ak@linux.intel.com, chang.seok.bae@intel.com,
	andrew.cooper3@citrix.com, perry.yuan@amd.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 01/10] x86/cpufeatures: Add support for L3 Smart Data
 Cache Injection Allocation Enforcement
Message-ID: <20250710232607.GEaHBMD54IXx3e8UpH@fat_crate.local>
References: <cover.1752167718.git.babu.moger@amd.com>
 <e1ea4ad34a7ca4bca7fd03b96c961bb59bd43f9f.1752167718.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e1ea4ad34a7ca4bca7fd03b96c961bb59bd43f9f.1752167718.git.babu.moger@amd.com>

On Thu, Jul 10, 2025 at 12:16:15PM -0500, Babu Moger wrote:
> Smart Data Cache Injection (SDCI) is a mechanism that enables direct
> insertion of data from I/O devices into the L3 cache. By directly caching
> data from I/O devices rather than first storing the I/O data in DRAM,
> SDCI reduces demands on DRAM bandwidth and reduces latency to the processor
> consuming the I/O data.
> 
> The SDCIAE (SDCI Allocation Enforcement) PQE feature allows system software
> to control the portion of the L3 cache used for SDCI.
> 
> When enabled, SDCIAE forces all SDCI lines to be placed into the L3 cache
> partitions identified by the highest-supported L3_MASK_n register, where n
> is the maximum supported CLOSID.
> 
> Add CPUID feature bit that can be used to configure SDCIAE.
> 
> The feature details are documented in APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
> Publication # 24593 Revision 3.41 section 19.4.7 L3 Smart Data Cache
> Injection Allocation Enforcement (SDCIAE)
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v7: No changes. Fixed few conflicts in
>    arch/x86/include/asm/cpufeatures.h
>    arch/x86/kernel/cpu/scattered.c
> 
> v6: Resolved conflicts in cpufeatures.h.
> 
> v5: No changes.
> 
> v4: Resolved a minor conflict in cpufeatures.h.
> 
> v3: No changes.
> 
> v2: Added dependancy on X86_FEATURE_CAT_L3
>     Removed the "" in CPU feature definition.
>     Minor text changes.
> ---
>  arch/x86/include/asm/cpufeatures.h | 1 +
>  arch/x86/kernel/cpu/cpuid-deps.c   | 1 +
>  arch/x86/kernel/cpu/scattered.c    | 1 +
>  3 files changed, 3 insertions(+)

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

