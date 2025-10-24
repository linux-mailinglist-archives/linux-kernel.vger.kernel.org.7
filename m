Return-Path: <linux-kernel+bounces-868183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87020C04987
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80CD91A653F1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 06:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE503277C98;
	Fri, 24 Oct 2025 06:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHh21Toz"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B61274652
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 06:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761289133; cv=none; b=py42Hjl2/+3OOsS/SwqAIsK/ccdHK16HDiPiJuKV5VDokUHk9gOTp04oMSonr+NoJ8wSni8nZoCpxfLMYRIkctSlrw84umX/08HCt9fRb2N3lMWgZjEpiIvsuYYgTJvy4eRcT0G0gI1/AH8BfetfQuSFn1GXzdcP9xCn7qFBLPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761289133; c=relaxed/simple;
	bh=ouuvPGm0sNumIUj8yL/i23jRDtD4FUp08+5H5fz4Wbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oe2Z83U/H3lUFTpgLwrYv7ObbpgAXXGdfJTluWQsxXs6T94Q9g+rBnCtk5i/eRBHoAPnnO43YJAXeYPOXfqRRnF9bS7A2onMVVDMA7ony6QQUP3lWEihKGa/Z/moT/2//at1lgDJdjomyAg0pGMtl71Si9HkJ6+idJO39mhxogM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHh21Toz; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-290dc630a07so12235465ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 23:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761289131; x=1761893931; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k87hOdMqC5Cdt3rAJ8+LiDSDQZa5GhKDKbVYp0AjmqY=;
        b=SHh21Toz5tVvp8ANRqRAs+DiwvdEDuPaupwuQWmeChPiRm2884qVsbJk8QLjJdOsEJ
         2NDsvWovnEQubCm04feJuef+jT4QGe+M7KdTAARePGrd3BThQVQxKYHPFUBLRlMzRBhA
         BtncmgLcqvjUyYJ1VjX26qDk8/2RrM786zxp3ptm+dwk6KL1+UANW9vH1vHgfc1XZ2km
         0XkTH5ZQL634WWSHWB+kGXu1fsx9JFBedJVWPYU/fcaUts1TmMz5zz+OctnWnYgBoMb7
         zq5Zm/EB1zuk5xJRdBHrGri2Co0YKAv0JLSc63ENe/ffiOzvuysuocv4+xjwlwBGVIbk
         YpeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761289131; x=1761893931;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k87hOdMqC5Cdt3rAJ8+LiDSDQZa5GhKDKbVYp0AjmqY=;
        b=X4YffJkXcBTufy6DUzI/oLYlwX/cKacojKtFzAMpl5QhviKlT/bpafHbT9BuNiz8qP
         LI2aUm1LZZ+LISew1MOLl4KWce1LAIvWtq8DN+mHl17wqwLq9FfCaY2UWuCa0WOoq4Lm
         4AsEEtve2o+G6nhSs8gfe8GY/A75B8JdpD7lks+XkmJFvBIYmvynH787uJfkOzNqpLa+
         egtviqCihHEcn7/fz6PIGDSQOYpTsMPbE+Lg0m1kq/C0xiDIa3Olm7MLA5QD6IILbBQ5
         aY7P+ivr8x/ckSNRCrniz6dZEKAqgpGAfLfQSRnD0KTII/Fp7A3VIDHhqfmzt1dhxLa1
         ctgQ==
X-Gm-Message-State: AOJu0YwvQ5z54Gp57gwq7DA4MyKFHi4q91n/Q3JdDhhrgn0pP65jullB
	j9Wf0CdQTmEyOU+vr9sAV8iVr13dkUXTpWkLmRpoCBVrV9aPEYCMdCPl
X-Gm-Gg: ASbGncs1OrzBnB8LpIHJ6sMZsjAtLb1E7N/VAI/ZahzpiWzGA58gf80/sZFW527i6xu
	NfQ6FjU980Pv5gvh7d1i+Bdbkya1bZn5zTJ19Hzg9ZpPBP/L3FHGUMR9nF0YeERd/r9fB5VkMnk
	OhE4vgQp/yuaX/Hd4IruQjPxswtb6i/lXvaiPp+SYlfZkxiD+j+vAi15iGlrfsCCaFGmAsiAK0h
	qDYP6LrNAVRIi80hjrY06rxORRWlvSFB3KTvhGS/NNsS5QZ11UVfTiM/Tk5GiDqjfP3VBIv3owa
	XaTiiB5HAWff08gBK7+2oEALmQRzxAmTJd+YmorXMHbHesSUd59Gj2smzXkq2XoF8sSrRSWGBv3
	V51bDjcGCRUzL/xDAHjBhu0TuecHkAhRdC+c8FElwhRbgmoODaG4FT87pOYP3Mu35ODKPrvYMr8
	RPYBYBJ7nR9PXtSJOCVLQ2rYnQxR7RrB8=
X-Google-Smtp-Source: AGHT+IEgJgSJT4c559o77/ns1JxQ3O0Fpw3oD26TngmT8w9TA3KEe2VfcEYAUCHIIs/Ae1dHnnUPag==
X-Received: by 2002:a17:902:db11:b0:240:48f4:40f7 with SMTP id d9443c01a7336-290cba4efc9mr416493535ad.39.1761289130959;
        Thu, 23 Oct 2025 23:58:50 -0700 (PDT)
Received: from [10.125.192.78] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e2247a342sm8113140a91.13.2025.10.23.23.58.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 23:58:50 -0700 (PDT)
Message-ID: <561a15f5-3391-2796-6454-b980e0a228bd@gmail.com>
Date: Fri, 24 Oct 2025 14:58:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] sched/fair: Fix non-empty throttled_limbo_list warning in
 tg_throttle_down()
To: K Prateek Nayak <kprateek.nayak@amd.com>, mingo@redhat.com,
 peterz@infradead.org, mingo@kernel.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com
Cc: linux-kernel@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>,
 Aaron Lu <ziqianlu@bytedance.com>
References: <20251023121213.38282-1-jiahao.kernel@gmail.com>
 <98c1968e-8629-43d1-a4b8-600d263bd5a1@amd.com>
From: Hao Jia <jiahao.kernel@gmail.com>
In-Reply-To: <98c1968e-8629-43d1-a4b8-600d263bd5a1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hi Prateek,

On 2025/10/24 12:36, K Prateek Nayak wrote:
> Hello Hao,
> 
> On 10/23/2025 5:42 PM, Hao Jia wrote:
>> @@ -5287,7 +5287,9 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>>   	se->on_rq = 1;
>>   
>>   	if (cfs_rq->nr_queued == 1) {
>> -		check_enqueue_throttle(cfs_rq);
>> +		if (!(flags & ENQUEUE_THROTTLE))
>> +			check_enqueue_throttle(cfs_rq);
>> +
> 
> So my only concern here is:
> 
> check_enqueue_throttle()
>    account_cfs_rq_runtime()
>      __account_cfs_rq_runtime()
>        assign_cfs_rq_runtime()
>          __assign_cfs_rq_runtime()
>            start_cfs_bandwidth() /* Starts the BW timer. */
> 
> If we skip it, we wouldn't know we've run out of bandwidth until the
> hierarchy is picked which would cause additional delay until the
> bandwidth is replenished.
> 
> At the very least, we should pass the enqueue flags to
> check_enqueue_throttle() and only skip the throttle_cfs_rq() part if
> we spot ENQUEUE_THROTTLE.
> 
> Thoughts?
> 

Thanks for your suggestion. This is indeed a potential risk, and it will 
do it in the next version.

Thanks,
Hao

