Return-Path: <linux-kernel+bounces-850483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB46BD2F26
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27047189E25B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FD126E718;
	Mon, 13 Oct 2025 12:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="nfuz76KW"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AAB253B71
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760358020; cv=none; b=HXnwSDp3gwqv0okil9pdLjlm7vB0I3OtfeY+zS0gnkxnVN0VoFRNp2oRx74LeRO8PrKcxRF+0KJvLTwMjZG9A8N9iZ9nDwSR+xdlOlbfVz6nkATB9HkY9cnfjJkeokzhtPb8WvdCXsRt1VhEfFbbOKi3FbilRrf3f3Rc2eAx/Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760358020; c=relaxed/simple;
	bh=1xwPO9EgoFKjot+j5CqJ6IDcBQ4cUGycQo5ADYce9mE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f+qKV/iMXf6KZIh6QNq0b9ErpCV6gmfz1d8m4y6P3yTnU0g5jt1SE3mKlqkBH1G2jAL2IgIo+oMAa4M2xlYBbHApykaRsaPL5xpMdxw9BblCtyBs+Nzj8PsRlXXeCyexeSsg6z8K2kyRDP+UG6UJxGq13mvUkwfMQ0ksDfwhQcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=nfuz76KW; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e47cca387so41716955e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 05:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1760358017; x=1760962817; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nwPBtVzaWo36hivYjisnYZie4hF0IMzUbnAFNXBWzL4=;
        b=nfuz76KWWB0lko1e+k8PdOPk5JG1rzb1GVAl/czXTdLBgumVmqCTd770DONin3ogKX
         668fOREKdCNJQRGOZRhSpIfI8npmFaghV/huRwm7Fp9cVDJRhjKMZVy2rwc+xxSLcEIt
         GzD2o7WVwSapFonYyllaBooZed0ZPTd6LsOMm5LtnjxelePZjR0T2y2jiYbuy3/vxM2f
         RSubq4CShiRsvFOD91Qg1oNwF+RbExaX0U13B/hJPQRzCgdQOXXRnX+Ssg8cqeOxHIWL
         fz7w3d0OLWXoO2OF4zDkrNK2UE8O8uCDqh20HPNVQeSWHJAmBQ/5xbZBJL0aHfXpZe92
         kocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760358017; x=1760962817;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nwPBtVzaWo36hivYjisnYZie4hF0IMzUbnAFNXBWzL4=;
        b=EjydI0c4rfkJqLFAq2eFNB3eGj8n5S4uPU1wgAQjifTVkh9amdOznQ9n4+SZvC5oLK
         nH1ZbQePv4VQbupNLn5TQvdfMAbjsyX/58qrh2W5I6AzTUte0RmUN+t6jd7XyfnaODH1
         OWj8gjQaU8fgOMt/Nnmh2QJh/rEglea/I4F7HXwzhTxoRfpNlhyrCkALflJl35/sAIan
         /Ad1JlJMaJhu0j/sLrTfNtZnFzg2gkN9AewXUJNvjd1rtVxR7gQan9epfnUoDSl8doMw
         gt922hHdvIn5PeqmzIdzRTzURTJSypISJ1oHIpVOSzX1/3NsCX+0UUK+QGjumhjjO1dl
         vugw==
X-Forwarded-Encrypted: i=1; AJvYcCXgG3l/IUGy+O+kk2gUYt5uL5DOMyMlYsW6GQ7TxoWbFN2RybNAYA8c1Jy4e6asuCLAYeG7hxMHoJySr4A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx40hm9vmn7Q/wlmCE1qU81dQ5s1RPYwTr1wrimWenVJoraORxX
	yqTxVjtvUpcvRPCuaG6bxnogrOsno9f9eRfFMED5wLc1FYBLWDfa4YPi9FYX0AiNDUs=
