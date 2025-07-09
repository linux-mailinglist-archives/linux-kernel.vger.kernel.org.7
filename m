Return-Path: <linux-kernel+bounces-724215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D6AAFF01A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 19:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22E94484AFB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71636233735;
	Wed,  9 Jul 2025 17:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MdcMAOPk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DCnIxKtE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F1821C9FD
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 17:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752083344; cv=none; b=TQXALmZcZRcs2GUswKCl2UBHOjzxcQAbg2EodckQgB4p8gPrnO60c0l+pMSoEjqHl9DAK2CVHC52Fy3AWBPy/6qwH+ekHFn3CzMys6AOB1onQ2gsGAj7hM3TgnTO4feqrmLDIfCJfPot2BoMgoS0iM4KpMEuBrkY3+8wSqyh6T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752083344; c=relaxed/simple;
	bh=zfrh9eUA1zxoWA7zHw+AY/mAIEfUqBHEDQhIvtXKXGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UyCsHpzs/IPa8X3Jv30PA9Wwxug2CDo/71JCuPAPntwbWHkZACloO7xgzP3moqBq6PkRdl0NJGZm/nTj+aKl3yN9buoEw2OS2S3MEsTy6hDs1eg289krATTdvyOYXi8PPWoyEETDghqp+alxDn/oPeppqMZNtsaVBAT2XAqbD30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MdcMAOPk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DCnIxKtE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 9 Jul 2025 19:48:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752083341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7IqoEpYFRNjbtqqAnFqnwbQLRCvOouomygWp7I8/+bE=;
	b=MdcMAOPk0j0vRUjAOn+wFmXmRZxgfv3vgdZ+WlsJRGXA74Z38XEjO7f5sr3OffbBa4j7tE
	fKmzS/7/Bcvl2qelelv4aAwj0s9EdRETxcPIOIL+5E1votDgS48U4+eFW/3xgDPZoonusN
	nX9QaMO7T3Wpb2YBVGaR14ixphOHeaBietpAmi6gQgq1mjc7WV9/jjCFQvZHQ4FAnadYV9
	6tdkEKXDBvfZp70wm+dmKzQ5z6BfNh9lkwFvqbFxTavQz2+MAmNI0dOvGYKQtI2Qsp8l1L
	SP3tfTIMe337lZt36jrYpx46gG3SK2tXZHrse5QEIROD9Z2CVxFWwK6lV6181w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752083341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7IqoEpYFRNjbtqqAnFqnwbQLRCvOouomygWp7I8/+bE=;
	b=DCnIxKtEr7l5JdP6mQWn+l/C7CdHVMUTsFZHWVBBA6EsANaVDEt7CDhGjgaXk4iZbOu67O
	YkqPNNJ4J+mo34Dw==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Sean Christopherson <seanjc@google.com>
Cc: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	John Ogness <john.ogness@linutronix.de>, x86@kernel.org,
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/7] x86: Disentangle <asm/processor.h> dependency on
 CPUID APIs
Message-ID: <aG6ri0-PlE-9lxyE@lx-t490>
References: <20250709170454.74854-1-darwi@linutronix.de>
 <aG6jH9ZHWiTxfFM3@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aG6jH9ZHWiTxfFM3@google.com>

Hi!

On Wed, 09 Jul 2025, Sean Christopherson wrote:
>
> On Wed, Jul 09, 2025, Ahmed S. Darwish wrote:
> >
> > Beside the call sites converted at CPUID model v3 above, this series also
> > switches below files:
> >
> >     arch/x86/kernel/cpu/microcode/core.c
> >     arch/x86/kernel/cpu/microcode/intel.c
> >     arch/x86/kernel/cpu/mshyperv.c
> >     arch/x86/kvm/lapic.c
> >     arch/x86/kvm/svm/sev.c
>
> I'm officially confused.  Neither lapic.c nor svm/sev.c are modified in
> this series.  Does "this series" actually mean something other than
> _this_ seris?
>

Oh, correct.  That list should've only been:

    arch/x86/kernel/cpu/microcode/core.c
    arch/x86/kernel/cpu/microcode/intel.c
    arch/x86/kernel/cpu/mshyperv.c
    drivers/cpufreq/longrun.c
    drivers/cpufreq/powernow-k7.c
    drivers/cpufreq/powernow-k8.c

I had a script that scanned the CPUID call sites which included
<asm/cpuid/api.h> implicitly through <asm/processor.h>.  I filtered the
false positives but forgot to remove them from the cover letter… :-(

For the arch/x86/kvm/ files, they got updated in one go by modifying
their internal "cpuid.h" header (arch/x86/kvm/cpuid.h) to explicitly
include the CPUID API.

Thanks,

--
Ahmed S. Darwish
Linutronix GmbH

