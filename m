Return-Path: <linux-kernel+bounces-762465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE98B206E1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 450DD18C2085
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9D22BE65A;
	Mon, 11 Aug 2025 11:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GqtAQaCh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E2F2BE647
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754910466; cv=none; b=fBay824GQGKqzgiQavJ2sqw1pm8Wc6oaxqnznXMGPWBv+mbMx85jWzbVmn2QB7Q+qO5c5KISr01CcC/RjrXptVXpyIlvaqvnowGHpu+vwwAwsSn1TOOiX1t5UO2NwJFqJ/h6ObBBEUMm4RzInaUPRCWnXAEeCnzJU5s+v9AxP8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754910466; c=relaxed/simple;
	bh=O2SKs0Md1F3DfmxaC8UtIvZcyp1gvc16RhrpwvtZfu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWMtiwqslJKLcCVE+nPR6Ur500S3lSY8d8cyEPYdfZD8RzNQM9zj+8IaGWgtBZnZiB+Ikep/L7IQRWPhMUUx9uLmSdtU2zNQUkEFPNSxKUT26uZ/5A5YulQASTF3WkpZbgCT8MvC46+urmpkzXUrRZBeZvnEPs2nrTtlxl1wwOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GqtAQaCh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754910463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O2SKs0Md1F3DfmxaC8UtIvZcyp1gvc16RhrpwvtZfu0=;
	b=GqtAQaChLiYi0LlLLPXpkNKdCIwm3zE5khHt6BCgk1Xjq67BenT7BpyXjtB7ziGYGdJJXq
	dRxgSkpzMrpt1GNmYK+buFUwb4xj6fBmmlXdMWP3Ja+uaIiz7EwnjPdHyHO+/xh5QO4Ajx
	tZ2Yo5o1D9bOGdDi1gWI8IBlYqmwwLg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-101-clhStL0ZPX67YSPKFCKKIw-1; Mon,
 11 Aug 2025 07:07:42 -0400
X-MC-Unique: clhStL0ZPX67YSPKFCKKIw-1
X-Mimecast-MFC-AGG-ID: clhStL0ZPX67YSPKFCKKIw_1754910460
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CA84F1956088;
	Mon, 11 Aug 2025 11:07:39 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.234])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 21D0B18004A3;
	Mon, 11 Aug 2025 11:07:31 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 11 Aug 2025 13:06:27 +0200 (CEST)
Date: Mon, 11 Aug 2025 13:06:18 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCH v6] sched: do not call __put_task_struct() on rt if
 pi_blocked_on is set
Message-ID: <20250811110617.GB5250@redhat.com>
References: <aGvTz5VaPFyj0pBV@uudg.org>
 <20250728201441.GA4690@redhat.com>
 <aIh5QajyaVT7MtVp@uudg.org>
 <20250729114702.GA18541@redhat.com>
 <aIjCYEkgNvVpMYCS@uudg.org>
 <20250729130936.GB18541@redhat.com>
 <20250801102428.GB27835@redhat.com>
 <20250811105948.OafBprND@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811105948.OafBprND@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 08/11, Sebastian Andrzej Siewior wrote:
>
> On 2025-08-01 12:24:29 [+0200], Oleg Nesterov wrote:
> > s/LD_WAIT_SLEEP/LD_WAIT_CONFIG/ needs another discussion even if I am right,
> > sorry for the confusion.
>
> You are correct Oleg. I've been just verifying it and yes: LD_WAIT_SLEEP
> suppresses also mutex while the intention is to only suppress
> spinlock_t.

Good, thanks.

> We have four users in tree, based on quick check all four should use
> CONFIG, three of them do use SLEEP.

Yes. I'll send the simple patch when this patch from Luis is merged.

Oleg


