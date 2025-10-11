Return-Path: <linux-kernel+bounces-849181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AED32BCF5DF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 15:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 629834E2148
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 13:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BB927B334;
	Sat, 11 Oct 2025 13:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsSf03iJ"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5608126B085
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 13:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760190394; cv=none; b=Xj3V4HOR7BSHPxxOfrnTx3kaoiDe4KnaA+O9diebgdoQN3eX7jx4zALrwkoJyy2FqTmbi7XL1/5nZHGShq/1cPYePSwlWN0uLPyfbvn1QHt3kvXv0MChgxMSsaIsOKpFoAPSzq8fIY6ElOmZmqmtZYyCmVEoFtLui6CTF1nLf+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760190394; c=relaxed/simple;
	bh=2mP/mdhx/PZWZwIOnFDykMB/bobzYkS+gWP6uY2NlcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XPmY1dAbS3QSWMTVWIPM7/qdzXy0FxfNqTLyPKJU2MRLi0rO8GOwwbrl/GttS/Dv8lLNtuXeO8yy0BImDtAksHZRl9uQMnEE9h3TgQibBqI7W4oh95+naRZhfeHNnf8mYVpYuwxHIBLV50ebW6rdcxNSSOFmhf3qUQu82kGZmTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hsSf03iJ; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b3e9d633b78so511654166b.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 06:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760190391; x=1760795191; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V7baLPO6ldN0wytk+dLo0ZV9RZqTyWkuy/xpv05pZ3Q=;
        b=hsSf03iJtxdsUj+ge3nYQSJcol49uy0+CbeNZBtfYnvhNBAZflR8HXOe+QBI0FHPO/
         BSevDCTKwStK1/aBhU7nfl/CUh/WOaeEFvMntyAeRdMTLp0iLTB13aMELkZaPTU5Scbn
         0bfqbpXGPAq4AlYwYV+QgX1q5przxolWKUmG9jeB5kQeqaD4peMql3xZsAdPt09tH4Lg
         ENSJ3gnEoTviBxgSJz/2HFmlWxZcNViOQfEaTBlHdc4s2cmCu9gkmloLSpFPJ3SS06SA
         bXYEv1VgwoDaBhWRu7peoi4DONDzP5WyU0bgSnu/gYPEA8WApuLbtvfRzdp8qmTLfhQy
         nfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760190392; x=1760795192;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V7baLPO6ldN0wytk+dLo0ZV9RZqTyWkuy/xpv05pZ3Q=;
        b=xSmyV8m6LxegNBSHxiuC2a+klGnfnkLX93m2zR55brsmi4088zMfRlMhpqqcJj3nGj
         vIK165Mu5Stx5nanbhnzsZMmDWDjdzc5+VV/bOb0TKtfcm4ldtgtmckcDrQDq0AOcpWa
         h9wY5QTQtGg4zPCSkSV48RpoRrti/aq06la5C/gWnDZBluJVZmqsA/DZFJzTv3HFPMFH
         OHasMugzk7+OTk2LP4X59tVSxp2hMteQeGWLeendWLDjmG0lWo8OJPeuSc+xSsud6rB4
         zjVJa0ohmwiTTVc3yrOXmrwjNESa/EHj3PP3pAZjoqE0Bglp9t+4UQlv14TCke+7PM+T
         2qXg==
X-Forwarded-Encrypted: i=1; AJvYcCUyMbEV4y1h2wuqvJwC1Ao9iIyXksxxYwI+J0TGDoGzWrDAWSgSMkFYabIv0SlkAleR51cRfD1g8t1lg98=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEMvLTakg59Oli7IBLNYPoU1Ejkl7iifvUdfOJWp2DN2oB1RFY
	nSd2m2ZXrNnUY4NcNIRFG8acmRQiRZ9sctI+xDTnJIzjqJcbhWX6PEk=
X-Gm-Gg: ASbGnctl/pTsHhMtYeHOM92t+QxzwLlUN13diwOMlDrtp5c1+2nSTnAG+M36jeM7dsQ
	TUD5hsXpIfjg/Wj9qHV5GpGJeZXW3yn4a6OlWaN9EH43TTbCLMWGkx67m8e8c3HUCTyr1lsB2Jt
	Nc8hl1cdPuYJ4zUt8+A+mEq0OboXbnkl/KVVc+If90XH5vgIHdTvA1WswRnFOVOTL5kLtBjF+Dz
	g0cwNjpR5eAqAriEswjn4uUm9j0so80YxjqE7BtY3nQ1l91Vyin9zoRhWAVQlrWBnRKkVSi3gTz
	c+5mfYz93UglAGokgWDPqOEBAld8U3ovQl+BpRHUEbaeejhlHazkdtu+qN7dRLi353NYUPF6qHF
	mcCX2MR/NzGlaYeHjMzQKvPz3omB1xW1YXf+qN+rfM+83btIPK2TD7zcBaTnWT/kkNW0xwiLUoc
	fmxMP9aCiwzFqRTLOckcyzvSX5O7df2z79JXrVikk=
X-Google-Smtp-Source: AGHT+IEeOXQezqtJMQ7hsE05lMpf7I93JoBsZfK1rO+E+6ZkZi1qgfeP+uOP/QAPO7I5q02P/gEzWg==
X-Received: by 2002:a17:907:6e86:b0:b04:48b5:6ea5 with SMTP id a640c23a62f3a-b50bedbed80mr1895801866b.17.1760190391512;
        Sat, 11 Oct 2025 06:46:31 -0700 (PDT)
Received: from [192.168.1.17] (host-87-19-169-144.retail.telecomitalia.it. [87.19.169.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d67d2cb1sm479786366b.34.2025.10.11.06.46.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Oct 2025 06:46:31 -0700 (PDT)
Message-ID: <9b074160-68ea-4c19-83a5-8beb6eeb3768@gmail.com>
Date: Sat, 11 Oct 2025 15:46:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/msm: make sure last_fence is always updated
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20251010-close_fence_wait_fix-v2-1-adb332dbff65@gmail.com>
 <eb15cf16-f51a-4eb9-992f-158e2510184e@oss.qualcomm.com>
Content-Language: en-US
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
In-Reply-To: <eb15cf16-f51a-4eb9-992f-158e2510184e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/10/25 7:30 PM, Konrad Dybcio wrote:
> On 10/10/25 4:39 PM, Anna Maniscalco wrote:
>> Update last_fence in the vm-bind path instead of kernel managed path.
>>
>> last_fence is used to wait for work to finish in vm_bind contexts but not
>> used for kernel managed contexts.
>>
>> This fixes a bug where last_fence is not waited on context close leading
>> to faults as resources are freed while in use.
>>
>> Fixes: 92395af63a99 ("drm/msm: Add VM_BIND submitqueue")
>> ---
>> Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
> Your sign-off will be removed by git, as it appears below the '---' line
>
> Konrad

I sent a v3, thanks for pointing this out

Best regards,
-- 
Anna Maniscalco <anna.maniscalco2000@gmail.com>


