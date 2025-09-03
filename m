Return-Path: <linux-kernel+bounces-798521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0779B41F25
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61E461BA2DC8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559672F616A;
	Wed,  3 Sep 2025 12:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ACFeqGac"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279223C01
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 12:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756902910; cv=none; b=VG+czGVw1j8MYCGRdAsP4hHjVWfAco1xoITcnuDgoVGuF/2d6cfh3z2k9vjpR+lGtoIjIyiLaps/5KHKxYtFAB80ekQlS6XLYAk3nrl1MvM3eK3NaXhbwlF4XqPtJh6ZBAHgIbGDQLK9hMayMXnJ1i1p0xQ4j9YvJ+uBGlUWhps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756902910; c=relaxed/simple;
	bh=2KH/JQ/vqtUTuVCclkQ8P86bxXvO3EGosKw4NB/N1Ao=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L7CMrOgcNEfkQar2fYMyaeguNvBCpFCu/xUDqPmiVqxl4cscxzckphD/59/++mMLbZmisu7MtsuI+KWONaxGw5EoUhQVNbuOZZL87dWX2c2W+gmkSzRz0uTOhosx+Y3U2YB63JM1OHsnaaVMREWEgKsAq4Hu6JU2BH6BcGmX2MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ACFeqGac; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756902908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kn9E43Lx4Cfno8vwxAsFxV0RgKs1y/Qo+4mjLYx22d4=;
	b=ACFeqGacEm/sJdOCBrKKEV51nZGOGcmAKO+JvVuMxoS6X5pwnyx2qxx9g8/tjJt3ts7rT+
	t5c10wFKGnhj3EAq2gS3dBDnfkIULD2BGG4hIcn6GZcpYcDic2HcSoVcUPh48K8mZImOpU
	PYESRneX7UAaz4W0ZejQGw5elKkVG0I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-3tof4e7mOB-tbCbQkPqANw-1; Wed, 03 Sep 2025 08:35:06 -0400
X-MC-Unique: 3tof4e7mOB-tbCbQkPqANw-1
X-Mimecast-MFC-AGG-ID: 3tof4e7mOB-tbCbQkPqANw_1756902905
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b8af0b986so6983745e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 05:35:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756902905; x=1757507705;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kn9E43Lx4Cfno8vwxAsFxV0RgKs1y/Qo+4mjLYx22d4=;
        b=ebDf6DtRC1SHeCywwwQvBITjYpcAJ3AdjghV4ix20ez5qF5TZFhUZvwbnpYQy0KyIp
         EsQOGyy6/mLVLjLxhOV/6MfY25zMOwAq6BaAZNCvDmUNDjXafYLivBbnz7iHbJU4mLL1
         p7Js8TPtogapEQB6o1N0Gd9Ga+3/QYHG5IVOyiZuBVU/VPDZEBBQT+9qMymt+b5jwekp
         mSEmzstx5lBYTA3K/Xqh8iS7hW5cTWE54Yt6cajRXOSXU0f6Y+4qKbjVvlamrQUXcx+0
         9heisnxBS96a3FQNVRR3VYM2YyybEXvb1p3HGkuVuBI66yP7mvh0zSwVHNluPlBBWu1j
         BBDg==
X-Forwarded-Encrypted: i=1; AJvYcCWYUrBgg+6boyGXRtdg6sn0AyatqvD569dWglKZojIZ8tdQmoPChij6oULKsvmwN9IYnZ75duyoKo8QgvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNJOoU8EQ0WzHexpm3oll7+85f8dkfyAR/CVEff2gpMONjYDrn
	sDiPdVYQAAs4rWil/qC91NUQ0Tvajau33FZhxcX0sI4WXM2I2DnWge+1+ZWdyelr14uyPtFQk5W
	PexYqcZ5/6UEaUto0GkZ+cQXD+FxZtwVwLE7uSzil/FtSF7ZfFs/aWXKTS/x3wCCZjA==
