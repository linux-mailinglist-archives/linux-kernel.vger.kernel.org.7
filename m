Return-Path: <linux-kernel+bounces-839044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EB2BB0B2D
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 16:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4106B174BC6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 14:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1B02253EB;
	Wed,  1 Oct 2025 14:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aUvI+eYy"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0713B212B31
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 14:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759328959; cv=none; b=qJs60+due658hHi/n2KreDtoRAFalAy308Wl8fYRvxhMriMj3udQM7xPqLNX/sIO4bdcTxeZn7XH+daUuDRIxw1m+LE/L7eZbIllCQniShvPPaLS2By0YR4dY+9dP26HlgH4zg2huHSpJbncWrnfishH5Se3QhdpXb9V/lYc1xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759328959; c=relaxed/simple;
	bh=WlD739qP7VTKZ110SHGt3slRhEvLXC7nKfut6lSkEw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a8Y8R3+zlEkUX0j6BAtE500sdHZkLJZok/eOsW6Kjr+JOY0Mr+HvW94UXwko1KW2i3rv1HmUMRZz5vbEWq3QE01kmdofU+hCQBhhWAeyM5m/hbTced21GEErAPwUipWmRwRcQs6vApjhtxgrEsFJovOuTQPoGqhfYnhXJ/6TQ7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aUvI+eYy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59197tFZ030557
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 14:29:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AngmzVKU/oV6H+AZt7Bg6MyTPIReuPNVTmh+UodZsic=; b=aUvI+eYyCaJWAOE2
	gIjvn/T47qSHbg52cG/Uv80zehE5FOcBzkac5BeChT6KTVz/tNJc981/Lo9gpg9O
	Tymeg7hwfmOFiQMj4tov5EZKq8kx9AkCf9wmoSGLdY9yS+pklwddQ1w8j79hDlHm
	49tzDWtEOmPmkCwDR8vzlatVUTVJ4sZxNlVSzyytHUmyOI73SpX31BcRGziw9JoV
	bBPmjIdJr9sPQSsb79nP4HBg3KgVZ+towgoEQHloNiI8G+ONz91Vx+cTuA9NTnNE
	7GRYIgZjEZOfDMtcvOA968zLLxrN8VYdc/pHa3gj+hogfdbY4CnPj72hiLBQdoTl
	iRAUaA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8pdmm25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 14:29:17 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-28973df6a90so39325025ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 07:29:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759328956; x=1759933756;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AngmzVKU/oV6H+AZt7Bg6MyTPIReuPNVTmh+UodZsic=;
        b=R+Y+QIaoiHcUKKFPdhoB6WfwbAonyM0qUUy9G5FeYgT3f/vQXsEtujB2RPhDD0h/7j
         I5+OgbC49VWOzih7qA2CpPwzwARg+uIxjsUhpuPajs12pN+eArhVn8MC/MeCDstm3nQk
         8/xXMUrVvu7OlHYGYwRWkYDj3IFih8rNMWmh9AnyvSdVXwE5qNHuVyv0LcwAN9jQJADo
         rmHbj/Nyf7frceyHOFMGuDcJiCHBnsJbObv3SjxfxA92mOWNOu5DRFi7Re5iC1zHbk/c
         HvtQyObHQQan7yKnZ5R+18s6konRgyjfINrwxEGenfHsqItiPSb9PXhYDwIVfcqKZhaA
         ga0A==
X-Forwarded-Encrypted: i=1; AJvYcCWdIC+8GmUmjzNKq6Ujd+VToct1COGUWB4a4ykm8jqlLpVEG6Va093RwMmMHwBA4UXXzVS0bIRV0fXYxXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBhd3u/gnAAwQEmluu+3GqWfJfigx+ZmSOa1BBhBI/9kOF8tBw
	cO6imLRg9OqEh7S0GCFh5fY5JgN/v0TfT7GPTUNX8w6e1kSF4buD6opHnwmCjDONYzoHRO7MLuy
	TVd4V2JbYeUFpUUqi3e8Lud3UxqI6JXAcCmD8cxCDwjE7x2QDopkbyr571T342eqjri8=
X-Gm-Gg: ASbGncvmP2mLOY3X4xDaziQDfQhCxdgfqBKfRj0dyxycJobFboDkUaSXFRvodH9hqAS
	EM2EIe3eQXqTVkHFK+f+47D+ZRaTvWVlBOrh8xYwcvH7daXz4LIFx0juC4o+wfKIUDvyUVf8muH
	HyX5f6JK4UW6ge06hqidmP8YCEkuDc4Xlxlh7g3575/y1BCt3Hj0HUDHgjo8Ld9qCv3vmT3khP1
	ulgCLE4oKNHTF2sczUxnpckhWNWwfpfQGtRT2lWe2IsCKSqk8WlwJOtQ+iOleIXLtoYosPH2qhr
	0/Zm8z26Y2LRPpCTFMSYOuElcsjzD4iHCIocB3KipETMrIblcXaJNBZz3cU98EM1SRiPYEVgHnx
	pnpF6
