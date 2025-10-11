Return-Path: <linux-kernel+bounces-849184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A7DBCF5E9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 15:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56BFD189D251
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 13:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E6B27B359;
	Sat, 11 Oct 2025 13:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaqWxYq/"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCC0262FE7
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 13:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760190494; cv=none; b=Ebwd7PvpT5GbIEkYVZmPyZWjRA50lqydVoplpfAdt4u+9oqYPrSFHiULNeyXWvFZBc6AMbaPBdSQhUT6OjdWcEAs7BRFuTtKEQpBLDfM8sUbLuuA6mLfbnTQmZzjF1oBi/dCaDjkpXPQDfLVkZrRbo0b5mKi8A51tv3j7Ckzlic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760190494; c=relaxed/simple;
	bh=vcaJuw1clwXJ4jWIw04e4JaDkRS0s63ajXtRoop4cJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aSfhBqBmpMrp0OFn9/hFb8RoD1xqTWY2oaS5/41txXn0AZnrieqoAOFrRmQ/lTymrlkK1eBgNLevVI1OdCHbNdLLaxpkS7ftWS2ClvxQKMaGBClZb2C7K/s3gq4vS22ktLrg8OkZCRb3Gm/E6+23Jtkc7J7zq5DiHXI7kw5ecG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PaqWxYq/; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b403bb7843eso621144266b.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 06:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760190491; x=1760795291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ij0pRbpZK7DlOFmMLygfu4zYOW6yym5MECdSzEWg690=;
        b=PaqWxYq/mfmKwoodEEt7XtBaVTK6jxic09MkAeVGr9vntrezUsU3OzxQVkW8vxViLa
         Z/DWmLBJx944a43noJdKRhYXkyR45OFlvviCebbcs2Eu5gSh6OA08FWYEtl6v4WrvPWS
         eZ091w4XgN6HNlwMDLEo6cwc2v40yZtg2Mvz/sgb0x0l6grRNe2NI8ZkwGJ5YA2WDs04
         5bZaUxizTuqmWQMO+HlDlQbzZaxiU8SSn3Uhp2pU9PPNSXgp+lJbB0cYT2TOcKw9TQEU
         eu7oN2uf/S8LzEE1bYYfdfouwNhmCEePgo3+sbDDwZLq4NW7nKaGfK7vJWz9yAGlwOSf
         td0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760190491; x=1760795291;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ij0pRbpZK7DlOFmMLygfu4zYOW6yym5MECdSzEWg690=;
        b=sIQCjbjB3S+7uCxSsbLw2+32ZholZVplUS/ci4fnBAA89SJxra1rHqtmXCQfero5SM
         VRr9+QtSxKT4VJpdsK7N6WY6wK42DTxlIyCYI14z00RPgHsth7fpBNTpCgWB5UQ0keoI
         IEohI6bvcOmyHINF5FTO/D2T5KhYEWTCSALAphCrymcL4OnRgLvClz/mY1cC7gtUMqIL
         CtpXQ3GP3F36Iz8rN0Ibj5FDO/+878i4RQK6HarYHKkETUJHN4cTVDDyEM9EBEkZMRMW
         GAEYGIlVTshyrP2edBSJXcO7nEAwk7b/CRpaHoO4x/i1coSA/kRMfXBCBuwou3ea4Cd6
         mXjg==
X-Forwarded-Encrypted: i=1; AJvYcCX1TpQQt8WupIlPTfJQe/7clB6PoPq8beswWlWaPF7BRma7sF+7jaUe840dIPxvqjWowZYAJ6sZO5yDXGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx01SVcGBzquKYIaeRiJPO7TgSHvNhK9t5NVOL/2obP2AEgdwu6
	rAAbSv22J8mr8J+UWH8a4xEST/dF0Q+2rDiQA+R59e3j8angImBUKuo=
X-Gm-Gg: ASbGncsPLqNzs/NTSEeD3mgvaKIsqH2nQQyoY9ncPuJT1HT3r2FAIrNTYj4pK07NBTv
	fsHcxxGwVrRTiUUfLNWwVL528t5FXmkdXaOtIMHU4halN33t073udqjqrjTsZvm9+BCqTH+r6pR
	FjI5Q9Ory6bjB5IoLIu4LB0zYI1hRxnaY7qhbZuB6OK3mafSyzMQ5pJHgtiHiFS92BmZOPGHjVu
	9/IX9Zf31OLck5DBaVUOalShVKBP9qTcX9kNTUJVAUnNdQWwbw1rqav34ekMw4RXs40KmSq6a3I
	Y02c1dNYOGnkakQ/BZSUHC25NeQAHmKfxDGe0Xoa7qBmgsLy9GRD9xF2xawMRKSX3jr2XITk1yV
	d9UhDbsylqgIDDfRCN4E4V7YJJAKxsOvPYBaQQcdKgexnl29LJvBTtsPT93BnXfBkEWaaXw+7nV
	4zB01LyWqm4H2zzz4Q/S1oF1i6OvEy
