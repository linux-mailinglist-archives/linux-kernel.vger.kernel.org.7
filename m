Return-Path: <linux-kernel+bounces-759699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE97B1E154
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 06:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4918718C23B3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 04:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330BC1C5D57;
	Fri,  8 Aug 2025 04:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NmPqKo5E";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dkxkoec8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5885182D3
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 04:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754628779; cv=none; b=uMccJJR0nKtovaiWjArsU4jRvQCGGkjOT+N0pzhPn1wPJaq0Yw8BePa1IwiWcq2JR24XYUgYKnlsbvJs1tazxSXK2IL5zKr8nDtOHtMSlUeLtdDPewuQ1yhs//9HI1BGQoQhRv5308wMK0ugd9jnwKi1x6fULAmDLFTxpRFsQgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754628779; c=relaxed/simple;
	bh=JDnGGV7dC2AbZvKaXgtHgt5QXxVMQtVIKS4qBQaA58U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y62m6BEMcvyWbyamnClpsuzLxsNK32zGx3h0Qt06+6v8h6Nikw8x0L93iAWJuU3KFNdjCwfIY/KTqDtnWwp3Uf4dzu/B2yV24V0XnPRm+fzZ/qEQ3GvjbKOLYkfGkxGewubSdvfrbwjBMRbwgbwJc6QRP33YynpzkGx+NYGNWgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NmPqKo5E; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dkxkoec8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754628775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JDnGGV7dC2AbZvKaXgtHgt5QXxVMQtVIKS4qBQaA58U=;
	b=NmPqKo5Ev007ZLd0iXzzv3TkeqjjsCFihzHkopauv4t9+m/nH8+JJAS8yNg1IuT2+euAJS
	rK6UdMm7t7wERSUaxCWxw5And+7rzwO92iNZaWOFRvT+1zxy/0wDnXJCXNV6m54wgvqeUB
	0YZCRPERBzmL77gHpgF5VDgStd3vhSzmaSRbJ+42ScFXiDGj4CBJb8QE+9zpnzBnphj8RP
	VTkc+ESbnTnEn+cZDlwKvaSkmGcCz848zsMei0IMxtVsICs9PwplBgv/wY1vrr+ZkiF3EL
	F+eeVdbhcVNjCai1G4Seh5/opYwo3Jkg4vSGfhAo8c5V3cabgBEkcj1AsVgA4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754628775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JDnGGV7dC2AbZvKaXgtHgt5QXxVMQtVIKS4qBQaA58U=;
	b=dkxkoec8BEhRpTO14mVCPGwylv4H2TKn5yquJUDsjdM4wRUJRjAnQ2McQhBT92uGYwQbWF
	QsF+WmM0EpQ3WRAA==
To: Inochi Amaoto <inochiama@gmail.com>, Inochi Amaoto
 <inochiama@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Paul Walmsley
 <paul.walmsley@sifive.com>, Samuel Holland <samuel.holland@sifive.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Yixun Lan
 <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH] irqchip/sifive-plic: Respect mask state when setting
 affinity
In-Reply-To: <prnjyu7ev5scocf4jh5jikox3niftje364lf3bjvizppxamdov@hbizpiazqual>
References: <20250807111806.741706-1-inochiama@gmail.com>
 <87fre3mhkh.fsf@yellow.woof>
 <nowqjgxmomniw624avrizohwzzq7ebkznb64m25qim3zgxjacn@oizd7ngxjd6a>
 <prnjyu7ev5scocf4jh5jikox3niftje364lf3bjvizppxamdov@hbizpiazqual>
Date: Fri, 08 Aug 2025 06:52:42 +0200
Message-ID: <87qzxmpg85.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Inochi Amaoto <inochiama@gmail.com> writes:

> On Fri, Aug 08, 2025 at 06:01:39AM +0800, Inochi Amaoto wrote:
> After some dig in, I found it is not very necessary to add this,
> When all enable bit is clear, the PRIORIT register of irq is
> not functional, so only umask the irq does not make sense. Only
> calling irq_enable does enable the irq.

Yeah, I contemplated doing this myself when I added the unmask to
plic_irq_enable(), because it looks more natural that plic_irq_enable()
and plic_irq_disable() are opposite. But I don't think it is necessary.

> I prefer to add a comment to describe this behavior, instead of
> adding this change in a separate patch.

No preference from me.

Nam

