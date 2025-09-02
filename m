Return-Path: <linux-kernel+bounces-796753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AC2B406BE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 888105409C5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D2730C341;
	Tue,  2 Sep 2025 14:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h7MfJkRM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4082F277026
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 14:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756823344; cv=none; b=M3d7DK+T2paQQ3tvBNJSedDm5cPh9UYIFuPs+FI99tRtAb7+RW5c6z9OrQGM2laC2k8E//s0/LPgwYGW8wLM7NiuLv/U/ywQ5PZMBiCie4hHTm9Ll8p7OsOS3JcZ7nu3DI1h4pT8eLkj9fEITaGSDLiKUvkWoQ5ExwraQoS+hpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756823344; c=relaxed/simple;
	bh=0uD3fgepSvnzef4qtRkCstzfFO2Qw51MoEU770j8axY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ClnBB6nnO14IrsGS6LUEQ94t83rChGErNQR5nvJuoW0pJgl606XCDhdkV/UOnH697PDP+mCp4bawNgXuMw4jSWBRhmpRFP3XQXlyFf7oqf5pBLx3N3rOSDMtnfEBsBPvAtgS+RZ2352cqacBGU569DPjTV/lcpp4ozaiJtkZjKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h7MfJkRM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756823342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jMm2hqFJ33GpaPZEoSKZeivNw1uggEmRUJPe/aLNhzw=;
	b=h7MfJkRMtClPJ+y3TAXGTNEG4DiLz+7qnqkUbYRVyY2cqYl0zgbk074e7Krev7P6KW8l0U
	Yh7Sg1M5Bbv6Ho3JMMAKCAiCNGMgVWU4AM0TsVTX9QviVDX2PuHSn41+Qb3OFOinXLOF4a
	oYkACn/KPi5EqsdpL3yi9ZYPNcJiQnc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-fck0o72tP1uiha-tMphs3A-1; Tue, 02 Sep 2025 10:29:01 -0400
X-MC-Unique: fck0o72tP1uiha-tMphs3A-1
X-Mimecast-MFC-AGG-ID: fck0o72tP1uiha-tMphs3A_1756823340
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b3415ddb6aso23230711cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 07:29:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756823340; x=1757428140;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jMm2hqFJ33GpaPZEoSKZeivNw1uggEmRUJPe/aLNhzw=;
        b=X5rPUbfBmHBLHZBGHjcx9LtlK88q0D2goPVeD/NoQ6lo8KS7nTUzyEZ5UgOnEiX6Z1
         5qHJ7ae68d11koKqJoe3PPzMZifZ3BqHjElOrgsHl5f0yEO22P/dXL6OOtd14aU2BbNo
         nk3XxXz4N1n2jZjXkvvjMXNer/5vk32mU4O2j/fPvzKftBYW5dW0uUQixLo1uAlkHN4a
         KLc/P821jxkdtj1jAZ/61xjAwQ2i4g2MP0jnJ7dfQBFjo2TGsZO5t7qSlGCCiHEAuQGw
         +Zn9KaJuHKr2fRMNU0/70eM12IBIn+3fcbwcEaqXSjlKtbtZYTQsPGvEqlb4PJ6YEkQC
         S1xQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxWeVMNXI2gTdfKZ3dVmOyJb9cetp2bjC+4y6Gb5jKczsCPqt2Y3wCzd18yrUqwFFzb7kxT8ADgglvJJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKYkqx6heqsBEdG4VDCzNQcNx9/RAWq1MI2Buu2ryz99U2qg88
	PlU9O8nr4phP2wduy4qfxgK55UNoMpF3moNVbVuB3P581mNDvZJFq3meWWdQsNhmX2XTw3uJTzS
	XKxrz7FJ5y05KtY2V6+9q11oxb55aVGmfRLsGL/NTsTk0Eyt91FOXFz9YIWalExReBA==
