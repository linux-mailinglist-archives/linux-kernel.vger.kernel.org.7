Return-Path: <linux-kernel+bounces-817231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5230BB57F8E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16E6A2A03EB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D2134321A;
	Mon, 15 Sep 2025 14:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iRlVEryl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4EB343203
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 14:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757947791; cv=none; b=hfNDoCLOHHLIMDpOK6IbTseDrzUMtaWBaOwyVILLICUqqsoJC8JUnMYeAu6ob1X6jzMTGOengSf7iwqW1U4RfCIO4lLUTo49+vJGKFEYLnDT3n3ceT8ZPvS9pRVD+RUDgAOy/MNqNTacBQhQEgjV5dSlZlZb7TJwM1jKMJWl8Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757947791; c=relaxed/simple;
	bh=EQrR3as8r6JttpBYEwX3XQQTxMYtTk/VHuoMMD/Weqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJ9INlt0S/VvscHkOV4lt/KVNlsizQv6qIkZzL/oysmafWPE2zjKtKoOb8bgGvKDGEhFUucXtDK7lQL/sUyA0ggr3XlQ+XR4XPA66OkJRej9U4MrsMipyAq9gZiABkdU+ndlPUeabygdmHyvNWsOXVf7D7bN2jFZAYIgRJgk92k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iRlVEryl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757947788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CkA/y861UY0j0NSM/jI1mVaVre4MXQ6jr6/SWw+imII=;
	b=iRlVErylVtwlecChbxbD23zb5qs1aRyrVrnExiMJ57VWMsWf+zWzOBYDSa6cRbJ80voGSK
	Y+/9hcymO+1EvbQxs46lm4B6BVZ2RTjWSJ+L9S09TG49Pp+H2Z6wQ23ItL7D/C5IU02qjd
	NLxjPn1kOrcdZnqEsZpuw/2GGZgjHro=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-oP7DMVCmMkaCpixDQ5C5Vg-1; Mon,
 15 Sep 2025 10:49:44 -0400
X-MC-Unique: oP7DMVCmMkaCpixDQ5C5Vg-1
X-Mimecast-MFC-AGG-ID: oP7DMVCmMkaCpixDQ5C5Vg_1757947782
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B6BF81800447;
	Mon, 15 Sep 2025 14:49:41 +0000 (UTC)
Received: from localhost (unknown [10.22.88.26])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 19A651800451;
	Mon, 15 Sep 2025 14:49:39 +0000 (UTC)
Date: Mon, 15 Sep 2025 11:49:37 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	David Vernet <dvernet@meta.com>, Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>, Crystal Wood <crwood@redhat.com>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Juri Lelli <juri.lelli@redhat.com>, Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>
Subject: Re: [RESEND PATCH] sched: restore the behavior of put_task_struct()
 for non-rt
Message-ID: <aMgngWdtqUKuqLcw@uudg.org>
References: <aMf1RzZHjdoPNOv_@uudg.org>
 <20250915113812.GB3245006@noisy.programming.kicks-ass.net>
 <20250915122444.Gg_Tsymz@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915122444.Gg_Tsymz@linutronix.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Sep 15, 2025 at 02:24:44PM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-09-15 13:38:12 [+0200], Peter Zijlstra wrote:
> > Right, but I thought we did want to make this behaviour consistent.
> 
> That is correct, that is what I asked for (either consistent or a
> compelling reason why not).

I received a ping from colleagues investigating a problem possible caused
by excessive pressure on RCU and this change could make the problem worse.
But last I heard from them, sounds like the problem they are investigating
lies elsewhere.

That said, I don't have problems either way, limiting the change to RT or
keeping it general. I will follow whatever guidance I get from you all.

Luis

> Oleg pointed out that the patch description does not match the change.
> That is the only complaint.
> 
> > And IIRC RT has been running with this for ages, and never seen a
> > problem.
> 
> The syz-bot picked up RT recently. Other than that, yes, RT had it for
> ages.
> 
> Sebastian
> 
---end quoted text---


