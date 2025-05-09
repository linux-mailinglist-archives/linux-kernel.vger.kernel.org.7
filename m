Return-Path: <linux-kernel+bounces-641930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C115FAB1835
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 17:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 294014E068B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 15:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A890121D3F3;
	Fri,  9 May 2025 15:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AGFysvlf"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A3E20F097
	for <linux-kernel@vger.kernel.org>; Fri,  9 May 2025 15:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746803926; cv=none; b=b5/mzCbm6vwiiTCS/0Vykaq6sAFLX0z1mkDwfHCIzDd0GQ0MSRnl9qYjVAxglrucGonDH7mlkNqLS0jkOl09puvyLGWLoAZGuj9ZT1XpSNNvAmPLWA8+0izYjKXLMK5EWM0nWOGDLPtS8MbsU7GE0ANI/Ed7c8mqAYOatiBPMOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746803926; c=relaxed/simple;
	bh=GRCt4KgGr07bRlbGOwSFzMstJmndK7uc3yhrnHTMJ7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DIpAFUV3i/kMAUpKOxGTfi9h++ZY5WohRXFEk3XWkKzR07BGmMIKSL+6Z8YnMfRyWU0caXgmMT/lQCGkCeKiYQFwFJ7G26VSDrpSC29sP2MKspVohtgEbvBxYqRrajOMQMnK29ns5rfmEPuLkKGaerZpKdafqUMf24fFEt94htU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AGFysvlf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 549BhwR3022870
	for <linux-kernel@vger.kernel.org>; Fri, 9 May 2025 15:18:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	utDfRm9yEnEcuSD5wRoweKl442QKaEa5GIg5IOHfbG4=; b=AGFysvlfYlojTWJr
	fuPItSLQ7FohYoLGYuEZncqk5x81gXE0Tzxp4y9lR9GM3tEXuQGJIHGgC6h8taEm
	bU0IdJiS6F4O3VZe7p8njwElnL+D1+Y3uoimv11jNF6gUnZgi7I96DVpmOsOH0yo
	8s/Qfr4PqZ9vXcR+odwcZMJP5AcNXBglX2UU0I+v0VM1qccG73vfXuEggd7bxqhb
	WJGq252vq0daz2yxxHj0x1lw0koqHHGuOm3YAxk+UT7DN+MKpWPGhMg4mz0x/k5D
	k+6vp+3g3v2KyKPq10tMEVnxwThGeeaRLaRlEg3QWU5Lh3v62dJB49KlZw7atjCG
	ttNxhQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46gnp854v5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 09 May 2025 15:18:44 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c5750ca8b2so322873985a.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 May 2025 08:18:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746803923; x=1747408723;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=utDfRm9yEnEcuSD5wRoweKl442QKaEa5GIg5IOHfbG4=;
        b=R+119APgIatF5Xq/K2G1HJy+negPizpOz2nvRRf6DdRDrbYZvfxnRZnjEi6NWZpn/5
         kQJkte8Ovxd9DXzCBNis5N72gMCeTO1gz6B6mBlRuev1JeY9gJJdLOKUHYcbKzrgBCvG
         72tMQbEIlDcGtW/WyKW6uxNPy9kDIeapeTc9imNF5kfCPniiXyoLo6gudWj/gFULfzlX
         aQiRmt+edLpICQQnyCE/xDT7y/JZFm8+PCCgbe7eiIAdhsKBJxotqPSe6ylQXUZc5UXK
         jKuwRt1pHelgIKRkcgAfKOlDQ2+tedfOq1MI4aJNPIVukUkE/9I8XPsVL+hPef3TCxY4
         njKw==
X-Forwarded-Encrypted: i=1; AJvYcCVcD6uaRfRWE8MJMLxKVA0aOaQ2MwbWgZFcn/zNqdtgDM4kD+H9rJigsmp6Py1qwsxKwvoGGoLr5Bjy50g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOlgnr8/X/XGcdEVbcX85+iU2QqA3yG0YM6hLPy1RrO0yqVV8I
	6NM0i08wOHgz4MEw0u43nY1WAjaUmFLgeIZ+UeLDZ/0XQfxf+DylysKqfmW6exHJLB0mtl2Ynzg
	ThYwz+XULxx7KPHVoL1CvdfToHQ80NCp6St04KSmahGOYyiVn/YkzoTJhqytJJmE=
