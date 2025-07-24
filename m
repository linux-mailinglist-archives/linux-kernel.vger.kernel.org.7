Return-Path: <linux-kernel+bounces-744148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1273B1089E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 13:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 290CF5465EA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF85F26B971;
	Thu, 24 Jul 2025 11:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c5co5boj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF3715855E
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 11:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753355357; cv=none; b=BVY1wIPhQXPdNT/9QE5EKNIN+sS1uHd2USjAPeCZHjcSkOeq8MMnKPyz33Z61XvWlWZZ/lUwIYJ+BZChk5L2iX4VQfe3Jt8pEgoGCnrqD1eAwIZprLmIbKfgeUb1BTfZcgQuzDAo74m0UWotsLuaxMHn8GpmPm1FVImLia+5Fus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753355357; c=relaxed/simple;
	bh=4MkEvu78QrUvExfpgJM10kwAs/6EItzsTbrSjSTAvhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tZHecw0/ty5X+sRhzp8UxZb2touxNaSu3eNPcpqGkP0F/fatSA3U8zDLOkY336foaoNn+1dHvfEm+9DoldLCYJvOwxCP5LzsdiKafKJreaQpEhevcsSi2o7pzcWP5/g/o9VPurGv9QxAtfv5nGBTH6bT5vFQ+HDJ+fkARYwTNvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c5co5boj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9TdqY022193
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 11:09:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	omoQ5joPArCteDC0YHg4O+qjve6IQsjjq+F76qZeAQA=; b=c5co5bojJjlNRKbP
	bMLUJtjLT0X1E/YOmJTps3XhNkUhDcAEqcWz1XcsAIhoWqg9m77xUCToYT3egYnt
	z8p6gpB37g+Isjuevyjg40D3W3+R+Ijhn8fzDR74NeDpG/MW8ZNnqwAwT28a/R/h
	3IJOD+OZJFjj6pBtHazcT8Mz7wfp+GsOZl22QEvYHNVHsxm2jeRCA5+QdjHRMrSU
	63M98ulaw+XRt8/xiP/kivVFlAHk5qGXAR2c8Dz7bhs2+Dex07cNbTSv/YdbyABS
	0vgcQ15Cdm9w43/ZiBuqNbbeFSPEe7WTNXCDHmlvsnttCQwhoTlrlP6Fz2aSMF1g
	2gHhuw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48313kk4gx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 11:09:14 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7da0850c9e5so164288385a.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 04:09:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753355353; x=1753960153;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=omoQ5joPArCteDC0YHg4O+qjve6IQsjjq+F76qZeAQA=;
        b=ky1gL8gdVD5Q5wjsbRN/03no2ZggUPUiWiqLd8Z7VIZqZU5kd4XUvIgjhHozb4JfzT
         6U+iqAY1RqUDjkoINTLCo15bb41mmHJ5LgQBRvJLoMMPitkK2R8JMmulDNWmt6Y/DPoF
         nusI0TiNCHaEIeRHbgZEPWBn5u++PC5TwVz6O4WP1X8BWA5m8hcdkBctmzua+wdzRRJn
         3HqXI1RrpDExuwduY9fBnBZWn4yITvwiPizqaWtT5VLccl4PdwRjBMluOYjrM8hd85q7
         srrIjP4tgNmAILrBFfOukyv7JZia3/FattfJEgGwzU8aE0/g0nnNgkBVulz9Im02R9TN
         klkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKGZilON6P3cT5EfKb7YuiR7hNVyzSjAcjyv/HUGY9RieFvNEupDutEh6Hae6Od3B3/cMlU1YOfQwDVwM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5TM3hAzqzvTMkxFvSdhGLrc5NTF+m+VG9iETnDXvQ2MxaI4mS
	12guVHA3DsA0eCimMh8kG9fh1TpyCUQo07BR1x5l85Tk2i1B9OvirjE0y5ZmnY1/lULG0g188aj
	q8vZJGOpzaYLSTICwS5dK4hcvipFLz/iT0NRFUo+bs51tel8WDjwvwgIdpX9Pe/yt2p8=
X-Gm-Gg: ASbGncvoIAmpP2eWQ3I8KeU3TDDMN77xCnVaPLjyuDsl563T/EYF7tjSI/HBu1tbiYi
	VXsbTQpOVnGto0jIVDqHZ1st4+xWisdlpn/bhSRibZ3CnvGzw5ZEfEmsvPkPHFBBp0T/eV/33bj
	kaDKoRiGyraxKFyAQbn9sZOBlB3kO6TG6tV+eTLApT0qyTt1rm7CuX54NXJ7aFZCETl+hley+L4
	nVWvYG/UdvWN+27SSm7PMXailxYGqKWTLVBuXRqE14lQHy9suX+PSX834EvQXhIIsV3LlN9vEkV
	kREW5orJaao5qnHTRXBuELhbDFKZN68Fz2kreG/GQHgm+zDjjPLYDUKkYtZaYhu3ihQvhFmincK
	plc/HzGvP1l0Vm5Rxzmloolx33luncgN0uSR5ccM8fTSDudVe1RDNDekkFCzPBM1S6hdQbkOg0L
	FVhWSoC+6rvGxVrfkroA2dQo8=
