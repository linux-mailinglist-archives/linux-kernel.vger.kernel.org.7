Return-Path: <linux-kernel+bounces-619689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8211A9BFFA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 09:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22D5F1B60880
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 07:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF2022B8D2;
	Fri, 25 Apr 2025 07:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OHQmEMtZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sTI7viOe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96562701B6;
	Fri, 25 Apr 2025 07:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745567157; cv=none; b=T11wKzCbmrzsfiwigGfDMG3xXJ+UGtLFzRYSqn/K3NfypaSSt+xNZof3GP5DRVyDugpI48m4RKSK2zSm4G7tIi3p0OmKqiCdrnDnf/q26/xC6G2iJUAUfhviSK1Ggy6YGEWaT7zAGaoC71MbTC8tqZZxdocXRWWnihmoCyEUe7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745567157; c=relaxed/simple;
	bh=bpjbiBbYd2xlA2obJvJ3jRRn/TOOWWqT+YFzwj2cKqM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UpXPm35okKKE+BI1QPt+aMYye2Kz22TZTRfTJ7wQ2in9B2VaFxQXiLaIA8a7zWGB12j9AWNGPFIRQR2CCOobGBjy/NV+V81qdekEW8BBWUQlc27EUo2N97HGqYCsvZzVyOi/aBErt5jinPWjgJZBMnkp+wPiaA4GJ/0D4ar+LNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OHQmEMtZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sTI7viOe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745567148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cecrIr4xEjdih6jLdwsZgmRawZN6QblC3AkqgY9IU1M=;
	b=OHQmEMtZE/yVtqIJon44aQEVzFQuekD2KX0zZb3ydp5UHYkjhr5H2O8Czb807FBmK4WNJ0
	GdbTLDIlfN9lQkSXRUCHqoK2mVgxkntCTk4Wv5FXQwqzWT1EW8jxaOr8HBRF3hxznxDCUw
	tVcaG6yuYKC3GebNWvREVDQ0ynGNFQtWAschA47XR/OZXCEfa0TFJoAjXdJwAuvlHien7t
	l6Za+QIlPhWiFibcG+CPPxh4Us+0vqD6vpm3izFddRJz/A1dvd+JD3R3Ll3uNAjrKJpS8g
	AG6DZ9IBfg1Ye5eNWbXps/PegMx8RHPPHYBqc6Q0eT+Gcrn4esMzuM+RSOpZOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745567148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cecrIr4xEjdih6jLdwsZgmRawZN6QblC3AkqgY9IU1M=;
	b=sTI7viOeurL2zoHc/Pg0+S6q6rbBWdf0p6Sk5BXpqT4GetC+cU5Pml2IBtng9JXtD3IaQb
	HfdVvNBz4TuClCCg==
To: Nam Cao <namcao@linutronix.de>, Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 20/22] rv: Add rtapp_sleep monitor
In-Reply-To: <20250425063456.NBE35YHR@linutronix.de>
References: <cover.1745390829.git.namcao@linutronix.de>
 <c23cb5ef10310f978c3f90f07c2dbb9b042e8b01.1745390829.git.namcao@linutronix.de>
 <c321c7350ec10f9f358695acd765d2dbd067eeb2.camel@redhat.com>
 <20250425063456.NBE35YHR@linutronix.de>
Date: Fri, 25 Apr 2025 09:51:47 +0206
Message-ID: <84ecxgit04.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-04-25, Nam Cao <namcao@linutronix.de> wrote:
> On Thu, Apr 24, 2025 at 03:55:34PM +0200, Gabriele Monaco wrote:
>> I've been playing with these monitors, code-wise they look good.
>> I tested a bit and they seem to work without many surprises by doing
>> something as simple as:
>> 
>> perf stat -e rv:error_sleep stress-ng --cpu-sched 1 -t 10s
>>   -- shows several errors --
>
> This one is a monitor's bug.
>
> The monitor mistakenly sees the task getting woken up, *then* sees it going
> to sleep.
>
> This is due to trace_sched_switch() being called with a stale 'prev_state'.
> 'prev_state' is read at the beginning of __schedule(), but
> trace_sched_switch() is invoked a bit later. Therefore if task->__state is
> changed inbetween, 'prev_state' is not the value of task->__state.
>
> The monitor checks (prev_state & TASK_INTERRUPTIBLE) to determine if the
> task is going to sleep. This can be incorrect due to the race above. The
> monitor sees the task going to sleep, but actually it is just preempted.

If I understand this correctly, trace_sched_switch() is reporting
accurate state transition information, but by the time it is reported
that state may have already changed (in which case another
trace_sched_switch() occurs later).

So in this example, the task did go to sleep. Why do you think it was
preempted instead?

John Ogness

