Return-Path: <linux-kernel+bounces-896883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9DAC5178B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC2933AB09D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3922FE570;
	Wed, 12 Nov 2025 09:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b="dU+8lRRE"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0FA2FDC5B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940538; cv=none; b=gbwoVGsveNNBD4miTJmoBDe/LJo/IFg2INrx1C6cHSZT658ycYBBGUp8Ilze+/ZlvkWdA0inik6us3cSlbihAKeU0FH+eteDMjexAh685uwCapCrzc0ID8M4qpAJ4272GWkRu5KElHrY7x8xjZmMY0vkhq9d2c6OebkPsVurt44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940538; c=relaxed/simple;
	bh=anc7Iw04tHnWj+aWsPc3gyh5YEPw2RAWClKgxhtljig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=twXL4sqtGlLY/KARackdoY3qnmV/QPruG8VHb+bqpJRb+Ip1DVoknkj+snQ/RpHckYZFyhbFEHA4HlgflVybCqr+ZaB+AwHrh7k5yQNEReYv9K1J28/NrYI/yrFtRJ4XRNwiSTEJ1s6ot0lNXJwdjpFvdnwsRtbc9yMpTcvS6/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=pass smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b=dU+8lRRE; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ursulin.net
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477632d9326so3920045e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 01:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin.net; s=google; t=1762940534; x=1763545334; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=non7jFyDgpV9ioaJdY/PWd6esrFFlJ4jS7hnF3MLWcI=;
        b=dU+8lRRERmyGs8a5PSiBowRYyxIW+lvsnBbMZhXCZdryH7CDU6H2AuRyhk3g/TZJ63
         UkI9AI7BVtvBR0pz7mNQiWUuBhNWtD1jtu+hJxjsIYbEH2rTRxiCtE3PGu8I6nXent0b
         /yScrqaSI4tWiTjXpCC8kTpl/yk/N0qplHLhUmxaL/XMpLRuBfu2gZ4oj9Pi/cGEIgKK
         LZMuy3p5V+Q9g6p/QaPS7GJRVjFQM70AYDEmvRl3kXN6LBrA6WJ8fTPNwrF40yu0kwlk
         cdVoZqMhDY2+1mI4uHP/sszeTmpNwQ8bv5nN67sA+ZAAz0+Md6hREADM5fTFXIhrSs0b
         z33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762940534; x=1763545334;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=non7jFyDgpV9ioaJdY/PWd6esrFFlJ4jS7hnF3MLWcI=;
        b=MtjfIImeNL0yxL75lviaiHcUZ2o74QP+WwBuUDIXBllvRIQN0qn66DZNgzdBsKB89f
         /SIjhJhx6K+gQcwlvfbAOtn67lve/YZ0zAi385CLL9GwRVOiuEZxLALwyn6xCa+sqFQ9
         gvcOLK9+0nkgPzSepyiwONPXlP5ML4TGKF8tZvVfRs71O5hillEpgk1VgZhCVAoiI+LG
         7OMqnqM0NzaNuOgN2h3bvd73ebwdnAaJJnMuwP++xwZAaICaUixdf4Pqap1ZHBL0SbpS
         pxOvc1xxY1MuDkVeHiAEZZN1ycJMCrnGS5LNIU4E5IrboFK/l5BD2+2YhXr+1nX6xkd0
         viNg==
X-Forwarded-Encrypted: i=1; AJvYcCXX1J0TYbOcb5N2NdXPggxjN/jrg+lK6oAX8x7IqCJwerWPoHB8MNnkOWKgcpTMAfmye6EE/jt7kIfdNVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaDz98eNXHDmL+5zkmzJhK1VoUo3yLEyxCvTVnERvit70YRq2M
	GBoKp++isEi7DKPc4g2wri1ku4+kavfka1UejS+UTrd/E6T7ymesEhIPW/daSVsAu3c=
