Return-Path: <linux-kernel+bounces-788557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD76B3865D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBCDC98415B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C0F2749E2;
	Wed, 27 Aug 2025 15:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Az4gRDNC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBCF27FD5D
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 15:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756307792; cv=none; b=SRinh4UVYIUPJ7oWn/mprev4LbMuCscdaS1yphcWg6qZc3c4o70LTaI5MxkAeDfOwCwUHnhN8HdH/DrQvZ/eeSdnVoqlx4PBQxeZMQPkLbk0to//6DkacydSSg93LK64hq3xfJE6OYieiTONUh1eZqZCX0H7SPaoaPE0lDDDzao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756307792; c=relaxed/simple;
	bh=wZ+bwOJpQxI9Tze06XtG+N15eOiS0Q81ytrRTouxzWE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bsZPQgBoNr8E4I2sthv0o1mbqj3K2DF5m6fIO6ePaMWMi9u2iZpT7Qc5pqSA1KEnguPYZZlQqImeBuHEzuJ8cakZhYxj2LqamY5ZX1Pea/AS4ytGPKdgt6BdU4j337fcG+4Uzw5m2tXzXBVcqpOTmrcdCPy77zgNwQilV3K0bRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Az4gRDNC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756307789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=imIf6RzY7hAhYgovS6Iof1LvghCiP7y7dj/G/jXCBLs=;
	b=Az4gRDNCBEem4I2PtCYgQTVqOyueuB0y08HziEAqAovjVyybet+9Z8nGUL9UmcJ6X52XQI
	q7GodT2sQ5hIQAgitbCGD28C9c1QawBvr83487FqL3LbOMQfaZ8jl6XcZRdN7OVKPpQ3iH
	BfPuhc+sDWoQIdHN6OBobLnBulHT24U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-oLaUAu4ePBWrZwrZVbM0XA-1; Wed, 27 Aug 2025 11:16:28 -0400
X-MC-Unique: oLaUAu4ePBWrZwrZVbM0XA-1
X-Mimecast-MFC-AGG-ID: oLaUAu4ePBWrZwrZVbM0XA_1756307787
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45a1b05d8d0so48734585e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 08:16:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756307787; x=1756912587;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imIf6RzY7hAhYgovS6Iof1LvghCiP7y7dj/G/jXCBLs=;
        b=vFJabZemJh/ulw0qnv7hO//MjAOUHzYA5aIqOcllpszNS6DgoTrWfaCEDLr+eiaR0D
         iwXbJLbzI+vPMDGS1BW6Xdm1AQELnK8s+3ZyO8SNXxq9TDQqJ6mJB50SH5f8UEmCOBjd
         vqQSntxHgjyvuvFEHrSS/ewL9iZLU4xAIK5SdL6ioDb4WsohwwV8H6K1Fc7gMWS7xtEp
         VAuWy6qbQhZNUfzs6P++0pgo4u7ZWcAboQCcBBMPvI9pRaH3XBQ8iwpY5IOhMR8JKdxg
         XhQwQi/COMf1BLAGf35zwigHfSniGkdSiykFTkiE63RBSSQC1RQ/6eEcqlk7HlcnOjiy
         VRIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHqMsuKX7SJV+AaCQlaRzVNQ83+EUPdM8Ggm5Ag/zmWEJAaa1rVU30/ayqIjoJ6o2MxbUBf7iTUZB5VuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YysJ7VlHhjhBN66gqGqJsDiGi9Dr1EubL51s4a6JE4l42ZaM3mu
	rC1skZgj0plYGEqGrFE6MzfpRIXm5g7g62dtf1CAVQyVAsz31+N9pxqSE3c7sc7DkJ0UM82iuqa
	2kziLrW4nGhGVC7kvRwyg31F/2Sa9lgRJLALRgCirrcB2K+0RzknysYr9WVHxliLf3A==
X-Gm-Gg: ASbGncui3ix8i5RPAQ0qGrcJxk7YnNLMSRGOVwLNX71bNDM82cy8t/l/U6t2EM4abHU
	8LGf0gb3QsA9Y5Ephgy1zB8X13qBWypzPbddB3DNTSBT8KOaOCTG04Y6fDJIF2UFvgL3+IyAXLd
	n/93A4sULTeqH78lNxdBeYa2pX1ZK6zWLKAr5oIk57R8eeaUkXKwyB3Rgr0gDSP7KPiSP7VesmZ
	Sw7Mcrl8ZypGJcaIeEt5r8sj4JjtGuLyABVKYR7rBoR4if6o+5EQDyod2w066Tc2Ga3MzKw2F4a
	491HBBZW1bqhD4l5ljWaIXk5oS92SgVaNKWTji5mIi/6yxK5+7WiQjXC+f84xIgnE4qQLSAKVO+
	HjM26HtU6c4ILjD+afxUINPwQ
