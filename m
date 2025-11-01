Return-Path: <linux-kernel+bounces-881574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 751E6C287A6
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 20:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFA8B1A217EE
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 19:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFB73019B7;
	Sat,  1 Nov 2025 19:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rCckHSPe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vVoHIb8k"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3641E25C818
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 19:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762026904; cv=none; b=tmXXtDEj4UoAHCobkem+1YKIXheh7eipU2eqI9P5Y1q+WByTABAOR/818QdQqBdd7RGgu0YGqDBi+UVGtE4775Y4mClgq1If8pZrK6fHpInbSX6N83UAnRYUd7AMIXN5HW5ZzuododoKEWzyJLehVqTrtSMepTHxZQfPA+u720Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762026904; c=relaxed/simple;
	bh=ZU624fxeXebH9L+eS3Byfu8GEP0GK5fxcUyjurW8Yt8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gTiKn6E3IWlMIBJ/ZkN7DF7Sa6YGdFpbBPCevWH3UvYwkUD/LwMhpH26N9SjfOsC0IOFg9aPmu3pM3dOhIkut9wIH7hYB0HV/KPVdKASIhG0MfZO8vPZMa9a8TQ/TjvMl7ctnULLGdAJb7E+BCmuZH/jrc8zi3JAUIBx3TuIrEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rCckHSPe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vVoHIb8k; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762026901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=amlOK1nam7uM91A/cwLqqUczbT1l3VKp6CtsbfutauE=;
	b=rCckHSPehqvrsNJbhdOVxQn9q5vwTmg77rNaa54f/FnF++rzU9aGHj9uOjZvZYui2zinXO
	sZx/LhLwGWSrM1OeTK7IsDqfPJPy+X1AYH/DPa9RA1VUcqZsA4aKejAVPj3wxVK4F9k7mh
	LHeEzxj61ZaFpc0RUesHMBFeDWDc/2N6zW/BwrXO9DB4fra2f8nyH3oAhMbHZSyof/8c1f
	18GXqEqkayFOOIrGGb2AkEHeUki36yuRc+5eLAJRh9i5/2B0DV2bd1t12qQOkYxcwPem1L
	6ow3SsC+y3kqbtWnSmeLpg65fPsHAiD31Mb0quFL6kJKn3Wea/qkt8BKO1gykg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762026901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=amlOK1nam7uM91A/cwLqqUczbT1l3VKp6CtsbfutauE=;
	b=vVoHIb8kYLcjp888dT5cmrd3rT1Ji3J060Fm+ypWPh6/m1FL8q+PdLBI1XgXjVvLbSbheo
	tlkGRIPHzBifFbDg==
To: Fushuai Wang <wangfushuai@baidu.com>, anna-maria@linutronix.de,
 frederic@kernel.org
Cc: linux-kernel@vger.kernel.org, Fushuai Wang <wangfushuai@baidu.com>
Subject: Re: [PATCH] timers/migration: Remove redundant ternary operator
In-Reply-To: <20251005073021.6810-1-wangfushuai@baidu.com>
References: <20251005073021.6810-1-wangfushuai@baidu.com>
Date: Sat, 01 Nov 2025 20:55:00 +0100
Message-ID: <878qgpy1d7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Oct 05 2025 at 15:30, Fushuai Wang wrote:

> The ternary operator is redundant here, so remove it.
>
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
> ---
>  kernel/time/timer_migration.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
> index c0c54dc5314c..b869b244025f 100644
> --- a/kernel/time/timer_migration.c
> +++ b/kernel/time/timer_migration.c
> @@ -751,7 +751,7 @@ bool tmigr_update_events(struct tmigr_group *group, struct tmigr_group *child,
>  		 * be scheduled. If the activate wins, the event is properly
>  		 * ignored.
>  		 */
> -		ignore = (nextexp == KTIME_MAX) ? true : false;
> +		ignore = (nextexp == KTIME_MAX);

The parentheses are pointless too, no?

