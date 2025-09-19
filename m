Return-Path: <linux-kernel+bounces-824730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B41B8A028
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41DAC165CAF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839592EC08F;
	Fri, 19 Sep 2025 14:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R9zYO0Ce"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1DD34BA36
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758292666; cv=none; b=kdlN4Z/oqbSXAYPcswWVIqolocF8KmqomUq86XVGgYmtrmitM1AdjvGgH9s784e0cB64jpQWTy03GzFay7Sx7hBRLdMoVwfDvwyRQ4dc7VhV47Zw7XPd2sd21DSGXGv17+6Klk13uMUIGeWn9fhYkkd8rQyidb/YJi14EbIvFb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758292666; c=relaxed/simple;
	bh=qlehZ7AH3GZDRQFxoiCABVph2W4wtDeaFZ9z1O/STjw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ETQ9wnR5a6+kaE3i0a9w+0fwltM4tNlPoPHkJFs/TZS58rf8RuDpAyfndXk66or8HBa1BJDF7Yuf1EqWUmPE+s9F1iLww5lK2ctcortfBZjq6LOPIVSBsywZq6h/mufVV8MdPlniSuA/ZHiAuVUdpYRSMQ1Kq4Xw387cO5/4H00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R9zYO0Ce; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758292664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qlehZ7AH3GZDRQFxoiCABVph2W4wtDeaFZ9z1O/STjw=;
	b=R9zYO0CeTRPjanGW9f880H6R1qh3g1ZnvfDEDfAYwPQklaizTaWAhqwxg2wmn9gI+38RGu
	TDsItQfh/wUPnq8ncLuW/u5JiFsypDhxbPnq4i8ITvCS8QoEoEjSC0Uk4HO1TpIwbR8Cr3
	xdaijW8+lkdrN/pICVM50EPw86u+HYY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-wkrhlYMYOR2GM8hex9aW_A-1; Fri, 19 Sep 2025 10:37:40 -0400
X-MC-Unique: wkrhlYMYOR2GM8hex9aW_A-1
X-Mimecast-MFC-AGG-ID: wkrhlYMYOR2GM8hex9aW_A_1758292660
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45b98de0e34so20888195e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:37:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758292659; x=1758897459;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qlehZ7AH3GZDRQFxoiCABVph2W4wtDeaFZ9z1O/STjw=;
        b=AxP4uxQWJPgn8UuUcFZfEdeqpoCHXiOQ/b70EAlxmWUQxF6X9b4ow2SF+TJEtFig7G
         DFi5U3KM4G7vATmQWO19rKb9uVFaG2cRcGMpyK0pS9u8fB4r0Q541d7VMCHcwmXuiUgg
         aM0Hd+n8yYNiiFGUr85n7SGjrUmW/udLBzUzdfuPL6hMwg/zWUCYrZ1RqeMCobdyNIzx
         R0fY6AGkHKHujQe8X2slz+yZIs67Jl898BWddGppQLv6eTZkFSJUWFvJMjcyWLBe50ut
         nvEq2mDpiovihG17AaVpzT8X0ahjwHJ+Xzu76i4+utiXmy5hu/wOts0SmRnFeebDof6L
         27eg==
X-Gm-Message-State: AOJu0YwQNqVkG1R8GpT0Q9R7uHUTU8Tz+94mfbogKJ5c1W2+WhawSkP3
	g2eIMam29odeRLDVku2EZ2ZqNrfiZNwGs58e6zXJ1OUZTrkIIYtNIDar0pKt4La/s9DNZ0xbpVH
	eekN4gbhPVDIrAttm2lItUBGgbkqcsngNvMZ/Q6H6HLUkeg/OE3A0Yrjh/HskD8WmsA==
X-Gm-Gg: ASbGnct4pMqRxAhk9wcPnyHkSq42w1ShZvt1E/D7tgEdOEZLVHDyMXzHiY3UHKgzUmn
	krH6Y0I19e/1+oNS8CWwh4Z9Vtwc28F0/jCft6r6/ghrX5mtPHUugISF5ewChjB4npEPSvLw6Jh
	Nx1jnduFkxGIxdLOUs7XLj7HRqi7Xy4nkV6BxZEJ/h4bSSpsTC/WmDpJPPkNyYzuV0gAcAURZJG
	kEgHV5mhXe+aOUkdl1eA8WBE8a1hqifNAnf6Ui+d/72uqtb+QFBiGwdqenSC4wfDhHaXLW2IIZw
	lQsgyD5zjntW1+9Yt6DmDj2QxfbZvdhaTd8B3NG9tWQV9E4U90xS7lZGP4iMoBaJOXB/ww8y4Fp
	4YHFrUAS0TZL4tvSNRH8EbR8t
