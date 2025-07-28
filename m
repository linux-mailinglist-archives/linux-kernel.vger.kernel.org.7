Return-Path: <linux-kernel+bounces-748197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 818A2B13DC2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 16:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6220116C705
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 14:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAF126FA76;
	Mon, 28 Jul 2025 14:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YCTVcZWP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eMgCQQ/Q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32511586C8
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753714711; cv=none; b=ILtqd/QIfnd1aSos+Ex5tJPSZ6463GDzlOt9jUgoCUH2Ich7UlQBO8GcgORIpgs6GfswFm02d/AQpgelKnz0+NRHPXTFQgHbtbPoFKB2E+N3ksZyiVsYSkP9ghZXO0v+I4X7gSD1NCFY32Tv1IAZkpoMl/L48uyWah58d+XV3yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753714711; c=relaxed/simple;
	bh=LO82ata0pc2gsdifXfeW0p4R22XGuG0nHj1Grg6QICU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n8DkTrxZ5zfjV+Cg5Ec1ru3CfpxmWU4SQAGJZYLZic3xIod6EBK5wQnFDFe1907FF+FnJaoNjN4ppfpnfxaGpaPuLCrKA3vRmeJIBrzVL8/fYG0VE63A75p0k2O61F8XUPdlKa3ZgBXsw7UnIk2oYUZBiJoxNfA79C5UuhxsCQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YCTVcZWP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eMgCQQ/Q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753714707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=txNVi1Jf9BhDnx8U9qSE3SqNsFsfPAzF9iPKoqgzA3A=;
	b=YCTVcZWPHiYikNH0HZVoeC5jLOIY8c4pVFZRs9g/opVYnhbKaE2npC2Hb0cXdMshWNQw/N
	RBMV6+XJrf0gC9eLkFhbbVw3BaNABAuMdSYlenEOVSkAc6vwZ0hacY4LjgS9pyugzEsd65
	hzYGog9no4lUhQE1RQApl3QcbG8vOCc7lclnsKnaCtHNcoanmV6Id9NSLqxfUDNP6aUVbD
	4KzyDFlXRiRLEs3sgC/lP6mG+Z6S8bOphUnQetbjEoEY6LV3vcvmdLCFDvDYr9caS4YqLa
	3Db1TFqyorCibN8b5vQlVWw3Bwl2ztPPEWAkDeGH/y8Hy2ghoy3twp5fT/ypng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753714707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=txNVi1Jf9BhDnx8U9qSE3SqNsFsfPAzF9iPKoqgzA3A=;
	b=eMgCQQ/QiCXMk9goxd0y9V5lf7KAxuiFWuc1EAITIyk8JiC3q38B4kBgVhzIumOeRrgjZs
	QQuQYp8PQnkbgxDw==
To: fan.yu9@zte.com.cn, frederic@kernel.org, peterz@infradead.org,
 oleg@redhat.com, brauner@kernel.org, iro@zeniv.linux.org.uk,
 joel.granados@kernel.org, lorenzo.stoakes@oracle.com
Cc: linux-kernel@vger.kernel.org, xu.xin16@zte.com.cn, yang.yang29@zte.com.cn
Subject: Re: [PATCH linux-next] signal: Remove outdated __send_signal
 references in  do_notify_parent
In-Reply-To: <202507281624542763Kn377WvUMXlKHVJUdNjA@zte.com.cn>
References: <202507281624542763Kn377WvUMXlKHVJUdNjA@zte.com.cn>
Date: Mon, 28 Jul 2025 16:58:26 +0200
Message-ID: <878qk8pdkd.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jul 28 2025 at 16:24, fan wrote:
> From: Fan Yu <fan.yu9@zte.com.cn>
>
> The function __send_signal was renamed to __send_signal_locked in

Just use __send_signal() and __send_signal_locked() which makes it
entirely clear that this is about functions, so you can spare 'The
function'. Same for the subject.

> commit 157cc18122b4 ("signal: Rename send_signal send_signal_locked"),
> making the existing comments in do_notify_parent obsolete.
>
> This patch removes these outdated references to maintain code clarity

# git grep 'This patch' Documentation/process/

> and prevent confusion about the current implementation.
>
> Signed-off-by: Fan Yu <fan.yu9@zte.com.cn>
> ---
>  kernel/signal.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/kernel/signal.c b/kernel/signal.c
> index e2c928de7d2c..30a52d884f87 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2251,10 +2251,7 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
>  		if (psig->action[SIGCHLD-1].sa.sa_handler == SIG_IGN)
>  			sig = 0;
>  	}
> -	/*
> -	 * Send with __send_signal as si_pid and si_uid are in the
> -	 * parent's namespaces.
> -	 */
> +

Why are you removing the complete comment instead of just renaming the
stale reference? 

commit 61e713bdca36 ("signal: Avoid corrupting si_pid and si_uid in
do_notify_parent") put that comment there for a reason.

Thanks

        tglx

