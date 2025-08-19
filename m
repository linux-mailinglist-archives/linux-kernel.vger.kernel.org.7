Return-Path: <linux-kernel+bounces-775859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACECB2C5E2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 207C1561A2A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91F3310645;
	Tue, 19 Aug 2025 13:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e09qY7GF"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB30322C62
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755610478; cv=none; b=bEqLUhNPYFSCEzdxT1P4SKEN70iVjQu3IBIZno97csw5lJ+WZGlqdBBFc+9ZPvyrXWyWTagXuWsKmXL3WBzPsKolQXDcBZwHNODfTYa+/blLGenwPY/K8SzDX3DTcBwc0qBaHC8hJC0Nm9cxNiulobPSwpj/RM2MJwuXM42wf6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755610478; c=relaxed/simple;
	bh=wipzgxzu/rUCZ24ZntLQzz9oqTSOOsAe7X1A0+zrX08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JpMzAoyPZLUXjVoPcqMMmzNQ5xPMIL4fKntAYnNcxH9hGBG3Jlvny7C3hxKfvtgaSvbGqF5tKLCuxlR6TdygTMA407byzL6/rzI9MbCvqztqX/3tlngCMDn0RskSI0RDtwEoez/Zk8M/2dTzQawj/LKqDBjNgOnE8Supt7qG6cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e09qY7GF; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45a1b00f23eso29662085e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755610475; x=1756215275; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a9ZFei03fy4ZPyixVVD0bhhT9fRXV0zABOzey2pvCiY=;
        b=e09qY7GFqk2uaOkiQe3ID/b1q5kb8s1xn35ziiaUZ+1zHECeWonxQJoPp6Y9dSOglV
         1oXZLKEbLZ+7dXCUFP9J7aXYENfzubh4muCxPj88BjjMLi/l6M4A3VNVxcHyFDcg3m/O
         9oizJST5wMvxj/eGXMcvcNAdLmW6ahOs+asL2A5+gNUiBiTV92Y1mZG18G5Yml1CCW9j
         YSpHjoL0w4c5uGtPtaDy5PwBKh0WeyuQkHwtTkayt3Mt9ohr5kQPI3VWrwpBNmOtHne6
         z1nNYT/j92GR3VIvPBolgSgf3qy/sHn+9PEByLSN9w35yffeVqlGZAYlHTFZMhqAmCAj
         juVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755610475; x=1756215275;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a9ZFei03fy4ZPyixVVD0bhhT9fRXV0zABOzey2pvCiY=;
        b=LhaMoJRC7A3KSVRsXpzjiUh5j79JaSiWWvdTiKyVsAq4v+zJ+8jq0C9a6cYeODGsAG
         QwvY5agafBzuweVI7ciQauWImL8cBo5ds+t5POsyRcpgv5WUvcVm/bzLr+2uk+29rRP0
         FywW82bmnzKRp1wswFapENnk6EpmUuem38q3e3lKDLeVyUHY40vWLEANYV/heiSGC3uo
         IpMZ//MYOc2cowFWPwxuECN2DdgstyGgUUh+Y4eaDkRIGamaUK5MxqxusdDsLiVcIkBc
         0V8LZMvjTzRkQWTVlHQgHwzcYgemO4OS4CFHLiR0eck4zF1KPO/kqSDRcdZvyvOmVnd7
         UZEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYNcVUC1kOCmZQXrZ+av4AzMgWKdhhj2uuPKo3EtI8JDyoMEjRYvLKGCDdAM7XzOAEv/jj12KuWcmvvMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDGgU24D4kp4B/S3mRtuoTzXtgTEX0GSYrjdON7x4u4TOCmTxi
	mvlJCJP4gqa9lh5DKFf/E7VOnIoh2dlOAGKUSyfL+FL47rRZHqRt6housnE79u4n/l4=
X-Gm-Gg: ASbGncsxZcwsT9D+bI4WBQ2lH0iHItOGMKnf+f3KZLbZyJG4rhFKAbwJv+mb6knACx/
	FgbuntLbV+48PuO3noLsPb7e/cnpOvjvgVTAAavE23ocZC2s87Jr5r6zuC5ZPeq9f7G0AqFCsaq
	icKzdqsjur/Oi4CCdDwrcB59ABVpPkJPXQqz/vetp1tEC9UtdrQLjwgNLT4ly7wH6aSp4xnWeg9
	OK4Ateoy45IHSmuByXQDS3o9BBMSS0lmF58mr+Y9vc/KA/d+Hl5uAjiNLnM2f+qOvKCccbvP92a
	0FbeQXwhO3nhNQvunq7kVSMb9r72xPMDWZBv5cZMCG0NZ98NS14J2jF67bobOPjFkyFxNY310kQ
	ltI/KJRNBHyrfcXNx9/WsAVNInmBqXexfClsRNrnuK/6rFQAXA0E+gy4fLbpwzP8=
X-Google-Smtp-Source: AGHT+IGA4uZOavHskRVazrBsrJEpwCCS9yNXa5Q7x4nDv12AaruKezbMFjMhYQNh3voiuKoxjMWquQ==
X-Received: by 2002:a05:600c:46c6:b0:456:24aa:9586 with SMTP id 5b1f17b1804b1-45b43dfff1amr20520035e9.21.1755610474714;
        Tue, 19 Aug 2025 06:34:34 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b42a7756asm40936015e9.11.2025.08.19.06.34.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 06:34:34 -0700 (PDT)
Message-ID: <552c0e8d-f3ae-4c2e-ac8d-f43cde5c5ccb@linaro.org>
Date: Tue, 19 Aug 2025 14:34:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/24] media: iris: Fix port streaming handling
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil
 <hverkuil@xs4all.nl>, Stefan Schmidt <stefan.schmidt@linaro.org>,
 Vedang Nagar <quic_vnagar@quicinc.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Renjiang Han <quic_renjiang@quicinc.com>,
 Wangao Wang <quic_wangaow@quicinc.com>
References: <20250813-iris-video-encoder-v2-0-c725ff673078@quicinc.com>
 <20250813-iris-video-encoder-v2-4-c725ff673078@quicinc.com>
 <40673a17-a19c-4722-ae5b-272082af917b@linaro.org>
 <8b9d5f6e-ee95-e4d1-3fac-fdcb277a7af3@quicinc.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <8b9d5f6e-ee95-e4d1-3fac-fdcb277a7af3@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18/08/2025 10:45, Dikshita Agarwal wrote:
> 
> 
> On 8/16/2025 4:10 PM, Bryan O'Donoghue wrote:
>> On 13/08/2025 10:37, Dikshita Agarwal wrote:
>>> +    if (!ret)
>>
>> I think you should have a consistent error pattern
>>
>> if (ret)
>>      goto error;
>>
> Its done to avoid duplication of code, otherwise it would look like
> 
> if (inst->state == IRIS_INST_STREAMING)
> 	ret = iris_queue_internal_deferred_buffers(inst, BUF_DPB);
> 	if (ret)
> 		goto error;
> 	
> 	ret = iris_queue_deferred_buffers(inst, buf_type);
> 	if (ret)
> 		goto error;
> 
> and more duplication when encoder is added.

Understood, IMO the pattern above is clearer and easier to read.

Up to you if you want to change it though.

---
bod

