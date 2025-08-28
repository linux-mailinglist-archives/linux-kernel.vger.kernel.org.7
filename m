Return-Path: <linux-kernel+bounces-789789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 150B9B39AB6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C407216C1D8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF52430C63F;
	Thu, 28 Aug 2025 10:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CGUnR6hv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6098917A2E3
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 10:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756378577; cv=none; b=TPoM09KipBLiT4oihHC4bRmbiXFklmcDjxXl4ppXT8ydcFn+zELAyVHQ0EROfI8RzKdgHIn4BAFtK16BH2iXRKWR4FW+VgvDZ7hzjFdB8yxtvNxLgwQdCby1mkY4GtcZ00LZupCo7CV16vX4yf350XNGypuChtiX4/sD87MDQBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756378577; c=relaxed/simple;
	bh=4wOmcCCaAf0POaGYMVyz6T+bHVQ7IulZjGJTwjLHJQk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NfuEflFdhZgBw/SQPVLcFNdkWJxF2Zy3qV5JPMBD9qVSWbiElgLTQx0njZPU/02h6/detAFnOiYXsuiL7Ofx5bMMvOvoTyPyzwokbFuQ6soqTmbQ1uxCRHzBJEd+VuBHcgDW3rBaw5OSEl5ivn+o3CtFVgRV39/kaU8blGsKqdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CGUnR6hv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756378574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4wOmcCCaAf0POaGYMVyz6T+bHVQ7IulZjGJTwjLHJQk=;
	b=CGUnR6hv/rfWxSAgXaPiiw2wHqvZCr5ALzfpRzumAqtu54xaBEgVkIjyY/KfK7GvcLeCNI
	/eS90LEBoDek4g6pr40RhcnQdkg//xLV+ktIyae9QR25m2ImkBxPw0RKBNqNY/KNyDc2Wd
	i95mEw3UDLRtR/rSKAiiELWvwa+55M4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-WWZZeKgqNTG0l7WxR7a_Iw-1; Thu, 28 Aug 2025 06:56:13 -0400
X-MC-Unique: WWZZeKgqNTG0l7WxR7a_Iw-1
X-Mimecast-MFC-AGG-ID: WWZZeKgqNTG0l7WxR7a_Iw_1756378572
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e86499748cso525081385a.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 03:56:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756378572; x=1756983372;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4wOmcCCaAf0POaGYMVyz6T+bHVQ7IulZjGJTwjLHJQk=;
        b=qyo2dQzhmrZjSSULA+FUYL+B1EspxBIfxImf/QV8rrKyoATndBmaMhr97hftX0csXW
         qS6CcOaok5j3Rd7f96v+Kf4wmKJyT58VZ939qBGSIyKg04Bie8JQWf8xlNr/GPyvpqHW
         CZSA7GlHPlxxviRWOlbTtUsjGolUPVHw3HesR+CXpFxgTUhihzXeLsI255N9oqF1QqJc
         lZ0pMUXSS8bcfEh64cfBfPYd5InNudPnWT2ylPZ7Z1qgt2e/Gp/8nG/kT5xB29Xi8jO8
         cCZlP7/okD4OalQHBhPpEotW7M3PXF0F8lCLLFemVQZY0K6ojiTq/OZWXsNg/AGBPL1l
         W5+w==
X-Forwarded-Encrypted: i=1; AJvYcCUTKbSshu39xfgFce3fcVqp8FDr1VmEMg8pR7Fli06+fsbhfCmOOp+YTY2Swwsb8YGpujGuZpKkF+iMBJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV2yOchzAexDe29t6EmNrlQSmg3R1CjnUScThuXNGso+EiqK9/
	pTYQAmLKxXJu951gWAopkb65vL4dFK+YINzU6NStnKU50aQ4LZVoy39wNoZCWFCdmCHQ3zkO/U0
	9rYLXn7tOLC91JAw0bWYJ55KL8PJpD+WEQCeYwqat6qD2igrmK6sNeTDRmO9aqBReew==
X-Gm-Gg: ASbGncuFSgUffJJQcsbY6mfmlETugSmyVJpgU8jnH/6CDfG48J14qFG49IhHrOyF7YF
	4dHDItfIv4XGuEqQ2KbIOI5bWtPGVIqyY1TFwkiSSxPCmuKSgN39vGMJmPC1NzV2BZ4e6nW+aap
	AUhcsRvqiwaNF8gvwOkxEOAOzCO04mEDi6lu0gWDsLBC+KRcpleN65WFsa+Y++2/WdSUdSNF+gO
	lORgbKVu+iTN1o9TCyNwW2E3Y1A3aFOdNEB3xozhi3E/74F8dBkQiX4MR9E0Woa5BwHqSqzJ0mX
	YsmWRXKNcO60AkkU+TyL8WOk/A58wolC36Ml9JHp0AIBe5laUpPBqiUARB4K8NS6msqHzwkKmfm
	iMFbX3A9d3cbWAFyE8KvZPsUV
