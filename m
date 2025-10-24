Return-Path: <linux-kernel+bounces-868727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A07C05FB3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 65A07568C44
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFBF31B119;
	Fri, 24 Oct 2025 11:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IhkEPRBY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92CA31352F
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 11:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303693; cv=none; b=eXb9lMj+doSGSd8Rwt6vj/+p8/jIhIZNqhMpKxaJoKwaPdq40vGWNuI9v71wUnWUdUVQEiyGmtEsL2Aq2QNNK7qny3cSwAu9aTdNdoL3uMYNtHooRQahiFooEhmW5FOgdfzhEC+pVZWLPOFu5wJ31oKhCKirwU5GojW7KVMV8I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303693; c=relaxed/simple;
	bh=mCAe9ncMYt9xNubzh6i4PNc5V9nSnsjSFZkvBPHzR2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYacUsVCsMYbxZMAzFrLLKeehx1WvJYvpdI26SthGfuOMzxgc/niIrZWPHGiG8Vnw7jgBSd0Bt0X6DFYFP0y/xPI10txXb9jxHQRi8otjNXAWG4wrCuJFnu+vkU030u0d5tZeqOtwxgIUii5H9idNoTlZawa8GPiQgom/EGkIlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IhkEPRBY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761303690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mCAe9ncMYt9xNubzh6i4PNc5V9nSnsjSFZkvBPHzR2M=;
	b=IhkEPRBYfkwJkZFlSsMxvEySeuNaoNFNJVUiJbc04myswbIFkyQ2Cigosb7yu+c1+O1oCN
	eORufb4gxrP0dni8Dka3CW2sWenmFMUp3J7jT9Gvzv2tKPmyHb+nC480/5CAipdMATH767
	gzWz3Xg0Lz0OFnIitJWaubxHJY7b5m0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-n6R1ZRgFOhCL1_-48qj73g-1; Fri,
 24 Oct 2025 07:01:27 -0400
X-MC-Unique: n6R1ZRgFOhCL1_-48qj73g-1
X-Mimecast-MFC-AGG-ID: n6R1ZRgFOhCL1_-48qj73g_1761303686
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3169618001D1;
	Fri, 24 Oct 2025 11:01:26 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.19])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 5715D180057D;
	Fri, 24 Oct 2025 11:01:24 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 24 Oct 2025 13:00:07 +0200 (CEST)
Date: Fri, 24 Oct 2025 13:00:04 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>, John Ogness <john.ogness@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] printk_legacy_map: use LD_WAIT_CONFIG instead of
 LD_WAIT_SLEEP
Message-ID: <20251024110004.GF771@redhat.com>
References: <20251022154115.GA22400@redhat.com>
 <20251023103234.GA27415@redhat.com>
 <20251023142655.FvZkeSa-@linutronix.de>
 <20251024104055.GE771@redhat.com>
 <20251024105222.RZPI5xWT@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024105222.RZPI5xWT@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 10/24, Sebastian Andrzej Siewior wrote:
>
> On 2025-10-24 12:40:56 [+0200], Oleg Nesterov wrote:
> > On 10/23, Sebastian Andrzej Siewior wrote:
> > >
> > > On 2025-10-23 12:32:34 [+0200], Oleg Nesterov wrote:
> > > > printk_legacy_map is used on !PREEMPT_RT to avoid false positives from
> > > > CONFIG_PROVE_RAW_LOCK_NESTING about raw_spinlock/spinlock nesting.
> > >
> > > Could we please get rid of CONFIG_PROVE_RAW_LOCK_NESTING here? This is
> > > lockdep internal implementation and has nothing to do with printk or
> > > anything.
> >
> > OK, but let me ensure I didn't miss something (again ;).
> >
> > I mentioned CONFIG_PROVE_RAW_LOCK_NESTING in the changelog because if
> > CONFIG_PROVE_RAW_LOCK_NESTING=n, then LD_WAIT_CONFIG == LD_WAIT_SPIN
> > and lockdep will not complain if spinlock_t nests inside raw_spinlock_t.
> >
> > IOW, without CONFIG_PROVE_RAW_LOCK_NESTING printk_legacy_map is not
> > really needed.
>
> This is correct but CONFIG_PROVE_RAW_LOCK_NESTING is kind of a must and
> should not be an option.

Yes, I see your point. Just wanted to ensure I fully understand it.

Thanks,

Oleg.


