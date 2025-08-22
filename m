Return-Path: <linux-kernel+bounces-782628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCF9B322CE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 808E7640A19
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 19:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58192D0C8D;
	Fri, 22 Aug 2025 19:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="KJjpOTjC"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006DB2D0C7F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 19:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755890900; cv=none; b=kDxsF3vz3I/Q/ssh2uIPbXrR4oEERI71MnuLPwsRWwvSJoCSDd9nz/VvUuycfuujYnYWLt0xb7oUwwIadfkI/bYbykn4Z9mKUhBUug8QmAM11tzdiJ/Qi4CN6VpNAtBpxoAlTBPR6NOSQb8ds/12OZTwYJP7/tzJ7k2QAuWFxGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755890900; c=relaxed/simple;
	bh=j7A81r6RegdpWcYK+nl/r11XbwhWIIuLUbhyJyMgDFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSXNR9bjCUvcRjT7WHFNNe0296pUWSGb9YSxG8NSFDRr+WOdWN3yKmt7v7zHcpuOoEm0Q+OGMuxl/R8h+t6odE0aIeP0RzhOkjZp3ZF727+w12rbqYdV2PS/wTpxxn50nf6U71aAmgncSwQNd4R9W+rN3d9Q0OSyNfFRR4cL+ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=KJjpOTjC; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7C3FD40E025A;
	Fri, 22 Aug 2025 19:28:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id T2m5S5JyptlF; Fri, 22 Aug 2025 19:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1755890890; bh=R14rzH+K/gudqUukLtOD/dl9q9GH0ErTFk5o67w8BoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KJjpOTjCCWaHiFfYpDscCe2ZJpwFAM4b7mAS6ONMwIusSYTSdZk4ut2J31t0Udu78
	 vlN2jIlmZCaXMFKA2s0PVFsWOsjOCwFmSY6db7qcE7lRLlgDf8my0P5I7yptqbyvXm
	 zdGiRG2crthyD0n/2xviDLbGFk0hgtDCBXi5noxY9r/0w+LYWT1oN8IOOOm1cipHMc
	 j3UGidTWyt+jI7N8bHNxc+uzXGd5qu2lZSpzzRUik24iYwyTEBIQjqshn6+RPmvnZI
	 eDTYgv+G+ESNBZyt/bjAGUyYs/Gw7KMglECgmR/1E/8T+uSIUnNxoe7YPvil4uwuSb
	 JaTx0wK9StnmgKIy8rPMnXmWacBQRsor5zz2LjEtkpLYqox+QDvTbb44cZUEj/dcOU
	 hPGPcYNSSQswfwguaK3kkxCsw2A2WFdkSZR/fyUoT0IIBQTRxWnd8oICDTwVvlgVpo
	 LYiA7vqG3wrEVvPzoPqAZrzZzCPRYGQcCBBHhD2T3qmrSV0Y44homwu6itYgWYeNlE
	 626eqlD3BCfWz7C4IhLBBcTdNzuTrtePewDfnE9EjHAWYO/cb6EigKRflQ8YOzS5Ox
	 ZDEb2hefGgTioOrevTu5WSmihQEo5w7Mc3mePvRwtmJ+97+wOK55Y3DdJ9g9BATZBw
	 pNaOwKTn7Wb2x+tKfXm9HJUk=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7DFDB40E00DD;
	Fri, 22 Aug 2025 19:27:57 +0000 (UTC)
Date: Fri, 22 Aug 2025 21:27:51 +0200
From: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Sohil Mehta <sohil.mehta@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scripts/x86/intel: Add a script to update the minimum
 ucode revisions
Message-ID: <20250822192751.GJaKjEtw5Rf4f0K3DE@fat_crate.local>
References: <20250822004422.2908427-1-sohil.mehta@intel.com>
 <20250822100949.GAaKhB7ZlYxjpfcIit@fat_crate.local>
 <aaed72a9-8dc8-4744-96ae-ac3db9fb4d01@intel.com>
 <20250822182447.GHaKi176wVuSsNMmi4@fat_crate.local>
 <4d5a17d5-f26a-4682-ab7b-5a3b05b5af3a@intel.com>
 <20250822190622.GIaKi_rpJxdNGsbDlf@fat_crate.local>
 <2d677e21-a5a7-4b68-b11c-e73473bab0a6@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2d677e21-a5a7-4b68-b11c-e73473bab0a6@intel.com>

On Fri, Aug 22, 2025 at 12:16:59PM -0700, Dave Hansen wrote:
> Ahh, gotcha. Should we slap something like this in the script?
> 
> 	This script is intended to be run in response to releases of the
> 	official Intel microcode github repository[link]. Typically,
> 	someone at Intel would see a new release, run this script,
> 	refresh the intel-ucode-defs.h file and send a patch upstream to
> 	update the mainline and stable versions.

Yap, thanks!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

