Return-Path: <linux-kernel+bounces-779363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C41B2F31F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6AE464E5B08
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D252728BAB1;
	Thu, 21 Aug 2025 09:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QIS+bk5z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5288284B33
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755766910; cv=none; b=l8YyEAgvJqwtpa6EmLqOUwNmGGk1sr3G7G7tN5gVxxU3sal45n2BeFKLrLffRAvdj/cj+upMEFqnkR+QK9rlUcL657qD+HawWoquC4TZN5HGXhW3srOZp3Wqn6Ph9CWH/e/aqiUg/+Q/qa1UJKFjyytBKtnwUbPugvl1fyqWVoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755766910; c=relaxed/simple;
	bh=jwugaut5sPAN8wxxkjmL3ZplSqfat/GP4DqjqZoMU60=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PUGjsj5pCqtpTRLm5KPUXkltdE3GGGd7pIgzt2uigJ+uzg+wDR4HN9IUxeOupMjqiVaaIzLTM8x0xLHmSd279DXMuGjKzx4pKm5gQ/NBDVnnqdxewZyBn8hLJb7CIlOslBGO8yJ9LHi6xmLysG/1ipyhWiyJ6Uh56SWjOD+6E+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QIS+bk5z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755766907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jwugaut5sPAN8wxxkjmL3ZplSqfat/GP4DqjqZoMU60=;
	b=QIS+bk5zz4nPLG5Kv0GFTLkJcZsE/VrgmEC3qABm643JgvGO3x52dvnyI63qzUCreNe1T5
	RAHjuSjYv+dsLLtOTw9EQ5/7SAB3uZL8bdCJ034fSWqocFCzaNC6cT7vzHE4/1fW/ux3+y
	2TnKQwmxS2uP9QtZdouqJ+a8023hde8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-OxGdiFjpP6GBidKXbAsnYA-1; Thu, 21 Aug 2025 05:01:46 -0400
X-MC-Unique: OxGdiFjpP6GBidKXbAsnYA-1
X-Mimecast-MFC-AGG-ID: OxGdiFjpP6GBidKXbAsnYA_1755766905
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70a928dc378so18357106d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 02:01:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755766905; x=1756371705;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jwugaut5sPAN8wxxkjmL3ZplSqfat/GP4DqjqZoMU60=;
        b=FVednOGfc1fmGSOfgwLJViUKflLLtsb9QxhBOdZdPajPDzqKwBEmtXFriwJT4ulBp+
         NWOFxvgU3Fk5YQi2JaTWizMdSUBx5eOeSbo/kAWNwuUngDdeyPf2zXHS7daAZiKOL/IU
         BOzf3C34+FvEUHCKxCfNTDeJI63b5LTcSwBgjiXlzitn87m/dgnKI8cvh8+lDV9Fow0S
         sKvrvws1gMiqByvgg5UNvrvv1IsOl0qr91IWJqL994RTwb+ith7HvUsdZSFUIW6ToeIm
         pNyAmpqvT6c5Mnln66UTNW1JkqanUU02J8l4ZcGXaquSYmqWavwFTHPIBpgZuH7V4YYH
         YL3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWyKTKZJk6A5RYYGmqgzuoyW8duG8fkSAcnEgG8y4j9R7XLio6JevglP/Ij4EDJ0m3yeLYaDzybiSYn2oM=@vger.kernel.org
X-Gm-Message-State: AOJu0YziK+ueqq9EtE1kF0u5CDkCKMyoCJjPndm9CGpVAvzZCTtcOcn9
	0zoBfkvu7rNVMQXoZUs15x/Wu2Gt74S/7vXlvJoN5OAshYFOgFVQ7vxozfYdPdOB1sNEkPz0oxw
	WiYQoNl25YuA638vDl9LXEaC5aOeqGRdqZuao97I9Vf+IK50B+2eu74RiS4ALfbFSiQ==
