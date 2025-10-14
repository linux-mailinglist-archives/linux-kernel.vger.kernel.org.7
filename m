Return-Path: <linux-kernel+bounces-852531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC6FBD9394
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B735D3E7965
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F1C3115A3;
	Tue, 14 Oct 2025 12:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="JPd5mW5F"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE692310771
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760443555; cv=none; b=iW8jjnBGO0yhjOl3Tl0W+TeC0TG7xJCm0vxbIT7DFO2LlsaemnDIhnLANtpYpu7A2c1MIIykUrbjyx/PI4k4KjsVbeiIJaznUdqb7blc7LOggdyPlLaRUAOCdIMikQV+uVdXHztkSZjACx0eT9p/WuZooeA1qJgtbkfuMYNc40o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760443555; c=relaxed/simple;
	bh=DHuuAzkFkUPr5YhKl/+FlX+iocrf3NZOoDe8nFZEbrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YOkK8Lq9+JxMExN3VNm8QJmQaiLkaDOzQysrtSgw4gNfGlz1xjBRVq3Tj38cZmwjOvWZa51oQb2q2STGWd+6RlsmcNfzO8aNslf7f7js1wvAg7Z81OzF7T6zbkJ91Kkn0RVvgr31PTVYcW9a5VhLSyHK/LXT6J6PACfNOJnM3Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=JPd5mW5F; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ee1381b835so3396254f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1760443546; x=1761048346; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6/oH008OmOSILGStPOvECv9JZ5uFtkPz/y1ZNR7iEvs=;
        b=JPd5mW5F0SFs3Wwrxo+KcXRixXan3UktdQy/r+Xtjn7WD/xl1N848T4gFsFIzgdeGV
         d3RtYBoZ5QUpRviFm1tlRSr8SN25cMWHlPh6kPSqCA9unrSXoaU9rsxkd0Hmvn+AEGCB
         gLUnKTZUNaKG6xNZz11WNmrbnmOgDIq4UkOYoTmHrsSJUqgFRax9bt7fh59UKm0rI8qE
         1bA/e72XcVwZFvCuLAkY0BIkO4g6rIqnd11qkpqeWtT0er9OyXMsBpPMupoffvtqQYUY
         8wOP2hIPHM0v409eRwiSymnzXH9E6uLc7JLmYg5Z7oy8csh+PjvjhKD7+WsYDJQNMN0W
         vUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760443546; x=1761048346;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6/oH008OmOSILGStPOvECv9JZ5uFtkPz/y1ZNR7iEvs=;
        b=BKVe4PTpQerXNIMzwnZpnYb0pZnbGzRp1w+ykKlQRaKA3puCXynD8+tQWXKON2Q/Ph
         VUyEmhcmjeO95EE/0+GErLIFDY+b1FVjanT2HRpo6p4OweKmTUvy/ezS3YznqAPNUgpg
         m34YBX+XTwjbYwpwOF40kTh3fg9F2bQpAXAX8CvY2YN0p3YmVt++R54aKEVzvSQpyLPr
         kV7sA76a5jhiQ/BpY/CK6PVuHCjkAKfX6E5szUjqWLgM+dRPULmK3i4BhQ55OM7OqKCp
         JKSUAjTTsjk04IrNut5J1iS/ehG82Bu6diB7SU4SUAXak6cGriEeV1QbnaKmrFuBfK81
         /MMg==
X-Forwarded-Encrypted: i=1; AJvYcCUR0FrzfuxKGUAR56R327siyE75BejFzCx4TeciE8Tg2pEl2R9za6AHsul8SqilZCdSd1uxXUo6eEwnUZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXCmkbZ/mnCNVVBXOfKNfJ5n+/n6CJ67pOG5iE5/1XHTzDX/2u
	U7Q5Xxy5tKXz96SvTAOV8W5RrIh4FSvtHxId0mQxoiBUwBlcOQIgzn4R3gm2GGwINrc=
X-Gm-Gg: ASbGnctOrsXKcaK7rzCVoxHFwyLavFRD7KHFPdVVtTqYXs5zJrdNQ1XCbvna89fvLeO
	fOyX5nY3whZnnumYq6HSHdImg0JuME4D00G75NqFCSxemzeHBeiYCJPUPECaZ7x4nPGFnmDLp9R
	Rg+m0dCK6EbEyRt324iqLK7qmmH9TR5FndOwBYGy06/XEQBTiyOvxbfD0EjsvOEowJ4giBvcrcq
	dvgWj835wjQ7rJkEikSlfQPeqWDgGlsMQxVAew66VAWfc+WNhGUrc19iRRaiC87ZcBEb6n2i/k0
	o5UZINQRFiuo5NXC/jqid+JuD6sOkuFy4tZJrHgPSzkSD2xUxQX1fKlCQ3xyz74KXXxCb0WeQsc
	stZ9/tzQ/3/X23cypO3zdXVkYg9nK2/WPlXddQrQ9uSLemoufpjUCv777