X-Gm-Gg: ASbGncs2Oiv5d3j2ljwP+RUlzBQY7DgecGIEB+57p5Ngb+pvQdI9rQRMcPNFUSjO/cv
	px3L7h8IgXb3OhTaxRhMW9P5xr/dY4P91ugnavMTXGsiIiDmpIBF/nC4pgRC53stsKqhDWjcxs6
	0nJ6OpTmFHWcA1WzS7FICB37gTw3x2dTQcO5lmeEe0F7u+IU2PMwMqna6RZUXXFQa6Nbe7OuwC1
	+t7L+3E2GGOvBVdMV456WlgQCV1cvCJufISZKzj5KyfH+bTpieSsmgioXmbOc0j1A0UCWLZe5w7
	JEnBgZYTnzeXkDrITy6J7IusJdzaJTtLLwJJBCJKwpNJbtDTcuVIahEomqnjB+CZDtqnxoZkjgr
	YWT0zqPDSqBzVfCtcbOLZPPGDI3RawD2Fl3SibEO85xES6pbzPtZV3w==
X-Google-Smtp-Source: AGHT+IGX/AgrL3dHZjIFyO0yIQjVQ8JpLbWaakeo7HGCj7Fhm8sEdEMMwy8fhLNldeBaV5STGHOaFQ==
X-Received: by 2002:a05:600c:46cf:b0:46e:35a0:3587 with SMTP id 5b1f17b1804b1-46fa9b02cebmr136926125e9.27.1760358016616;
        Mon, 13 Oct 2025 05:20:16 -0700 (PDT)
Received: from [192.168.0.101] ([84.66.36.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb497aea6sm184960825e9.4.2025.10.13.05.20.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 05:20:16 -0700 (PDT)
Message-ID: <1490c292-c244-4dd9-80a6-3fecd0ffb422@ursulin.net>
Date: Mon, 13 Oct 2025 13:20:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sched: Mandate usage of drm_sched_job_cleanup()
To: Philipp Stanner <phasta@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250926123630.200920-2-phasta@kernel.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20250926123630.200920-2-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 26/09/2025 13:36, Philipp Stanner wrote:
> drm_sched_job_cleanup()'s documentation so far uses relatively soft
> language, only "recommending" usage of the function. To avoid memory
> leaks and, potentiall, other bugs, however, the function has to be used.
> 
> Demand usage of the function explicitly.
> 
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
>   drivers/gpu/drm/scheduler/sched_main.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index 46119aacb809..0a9df9e61963 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -1030,7 +1030,7 @@ EXPORT_SYMBOL(drm_sched_job_has_dependency);
>    *
>    * Cleans up the resources allocated with drm_sched_job_init().
>    *
> - * Drivers should call this from their error unwind code if @job is aborted
> + * Drivers need to call this from their error unwind code if @job is aborted

Should is indeed wrong. I think it could be better to go with "shall" or 
"must" though. Since those two are more standard language for this.

>    * before drm_sched_job_arm() is called.
>    *
>    * drm_sched_job_arm() is a point of no return since it initializes the fences
> @@ -1038,7 +1038,7 @@ EXPORT_SYMBOL(drm_sched_job_has_dependency);
>    * submit it with drm_sched_entity_push_job() and cannot simply abort it by
>    * calling drm_sched_job_cleanup().
>    *
> - * This function should be called in the &drm_sched_backend_ops.free_job callback.
> + * This function must be called in the &drm_sched_backend_ops.free_job callback.
>    */
>   void drm_sched_job_cleanup(struct drm_sched_job *job)
>   {

Hm, having read the thread so far the situation seems not so easy to 
untangle.

On one hand I see Matt's point that free_job callback is a bit 
misleadingly named and that there isn't anything really requiring 
drm_sched_job_cleanup() to be called exactly from there. Free_job 
semantics seem to be "job is done, *scheduler* is done with it".

Drm_sched_job_cleanup() already says it has to be called after the point 
of no return (arm) so it could be left at drivers discretion (de facto 
state today) to choose how and when to do it.

What I did not get is what is actually the perceived problem with 
letting this stay? (Ie. "should" indicating it is recommended, but not a 
must/shall.)

Regards,

Tvrtko


