Return-Path: <linux-kernel+bounces-800746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 493D8B43B7E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0204D188E903
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DD92EB865;
	Thu,  4 Sep 2025 12:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E4GnCT/t";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EcZcEeGF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC0C2D663E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 12:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756988783; cv=none; b=MYoJ2E/9MiZ19flCH1LRJxeHbOL3xdKh85ylER55RZ6OwRf5i7bqJbg0ZJ1nbpzKKb124oPccdl/sKFbxspdqlWM6zICX9QOouPlHJ1o8wWhhdpqtL6tTGTqSJL8BXHdRHhL6/p3IVFS7+0sHPhtvcqrCt41Oy08NqCrBoYfk/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756988783; c=relaxed/simple;
	bh=zNllfNBoARBDljqfRXqVOGETW/y6HHQqyqnSQy7Jbfw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WA6uCzBqHEJlbLpVlj3OSFc8xw3kZQHY49fLvDQoJtJuXabiBQ0wuvDSDDe5iirA9HITiRNyLPVFP85APeyz/ftwJKWre5d5PLKpQHHE0tQibxZdm7xybgnlTY64mDLVv4/Q1/kgz2d9V670su9M09vKKBekWoATDbpp4bAG+1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E4GnCT/t; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EcZcEeGF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756988779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GT+4xzFad7vxuZsNfgdp6OupSbkDwbYzbg44k6lM+Bc=;
	b=E4GnCT/tbEbroAbdX6FLaiAQQnym7AbYHtv5ym+KljkJY9G7oBy1SqsW90DM71aJpgw2Qb
	dbD9PD4jOWLVP/ujtGCDKG1Rlj8HXdWpnxKSf3kS6jhmP+x0pT6vFSZi52cYlLvUkkT56V
	OzFqHAW/IWGszvZt4bAZKJojQvgwjM+/DY4fNnAX2Yo0gKlr/YC1+ezFEO0pQnOyI2ZlRX
	itj5Hqg22JbksYUzyAIc/8LvAEQVFTpg9At4x4RemtHID2gMW4M2LFgrlSwlgxii+oqVji
	9rTdDnbBDDBlOOSvvZAyoh6Pbvw+HXvCBviVI8O02QHLjCODGZnabHTRjtFpGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756988779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GT+4xzFad7vxuZsNfgdp6OupSbkDwbYzbg44k6lM+Bc=;
	b=EcZcEeGFgxbB1QZuEJobGTaJnfwTFR4BlZz18edUsz2EJCsKclPMVb7b/P/wA1Z4M9mLsO
	hzLTyCpLPTNwVAAQ==
To: Sean Christopherson <seanjc@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra
 <peterz@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>, Boqun
 Feng <boqun.feng@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Wei Liu
 <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [patch V2 36/37] rseq: Switch to TIF_RSEQ if supported
In-Reply-To: <aLllFObsXWOtaVVI@google.com>
References: <20250823161326.635281786@linutronix.de>
 <20250823161655.586695263@linutronix.de> <aKzBQRKuEmrNtCiB@google.com>
 <877byh2k13.ffs@tglx> <aLllFObsXWOtaVVI@google.com>
Date: Thu, 04 Sep 2025 14:26:18 +0200
Message-ID: <87ikhyxv2t.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Sep 04 2025 at 03:08, Sean Christopherson wrote:
> On Tue, Sep 02, 2025, Thomas Gleixner wrote:
>> I'm happy to add a comment which explains that.
>
> And maybe a BUILD_BUG_ON() to assert that TIF_RSEQ != TIF_NOTIFY_RESUME?  My main
> interest is documenting why the generic implementation doesn't need to re-raise
> TIF_NOTIFY_RESUME.  E.g. something like this?

Done.