X-Gm-Gg: ASbGncuHqi4Q27K7xSRmOxIWJkcujMPzpiWuA7GLADHz+LbrX/E0QyGfNlzZzljoJXU
	5uHEQSmQuZypJNU83OxHN1aMzbEpw5vnK3uOclQS7JIoqWuT1iijVBozMr4cQ/S2h1k3v+xpq45
	jFjy0rC4wr8rA7nNr5okmOF+UsIBTS3VC6ByI/cPOhp+NUfRLdOl60Cl3TrR2zaLwvWyaQNV2DJ
	4QdxXNGDjpuiRagstH37nyv5NMMZ/Zdp/EmBqocVjgqMX68ulR2aT/2Tp6+fK/5r3Iur3cWSG09
	cSS2a1PAbmdRm1+v6dtGDxk9fZJCbdzRJzHgJypnF19L32NnVfMhbNpE3h8Lw23WSCLauyEDGaG
	t3+XgSQ0n42vDAReDM7QL9f6S
X-Received: by 2002:a05:600c:5247:b0:45b:910c:adf with SMTP id 5b1f17b1804b1-45b910c0ba0mr64460785e9.12.1756902905376;
        Wed, 03 Sep 2025 05:35:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4pvRcnWLyJxgCu4zwj3WAp3ebw/VtQ9Vb0SgglYp4db0eA6X7i+c7TZCYs6m0w3klftuXPg==
X-Received: by 2002:a05:600c:5247:b0:45b:910c:adf with SMTP id 5b1f17b1804b1-45b910c0ba0mr64460485e9.12.1756902904947;
        Wed, 03 Sep 2025 05:35:04 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45cb5693921sm31840525e9.0.2025.09.03.05.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 05:35:03 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Adam Li <adamli@os.amperecomputing.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, frederic@kernel.org, linux-kernel@vger.kernel.org,
 patches@amperecomputing.com
Subject: Re: [PATCH] sched/nohz: Fix NOHZ imbalance by adding options for
 ILB CPU
In-Reply-To: <916176fe-ad43-9dd2-ed1c-6f05f838d491@gentwo.org>
References: <20250819025720.14794-1-adamli@os.amperecomputing.com>
 <xhsmhtt23h0nw.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <7438bb3a-96d6-485a-9ecc-63829db74b39@os.amperecomputing.com>
 <xhsmho6sagz7p.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <d421a5ba-95cb-42fb-a376-1e04c9d6a1ac@os.amperecomputing.com>
 <xhsmhldnegqq4.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <1db2d6df-16ff-4521-ada5-da585b87b06f@os.amperecomputing.com>
 <xhsmhfrdblnp3.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <916176fe-ad43-9dd2-ed1c-6f05f838d491@gentwo.org>
Date: Wed, 03 Sep 2025 14:35:02 +0200
Message-ID: <xhsmh4itjlnnt.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 28/08/25 08:44, Christoph Lameter (Ampere) wrote:
> On Thu, 28 Aug 2025, Valentin Schneider wrote:
>
>> > Yes, binding the threads to CPU can work around the performance
>> > issue caused by load imbalance. Should we document that 'nohz_full' may cause
>> > the scheduler load balancing not working well and CPU affinity is preferred?
>> >
>>
>> Yeah I guess we could highlight that.
>
> We need to make sure that the idle cpus are used when available and
> needed. Otherwise the scheduler is buggy.
>
> Such a load balancing action means that there is a cpu that is running
> multiple processes. Therefore the timer interrrupt and the scheduler
> processing is active on at least one cpu. We can therefore do something
> about the situation.
>
> The scheduler needs to move one of the processes onto the idle cpu.

AFAICT we have (at least) two options:
1) Trigger NOHZ balancing on a busy housekeeping CPU (what this patch does)

   This is somewhat against idle load balancing rules (only spend CPU time
   on that if there is no "genuine" work to run), but I guess from a CPU
   isolation PoV this can be tallied as just another housekeeping activity

2) Trigger NOHZ balancing on an idle NOHZ_FULL CPU

   That doesn't steal useful CPU time, but that also potentially causes
   interference, albeit only if racing with the NOHZ_FULL workload spawning
   (which shouldn't be the steady state).

The more I think about it the more I'm leaning towards 1), but I'd like
other folks' opinion.


