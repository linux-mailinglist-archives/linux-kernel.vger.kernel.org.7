Return-Path: <linux-kernel+bounces-655129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA86ABD13E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 09:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 319FC1BA1A50
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 07:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345FC25E81D;
	Tue, 20 May 2025 07:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="olWP9vbg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ebenGUcc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E015E23BD0E;
	Tue, 20 May 2025 07:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747727951; cv=none; b=oYt3jfc+zc6IOxATZf/RFV3xF7nUE0RbtqOS39RFFn7i6WJ9A9M8Y1GiwOloKyKUCf92MyrjowsBy2aZ2V/Nk93GQOueIdC+c/zhZ2PNllPxRITVaAEKykdYyhT7Hc6QmtSgKTuP1VTjlLj+DrxuR2MpWZM5PmBR6MXM2Ck9jC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747727951; c=relaxed/simple;
	bh=jYrYqaKl21++6skX4iYnX944r1VNKDYn1WmEWfB+E74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aX9a02QX2bbiBUNpUQjuHPt+4h6FppGQLEC6fUDx2/QfVdQjPkukTHd/ct23qmZfLuEZp6fKpB1isGaH1n4DUFOIo/p/XS4rfzmY2aYedaq0zEJQjKpuUpM7cbhjhgzqaqrACil+F345y13L9C0XmjjTS8X6usDbgxEI4db/nwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=olWP9vbg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ebenGUcc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 20 May 2025 09:59:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747727947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mUv/8Bn/22WNgI1YYTIXWnAwhT3qoMvfxwXeAeLU0vk=;
	b=olWP9vbgp81/ORXemHVdPQUcFcD3rtRNdNAU8FZOialNAdRszZ9+XJXOQNTKVWuZ/LmQkE
	JPRLb0t/yThNQiHcbnLWL9wqFq68PMIWhWcZvl1TnkhNyyOVLv1w7r8xYxRKLZQ87n0sEH
	EaAR4Pg+3mjM0mzW9vLI1Tv/IXM1cVp1juw5dwgthm4nbRt+e4HeWH0b/k5rT25/cmzPMv
	Ph8s6hvLAHOwxyODodwd8fA45JDkFvRN3Ip7XJM/egI14HeQZ/0BVsyE3yglv8kMxJNCtm
	m7mGH2Z4C0EbngYB71xsMNQAxkgdfHwQ2Avc2a6ne4Kx67cICqV2wFNVBtrPIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747727947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mUv/8Bn/22WNgI1YYTIXWnAwhT3qoMvfxwXeAeLU0vk=;
	b=ebenGUccGjakKX9mH3jy6uy12iiR2rjE1ea4xNkbx6Q1hpnlAGv6cwljHrwAqUBLL5qSo0
	LbegxoJoUCSqVlCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for May 16 (futex kernel-doc)
Message-ID: <20250520075906.dGs8ZI_F@linutronix.de>
References: <20250516202417.31b13d13@canb.auug.org.au>
 <7b32e541-16c9-4691-8545-e124337cc25e@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7b32e541-16c9-4691-8545-e124337cc25e@infradead.org>

On 2025-05-19 14:02:57 [-0700], Randy Dunlap wrote:
> 
> 
> On 5/16/25 3:24 AM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20250515:
> > 
> 
> $ make htmldocs
> 
> WARNING: ../kernel/futex/futex.h:207 struct member 'drop_hb_ref' not described in 'futex_q'
> b04b8f3032aae (Sebastian Andrzej Siewior)

I see this warning as of next-20250516.
I don't see it in tip/master which will be pulled into the next -next
tree.

Sebastian

