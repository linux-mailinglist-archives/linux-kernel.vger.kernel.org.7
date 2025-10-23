Return-Path: <linux-kernel+bounces-867311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6B9C0238C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7C283A2D43
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C23222587;
	Thu, 23 Oct 2025 15:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DAJnv+2O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j7vXJwTr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EC521FF4D
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 15:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761234373; cv=none; b=UFoRnKx+k8eu9YefCm4uLquQ93wSijtRUj9iBz732Cmc/Xw1wZkcb1E/h2N3ZyUMeHPx9hkrKQebNWBupu8serZi/wCGU+f+D7BNX0VZoNkkkTeP0AGXNWt54xdSLzHEcDtkgRHv3XZ1F0177cibH/9U6ROmT9aNgEbipRdCB6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761234373; c=relaxed/simple;
	bh=4RS49+lW1obmZeqEhAFrgEwYXyMDeyk6cpqEJDmXwGw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E58F6vQH1Ijv3l2SJEzQctsSVZMddp91gfy329/9sUGFPL1bwBUMvxiYkgehtleTmMqq7y12cFEBb+OjIxRHtr4BmdOvR+/1yKzn+C0SKC2Vq8ilq4xsRaMXGYStlUCNiK60UHRoRP1brmCyFJU7hUwK1qrt5V5nxCtss+YL02I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DAJnv+2O; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j7vXJwTr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761234369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4RS49+lW1obmZeqEhAFrgEwYXyMDeyk6cpqEJDmXwGw=;
	b=DAJnv+2OGn7s2K1YH2czcdQOkt+1QqhCtKXQZjCLAQZN+IdqRT5SaWEOuYviS/xukQ+e8M
	Ff7YZbz11MnzS2BOZ+GEfixSyl9a44vrySAAYgiDYzaV/+PRYwldL6uUfDBMXRmBfWuovw
	qiFEx/NnteD+tf1ui+31/BpdoZfT0z+4yUeJQ+4HYGkU2eOrMa8yQv9+lSTJ+mZM57V7pG
	4hBFY+td+6cVT74QcyJePeVkb2vLGHz2d7QlMCpuoyTHcc4TVcyE/XLVOMmk6jmPWU4Pga
	T2eqOhloV6Lq/P/xjvJuz0JxigJrJOTmj8dPV9d3fw8MHuWX12F7NdTyvTjxXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761234369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4RS49+lW1obmZeqEhAFrgEwYXyMDeyk6cpqEJDmXwGw=;
	b=j7vXJwTrzJhspp+Lq0GLkMAQg5st5yVK1P4sD8QlMQ44lqobOi9LpZd+Bxr0fw3k6mox1I
	/fbC04IoIJWrFFCA==
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Oleg Nesterov <oleg@redhat.com>, Petr Mladek <pmladek@suse.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] printk_legacy_map: use LD_WAIT_CONFIG instead of
 LD_WAIT_SLEEP
In-Reply-To: <20251023151112.goqBFQcM@linutronix.de>
References: <20251022154115.GA22400@redhat.com>
 <20251023103234.GA27415@redhat.com>
 <20251023142655.FvZkeSa-@linutronix.de>
 <87wm4lbqt2.fsf@jogness.linutronix.de>
 <20251023151112.goqBFQcM@linutronix.de>
Date: Thu, 23 Oct 2025 17:52:09 +0206
Message-ID: <87tszpbozi.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-10-23, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
>> With PREEMPT_RT, legacy console printing is forced into its own
>> dedicated kthread. At runtime this is checked via
>> force_legacy_kthread(). So with PREEMPT_RT there is no need for special
>> lockdep trickery. Once we can get all the consoles switched over to
>> nbcon, !PREEMPT_RT will also not need this lockdep trickery.
>
> This does not matter. My point is that there no need for this ifdefery.
> You say: This might get the nesting wrong but it is fine because the
> outer lock should be this. This does not hurt if it is also applied on
> RT. _BUT_ on RT you don't even trigger this path so this ifdef is not
> needed.

I am more concerned if we implement a bug and the outer lock is _not_
what it should be and RT _does_ call this path. IMHO avoiding
lockdep-forcing when it is not needed is more important than avoiding
the trivial PREEMPT_RT ifdefery. But I will not fight it.

John

