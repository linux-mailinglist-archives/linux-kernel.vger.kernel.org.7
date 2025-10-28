Return-Path: <linux-kernel+bounces-874429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 384ECC1655C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73CE03A9F25
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E439E34B1A1;
	Tue, 28 Oct 2025 17:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BbDk9LW2"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCD017A2E0
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673864; cv=none; b=e8oXyVrsl5Rg/xZsD8iZWKazzgKdOtoQK/0xCS63UTU6vCiMVx2rVvVLyRo39SOp7ZWUw8jyEzTk4qYXOGgKp3p8S4Egdh/RE162jhWCr6OOGOWd40iTGvdVnM0iR2Fzo5hlc+je0+z4WDBkJ6bnqJ5qk2BiCoaNzot46+M1OrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673864; c=relaxed/simple;
	bh=OR5hyWguXhFi+vK9n485+xoRTtPsJ9pKkAHM4sjOqUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WwHCHP2NP0wT7E1e9j4DuQluPInEzPrp1kZ9tStLA6Kif8UQDidKpsB1tDbSnJanmb8tnsQCQ9LhNGkiuhtwRYLFhB1qQhpsRp38o5yUtuoN/fWcl603NGa/UTst+XdCtHY7XgkLv/oGNHVtNogG/S8EZK+XSA4uIsHCJ9g1tuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=BbDk9LW2; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 494D640E0200;
	Tue, 28 Oct 2025 17:51:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 526wgh75SGto; Tue, 28 Oct 2025 17:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761673855; bh=oz3I0r0/Uv0Hig7MsmFlrgD+dOXSKw2vNqensbSzaSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BbDk9LW2AfJgFUUhU7QSNGi8GLRhgkSyLMyse1gy/TH6xPMwcQKKPKwwtj/OvQpBL
	 OwdS1SJ+RIlEW8tQjDmDgK5OVhWkpIGC34c0y5tELF0vIgA0FrsgLQWT/v6NorYEeN
	 IrsYB4H747CjBWuQP53cOzRWsZ+soz28YnFjRjnXGHpFCU56nof+mPLA10JRRQGCZ4
	 sADYdukju4igDy9zy19c7JsTQCQ4Tbpj+IDe5E0Ai8DKKEtjqJbMZci+SCyhVI3SzG
	 qXTAO8r2pwKTyFTZENLd4+GbjUGnC6uqAonWNdF63GNCWwYkGwFuUWabP/LGpyOwMq
	 7wKKlXu7Qbl3I0fZLzhXkyclU4dv4hE0F39h0uRiiXUKD+1gyE8RfwlCROo6B3dx3E
	 6rJ+vFf37DhYaD04hFhKN0Z93hoNxkd7XiSmmjWaRa65GRjnCeIg6qVgyCjmMdRc6T
	 oZw82kWTzXGN1zrPbyBPyc7hdk0zvTn459GBi8m2Zd+dkbChEn5SQE6k+5aUgq9yoY
	 znxVCeXuvbz/dw0MzXZ+aoI+bTNLK6QoJY8CSz3j+Z0UHLdpr7uMWV+GqBvHFdfwWU
	 5myGbbW8kOG34l5X0ZpyRUSEsdPsw7gOMM70QpQRlIc7lioLIqCUkf3vuhBEyvYzRK
	 LSPu4AoztyF1CTQQoVsbYsFc=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id B67F440E00DA;
	Tue, 28 Oct 2025 17:50:40 +0000 (UTC)
Date: Tue, 28 Oct 2025 18:50:39 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Sean Christopherson <seanjc@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sohil Mehta <sohil.mehta@intel.com>,
	John Ogness <john.ogness@linutronix.de>, x86@kernel.org,
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 04/35] x86/cpuid: Rename cpuid_leaf()/cpuid_subleaf()
 APIs
Message-ID: <20251028175039.GCaQECb5EqT1_pwqX3@fat_crate.local>
References: <20250905121515.192792-1-darwi@linutronix.de>
 <20250905121515.192792-5-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250905121515.192792-5-darwi@linutronix.de>

On Fri, Sep 05, 2025 at 02:14:44PM +0200, Ahmed S. Darwish wrote:
> diff --git a/arch/x86/include/asm/cpuid/api.h b/arch/x86/include/asm/cpuid/api.h
> index 44fa82e1267c..2b9750cc8a75 100644
> --- a/arch/x86/include/asm/cpuid/api.h
> +++ b/arch/x86/include/asm/cpuid/api.h
> @@ -131,12 +131,12 @@ static inline void __cpuid_read(u32 leaf, u32 subleaf, u32 *regs)
>  	__cpuid(regs + CPUID_EAX, regs + CPUID_EBX, regs + CPUID_ECX, regs + CPUID_EDX);
>  }
>  
> -#define cpuid_subleaf(leaf, subleaf, regs) {		\
> +#define cpuid_read_subleaf(leaf, subleaf, regs) {	\
>  	static_assert(sizeof(*(regs)) == 16);		\
>  	__cpuid_read(leaf, subleaf, (u32 *)(regs));	\
>  }
>  
> -#define cpuid_leaf(leaf, regs) {			\
> +#define cpuid_read(leaf, regs) {			\

Are we getting rid of that "cpuid_read" thing eventually?

Because with CPUID the only thing you can do is read - no write.

That can be sorted out when the dust settles...


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

