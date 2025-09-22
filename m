Return-Path: <linux-kernel+bounces-827303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1406BB9163B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6CEB17E54A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8001308F3D;
	Mon, 22 Sep 2025 13:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AiCNUyFK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PDEJaJp1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2110B1A2C11
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758547639; cv=none; b=JCfksMnSB0NNVLlMQhGjt5vwj/CcBkUJ4OVv+ZdX48iPGFptkrtzyr0udnEPKivljmgCQA3sID1PzB0aSfgOtCkIVTXja4Y6Def/hvFip6uDWmKwscQCkgE0kOaqla6w0ua+T+vOlpXzbPMVm1YmVIzmCPXvHEPmM+bIi8eNOMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758547639; c=relaxed/simple;
	bh=hLR/SjpkPXbadrVNeuR49fC1NpoB85qsjhbzr+tCXTs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i3K8eXUKehne3PSyXY4ZGc2r6RRPV6Ji24DrwBfqToRzr9FbdxwJ4Rik4IZhP1VWIv0ciPX//TeuPnYWGa2lXRiyhBoiYQOqQGL3UR8nhVagIezZYIaLdKrqcp6VrEBl0guqpGj/dTXGTJW8xh0OPrUcHiXLpi0y2QARVBzepMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AiCNUyFK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PDEJaJp1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758547632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OHjq8/naxj9wOATVKaAS3Sl7b6cZ2oEkLh8gYUB7OZo=;
	b=AiCNUyFKMHHXueG3TBNI3CfcXYN85ycsuNU2f642S3rtN09wsij+j9FaWwnWHoRWORSYIz
	BJrZiiZg6u/2fqALi5Ml85wetmICGf9zF26ir4LUNhm62/jJDGwkK4vWtuySZ5PGdRJSQn
	a9tCk5+ixbMQG+7zW50aG7Rd3Gxtyf1gVorb74c03e0z/PKS11AXYrv3Wla7EgbcCn6H2I
	AuIYbt7qrkXbBrc2nbElFpfMT9Y/tB8/8d0bZF458AzRxzCNKfSOx/WJTw4EwUxWM7eg27
	ykKsOTR1myheB6+wNowkfaDYzikT25qvpHQMegE/KWY1jAdqg57hqFqPRLgyLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758547632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OHjq8/naxj9wOATVKaAS3Sl7b6cZ2oEkLh8gYUB7OZo=;
	b=PDEJaJp1KPKU5MgTULlys7QaOp46wlgZEXKLXl4DpVdzLm4BaDXGyMteo8tCTub/Z0bzaR
	FASUU1yG1Vy35mCA==
To: Andrew Murray <amurray@thegoodpenguin.co.uk>, Petr Mladek
 <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] printk: Use console_flush_one_record for legacy
 printer kthread
In-Reply-To: <CALqELGz4ug+YyBvdmPp5aHR3x4qUEp4u4cCpWLL5143VCrf3-w@mail.gmail.com>
References: <20250915-printk_legacy_thread_console_lock-v1-0-f34d42a9bcb3@thegoodpenguin.co.uk>
 <20250915-printk_legacy_thread_console_lock-v1-2-f34d42a9bcb3@thegoodpenguin.co.uk>
 <aMwy7pFM7EExLxaX@pathway.suse.cz>
 <CALqELGz4ug+YyBvdmPp5aHR3x4qUEp4u4cCpWLL5143VCrf3-w@mail.gmail.com>
Date: Mon, 22 Sep 2025 15:33:12 +0206
Message-ID: <845xdak47j.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-09-19, Andrew Murray <amurray@thegoodpenguin.co.uk> wrote:
>> I played with the code and came up with:
>>
>> static int legacy_kthread_func(void *unused)
>> {
>>         bool any_progress;
>>
>> wait_for_event:
>>         wait_event_interruptible(legacy_wait, legacy_kthread_should_wakeup());
>>
>>         do {
>>                 bool any_usable;
>>                 bool handover;
>>                 u64 next_seq;
>>
>>                 if (kthread_should_stop())
>>                         return 0;
>
> This changes the behaviour from the existing legacy_kthread_func. Thus
> allowing the thread to exit mid way through printing remaining
> records, whereas previously the whole set of unprinted records would
> first be printed. But that's probably a good thing.

It does not matter. kthread_should_stop() will only return true from
printk_kthreads_check_locked() when @have_legacy_console and
@have_boot_console are both false. That means that whatever legacy or
boot consoles there were, they are now unregistered, and were already
flushed from within their unregister_console_locked().

John

