Return-Path: <linux-kernel+bounces-740834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86750B0D9C2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89FC716940D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBA92E92BB;
	Tue, 22 Jul 2025 12:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jqRz5ZTh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QNuLfQzA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA447155CB3
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 12:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753187816; cv=none; b=Lj/mK1e8fBDWh8BJ9FOXVUB4+i8oUuwkZYb85TIZCAoykBg2mtnQnaI0H+dPjoIdU+k82EE6H+JWCSPD9OJSuHTAsc3D9uDrlPyJ/Zob3PmpcX7Hngqtzy581wOS25jUlDiA/PU1S3a/v6gNLGqg9pFwrQ1ErZZyBPG1dthOBEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753187816; c=relaxed/simple;
	bh=kphWtzDgyCjxtixAH5G3+tjAQ4SHcPyDwtj0yf4OFu8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rppTmkGN+hiV1fwCk44X7Pa2naQgIVf02NOxbxUlUTraqVM3GlZfdm94kPDSnUnBKDPlvjs84ViMckPkPtOrfOsSOQ3HniMbPghq/GABsZvN+vktvt9JW5+6vwtvK165qwVwfxcskkdIy1iPmzqQORniZjK9tOFpURwwiVh4HPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jqRz5ZTh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QNuLfQzA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753187810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cj3RJo7LhXbFe8x/bjHima/6s5igm92zkD+UOzN9wco=;
	b=jqRz5ZThgeRXJkLsv2DeW3u6BrnaOK3/yD3ChIVl+ecZBXwLgwb+2WBeq8ywMTgdwXX7pR
	c7h07XyYawVRqpOZUs/rjx0GUCLe6RXx4P12RjA7PNp+dJp5itdQRD+XIx18Z4+NFLRBYe
	zmth+Bsrv+k8yHZLCT6vq7oucwBkbxAaTplFLHD4KuNjIw1hoAOvN8cyCezHQdVP3PA4LB
	ACKGqSzoqZLHrn+93kX2InxXBH0Gc5fKei7qZZGTK9kt+pX/3D3SmUr0tTQdVNGIdhIXt5
	+0SyZb1H+diLhLcCC3kYfs5Hp+ZDRFT4RTeoJzmrFOqY5H7PpHLx5XT+lYxtnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753187810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cj3RJo7LhXbFe8x/bjHima/6s5igm92zkD+UOzN9wco=;
	b=QNuLfQzAUnaJPKPulpTcAtbjxacN0/sKKv6gcjuDim5grrbnAk5pVPFspa9W7zmHBGTQiU
	ONca1AVQ2k/9tuCg==
To: Jiri Slaby <jirislaby@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Liangyan <liangyan.peng@bytedance.com>, Yicong Shen
 <shenyicong.1023@bytedance.com>
Subject: Re: [patch 2/4] genirq: Move irq_wait_for_poll() to call site
In-Reply-To: <b97f4d0d-ddb6-4fca-bf96-e9f11e00e060@kernel.org>
References: <20250718184935.232983339@linutronix.de>
 <20250718185311.948555026@linutronix.de>
 <b97f4d0d-ddb6-4fca-bf96-e9f11e00e060@kernel.org>
Date: Tue, 22 Jul 2025 14:36:49 +0200
Message-ID: <875xfktna6.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 22 2025 at 09:07, Jiri Slaby wrote:
>> +	if (IS_ENABLED(CONFIG_SMP)) {
>> +		do {
>> +			raw_spin_unlock(&desc->lock);
>> +			while (irqd_irq_inprogress(&desc->irq_data))
>> +				cpu_relax();
>> +			raw_spin_lock(&desc->lock);
>> +		} while (irqd_irq_inprogress(&desc->irq_data));
>> +	}
>> +	/* Might have been disabled in meantime */
>> +	return !irqd_irq_disabled(&desc->irq_data) && desc->action;
>
> Just noting that this line is newly evaluated on !SMP too. But it is 
> still supposed to evaluate to false, given we are here on this only CPU.

It does not, but in that case the code is not reached because the check
at the call site which evaluates whether the polling CPU is the current
CPU triggers. So it does not really matter in this context.

But for the other case in handle_edge_irq() this has to return false. It
should not ever get there because interrupts are disabled while
INPROGRESS is set, emphasis on *should* :)

So I moved it back into the CONFIG_SMP conditional. Thanks for spotting
it!

        tglx

