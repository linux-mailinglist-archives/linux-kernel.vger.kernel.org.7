Return-Path: <linux-kernel+bounces-869086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8193C06EA6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E9191899F9E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53C33277BA;
	Fri, 24 Oct 2025 15:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hAe2Pqc0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8ED3277B4
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 15:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761319031; cv=none; b=e/3I/Hy4nWyD96ag1850cRSAAoFavNAeSkfBgC62Z1nHZ5E+jX//RNzmhkHy6bQlggn53dutSuEq7hHIugpoK7L9AAZ2N9IwLLQWeX9a8kT6aONzeLSRosAEz+vFrNfMQjaR4CL7zr14IzEXa+XkEzh0ndUKqSn0mwXhWBI3JXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761319031; c=relaxed/simple;
	bh=8Y7SrK0ctZphNN2Pa+hqjmd92v8eIQVCr9RsEOW9zgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mqRG8X4AhJ3nrFL5iMZAvgsiVuJZMuaQZjthIWWLMZZDe4IaU9oWrZlN85MvZcJnfKf+e+yANS6haEbKBBIJSPdDtYfoxh2pqVy5uZjCq3Estg/hmGbRwbDmaLvYJnXtbkfZZOWIBSvCBTaeIfD1AkdpF6yp+TMp8qV4w1A3FVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hAe2Pqc0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761319026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NabUNuiOqfPqN9y+bWQU4ZxvJdIaNiEJw8A5/qk23aw=;
	b=hAe2Pqc0rhvSTd634YqUM7ng2EuIgu4YDraG5ZcJs4qhLzuNrpFGRnG29aU85OsARw2dzU
	LqYrXALFcCTSSS4y59I5/M6hYyeYsdV7LXvYbm3uAL6/VKYAvF2v8OI40t5qLob7I7xX+d
	x09/IczNZPwUXJ+NP4I/YyP8yND7bHI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-600-MqyJmtpcPfq6kUVI0btGgQ-1; Fri,
 24 Oct 2025 11:17:02 -0400
X-MC-Unique: MqyJmtpcPfq6kUVI0btGgQ-1
X-Mimecast-MFC-AGG-ID: MqyJmtpcPfq6kUVI0btGgQ_1761319021
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8BC931800637;
	Fri, 24 Oct 2025 15:17:01 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.19])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B6455180057F;
	Fri, 24 Oct 2025 15:16:59 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 24 Oct 2025 17:15:43 +0200 (CEST)
Date: Fri, 24 Oct 2025 17:15:40 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] printk_legacy_map: use LD_WAIT_CONFIG instead of
 LD_WAIT_SLEEP
Message-ID: <20251024151539.GG771@redhat.com>
References: <20251022154115.GA22400@redhat.com>
 <20251023103234.GA27415@redhat.com>
 <20251023142655.FvZkeSa-@linutronix.de>
 <87wm4lbqt2.fsf@jogness.linutronix.de>
 <20251023151112.goqBFQcM@linutronix.de>
 <20251023154657.GD26461@redhat.com>
 <20251023191442.Uu0mD_Nq@linutronix.de>
 <aPtIUq7hf4R5-qfF@pathway.suse.cz>
 <20251024103808.umPAqCda@linutronix.de>
 <aPt3qje1IQU8i9Md@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPt3qje1IQU8i9Md@pathway.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

So it seems that you guys finally have a consensus on this patch ;)

Should I send v3 or will you do it? I don't care about the "From:" tag.
If you want me to do it, let me ask:

On 10/24, Petr Mladek wrote:
>
> On Fri 2025-10-24 12:38:08, Sebastian Andrzej Siewior wrote:
> >   The legacy console always acquires a spinlock_t from its printing
> >   callback. This violates lock nesting if the caller acquired an always
> >   spinning lock (raw_spinlock_t) while invoking printk(). This is not a
> >   problem on PREEMPT_RT because legacy consoles print always from a
> >   dedicated thread and never from within printk(). Therefore we tell
> >   lockdep that a sleeping spin lock (spinlock_t) is valid here.
>
> Looks good to me.

Same here. Should I replace the whole comment block above
DEFINE_WAIT_OVERRIDE_MAP(printk_legacy_map) with the text above?

> >   printk_legacy_map is used to hide lock nesting violations caused by
> >   legacy drivers and is using the wrong override type. LD_WAIT_SLEEP is
> >   for always sleeping lock types such as mutex_t. LD_WAIT_CONFIG is for
> >   lock type which are sleeping while spinning on PREEMPT_RT such as
> >   spinlock_t.
>
> Looks goot to me.

Same here. Should I add anything else into the changelog?

> JFYI, I do not mind which version is used.

Same here ;)

Oleg.


