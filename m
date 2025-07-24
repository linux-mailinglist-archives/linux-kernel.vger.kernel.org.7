Return-Path: <linux-kernel+bounces-744521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87885B10DED
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0D747BAD0A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEDF2E2652;
	Thu, 24 Jul 2025 14:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d49lz9kE"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FEB2E041A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753368254; cv=none; b=EcdLdT8KiRn/fRzPxe+BC3DQDpDIIuGtd7gx3uCMvZjU41OrtbGcIk6FYvJET3IXHe7TTI5fkzzJAskHjwOzaZINGcONULz3ReN/RAaQPTLUK/LVcachZtwK3QzTnx1h2hWZ5ek+8U2ZCzvXj+nFD+evsZFXmBER1bJ4fB2ThCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753368254; c=relaxed/simple;
	bh=wvW6Hz2DgVHLdOrh27MlC5dgHBHuWnEVmc6aahJ/o7U=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=CciwnJ9W8P9JQCHo44gWWx47HMhgLe8ijOaMTtpSEZQAdv18OJyXEBvk/zWhWEXSJODUnVFceBtUVS+DNBR1ngfulji9y3Qw3kn1UiNesA3CixLxdyqxOF+3oxTUiomM6KV70LUpomowr4XVj7CPsGZxY1gON7TRsnEGcx5N9Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d49lz9kE; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-451d6ade159so7210945e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 07:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753368251; x=1753973051; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h61dAcV4h+YntxpGoUH8VGIIIUvkHb2+OkdP23t55x8=;
        b=d49lz9kEkZ3aZlAutVtwrkYcY7nKPl0qQNfiWIIbWZbpPCghMPS0n70hdoCulDr98T
         aE7BK4fS84FgjWW2nYb05WVyvWVhhAMbDquvH4w70jp5jGbP8HEQ/F0qErxmnrCzDpOR
         AJeHlSBq74odCow7QZhFrAOW8nZ8KcBXLopKtCe/Y7tIGOe+GwXKKGIpNIAd5xtXieru
         pm8PRUvaWwHRvIveQejsnEtOnIVZGmsjVTzlJlD+PcnK9u63Sd7Kw2rpwRXnGLuTEoLG
         1q9Hv4vWca1OsnFxIp3dnHVujvnYwmN/Pix2Y0Xz7dor5ERLLSmpBLC+lIASWKkAt0R6
         D2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753368251; x=1753973051;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h61dAcV4h+YntxpGoUH8VGIIIUvkHb2+OkdP23t55x8=;
        b=YNrG+sCXlX9Kiv2ZCIaSvLj6dy5/Sl1IpQiQDRPw3oolsPViojI0+0WVj+4UzHHkkT
         YWWJY47TxXaXXTkHCMtWMnlP21Y75qHlgIR8KAfogVhpLAtu0UZQxkCCDMXHHDkVItt+
         CFS6tCxLUkfpKmrUW6rdgZQxMo+hLahav8Zuc/qAVNZni11w0tmoZnQtNfJ0pYhrIBBk
         5Wd5JmAArF8fU5qGAiCRkjbG4tMnld5YemC2XLWnjx8i/JUUYaVunAc5MsrjBO2BpPDZ
         Uq37tiYKnyHtuMtxt666RHF/G+61k5ve5blK11wVAC0OyjO9TnqMQJpUp7bhZ5fOXfIk
         7bmA==
X-Forwarded-Encrypted: i=1; AJvYcCW0XSraJ7O/TjLqPGZFiYuq8d/b8kA8/WRrpmVNqPb2Hsao6e8LXEW9PCeOTdaP5ct9LWdDHAuSU/JjplM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBqko56+KRBBED7lTpPPq7JWN1Rhp3YNBvBVje+enxJKx3kGCn
	7so8kXi9hW3qn52gETiavhFHwcBXS6GM5JNNHnIMNTtDAYzSrCLdM7svar3JyiisZKQ=