X-Gm-Gg: ASbGncudyvBh2VrRsvdUtTH1ER6Ez+cKN+1R2ZKaOwdM2hSZkqNF59cPT8sP9l48RgX
	jr8EcZCHbw1UVDzpEfcVb1IwgfSA8nPRSniLUBYitbXrIjdaY2J/Z8mIVsIZSapu0J7/o89HTJh
	I09yhIAmXgjNNI544OZ+KnP++Fu5R+2CQPnZGbu2JZ/6o9OkKfZxM5hSF4K4gDWZg7opf5gZKD0
	69GgOQ4WVQHTWWA3kf3k8LTcLOofVPuh2QSVOijS9z4UTM0hlOiCFlGAKE63d08AXqNKxvlSEcX
	VJSZ+PhpHFxFj51Gcr12aRkW1onPbC/hxf1vqrik7QcR3IaUVu/j6dbumwcrOhALGeXeAWL18he
	qnEdnnpg5m/t2NLF5DOWVSLKbu1AVVxAb1meaGh874sU6fA/RZnJRuwWJc/9OBua5jdBvuW5yyp
	wZyn/Gy+vl/aztkrrRDOjJ9UL3MHa4pr+L
X-Google-Smtp-Source: AGHT+IEUD7F/bL8359XxwqylO1O60OBLZSd4tmhEK3pFqGhIuhFA3c+ouW/g75Uh+RBAA2Oa4hCSZA==
X-Received: by 2002:a05:600c:1c08:b0:475:df91:de03 with SMTP id 5b1f17b1804b1-477870b67d1mr22341115e9.39.1762940534598;
        Wed, 12 Nov 2025 01:42:14 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e486fbsm25160545e9.5.2025.11.12.01.42.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 01:42:14 -0800 (PST)
Message-ID: <e9c02871-fa80-46c7-8b96-bad3a6a2c5b9@ursulin.net>
Date: Wed, 12 Nov 2025 09:42:13 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sched: Document racy behavior of
 drm_sched_entity_push_job()
To: Philipp Stanner <phasta@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20251112073138.93355-2-phasta@kernel.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20251112073138.93355-2-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/11/2025 07:31, Philipp Stanner wrote:
> drm_sched_entity_push_job() uses the unlocked spsc_queue. It takes a
> reference to that queue's tip at the start, and some time later removes
> that entry from that list, without locking or protection against
> preemption.

I couldn't figure out what you refer to by tip reference at the start, 
and later removes it. Are you talking about the top level view from 
drm_sched_entity_push_job() or where exactly?
> This is by design, since the spsc_queue demands single producer and
> single consumer. It was, however, never documented.
> 
> Document that you must not call drm_sched_entity_push_job() in parallel
> for the same entity.
> 
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
>   drivers/gpu/drm/scheduler/sched_entity.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
> index 5a4697f636f2..b31e8d14aa20 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -562,6 +562,9 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
>    * drm_sched_entity_push_job - Submit a job to the entity's job queue
>    * @sched_job: job to submit
>    *
> + * It is illegal to call this function in parallel, at least for jobs belonging
> + * to the same entity. Doing so leads to undefined behavior.

One thing that is documented in the very next paragraph is that the 
design implies a lock held between arm and push. At least to ensure 
seqno order matches the queue order.

I did not get what other breakage you found, but I also previously did 
find something other than that. Hm.. if I could only remember what it 
was. Probably mine was something involving drm_sched_entity_select_rq(), 
drm_sched_entity_modify_sched() and (theoretical) multi-threaded 
userspace submit on the same entity. Luckily it seems no one does that.

The issue you found is separate and not theoretically fixed by this 
hypothetical common lock held over arm and push?

Regards,

Tvrtko

> + *
>    * Note: To guarantee that the order of insertion to queue matches the job's
>    * fence sequence number this function should be called with drm_sched_job_arm()
>    * under common lock for the struct drm_sched_entity that was set up for


