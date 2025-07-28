Return-Path: <linux-kernel+bounces-747796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AC4B13866
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2460A1882E9E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920D622F76B;
	Mon, 28 Jul 2025 09:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gtc2CrfM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD7A1B0F1E
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753696531; cv=none; b=uAtv86BbOBc364j8bt20JyUBvDvA87lia/aBvzctlxzKhpNXiMpMbltqKqOPmZWiBGgOsZ8m2gpTS6XI8kEROokfZ6/ZqcA5NPyjynkLKJV+TBwI/Qb7jhuk30xJQZQ8KgZD2CNs8qgUkfdkvsc1Wm8SJTmq04fMvjMn0xVdJHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753696531; c=relaxed/simple;
	bh=lBOT7hNDrq4LRqh66HuYkxIAwxJkkktIfTx0GsgYiRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLJMAapVyRTLC5TTMFF5lt3JgGzeCYha1wJId1pIIptp1IcoIk7GC862kIJPrAFVcEJF8ba1w0Mkm+Gy/3yaZvDZgbFXuAUgrjPMcZm4orz0tME+E1ibuRfh46zbLFENaN3nquF2OkdlGVNJF/HgZwlyiwadvs41yGrMovSDNnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gtc2CrfM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753696528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yz8/CCgPUzXF1R3Fc0XWgyltV+CnRyECFIpVoR7bFdc=;
	b=gtc2CrfMiBsiedF5d/Rvylgfqa/mi6ClJpi0NiMcZD6F/dT/DOr1gXYOGDEWVMQTPXifB3
	V9LcrOMDekVWIkHjit7aVXw9qsISHV997PUAtjdaM6kPNPmYHeUAOJAuLgVcorc7hY72gO
	bUXBE4vJNlKa9ygvl5iOfduqdbNgrcQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-jIssgOjWMRiP-cdLviCs4g-1; Mon,
 28 Jul 2025 05:55:24 -0400
X-MC-Unique: jIssgOjWMRiP-cdLviCs4g-1
X-Mimecast-MFC-AGG-ID: jIssgOjWMRiP-cdLviCs4g_1753696522
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9526F19560B3;
	Mon, 28 Jul 2025 09:55:21 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.39])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A9AA51955F16;
	Mon, 28 Jul 2025 09:55:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 28 Jul 2025 11:54:13 +0200 (CEST)
Date: Mon, 28 Jul 2025 11:54:05 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: fan.yu9@zte.com.cn, Andrew Morton <akpm@linux-foundation.org>
Cc: tglx@linutronix.de, frederic@kernel.org, peterz@infradead.org,
	brauner@kernel.org, iro@zeniv.linux.org.uk,
	joel.granados@kernel.org, lorenzo.stoakes@oracle.com,
	linux-kernel@vger.kernel.org, xu.xin16@zte.com.cn,
	yang.yang29@zte.com.cn
Subject: Re: [PATCH linux-next] signal: Remove outdated __send_signal
 references in? do_notify_parent
Message-ID: <20250728095405.GA25567@redhat.com>
References: <202507281624542763Kn377WvUMXlKHVJUdNjA@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202507281624542763Kn377WvUMXlKHVJUdNjA@zte.com.cn>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 07/28, fan.yu9@zte.com.cn wrote:
>
> From: Fan Yu <fan.yu9@zte.com.cn>
>
> The function __send_signal was renamed to __send_signal_locked in
> commit 157cc18122b4 ("signal: Rename send_signal send_signal_locked"),
> making the existing comments in do_notify_parent obsolete.
>
> This patch removes these outdated references to maintain code clarity
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
>  	if (valid_signal(sig) && sig)
>  		__send_signal_locked(sig, &info, tsk->parent, PIDTYPE_TGID, false);
>  	__wake_up_parent(tsk, tsk->parent);

Acked-by: Oleg Nesterov <oleg@redhat.com>


