Return-Path: <linux-kernel+bounces-883011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0B0C2C480
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 14:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD9353BEE71
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 13:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6661D26B742;
	Mon,  3 Nov 2025 13:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dm4jy9rz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jSAsfMRY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D132222BF
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 13:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762177823; cv=none; b=dwYZcBtWBXxlEtHDvsjAiFuwdlLDvERgKxmldBTN4CMeeZ9l/bCiv51b96kVioPuRcNVNmpszYxYlYeYbmM1jljuhBmUPOVO3z019SiYrYh4yP/ZckFcqK74VRLp0NcGt9l7UH3K0rnwyK/pftX6fsTwPKutjNTVf/vIhZN11BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762177823; c=relaxed/simple;
	bh=ohJeMw0OCJJD0F2l1gW4Fy3Y3zG1SiD8cjcPlLbmCiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YyPJNZsgqQRFw45ipGP+kOZiI2wgJyObeebh7e138o9MPkXhM0PbPUiTVujtRDNI9P1EORrw7pBs43w/p6DXlyVVEpF7a+SP2Zu9DxN18baz59c3Sbn412QnDdv2EoDG7MUWRWCIKKv1zaPc9r3RIVk2Nf7pG0xavUxtEh9V+yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dm4jy9rz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jSAsfMRY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762177820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DeCW7EBrUwZA713FmQXR6wEfB/uUnNKUpWTNflayAhw=;
	b=dm4jy9rzUcOgAVZlU/UO84XkjM1ZlzePFHe21ACK9FPRod/DkDUyJig7w39MglmTx9Rmnw
	GTU4MNBCJeF3oPt8WA9w2Qyj0W/x7w7r+TATFFLs1Tj/4hrbA10vItzvEcJBL1FTesEUKe
	qOr8y0GJXWds2plQgMf9AYiZkIChOmc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-prWvVjhsOIaCBDckY84f-g-1; Mon, 03 Nov 2025 08:50:19 -0500
X-MC-Unique: prWvVjhsOIaCBDckY84f-g-1
X-Mimecast-MFC-AGG-ID: prWvVjhsOIaCBDckY84f-g_1762177819
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-471168953bdso34397425e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 05:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762177818; x=1762782618; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DeCW7EBrUwZA713FmQXR6wEfB/uUnNKUpWTNflayAhw=;
        b=jSAsfMRYgXwwPF4pG5kdFNL4l2RsdQEngykvdnnWWkIGbKGO9pS4xJCZ4pLQM3vddB
         A2BfdEAiSFnaQiCCluQg36CR75nlzs/tKIDprmHS6aUgvzNE0DZyapkG0o8ww5ciEypV
         VYyPBTCmXSzM/q3fk3Hp8v/fc/MfoT5o669UtvI3bsHqajpUjauX0rD/Fws/kYuk5BXx
         Qh5gK3AXBUfDr6/dK/3Dv8EPcsH1Jxt5saog4wnEQRyue6kNSm1xXYWSOEKl5WTKa36D
         /3kC4bdc0/pme/+Y95eBrdKjjc8AyKSJx82xvOjjuHuC9QhZ/SHe6xMe9e8cFobBGCDs
         xhow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762177818; x=1762782618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DeCW7EBrUwZA713FmQXR6wEfB/uUnNKUpWTNflayAhw=;
        b=cwdtsmbH29gEsuy9xBYQ6k8DkUveoPRv4HYlf5BanVliBxlL8JbRWImL4sFZ4z390Y
         TvwRk/6qPI/yyFN+6xK1TvdlLhlY/0cEtX4vyAsxk+YXwGyCuCQKAuJLzu99csbN6ioE
         h7v90vEbXe6nGE69D/5XnJM3ymg07PgJ+df+n4DAFK/K3SXlN8zKqqFziSicOLQ948jI
         RKiJqAKTZBHGLT3yc/cjxKuK8BfPg7wCWxdVepKcyoG8mC04/xYREfNeNvTldU/G8BqE
         fl07gFee4e2U21r88WzxtCjjnXIJ/Afr68s8sMNifXfAmhBi84lmdNGcoKieFSgr2p0Z
         u2Pw==
X-Forwarded-Encrypted: i=1; AJvYcCVEx365s3dfgeJxfMw3XyvemMBOOPfufyuIb0AlvoebC8XFSFGHoC/kDreZMfjGUfjB5f3NPdhZbBhlzpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSLLEvlSdJF2+ADqpcyL6UH5dAzlBYaktcTkYAkyW4w+Ih0lMl
	lUq3+RfT4QTk0TSn6ZN4psYxmHgEW4FQX4P4DMxUdmvfqJVpKEfdzPzgXcVlVAd/ZE2/yhXCL3t
	tN9my3jI9+MamuWE2Gn8ZxIGTkdPTX/Hnl7JzPWb/qzhyJhcMyEdzddE2fW0OB0eKrQ==
