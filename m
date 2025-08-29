Return-Path: <linux-kernel+bounces-791189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A82EB3B323
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 243AE16EBE4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 06:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E880220686;
	Fri, 29 Aug 2025 06:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v2m3n9nm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PKSCyZ/K"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B75224891
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 06:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756448195; cv=none; b=txgV39JyaxQIw+7fOmT6vSs2Qv/iL8mrcHolFVTOs/N7IAqdoyEb+se0lyNO2gAjhseI/BobQ42HdfM8/lgTKi3zSmsz291o7GzDVgvR7o86wPvtkvxlZsu/QDZxjYBOjrwPRu9SXnV2+AKsrbHsec2etmVnR2dNQq9+TXs2O3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756448195; c=relaxed/simple;
	bh=cEA+yfQNaCChMMokVhI9gM1RYf4Slt0HnEjPf7v8xQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGMyRmJrTdY1QXGIwtvXLzG7i2ogfcA2kRm96BGJ29ZC8+IvJwOuy5q95VDYZ2Seb0JqxN53GTszUL9VNXzCqubm0+UKYe+rge7El7ylSnHbaxYkA3ioVm16MQhI3kbHz8aINYf+UJUgQV4nDtvAxpbAKv8rWymbjcExnOVdvps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v2m3n9nm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PKSCyZ/K; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 29 Aug 2025 08:16:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756448185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cEA+yfQNaCChMMokVhI9gM1RYf4Slt0HnEjPf7v8xQg=;
	b=v2m3n9nmkzWLorTjS14ZTGB1lrjlFypQi4xXsh262JK9BCGbWaWEhlldOeh2F4yzLQgHEa
	5sYQ6vGomot7cbm7+Pc9oBf3ELuJXFcuacRzMhNzgsp8OKyAln2NYc5Wlyp+LNJAiDDnWq
	jZCXh/6qw/QTL5b9qQ5jvREKY51pOCONBX2T0LLuZkT52eZ8tPCNCOYFwmRqf6nrE7JnlH
	MOYPkOwz2frVQFirKQLdLHXAjo1zEnnoSYbBtNxnowDQcT7z8oz2498+pePpptcJSByRJN
	ub/wM8PQYb1sLMF09+NI7PKfSjONLGo3R8lBNj0K96C0SYHjtfU43qQQUkm/jA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756448185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cEA+yfQNaCChMMokVhI9gM1RYf4Slt0HnEjPf7v8xQg=;
	b=PKSCyZ/Kt5gqo4rnl1vN3kMdm7QMPd4GF/Nx/xjq/vRQykyxBTDaIrrWWjApTP/2cN8oD8
	R5RvmN/7+AV3ZsAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>
Cc: Waiman Long <llong@redhat.com>, Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Borislav Petkov <bp@alien8.de>, kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/futex: Fix futex_numa_mpol's memory out of
 range subtest
Message-ID: <20250829061624.sC9Bavj9@linutronix.de>
References: <20250827154420.1292208-1-andrealmeid@igalia.com>
 <9d4c0d27-0ebd-4c6d-af38-d32ef420fde4@redhat.com>
 <61725722-f933-447c-a041-71b2d28e7f90@igalia.com>
 <20250828182037.qkdKVaTN@linutronix.de>
 <c61e7737-bfc7-4de8-962e-652aa3dbfd40@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c61e7737-bfc7-4de8-962e-652aa3dbfd40@igalia.com>

On 2025-08-28 23:22:03 [-0300], Andr=C3=A9 Almeida wrote:
> Em 28/08/2025 15:20, Sebastian Andrzej Siewior escreveu:
> > On 2025-08-28 15:06:26 [-0300], Andr=C3=A9 Almeida wrote:
> > > Thanks for the feedback! I will send a v2 addressing this by next wee=
k.
> >=20
> > Any objections for getting Waiman's fix in for now and your rework for
> > next merge window?
> >=20
>=20
> No objections merging Waiman fix first, but we are still in -rc3, so maybe
> there's time for the rework in this cycle?

On the regression list, we this one fallout in the testsuite. I would
like to get an easy fix for -rc4 and be done with it for this cycle.=20

Sebastian

