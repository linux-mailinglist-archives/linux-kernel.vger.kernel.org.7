Return-Path: <linux-kernel+bounces-803396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37957B45E96
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D98791C83D17
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672B7309EFE;
	Fri,  5 Sep 2025 16:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PdAciHQ2"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4EC2FB0A2
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 16:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757090868; cv=none; b=lCJWwWEXC7uHbGlqabNzIyU8m4U1g4AqkNk2GUTKbXhQswDxvcGJzWqAuxiSVZtNoVbwg+osFIRaTHH2oVQ28JE9xrG4Kd/URxkpNRJAfRf/GM+Lr44bBCBqKxN+GcMu7WE8D6vlQhOEwlkW/SEj/c349ZFvp/1tuyeJaIBazIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757090868; c=relaxed/simple;
	bh=TkfY89RKRXEALwgB2aNVJLpg692JYnKY4FfUhrmhjUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aVWG2ds3qHbdVb/jGC89bKAQFNo1nEV9Vn/Tty8wngIkmYbE5u+/SMf5Oni1oSVMgMpE1MPjaThdiwsf3XaOihQxDgKKuiYJtY2iFzY9Ezno5zSbIPkJBEUZoIYxFaSh+sfEQ97+VfQh+YAVj4R2LWm5HsYj+NSRpXmZM27+kb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PdAciHQ2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585GKM2c031930
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 16:47:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UUdgNg/39urdaUGy5tuNL+v9wjA5hMimn7UR8IzRX/Q=; b=PdAciHQ2LJAlN3lz
	mhfyemdXnUhAmCxtsYv54lZFu/YK+QqDMz9kGCQys1dPqVHD/b2muwcqnzvC4RaO
	nkW0KBEzjPRZ7o8UL/I/qrEQCG4soGkbi6y3GUpCev3WtEY//5mc32yEInyBXeFe
	hcjDPgfoaHE/j92vUC1xCyRznE7QMlR/3VDlzq/dsowpB4D0/Ojf6phUR90hGkSy
	q/1w+aQ0L5hGwBSU4E7SFZEiZq++32A/Ys+XvNs0A+Kzi48Vs11OCKA8+ZTeDHyg
	WV0KqaxhM/YrHWwFqbkZfYeJ/KjBl1/E+b8intGJlkacHB1gEEhBcm6hI/9ENAWx
	47RKIA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urw0bx8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 16:47:45 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-718c2590e94so65199236d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 09:47:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757090865; x=1757695665;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UUdgNg/39urdaUGy5tuNL+v9wjA5hMimn7UR8IzRX/Q=;
        b=DaC41D+RF/6UUtrsJbZKejfMbdEztt5yysyji5QdqVuQJQa9PQ0bBRV6rpYMS1V971
         m5O1CHVLXl/58wzBsEqbCBq+kCPwwEeYhFhrkD1qhM4zi5Qv0hrZkUT7jD+D0AyIeIly
         pkl+h1SJUI/2oFovGcy75BI0Z2kAoWfYCJQ1VKsLvgmmtHzXReyl657EkVILtPX+yaEm
         GgK0/uhARZKotVZIJy7DsHGatdzY5ae6FHSBYy+QmVIH/wNll3nIePw21rBtyfkVKZ9D
         NF3b35JkZ8Mmx2OzO7hOHz5vlXLKq/yAiv1qu6M9PiuB1h6hEX9FOHaiy2Os4m6IVK24
         gYwg==
X-Forwarded-Encrypted: i=1; AJvYcCVy+IaRj56vPZU9rQo8Jik2x4rmTt45VYM7crSe9PgJtfbzbhqqZDg7edIUjyn0n9RD6sEohCvxVyJcDSo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9WvxY7z9ojoeea1UxafZG4ukdjc0bgeNm1cbPvCJVh4LMl1+E
	hloMnjoRupDMIS4YlpiuyhlkcoJ/SSguwsEK2LYCBxurS14MMtIKCfgk4AbGYlQTHuPj4iN/Pts
	FvTCWZ9qyWpkKA4VN+MQnNm++IDOBH2WfRglHRZmwbRBsKFvtu2DWpx7eMGVZw5OWfAo=
X-Gm-Gg: ASbGncuuvQVJaoou3C65uXlN0VYK3KpJC+/1PIKvt1Qz59A1xSu/wh63j5zeAk12j4+
	FevbYIWfKF+hLnnYYD5PskDLXNkcNBOIXzCQfIF6lFFnCCaFEodeog6lL2IANUn1wTQff5s/gKU
	sMk9R5XmCjJyWg81Bq0+uoUnjYr++/oZJVzTUBjziaHJProk8mX7S3/WqhGOk+dJNIzhTGgypru
	P//MZoAAtP6h9hhsU1+Pmw2Hkh8asdKuj4+DrnK4inPPnYN1ERN2kvNHk0oVLhAy2yfYTqjXxPq
	Vnw9Cn64rsL54nwIHq89hcHkLMKtA1kNXVHgg7lajh2bwLZkMOQCanVwtVfp7AAk1Xk=
