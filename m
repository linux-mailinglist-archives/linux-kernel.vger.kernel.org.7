Return-Path: <linux-kernel+bounces-820196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4382B7E91D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75B4A1BC8810
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 08:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBED305E01;
	Wed, 17 Sep 2025 08:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="phryVV42";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pgY3va0K"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2443D303A27
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758096285; cv=none; b=NxNZg7d6DgEsxDT953TXfpaTItgLaoYUTe1LLQqJsVVtLfeWHl7MI6VpAk6+/IDzfRRAq1WaK4ehvFi7AnZt87F0CaGQ0zxljRIAQR9N7B5lLaqky+HVDJ3JsqbE1ixVKK3HovL4AM3BpDb+m8vDl1GM9RaHFCx1pNvprVVIETE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758096285; c=relaxed/simple;
	bh=konjTvPypzFucVLDYC5mnEcgUPFyOEdeHqQYGVd/HAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BqD4V0cBLNiy0ARPlyxTGaIK2wtAALGBR6YhwICRqkuGUt5mn4WDKj2+xA4rgLeW826ubs1phcFQ5as/jXv44uO5FyznvJbxiMLQYE4zlO4usGkOKNs+JEnUVzFDmU8qZ6dwm3TDtBgvQTVyKt65T+xICxj+iT89OmQcIBWQEGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=phryVV42; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pgY3va0K; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Sep 2025 10:04:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758096276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lvayRVsTXb1GHZyI/5B0A9TO76BVx4lkIJl2VHNdOYA=;
	b=phryVV42XPPBOnEB5AgeGedpdyXTEOTRbuqjvPM+i4HKPXMPjVq3PYRW06wbzm7GqOa3jb
	choKkddmBsn7zjMQg3kdh5C7+oSigMqM03Nlyp9PVZ3u1aeeyXnRACmROdsW4Z3OX/iteE
	8cVMSk5LZAZDWjG+6VQyCOKQTmiZ46t6bm8vC/GcnXGNok3Up/PODRoSA643Lm5agDWoHs
	fyR76OzG/lNV+78ksFarwfksstlOxpSxMiQr2VRwntqvwjVgDSMOr68cZoiuI/azk6HCmo
	247Jvi1q/n5EJdLRE30y21/KyoyYKrsr73rvarYH5eNoXcTvcBtm5e5tfHdFdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758096276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lvayRVsTXb1GHZyI/5B0A9TO76BVx4lkIJl2VHNdOYA=;
	b=pgY3va0Kb5jQ6Moc093JH0heX4NyrRUsAIYKsUbNZbffR65bOi/vMEBiIZSJV2oNYEMIui
	Gtjrxrwxu/kVA/Cw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Andr?? Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2 0/3] selftest/futex: Collected mpol fixes
Message-ID: <20250917080435.m16PMr4t@linutronix.de>
References: <20250915212630.965328-1-bigeasy@linutronix.de>
 <20250916183502.GA2800598@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250916183502.GA2800598@noisy.programming.kicks-ass.net>

On 2025-09-16 20:35:02 [+0200], Peter Zijlstra wrote:
> 
> Queued these for tip/locking/futex, if they were intended for another
> branch, please holler.

no all good. Thank you.

> Thanks!

Sebastian