X-Gm-Gg: ASbGnctqrtTNdeADoaJCUs26NeEIXRKOWjuv50H+Zsv6dz2tEugoiZQaziLWNaqlcCT
	jhdkKu18llgsMInWMl8nv8T6iCftour3de8cdMw/QoQCmd7bNnYCPyjvDcBbo8Oi+T12ZTLP6CW
	aPasnNZojoFzxOE9e2hkqJ3UZssEbejZVqllpLHxNcC3+UP6F2SE0F8Qs1LlYUoKZULzlnW9urh
	73DDcJBhZEC6pwAgysB7sePctuzYzDsosLyO0R/X58nqVB9V7u8VEzHDg58r3aRzdDpmzk+def3
	sEgFZZA+aX/H/yux7OAcdWM9HSrVZgnveUayvTs9j46Q0PIh1jAqN1bsMlrTeaoD3xnOzQRKvqn
	KBRszPYJavLCw3TZymhZeuFcgu80bhw==
X-Received: by 2002:a05:600c:600f:b0:477:3fcf:368c with SMTP id 5b1f17b1804b1-4773fcf392amr48151485e9.9.1762177818543;
        Mon, 03 Nov 2025 05:50:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHprfIQvR4JLgoHXRWh95iDbOYRS6dB1U8J8sEltQRqMZFbSOioWRJ4TfMwWwgGiqflgfqM6g==
X-Received: by 2002:a05:600c:600f:b0:477:3fcf:368c with SMTP id 5b1f17b1804b1-4773fcf392amr48151155e9.9.1762177818098;
        Mon, 03 Nov 2025 05:50:18 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.129.40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772fbc32d9sm90361805e9.1.2025.11.03.05.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 05:50:17 -0800 (PST)
Date: Mon, 3 Nov 2025 14:50:15 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <llong@redhat.com>
Cc: Pingfan Liu <piliu@redhat.com>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCHv4 2/2] sched/deadline: Walk up cpuset hierarchy to decide
 root domain when hot-unplug
Message-ID: <aQizF0hBnM_f1nQg@jlelli-thinkpadt14gen4.remote.csb>
References: <20251028034357.11055-1-piliu@redhat.com>
 <20251028034357.11055-2-piliu@redhat.com>
 <52252077-30cb-4a71-ba2a-1c4ecb36df37@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52252077-30cb-4a71-ba2a-1c4ecb36df37@redhat.com>

On 29/10/25 11:31, Waiman Long wrote:
> On 10/27/25 11:43 PM, Pingfan Liu wrote:

...

> > @@ -2891,16 +2893,32 @@ void dl_add_task_root_domain(struct task_struct *p)
> >   		return;
> >   	}
> > -	rq = __task_rq_lock(p, &rf);
> > -
> > +	/* prevent race among cpu hotplug, changing of partition_root_state */
> > +	lockdep_assert_cpus_held();
> > +	/*
> > +	 * If @p is in blocked state, task_cpu() may be not active. In that
> > +	 * case, rq->rd does not trace a correct root_domain. On the other hand,
> > +	 * @p must belong to an root_domain at any given time, which must have
> > +	 * active rq, whose rq->rd traces the valid root domain.
> > +	 */
> > +	cpuset_get_task_effective_cpus(p, &msk);
> > +	cpu = cpumask_first_and(cpu_active_mask, &msk);
> > +	/*
> > +	 * If a root domain reserves bandwidth for a DL task, the DL bandwidth
> > +	 * check prevents CPU hot removal from deactivating all CPUs in that
> > +	 * domain.
> > +	 */
> > +	BUG_ON(cpu >= nr_cpu_ids);
> > +	rq = cpu_rq(cpu);
> > +	/*
> > +	 * This point is under the protection of cpu_hotplug_lock. Hence
> > +	 * rq->rd is stable.
> > +	 */
> 
> So you trying to find a active sched domain with some dl bw to use for
> checking. I don't know enough about this dl bw checking code to know if it
> is valid or not. I will let Juri comment on that.

So, just to refresh my understanding of this issue, the task was
sleeping/blocked while the cpu it was running on before blocking has
been turned off. dl_add_task_root_domain() wrongly adds its bw
contribution to def_root_domain as it's where offline cpus are attached
to while off. We instead want to attach the sleeping task contribution
to the root domain that once comprised also the cpu it was running on
before blocking. Correct?

If that is the case, and assuming nobody touched the sleeping task
affinity (p->cpus_ptr), can't we just use another online cpu from
current task affinity to get to the right root domain? Somewhat similar
to what dl_task_offline_migration() is doing in the (!later_rq) case,
I'm thinking.


