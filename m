Return-Path: <linux-kernel+bounces-782106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B55E4B31B2B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97F411BA2173
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADBF306D2B;
	Fri, 22 Aug 2025 14:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2u/LSTZM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PlE961fM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677802FF17D
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 14:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872219; cv=none; b=XWXrBC9+Q7MNz2+MmPVbnzOF9CJ6lNA7p8kkMmDfEOKVlNqHtmpr8xJE64usM03NLwOHCaiUjWnQUx6FFo1fSHfwER3jCMOX+tlIamGyLMbyUWlT4YmnkVanfYCU0l55pZ2dOJmWpojgV6P9uQ3HifURZFNtrVOejC1z0f4XosY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872219; c=relaxed/simple;
	bh=DHEF/sRtEUfVZJrky/fG0g6fwC0YpUpOvdDoRBnU+Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0DlGuBxGb6gxlwAvdEEd+kZeQ3AuPpmFF3q4uOiJIXu60OigLefEK8tq244189eDxk7wnhKG2/g/dsBv1i2GLUZuod4GEsnNAC2m1llW1zSFlFn9opt+orH5Ec9dt6qQYgZes269HHyskXxrr9y7zfU2LLhun0zZm18ADt+FIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2u/LSTZM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PlE961fM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 22 Aug 2025 16:16:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755872215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6qGPbFm6ev3FCh05T0AkxuGsgsnsJn4OeQyYmrseSXA=;
	b=2u/LSTZMjHbIT6aqK25yCTh5PO8YuoqK69duoqvhMzafxm4hSS1i2lKXDKwfVvdcBDuX3e
	r4bu5K0NMBJCS4ET7n8akpZiKel/16aKccBX6JbPFdUGudumsrO/3TmEZ5IFfGx8+Qj85N
	VJPdPTAXSPHU72bBynub/mWh3+kO1ElTKdzdqXMz5IpWINhdWWIZHeEpC96DqWPX6gb5qb
	g0cYdmYCLaZz5scetYu2cAM2lmhxj6bHaAaQ8XIh9IuC9q7XQUoX3c384NSlqSpByqw7XB
	0Rz2Ra6DtY7tI+K2j2Nlh+1YjTLaEFp9v1lCoOHPSMGZMY0oPnLx4R6Y/EpeWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755872215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6qGPbFm6ev3FCh05T0AkxuGsgsnsJn4OeQyYmrseSXA=;
	b=PlE961fMfFnaxi8inWU+/n24foRjQm9V8RMEpv1T721h8/nwmX7BX3BYY3DXCyO+C7XlQC
	sQQv11G4lFXMtiAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Sean Christopherson <seanjc@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>, x86-ml <x86@kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] locking/urgent for v6.17-rc1
Message-ID: <20250822141654.Sjoffo8F@linutronix.de>
References: <20250809180207.GAaJeNHymvt6gaR5nY@fat_crate.local>
 <CAHk-=wi+X2A6K839AxrRvaCDCakya-2B68NTkYP5YGfi-h5EuQ@mail.gmail.com>
 <aKd3cNJqj6_g_ATE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aKd3cNJqj6_g_ATE@google.com>

On 2025-08-21 12:45:52 [-0700], Sean Christopherson wrote:
> Piggybacking the futex private hashing attention, the new fanciness is causing
> crashes in my testing.  The crashes are 100% reproducible, but my reproducer is
> simply running a variety of tests in parallel, i.e. isn't very debug-friendly,
> and the code itself is black magic to me, so all I've done is bisect.
> 
> I reported the issue on the original thread, but haven't seen any follow-up.
> 
> https://lore.kernel.org/all/aJ_vEP2EHj6l0xRT@google.com

I somehow missed it. Can you try rc2 with the patch I just sent? 

Sebastian

