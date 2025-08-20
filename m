Return-Path: <linux-kernel+bounces-778123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0548B2E19B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 17:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E6FD1BA4B67
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EAC322763;
	Wed, 20 Aug 2025 15:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="FGlUNitg"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBA5322534
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 15:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755705379; cv=none; b=IkrochudDsiGUwUJFu8tojQuscMOK1iTRONJfcT7oy0hRZlUsvkHkwuiPh2IRObiH6FltnGGKNef1DwIyy99gxefmk/0SLLRn7Ur7g8PlIS6IJ8Ix9fKw7w2DqRyxxYQ79PWlEaqppQbVMCYHgj0YRvGCtC4rM+Qcn1KI6ww/+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755705379; c=relaxed/simple;
	bh=Ztv7UV5P057lx3U3cxXplP+nQA5x+kXzdOfMyB2e1xQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bn6hGsVfCp3/PE/oqoLtAEsZUauXfmeJMCybNLxnHB1+DuydvH/ZwQomZ4rhZUPmcDhJFRRQbYhDJzdCV4B2oO52bGGp0pZnTt+8Lkc3aLS8yguVl9zdezrcsgXn3vnVGQ/iwMZu1gP26ZQV4cXyqfkqNIRR4dFasNpHtZj8uS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=FGlUNitg; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 370D340E0206;
	Wed, 20 Aug 2025 15:56:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id XwcykwZtOXk1; Wed, 20 Aug 2025 15:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1755705371; bh=NizlxltdzKBHg/K2q9jgpZeNKU8MKcMEMHs98zy879c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FGlUNitg4Hefmfou3zmpEMFUbhXxLGD35jgQM09EA3od4Jd9HLA0HogwuBlMsPXGF
	 TqQqrdUUfxSbijDABqgZEJo1CkzDT0+jsgHVYUlvlEBXa08hqXapRbxwCrhwusuHE8
	 Diy4ZbQOUDp4YrYAiDreiT3P/1JfeVFafkJFOTIaTc1mQaOmZC0yG7K2QyzeNAnDFK
	 AnTe48m9BgfaZWQMZitTp30tcer5NSb7F4IZ6d46XRLyGhcSdUgPfFZp0C2K9RUhMB
	 yGEtNpbWahWNZ/R8Q74pLKuSX3elgYgGWjObJxysU3sxY9XhmLkIHcZHVLPmFNEuIq
	 bAGkUl6cAs78ew3MxCMke+1ZoyGod6JHzZq4K974Mmirrw0OrfabYCyx6FbWw24o55
	 TFpivnj/GNW2JC1u5jckW31IYP/voKPbvJBkeXhILuwTI3A3Bgc373ap3/AtnGDQtw
	 tglN1S6bwpzf1AWXOAfzLW+6z3bdTKnXv1b7QfEYzT2okUgqHdl4xlWfo+rkc1Ww3f
	 wewiEe4NIXeYvqeolgQSRieSSs9S808hTk23SxVMaT3OKHFyZyWYbSJElku+CZW3Ic
	 zrIm9/e4wY7tGvxA7tkvunF378TPOsy+YzX8mJoRiORGNAdzD1SGKyCrvmy2g6dJ2f
	 N69PY56uOwyDfk+qXJYRX5pY=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1182E40E0163;
	Wed, 20 Aug 2025 15:56:05 +0000 (UTC)
Date: Wed, 20 Aug 2025 17:56:04 +0200
From: Borislav Petkov <bp@alien8.de>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: Borislav Petkov <bp@kernel.org>, X86 ML <x86@kernel.org>,
	"Chang S. Bae" <chang.seok.bae@intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -v1 2/2] x86/microcode: Add microcode loader debugging
 functionality
Message-ID: <20250820155604.GKaKXwFLU3C8iltWjI@fat_crate.local>
References: <20250820135043.19048-1-bp@kernel.org>
 <20250820135043.19048-3-bp@kernel.org>
 <6e5503b9-bc5b-4147-836f-8f86f2ac8124@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6e5503b9-bc5b-4147-836f-8f86f2ac8124@suse.com>

On Wed, Aug 20, 2025 at 06:35:51PM +0300, Nikolay Borisov wrote:
> nit: s/in a guest// since nothing in the debug code is really dependent on
> whether it's run as a guest or not.

It is - see get_patch_level() and microcode_loader_disabled().

> dito, AFAICS it's perfectly fine to have the debug output if not run in a
> guest, no ?

Maybe.

But let's enable that when the actual need for it materializes.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

