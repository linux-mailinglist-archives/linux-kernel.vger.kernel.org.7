Return-Path: <linux-kernel+bounces-880489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D1CC25E0D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBCC21A2198F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D3327467F;
	Fri, 31 Oct 2025 15:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K/sQ4NRY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G377tDWt"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61942DC78F
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761925412; cv=none; b=abCL5Zp05x1JRNRDw0jI468Nvv6OHb99BErDyi5kGDpx/yYi0b5T8MztFirT6C22Q3iA3B+m3CkVNRr0U1XvNx8VIjqVu7v1csOdZKWXLAqsEDsMZf+mk5dyX4BeRU6kseGcrDtsP93Hp7Expqe70WvseIHEMboBXl/lo1EJ/Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761925412; c=relaxed/simple;
	bh=LU4zbDVx4NbF8EhWTlBBqiKUrpuABwRR04ESl5ewXWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XugjdjpJyytAsGlO0Vu8yizGrIClhS0ByJnPSbhNHZxs8aWA/xWeQTPkvzlQ7BUOV02HUd1qXSQyVNyfUMfVbCNbuNApio0ghqcYur6y3RRh4Re42ZxGxUhWB/j+1AY+skjNv5W4hSQx+4q8ZYEJI/pFxXdzKRgLhBGIymw5ZxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K/sQ4NRY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G377tDWt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59VDJPAn1827332
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 15:43:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4JFmZvuI7Px4Apbk0cnCG+kjMARdLNyYjmhmEWKvxe4=; b=K/sQ4NRYmSLBGIpo
	3uMcLBcwLEFQ+C6z/3XPMKqSqc4mBX+EkV6d/DvRjNvw9iypt1yAya5X/S9KCExX
	jPzBHOepU1TwzF+DbbckBcO9V73oNRbj9XDJtuOXROQKd8Fl9/etunalv3cGpJNr
	+OFlsLm5wX78l8cl4jzocBIYsrm+rmLXlnCy5hDdnHJmvcueAzLIg4OafpdCH+VM
	aVs02kgsr5LzO2nciYm0E2zFE97+GFWF5BUu3KOETNf0hThTTg8Mnsf0GIeOWW8O
	clrm9nyuThytGDYLPTMqS8DgNSL93P1aIRSYAmYnwlWZ78kXLsgkdzWwl/hTPBjd
	y6TdoQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4p11ssmu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 15:43:28 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4eb9e480c15so31765151cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761925408; x=1762530208; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4JFmZvuI7Px4Apbk0cnCG+kjMARdLNyYjmhmEWKvxe4=;
        b=G377tDWtPi87YotKnKHidIhj/yowwqQH0I0fedyFoExeChWQ+mDn5ExfPa7LFE04Kv
         C1QxCMdXcXikduK59YSot9amjFAvaX2QzWhixs2h34h8pXGqiIlKDMQhXFNflryzhfBC
         qbzTxLM0MXs3PT3GDmxNpg5TIhxgB0+y47gqkJab0K9JXZ44U8qm04Wttn1RXCI2CZ5C
         teUUUo55NH/tZM2NqTV8Q+vzP4ZoF2ukrxlEHCib8mPY8bqfIMECCfLHheDPgv5izBd/
         DpVohv1RfD16RGC8mthxpXjujqUmsC7623ZonaOmV188LMxgeG+zH08LbrA/HEpk5HOP
         UN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761925408; x=1762530208;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4JFmZvuI7Px4Apbk0cnCG+kjMARdLNyYjmhmEWKvxe4=;
        b=Y8Onslg0yu1VFjTeTlpHoPvzI/ZFs6BMhhbPxAJ6k/5u9g7LZDG69X+E51nfOiq375
         JY6mvyyXmJt4jGn7DhvWrXIoz53FsAVq8LZ8o0dHit1t8XerlJWK5rV77i5e0ytgbpqw
         ZpxRU4IBuodXSw+fiDPOK6SDSJp/XjavycHmWkpH7GS3Jx07jCmTGrMN/IZ+Yq0rbV78
         m72uy3zdJlrrRqOGksxwyvh3v1gAm80Rwk0jFF+0KyJW+iEeuXBFdXFiauZQWq6Y6viI
         eJ33sa3VEFDCwNz2M2S923k+uH05nG94I63NG1CQS9+DIO3uXyhijrzftAkomiOxhly/
         4MbA==
X-Forwarded-Encrypted: i=1; AJvYcCXoIZHhR6Pd+rvGn/hWyM9zH48BF5EUF+ZGcPJZElCy9ynIslE9G1jEsHWa6xM4dRdJph1flNJFTvNkhn0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1fAvXpoaeKXeRw1e2+p9KbzHddiIGQ40ReBV87dM253ZEjyBz
	JTZiaPyyfh21vnzuJ6c3RICDMXTHBzNbvoPVmGEttVyHOKLO/32TJQCaomtdovdR2gO7QGYxS4D
	HbCQNWzsdT53eOpVN8+5apWSVFLuGM3+0aQviNx01ypbV+bHxk/DpDceRdFs25J90Ves=
