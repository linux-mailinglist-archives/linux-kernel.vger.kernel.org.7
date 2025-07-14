Return-Path: <linux-kernel+bounces-730156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8036CB040C9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C05AD3A406F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE1F2550AF;
	Mon, 14 Jul 2025 13:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ihwoucRH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F492550A3
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752501476; cv=none; b=pzteKc67hK3zYhUL+4teJsK91/j0t1hebNz/f3WUTnpQ5Yh0ZJKxVzkx3cdpymfhe2mh0gypTYqEsSeaeLkjDYKkzVLkGxtw9JFamcYuzfXJauvQRt9djh6x0tqf52b2cHkO0zcYuB9GoIUdU3EXZAVAM4N673u2ps30Phuz4ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752501476; c=relaxed/simple;
	bh=E8iD56zHPlIFvKlRxG6dwgur/A1xsXFYNFKjAHaAgUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmEWbJG71L/SO9gbImKYFRy4D6c8cRmLEXsFsYtxARMl8nrM46DEseUwa2LYmB3w4IIShJTM74UClZDD/77gtTIJhYM8B6ZKVBvl+ij/APjRyVe98juXlJOIoszHjqlNwj6MDm/Tj5LhODQm/9c8dxkmK918Te1zOdEB6jdUAFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ihwoucRH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752501473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g225VFOoJkWHVHYM5ehZTAWKqvMpJYyKwWcyzrVaidU=;
	b=ihwoucRHI1ca8LbN8LpjNxAXjY4KcgHmc0ET18byrsBpxk/xnuqGV7PAenorBCk+3z/Jn/
	vandFNoac3SASJustWWkjL3edGyIbI08Yd6TZWhGztSEqrWx1s1eC3Nw7T5GeEZAMsyacd
	Tmaf1LQPHJZM6C+XF04+z58Qzz62s9c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-PjgUnN9kNeWtRTeLB0rT_g-1; Mon,
 14 Jul 2025 09:57:50 -0400
X-MC-Unique: PjgUnN9kNeWtRTeLB0rT_g-1
X-Mimecast-MFC-AGG-ID: PjgUnN9kNeWtRTeLB0rT_g_1752501468
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 61B701801207;
	Mon, 14 Jul 2025 13:57:48 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.81.87])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B117A30001A1;
	Mon, 14 Jul 2025 13:57:45 +0000 (UTC)
Date: Mon, 14 Jul 2025 09:57:42 -0400
From: Phil Auld <pauld@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, clm@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/12] sched: Add ttwu_queue support for delayed tasks
Message-ID: <20250714135742.GB54091@pauld.westford.csb>
References: <20250702114924.091581796@infradead.org>
 <20250702121159.652969404@infradead.org>
 <20250703160027.GC245663@pauld.westford.csb>
 <20250703164708.GZ1613200@noisy.programming.kicks-ass.net>
 <20250703171121.GE245663@pauld.westford.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703171121.GE245663@pauld.westford.csb>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Peter,

On Thu, Jul 03, 2025 at 01:11:27PM -0400 Phil Auld wrote:
> On Thu, Jul 03, 2025 at 06:47:08PM +0200 Peter Zijlstra wrote:
> > On Thu, Jul 03, 2025 at 12:00:27PM -0400, Phil Auld wrote:
> > 
> > > > +	if (ttwu_do_migrate(rq, p, cpu))
> > > > +
> > > 
> > > This doesn't compile because ttwu_do_migrate() doesn't take a *rq.
> > > 
> > > It's easy enough to fix up and I'll try to have our perf team try these
> > > out. 
> > 

For the second part if this email...

Our perf team reports that this series (as originally posted without the minor
fixups) addresses the randwrite issue we were seeing with delayed dequeue
and shows a bit better performance on some other fs related tests.

It's neutral on other tests so modulo the issues others reported I think
we'd be happy to have these in.  We did not see any new regressions.

Thanks!


Cheers,
Phil
-- 


