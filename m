Return-Path: <linux-kernel+bounces-845493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A17BC525F
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 15:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1661C189C697
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 13:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA4927B34E;
	Wed,  8 Oct 2025 13:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cpWzYXB7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7656F170A11
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 13:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759929196; cv=none; b=uTZTIzn8HF/fKPCgYHNCArdSdxioVZgrtvy2famJrrISt+OVWR/201iwJr9bMh8kCNrpyljsohRU30z2eaOmIEU+yrJrc5SyBLIR+q/h/jnm+atQLAMaz0JxRSzdAM0bRP/6GHtjWPaQl0J9ISp4qZH7ajlauvv7TlyVrRYh2fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759929196; c=relaxed/simple;
	bh=J0UgBcMVZShSgTRFPqyT3w8kAQB687JxSVIhZQnew44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMVN3n2d2zks4Zbhk32hVCd0efsWSusPrped57ZUiQ94fIQVvyhmTtlvpeQlR6A9zgD+iiiCpJtKPI94f4+yzLsRTkTn/SfN+KX0+rRjXkO2X8Wjdu6j63MnOsIqJwkIltPIKsrvTZqDvdVOxnfEtsN40FumoqwHjQTrCaIWef4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cpWzYXB7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759929193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KfO3HcuzilzdD2IT8B5zQurZ7lvUWM/OXF8M+sb0TFY=;
	b=cpWzYXB7+5i7crgqV0MGtknN66Jer/ITM3ogBhqWxyVTScjYd/mqpXfLBdFIxRB0zH3Hug
	KpIVB5Q2qIQpcjkYZZyWHItrpBQ61ArKAf1Au7te+VZteKi3wHM/ijXuwBQo9pamEqARO0
	n2TqMaZgTX83aqiHgWaeu+UiV69akhE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-59-WK4l7uOGMXqH89epSJtmVA-1; Wed,
 08 Oct 2025 09:13:10 -0400
X-MC-Unique: WK4l7uOGMXqH89epSJtmVA-1
X-Mimecast-MFC-AGG-ID: WK4l7uOGMXqH89epSJtmVA_1759929189
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 032901800292;
	Wed,  8 Oct 2025 13:13:09 +0000 (UTC)
Received: from fedora (unknown [10.44.34.240])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 759451956056;
	Wed,  8 Oct 2025 13:13:04 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  8 Oct 2025 15:13:08 +0200 (CEST)
Date: Wed, 8 Oct 2025 15:13:02 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Boqun Feng <boqun.feng@gmail.com>,
	David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Li RongQing <lirongqing@baidu.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] seqlock: introduce scoped_seqlock_read() and
 scoped_seqlock_read_irqsave()
Message-ID: <aOZjXq8u8fV_kABe@redhat.com>
References: <20250928161953.GA3112@redhat.com>
 <20251008123014.GA20413@redhat.com>
 <20251008125639.GK3289052@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008125639.GK3289052@noisy.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 10/08, Peter Zijlstra wrote:
>
> On Wed, Oct 08, 2025 at 02:30:14PM +0200, Oleg Nesterov wrote:
> > Only 1/4 was changed according to comments from Linus and Waiman,
> > but let me resend 2-4 as well.
>
> Shall I put this in tip/locking/core once -rc1 happens or so?

Would be great ;) If nobody objects.

Can you also take the trivial

	[PATCH 1/1] documentation: seqlock: fix the wrong documentation of read_seqbegin_or_lock/need_seqretry
	https://lore.kernel.org/all/20250928162029.GA3121@redhat.com/

?

OTOH, if this series is merged, this doc fix should be updated to
mention scoped_seqlock_read()...

Oleg.


