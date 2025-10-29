Return-Path: <linux-kernel+bounces-875282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83198C1897B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D4A73B5DF7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EDF30BB90;
	Wed, 29 Oct 2025 07:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kjaq/1pT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+Yxr1RWt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF9A2D738E
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761721875; cv=none; b=lifgOu5yzyahTi0+3xmDkKvksH+A/lLXGq+xu3SLyCKxZepoikWcjivaWdy+EKATlacPCTDROtF+EnxThShkA1qUyraggiYvhDrCHze8w+deKaclmkT6nS9XJk7ZBPDlgv64CnoB//J1B1tgda+Eqt5XkGrV/cP/Acrnhqc49UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761721875; c=relaxed/simple;
	bh=5WUaEXVTe+Hn1OD9+LZFfmRm1CGCx/UI7ZOF4HLm91A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAeHSL7W8eUXoguz0iiZ2vMHDJN4atLfQVrIQREjjS4bjKMt9AhuouV5vibRUxt1QQMWDB9DVKLg0NIXqT8bpb9yZ5+qEmPuNNvHzBJ91qCeSElbn+vPMajz7l9kjVURQM4oYnyfTn8M9VRr1kzzBC78xTBMkXFzT1mdyKGWwFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kjaq/1pT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+Yxr1RWt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 08:11:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761721871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZYU1yO04Vl6gQUd+zVeWV299Sxti2R9KNXPToDb1EC0=;
	b=kjaq/1pT+5TEp1kbFkbDEgi1feSbH4Tv7i3gf32qkAM8/6LMPatatORoJIk5Rsce0RPDLv
	hg5EEBxXoV4qlE1o18gu/IoqXjXFMysgBVidsRWu52Flz4HyxaHSV05p0rvn0FxfMSwovR
	xBAst4yUAoD8VwlhVPJQ30E9sXoVUNmgH31uhO1Up+GZASBO0VRZ7MwekeIW2w6Ta5uuUF
	nn7C4bwhsL7JmXfl45oHSj3GdJWFeiuCMVfwFn51rG7obPHmhjux37JjxzFBg3OGAJ4a1+
	fh/V+ooVutCmV138b0F4jwmFOpwLylbCdbeDAsAdtdWAweeadwgbpKrgGdBGNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761721871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZYU1yO04Vl6gQUd+zVeWV299Sxti2R9KNXPToDb1EC0=;
	b=+Yxr1RWtc2zdAJXy4Hgexznn4Y82izDHEk6m30ZX92y9TlJ2RJIgkN1WEfTZ8dDfQ7g3Xm
	UkTv69J2pzUmuTDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Xie Yuanbin <xieyuanbin1@huawei.com>
Cc: akpm@linux-foundation.org, arnd@arndb.de, brauner@kernel.org,
	kuninori.morimoto.gx@renesas.com, liaohua4@huawei.com,
	lilinjie8@huawei.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
	lorenzo.stoakes@oracle.com, marc.zyngier@arm.com, pfalcato@suse.de,
	punitagrawal@gmail.com, rjw@rjwysocki.net,
	rmk+kernel@armlinux.org.uk, rppt@kernel.org, tony@atomide.com,
	vbabka@suse.cz, will@kernel.org
Subject: Re: [PATCH v2 RESEND 1/2] ARM: spectre-v2: Fix potential missing
 mitigations
Message-ID: <20251029071109.Hj1fO_B-@linutronix.de>
References: <20251028182052.nrRad87D@linutronix.de>
 <20251029024151.6005-1-xieyuanbin1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251029024151.6005-1-xieyuanbin1@huawei.com>

On 2025-10-29 10:41:51 [+0800], Xie Yuanbin wrote:
> On Tue, 28 Oct 2025 17:20:05 +0100, Sebastian Andrzej Siewior wrote:
> > If I apply both patches (of yours) then it sends a
> > signal with disabled interrupts which breaks my PREEMPT_RT case.
> 
> I am not familiar with PREEMPT_RT yet and do not know that signals cannot
> be sent with disabled interrupts and PREEMPT_RT=y.
> I apologize for this.

no worries.

> On Tue, 28 Oct 2025 19:20:52 +0100, Sebastian Andrzej Siewior wrote:
> > !LPAE does do_bad_area() -> __do_user_fault() and does not trigger the
> > warning in harden_branch_predictor() because the interrupts are off.
> > On PREEMPT_RT this leads to an error due to accessing spinlock_t from
> > force_sig_fault() with disabled interrupts.
> 
> This seems to be a more serious bug, and may require another patch to
> fix it. Not only !LPAE is affected, but LAPE=y is also affected:
> do_translation_fault() -> do_bad_area() -> __do_user_fault()
> This code path seems very easy to trigger.

correct.

> > I guess the requirement is to invoke harden_branch_predictor() on the
> > same CPU that triggered the page_fault, right? Couldn't we then move
> > harden_branch_predictor() a little bit earlier, invoke it in the >=
> > TASK_SIZE case and then enable interrupts if they were enabled?
> >
> > That would make me happy ;)
> 
> This seems to only fix the warning in harden_branch_predictor, but cannot
> fix the issue of sending signals with disabled interrupts mentioned above.
> 
> What about adding:

I was planning to just move it up. Let me try to form something in a
bit.

> Xie Yuanbin

Sebastian

