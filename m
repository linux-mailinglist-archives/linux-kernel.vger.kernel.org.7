Return-Path: <linux-kernel+bounces-729810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 475DFB03BDD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 371734A0998
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C416242D9B;
	Mon, 14 Jul 2025 10:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Ebkdrr2Z"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D0B23C4EB
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 10:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752488869; cv=none; b=gToljkZS6NB5eZhSyVJH465s2EDyJmSlEsI6U+SZ5TwNeDAVZE0OZ0Shk15lkDitVUUIBqlcgBpOf0JKxcRSNDQoOiNCIA1DGwdnGCZT1hSLj2I+EiBrHoFSJJm9N0yw6hZbDZfCwBk9XSwOSd91tcapRil1xopHKbvzfqXYbDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752488869; c=relaxed/simple;
	bh=7f5JO+G5HSg85L10NnYDJg7gTycID3e/O4cdxAf0U2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVBfJ7XbcEFzObqYR3tpuFhMJXzl1RUJyCy/Gq/9a09iLgox45rAQxmll7ePhF4CF5ftdfEVXFDG8uRMb91iC3CNqs3aU9OVzbaDKVVYCJ7+PpHIK9D6j7AyWDaiY4rq9f7yJ4d2tE0p+t8G66413VYKAJ9MOmVfDGyCbyWWslU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Ebkdrr2Z; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 48B2540E0216;
	Mon, 14 Jul 2025 10:27:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id PDwsZvDTdks1; Mon, 14 Jul 2025 10:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1752488860; bh=NROTqCYd1HPCd3KjwaxGfkgS7An8P7HR/pAbvsSC+UM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ebkdrr2ZMM2R0m6Bx4MmqAWJBPUQFKq5wVCacxwcERPGRNUI54UaZfS5JCk16L5Bx
	 50v8/HxJGaeswItFtl6N7/ZMrqNs7t+KAUayI1LF3aOzPDKvSb3+olXpTPKh/8Hht5
	 +W4Rr8Be+kVQcoXT8fLtyTrQK9a7Z/vjkTLWCVEWinYv495po7bVIlz3grzvPoUF1Y
	 uMsQYC1hoUgUIwpMe39vV5UlxqG5FduP+fJ94x1lER50iGyEDzWdcTrH5IhskP9hAs
	 MG8DchvARI9bUvK8/R754xQEHd7pg+/uykFumfrKAXYra8hTb+K3LU4UsqY4wGd4zD
	 Q3ecNJlK2kXyoRTUGrJixsXVVACZKTecYL7Hk8B0Vnrs7nYmDiQklyvGzX9czAmlfi
	 7RVHajXTwUuCRf6Z0sYPPEVBJKLQVsHiWr3Z6neCS4wxnRI2xz3y/p4vahdvagtgZS
	 81NRzV3svR3TS5r/1GAAl935zuKqU+Qp6m71jOvyJeC9N8EVKupgkJZ2nYCCCoKsnZ
	 slK6IFruJC1rkM+F9gZpLSEJwZP/bXW+cmx7QTZI3uo/h2sN2CeCKRUdkHa9Y4vD3r
	 g/xkEFYsGzDs+r5yuEOa8iA2BLbqT58QQiYfxnbuiwN6tTll3yti+9YD4nkm003/mV
	 Ffo2resE7GJ9JZq3AO5Q0FvU=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3B94C40E01FD;
	Mon, 14 Jul 2025 10:27:35 +0000 (UTC)
Date: Mon, 14 Jul 2025 12:27:29 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] x86/sev: Work around broken noinstr on GCC
Message-ID: <20250714102729.GDaHTbkRSLA61z7vPz@fat_crate.local>
References: <20250714073402.4107091-2-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250714073402.4107091-2-ardb+git@google.com>

On Mon, Jul 14, 2025 at 09:34:03AM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Forcibly disable KCSAN for the sev-nmi.c source file, which only
> contains functions annotated as 'noinstr' but is emitted with calls to
> KCSAN instrumentation nonetheless. E.g.,
> 
>   vmlinux.o: error: objtool: __sev_es_nmi_complete+0x58: call to __kcsan_check_access() leaves .noinstr.text section
>   make[2]: *** [/usr/local/google/home/ardb/linux/scripts/Makefile.vmlinux_o:72: vmlinux.o] Error 1
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/coco/sev/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/coco/sev/Makefile b/arch/x86/coco/sev/Makefile
> index db3255b979bd..342d79f0ab6a 100644
> --- a/arch/x86/coco/sev/Makefile
> +++ b/arch/x86/coco/sev/Makefile
> @@ -5,5 +5,6 @@ obj-y += core.o sev-nmi.o vc-handle.o
>  # Clang 14 and older may fail to respect __no_sanitize_undefined when inlining
>  UBSAN_SANITIZE_sev-nmi.o	:= n
>  
> -# GCC may fail to respect __no_sanitize_address when inlining
> +# GCC may fail to respect __no_sanitize_address or __no_kcsan when inlining
>  KASAN_SANITIZE_sev-nmi.o	:= n
> +KCSAN_SANITIZE_sev-nmi.o	:= n
> -- 

Hmm, so this points to the carve out:

b66fcee1574e ("x86/sev: Move noinstr NMI handling code into separate source file")

but then we didn't do any KCSAN exclusion to SEV code before either.

I guess send this to Linus now so that it is in 6.16?

Hmm.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