X-Received: by 2002:a17:903:b46:b0:252:1743:de67 with SMTP id d9443c01a7336-28e7f318717mr34851565ad.44.1759328956260;
        Wed, 01 Oct 2025 07:29:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQkbu1V/f1BevfiWTG4h561qbdd55zTM39aBJ0rupqzJ7d5Iy/uUX6B2rW6W5ql6/AELVUPg==
X-Received: by 2002:a17:903:b46:b0:252:1743:de67 with SMTP id d9443c01a7336-28e7f318717mr34851035ad.44.1759328955335;
        Wed, 01 Oct 2025 07:29:15 -0700 (PDT)
Received: from [192.168.0.113] ([49.204.17.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d2ffdsm189608215ad.18.2025.10.01.07.29.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 07:29:14 -0700 (PDT)
Message-ID: <b2eda648-9c2e-423d-8068-3ff95e741d70@oss.qualcomm.com>
Date: Wed, 1 Oct 2025 19:59:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: pd-mapper: Add Kaanapali compatible
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com
References: <20250924-knp-pdmapper-v1-1-fcf44bae377a@oss.qualcomm.com>
 <6f8583e8-2a73-4795-8eb8-5f1b763b36eb@oss.qualcomm.com>
Content-Language: en-US
From: Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>
In-Reply-To: <6f8583e8-2a73-4795-8eb8-5f1b763b36eb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: jynZblVP6c3CBxAd-DZkkX2AXmcxPYI1
X-Authority-Analysis: v=2.4 cv=MYZhep/f c=1 sm=1 tr=0 ts=68dd3abd cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=/JTPBhwEQko7YaD0RKblyA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=x6YHpMzrCJuErKLu4owA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: jynZblVP6c3CBxAd-DZkkX2AXmcxPYI1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzNiBTYWx0ZWRfX/OaK4ZOuzL0D
 XAgL4oadMI22IhcDwA5SLOCDG0ZLp4CTVF36uAOSaMXVrsPV5qZ250Z31tR/E4K34u9L4YS1cdQ
 yj2sR5bQ6gqVVvvZz3G5KnT8HuTKB2FH0ZYbZKgZZQ22dKaortCeVggrmkv9IvWa05Zh/cLd3G3
 msdDyKkr+TerQbQDj6A5xKimwq8Ol3AbH23j9cWD0eNXmJumh/PbDF9Kg3GiMHPR2MYVwaLa5uz
 71g8BRqDRpO7GI8FA5ByETfBhhU4nA1pbErT9f4ZIhVzNBts42vFGybYS3/mtAj7cpm11V/Rh+b
 fxow74veKPEyeUysjqxH0CzvIXJYJHChouqrg08O/MaOdEdvWX2eeWdiH0Hj3B4BTEOY1ZMp35N
 K1Y06IhqYi8JtFwrqml1BtbSwSzpIg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270036


On 9/25/2025 2:24 PM, Konrad Dybcio wrote:
> On 9/25/25 1:58 AM, Jingyi Wang wrote:
>> From: Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>
>>
>> Add support for the Qualcomm Kaanapali SoC to the protection
>> domain mapper. Kaanapali shares the same protection domain
>> configuration as SM8550, so reuse the existing SM8550 domain data.
>>
>> Signed-off-by: Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>
>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>> ---
>>   drivers/soc/qcom/qcom_pd_mapper.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/soc/qcom/qcom_pd_mapper.c b/drivers/soc/qcom/qcom_pd_mapper.c
>> index 6384f271953d..bb2eeb955106 100644
>> --- a/drivers/soc/qcom/qcom_pd_mapper.c
>> +++ b/drivers/soc/qcom/qcom_pd_mapper.c
>> @@ -552,6 +552,7 @@ static const struct of_device_id qcom_pdm_domains[] __maybe_unused = {
>>   	{ .compatible = "qcom,apq8074", .data = NULL, },
>>   	{ .compatible = "qcom,apq8084", .data = NULL, },
>>   	{ .compatible = "qcom,apq8096", .data = msm8996_domains, },
>> +	{ .compatible = "qcom,kaanapali", .data = sm8550_domains, },
> Doesn't e.g. 'msm/adsp/charger_pd' need adjustments with the move to
> SoCCP?

Yes, Thanks for pointing it, Will create a new domain entry for 
Kaanapali and
remove the charger_pd. Will update in next patch.

Thanks,
Prasad

>
> Konrad