X-Gm-Gg: ASbGncuAf7C0ehEEXIBB/vJy+wGtQbFbXy4oQdUbLVA9umtz2bLSOyigXPjzdPEswc7
	XUDdkus5DEHj8mrNzAf919bVnmhVhvbFZxL20rBWPTFVZVnZFW9ZNr9RY6/VPf0eL3tjMFnDMqI
	+eXnuiIvrvsphDwphf5qSQPvISQo/3fdwPZ77oKynp8SQQkDMhi4XrKjHn2EsRHlAUdo9jWBF1O
	OjCernz209eXNJh3Ua4ZpYPYJjQYYHklohZUa/Euh1VeoGJN0AQstgZhRnl7p7BlhwJG+JCXFyv
	Iw5e/dDhukrasHAwoqVF18ddCTAnhWAw1+zzWbJdktZe65QfsUFoG/S1FNCcf40YTa038+DmVqF
	8hglHBkBJd//fDLrNUw9jEKtbxc5L8caGKZ0YeQB5Mh/NIbSCpG8oD1HuCftng6t0
X-Received: by 2002:a05:620a:4727:b0:7c9:2383:afef with SMTP id af79cd13be357-7cd0115034cmr674763985a.37.1746803922677;
        Fri, 09 May 2025 08:18:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPsqI2DXHYl8igD/hABxSIitYc1LfAKRC3bEPVNydkg0fxuqduKG1kw9aY/mt1U3TUllVG3g==
X-Received: by 2002:a05:620a:4727:b0:7c9:2383:afef with SMTP id af79cd13be357-7cd0115034cmr674759385a.37.1746803922301;
        Fri, 09 May 2025 08:18:42 -0700 (PDT)
Received: from ?IPV6:2001:14bb:a6:738a:e519:cad2:e720:53eb? (2001-14bb-a6-738a-e519-cad2-e720-53eb.rev.dnainternet.fi. [2001:14bb:a6:738a:e519:cad2:e720:53eb])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54fc645cee9sm305198e87.75.2025.05.09.08.18.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 08:18:41 -0700 (PDT)
Message-ID: <6cfc706f-4909-4121-9849-a37e4769ab2f@oss.qualcomm.com>
Date: Fri, 9 May 2025 18:18:40 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 01/14] drm/atomic-helper: Add crtc check before
 checking plane
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar
 <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20250506-quad-pipe-upstream-v9-0-f7b273a8cc80@linaro.org>
 <20250506-quad-pipe-upstream-v9-1-f7b273a8cc80@linaro.org>
 <b5kl5whmagpxn4saimkj4qloowh73xggehdh5rnl6lmjvqf65j@esycoi7w2nmp>
 <CABymUCMuiKQwtuYW-HX4bwyTR4awm4scwXTWNzVCEmyQsQ29aA@mail.gmail.com>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <CABymUCMuiKQwtuYW-HX4bwyTR4awm4scwXTWNzVCEmyQsQ29aA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=M7xNKzws c=1 sm=1 tr=0 ts=681e1cd4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=sWdYkf8P3oHYA_MdvdkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 0TXHz23R4sLsjsTI1h8rfoZVZuzFXjjS
X-Proofpoint-GUID: 0TXHz23R4sLsjsTI1h8rfoZVZuzFXjjS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDE1MSBTYWx0ZWRfXwJ9SkJDgVqbd
 BWdt8v1+vbgJH3EZCXXekQt7fCL+1uc6E4LhDV41lYVA0qaw1Ez2oIac0UwopqByUmt22GRqZDk
 hgmPuaWTCpSb4Jt/5USIRP1ovLQn0dXrUp3ixiYlPVdF7pIq3Ff35fGQaesSuoUtI+YRVV1Qaqp
 5nn8OAXZKcwrjxRQ5mCIOqaZTeU86EBkqXtyEFsd881qTQOmzq3qOTjcMLTuHS4eZmznLTSCgYe
 QcDntno6O6hrcL5rtyzDKxIe6pnIE0NR875tPCcGlWs9n4ux1Fu3/W/reFpvL6HrwN4Gv0Se5uj
 Fw8++UKpp7ZR669uGaf7z3xQyMdDHb8ewtbHXNPIw7ivwxAdLQb0iwSbVWK78rV+B9nXd/su5K6
 wU/UcdiKMKWpSjwnczDPJ4noPAJ9Wl+K4JtPr682D9OCHkNVrUnawKFU2OtftXMmvb3PkWEv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0 priorityscore=1501
 spamscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505090151

