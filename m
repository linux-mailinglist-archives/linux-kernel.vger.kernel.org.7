Return-Path: <linux-kernel+bounces-793180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC676B3CFDC
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 00:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 836F17C2824
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 22:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26A2259CA3;
	Sat, 30 Aug 2025 22:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UVPtAGIb"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA071863E
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 22:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756592771; cv=none; b=ihJDHNaLqkqaf2ldZMHxa3B5BdpTXJjhRzaz0brb32rT2Mvvv3vG97ITWJmPWUE/6dN5SYe11udq81btV7kfL05MlAvb8TZ0to3NYRUeQ37MMplKhY//5xB8HUjnpLx+uuITIqC/8trAdMkgJgvrhFBo5Cp+nlskLfeX6QK5l+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756592771; c=relaxed/simple;
	bh=+cznMWbhze59dSzIb94h1PXt0j0iLOaF8f2CY8dhMII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYjX8V5hSJcEMBvxybsx6M7ete3Yz+MJksuJgTgJgawwClpvHMKT/CKGtKRFft/rR9OTu0dLSG+0uFkyd5vFig6M2D/NlaVP680VB1feXd4PBwpD+1nbuoZdmJyD/fE+hKxRFOFsQ/tZLsECx8jFQkXtbalwFmCDDTzLoR0n64I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UVPtAGIb; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1856840E016C;
	Sat, 30 Aug 2025 22:26:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id FcyThMKzddel; Sat, 30 Aug 2025 22:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756592759; bh=3hH1zbeaU5RbFICZqDb/Vt1u8p8wn0WrHQ01ReL6kbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UVPtAGIbPsGEXry2u7hcoucuhTadp7r+Y0Scv83vij2/JaD7FrzbniWuqYt1ywVoo
	 fqn4O/9Yf2Ekw5FCMXjHfjcthYCVz7WZU3nBRslVcyaOSCyhIZLuebZKvLxX3aAD+l
	 wuAPP19PDs9SSZVyuXypVYjyDdE92fbB0AxMkcryWSzb/O/JaYAp7wGizirI+dLv4k
	 r+9ITsiwctw3HJ7rQs82Zn7Kihf5YPt/vB4eycUAx/tkiX3DztXSMQFarrzWp+YzAm
	 7UBw0oVATWn1iIQ7aP/e5PaNsyYaAVgbMM+6fpSws/gfp8YChBNR0I2aPpH9WI/S0j
	 TRsa/NuqepqkhKo7ajo6gw6igfLl5rCrKqgHPZ6SZIywf/GyFxZ/s2tYtcz8s6n2tf
	 umgvcKeJQ5olx0a8OF2IJLDBnUZHxPZt6xlDV/eViv+xAiT3PHWU6+/vm3UTaNMsIT
	 31JQrV445qftiZSDkoh3CuMRXDb62vsN6y40h3eQHB/LzetoTCJgxHPFW2dTn315Sg
	 z5k/OGlib1j5Yrx2GehnY9umqqLKhZw7qatHUWc48o7+oVBmeiT3S4f1QhbGLQolhw
	 9jDz+lWLPK+i4JnkqtrduTqOtQ5zCyjwXzBZVaTSn1fy5SKBRktdwCzOE+Ez9IwWsq
	 deT3Xh1FXeVkFbWgeMejCElM=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 230C840E0140;
	Sat, 30 Aug 2025 22:25:51 +0000 (UTC)
Date: Sun, 31 Aug 2025 00:25:45 +0200
From: Borislav Petkov <bp@alien8.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] futex: Initialize mm_struct::futex_ref on mm_init()
Message-ID: <20250830222545.GAaLN6aeQzWHYc20BF@fat_crate.local>
References: <20250830213806.sEKuuGSm@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250830213806.sEKuuGSm@linutronix.de>

On Sat, Aug 30, 2025 at 11:38:06PM +0200, Sebastian Andrzej Siewior wrote:
> mm_struct::futex_ref needs to be set to NULL during mm_init() to ensure
> that it is not copied during fork(). Reusing the previous pointer can
> lead to use-after-free which can trigger
> 
> | WARNING: kernel/futex/core.c:1604 at futex_ref_rcu+0xe1/0xf0, CPU#2: swapper/2/0
> 
> Initialize mm_struct::futex_ref on mm_init().
> 
> Fixes: 1b708b38414d3 ("futex: Move futex_hash_free() back to __mmput()")

So this one is queued in locking/urgent and I guess I can fold this new one into
it so that that commit is whole and fixed.

And then leave it in that branch for one more week for some more testing...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