X-Gm-Gg: ASbGncsY5XT04aRY3m5z+xR3wtTf8yJRDabPgR4nbM94ZXu9E1taOirAKXM0HOQrP1g
	gRhsynCoypLfj9ApAQLlLqRPeTKArXlYCJlq4hOakoKfzX5Y0iiKehMFFTyoKtCrh/f0JAIdLcE
	yZk0CBR0HPRq0ki4/e/ebsJeRAgfNcyRg6WKy+gM3ZhXdi2FPdu8i+jeXJuBZUx1EQfvP4qs/93
	6ts6wMKc+Phtr78usf9f+QQwvMuK+Dgp0qiEAsop1QZ0X3sGRRkFvo3n1vje0wceJQherHiQS1z
	8l/eF4/yW+8pcF5JayMbPzn4RjI2VsttSGvO4SL2CWqFTw0yCHLlCfBoCUnFZ141vuOaWQzBf0D
	wECjW8NSDk4DJsrlWa0cHGSjzP/IiANPYdwC3SQ2ajoLN7JSsFa8080ErpR0LlQ==
X-Received: by 2002:a05:622a:153:b0:4ec:f035:d60 with SMTP id d75a77b69052e-4ed30d923e3mr43230771cf.5.1761925407722;
        Fri, 31 Oct 2025 08:43:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQAWd1J7oWtcMPX3rnVkF6XNlyYFAMR5sObmDNnVQ/IctF28iJZltsP22Ps9WEpLaV+65wUw==
X-Received: by 2002:a05:622a:153:b0:4ec:f035:d60 with SMTP id d75a77b69052e-4ed30d923e3mr43230481cf.5.1761925407236;
        Fri, 31 Oct 2025 08:43:27 -0700 (PDT)
Received: from [192.168.10.38] (91-154-146-251.elisa-laajakaista.fi. [91.154.146.251])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37a1bfb45easm4478091fa.16.2025.10.31.08.43.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 08:43:25 -0700 (PDT)
Message-ID: <e758dc56-a5eb-4c4a-9ab0-74e9b9b86c7c@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 17:43:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] drm/panel: Set sufficient voltage for panel nt37801
To: yuanjiey <yuanjie.yang@oss.qualcomm.com>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        sean@poorly.run, marijn.suijten@somainline.org, airlied@gmail.com,
        simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_mkrishn@quicinc.com, jonathan@marek.ca,
        quic_khsieh@quicinc.com, neil.armstrong@linaro.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tingwei.zhang@oss.qualcomm.com,
        aiqun.yu@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com
References: <20251023075401.1148-1-yuanjie.yang@oss.qualcomm.com>
 <20251023080609.1212-1-yuanjie.yang@oss.qualcomm.com>
 <20251023080609.1212-2-yuanjie.yang@oss.qualcomm.com>
 <zxofh6bwee3vjjlntlfqy7yg2iu2mipjvl7s5bcm6gbh233cjq@nuicjojawd2d>
 <aPsWEhM7i+gDjXE0@yuanjiey.ap.qualcomm.com>
 <4bnvh2ydtrmejknzpsxoalxoyjpq5g5cjbrico5ezbek24r52s@u5zy6ekh6lps>
 <aQF0zzUpLeUu4lrC@yuanjiey.ap.qualcomm.com>
 <5hftxsuqz745mxxk2hjpwfxwrm73p2l3dxn2mb2uqb2c44fd2w@l5xvadj7gvvg>
 <aQLInjBCbeNJVanK@yuanjiey.ap.qualcomm.com>
 <r3sbg5r5pesrfrave7l6nx4ws62eogfn7m4f5c3ur2a6xkhsss@f5vfre2hd2cr>
 <aQQdQoCLeKhYtY7W@yuanjiey.ap.qualcomm.com>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <aQQdQoCLeKhYtY7W@yuanjiey.ap.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: c33GczsYj7e-d2MjiJWSKcKDF2HrV2th
X-Authority-Analysis: v=2.4 cv=RbCdyltv c=1 sm=1 tr=0 ts=6904d920 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=CKk/IlMN6Gw3Dq31eR3Dfg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=e5mUnYsNAAAA:8 a=EUspDBNiAAAA:8
 a=Gjd6gEmqAeAVqTANhbgA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: c33GczsYj7e-d2MjiJWSKcKDF2HrV2th
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDE0MSBTYWx0ZWRfX2e6wNcm/2IAL
 WCyl8YliY2LX2DsngL/M1zDfplf5+ZK4RXXCGldtLw2oOgA+yxjGjIRTORw0M776y/URgGFmIJS
 /houqgGi1XXJnIn02A5Q+55+2jnic9H3+T+4Cu3uCNxAmLjUrxbC2c/70Y+Zy1K+k6WJIM+gaPS
 yOkG4MgRwHAtOkVlEq5nFtsLQbJ76esYkBLb0KlSnvebr/kd4OsIXNM4grXppsSgLH3D81MHJqL
 I7wGeTgMCQAi1UYaTqxJjabvQH3zSk2CQcgv4WUVdohUJAkF2B3Upt5ktWPW+MhzgH+mEQqbMia
 6p9Fxs7Mj7ZyR9bvlSZYD+Ockrkb5bVZMeQuts2CUaiZuczw1sZBFddXgKvKibN+ziBkjWxUgqu
 GqKbYCe289nn8ckqcYVLSZ6m7D5DrQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_05,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310141

