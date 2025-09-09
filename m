Return-Path: <linux-kernel+bounces-808064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFEEB4ACBC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58F195E145B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0B63277B4;
	Tue,  9 Sep 2025 11:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kYBpEEOf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nXUn4eM8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DDC322DC7
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 11:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757418389; cv=none; b=nRY2/EkmVPp76NlPRX9l9fejpL6axf+aCMXmKXxrPlVUA1kLNhxrtd2uIoNkjtLfde95YXw9v27Jw24D/pArH6APfubLpJQ4HEkJklUnUri1vmTg/6Q1lQpj5MbzfVkTaaikgOPFSAvvO/Dvl/Q9WOr6CHLr1O7Ca5C5gQK6Wnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757418389; c=relaxed/simple;
	bh=g7dJd5YxHfknkDgdWrZzEt35OYW/qA6NbSR5v5L03nU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bEMTqDTcE+gpkMoavgWslCJzbmKaTGqMPlenGJvhYe6XwBTx93MSMnTJ4P7SqyVAPzgMnp+z4/zgls7DIe55oPp6kXNVUpowmWhP40vbHm5eMqFufAwUINAxe5xQSBDyqOHv1b3vOh2gIymSk4Clqw+eEIXcIphUy3O601O3Hi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kYBpEEOf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nXUn4eM8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757418382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JF4vRX1sxHuWaDPXPxOxjfczfJj4nlUyfiiwX0RUXWA=;
	b=kYBpEEOfT4woGw4diqJMYYe4YYNW8aL016tE0fhJ/10qD1nUN7Gs0nOfUa+mxspW9gDU3X
	htoUXbDMFS19yTyo3Vs9PwIBCOQNuDvoxG9NEwmxTcMF4UHnaw4yzHnQDRZGA0qp+uCGyS
	HuX0NV6CLvgyhAhwwGhL5j2+UHeRQJSPoCDB2I3fGCECWjwfkSBKeV+qYA2spHaAJIVIXj
	FI1R15NQsmNnPAfYIwpc4j561NQuKjoSleIkTX26MLLlnGtAdntwsS/9IPMiblFJ6qlfYJ
	KVh9D1NOyr+ZUtWWRfND9t65geoCRkRnKX3/h3YTMw5EueTsc4FJElPad6xURw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757418382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JF4vRX1sxHuWaDPXPxOxjfczfJj4nlUyfiiwX0RUXWA=;
	b=nXUn4eM8HamPNniMugsfSJi+Tn3msVjbBe0cCvtns6E2GmocnU6LE5/psaQ3022KG/QtXQ
	lW03hT2KaBl+9nDg==
To: Haofeng Li <920484857@qq.com>, John Stultz <jstultz@google.com>
Cc: linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, Haofeng
 Li <13266079573@163.com>, Haofeng Li <lihaofeng@kylinos.cn>
Subject: Re: [PATCH] timekeeping: Move debug sleep time accounting outside
 spinlock
In-Reply-To: <tencent_6FBD7FB2B5EDA57B1481766C52482D033008@qq.com>
References: <tencent_6FBD7FB2B5EDA57B1481766C52482D033008@qq.com>
Date: Tue, 09 Sep 2025 13:46:21 +0200
Message-ID: <871pofx302.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Sep 09 2025 at 18:23, Haofeng Li wrote:
> From: Haofeng Li <lihaofeng@kylinos.cn>
>
> The function tk_debug_account_sleep_time() was called inside a spinlock
> in __timekeeping_inject_sleeptime(), which could lead to potential
> deadlocks, particularly when CONFIG_DEBUG_PM_SLEEP is enabled.

How so exactly?

I don't see how that would deadlock, but I might miss something. So
please explain it properly instead of handwaving about it.

Thanks,

        tglx

