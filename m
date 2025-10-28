Return-Path: <linux-kernel+bounces-874633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCE6C16BE1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 88936350330
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B50935029D;
	Tue, 28 Oct 2025 20:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dy60kxZh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4RqJzLaD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A7B23EA96
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 20:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761682439; cv=none; b=OPzP/LyctLBdcAb1GCzAwyJ2APQdhctyMXfDZ02ZV1mwnSiO4N5CqRp2MbhTEQadoJgI1I1Hn3Ul/mUnmb/TEopyyKNa2q3CImasbwS22L1SpRSnKokNjUyxV5P0h6qqskWQuo4Q68bkci9rJWL+BWKqbmn9o12Bun0q6WDj0og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761682439; c=relaxed/simple;
	bh=Oixx8EWSWQTq06cavMws4Pvsp62qi2MmNzuildh4xzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSZn64QjyMzrSXVrL9gRNYvxUEJX4v24bMVmEzjxdHXzeD79RtixDOa7yPNs9zl8wJNtvjMjB+UtC8mVxapUHuhkMAikEzJ2llXpmj2oEL58czPd7GRGb0fSCt/vYA9eZyE1R1MX367PpBJRTHs4O7qhTU4sUKDnMJ4RFKad8uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dy60kxZh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4RqJzLaD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 28 Oct 2025 21:13:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761682436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oixx8EWSWQTq06cavMws4Pvsp62qi2MmNzuildh4xzo=;
	b=dy60kxZhniGssSMo2E2uj67BKgl1P10QrChr46SvnZvO7RjiX/OyJXNkBARcVwwCyJJvez
	WnybMELM8aRxwPK1qZjHeYJCDMdj1ljjgW369J6B4LC7xtgqQfLf5AUv22QvZiX3Wocdip
	kY1rJn+Vjc3plBFx6hWNMnyBdqBbFfyPTBDb8Owiv+wH/9EBCeftm5ec8T8JE+HcN14XR0
	Dz8bCZH7nWbtTG8FUL0DugY7fNBFr5M5/SA/ulec2n4oJOf9btvE6+jKDi5wpVtXWylhy8
	PcDSfDXlyFk2G7j4CdwcyNMeziYUOpPl3YvPBy/JWUSR3Flh8q+73MU6WbcJCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761682436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oixx8EWSWQTq06cavMws4Pvsp62qi2MmNzuildh4xzo=;
	b=4RqJzLaD/HZzL9Oi9q4JouyvUZTJV3HW7yOG6YDRuZwyp1O4ioFRoix5mV5N3Inr7qgtwF
	uCd0LdQROxT0vLCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] perf/x86: Add cond_resched() when allocate/release DS
 buffers
Message-ID: <20251028201354.d25lZRRa@linutronix.de>
References: <20251027212724.1759322-1-namhyung@kernel.org>
 <20251028141518.GA4067720@noisy.programming.kicks-ass.net>
 <20251028152747.GR4068168@noisy.programming.kicks-ass.net>
 <aQETYiqpEo5IcTXN@google.com>
 <20251028190422.GE3419281@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251028190422.GE3419281@noisy.programming.kicks-ass.net>

On 2025-10-28 20:04:22 [+0100], Peter Zijlstra wrote:
> Well, we've been trying to get people to test things... But
> realistically people will only test once you force them. So we'll see.

| grep CONFIG_PREEMPT_LAZY /boot/config-6.16.12+deb14+1-amd64
| CONFIG_PREEMPT_LAZY=y

Debian has it enabled by default in current testing/ unstable distro.
\o/

Sebastian