X-Received: by 2002:ad4:5fc5:0:b0:707:6cf8:5963 with SMTP id 6a1803df08f44-72bbf3fb0b1mr43965526d6.9.1757090864920;
        Fri, 05 Sep 2025 09:47:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZ8+8+MxEUmtiGkpVpKbOO3CIojnpVHP4pNFKV12I5SozNXXmspK50f6RKTZrWEioefG8OdQ==
X-Received: by 2002:ad4:5fc5:0:b0:707:6cf8:5963 with SMTP id 6a1803df08f44-72bbf3fb0b1mr43965196d6.9.1757090864286;
        Fri, 05 Sep 2025 09:47:44 -0700 (PDT)
Received: from [192.168.68.119] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3d66b013b7dsm20987137f8f.28.2025.09.05.09.47.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 09:47:43 -0700 (PDT)
Message-ID: <08afe342-e108-4f0c-9903-fb4df4eb860e@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 17:47:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/12] ASoC: codecs: wcd937x: set the comp soundwire
 port correctly
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, tiwai@suse.com, vkoul@kernel.org,
        srini@kernel.org, yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, neil.armstrong@linaro.org,
        krzysztof.kozlowski@linaro.org, linux-sound@vger.kernel.org,
        Stable@vger.kernel.org
References: <20250905154430.12268-1-srinivas.kandagatla@oss.qualcomm.com>
 <20250905154430.12268-2-srinivas.kandagatla@oss.qualcomm.com>
 <as3wxoths3rgy2qpbqwyys6zydhjo3lbueu7ibrwbinxt3sffw@wyprroihsjs7>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <as3wxoths3rgy2qpbqwyys6zydhjo3lbueu7ibrwbinxt3sffw@wyprroihsjs7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: DxnOfT02X8s6FrXvrNwIn1tMU2_QQ84X
X-Proofpoint-ORIG-GUID: DxnOfT02X8s6FrXvrNwIn1tMU2_QQ84X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfX1kw4zPPaikc5
 zDMMs1eB/bXlLwfvU0ZXsXS1BQDwmkerknVkcWrohe0Dwlqemdr8cvGhfEHIslM6OIwX5DEc6a0
 5hUrTx7YyUe1WSF8fNhyoVi9Vp9AJ/6ZMF0siKJuch3Iil7GfbeULJlEojcqi7riiUsI8/OWNW7
 WYVDxQ+2LVI+dfrMWGsAUN1xJkYCt3Kt+wpvduw/83dVFcO0RuOEhartPUE+opzwt7KNPmuTaFK
 2Wkly9u6l447cq5gBzxBLzd9MgGmWfrXt9MHClzbJX5Vid208pKMtoWdle9vGx9wYQ/6MQHfaif
 B/HXN132OFv7Tjd0X6FDZQO+KTqyi2Wc9Ll0rbja567kNhbczrOuBVnNWIU079jkEb6nf3ioaEo
 sSOBkIUb
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68bb1431 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=OWw5mONqTAKyzQI3keYA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027

On 9/5/25 5:14 PM, Dmitry Baryshkov wrote:
> On Fri, Sep 05, 2025 at 04:44:19PM +0100, Srinivas Kandagatla wrote:
>> For some reason we endup with setting soundwire port for
>> HPHL_COMP and HPHR_COMP as zero, this can potentially result
>> in a memory corruption due to accessing and setting -1 th element of
>> port_map array.
> 
> Nit: if passing 0 here might result in a memory corrution, then
> corresponding code should be fixed to warn loudly and ignore that 0.

Agreed, This is something that should be fixed at source am on it.

--srini

> 
>>
>> Fixes: 82be8c62a38c ("ASoC: codecs: wcd937x: add basic controls")
>> Cc: <Stable@vger.kernel.org>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
>> ---
>>  sound/soc/codecs/wcd937x.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/sound/soc/codecs/wcd937x.c b/sound/soc/codecs/wcd937x.c
>> index 3b0a8cc314e0..de2dff3c56d3 100644
>> --- a/sound/soc/codecs/wcd937x.c
>> +++ b/sound/soc/codecs/wcd937x.c
>> @@ -2046,9 +2046,9 @@ static const struct snd_kcontrol_new wcd937x_snd_controls[] = {
>>  	SOC_ENUM_EXT("RX HPH Mode", rx_hph_mode_mux_enum,
>>  		     wcd937x_rx_hph_mode_get, wcd937x_rx_hph_mode_put),
>>  
>> -	SOC_SINGLE_EXT("HPHL_COMP Switch", SND_SOC_NOPM, 0, 1, 0,
>> +	SOC_SINGLE_EXT("HPHL_COMP Switch", WCD937X_COMP_L, 0, 1, 0,
>>  		       wcd937x_get_compander, wcd937x_set_compander),
>> -	SOC_SINGLE_EXT("HPHR_COMP Switch", SND_SOC_NOPM, 1, 1, 0,
>> +	SOC_SINGLE_EXT("HPHR_COMP Switch", WCD937X_COMP_R, 1, 1, 0,
>>  		       wcd937x_get_compander, wcd937x_set_compander),
>>  
>>  	SOC_SINGLE_TLV("HPHL Volume", WCD937X_HPH_L_EN, 0, 20, 1, line_gain),
>> -- 
>> 2.50.0
>>
> 


