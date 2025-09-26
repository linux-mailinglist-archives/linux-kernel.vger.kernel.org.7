Return-Path: <linux-kernel+bounces-834222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C02ABA4374
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD4D87413C3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D4517C91;
	Fri, 26 Sep 2025 14:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mpP3FFQs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="88ta3RhW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE8D1CD2C
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758897057; cv=none; b=j3SLFse4CE3p+VY1BLw81WZX0MydXb+t3awTr21Guag73xb+ApreASURFRdOe423vBcogjY2FEUWUxThxaiI6WWY3hqx9RjdPP6Bys9Sc37yQ/gRbrmDmXn6cB8kNFmX4FKsnkGe6iM5vuUPUUgqbDcnasUoDELAncoYElKD9CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758897057; c=relaxed/simple;
	bh=pgVdzlMsm2HmNSxY2mm4KhjHI/hY3FaSKDzCM7Qwmg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Payv6K6v/AtH9OTXOZ3dUBjxrGg7Ros/Qszy6v3GzHDMpyWYWrJ7OEdfdE6BvsxU9WFxSar5ccm+A6AUg2e7F16o/wCHOfeBHa1FCbUWnbGCiFqrrWLljMIKz2GvyQR5wob4pBEYid9gWk3KIbztY6Sn86a6I8jULUpkY2De6JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mpP3FFQs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=88ta3RhW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 26 Sep 2025 16:30:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758897054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jS3g5y5kTwpzWvYTKSfteuHNN8u6xwodKaPs5Ub7JOU=;
	b=mpP3FFQs8uloea4cHBcZx7hBWL1VjheXn08f4t7ih8Q5sb1l4Lll/cUQRPpp761qCF/fRa
	HpMVqUJ52qVLW/mwOPAM4BgPggn2WXQrBvln51TwiNYiYqO7+bnwlXiM9KU4y8JuUxal0I
	b02m+2qPfz4XW21nNfHtoXc6ZOZG3IVYxBq6uDT92c8HIMCwEQpVj8d36UKa8fjrtg2DCf
	YbVYx3i1HDxPPDebrHnxC5aWLkPe3a0DD6Dvnqk1rNeRiam57+bdBVUhRmTnYVbIEwos2e
	lZC5iCtasmv1y+Pc+lvZuupDEe/Cai1sgF/4ube418snEf6f+vtVjrmtLRWR4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758897054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jS3g5y5kTwpzWvYTKSfteuHNN8u6xwodKaPs5Ub7JOU=;
	b=88ta3RhW8OF1Fb6mROckX39PIB4tqepFjygn5rJ0BMfQqAkq0QmfwPUUQtfg/ZA81hPasx
	iTqxQeMFBYM4NrDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] locking/local_lock: s/l/__l/ and s/tl/__tl/ to reduce
 risk of shadowing
Message-ID: <20250926143053.Kk3jOwSw@linutronix.de>
References: <20250925-local_lock_internal_fix_shadow-v2-1-d3b85ee775a4@kernel.org>
 <6c49739d-6f2a-4c49-a04b-9774f10a6925@suse.cz>
 <20250926142032.3vMasceT@linutronix.de>
 <70968d59-c7e1-4f9b-8e94-d6a66464e848@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <70968d59-c7e1-4f9b-8e94-d6a66464e848@suse.cz>

On 2025-09-26 16:29:33 [+0200], Vlastimil Babka wrote:
> On 9/26/25 16:20, Sebastian Andrzej Siewior wrote:
> > On 2025-09-26 16:16:56 [+0200], Vlastimil Babka wrote:
> >> +CC LOCKING PRIMITIVES maintainers. Looks like local_lock files were never
> >> added to the section, should we?
> > Yes, indeed. Would you be so kind or do you prefer me doing it?
> 
> I'd prefer you as the author of it, but can do if you're too busy.
Sure thing, will do.

Sebastian

