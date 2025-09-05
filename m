Return-Path: <linux-kernel+bounces-803141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2323BB45AFE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23D747A9D5A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B94C3705BE;
	Fri,  5 Sep 2025 14:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TasVQrrv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4CBkmSoP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F932D6E62
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 14:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757083959; cv=none; b=dLTgfByxAsSq3OL4tljy3sZRqqD9D221wQkKqLQohACIqzNwgpjIytNIx8jpzo/0B+I2mt/ObHIXB5ak9kMmR0O0elAec7ByWoUQPOR361xJ8bfyeTyoiHpSrU2UksMDPIXjy2989bI7SBvAEdBL7B8f8X6L0sREbJDRR/CCuuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757083959; c=relaxed/simple;
	bh=Xu1g+teYydmWB5yF9an1FWrhCK8s85vhbN/eTm57pkI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ntPDu04brpkip7nHwBAyS22lCdhwMqLy+Z2Z5GhLAzXerY0lccXK1NiF3SlHXuermSKINLrAd4qHCvMCxLeHNrhYdlepOFBTcfDGjmMTuUK3uICuwwTdIvssZ2bhb3TdS/wi8RKaqrHr0OVYzMh6iHohwwk31YfCBd5ybd8IYfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TasVQrrv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4CBkmSoP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757083955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lNJmb91huSLN3d6QUPI4dIIOu1cH9V8bQvyuIahQuKM=;
	b=TasVQrrv0+VlZT7ShLM+x0HY0QYw0AzbdY4hEUlNFvqMkJ2DelOt/p5WCtxnibKETKtXjI
	Hq1jww8/I1jWryPdmNFQbelOpqlhbtDIHsXQ37ZDmT63MJYIYnjeVkLuV5a6QuoI2v2Eqz
	TzbTnG5rpdhW9/2siEXyMc52a0LJ3SApgzAW1leN5YiomMcqemj5rZjER8QhVXvOxdrEpz
	SRJo2y9f7MYMEbmQv23rOESNbzyKBmtH138wvdzUaHzuPBzVwdadACn4PVCumHhZsNE0fy
	qRAoafq1TEluO6VSenSpmSXSrrPCmDR6XQfJTBr31oGRlzz8J4GYxGclBgHETw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757083955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lNJmb91huSLN3d6QUPI4dIIOu1cH9V8bQvyuIahQuKM=;
	b=4CBkmSoPp06N8LzJjJEf95pQRhzVmonT+5akiifYx8zGCiKpnKndOvM0jqGJ6kC4a47vAy
	3J75zBxonjp4t1DA==
To: Marcos Paulo de Souza <mpdesouza@suse.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Petr Mladek <pmladek@suse.com>, Steven
 Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <danielt@kernel.org>, Douglas Anderson
 <dianders@chromium.org>
Cc: linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
 Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH v3 3/4] printk: nbcon: Allow KDB to acquire the NBCON
 context
In-Reply-To: <20250902-nbcon-kgdboc-v3-3-cd30a8106f1c@suse.com>
References: <20250902-nbcon-kgdboc-v3-0-cd30a8106f1c@suse.com>
 <20250902-nbcon-kgdboc-v3-3-cd30a8106f1c@suse.com>
Date: Fri, 05 Sep 2025 16:58:34 +0206
Message-ID: <84y0qtdk99.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-09-02, Marcos Paulo de Souza <mpdesouza@suse.com> wrote:
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index ff218e95a505fd10521c2c4dfb00ad5ec5773953..352235a0eb4a484caccf86d3a57d1a149218ecec 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -255,6 +258,7 @@ static int nbcon_context_try_acquire_direct(struct nbcon_context *ctxt,
>  		 * interrupted by the panic CPU while printing.
>  		 */
>  		if (other_cpu_in_panic() &&
> +		    READ_ONCE(kdb_printf_cpu) != raw_smp_processor_id() &&

This needs some sort of ifdef CONFIG_KGDB_KDB wrapped around it. Maybe
it would be cleaner to have some macro.

#ifdef CONFIG_KGDB_KDB
#define KGDB_IS_ACTIVE() (READ_ONCE(kdb_printf_cpu) == raw_smp_processor_id())
#else
#define KGDB_IS_ACTIVE() false
#endif

and then something like:

	if (other_cpu_in_panic() &&
	    !KGDB_IS_ACTIVE() &&
	    (!is_reacquire || cur->unsafe_takeover)) {
		return -EPERM;
	}

Or however you prefer. We need to compile for !CONFIG_KGDB_KDB.

John

