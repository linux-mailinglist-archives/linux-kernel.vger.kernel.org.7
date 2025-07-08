Return-Path: <linux-kernel+bounces-721117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8BDAFC4F2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCB37427F08
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9C529B776;
	Tue,  8 Jul 2025 08:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2ojlPqqJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kugaM1tO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B3510A1F
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 08:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751961753; cv=none; b=SBYrzBzN8TYFSD49vfQAY2u1Xpp2iCd1QLQ9sNH2/ltIHgPyiNE6DxhxgoWUCIgw2OsqSH1WAqkQVHYw6rLJq/keJt42ffuscKJw0VeeSQmSbUfgJWe6udDmBbxcMnofXA5Wukq+yWZ2FJNP4Aear0bG3J9ay8rcNVwKo//y+Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751961753; c=relaxed/simple;
	bh=6b3Zx3N2YsRk3AnAcT0RtZk/t6XqZxbjGfJ9x31RaF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVVdIbcENerZ6/+P17rUD12c53BTT8SqVa0siJbo3TNwoFwkM4mwlyq3tmpNbQpOfGEKbQBm8a5mYXUfcJXB2yRtmtACulmRTP739ng7Ms4+rRYe0uagGCZEmfYJtaZdKFplN7OVje/tEeE015bnWAXGWkALk6sy0ZQfQqRJKzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2ojlPqqJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kugaM1tO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 8 Jul 2025 10:02:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751961750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6b3Zx3N2YsRk3AnAcT0RtZk/t6XqZxbjGfJ9x31RaF4=;
	b=2ojlPqqJQaw3hjSV4u3YmmTrnVY9BaFfXrmJFvtwH0V/qHGXJrcOq+Z74idoAle5vtV70f
	w4KRSi/5x/rJjBiXpAXuA298ljT4Hnx/MMntYNTsFNBFPVi299r4LaulzvhbkJKRr9eBDM
	XpCp95T5Vp8p3kNJw+lvCwPT/fAmkYEw3JG8QOkCir1yL7cy6o/mHb+xkvn380EmNusHOs
	PdnYpnfGtPAgwR/y8gjPd5zBBA2toM5KlRy54ofUbSCsQLBPp+Njc3TPVdf7D3GMKgKLiI
	UXQShKTtfuzj8d/zQgSKIpscJ4Tx8N3QzixDmVYP94qIQENYSQIyS5hqAvGrIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751961750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6b3Zx3N2YsRk3AnAcT0RtZk/t6XqZxbjGfJ9x31RaF4=;
	b=kugaM1tOqquIiY2r+XWZEWZwf7GFaCcljDs1JM6e86RY6MqwN0CCPs/A3u2OIG8PMIYXqQ
	DT8DZGp5dXzC9NAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 0/3] futex: Use RCU-based per-CPU reference counting
Message-ID: <20250708080229.goCjGgBH@linutronix.de>
References: <20250707143623.70325-1-bigeasy@linutronix.de>
 <20250708075025.GF1613376@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250708075025.GF1613376@noisy.programming.kicks-ass.net>

On 2025-07-08 09:50:25 [+0200], Peter Zijlstra wrote:
> On Mon, Jul 07, 2025 at 04:36:20PM +0200, Sebastian Andrzej Siewior wrote:
> > Since it was not yet released, should we rip out the IMMUTABLE bits and
> > just stick with GET/SET slots?
>=20
> I suppose that makes sense. If someone ever comes up with another
> use-case for it we can always add it back in.

I add a follow-up patch to rip it out and update the docs.
_One_ time we have the docs in time and then=E2=80=A6

Sebastian