X-Received: by 2002:a05:600c:c4b8:b0:45d:e0d8:a0aa with SMTP id 5b1f17b1804b1-467ea004717mr38020825e9.17.1758292659481;
        Fri, 19 Sep 2025 07:37:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+vuRm+h/9o2Pg6/P0WdQN/kH+c4l4cHEQ4Pj/2rXVx3XmlUeCN1atOxw0Az1Dk5fo8ZI/xg==
X-Received: by 2002:a05:600c:c4b8:b0:45d:e0d8:a0aa with SMTP id 5b1f17b1804b1-467ea004717mr38020325e9.17.1758292658965;
        Fri, 19 Sep 2025 07:37:38 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f6695a9dsm91332845e9.24.2025.09.19.07.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 07:37:38 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Aaron Lu <ziqianlu@bytedance.com>, Ben Segall <bsegall@google.com>, K
 Prateek Nayak <kprateek.nayak@amd.com>, Peter Zijlstra
 <peterz@infradead.org>, Chengming Zhou <chengming.zhou@linux.dev>, Josh
 Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Xi Wang <xii@google.com>
Cc: linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
 <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>, Chuyi Zhou
 <zhouchuyi@bytedance.com>, Jan Kiszka <jan.kiszka@siemens.com>, Florian
 Bezdeka <florian.bezdeka@siemens.com>, Songtang Liu
 <liusongtang@bytedance.com>, Chen Yu <yu.c.chen@intel.com>, Matteo
 Martelli <matteo.martelli@codethink.co.uk>, Michal =?utf-8?Q?Koutn=C3=BD?=
 <mkoutny@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 0/4] Task based throttle follow ups
In-Reply-To: <20250910095044.278-1-ziqianlu@bytedance.com>
References: <20250910095044.278-1-ziqianlu@bytedance.com>
Date: Fri, 19 Sep 2025 16:37:37 +0200
Message-ID: <xhsmhzfaqwlse.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 10/09/25 17:50, Aaron Lu wrote:
> Peter noticed the inconsistency in load propagation for throttled cfs_rq
> and Ben pointed out several other places regarding throttled cfs_rq that
> could be no longer needed after task based throttle model.
>
> To ease discussing and reviewing, I've come up with this follow up
> series which implements the individual changes.
>
> Patch1 deals with load propagation. According to Peter and Prateek's
> discussion, previously, load propagation for throttled cfs_rq happened
> on unthrottle time but now with per-task throttle, it's no longer the
> case so load propagation should happen immediately or we could lose this
> propagated part.
>
> Patch2 made update_cfs_group() to continue function for cfs_rqs in
> throttled hierarchy so that cfs_rq's entity can get an up2date weight. I
> think this is mostly useful when a cfs_rq in throttled hierarchy still
> has tasks running and on tick/enqueue/dequeue, update_cfs_group() can
> update this cfs_rq's entity weight.
>
> Patch3 removed special treatment of tasks in throttled hierarchy,
> including: dequeue_entities(), check_preempt_wakeup_fair() and
> yield_task_to_fair().
>
> Patch4 inhibited load balancing to a throttled cfs_rq to make hackbench
> happy.
>
> I think patch1 is needed for correctness, patch2-4 is open for
> discussion as there are pros/cons doing things either way. Comments are
> welcome, thanks.
>
> BTW, I also noticed there is the task_is_throttled sched class callback
> and in fair, it is task_is_throttled_fair(). IIUC, it is used by core
> scheduling to find a matching cookie task to run on the sibling SMT CPU.
> For this reason, it doesn't seem very useful if we find it a task that
> is to be throttled so I kept the current implementation; but I guess
> this is also two folded if that to be throttled task is holding some
> kernel resources. Anyway, I didn't write a patch to change it in this
> series, but feel free to let me know if it should be changed.
>

I saw these already made it to tip/sched/core, but FWIW that all LGTM.

Reviewed-by: Valentin Schneider <vschneid@redhat.com>


