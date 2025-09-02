Return-Path: <linux-kernel+bounces-797228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84550B40DB3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 21:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43871543FE6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA0834DCDB;
	Tue,  2 Sep 2025 19:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UFQYUEh7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CE82D593A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 19:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756840331; cv=none; b=kFwwvFT6VPfckOfnmY+GXjm0L5unUVRTLB7FpbQpQuTW48j9JO0EXlM23PeOf1V5usLxKpPvJCab79yy+KmDs+AdoO66TxezrgQmQ0jVFFOqv3vfGQBlyOMJV4unsyXFpbd8P9HWCa3KY+6QoqqdWtQRm7K6qf3CCRaZT502F8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756840331; c=relaxed/simple;
	bh=dVmX+mO4WA+/5NAlvy0aPnl/QX9ZML/ebE57voGkdpA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LFsH98U26YmY2ERHzI5r0umurZd/nggtx8QLT6gz275gHeb3FFhsrVkwRGqifCtN8lTwEmhpkKhyb0LXi9A5odgsAEZHnuyKcDr51Kc+KajdAQUgCdUuWampcz/QOc9S6yxjUFN7OnLRhad4C7b8LO1b2HkvcLvN50Roq6DNRy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UFQYUEh7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756840328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lEU2O8HX0DE1HyuvyftpTVeXKhmvAwu3017CZ7Qr7Gc=;
	b=UFQYUEh74zaX/hoBi2uTx0W6EKl13xjLPBQOlnxpWYPIBTlVe2zDNHIb30Ojwh1gCrDdBm
	vtAh82UcmE3D7nzkjNE09/EGA1p4IGUO97m3ed5158mbV/68CltdPle3F0+MGdP67t2D5Q
	8m0BKx819KzfqbHgj8nEQ3Jk/Hq3DKs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-JoiApgH9Mb-pj9Cqy8aMuA-1; Tue, 02 Sep 2025 15:12:07 -0400
X-MC-Unique: JoiApgH9Mb-pj9Cqy8aMuA-1
X-Mimecast-MFC-AGG-ID: JoiApgH9Mb-pj9Cqy8aMuA_1756840327
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e86499748cso47413885a.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 12:12:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756840326; x=1757445126;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lEU2O8HX0DE1HyuvyftpTVeXKhmvAwu3017CZ7Qr7Gc=;
        b=xA05TjjrH3z7CYDpghDwaJgSBZEV3i+IkxRRb006lmj/jf9iUUdoXmQr4Zab0R75o5
         Wri5V1pHdXzn9Sb2ixwOmvCFvXn8/5eJYY3XOP00drfOTixeT7ULWhSgXvynPYJlmaVM
         va8noBj3tfF0kxrZAPYXZbcgKwfzGFPIvNhGB7309sZjZl92rb2NXfJbPbZ/xvGhWwS6
         JFuT6uaqQuhGjBBedoYMS3ev2R0hKt/xeJ6vgkiBEl/kpj+un/3moaYA3vlq+0SCOJQW
         20jHztgt70cPUsM2wUrqUoTRYkVmY3oseh8N2d8/OtJXkyTah2WTZs9w0X6B+Vta0O8b
         MpvQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8zKHi9lzeZRMjsMzvUhKylYlhJjHQixa7O0iYIIcujddAUjqdVSTlHrr9wU1fE7ErEp4p6bxOCDrAnDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbepGRy1/bcTmEQYcJhLHv4Ps8DbJYJCyrNmfyfwfallk3rj6u
	eu6GTudSoeDMfAC8nXCXmfFgflHdMAe5DcptLYorCd+8/eDAu/BUf9UML938ixBRTuE+0pqvEHb
	tc7yWX2yfZOkQBicRHi/MSNzmFun6zbpNeUG7I6GMLqRRhZyUq2L2UY4eQg1Wcp6nnJpJNU7QCg
	==