X-Received: by 2002:a05:6214:300c:b0:6fd:26bd:3fe9 with SMTP id 6a1803df08f44-7070075b46fmr88683546d6.36.1753355352897;
        Thu, 24 Jul 2025 04:09:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEc/fYZ423PcC/MADtOutu923q+hqx/kNGi5uwxh6IK8njxLje60SRvGbbX151gfy/K27n6jw==
X-Received: by 2002:a05:6214:300c:b0:6fd:26bd:3fe9 with SMTP id 6a1803df08f44-7070075b46fmr88681936d6.36.1753355351070;
        Thu, 24 Jul 2025 04:09:11 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0c3:3a00:6f:d7d0:17d0:bfc8? (2001-14ba-a0c3-3a00-6f-d7d0-17d0-bfc8.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:6f:d7d0:17d0:bfc8])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-331e08e81ebsm2577601fa.50.2025.07.24.04.09.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 04:09:10 -0700 (PDT)
Message-ID: <5d86adfd-e16d-4072-b5a8-4f128a2c9adb@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 14:09:10 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] drm/dp: clamp PWM bit count to advertised MIN and MAX
 capabilities
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Johan Hovold <johan@kernel.org>,
        Christopher Obbard <christopher.obbard@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Rui Miguel Silva <rui.silva@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>
References: <20250330-wip-obbardc-qcom-t14s-oled-panel-brightness-v6-1-84ad1cd1078a@linaro.org>
 <Z-pTcB0L33bozxjl@hovoldconsulting.com>
 <CACr-zFAiKRTHyRAF5HkM2drCMD7Q_Z3ZUFAsSnevy38yD8XMwg@mail.gmail.com>
 <Z--eRHaYw_vbgK2f@hovoldconsulting.com>
 <CACr-zFA77ogDSNEOGd32Rdh3geqkL25T0BKtNdKzUdjrL0+9RA@mail.gmail.com>
 <aCw4EK_8C1KLb6MD@hovoldconsulting.com>
 <6612cd14-8353-4d3a-a248-5d32e0d3ca23@linaro.org>
 <CAO9ioeWeQ++qSaD5ukooqBg997=1pwwS80NHD_xiHz25ABmtXg@mail.gmail.com>
 <a9df2561-95d4-47a5-b5df-5874b71937a6@linaro.org>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <a9df2561-95d4-47a5-b5df-5874b71937a6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA4MyBTYWx0ZWRfX7qILuaIrsHZ7
 gQZZuWLUHGDpCmXlPb1W7sg7io+QBeRql6j5hVHMnpo1rdzx6uQDgwnVLb5f9SURxGO4B27q66r
 sxkJi1INYwBVM/76l4HP9PktM/lKBZAWBFXcQGm8kwQH2eajnq44qYrU2sJ2xEC3IX+ELEO6njD
 Qq19BeL5WYVLymEwYGLLp155fRccDnB0Mz6DU7aBbCeh267k5tNPVMrk2FXx6EdHNFepCwfeiaj
 BmIn1ZKZo9xLtrNe+wlMbR4lmakZ2/TIcNH1qI5je3rdGustmshiBDz4HiCRZIZlsLtfkgGeYDj
 PimTzln8VJnffYzKiTOLiGaFVVfKTu2CBEX5/fcwY/G0ApeNpwciwS9t0GsAAhaLrBdTI+zHeNV
 UOuqOr2t25UGzLfFXGeeGptYTGTEAie4mmCa1D+atbBZaaOAAtZf9dEpUY//9UC23IK+diUE
X-Proofpoint-ORIG-GUID: 4IvSzH2bcLTfB_XPhZy_4Vv0dymfkFLM
X-Proofpoint-GUID: 4IvSzH2bcLTfB_XPhZy_4Vv0dymfkFLM
X-Authority-Analysis: v=2.4 cv=C/TpyRP+ c=1 sm=1 tr=0 ts=6882145a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=m-6kepI0FKUGdeIz8lcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_01,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 mlxscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 bulkscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507240083