X-Received: by 2002:a05:6000:430d:b0:3cb:46fc:8eaa with SMTP id ffacd0b85a97d-3cb46fc8fe4mr5753646f8f.31.1756307786815;
        Wed, 27 Aug 2025 08:16:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyvMK+M7e2Xw//rir10/NPKq9s7nd6+EFamXp8genZqqejzStqxle2mu6EzM/YI9h9a7m2mA==
X-Received: by 2002:a05:6000:430d:b0:3cb:46fc:8eaa with SMTP id ffacd0b85a97d-3cb46fc8fe4mr5753624f8f.31.1756307786299;
        Wed, 27 Aug 2025 08:16:26 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cd8bb9ee97sm498259f8f.27.2025.08.27.08.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 08:16:25 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Aaron Lu
 <ziqianlu@bytedance.com>
Cc: Ben Segall <bsegall@google.com>, K Prateek Nayak
 <kprateek.nayak@amd.com>, Peter Zijlstra <peterz@infradead.org>, Chengming
 Zhou <chengming.zhou@linux.dev>, Josh Don <joshdon@google.com>, Ingo
 Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Xi Wang <xii@google.com>, linux-kernel@vger.kernel.org, Juri Lelli
 <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>, Chuyi
 Zhou <zhouchuyi@bytedance.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>, Songtang Liu
 <liusongtang@bytedance.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 4/5] sched/fair: Task based throttle time accounting
In-Reply-To: <u2ri72fqvzlyvwxmaez3l6mbgtkvzmg36ylzc4k2qhvjcdiup5@7ogshyljqoot>
References: <20250715071658.267-1-ziqianlu@bytedance.com>
 <20250715071658.267-5-ziqianlu@bytedance.com>
 <xhsmhbjociso8.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20250819093427.GC38@bytedance>
 <u2ri72fqvzlyvwxmaez3l6mbgtkvzmg36ylzc4k2qhvjcdiup5@7ogshyljqoot>
Date: Wed, 27 Aug 2025 17:16:24 +0200
Message-ID: <xhsmhiki8lrqv.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 26/08/25 16:10, Michal Koutn=C3=BD wrote:
> Hello.
>
> On Tue, Aug 19, 2025 at 05:34:27PM +0800, Aaron Lu <ziqianlu@bytedance.co=
m> wrote:
>> Got it, does the below added words make this clear?
>>
>>     With task based throttle model, the previous way to check cfs_rq's
>>     nr_queued to decide if throttled time should be accounted doesn't wo=
rk
>>     as expected, e.g. when a cfs_rq which has a single task is throttled,
>>     that task could later block in kernel mode instead of being dequeued=
 on
>>     limbo list and account this as throttled time is not accurate.
>>
>>     Rework throttle time accounting for a cfs_rq as follows:
>>     - start accounting when the first task gets throttled in its hierarc=
hy;
>>     - stop accounting on unthrottle.
>>
>>     Note that there will be a time gap between when a cfs_rq is throttled
>>     and when a task in its hierarchy is actually throttled. This account=
ing
>>     mechanism only started accounting in the latter case.
>
> Do I understand it correctly that this rework doesn't change the
> cumulative amount of throttled_time in cpu.stat.local but the value gets
> updated only later?
>

No, so currently when a cfs_rq runs out of quota, all of its tasks
instantly get throttled, synchronously with that we record the time at
which it got throttled and use that to report how long it was throttled
(cpu.stat.local).

What this is doing is separating running out of quota and actually
throttling the tasks. When a cfs_rq runs out of quota, we "mark" its tasks
to throttle themselves whenever they next exit the kernel. We record the
throttled time (cpu.stat.local) as the time between the first
to-be-throttled task exiting the kernel and the unthrottle/quota
replenishment.

IOW, this is inducing a (short) delay between a cfs_rq running out of quota
and we starting to account for its cumulative throttled time.

Hopefully that was somewhat clear.

> I'd say such little shifts are OK [1]. What should be avoided is
> changing the semantics so that throttled_time time would scale with the
> number of tasks inside the cgroup (assuming a single cfs_rq, i.e. number
> of tasks on the cfs_rq).
>

Yeah that's fine we don't do that.


