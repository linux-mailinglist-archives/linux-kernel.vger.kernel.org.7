Return-Path: <linux-kernel+bounces-797365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2A1B40F75
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 23:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFCC45E57AB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 21:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95FB35CED5;
	Tue,  2 Sep 2025 21:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zv6yiOdu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4OFLyBKp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614C835AAB2
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 21:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756848727; cv=none; b=pOLk8njhPbrO6+Z7NBgzxRZ6I0HD36wwimNcXQaTs5Be8pMBrpe+IWD1Rerq0FUnIbDvKdOhox6/y9UG6khL48r64kZEOtas5pDhHWFvRiVxxHPtfLc97hv5HRlrQVgGBqL8uUGy8Y6UTD/Wmd+yvjpW6Be41rhjO+BiI4Bmsx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756848727; c=relaxed/simple;
	bh=vunqQJ5oeuYGzfWXmT8HUR2VoyfQuEfTY9jja4+u48s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Se91exjjR4EoIW3bFuWdTn48j28VeBOApxF+uEeWazMkO5idZmXQQtXoK6kuhOjYPBPc4fvnhH8XHWi4gTciP2AGzbydZDePW1UpBvrTMX5bbbZ+b6sJO+XZWotvc8q7NS0O73NN/Q2mLuloHTYnT6tqYs8FA7zpzzf4xbQBLfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zv6yiOdu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4OFLyBKp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756848722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VLFZuz30dpa79lpxVcrr60HQRnKxDWtLmNqx3vgx7b8=;
	b=Zv6yiOduGnjJ0WqWe1gJI2sWO+xJHM+9mryM69iWW/x9MXGRG/dmEb5UMxHnC0JqY7VHbE
	KHHbicPwJ7Jq+GBYMNhx1UG9Nui11BSuiZYMotWMCO6Lf3HZDuAb3aBdE65zUQ/pqYp8Gh
	p5TEv1Fmq1cT3aK0QLqnBbeyOAoU5IJaYX31xSxyDjM58hA+mAkC2cQPhJCnd+yXyQLYT9
	5Md5GZD+H8oGJp7oKWW2osJh9jxuBb0x9qh+a48CX6e5jplWDwb0iw3YR8rHXKmxb5wJN/
	4vhdlNw4TVY3QM6qFT4PM8krLwBR5BBbvCNBPeco85AWY4MqK+XjyZ8kYkdUsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756848722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VLFZuz30dpa79lpxVcrr60HQRnKxDWtLmNqx3vgx7b8=;
	b=4OFLyBKpb+jH1AHqeowtFzp2dzv/hj3blRLlcme50Ikav16eZnJDUc4Tv0o2ZpyVNoJoLl
	aEJEG+qy8oSMuzCA==
To: Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
Cc: Llillian@star-ark.net, agordeev@linux.ibm.com,
 akpm@linux-foundation.org, alexander.shishkin@linux.intel.com,
 anna-maria@linutronix.de, bigeasy@linutronix.de, catalin.marinas@arm.com,
 chenhuacai@kernel.org, francesco@valla.it, frederic@kernel.org,
 guoweikang.kernel@gmail.com, jstultz@google.com, kpsingh@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 mark.rutland@arm.com, maz@kernel.org, mingo@kernel.org, pmladek@suse.com,
 rrangel@chromium.org, sboyd@kernel.org, urezki@gmail.com, v-singh1@ti.com,
 will@kernel.org, peterz@infradead.org, elver@google.com,
 namcao@linutronix.de
Subject: Re: [RFC PATCH] time: introduce BOOT_TIME_TRACKER and minimal boot
 timestamp
In-Reply-To: <20250902133920.973210-1-kaiwan.billimoria@gmail.com>
References: <871pp14pkr.ffs@tglx>
 <20250902133920.973210-1-kaiwan.billimoria@gmail.com>
Date: Tue, 02 Sep 2025 23:32:01 +0200
Message-ID: <87frd4zgku.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Sep 02 2025 at 19:09, Kaiwan N. Billimoria wrote:
> Subject: Re: [RFC PATCH] time: introduce BOOT_TIME_TRACKER and minimal boot timestamp
>> Under the assumption that nothing on the way resets the counter.
> Ah. Is there any known component - within ROM/BL stages/kernel code - that does
> this?

How should I know? I'm not playing with this boot timing muck and yes,
some hardware counters can be reset by software...

> Forgive my asking, but if fine, will this (above-mentioned) patch be taken? So,
> knowing that, we can proceed forward..

Just send a patch with a proper justification and we take from there.

Thanks,

        tglx

