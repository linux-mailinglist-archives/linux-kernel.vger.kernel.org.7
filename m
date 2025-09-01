Return-Path: <linux-kernel+bounces-793894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CA1B3D9CB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38C611899FD7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 06:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4520E257827;
	Mon,  1 Sep 2025 06:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mHjWz8P3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d/y5bJr1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E80255F22
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 06:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756707693; cv=none; b=iQoOBd/rb13+eul79v8azaqxmNx5LAZOs2o6SqJU6HCOAdHxqRG4OQ/2KldEMK1EuXFB2HE9HVc8GQNQBkz/L3J8xy8WnuI5j2/bxMg8Fka5yw1MEZ+RgVw2YOth5IYeu37aJPMDXLDYM4sxeO12jAcaBTnefsqyLyFZMeDFYsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756707693; c=relaxed/simple;
	bh=uZIi+57KRtos/zaLAJCBCwJGMUNQ9sikOE940JvovW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9+SO0o3TrC7PLIyWD6JKoI8P0oRFMQwBIyHkAJaM1HL4kPyuiHSuBtk9AL0xGOVK38K6lnvNBU0+zw2b/Qn232f10rmdwjgkmFTMLEexznjK3eqq75Wl354t42mtdHupALtSKFqca3cuGFkvgLYPhibnbRb0Ivl2ZkAFTk2vnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mHjWz8P3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d/y5bJr1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 1 Sep 2025 08:21:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756707683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/U46GoTONUgv/fPv+v+slNHV+2p+IsUXgaen/D1YCh0=;
	b=mHjWz8P3EEx90cK0/I7ICShQ1/3VEaiZgcYgQkgooUJfePldSnAgBWR7/zm1QnecvN0/sD
	h+45EcxD7a2u87aoPUHbd86GDvW8Rd5VQ4FXVlui4+0QvdsyQCQIc/kW7Jw3+nLyBJamhU
	yTcl03EAa77qcySyRk7bIsWNe0UiO4tkvAzv5rr8STw5cVT9DUVQt16orkh4uXT+Pmuz0a
	DkJSdqs8mK7zPFEI+Ya3FkhZSY1NzI/pClpztIn4PwnfwTbwvyrE7oquFG2IocIBpNfbpZ
	L25ZoyA0pSK+sSSnGsyu41c8TSVrm5sa7MqCe2de+sm5vAKzfexDGxIGgfS+hA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756707683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/U46GoTONUgv/fPv+v+slNHV+2p+IsUXgaen/D1YCh0=;
	b=d/y5bJr1ZZhzG7udMDS/i/Kk2h8avTGdiKXbq7uPnEaD0/7oz5QlrtfqN7IWL3DEX34eWK
	AqZvqOLSM94KGoDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] futex: Initialize mm_struct::futex_ref on mm_init()
Message-ID: <20250901062121.4FbeY5D1@linutronix.de>
References: <20250830213806.sEKuuGSm@linutronix.de>
 <20250830222545.GAaLN6aeQzWHYc20BF@fat_crate.local>
 <20250831122145.GBaLQ-WUUgrhyFCwxN@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250831122145.GBaLQ-WUUgrhyFCwxN@fat_crate.local>

On 2025-08-31 14:21:45 [+0200], Borislav Petkov wrote:
> On Sun, Aug 31, 2025 at 12:25:45AM +0200, Borislav Petkov wrote:
> > And then leave it in that branch for one more week for some more testing...
> 
> Ok, boots on one of my machines, fix folded in and force-pushed.

Thank you.

> Thx.

Sebastian

