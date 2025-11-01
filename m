Return-Path: <linux-kernel+bounces-881522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E347AC2865C
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 20:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B4C5188C12B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 19:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FD51A316E;
	Sat,  1 Nov 2025 19:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bbbWt7yN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QmU9q+eg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCD734D3B4
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 19:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762025438; cv=none; b=JbIGOtbCAyoP+HyA71+FjUKOs3bA8tfyuJ3QsyB1frZOg/KfmOQAoQ1NkWI+Tc2c6CNGtusr8w6Jg2OfneIFoDYKgB9jOSjDj2TJ1z0OwsV50IHi+VNLx5G64ig6FHzMJmpEWvj8YqrrpIl8MAD4/L0hd1N8sMWMIatQoWc4TAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762025438; c=relaxed/simple;
	bh=PBj+w8OHJZ0dGDago/B9NNgTGdqHJ9frgrZyeblhUaA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZAJ2ZR44wMxZZDYmk5N0zRYjb1p0wfxoPcgVFo52XYR8NAFM32JzmavrWctkokgqjbxGNsg68usI4EyKgddJ5m3vCMX6wMRij0hCr69vAxw8ovmfJKpwnIQK4VX2j2A8keWfUx4/DqyXH0EFJCV9mT0UBHDeI4Yz5KSOCjm7UVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bbbWt7yN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QmU9q+eg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762025435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9TWDH+czvTr3cRznPeivTCS6/zRoWHetvj0QVyKMLPs=;
	b=bbbWt7yNqPRJUX4xq/3FIbngCzQjH2P1v5uXd9uuofez5Q7ayyCx+y413Wy5huBgU9+dnn
	7qjB+PvJL6dVatXHlIAubFKHlfPUXumIedFgUnuGFVudHo37M4EfDK8u1oUWbC219D1VhF
	Ko9y0vtZYwvc9J5SmoTxYxYdxOxI4GpOrcfekYXujT34w1cMkiR5RaGoz7ZKlq5A0PslhL
	Jjwll/cIFpBAMps+c1X+mzixlYK4fUoGdFqn0enjBOvPSVyV9hx7K6bvteQlpbaUzVbHhS
	z1bFx3ppVhRliPHZdS1YcqZhob6f/aGpvpK4gU+SCAv1a/DYicMC8eYTsiiJEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762025435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9TWDH+czvTr3cRznPeivTCS6/zRoWHetvj0QVyKMLPs=;
	b=QmU9q+eg4QaxaZBtCuGptKJ96zRIxBeNloHGPOpzAHShGTPivvVVC7Ztao2aXD1qVX+1SU
	85/MiAnsIJ9TemDQ==
To: Marcelo Tosatti <mtosatti@redhat.com>, Frederic Weisbecker
 <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/idle: disable tick in idle=poll idle entry
In-Reply-To: <aQJWWIDMMUxqDxnR@tpad>
References: <aQJWWIDMMUxqDxnR@tpad>
Date: Sat, 01 Nov 2025 20:30:34 +0100
Message-ID: <87bjlly2hx.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Oct 29 2025 at 15:00, Marcelo Tosatti wrote:
> Commit a5183862e76fdc25f36b39c2489b816a5c66e2e5 
> ("tick/nohz: Conditionally restart tick on idle exit") allows
> a nohz_full CPU to enter idle and return from it with the 
> scheduler tick disabled (since the tick might be undesired noise).
>
> The idle=poll case still unconditionally restarts the tick when entering
> idle.
>
> To reduce the noise for that case as well, stop the tick when entering
> idle, for the idle=poll case.
>
> Change tick_nohz_full_kick_cpu to set NEED_RESCHED bit, to handle the
> case where a new timer is added from an interrupt. This breaks out of
> cpu_idle_poll and rearms the timer if necessary.
>
> ---

ERROR: Missing Signed-off-by: line by nominal patch author 'Marcelo Tosatti <mtosatti@redhat.com>'

You've not started doing kernel development three days ago, right?