On 09/05/2025 06:08, Jun Nie wrote:
> Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> 于2025年5月8日周四 18:47写道：
>>
>> On Tue, May 06, 2025 at 11:47:31PM +0800, Jun Nie wrote:
>>> Some display controller support flexible CRTC and DMA, such as the display
>>> controllers in snapdragon SoCs. CRTC can be implemented with several mixers
>>> in parallel, and plane fetching can be implemented with several DMA under
>>> umberala of a virtual drm plane.
>>>
>>> The mixer number is decided per panel resolution and clock rate constrain
>>> first, which happens in CRTC side. Then plane is split per mixer number
>>> and configure DMA accordingly.
>>
>> Here you are describing a behaviour of one particular driver as a reason
>> to change the framework.
> 
> Yeah, the specific driver requires a change in framework. Maybe the
> comment is not
> proper?

Yes. Explain how does that benefit the framework / other drivers. 
Otherwise the answer would be as simple as 'replace 
drm_atomic_helper_check_planes() in your driver'.

>>
>>>
>>> To support such forthcoming usage case, CRTC checking shall happen before
>>> checking plane. Add the checking in the drm_atomic_helper_check_modeset().
>>
>> So, now drivers will get two calls to atomic_check(), one coming in
>> circumstances which were not expected by the drivers before. Are you
>> sure that this won't break anything?
> 
> Yes, it is a concern. Is there any way to limit the change in
> framework to specific
> driver with a flag, such as DRM_FLAG_CHECK_CRTC_BEFORE_PLANE?

Definitely not with a flag. You can try adding a new helper callback, 
but I don't know how DRM core maintainers would react to it.

>>
>>>
>>> Signed-off-by: Jun Nie <jun.nie@linaro.org>
>>> ---
>>>   drivers/gpu/drm/drm_atomic_helper.c | 19 +++++++++++++++++++
>>>   1 file changed, 19 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
>>> index 5302ab3248985d3e0a47e40fd3deb7ad0d9f775b..5bca4c9683838c38574c8cb7c0bc9d57960314fe 100644
>>> --- a/drivers/gpu/drm/drm_atomic_helper.c
>>> +++ b/drivers/gpu/drm/drm_atomic_helper.c
>>> @@ -816,6 +816,25 @@ drm_atomic_helper_check_modeset(struct drm_device *dev,
>>>                        return ret;
>>>        }
>>>
>>> +     for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
>>> +             const struct drm_crtc_helper_funcs *funcs;
>>> +
>>> +             funcs = crtc->helper_private;
>>> +
>>> +             if (!funcs || !funcs->atomic_check)
>>> +                     continue;
>>> +
>>> +             ret = funcs->atomic_check(crtc, state);
>>> +             if (ret) {
>>> +                     drm_dbg_atomic(crtc->dev,
>>> +                                    "[CRTC:%d:%s] atomic driver check failed\n",
>>> +                                    crtc->base.id, crtc->name);
>>> +                     return ret;
>>> +             }
>>> +     }
>>> +
>>> +
>>> +
>>
>> Too many empty lines. But the main quesiton is: why are you calling it
>> before mode_valid()? According to your description a better place would
>> be in drm_atomic_helper_check_planes().
>>
> Agree, that's the proper function. Will remove the empty line in next version.
> 
>>>        ret = mode_valid(state);
>>>        if (ret)
>>>                return ret;
>>>
>>> --
>>> 2.34.1
>>>
>>
>> --
>> With best wishes
>> Dmitry
>>


-- 
With best wishes
Dmitry