X-Received: by 2002:a05:620a:7013:b0:7e8:7a7b:5723 with SMTP id af79cd13be357-7f58d942121mr801499785a.22.1756378572518;
        Thu, 28 Aug 2025 03:56:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0sTQPoxTYjD2KkkPBUEn3tiRUVWYtIRO2Cq3OjI4bFTMshNKLd9LG2MMXO9k3YwLD4oK9ww==
X-Received: by 2002:a05:620a:7013:b0:7e8:7a7b:5723 with SMTP id af79cd13be357-7f58d942121mr801496585a.22.1756378571946;
        Thu, 28 Aug 2025 03:56:11 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ebf41792dcsm1070250885a.71.2025.08.28.03.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 03:56:11 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Adam Li <adamli@os.amperecomputing.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org
Cc: dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, cl@linux.com, frederic@kernel.org,
 linux-kernel@vger.kernel.org, patches@amperecomputing.com
Subject: Re: [PATCH] sched/nohz: Fix NOHZ imbalance by adding options for
 ILB CPU
In-Reply-To: <1db2d6df-16ff-4521-ada5-da585b87b06f@os.amperecomputing.com>
References: <20250819025720.14794-1-adamli@os.amperecomputing.com>
 <xhsmhtt23h0nw.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <7438bb3a-96d6-485a-9ecc-63829db74b39@os.amperecomputing.com>
 <xhsmho6sagz7p.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <d421a5ba-95cb-42fb-a376-1e04c9d6a1ac@os.amperecomputing.com>
 <xhsmhldnegqq4.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <1db2d6df-16ff-4521-ada5-da585b87b06f@os.amperecomputing.com>
Date: Thu, 28 Aug 2025 12:56:08 +0200
Message-ID: <xhsmhfrdblnp3.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 21/08/25 19:18, Adam Li wrote:
> On 8/20/2025 7:46 PM, Valentin Schneider wrote:
>> Right. So other than the NO_HZ_FULL vs NO_HZ_IDLE considerations above, you
>> could manually affine the threads of the workload. Depending on how much
>> control you have over how many threads it spawn, you could either pin on
>> thread per CPU, or just spawn the workload into a cpuset covering the
>> NO_HZ_FULL CPUs.
>>
>
> Yes, binding the threads to CPU can work around the performance
> issue caused by load imbalance. Should we document that 'nohz_full' may cause
> the scheduler load balancing not working well and CPU affinity is preferred?
>

Yeah I guess we could highlight that.

I think it's kind of a gray area; technically we could change load
balancing to make NO_HZ_FULL CPUs better at pulling tasks, but that only
works up to the point where, if you have N NO_HZ_FULL CPUs, you have pulled
N tasks. So there is an underlying assumption that the workload threading
matches your NO_HZ_FULL topology; and if that's the case, you might as well
affine the tasks by hand and avoid any surprises.

Put in another way: yes we can probably make load balancing better
for NO_HZ_FULL CPUs, but that only really works if we have one task to pull
per NO_HZ_FULL CPU, in which case manual affinity binding works just as
well, and I prefer that approach since it means we don't have to add a
NO_HZ_FULL load balancing logic which may end up interfering with
NO_HZ_FULL itself. At least, that is my opinion.

>> Having the scheduler do the balancing is bit of a precarious
>> situation. Your single housekeeping CPU is pretty much going to be always
>> running things, does it make sense to have it run the NOHZ idle balance
>> when there are available idle NOHZ_FULL CPUs? And in the same sense, does
>> it make sense to disturb an idle NOHZ_FULL CPU to get it to spread load on
>> other NOHZ_FULL CPUs? Admins that manually affine their threads will
>> probably say no.
>>
>
> I think when the NOHZ_FULL CPU is added to nohz.idle_cpus_mask and
> its tick is stopped, the CPU is 'very' idle. We can safely assign some work to it.
>
>> 9b019acb72e4 ("sched/nohz: Run NOHZ idle load balancer on HK_FLAG_MISC CPUs")
>> also mentions SMT being an issue.
>>
>
> From the commit message of 9b019acb72e4:
> "The problem was observed with increased jitter on an application
> running on CPU0, caused by NOHZ idle load balancing being run on
> CPU1 (an SMT sibling)."
>
> Can we say if *no* SMT, it is safe to run NOHZ idle load balancing
> on CPU in nohz.idle_cpus_mask? My patch checks '!sched_smt_active()' when
> searching from nohz.idle_cpus_mask.
>

I suppose we could still make this work for SMT with e.g. is_core_idle(),
but see my point above.

> Thanks,
> -adam


