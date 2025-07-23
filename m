Return-Path: <linux-kernel+bounces-742108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 231BEB0ED56
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 800C73BA611
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 08:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AFA280018;
	Wed, 23 Jul 2025 08:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cjreUs4z"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2BF279DB2
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 08:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753259652; cv=none; b=RCb/D7YT521GLwNtLuXXGU7bbd4vYpFF89zj2iRArgkIZlxeM+u/E7VBBIyjvlnIrgz+FPAll8jGQoDvURDuOIGO8psdJqix4tBjio/ry+87WB3kj9m6UbUFeVYMDwvRoEKlZQy65KPqN4gK8d/MESaTdy294CQWiYt4HKU79as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753259652; c=relaxed/simple;
	bh=fqqTU5Q2Wts1JqfPaHt73vG1jMrBA1lvDzSJGM0bLjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kTU+WB7uTvaG7ycALo4jH5bJhplcoTmnJEOmrgwhQZG8su9iYbYcRiUYywrM+yZYzOGaPAaX/454D45HEtOqzDgC0LyrZ4cInUwfEG1kQGSlCZyFLmWFhTw7WvD9JskxAMaG+MMWF+YCNHJi5mTO0TSW/dfz61/E4mI8vj2ozpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cjreUs4z; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4560d176f97so68329935e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 01:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753259649; x=1753864449; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zKVnFomYy8E8KQwcfNsj6ulD0Xw2fyUDVFD8613P6Yg=;
        b=cjreUs4z8imaUe4vpRGLubhJENAEX32Kgx6Jv+ZYY19ztwb8fs3dLnNj1aEKU4xS8h
         GYsvABMAcqp5PXWk12WcXkarwisabnVUPJPh+TAd7Xqfv1iDu0eJyYdObqcNn8a5VmR5
         jT/so9LD5REEpZvPVfJVzFpdq1pM0p49HB1y7UQ6Pklo6s219CXyahVGtUi+VeTA2JRO
         lG0/r+2RCY02SPR1MbkjhVhpuqrVpv3VwXlPZPLMguO80FZzYr4GKtPBhJ6ayDZzfSwO
         mGtOFZ7Btzz2XS3J6NPspBW+w12JVAseGT7uMgHIh1SRUvoA/+NfBBvo36/YqEAGSkqm
         lI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753259649; x=1753864449;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zKVnFomYy8E8KQwcfNsj6ulD0Xw2fyUDVFD8613P6Yg=;
        b=HTxK9/wWuDsOkPnKCUVNaMSw8gelEl2taSAGlKQBD7pFO7z4rMwTJhagT76BxFXJxr
         ZMNsItr4dxahhvBjiPF0qcIdkVm2HV+VbFJR6hxAJKe845gY3ECI5f+oEzY+ITtTw/h8
         SFNbRKZjnNzRKC745Is4cMmkZtmw1qvr+3HNd1J7qGeHKCZzpClY+zax7RZXj3pjsRro
         X1rsm00gURe57cpzmu3nKBYQPWAFYfhIKwfUXMYMlGbNXmbCYf5gnpYv14h8tVwcxkLR
         H30wGWAHmaudbaUlo4ky06Ixl3Of7/1lhjKWnOOcLZwlGQm3gZLnnuHM35G85g1aciIa
         axQg==
X-Forwarded-Encrypted: i=1; AJvYcCUBgKZAJBGBuqyd4NOPr+THqHs8irytbJ9JSAt2UweG1Rju+uCEawQ87UEBBKSeIvsy6H7QmgQfY75E1QM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7BwELLOb1TjcNuwbtORDQ9OSEe/URMCC9RE54bHb3LR1VkPY3
	qxTAlQxqEV2f90c08I7ZTbXcnF/1NR8nAAV1znoPXE5XYTkUvSBxZHG8zESdQtzODrn8PcGGsku
	tK/lzowE=
X-Gm-Gg: ASbGncvof2CMck65mCN52Tj/MTMTJNRATLClPXULFg5KSK1iS6b1VtU2bUCVW4MwCmU
	9Ig4aKZ0W2CPpYP/sU9JfeKcEmarjubhBx/Rl40SwbUyVs8ieW7RjiimaO6NUeYaruMPEtY/vvf
	0WZVOCdIPVSrXf4gKtOAHy3q88Ffw8f6j7rjM6YCTKM+7EL+qtn7WuG4wbaWznPc4/eFHR8B+Z6
	/Cta7KkxYja7rBMoz8hvnjB2gztV2+NLn1BMpGhD3VPfscVv48YplieqYqP9g8tsQaugSq0hYsy
	DX96SalOuEM9sW2tD4UR++ubRBiPrsryY9bHB0QwpTp5xVAic7WwI1frXOMFjM6mCZuMYhakAC5
	edPhjOlJGYjSWimzVClQK1gLiznLz4iVliyoiSFc0tSTsRRjfITB8TDfDuwG74lA=
X-Google-Smtp-Source: AGHT+IHh6It645AxDuSmVuSvYrBa/qT8yZ8JYoP6ZpWAS5lzUHw2g8ZbWyzuQU3s670wb4c/O9V4bg==
X-Received: by 2002:a05:600c:8717:b0:456:26d1:445d with SMTP id 5b1f17b1804b1-45868d4ce4cmr14590345e9.31.1753259648734;
        Wed, 23 Jul 2025 01:34:08 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca4893fsm15791493f8f.52.2025.07.23.01.34.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 01:34:08 -0700 (PDT)
Message-ID: <cea0acf6-5ffe-4cce-87f4-12be3c8f31f0@linaro.org>
Date: Wed, 23 Jul 2025 09:34:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/25] Enable H.264/H.265 encoder support and fixes in
 common code
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil
 <hverkuil@xs4all.nl>, Stefan Schmidt <stefan.schmidt@linaro.org>,
 Vedang Nagar <quic_vnagar@quicinc.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250704-iris-video-encoder-v1-0-b6ce24e273cf@quicinc.com>
 <f48ac2fc-2239-7ece-730c-342b495b8986@quicinc.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <f48ac2fc-2239-7ece-730c-342b495b8986@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/07/2025 07:40, Dikshita Agarwal wrote:
> 
> 
> On 7/4/2025 1:23 PM, Dikshita Agarwal wrote:
>> Hi All,
>>
>> This patch series adds support for H.264 and H.265 encoder in iris
>> driver and includes a few fixes and cleanup in the common code that were
>> identified during encoder bring-up process.
>>
>> The changes include:
>> - Enabling support for H.264 and H.265 encoding.
>> - Fixes and improvements in shared componenets used by both encoder and
>> decoder paths.
>> - Ensuring compatibility and stability with the existing decoder flow.
>>
>> All patches have been tested with v4l2-compliance, v4l2-ctl and
>> Gstreamer on SM8250 and SM8550 for encoder, at the same time ensured
>> that the existing decoder functionality remains uneffected.
>>
> 
> @bryan/@vikash
> do you have any further comments on this series, I have few smatch/cocci
> fixes which I plan to push with v2.
> If you have any comments, I can address them as well in v2.
> 
> Thanks,
> Dikshita

Will review this week.

I have it stacked on a Hamoa tree and it passes v4l2-compliance but, I 
haven't put it through an actual test of the encoder yet.

Will do ASAP.

---
bod

