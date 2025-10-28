Return-Path: <linux-kernel+bounces-874223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF7BC15CD7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81EA9427643
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE15E3446C5;
	Tue, 28 Oct 2025 16:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SxROkCon";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bTXt80oc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D91B341ACB
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761668412; cv=none; b=KuwZjP4Z/5xTjdBaJ49YwAUqctTE4CCaPs0yKfZ/xWTw8wem3iQaldJ5fK3Joiaja/x3KbLs9SwrlVn+Hp+IkOSIjUIa2fG7mypWserTsKxR/jA8dL+qVLUj+KIDqU6yEPb8KuBepM2dHSs0ipOLbeWuU+Lemj7Dvbx74nK+uzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761668412; c=relaxed/simple;
	bh=Z8h7AOYDZruOfs1ULNgBL4IWEkyKGXKFfNiYjMrc4/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYkmYUYtoMEpzmW5eg1LRM1yikCGFgW0J0qYajq8wKMr85vmKtw95b+56hPmk6q+K/r75aDsC1IzLa861FgFXVKzaftl7KwhArAB3l5QsEz/cbJ4ok84ausO722LpVv5a/DDUSh1DFG0HAlLY4mdxjA/jiXc5a0WhJFMhAQtAsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SxROkCon; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bTXt80oc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 28 Oct 2025 17:20:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761668406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z8h7AOYDZruOfs1ULNgBL4IWEkyKGXKFfNiYjMrc4/w=;
	b=SxROkConP9XTvM+6UcqbFbfFG78aNUyTCpFVZinZ32QvxMYSxBC5LskEG2FnZhmB/zl2Ph
	6QIvsGmmQH2N9iSipXZUB/rydS2bACJTNJCFOszHgHlmtL6lBMpHJNkY6whsmYS5MUHuUM
	ei7tzNQRFSlFeEYxJPUrWJZamyVRsFvqViR40WMHth9pdBToyqT4LhWkeGQdwKKKuL4MMb
	cRHOxiIeG9Mt27/lOZkmSahM2MwK0mswqTFbix6gIpC0K7Oym4x4ze63/hLAd2ZjePoLcz
	onvd7YFDjFCTnHw+zXhMuG51XRRg2jy8BqUr09el2clKKHCXuDYFZ5amG2uEbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761668406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z8h7AOYDZruOfs1ULNgBL4IWEkyKGXKFfNiYjMrc4/w=;
	b=bTXt80ocon1BwX7ceW+7vM2bt6Yale++XWnLf8HNGx9JwanQ8xpWYveiV6MHyI4RC/Alt3
	mwczZncsVxqlBgCw==
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
Message-ID: <20251028162005.bLKC89Hy@linutronix.de>
References: <20251016121622.8957-1-xieyuanbin1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20251016121622.8957-1-xieyuanbin1@huawei.com>

On 2025-10-16 20:16:21 [+0800], Xie Yuanbin wrote:
> Over the past six years, there have been continuous reports of this bug:
=E2=80=A6
> 2019.3.19 https://lore.kernel.org/all/20190319203239.gl46fxnfz6gzeeic@lin=
utronix.de/
>=20
> To fix it, we must check whether mitigation are needed before enabling
> interrupt(with PREEMPT) or before calling mm_read_lock()(without PREEMPT).
>=20
> Fixes: f5fe12b1eaee ("ARM: spectre-v2: harden user aborts in kernel space=
")

Hmm.
I was moving things back in 2019 but things shifted and this is no
longer required. If I apply both patches (of yours) then it sends a
signal with disabled interrupts which breaks my PREEMPT_RT case.

The requirement is to invoke the mitigation callback of the right CPU.
What about disabling preemption before getting the callback and doing
the invocation?

Sebastian

