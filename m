Return-Path: <linux-kernel+bounces-874490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D405EC16720
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3794D4F0FD0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752E334B1A7;
	Tue, 28 Oct 2025 18:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LFWahYbG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a7i45+r0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F93F345CD6
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 18:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761675657; cv=none; b=gam2YK9A1YmWy92pRbihmlLrgp3INEFGr/M/48Z1VKVGKX0E8BBZLq1tAj3ZSQIqJQxr7y4cONUtK6jUaLpEBfdfHzFvgVCaq5brwLZVSJjca9lbf4MY6/kqoxiDPuwWkhjbtLG+lkgYfP2jy//k2wxBpuaIug5aeTPIFcRS3iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761675657; c=relaxed/simple;
	bh=oBT6KOoEoYz1LUZZyQiGr2v4dR0JIvwu42klUVecReI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jo68qhZWA5hUaCv3AJv81nxl1wvVNvhoUrjt4YxF+IcqwfQcO5gWQZZe8c02f7ujquvxQ0IeC58+5J/Hq89bZywuLLwgiKQVcB0dgqlehXqh5kLL1WooOojl/ZEaghYY1itGdVt5jU6zjYeQBAMWuc1EbcnLv4mVbhlxfBxMA70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LFWahYbG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a7i45+r0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 28 Oct 2025 19:20:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761675654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oBT6KOoEoYz1LUZZyQiGr2v4dR0JIvwu42klUVecReI=;
	b=LFWahYbGsUhyLZdoEXlErWVLrIB/T+rhvYb3KhhJdW/Gx+MgUNnIVITZlgXSmdCzYf4vLj
	YZILP2CWGI1WeNg7r9ASfPqDwsSoZ1BiWlnNwwVOMtz5jpObcDgRjOoLNUsZjRd0pZsWek
	oq408P1Reb8Tjxi10L6m0o4d462a9JOqT3weK6U/4P5bsicLkgtyu8B7ruEVzzwPOaNIad
	4hKcjybKwF8RinsMfsORJgDgSS3kbqk+HX3f4AB4bKB5iyr0zckVbOTXuURQLzc/JwSivF
	oMp49co9aRTFY8l14qCUAFFrm+HC42yUDF1CdhzROaSNz1XTJSK/xpns1wx9GQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761675654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oBT6KOoEoYz1LUZZyQiGr2v4dR0JIvwu42klUVecReI=;
	b=a7i45+r0qPK7te/RWB1jXuoYdegtH43cD4xjuDQQoV3NJmcBgP/+oSY2A3GG6deDow5qet
	tpB76aEDovNOwEAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Xie Yuanbin <xieyuanbin1@huawei.com>
Cc: rmk+kernel@armlinux.org.uk, linux@armlinux.org.uk, rppt@kernel.org,
	vbabka@suse.cz, pfalcato@suse.de, brauner@kernel.org,
	lorenzo.stoakes@oracle.com, kuninori.morimoto.gx@renesas.com,
	tony@atomide.com, arnd@arndb.de, akpm@linux-foundation.org,
	punitagrawal@gmail.com, rjw@rjwysocki.net, marc.zyngier@arm.com,
	will@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, liaohua4@huawei.com,
	lilinjie8@huawei.com
Subject: Re: [PATCH v2 RESEND 1/2] ARM: spectre-v2: Fix potential missing
 mitigations
Message-ID: <20251028182052.nrRad87D@linutronix.de>
References: <20251016121622.8957-1-xieyuanbin1@huawei.com>
 <20251028162005.bLKC89Hy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20251028162005.bLKC89Hy@linutronix.de>

On 2025-10-28 17:20:06 [+0100], To Xie Yuanbin wrote:
> On 2025-10-16 20:16:21 [+0800], Xie Yuanbin wrote:
> > Over the past six years, there have been continuous reports of this bug:
> =E2=80=A6
> > 2019.3.19 https://lore.kernel.org/all/20190319203239.gl46fxnfz6gzeeic@l=
inutronix.de/
> >=20
> > To fix it, we must check whether mitigation are needed before enabling
> > interrupt(with PREEMPT) or before calling mm_read_lock()(without PREEMP=
T).
> >=20
> > Fixes: f5fe12b1eaee ("ARM: spectre-v2: harden user aborts in kernel spa=
ce")
>=20
> Hmm.
> I was moving things back in 2019 but things shifted and this is no
> longer required. If I apply both patches (of yours) then it sends a
> signal with disabled interrupts which breaks my PREEMPT_RT case.

Now I got my things together.
LPAE enables interrupts early in do_page_fault(), therefore accessing a
kernel address from userland triggers the warning in
harden_branch_predictor() before sending the signal.

!LPAE does do_bad_area() -> __do_user_fault() and does not trigger the
warning in harden_branch_predictor() because the interrupts are off.=20
On PREEMPT_RT this leads to an error due to accessing spinlock_t from
force_sig_fault() with disabled interrupts. Therefore I did enable
interrupts early and would need end up with the same warning as in the
LPAE case.

Now Russell wants to keep interrupts/ preemption disabled for the
address > TASK_SIZE for the entire page fault path to so that
harden_branch_predictor() works properly.

If we need that, then it won't work with the preempt-disable suggestion
I had=E2=80=A6 We don't send SIGKILL because userland might want emulate pa=
ging
for the kernel regions. Okay.

I guess the requirement is to invoke harden_branch_predictor() on the
same CPU that triggered the page_fault, right? Couldn't we then move
harden_branch_predictor() a little bit earlier, invoke it in the >=3D
TASK_SIZE case and then enable interrupts if they were enabled?

That would make me happy ;)

Sebastian

