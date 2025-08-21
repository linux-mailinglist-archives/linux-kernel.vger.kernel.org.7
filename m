Return-Path: <linux-kernel+bounces-780477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5224B3025D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92DDB3B704E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827BB342CAD;
	Thu, 21 Aug 2025 18:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Mx5SsSH3"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4601F7569;
	Thu, 21 Aug 2025 18:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755802548; cv=none; b=ZZ9Mv0hNA1zshIr2Ylz3DCMxwe+x26VUeUZ9YSCSSE0WDfsoOSRLIG6uuZ5DRvi0mIHHssumPlKN40ejmuyYD+42mhGw9Jgl2oUx/YlbE3AizPFk1O4EOJ1ONSnqT0RfvzEvZ0LeYVc5Hd+LDb2irq5/2J/kWoXFx/2oUpYxUdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755802548; c=relaxed/simple;
	bh=zFUHcDJvbzNOwl1FWr1YwH7RVqJbXkRfrZIyqreRl1c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kSXjTG5cNLZPCnfhbsvhVdDbooOWwm1yRyNYrsA/PC4fRRNvRC3lLLaO3YKoZOD+z8fWI+mWsiXv845n7WN0khcp0jgwqOAfIUgBy2fzgID55GEIqm2Ks6GgpDVye7U71SJIHOQ50uKBhtTz/tShE/+LxOfftSTsye3FLimPq1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Mx5SsSH3; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A594640AD5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755802545; bh=L00NMz1INkZAETrRSptXWQEUzU6BVCW7sUXaka2fiyQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Mx5SsSH3dMFU13a7juS/VwetTdbl44ygyoOcWGDEYbPKydePzTtnhQrciRNkfMSZA
	 oqkk1pMxvFxXLUG6Om6NQHorKOWjj4Tamp1gB9s/MoJe99jVqSyqVFmXLuBz6pfXSV
	 XJ/reSnz282MvA22ltejXHG4QUvTSIxsKBaIbBXBLvRz8HUFP5e3CkfxnkzXbedVYg
	 n+oa/t1fy3KhlW+zAEBRQNHP3cz/FBMvT9VvHg5L88ZinU1tB+GUXhD1uo8Gv1oboU
	 vKh9SUH4UvXfRvPTRxIX94EVpp1DvFgOw44vYGqxxhyx6zZ2c0Xh0N4w++3oZzF7sl
	 W0QWQj8nLu5tg==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id A594640AD5;
	Thu, 21 Aug 2025 18:55:45 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, Boqun Feng <boqun.feng@gmail.com>, Clark
 Williams <clrkwllms@kernel.org>, Frederic Weisbecker
 <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, John Ogness
 <john.ogness@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Steven
 Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 Valentin Schneider <vschneid@redhat.com>, Waiman Long
 <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 3/3] Documentation: Add real-time to core-api
In-Reply-To: <20250819132828.cs64VMsW@linutronix.de>
References: <20250815093858.930751-1-bigeasy@linutronix.de>
 <20250815093858.930751-4-bigeasy@linutronix.de>
 <87seho8v12.fsf@trenco.lwn.net> <20250819080358.H9R_64I7@linutronix.de>
 <87ldnfv46n.fsf@trenco.lwn.net> <20250819132828.cs64VMsW@linutronix.de>
Date: Thu, 21 Aug 2025 12:55:44 -0600
Message-ID: <87349k7bdb.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2025-08-19 07:20:16 [-0600], Jonathan Corbet wrote:
>> > Right now this is it. Do you update the text above as suggested or do
>> > you want me to resend it?
>> 
>> I can apply it and make that tweak if you like, yes, no need to resend
>> for that.
>
> That would be lovely.

OK, I have done that.

Thanks,

jon

