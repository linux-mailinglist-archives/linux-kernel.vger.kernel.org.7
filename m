Return-Path: <linux-kernel+bounces-850034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A313BD1AD0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B395B3A3FB5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 06:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409D92DE717;
	Mon, 13 Oct 2025 06:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="czIlbdGL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J7VZgV76"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB442DD60F
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 06:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760336885; cv=none; b=GIbHbuxLUfN4MN6lBJHhroDyNYQ8wZ+LZp1+V5j4r5JgAZ3RfEtMsAmStpdLT1foldMs6i/hAg6YRwf2leIGtlwTwAUXT7QlMPgza5W9eVfpStAW64aaUjSJfeC4af9+ubeFC5kUokwSvNui8P2zmuQTpK4K58fGjgJ3pqVVSqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760336885; c=relaxed/simple;
	bh=RxVn2GQXUIB4qbHlA2Cb2iDd9E2/HPk15jFxklapqb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQjtKoVI4M9uI5NyJWyqI9XeN+DZF0j7A5o8Atq1JS3b3RJoaB7B0XyF+YnQ37rXmngj2NhWRsr4mFbHoUaAsT/3wnbNzU3iaHP4EVpOksxypJxSA3an7aXLA2XMiZZjIEKimkH+m/4MM2tubQF4ZozgKxTtNdsNa24cewiiJBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=czIlbdGL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J7VZgV76; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 13 Oct 2025 08:27:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760336876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C+lWtQFv2S+aF9dYafZDwwatkx8KiFcCSvwTyPK3+vM=;
	b=czIlbdGLytDRKDs6vAw1zqCbwJNmJ7KQpCPt8XVR8wulBg4k96MFqm8Lt+Jaya3k6EMsK1
	uEPXyCP4ME0Ov3QUlD93hqxyRTK39SYQd5ag3rOHnRQ5e76fipBK+wfeYWIYq8UoSYb64j
	JXlieO4zvxkNab2qcrli8wYGIDeeSLQHdlnUAsi9gsWww2sL8mUCaChrI4eqM7qhyk2BUy
	2cFVq48vtzBiTZrc/pOzXjGAN8n4a1Zz9e4anSGgb292FTCXoz8psDLaTQJgdKLV9mYg19
	BHg1zPs14f3ApM7RI/60S8BetJ+1u740fQt2Zodz1KmxGFukrgx2mnCgKrQx8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760336876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C+lWtQFv2S+aF9dYafZDwwatkx8KiFcCSvwTyPK3+vM=;
	b=J7VZgV76qYt6owRDosLVULkFKlKlRzfR8GYsIaVHlsPn5foBNC0b7Cgk0M1btbaoK4gQLz
	QY3RW4+Mlc29vZBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ryo Takakura <ryotkkr98@gmail.com>
Cc: catalin.marinas@arm.com, will@kernel.org, clrkwllms@kernel.org,
	rostedt@goodmis.org, leitao@debian.org, mark.rutland@arm.com,
	ardb@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] arm64: use SOFTIRQ_ON_OWN_STACK for enabling softirq
 stack
Message-ID: <20251013062754.6GDxEVID@linutronix.de>
References: <20251013013508.74677-1-ryotkkr98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251013013508.74677-1-ryotkkr98@gmail.com>

On 2025-10-13 01:35:08 [+0000], Ryo Takakura wrote:
> For those architectures with HAVE_SOFTIRQ_ON_OWN_STACK use
> their dedicated softirq stack when !PREEMPT_RT. This condition
> is ensured by SOFTIRQ_ON_OWN_STACK.
> 
> Let arm64 use SOFTIRQ_ON_OWN_STACK as well to select its
> usage of the stack.
> 
> Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian

