Return-Path: <linux-kernel+bounces-773888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 494CCB2AB6E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C8597A9273
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487BC1D63EF;
	Mon, 18 Aug 2025 14:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rpw5cUfs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OOgbGEpC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0CE35A28E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 14:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755528458; cv=none; b=EQpzfpG5JuMpPyETjO9XHqYj5whbPia7xmsdYieS7oDXD2T7E+5hpUvEjnu9lG3h3a1A7D52Hp3tVW16yhprWfZniUfcvx2EjUqq5vYanS+3tthNdNRMDR/bBSbNN0qqKgX6o7uAWedf+lr3h8WXhoDKuXO+eff+KFuR6E9VgQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755528458; c=relaxed/simple;
	bh=/gevmWoGhr/iSvgSdPa6jgG1Fdb5jzFj8h50WFqbKMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWFYWrHXDBc2TDx62II2GUQsqDvuJKuaTGOpPaobW3X6L49M3pCphQa1zHDT09qKvEjWy5UYCZV8A/6gPIIqbfyXUp3q5EjzSPA+9nomwG0xzxFv/jNNOgqYWNxetWCMr+rli7ikVAKSofK65GFgeO4FUnnvKiYadQJwtnIbTfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rpw5cUfs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OOgbGEpC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Aug 2025 16:47:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755528454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MD7BlFTIAjpDURHkhhochN+snxk6+ltTIEJ1JTtK1ss=;
	b=Rpw5cUfslher2rbOCkLNveM/8tf4htp9SJmKyGJkiiuWCvTOvFWYSfvdVyEJKkanVf3FT8
	+ZOpNolYBds2gYZejg9mp6ci+EaQyds6xkhggjR6vdkvJKBV9V2Qatd1d5h7jlG5Vm9MqB
	49+P1EwT9h7Dmd5TRM9I/5828jTBxF8WQ3JgjYgWWShOcWJgElE+RHVXon06Ne7esmkYFh
	opdjOyDOb0zgUvsypIXF22gi5hmCsrreNHlzZ4yhfbuyCGILuHWfoQa4NoQrIzTJMwaTC6
	5SjpMitC/XomcX0DGPG7Fwo3zl3ee8knqc7qlxB/smPjDHYDFWx/oqtAaMu1Bg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755528454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MD7BlFTIAjpDURHkhhochN+snxk6+ltTIEJ1JTtK1ss=;
	b=OOgbGEpCbZU8q/EFr4Tz8uWcgnpsaUmDuzPu7nMd2i0lloyGvqC+qZ7Y5/UUM3aVtbuNde
	L/QiWsowXU4w4eDw==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Sean Christopherson <seanjc@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sohil Mehta <sohil.mehta@intel.com>,
	John Ogness <john.ogness@linutronix.de>, x86@kernel.org,
	x86-cpuid@lists.linux.dev
Subject: Re: [PATCH v4 29/34] x86/amd_nb: Trickle down 'struct cpuinfo_x86'
 reference
Message-ID: <aKM9BH0q630ClMth@lx-t490>
References: <20250815070227.19981-30-darwi@linutronix.de>
 <202508180405.3e28d0dd-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202508180405.3e28d0dd-lkp@intel.com>

On Mon, 18 Aug 2025, kernel test robot wrote:
>
> [    1.202568][    T1] BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
> [ 1.202670][ T1] caller is init_amd_nbs (arch/x86/kernel/amd_nb.c:319)
>

Hmm... This is triggered by:

    static __init int init_amd_nbs(void)
    {
	struct cpuinfo_x86 *c = this_cpu_ptr(&cpu_info);
	...
    }

Since this is all __init code anyway, for the next iteration I'll use
'boot_cpu_data' instead of per-CPU cpu_info access.

Thanks!

--
Ahmed S. Darwish
Linutronix GmbH

