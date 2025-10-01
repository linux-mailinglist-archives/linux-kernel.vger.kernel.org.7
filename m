Return-Path: <linux-kernel+bounces-839408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD25BB1919
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 21:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 737C91944F9F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 19:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D1A2D7DCC;
	Wed,  1 Oct 2025 19:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FhOUt0Hq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B4917A305
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 19:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759345679; cv=none; b=FpOzm8lNSreoLCd+p7uJJeexO2T16vshj6rLXbqkTc7m2fKsYLFhTsJWN1quqqkHv6rlficHOe9hlgpvvENzRNfoGH3Sthk7J+jHzJMl+5zaLHjy/pdN9wDNQfiezdt0abVlceZynQfnB6pGNGgX4mww9CEUrUj39s0drfx6oDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759345679; c=relaxed/simple;
	bh=J2rCYo9hx5xVnFjMSBxrFy3BO+6XPr4j7vkKq1FApB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjiyAr9QEayuI2YTW1KaK77pWOBZHRc03+OSM8yaewGAzr5CrlEbSmfEJWnitD+dx2OVWTGPdaOAQtIsxnsoTfTY8V3FO0npO2nl3L+2/WWWJqZfA1MLYv5U/X4ORL3hciL13LTPUmSE5FGm5zEkHE7/+ryc4190PINEyZbLA4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FhOUt0Hq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759345677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cl3C0qcTN+Ix2VE0R2sMuZEQqdS3zTb7qWEzzurdaLY=;
	b=FhOUt0HqCWzDZrEXybH/fQeT6ChciM2iDF9WmsbrJ/BXXWzrlLQBeGB6DikM5xRDN/UJSo
	ahaFglGu8jDi8YybLQkO5V6+3ndXHMqlxIHVyS7zrPRsXKCJJ+2rOxWuuWUGvtBA9cG4Hf
	9uWB+mMajKUKoN7DH21tN87faKdP7LQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-499-0hfz0klgNsSebbZd5AbQrA-1; Wed,
 01 Oct 2025 15:07:53 -0400
X-MC-Unique: 0hfz0klgNsSebbZd5AbQrA-1
X-Mimecast-MFC-AGG-ID: 0hfz0klgNsSebbZd5AbQrA_1759345672
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7590C180028D;
	Wed,  1 Oct 2025 19:07:52 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.40])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D5686195608E;
	Wed,  1 Oct 2025 19:07:48 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  1 Oct 2025 21:06:30 +0200 (CEST)
Date: Wed, 1 Oct 2025 21:06:26 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Waiman Long <llong@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, David Howells <dhowells@redhat.com>,
	Ingo Molnar <mingo@redhat.com>, Li RongQing <lirongqing@baidu.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] documentation: seqlock: fix the wrong documentation
 of read_seqbegin_or_lock/need_seqretry
Message-ID: <20251001190625.GA32506@redhat.com>
References: <20250928161953.GA3112@redhat.com>
 <20250928162029.GA3121@redhat.com>
 <b83e9c1d-2623-4abf-8c63-1110a0b92d2e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b83e9c1d-2623-4abf-8c63-1110a0b92d2e@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 10/01, Waiman Long wrote:
>
> On 9/28/25 12:20 PM, Oleg Nesterov wrote:
> >
> >--- a/Documentation/locking/seqlock.rst
> >+++ b/Documentation/locking/seqlock.rst
> >@@ -218,13 +218,14 @@ Read path, three categories:
> >     according to a passed marker. This is used to avoid lockless readers
> >     starvation (too much retry loops) in case of a sharp spike in write
> >     activity. First, a lockless read is tried (even marker passed). If
> >-   that trial fails (odd sequence counter is returned, which is used as
> >-   the next iteration marker), the lockless read is transformed to a
> >-   full locking read and no retry loop is necessary::
> >+   that trial fails (sequence counter doesn't match), make the marker
> >+   odd for the next iteration, the lockless read is transformed to a
> >+   full locking read and no retry loop is necessary, for example::
> >  	/* marker; even initialization */
> >-	int seq = 0;
> >+	int seq = 1;
> >  	do {
> >+		seq++; /* 2 on the 1st/lockless path, otherwise odd */
> >  		read_seqbegin_or_lock(&foo_seqlock, &seq);
> >  		/* ... [[read-side critical section]] ... */
>
> It is kind of odd to initialize the sequence to 1 and add an sequence
> increment inside the loop.

Sure. But a) in this patch my only point is that the current documentation is
wrong, and b) the pseudo-code after this change becomes correct and the new
pattern already have the users. For example, do_io_accounting() and more.

> Perhaps we can do something like:

Perhaps. But could you please read the "RFC 2/1" thread? To me it is kind of
odd that the simple loops like this example have to even touch the sequence
counter inside the loop.

> +static inline int need_seqretry_once(seqlock_t *lock, int *seq)
> +{
> +       int ret = !(*seq & 1) && read_seqretry(lock, *seq);
> +
> +       if (ret)
> +               *seq = 1;       /* Enforce locking in next iteration */
> +       return ret;
> +}

And this is exactly what I tried to propose in "RFC 2/1". Plus more...

Oleg.


