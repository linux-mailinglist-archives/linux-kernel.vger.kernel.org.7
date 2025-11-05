Return-Path: <linux-kernel+bounces-886558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B3807C35EDD
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 14:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5AB78349D89
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 13:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379B131D386;
	Wed,  5 Nov 2025 13:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ih7w2fgR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t5YFdliH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EF130F801
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 13:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762350871; cv=none; b=mSPfzfglgG7QYKgEnTOmh6yprjcx8ajeleJamBLQ9qynaCe3Z+bsGDOOvYQTfyfY2Z4cqd27aSo1udbt+Y7vRRNBFAnsK2US0cXZzPiFTeLcofNzsu5WS1f4BN2IZc/BeYZXmUPdMDujARPpi3om2Z2lyyJHPu/YoP73hhdmah4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762350871; c=relaxed/simple;
	bh=gxtFJeMNO44n6VBkhOR4527TgeMj6tC/2cOW4kEKPmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XO579AnAR9Fm7aM16XGXODMGSslKJJ0ndTShHa6AUrip82TxDXxY2DdX6o6OzecYY+dTaID/D3rEvbhhq8UxTOpSZsaZ8Idsbmggl0rILikuV66LaJqobSExfXEA625KMYaFbLVKnejQJqr8Jkhr3pqZlzeypjMpj7B3Q/xpK7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ih7w2fgR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t5YFdliH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 5 Nov 2025 14:54:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762350867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Annd0ihP7HHSBoBNQUUh2VGiw7tpGe4QfV008xC2V8c=;
	b=ih7w2fgROvhLk8no40NcMxn2f9mvnwnl7pNJVbDFgTiGkpsaugyjEjnj+dPvwM1rDeNoIg
	2/qDfi0bdNZKKClwPSM7gn/1/Wbabp4AI8oAx1TLGMaJin0EXjIAsQuSGoesmFcQ0m5aeb
	CcvKk04Gs1rplAsbrltOh+tFX0sUTYvjBuKlM0HiWrWWkh8CM9klOmzSnu+X/v4f3cU/MT
	Fvot9CZfzTrVFfbCTaqxXq/ghE44zzp1qQtqQ6uKkXnVBoAB2y9XfKND4ChsztVBcaQm23
	w1iwvFDAPhKyZqNUFbTy5KDDQKNeaFrmBEoOfQPejxjYId4XScmwkk1Lc7+wkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762350867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Annd0ihP7HHSBoBNQUUh2VGiw7tpGe4QfV008xC2V8c=;
	b=t5YFdliHWVL7HVM9NRJgV3pBzyRgbwfPZtovT+iAxMLrCozl6yBD/2G8aZTvlNdkPrIMUO
	/L0trny0nvtyy7Bw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Waiman Long <llong@redhat.com>
Cc: linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH] locking/mutex: Redo __mutex_init()
Message-ID: <20251105135425.RJoTs_-A@linutronix.de>
References: <20251104140023.jV9j77ld@linutronix.de>
 <4207482b-fc63-4db7-ab98-36b31a600173@redhat.com>
 <20251105075729.SJ4cL1rz@linutronix.de>
 <10899bd0-09ca-4fcf-8142-3d5cd6e4fedf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <10899bd0-09ca-4fcf-8142-3d5cd6e4fedf@redhat.com>

On 2025-11-05 08:49:05 [-0500], Waiman Long wrote:
> > If you want __mutex_init() for the generic, regardless, we would first
> > need to make room and then something like mutex_init_lockdep() could be
> > the public interface replacing __mutex_init() in its current function.
> 
> Ah, I don't realize that there are users of __mutex_init() outside of the
> locking subsystem. In this case, we have to maintain the semantics of
> __mutex_init() to avoid affecting other subsystems.

Well, we could update them to mutex_init() +
lockdep_set_class_and_name(). Except probably for rust. But still if we
like _generic, we like _generic ;)

> Thanks for the clarification.
> 
> Cheers,
> Longman

Sebastian

