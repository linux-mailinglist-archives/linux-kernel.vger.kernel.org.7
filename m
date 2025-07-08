Return-Path: <linux-kernel+bounces-721608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCAEAFCB95
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37E691C205FC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F4E2E041E;
	Tue,  8 Jul 2025 13:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AcomI83+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55CB2E03F3
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 13:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751980207; cv=none; b=uz82t4sWLiwUDJB5Nmk7IjMRoDtZZLEXuBVCeKk6sXw1dv5cPdsuM5HIEcsltWACfUoshpnhekmWBFCphRFthpeXbUr1oDrhu55njJTW+M47Yk45Ndjy/UXK6pDta7XVfsyTN2kzTSpZAGSzQlfdMoXSwukUhCw+Bsh9K2oi900=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751980207; c=relaxed/simple;
	bh=kM0UdzLblDdqAakOw++JKFWNdpIs5ahNdvhftauQoIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kh7G3wpZRnhRl2vwiWcAl1kKBPGjVzBI+30cb4mS9uqGrxNtAs0Mn+ZAi93XNOQif3jXj1qruT5NteR/90pkUIaGaUGLtbxzVrccOj/niK9vqNBDfIYJMMPmbsuJQmyaY2zs0aUwLDFA7mBIAkESVP9O8vBhFSP6zLkdWLa10qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AcomI83+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751980203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NoHYDFHcFAzofPpYOAys2AY84RdkQXBE1/kxrLhMTeg=;
	b=AcomI83+1ov0yb8+IzIiF8ueIp7U3KQ/gd4ChiHQ+WoOwmfx5PHnnLPLVw+ky2T4hD70nK
	kk43bXOKQkio9w4e3OkTokNui3y6MGvXgc62rPqaAxobdZl5gA4BWe3zmcOg46pxDsL108
	1jAAJLG0DKTcnyTqRjkhdHwsROQnAQ0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-YL5rmCQvOfuXsZ7EjdZuPg-1; Tue,
 08 Jul 2025 09:09:58 -0400
X-MC-Unique: YL5rmCQvOfuXsZ7EjdZuPg-1
X-Mimecast-MFC-AGG-ID: YL5rmCQvOfuXsZ7EjdZuPg_1751980196
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DAD0B180028D;
	Tue,  8 Jul 2025 13:09:55 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.81.8])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id AA35419560AD;
	Tue,  8 Jul 2025 13:09:46 +0000 (UTC)
Date: Tue, 8 Jul 2025 10:09:45 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Thomas Gleixner <tglx@linutronix.de>, Boqun Feng <boqun.feng@gmail.com>, 
	open list <linux-kernel@vger.kernel.org>, "open list:TRACING" <linux-trace-kernel@vger.kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Clark Williams <williams@redhat.com>, 
	Gabriele Monaco <gmonaco@redhat.com>
Subject: Re: [PATCH v3 2/2] tracing/preemptirq: Optimize
 preempt_disable/enable() tracepoint overhead
Message-ID: <ppdduzdqnd3kwourcmocfi35i7wcbuagmzqgtgmyr55aps774t@37wucnoii7o3>
References: <20250704170748.97632-1-wander@redhat.com>
 <20250704170748.97632-3-wander@redhat.com>
 <20250707112622.GZ1613376@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707112622.GZ1613376@noisy.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Jul 07, 2025 at 01:26:22PM +0200, Peter Zijlstra wrote:
> On Fri, Jul 04, 2025 at 02:07:43PM -0300, Wander Lairson Costa wrote:
> > +#if defined(CONFIG_DEBUG_PREEMPT) || defined(CONFIG_TRACE_PREEMPT_TOGGLE)
> > +#define preempt_count_dec_and_test() \
> > +	({ preempt_count_sub(1); should_resched(0); })
> > +#endif
> 
> Also this is terrible. Surely you can do better.
> 

Thank you for pointing this out. I'm not sure I've fully understood the
concern here. My understanding was that this logic was pre-existing and
my patch only reorganized it.

I'm clearly missing something. Could you please elaborate a bit on the
issue you've spotted?