On 24/07/2025 12:42, Neil Armstrong wrote:
> On 24/07/2025 11:32, Dmitry Baryshkov wrote:
>> On Thu, 24 Jul 2025 at 12:08, <neil.armstrong@linaro.org> wrote:
>>>
>>> On 20/05/2025 10:06, Johan Hovold wrote:
>>>> Hi Chris,
>>>>
>>>> On Fri, Apr 04, 2025 at 02:24:32PM +0100, Christopher Obbard wrote:
>>>>> On Fri, 4 Apr 2025 at 09:54, Johan Hovold <johan@kernel.org> wrote:
>>>>>> On Fri, Apr 04, 2025 at 08:54:29AM +0100, Christopher Obbard wrote:
>>>>>>> On Mon, 31 Mar 2025 at 09:33, Johan Hovold <johan@kernel.org> wrote:
>>>>>>>>> @@ -4035,6 +4036,32 @@ drm_edp_backlight_probe_max(struct 
>>>>>>>>> drm_dp_aux *aux, struct drm_edp_backlight_inf
>>>>>>>>>         }
>>>>>>>>>
>>>>>>>>>         pn &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
>>>>>>>>> +
>>>>>>>>> +     ret = drm_dp_dpcd_read_byte(aux, 
>>>>>>>>> DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN, &pn_min);
>>>>>>>>> +     if (ret < 0) {
>>>>>>>>> +             drm_dbg_kms(aux->drm_dev, "%s: Failed to read 
>>>>>>>>> pwmgen bit count cap min: %d\n",
>>>>>>>>> +                         aux->name, ret);
>>>>>>>>> +             return -ENODEV;
>>>>>>>>> +     }
>>>>>>>>> +     pn_min &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
>>>>>>>>> +
>>>>>>>>> +     ret = drm_dp_dpcd_read_byte(aux, 
>>>>>>>>> DP_EDP_PWMGEN_BIT_COUNT_CAP_MAX, &pn_max);
>>>>>>>>> +     if (ret < 0) {
>>>>>>>>> +             drm_dbg_kms(aux->drm_dev, "%s: Failed to read 
>>>>>>>>> pwmgen bit count cap max: %d\n",
>>>>>>>>> +                         aux->name, ret);
>>>>>>>>> +             return -ENODEV;
>>>>>>>>> +     }
>>>>>>>>> +     pn_max &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
>>>>>>>>> +
>>>>>>>>> +     /*
>>>>>>>>> +      * Per VESA eDP Spec v1.4b, section 3.3.10.2:
>>>>>>>>> +      * If DP_EDP_PWMGEN_BIT_COUNT is less than 
>>>>>>>>> DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN,
>>>>>>>>> +      * the sink must use the MIN value as the effective PWM 
>>>>>>>>> bit count.
>>>>>>>>> +      * Clamp the reported value to the [MIN, MAX] capability 
>>>>>>>>> range to ensure
>>>>>>>>> +      * correct brightness scaling on compliant eDP panels.
>>>>>>>>> +      */
>>>>>>>>> +     pn = clamp(pn, pn_min, pn_max);
>>>>>>>>
>>>>>>>> You never make sure that pn_min <= pn_max so you could end up with
>>>>>>>> pn < pn_min on broken hardware here. Not sure if it's something 
>>>>>>>> you need
>>>>>>>> to worry about at this point.
>>>
>>> I'm trying to figure out what would be the behavior in this case ?
>>>
>>> - Warn ?
>>> - pn_max = pn_min ?
>>> - use BIT_COUNT as-is and ignore MIN/MAX ?
>>> - pm_max = max(pn_min, pn_max); pm_min = min(pn_min, pn_max); ?
>>> - reverse clamp? clamp(pn, pn_max, pn_min); ?
>>> - generic clamp? clamp(pn, min(pn_min, pn_max), max(pn_min, pn_max)); ?
>>
>> Per the standard, the min >= 1 and max >= min. We don't need to bother
>> about anything here.
> 
> Yeah, I agree. But I think a:
> if (likely(pn_min <= pn_max))
> is simple and doesn't cost much..

Really, no need to.

> 
>>
>> On the other hand, I think the patch needs to be updated a bit. If the
>> pn value changed after clamping, it makes sense to write it back to
>> the DP_EDP_PWMGEN_BIT_COUNT register by jumping to the tail of the
>> drm_edp_backlight_probe_max() function
> 
> You're right, we need to write it back, but we can't jump to
> the tail of the function since it has all the pwmgen logic
> in the middle.

If you add 'driver_pwm_freq_hz && 'to the 
DP_EDP_BACKLIGHT_FREQ_AUX_SET_CAP condition at the end of the function, 
then we can jump to the tail.

> 
> Neil
> 
>>
>>>
>>> Or just bail out ?
>>>
>>> Neil
>>>
>>>>>>>
>>>>>>> I am honestly not sure. I would hope that devices follow the spec 
>>>>>>> and
>>>>>>> there is no need to be too paranoid, but then again we do live in 
>>>>>>> the
>>>>>>> real world where things are... not so simple ;-).
>>>>>>> I will wait for further feedback from someone who has more 
>>>>>>> experience
>>>>>>> with eDP panels than I have.
>>>>>>
>>>>>> There's always going to be buggy devices and input should always be
>>>>>> sanitised so I suggest adding that check before calling clamp() 
>>>>>> (which
>>>>>> expects min <= max) so that the result here is well-defined.
>>>>>
>>>>> Makes sense, I will do so in the next revision.
>>>>
>>>> It seems you never got around to respinning this one so sending a
>>>> reminder.
>>>>
>>>> Johan
>>>>
>>>
>>
>>
> 

-- 
With best wishes
Dmitry


