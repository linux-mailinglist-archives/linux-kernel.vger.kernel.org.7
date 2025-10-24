Return-Path: <linux-kernel+bounces-868599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9B8C05916
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED9384F0AB5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F2E30F946;
	Fri, 24 Oct 2025 10:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BX9ix6Dw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DC430F93E
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761301674; cv=none; b=hbwCcMgPTj+4b3M2pL3oP+DZGMrwVIS07qQd57iHOqR9HiaaG2w0Pg3ImD6zB7u3kRQmlwE9fmDDRl5ptfj9/J30LlajHsP+HC+JwvESl95u36NWMd8ClZM30URxB6DvCw+9703pBEruLGVh9SWmuNtHj6XjmpKxcZyQsQE0XUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761301674; c=relaxed/simple;
	bh=N2ajP2q9W7M7yvoN4wqZtQqLNgaUm/57gWLE4t8N9Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cfw52ZJk++//QsEwH1tjXbdW4KBWGdxJiR7jntiRRInou0sH2fH0mn0J7W2LSYZAkLrfuLiv/cl22YC+cyj91ThKXxrxgATl96bY4putqQujdVyi/IHgb0LB7IOBL//GH+xbVj9mgPEuTPIO/KeK2hLX01KMyXCnurWWte5dd64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BX9ix6Dw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761301672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=op9gJxTu3V1l3M3YQdCe2LbH3bbhAoGT+rz90MVA+nU=;
	b=BX9ix6DweY43mgmSLbMuje71+9ptlbWx8JAfIectU39x35Avbg1Hzh4UrYmeeXkzVoFq+k
	5XA4evVbaSwWphYW/xQHyM9w30sFafeCKcjZQMcuJglAfvxsrSyGDSaZ4RS6u02VQydwMJ
	k81i6oHti8uPkSMAZWi1fpKJT4endhU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-VYONG_KNMamzq3OWIdM9vg-1; Fri,
 24 Oct 2025 06:27:46 -0400
X-MC-Unique: VYONG_KNMamzq3OWIdM9vg-1
X-Mimecast-MFC-AGG-ID: VYONG_KNMamzq3OWIdM9vg_1761301664
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 650861954190;
	Fri, 24 Oct 2025 10:27:44 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.19])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 41084180057D;
	Fri, 24 Oct 2025 10:27:35 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 24 Oct 2025 12:26:26 +0200 (CEST)
Date: Fri, 24 Oct 2025 12:26:16 +0200
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
Subject: Re: usage of DEFINE_WAIT_OVERRIDE_MAP(LD_WAIT_SLEEP)
Message-ID: <20251024102616.GD771@redhat.com>
References: <aIjCYEkgNvVpMYCS@uudg.org>
 <20250729130936.GB18541@redhat.com>
 <20250801102428.GB27835@redhat.com>
 <20250811105948.OafBprND@linutronix.de>
 <20251020145310.GA9608@redhat.com>
 <20251023135316.1ZRx0UU5@linutronix.de>
 <20251023152942.GC26461@redhat.com>
 <20251023153750.C6EU9NL6@linutronix.de>
 <20251023155339.GE26461@redhat.com>
 <20251023192353.Wkng87fi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023192353.Wkng87fi@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 10/23, Sebastian Andrzej Siewior wrote:
>
> On 2025-10-23 17:53:40 [+0200], Oleg Nesterov wrote:
> > Sebastian,
> Hi Oleg,
>
> > sorry. I guess this is my fault, but I can't understand your reply...
> > Could you spell please?
>
> So you refer to this:
> | /* PREEMPT_RT kernels map spinlock to rt_mutex */
> | #include <linux/rtmutex.h>
> |
> | typedef struct spinlock {
> | 	struct rt_mutex_base	lock;
> | #ifdef CONFIG_DEBUG_LOCK_ALLOC
> | 	struct lockdep_map	dep_map;
> | #endif
> | } spinlock_t;
>
> spinlock_t on PREEMPT_RT does not use (struct) rt_mutex as the comment
> claims. It uses just the basic building block which is "struct
> rt_mutex_base". This requires linux/rtmutex.h.
>
> spinlock_t on PREEMPT_RT uses LD_WAIT_CONFIG via SPIN_DEP_MAP_INIT as
> !PREEMPT_RT. Nothing changes here.

Ah, indeed, I was confused and didn't even bother to read the definitions
below, spinlock->dep_map is initialized by the same SPIN_DEP_MAP_INIT()...

Sebastian, thanks for correcting me! Sorry, I could not carefully read
your emails yesterday.

Oleg.


