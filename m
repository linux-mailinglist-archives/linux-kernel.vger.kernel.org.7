Return-Path: <linux-kernel+bounces-856006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA9EBE2D7A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FDA73A91E9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7DD298991;
	Thu, 16 Oct 2025 10:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l5T/faxn"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54BC32860C
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760610977; cv=none; b=YRzoiiRA5JumcvwacyDQHdq8lxTRCLckyHA8qxTBmiCA/8Q6zlq/pBLAF0qtdV/xgPWyGQQ0U2bH42Qubs5ASIV6FHDmPFISdrjx4namgWekC24PvLtMNlkf68TeukmT4zjAaRItj8sTcQRCcsqV6ZqZslFCkVHW/bsheL4oz3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760610977; c=relaxed/simple;
	bh=yJmsG5snjletFUGDWa3Mkz4pMirMe1Sfopo25+Ze0oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NvV44pTgZsYRq80iXsHwwRaJ6P9m0OQwqtxm/Xkn3rIm4NeVEUPNCuVLJ4QlWkVnKIOLNjcc/Zupa+4aUDkpXYlXASt3Bo407E9T2/7GFZSa6c95GYuElEj948BrsOeCiX6ztTXaYw255mMkZe4ZkKsUG9a75VkqREZ1kCVrpP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=l5T/faxn; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RFNy4a6PgC15sFlZ/beUEW1vHmRulGivY1TO7Dtp3mQ=; b=l5T/faxnHO4jTUxR/+h7r8o1Vf
	EUAn7cKRIG0+pRj+fzqhphNmV8iu7kqrzXp097I0i2VTdlEcoz0/uco6Gq4fkzT6nEnMTT4H8v8ps
	TT8xhpuZfviDEg1/TI2z+nQKtBX3Bwe7fp/w2PmARmDZ8fJ5sn6bX8O/5SsMqt2e/s7QYhVrfPxU2
	aHN4XLcfiuEuzx+UB4Zlk+iyo8iTWKh7XaUwK89tB+IVuNYcGsJ33eKD++q2rMwl12fR9xInTS2GV
	uHmYZ0jA0hZyQcDHqlOLoOtvJnjXQpIqABa5aqOw8lDAXFxE1/T+EN5CsX2PEmJ+suHZ/bJctbIrq
	JjQsJzpw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9LKp-00000006gCP-0GUB;
	Thu, 16 Oct 2025 10:35:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BF64730023C; Thu, 16 Oct 2025 12:35:49 +0200 (CEST)
Date: Thu, 16 Oct 2025 12:35:49 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: David Kaplan <david.kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, Alexander Graf <graf@amazon.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 40/56] x86/alternative: Use sync_core_nmi_safe()
Message-ID: <20251016103549.GD3289052@noisy.programming.kicks-ass.net>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-41-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013143444.3999-41-david.kaplan@amd.com>

On Mon, Oct 13, 2025 at 09:34:28AM -0500, David Kaplan wrote:
> Re-patching is done under NMI context so the NMI-safe version of
> sync_core() must be used.
> 
> Signed-off-by: David Kaplan <david.kaplan@amd.com>
> ---
>  arch/x86/kernel/alternative.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index b67116ae883c..2d48d750d4d9 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -2585,7 +2585,11 @@ void __init_or_module text_poke_early(void *addr, const void *opcode,
>  	} else {
>  		local_irq_save(flags);
>  		memcpy(addr, opcode, len);
> -		sync_core();
> +		/* Re-patching occurs in NMI context so we can't do IRET. */
> +		if (repatch_in_progress)
> +			sync_core_nmi_safe();
> +		else
> +			sync_core();
>  		local_irq_restore(flags);
>  

Can we please keep this in sync_core()? Something like:

static __always_inline void sync_core(void)
{
	if (static_cpu_has(X86_FEATURE_SERIALIZE)) {
		serialize();
		return;
	}

+	if (repatch_in_progress) {
+		sync_core_nmi_safe();
+		return;
+	}
+
	iret_to_self();
}

That way all the modern stuff that has SERIALIZE will still use that.

