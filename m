Return-Path: <linux-kernel+bounces-721569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C2EAFCB09
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D4BB164D7B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222312DAFB4;
	Tue,  8 Jul 2025 12:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hRZ5lBNy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D00D1E5B91
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 12:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751979265; cv=none; b=rb2IJmkkXwcmGX4ev+WQrATfFeCaFhyJIhjbMsqacDnVfrC4+2j8rikEe7kF/ecf6t6ltI+OuYbFot2Jhc7iHf/TH1AY0InWVzXhGC9h5XpixDLCPCYRb3RimJV3FIO6BzkXZI/mJ9f/nWtzuEp+q52DZDvx0fWPxwkHR/nV60k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751979265; c=relaxed/simple;
	bh=gCvRXp5IUoejm+SeREkfPCa6p5ZAtiPS7x9Pu01lKpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnkZcFL6WCpQojE/3izexGkA56okvXvLzRTlABa6pMlnEZwdiJuF0+LJpDvCemWt3ATP3I/0WyHbu02GJDInzBiq9sft3dImyvGB/d8n7pTC4AfB+3Vj/Jpb0W4PEyqEO4kWXlhgymrlniFX7/oSecaqdUCJ/6LzRvTes+ElRRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hRZ5lBNy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751979263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VsRZnLqc6bCbMesWPscz6CEY2RWuz7oE/SD/UpR8kA0=;
	b=hRZ5lBNypjRsFgIQbQpg0tN9g2DzIMhBB4HLih/rWZ8cme171Hv6ipMdzfTFMR0b2wcl8C
	3r6oPwYTSqbeBcJFo8NiHNdlSIXxtq+X0oWJrYfc4FcRE+xTrz3lU9QH2tTbqV8beRE42Q
	1rOBi498+VEDc9Vfc/pDI9aTM4M3b7M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-348-5BSFM9d_Nnq71JBThATDDQ-1; Tue,
 08 Jul 2025 08:54:19 -0400
X-MC-Unique: 5BSFM9d_Nnq71JBThATDDQ-1
X-Mimecast-MFC-AGG-ID: 5BSFM9d_Nnq71JBThATDDQ_1751979257
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 06A751800290;
	Tue,  8 Jul 2025 12:54:16 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.81.8])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0634530001B1;
	Tue,  8 Jul 2025 12:54:08 +0000 (UTC)
Date: Tue, 8 Jul 2025 09:54:06 -0300
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
Message-ID: <33jax5mmu7mdt6ph5t5bb7fvprbypxhefrvgrc2ru4p2dpqldg@d6af6oc6442r>
References: <20250704170748.97632-1-wander@redhat.com>
 <20250704170748.97632-3-wander@redhat.com>
 <20250707112003.GY1613376@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250707112003.GY1613376@noisy.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

O Mon, Jul 07, 2025 at 01:20:03PM +0200, Peter Zijlstra wrote:
> On Fri, Jul 04, 2025 at 02:07:43PM -0300, Wander Lairson Costa wrote:
> > Similar to the IRQ tracepoint, the preempt tracepoints are typically
> > disabled in production systems due to the significant overhead they
> > introduce even when not in use.
> > 
> > The overhead primarily comes from two sources: First, when tracepoints
> > are compiled into the kernel, preempt_count_add() and preempt_count_sub()
> > become external function calls rather than inlined operations. Second,
> > these functions perform unnecessary preempt_count() checks even when the
> > tracepoint itself is disabled.
> > 
> > This optimization introduces an early check of the tracepoint static key,
> > which allows us to skip both the function call overhead and the redundant
> > preempt_count() checks when tracing is disabled. The change maintains all
> > existing functionality when tracing is active while significantly
> > reducing overhead for the common case where tracing is inactive.
> > 
> 
> This one in particular I worry about the code gen impact. There are a
> *LOT* of preempt_{dis,en}able() sites in the kernel and now they all get
> this static branch and call crud on.
> 
> We spend significant effort to make preempt_{dis,en}able() as small as
> possible.
> 

Thank you for the feedback, it's much appreciated. I just want to make sure
I'm on the right track. If I understand your concern correctly, it revolves
around the overhead this patch might introduce—specifically to the binary
size and its effect on the iCache—when the kernel is built with preempt
tracepoints enabled. Is that an accurate summary?


