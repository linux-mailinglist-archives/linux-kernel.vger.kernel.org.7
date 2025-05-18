Return-Path: <linux-kernel+bounces-652866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C957ABB15B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 May 2025 20:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADBC31895190
	for <lists+linux-kernel@lfdr.de>; Sun, 18 May 2025 18:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAEE1DE4D8;
	Sun, 18 May 2025 18:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WIgXN/bd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p7c7XeTT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6464B1E7B
	for <linux-kernel@vger.kernel.org>; Sun, 18 May 2025 18:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747594433; cv=none; b=jRuJx4/Cl85siHPIBybzA1kHsVHY7VmJ1pj0AG12jhnrQOT8aT4k5yPu8y6Rwp0Q63xuYIIVMC8U76mvzQi9dVQDDwF7wzeZ+pbbfu+U6jHG0YvA/v1c1kJhO7ZT9mTGgbjifebhQYB/ltZCfJ+4SeVJwksc+qDZtfncQGKLe7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747594433; c=relaxed/simple;
	bh=z3+Is2pQHfxHpGAB4BmGcCIhBFojKbXzr4N5lCgZ1B4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=prXe1yiRR9UcD5KfoLDW4Loq9TW0JMth0HYdjoQJRSAG5G7elVv93cMOsXTorCUoWF0tWq8dEj2vy5gMLT3o93G1BCaRphSb3P+bU7ZZ7FVaJosMdr7pgFdFuH5CSiE28fOdbOmbiuIFRx6KvJjpEVLvS6//4aiBctXtikZ1h4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WIgXN/bd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p7c7XeTT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747594423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cs3cB3RHEhPEb5x0MVvObkLAWIDcBbEagjqIMecWybo=;
	b=WIgXN/bdOwb7KcCajgbmGHfAkJ0O8ts2wo03AHvHhIs3VdConAkTxq5qCEow5Wu7sJFjSc
	j1pU9KKZeSDdOB/cxu95XmohzIQXA1u96RiJ5ask0J4S+0zzF/vs9y8pSxhP/6esJeusUb
	P2Yz7jpqJqAHT2F1+chtjA+HlYWIdKH/2pV6x0JNnNLN2gTCLujrlnRUSFhaTQI7rcCMpK
	9gclG52XF8IAaiYXQPln/CCRK++79Waw0mProUgk0x7orBaT3wAxZFYSadJeLYuQw0wc49
	LNfebdAdhwb+W2e0xasH1b8jya1c6hQEFX9taGv5w2caJMRolgK+5MigeLEF2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747594423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cs3cB3RHEhPEb5x0MVvObkLAWIDcBbEagjqIMecWybo=;
	b=p7c7XeTTE4uPpxZwi8SD926jrjL4/GEJSWxFF+EBUPcV21eGOQIQ6HbkQ30YOqmTphs6V7
	OLKUxb9lrFpuERAw==
To: Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Sascha Bischoff
 <sascha.bischoff@arm.com>, Timothy Hayes <timothy.hayes@arm.com>
Subject: Re: [PATCH v2 5/5] irqchip/gic-v3-its: Use allocation size from the
 prepare call
In-Reply-To: <20250513163144.2215824-6-maz@kernel.org>
References: <20250513163144.2215824-1-maz@kernel.org>
 <20250513163144.2215824-6-maz@kernel.org>
Date: Sun, 18 May 2025 20:53:42 +0200
Message-ID: <8734d1iwcp.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, May 13 2025 at 17:31, Marc Zyngier wrote:

> Now that .msi_prepare() gets called at the right time and not
> with semi-random parameters, remove the ugly hack that tried
> to fix up the number of allocated vectors.
>
> It is now correct by construction.

FWIW, while looking at something related, it occured to me that with
this change you can enable MSI_FLAG_PCI_MSIX_ALLOC_DYN now on GIC ITS.

Thanks,

        tglx