X-Google-Smtp-Source: AGHT+IFd9B6gVvxY8KSFltf5N9REtQSNTlL7T1T8UAzp0xhQwwjQWYW8Is6AW0R0K0MvjyN1BJ+sLw==
X-Received: by 2002:a17:907:843:b0:b40:98b1:7457 with SMTP id a640c23a62f3a-b50ac5d0901mr1418839266b.47.1760190490424;
        Sat, 11 Oct 2025 06:48:10 -0700 (PDT)
Received: from [192.168.1.17] (host-87-19-169-144.retail.telecomitalia.it. [87.19.169.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d2a76499sm498766966b.0.2025.10.11.06.48.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Oct 2025 06:48:10 -0700 (PDT)
Message-ID: <f99f1fcb-2352-42eb-94b8-c7efa497caa2@gmail.com>
Date: Sat, 11 Oct 2025 15:48:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/msm: make sure last_fence is always updated
To: Alexey Minnekhanov <alexeymin@postmarketos.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20251010-close_fence_wait_fix-v2-1-adb332dbff65@gmail.com>
 <39a7f9a7-b97c-4851-9a00-ab926967d7c8@postmarketos.org>
Content-Language: en-US
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
In-Reply-To: <39a7f9a7-b97c-4851-9a00-ab926967d7c8@postmarketos.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/10/25 9:09 PM, Alexey Minnekhanov wrote:
> On 10.10.2025 17:39, Anna Maniscalco wrote:
>> Update last_fence in the vm-bind path instead of kernel managed path.
>>
>> last_fence is used to wait for work to finish in vm_bind contexts but 
>> not
>> used for kernel managed contexts.
>>
>> This fixes a bug where last_fence is not waited on context close leading
>> to faults as resources are freed while in use.
>>
>> Fixes: 92395af63a99 ("drm/msm: Add VM_BIND submitqueue")
>> ---
>> Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
>> ---
>> Changes in v2:
>> - Only update last_fence on vm_bind path
>> - Link to v1: 
>> https://lore.kernel.org/r/20251010-close_fence_wait_fix-v1-1-fd3e394dcadd@gmail.com
>> ---
>>   drivers/gpu/drm/msm/msm_gem_submit.c | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c 
>> b/drivers/gpu/drm/msm/msm_gem_submit.c
>> index 
>> 3ab3b27134f93b01236fec5833a18a6e2ad2cf5e..75d9f357437006ff261db148901e176eae670d41 
>> 100644
>> --- a/drivers/gpu/drm/msm/msm_gem_submit.c
>> +++ b/drivers/gpu/drm/msm/msm_gem_submit.c
>> @@ -414,6 +414,11 @@ static void submit_attach_object_fences(struct 
>> msm_gem_submit *submit)
>>                        submit->user_fence,
>>                        DMA_RESV_USAGE_BOOKKEEP,
>>                        DMA_RESV_USAGE_BOOKKEEP);
>> +
>> +        last_fence = vm->last_fence;
>> +        vm->last_fence = dma_fence_unwrap_merge(submit->user_fence, 
>> last_fence);
>> +        dma_fence_put(last_fence);
>> +
>>           return;
>>       }
>>   @@ -427,10 +432,6 @@ static void submit_attach_object_fences(struct 
>> msm_gem_submit *submit)
>>               dma_resv_add_fence(obj->resv, submit->user_fence,
>>                          DMA_RESV_USAGE_READ);
>>       }
>> -
>> -    last_fence = vm->last_fence;
>> -    vm->last_fence = dma_fence_unwrap_merge(submit->user_fence, 
>> last_fence);
>> -    dma_fence_put(last_fence);
>>   }
>>     static int submit_bo(struct msm_gem_submit *submit, uint32_t idx,
>>
>> ---
>> base-commit: b5bad77e1e3c7249e4c0c88f98477e1ee7669b63
>> change-id: 20251009-close_fence_wait_fix-00e1c2521eee
>>
>> Best regards,
>
> Hi!
>
> Since 6.17 I'm seeing gpu faults that were not present in 6.16, they
> look like [1].
>
> I was hoping this patch can fix it, because faults go away if I comment
> out put_iova_spaces() inside msm_gem_close(), and this patch mentions
> close path and faults together, ... but no. Perhaps something else is
> wrong somewhere?
>
> [1] https://paste.sr.ht/~minlexx/09a9b3d4bfff3e7be3e96cd88fe8cf34621cb655
>
> -- 
> Regards,
> Alexey Minnekhanov
>
If that fault appears when closing applications (which sounds likely 
given your workaround) then yes, this is very much the kind of fault 
this patch intends to fix.

Might be worth a try with this patch to see if it helps with your case.

Best regards,
-- 
Anna Maniscalco <anna.maniscalco2000@gmail.com>


