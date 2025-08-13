Return-Path: <linux-kernel+bounces-767582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65426B25649
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 00:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6DA43BC006
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 22:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC972F39CD;
	Wed, 13 Aug 2025 22:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qyRgJpH0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BAt7ut8g"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0D72EA743
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 22:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755122918; cv=none; b=V102L2dyNCBuFNrRuBqplvdpA32uVHSj+44H+RSkGvCxJ0WT9haa/15i3EaMnjwLy4aU6mGlYuFsdq17njY+m5d53fKBtfC2ZGX/WfSsiXOiFiDFJ5THp65jRSQ09mFDZ3eDp99WFE57p/ZKH39wVcPnPUOImioErLcbyt17rV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755122918; c=relaxed/simple;
	bh=OaYM3obHKZ/CPH+P9kky35KoETEEifJP9rYw9CIY8e8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Uwxc9vijIfPNmbNQnBvBwV6WywGuh4B3MZ4MvdOQxJuWaeKKPtXtlrWVxHSohPVNKsrKjFtpKcijRVkWKLIy4+P+/g1WuYKo8b0smNY8UOemVegoiw91wmAhkQ63f0h4b71GUQamLsK432WqfXBwoecIPkJug5+GoUg+4u5xXqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qyRgJpH0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BAt7ut8g; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755122913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6bnrhmTejItkeo982JeGsxifcGLJ0XQov0JrW3C+OCc=;
	b=qyRgJpH0XAbnIIa2QkcQoBYYiJWy74pCpGldBnRkfvQ8BrVDfvN6nHAE+3pscME0B24ySa
	szSNWgBy1jFF/EGYXtTaPEgLkq/61RJ8y8Km3GKECTnSWgUMsYDjAwExc3nEWfsgVdHmLT
	0Nt9JBBpvKBL6ODr6WzOfyIFsCoQQabGUg7g8msZYrD0tLztT9oYsMsUSXTHqO0wx+6w9+
	ns0rUDePUPu681kYD53gG541vu3tl5e0eygr0WNlZZysgFapGqxEa0+ppBYZpmpmhwEldz
	SpycTCGXrKoxmxxfcIeAN55HQ+EXHiYOdZ14LfPvWOGuqAifj4aCWhyxqI2vMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755122913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6bnrhmTejItkeo982JeGsxifcGLJ0XQov0JrW3C+OCc=;
	b=BAt7ut8gymE5SGEPuFbkDwgW+VUTsawug9Z+lk8qnng1LxWreD/FjHdPMCpAvJHCnnbI+1
	itfGyrzCLO9LGaCA==
To: Jens Axboe <axboe@kernel.dk>, LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, Wei Liu <wei.liu@kernel.org>
Subject: Re: [patch 00/11] rseq: Optimize exit to user space
In-Reply-To: <6b428c1f-4118-4ede-8674-eceee96036c1@kernel.dk>
References: <20250813155941.014821755@linutronix.de>
 <12342355-b3fb-4e78-ad5b-dcfff1366ccf@kernel.dk> <87bjoi7vqx.ffs@tglx>
 <6b428c1f-4118-4ede-8674-eceee96036c1@kernel.dk>
Date: Thu, 14 Aug 2025 00:08:32 +0200
Message-ID: <877bz67u3j.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Aug 13 2025 at 15:36, Jens Axboe wrote:
> On 8/13/25 3:32 PM, Thomas Gleixner wrote:
>> Could you give it a test ride to see whether this makes a difference in
>> your environment?
>
> Yep, I'll give a spin.

Appreciated.

> If I recall correct, I'd see rseq at 2-3% of overall CPU time last I

I'm not surprised.

> tested. I'll try and do some pre/post numbers for some of the stuff I
> usually run.

Cool. Thanks

      tglx