X-Gm-Gg: ASbGncsnHtPJdGdsME5jBbYnQIgPWlV5Z4iXjTpJWx/EiRSDHDcXiOB8td0zt8bpr0d
	ehBg+Qcbno19COQQZUeBLzcEQUyAyceUgpbqriF7XPSC+Fm2CGterwcHrx10qzRwEXtHf9ZmieN
	G1SbG5c9T2lw10zcQfFfK5mjlWmWnnm+xP3ajRuDujYZIHsyRsCJrTGlzh3WiV/DlSjwQ5HAZR4
	F05rpJxu+O6edV7FM85+7NoJXSQZrRrZpkHw6RQ9yxYZMlLTmi4t70vaMjTWYT5EQOgmiXb0hb5
	n392/gBVtkNnyra59d+SgokFmP8CL2MKmdHZ/FMQYvMSlXNJ3VI1+huKxSNJ276sxH4I7aLMpvF
	iReOKp9HJsA==
X-Received: by 2002:a05:620a:190d:b0:7f1:3603:9a7f with SMTP id af79cd13be357-7fed6bab872mr1409516385a.34.1756840326018;
        Tue, 02 Sep 2025 12:12:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDJawudQpCAGbM3138pmz5MmcUf77R8N1mU19Tp1L470L3YjI91/pWzvjjhurW/Qxmd3i9dg==
X-Received: by 2002:a05:620a:190d:b0:7f1:3603:9a7f with SMTP id af79cd13be357-7fed6bab872mr1409513685a.34.1756840325640;
        Tue, 02 Sep 2025 12:12:05 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8069c1531ccsm179008985a.39.2025.09.02.12.12.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 12:12:05 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <99f02e8d-7cb8-4190-ac0c-343b1e9fb735@redhat.com>
Date: Tue, 2 Sep 2025 15:12:04 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/33 v2] cpuset/isolation: Honour kthreads preferred
 affinity
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
 Marco Crivellari <marco.crivellari@suse.com>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>
References: <20250829154814.47015-1-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20250829154814.47015-1-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/29/25 11:47 AM, Frederic Weisbecker wrote:
> Hi,
>
> The kthread code was enhanced lately to provide an infrastructure which
> manages the preferred affinity of unbound kthreads (node or custom
> cpumask) against housekeeping constraints and CPU hotplug events.
>
> One crucial missing piece is cpuset: when an isolated partition is
> created, deleted, or its CPUs updated, all the unbound kthreads in the
> top cpuset are affine to _all_ the non-isolated CPUs, possibly breaking
> their preferred affinity along the way
>
> Solve this with performing the kthreads affinity update from cpuset to
> the kthreads consolidated relevant code instead so that preferred
> affinities are honoured.
>
> The dispatch of the new cpumasks to workqueues and kthreads is performed
> by housekeeping, as per the nice Tejun's suggestion.
>
> As a welcome side effect, HK_TYPE_DOMAIN then integrates both the set
> from isolcpus= and cpuset isolated partitions. Housekeeping cpumasks are
> now modifyable with specific synchronization. A big step toward making
> nohz_full= also mutable through cpuset in the future.
>
> Changes since v1:
>
> - Drop the housekeeping lock and use RCU to synchronize housekeeping
>    against cpuset changes.
>
> - Add housekeeping documentation
>
> - Simplify CPU hotplug handling
>
> - Collect ack from Shakeel Butt
>
> - Handle sched/arm64's task fallback cpumask move to HK_TYPE_DOMAIN
>
> - Fix genirq kthreads affinity
>
> - Add missing kernel doc
>
> git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> 	kthread/core-v2
>
> HEAD: 092784f7df0aa6415c91ae5edc1c1a72603b5c50
> Thanks,
> 	Frederic

I have finally finished the review of this long patch series. I like 
your current approach and I will adopt my RFC patch series to be based 
on yours. However, I do have comments and is looking forward to your 
response.

Thanks,
Longman