X-Gm-Gg: ASbGncvU0ELypRG2buhMBc5kAcz75r3K59jgtfcxoENwUzWOo4HG2hAISj0UNLMk343
	zLHiPSTAHBYqTCb8JIaaM1nqWr6XeKUElkMZTfeMJmA+p2oTaT43zNNAKxq7orAj3Ss7NpJFr4/
	W3E/51eqfH4TEiI48ls6SEk1Fg1EpZnKtXHpYOw5MtdrVNHQ2uPtQgzm6Ro48WQZ8dTxbu7Eyp5
	WS4LNiHLPVdGyxYBpU6/9kpGX+N+z2kC/VlgmiTr4DzXRSfMNn2uPgnsBkCjjn4TFl0s1JMMmRz
	6V6aqQXSZUebwvSdKYNV3wDC6Qav2lfmCvvmzPlkgk5IoaoBRI5XdsZ67k1z16zob77x8GgiV2D
	37Z+IT8IF/w==
X-Received: by 2002:a05:622a:1449:b0:4b3:1861:f0bb with SMTP id d75a77b69052e-4b31ba1dfbbmr134483031cf.42.1756823340261;
        Tue, 02 Sep 2025 07:29:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElo7xfrDWGtiqXJTwSgGuzEGYT7Smn/96zcSvEGWsQ7xtIrTZuKmhG2yXFRCYDs0xsZGT64w==
X-Received: by 2002:a05:622a:1449:b0:4b3:1861:f0bb with SMTP id d75a77b69052e-4b31ba1dfbbmr134482611cf.42.1756823339844;
        Tue, 02 Sep 2025 07:28:59 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b3462c9646sm12961021cf.25.2025.09.02.07.28.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 07:28:59 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <dc75acab-36c1-4340-9cf2-35a35361c32b@redhat.com>
Date: Tue, 2 Sep 2025 10:28:58 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/33] sched/isolation: Remove HK_TYPE_TICK test from
 cpu_is_isolated()
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>,
 Marco Crivellari <marco.crivellari@suse.com>, Michal Hocko
 <mhocko@suse.com>, Peter Zijlstra <peterz@infradead.org>,
 Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>
References: <20250829154814.47015-1-frederic@kernel.org>
 <20250829154814.47015-20-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20250829154814.47015-20-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/29/25 11:48 AM, Frederic Weisbecker wrote:
> It doesn't make sense to use nohz_full without also isolating the
> related CPUs from the domain topology, either through the use of
> isolcpus= or cpuset isolated partitions.
>
> And now HK_TYPE_DOMAIN includes all kinds of domain isolated CPUs.
>
> This means that HK_TYPE_KERNEL_NOISE (of which HK_TYPE_TICK is only an
> alias) is always a superset of HK_TYPE_DOMAIN.

That may not be true. Users can still set "isolcpus=" and "nohz_full=" 
with disjoint set of CPUs whether cpuset is used for additional isolated 
CPUs or not.

Cheers,
Longman

>
> Therefore if a CPU is not HK_TYPE_KERNEL_NOISE, it can't be
> HK_TYPE_DOMAIN either. Testing the latter is then enough.
>
> Simplify cpu_is_isolated() accordingly.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   include/linux/sched/isolation.h | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> index c02923ed4cbe..8d6d26d3fdf5 100644
> --- a/include/linux/sched/isolation.h
> +++ b/include/linux/sched/isolation.h
> @@ -82,8 +82,7 @@ static inline void housekeeping_init(void) { }
>   
>   static inline bool cpu_is_isolated(int cpu)
>   {
> -	return !housekeeping_test_cpu(cpu, HK_TYPE_DOMAIN) ||
> -	       !housekeeping_test_cpu(cpu, HK_TYPE_TICK);
> +	return !housekeeping_test_cpu(cpu, HK_TYPE_DOMAIN);
>   }
>   
>   #endif /* _LINUX_SCHED_ISOLATION_H */


