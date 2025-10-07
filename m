Return-Path: <linux-kernel+bounces-844421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 150A5BC1DDC
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 17:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7F523AE835
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 15:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9522D8363;
	Tue,  7 Oct 2025 15:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1xTLpEMd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FgB82ZS7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335411F584C
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 15:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759849704; cv=none; b=Zb+sG0q9LaA+E2gI1ke/XP7MQCR6NzIR0YaQvhLdixEcilPZbDE+bil8hflf8ofHuad8Tp0i1YKFipPiiPA/WXGgWFzs+epvgOY75Q8QHiQtYiu/gLbPPDFxD2ZsQJhwwAIiH8V1n7aZSka8OYKXIWbAJ2PSTFAUsbHiDHyG8ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759849704; c=relaxed/simple;
	bh=a1TD+8KpfeH/gJbsaC5UOjx2oAXgUqjMX+M5ZKF55Mc=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PUNINiFo1oaA3SDaLTfaIH2Ej7kMLCrl1VpQVqlStNloHATzA1dPjq5c6EOmr2mUh+n+q5iqudNikueCmU1xSnnWGprUOjjJecDfnyollWm9+OapGVEIKZo8K8hge/E46JL14kemmBKFELgPlB4ktmO17rG0IUUqeDdoraug+m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1xTLpEMd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FgB82ZS7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759849695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lwuiILyNljPc/pGF/DwYzC5Yq//Ho19n9iQQGYFYzXs=;
	b=1xTLpEMdJFBGqHDQkx1jHqvqyJLl9zJx3NeaVRTj2PIyEOO/4lCWjEbWL7twgB5CD02DjO
	Mn6CQLRKmsg9g8tOKWuWjX+k+tW0Tn9YoD0+eosOqO5fmKd3MHgbvH2GC6f8tE1OHkDp+/
	wFEJZc3Lw36ECQg08fa2BFKLkKBFuIBRBPScZbxhRAmzzktGOkNIpMhiHDTs5tFO+GeHhN
	8G84WynaZHuAGqcSMfFcMnJtt9dpCIsALqbcr5CPr8yWBApTXQzDqa4YKToo4RoGhtFuI4
	dIfre/2SIsneQz17QFmM4k3qHVWI0F/oMCsP6/iSAAJbY7meQPJX7wT9X2kWtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759849695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lwuiILyNljPc/pGF/DwYzC5Yq//Ho19n9iQQGYFYzXs=;
	b=FgB82ZS7utrlEobQnHn3iaXSzw87eyZ9gVfWg32mGvG8miU60ovILqbg3DXR/IC7zhXrP4
	3ScuJ6ItK+I/7/Cw==
To: Ritesh Harjani <ritesh.list@gmail.com>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
 Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Thomas Gleixner <tglx@linutronix.de>, Marc
 Zyngier <maz@kernel.org>, Gautam Menghani <gautam@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] powerpc/xive: Untangle xive from child interrupt
 controller drivers
In-Reply-To: <875xcrxp10.fsf@yellow.woof>
References: <cover.1754903590.git.namcao@linutronix.de>
 <83968073022a4cc211dcbd0faccd20ec05e58c3e.1754903590.git.namcao@linutronix.de>
 <68e48df8.170a0220.4b4b0.217d@mx.google.com> <875xcrxp10.fsf@yellow.woof>
Date: Tue, 07 Oct 2025 17:08:14 +0200
Message-ID: <87playvjfl.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nam Cao <namcao@linutronix.de> writes:

> Hi Ritesh,
>
> Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:
>> I am facing kernel crash on host when trying to run kvm pseries guest on
>> powernv host. Looking it a bit more closely, I see that we are missing
>> conversion of xxx_irq_handler_data()) to xxx_irq_chip_data() at few other
>> places, including in powerpc KVM code. 
> [snip]
>> Here is the diff which fixed this.. 
> [snip]
>> ... However grepping for "handler_data" in arch/powerpc I see there is
>> atleast one more place where we may still need the fix.. There are few
>> more places which grep returned - but I am not sure if they all really need
>> the fix. But I guess VAS should be fixed i.e :
>>
>> arch/powerpc/platforms/powernv/vas.c:   xd = irq_get_handler_data(vinst->virq);
>>
>> Would you like to submit an official patch for converting these other places too?
>
> Thanks for the report. I didn't expect struct xive_irq_data to be used
> in multiple files while making that patch, sorry about that!
>
> Something like your patch should do the job. However, my gut feeling is
> that multiple files shouldn't share a single irq struct this way. Let me
> stare at it...

I *think* we can do a cleanup. But I don't think it would be trivial
enough for 6.18. Let's do as you suggested for now to get KVM functional
again.

Nam

