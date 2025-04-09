Return-Path: <linux-kernel+bounces-596518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C71A82D21
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 19:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C0DC1B651BD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 17:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE6B270EB4;
	Wed,  9 Apr 2025 17:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BjUnZhX2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E431C3314
	for <linux-kernel@vger.kernel.org>; Wed,  9 Apr 2025 17:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744218158; cv=none; b=WOmqqjTx/1IdKQDzk5MhnTn2AOAJ8+h650jsTJDMDdnzHBLP6KFTkPBg2oDNVfekaEguGi/tT6Bxoa1A4WOdSts1NteL1LHDKUblo7N3GIs3T+gMUTySqPKDN4Y6uCaXb8fm7gj+sYStUaaQIhyFClqiXrg3SJJYJg+NLvrwwQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744218158; c=relaxed/simple;
	bh=8Woo7zONtTGlS+vR4tnAD9QERZsc8c39ch7Sp73TTfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFfH0V3tKwkBYgCN0YX9DmwUPk1lZu3SfEbFYKoLF/m4MGzYEYGODUZZAhCZgILzhqgr0BDTsKmRlN+y+nO3L9WfqA28S7NknOmo0F1itm0j0S1bik0iM21KqVA9ZVVwfek+Hm/RctjNJgEgDEmlCVoUI4vqDbcrYY+S1nQYOWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BjUnZhX2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744218154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=50r+s/P904+CGfzLh0ycHBDHZFcTaMXvlcTYX7DyJ60=;
	b=BjUnZhX2IDZ63/iIne/UPOCnNzYVA0gcnzr8bWC1XDcINBN3WDJ4dYkzzi68DNKq3gWDTi
	6gWcnEdsnHR3Q6/IkvJs3vmaX8Sty/nTku6uCk/ZGMWImlZm1ZjSf6TTZdhyQAl1qzkd6M
	Km4+ruTlWVpXvvmJVXNQ0a6lSJJ06jQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-J9jIKsrSM2qUPL-NgUtTjg-1; Wed,
 09 Apr 2025 13:02:30 -0400
X-MC-Unique: J9jIKsrSM2qUPL-NgUtTjg-1
X-Mimecast-MFC-AGG-ID: J9jIKsrSM2qUPL-NgUtTjg_1744218148
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 29F111800EC5;
	Wed,  9 Apr 2025 17:02:28 +0000 (UTC)
Received: from localhost (unknown [10.22.88.189])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2EB921808882;
	Wed,  9 Apr 2025 17:02:26 +0000 (UTC)
Date: Wed, 9 Apr 2025 14:02:25 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>, Tejun Heo <tj@kernel.org>,
	David Vernet <dvernet@meta.com>, Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>, Crystal Wood <crwood@redhat.com>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH] sched: do not call __put_task_struct() on rt if
 pi_blocked_on is set
Message-ID: <Z_aoIY7GwPFUqMNb@uudg.org>
References: <Z_W-i-ya0Q6fkXRh@uudg.org>
 <20250409114330.1444221e@gandalf.local.home>
 <Z_af4PF18ocF0bBW@uudg.org>
 <20250409123944.15df8714@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409123944.15df8714@gandalf.local.home>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Wed, Apr 09, 2025 at 12:39:44PM -0400, Steven Rostedt wrote:
> On Wed, 9 Apr 2025 13:27:12 -0300
> "Luis Claudio R. Goncalves" <lgoncalv@redhat.com> wrote:
> 
> > > > -	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible()) {
> > > > +#ifdef CONFIG_PREEMPT_RT
> > > > +	if (!preemptible() || current->pi_blocked_on)
> > > > +		defer = true;
> > > > +#endif  
> > > 
> > > Why add the ugly #ifdef back?
> > > 
> > > 	if (!IS_ENABLED(CONFIG_PREEMPT_RT) ||
> > > 	    (preemptible() && !current->pi_blocked_on)) {  
> > 
> > I had to add the #ifdef to avoid the build failing if CONFIG_RT_MUTEXES is
> > not set. I do know SMP, FUTEX, I2C, PSTORE and a few more things depend on
> > CONFIG_RT_MUTEXES being enabled, but I opted for being thorough.
> > 
> > I would be more than glad getting rid of the #ifdef and simplifying the patch
> > if that possible build failure is not a case to worry about, if RT_MUTEXES are
> > always enabled nowadays.
> > 
> 
> Because pi_blocked_on is only defined when CONFIG_RT_MUTEXES is enabled?
> 
> OK, then perhaps we should add in sched.h:
> 
> #ifdef CONFIG_RT_MUTEXES
> static inline bool tsk_is_pi_blocked_on(struct task_struct *tsk)
> {
> 	return tsk->pi_blocked_on != NULL;
> }
> #else
> static inline bool tsk_is_pi_blocked_on(strut task_struct *tsk)
> {
> 	return false;
> }
> #endif
> 
> ??

Thank you for the suggestion! I will rework the patch with that and send v2
after basic testing.

Luis
 
> -- Steve
> 
---end quoted text---