On 31/10/2025 04:21, yuanjiey wrote:
> On Thu, Oct 30, 2025 at 07:57:46PM +0200, Dmitry Baryshkov wrote:
>> On Thu, Oct 30, 2025 at 10:08:30AM +0800, yuanjiey wrote:
>>> On Wed, Oct 29, 2025 at 02:20:13PM +0200, Dmitry Baryshkov wrote:
>>>> On Wed, Oct 29, 2025 at 09:58:39AM +0800, yuanjiey wrote:
>>>>> On Mon, Oct 27, 2025 at 02:22:04PM +0200, Dmitry Baryshkov wrote:
>>>>>> On Fri, Oct 24, 2025 at 02:00:50PM +0800, yuanjiey wrote:
>>>>>>> On Thu, Oct 23, 2025 at 03:14:38PM +0300, Dmitry Baryshkov wrote:
>>>>>>>> On Thu, Oct 23, 2025 at 04:06:04PM +0800, yuanjie yang wrote:
>>>>>>>>> From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
>>>>>>>>>
>>>>>>>>> The NT37801 Sepc V1.0 chapter "5.7.1 Power On Sequence" states
>>>>>>>>> VDDI=1.65V~1.95V, so set sufficient voltage for panel nt37801.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>>>>>>>>> Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
>>>>>>>>> ---
>>>>>>>>>   drivers/gpu/drm/panel/panel-novatek-nt37801.c | 5 +++++
>>>>>>>>>   1 file changed, 5 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt37801.c b/drivers/gpu/drm/panel/panel-novatek-nt37801.c
>>>>>>>>> index d6a37d7e0cc6..7eda16e0c1f9 100644
>>>>>>>>> --- a/drivers/gpu/drm/panel/panel-novatek-nt37801.c
>>>>>>>>> +++ b/drivers/gpu/drm/panel/panel-novatek-nt37801.c
>>>>>>>>> @@ -267,6 +267,11 @@ static int novatek_nt37801_probe(struct mipi_dsi_device *dsi)
>>>>>>>>>   	if (ret < 0)
>>>>>>>>>   		return ret;
>>>>>>>>>   
>>>>>>>>> +	ret = regulator_set_voltage(ctx->supplies[0].consumer,
>>>>>>>>> +				    1650000, 1950000);
>>>>>>>>
>>>>>>>> This should be done in the DT. Limit the voltage per the user.
>>>>>>> Two reason:
>>>>>>> 1.
>>>>>>> I see https://patchwork.freedesktop.org/patch/354612/
>>>>>>>
>>>>>>> panel panel-novatek-nt35510.c also use regulator_set_voltage set right voltage,
>>>>>>> so I do the same work.
>>>>>>
>>>>>> Please look for the majority rather than the exceptions. Out of all
>>>>>> panel drivers only two set the voltage directly.
>>>>>>
>>>>>>>
>>>>>>> 2.     Kaanapali vddio regulator:
>>>>>>>
>>>>>>> 		vreg_l12b_1p8: ldo12 {
>>>>>>> 			regulator-name = "vreg_l12b_1p8";
>>>>>>> 			regulator-min-microvolt = <1200000>;
>>>>>>> 			regulator-max-microvolt = <1800000>;
>>>>>>>
>>>>>>> 	Voltage is from 1.2~.1.8 V , So I can not set it 1.65~1.95 V from DT(1.95V is beyond the allowed range).
>>>>>>> 	So I use regulator_set_voltage to set voltage, and regulator_set_voltage will choose the appropriate voltage.
>>>>>>
>>>>>> DT has to list the voltage values that work for the devices on that
>>>>>> particular platform. So, ldo12 should be listing 1.64 - 1.8 V.
>>>>> get it. I check downstream DT,
>>>>>    dosnstream DT:
>>>>>     regulator-min-microvolt = <1800000>;
>>>>>     regulator-max-microvolt = <1800000>;
>>>>>
>>>>>    I test 1.8V works, So I will add 1.8V in next patch, do you think it is ok?
>>>>
>>>> What does panel's datasheet say?
>>>
>>> The NT37801 Sepc V1.0 chapter "5.7.1 Power On Sequence" states
>>> VDDI=1.65V~1.95V.
>>>
>>> So I should follow datasheet to set DT ldo12: 1.64 - 1.8V ?
>>
>> If the panel declares minimum voltage to 1.65 V, why are you declaring
>> 1.64 V as the mimimal voltage for the rail?
> 
> Corrcet here:
> 
> DT ldo12 will be  1.65 - 1.8V

Yep.

> 
> Thanks,
> Yuanjie
> 
>   
>>>
>>> if you think it is ture, I will fix it in next patch.
>> -- 
>> With best wishes
>> Dmitry


-- 
With best wishes
Dmitry