X-Google-Smtp-Source: AGHT+IG+ox4uHFRDU2PjORRa/c0JlDTsp8OFc8jbQP/kBh/MC7IhgPjotuh6KpbBz03C2S8qtojjLQ==
X-Received: by 2002:a5d:5c8a:0:b0:3eb:a237:a051 with SMTP id ffacd0b85a97d-4267b3395acmr16245681f8f.58.1760443545906;
        Tue, 14 Oct 2025 05:05:45 -0700 (PDT)
Received: from [192.168.0.101] ([90.242.12.242])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce582a9csm23425448f8f.12.2025.10.14.05.05.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 05:05:45 -0700 (PDT)
Message-ID: <dfda6c38-fcd2-4d94-b9cd-c51972f40106@ursulin.net>
Date: Tue, 14 Oct 2025 13:05:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sched: Mandate usage of drm_sched_job_cleanup()
To: phasta@kernel.org, Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250926123630.200920-2-phasta@kernel.org>
 <1490c292-c244-4dd9-80a6-3fecd0ffb422@ursulin.net>
 <87f93819aed4784b3e280af38bd7b447821873f5.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <87f93819aed4784b3e280af38bd7b447821873f5.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 14/10/2025 12:56, Philipp Stanner wrote:
> On Mon, 2025-10-13 at 13:20 +0100, Tvrtko Ursulin wrote:
>>
>> On 26/09/2025 13:36, Philipp Stanner wrote:
>>> drm_sched_job_cleanup()'s documentation so far uses relatively soft
>>> language, only "recommending" usage of the function. To avoid memory
>>> leaks and, potentiall, other bugs, however, the function has to be used.
>>>
>>> Demand usage of the function explicitly.
>>>
>>> Signed-off-by: Philipp Stanner <phasta@kernel.org>
>>> ---
>>>    drivers/gpu/drm/scheduler/sched_main.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
>>> index 46119aacb809..0a9df9e61963 100644
>>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>>> @@ -1030,7 +1030,7 @@ EXPORT_SYMBOL(drm_sched_job_has_dependency);
>>>     *
>>>     * Cleans up the resources allocated with drm_sched_job_init().
>>>     *
>>> - * Drivers should call this from their error unwind code if @job is aborted
>>> + * Drivers need to call this from their error unwind code if @job is aborted
>>
>> Should is indeed wrong. I think it could be better to go with "shall" or
>> "must" though. Since those two are more standard language for this.
> 
> "need to" is standard UK(?) English for "must to" I think.
> 
> But I'm fine with "must"

Yeah will is standard English and IMO understandable. I was just 
thinking whether it would best to stick to the established "requirements 
language". For example:

https://www.nasa.gov/reference/appendix-c-how-to-write-a-good-requirement/

https://argondigital.com/blog/product-management/using-the-correct-terms-shall-will-should/

https://reqi.io/articles/shall-vs-should-vs-will-vs-must-whats-the-difference

But I am okay with need, your call.
>>>     * before drm_sched_job_arm() is called.
>>>     *
>>>     * drm_sched_job_arm() is a point of no return since it initializes the fences
>>> @@ -1038,7 +1038,7 @@ EXPORT_SYMBOL(drm_sched_job_has_dependency);
>>>     * submit it with drm_sched_entity_push_job() and cannot simply abort it by
>>>     * calling drm_sched_job_cleanup().
>>>     *
>>> - * This function should be called in the &drm_sched_backend_ops.free_job callback.
>>> + * This function must be called in the &drm_sched_backend_ops.free_job callback.
>>>     */
>>>    void drm_sched_job_cleanup(struct drm_sched_job *job)
>>>    {
>>
>> Hm, having read the thread so far the situation seems not so easy to
>> untangle.
>>
>> On one hand I see Matt's point that free_job callback is a bit
>> misleadingly named and that there isn't anything really requiring
>> drm_sched_job_cleanup() to be called exactly from there. Free_job
>> semantics seem to be "job is done, *scheduler* is done with it".
>>
>> Drm_sched_job_cleanup() already says it has to be called after the point
>> of no return (arm) so it could be left at drivers discretion (de facto
>> state today) to choose how and when to do it.
>>
>> What I did not get is what is actually the perceived problem with
>> letting this stay? (Ie. "should" indicating it is recommended, but not a
>> must/shall.)
> 
> I think the most correct formulation with our current mess would be
> "cleanup() must be called earliest in free_job(), or later (if there is
> a very good reason for that)."
> 
> Question would be how to document that.
> 
> I still have that big life time docu patch pending. Let me dig into how
> I could combine that..

Ok.

Regards,

Tvrtko


