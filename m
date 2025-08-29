Return-Path: <linux-kernel+bounces-791202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32706B3B35C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73C9F1C82A19
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 06:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6793B23A9AE;
	Fri, 29 Aug 2025 06:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m0hyNnjw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vn597Arz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C04B652
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 06:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756448832; cv=none; b=WAoCsiuHCBZh2EWs/JLUi/tMbOuU/JzCM42h912ZYVFBUEMF43TQvMVVkmtFvrXRTaAi/pSdWZTXIYqUgRTHeQGQoc8YMGzUxnE4JEu/y9BkR/AduZug5f8SugC7duMYoAbfR2jmR1CosIrnPaBRqZNSjWLO7V8n2DmjvNRdoa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756448832; c=relaxed/simple;
	bh=nUSjXe/JwlZOjU5RswlEFrfDxed+1IsMWi7G6hVRfEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWw3o77AcXsoIA+LJGJTsGdrxfdxA1fwJGBOkkcLWiKZ2dP5uEgFGQqspk6cws1eI5PnboEF1CaGW1E0fgbj4lgFdkxBBHnoreOR3XrlOMdzqEbrCEoy1YXVeNgv5x2LJCwc38v2+c3cCu1W22Uu+xv4LsszH4q/UPo0zPzrfDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m0hyNnjw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vn597Arz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 29 Aug 2025 08:27:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756448829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dGAMPKdAeRU40ghY4JJXkIE5IehO11JZoU2EnEKiHow=;
	b=m0hyNnjwhXsr2UTtn8pQ8q/HVHagMxJC1jQ8b2ff+GzhgEsjVWuLC9Xz0p7lfu2SY8U4Sw
	D9/mup5ReCWvij8/B0hx+Z84BqjYlpcqwS76yLAuKehdpQzgpi6MD+6pU7eEOJQpNU0xF8
	cOc5bePyfDHBQmCXwrDlJo2IdrypNFmjLk+AROZFxUu3qyFqFmmzhJsen/0Fyy2pwgwgZ7
	ADjJtZfwap73KzAdkfPsLl9KnzeDfzVnFom2bUH5ZUfAcQArpMjmNoLJ86rKvjFjN5PLkf
	KVHyXVQXEA8U3LUs8BLt1sE4LI2DmSi+0p/Sa4+HyuK4lO9kQUDhQNH/zjI9Dg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756448829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dGAMPKdAeRU40ghY4JJXkIE5IehO11JZoU2EnEKiHow=;
	b=vn597ArzZoFsyTDEowkztv3h4jb1wuyUAuUHhsBb1tCcUdg5SaadR/28Hv4CBcawFn8FD/
	R1BMosPZuAid/iBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>, kernel-dev@igalia.com
Subject: Re: [PATCH 2/5] selftests/futex: Fix some futex_numa_mpol subtests
Message-ID: <20250829062707.84iR4Gf0@linutronix.de>
References: <20250827130011.677600-1-bigeasy@linutronix.de>
 <20250827130011.677600-3-bigeasy@linutronix.de>
 <1e3d6a6c-7c99-417b-bc5f-3ab509b1a2f6@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1e3d6a6c-7c99-417b-bc5f-3ab509b1a2f6@igalia.com>

On 2025-08-27 12:40:26 [-0300], Andr=C3=A9 Almeida wrote:
> As we discussed  in the original patch thread[1], I have a proposal for t=
his
> test case to be refactored instead of being removed. I will send a patch =
for
> this in a bit.

As per=20
  https://lore.kernel.org/all/c61e7737-bfc7-4de8-962e-652aa3dbfd40@igalia.c=
om/

Andr=C3=A9 does not object getting in the -rc cycle. I would prefer this now
and the rework for the merge window.
If you prefer to wait for it and delay it until the next -rc release, be
my guest.

Sebastian