X-Gm-Gg: ASbGncvL5nT9q5/oDQ+u/CPQAJGRwgyF7p1HI18IfOjW8IO1d/rfw83v77Ac4RjruSM
	wAkrQ+FBIyhRgq6YRtxf/5eowq3MYrY8yld0Bq9KTX10gzLlXU8fOU5OGpA/jKxflgmmw0NRiFS
	TBF8G0EY53R+tJeAnrUPKxI9MjWdmn7ZjEZ1jeQLit0LZQ7H4Jec9KXpGMKaB4Rv0+Lv1+WSjnc
	AKXLTVKz0mTiQrCbKyrTharAibOsxAkRLiXivkqVAg8xQ7WcEWjuLOfkTeyjNo44ZLtPzhTHmdZ
	Ja6jVr7GUCPZ8F8wG8VWswhW+QQnVM7UoNeDQ3oFBfrorzxmdrj1I+tht9ss/CDCVyuklIgHIc1
	mVgXoiuVDZejxKDI3RfeO3F89
X-Received: by 2002:a05:6214:5087:b0:709:eddb:d1d4 with SMTP id 6a1803df08f44-70d88e2a4damr14881696d6.2.1755766904698;
        Thu, 21 Aug 2025 02:01:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3AB0V9LU6tuhjtCbsWPiJCa3UWop5/65VQ563hTQoaEWe07ygo0s6ALZGqx5uN/Q2En8t4Q==
X-Received: by 2002:a05:6214:5087:b0:709:eddb:d1d4 with SMTP id 6a1803df08f44-70d88e2a4damr14881346d6.2.1755766904151;
        Thu, 21 Aug 2025 02:01:44 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba9032801sm100373246d6.16.2025.08.21.02.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 02:01:43 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Adam Li <adamli@os.amperecomputing.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, frederic@kernel.org, linux-kernel@vger.kernel.org,
 patches@amperecomputing.com
Subject: Re: [PATCH] sched/nohz: Fix NOHZ imbalance by adding options for
 ILB CPU
In-Reply-To: <f6869880-1f7c-a39b-dc8e-4c3a84ba51ef@gentwo.org>
References: <20250819025720.14794-1-adamli@os.amperecomputing.com>
 <xhsmhtt23h0nw.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <7438bb3a-96d6-485a-9ecc-63829db74b39@os.amperecomputing.com>
 <xhsmho6sagz7p.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <f6869880-1f7c-a39b-dc8e-4c3a84ba51ef@gentwo.org>
Date: Thu, 21 Aug 2025 11:01:40 +0200
Message-ID: <xhsmhikihgia3.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 20/08/25 10:31, Christoph Lameter (Ampere) wrote:
> On Wed, 20 Aug 2025, Valentin Schneider wrote:
>
>> My first question would be: is NOHZ_FULL really right for your workload?
>
> Yes performance is improved. AI workloads are like HPC workloads in that
> they need to do compute and then rendezvous for data exchange. Variations
> in the runtime due to timer ticks cause idle periods where the rendezvous
> cannot be completed because some cpus are delayed.
>
> The more frequent rendezvous can be performed the better the performance
> numbers will be.

[...]

> The benchmarks show a regression of 10-20% if the tick is operational.
> The context switch overhead is negligible since the cpus are doing compute
> and not system calls.
>

Ah good, that's useful information, thanks!

>> As for the actual balancing, yeah if you have idle NOHZ_FULL CPUs they
>> won't do the periodic balance; the residual 1Hz remote tick doesn't do that
>> either. But they should still do the newidle balance to pull work before
>> going tickless idle, and wakeup balance should help as well, albeit that
>> also depends on your topology.
>
> That should work in general and not depend on any hardware topology. In
> this case we have a linear sched domain including all processors.

Wakeup balance not so much, select_idle_sibling() won't move tasks outside
of the waker's LLC - but AIUI in your case you have just a single node and
I'm assuming one big LLC.