X-Gm-Gg: ASbGnct1cFKhzFg7ZfkR9gRYOx8v62jplNtP+5x83ZmGf8nT+3CSwxtfSgBub109AKw
	NFLSfoHqd9aCod7xzxf8fK9Tm7PKtY6oVfl8bmdIKIevfVtYhWQN4wNN4q0mpV2bvcKtQM23pHf
	/JKuFQhpqObS17D3rbPoF7zezbCjTyfhZ/t+4b64gfYZMariZlBiy+u3psiZyc5ZlqMTUCP2tEt
	aOWTUbZSnIu9jOa8UfF5FmJQn5IMOpBgNLBGNIUVIlv9ydyMEsSqaW1XmUjVzDpKvbAe4j2QqyM
	fGzTu0ruzS+ViVtRXNPXuWxULtVh5oX5Wi9iFIxwAbOxLDXdarPCJlHoqLE/NJ00x1uAeuZdjrn
	SRDtSWBQQbN79pKmudnbfd4qpPX0tXExVWdt8hsapjFXss1xcEP08TyTedi0yD6cCJUXUuPVrrF
	V+/g3zBPulFQ==
X-Google-Smtp-Source: AGHT+IFGgQDhmKjsxwQeeanUSBp4sAHQ1P3xwlEiMitDwLsVw1OyZFVplMZ/sj3w25qrYF6TJH+r9w==
X-Received: by 2002:a05:6000:25c2:b0:3a4:dd16:a26d with SMTP id ffacd0b85a97d-3b768ef3c59mr6524335f8f.38.1753368250912;
        Thu, 24 Jul 2025 07:44:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:e2d3:d328:dc00:f187? ([2a01:e0a:cad:2140:e2d3:d328:dc00:f187])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcb89a5sm2326994f8f.65.2025.07.24.07.44.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 07:44:10 -0700 (PDT)
Message-ID: <53e0ae24-c32a-4b6b-a0ea-b056540c2f3d@linaro.org>
Date: Thu, 24 Jul 2025 16:44:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] drm/msm: adreno: a6xx: enable GMU bandwidth voting for
 x1e80100 GPU
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250721-topic-x1e80100-gpu-bwvote-v1-1-946619b0f73a@linaro.org>
 <ac476949-d0e7-4058-ad76-c3cc45691092@oss.qualcomm.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <ac476949-d0e7-4058-ad76-c3cc45691092@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/07/2025 16:35, Akhil P Oommen wrote:
> On 7/21/2025 6:05 PM, Neil Armstrong wrote:
>> The Adreno GPU Management Unit (GMU) can also scale DDR Bandwidth along
>> the Frequency and Power Domain level, but by default we leave the
>> OPP core scale the interconnect ddr path.
>>
>> Declare the Bus Control Modules (BCMs) and the corresponding parameters
>> in the GPU info struct to allow the GMU to vote for the bandwidth.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>> index 00e1afd46b81546eec03e22cda9e9a604f6f3b60..b313505e665ba50e46f2c2b7c34925b929a94c31 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>> @@ -1440,6 +1440,17 @@ static const struct adreno_info a7xx_gpus[] = {
>>   			.pwrup_reglist = &a7xx_pwrup_reglist,
>>   			.gmu_chipid = 0x7050001,
>>   			.gmu_cgc_mode = 0x00020202,
>> +			.bcms = (const struct a6xx_bcm[]) {
>> +				{ .name = "SH0", .buswidth = 16 },
>> +				{ .name = "MC0", .buswidth = 4 },
>> +				{
>> +					.name = "ACV",
>> +					.fixed = true,
>> +					.perfmode = BIT(2),
>> +					.perfmode_bw = 10687500,
> 
> This configurations should be similar to X1-45.

Including the perfmode bit ?

+					.perfmode = BIT(3),
+					.perfmode_bw = 16500000,


Neil

> 
> -Akhil
> 
>> +				},
>> +				{ /* sentinel */ },
>> +			},
>>   		},
>>   		.preempt_record_size = 4192 * SZ_1K,
>>   		.speedbins = ADRENO_SPEEDBINS(
>>
>> ---
>> base-commit: 97987520025658f30bb787a99ffbd9bbff9ffc9d
>> change-id: 20250721-topic-x1e80100-gpu-bwvote-9fc4690fe5e3
>>
>> Best regards,
> 


