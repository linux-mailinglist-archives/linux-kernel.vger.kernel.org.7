Return-Path: <linux-kernel+bounces-757628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05466B1C478
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 12:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4EBF3BA3A9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 10:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE9928B4FC;
	Wed,  6 Aug 2025 10:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pfXaTANT"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD36928B4F8
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 10:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754476804; cv=none; b=iL6hSXhdEdO2Dlq2pMmoGDUuUWlQxY6rCw1RynRvUNWNVvWTEcT/8L4etUZ1lrjGPDaNiSP1bmricQC4XYVi/pNGSxOOB35iA71no4oG1OzjMuCI2EtpqFPQY4wfpSOIP4XG54GFQzdFfj2z24x7rlKDgpycMODAFID5iwbm9Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754476804; c=relaxed/simple;
	bh=OljmIoPBfpKLYfO8OafoSkV2wVBqG4bhphe3kYBizQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iw43FBOfpj3XrpH3XzoWdzGg3A/E2Lz/kFxo9VzkPdjFqnvERduHTQz/u6WGPlKk9KEl3N6ePNQWY/a4v2njE614ZR+y/kGESmBBH+wsrjD38fyoNYdQOBMeEQDeemO5kldjO3L1PdBx1qIiRFaXDZpwTSoWcvPkNtTvkjUtnVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pfXaTANT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5765Fgwv011200
	for <linux-kernel@vger.kernel.org>; Wed, 6 Aug 2025 10:40:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AJGlzxH/LQxRsneDJaVraLZ09KjHz9driY+34sSKdlU=; b=pfXaTANT6RhqRYT0
	WU6CeVKmbvad0lXhs/9j+0LzPnCK8VISoA3BMec1wG1gpcPYz8sWzdwwz2PnX4Qa
	nT19xvDK+76tRO1tSTDT9F9uyvk/Z2iwk6CB7MAWcuYljAgbfDbzL+9p7clVnJ7o
	Mu2KSKGC/iv9P/qJFEIAyCuzdYDk3iR9MEWCvKCPo5D1cyn2pZeknKPkhSIn08gV
	EnnalE4/u2lpOCiIEtyIaKROyjD2k553RqiIJisZimLwBjx5Hpcd5cfQ1dqFIStN
	+xg4Z+thEYgq6+gd0S3FotSkgAPpAJgZRvb+oKztrJBZfOOf3OhdWJukYPQiC4Z3
	ap2Jjg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpw32fcq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 10:40:01 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-76bf8e79828so6735756b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 03:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754476800; x=1755081600;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AJGlzxH/LQxRsneDJaVraLZ09KjHz9driY+34sSKdlU=;
        b=MOFHg/4Nvb8TjtirWcImVeXc4HWULGanCfk+KexM4F9WbsYNUrmbQreBYfqqUlewmD
         DlOS8bLXTUUrocvAB/8typDX1FRgkk1rTOxthNnkYGbRJEL4KKYR3OYk2Vs7nfPMoe4w
         y31EKst/ppKmnJaMfUR2qBAptiARd9gk3h3Hlw+rBztWEz8+fKJUFzQbdWDg/0lRk9yd
         f2BvOlzJUeO1YXm7SaGiEp/pdf498muFp6qd1NSV0ALktu9s19JOjbPhleMPzQu1SUjN
         GVkVWzmZAAsL5OCvqmF49rlgqqMtPNI6B6iOrAQ9NE/RvGr2fir1YyQTZoMdixwhfCcL
         dF+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVPszpENL/bz2sv+AeCBdDW4K++jHD08yhYsUMndwPGZfIJU3srTHaLwEtFij9U9UgIlB+ppWJrPzHCCIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZWQG8iHWEMW7YDI8bygG6ShGfNiTXQqQF7bXewRHm462eoU8A
	M6zFMA43iRLLV0le/+CCQgoe1jJK0th8oSzh6p7ya0jaeIubS2zPG8dQg9M8Yz8aAWR+D/OwGL0
	s1JjADWXm5bcm++59suqYlFAQMXpHWKobtQE9w98VzhquIH4qwNQHPihl9tGkc44Ph1k=
X-Gm-Gg: ASbGncv+px2ylbTVpVm81l+bD3WHnmXzmOOmcaBzdIXRzGPgCyz3J9YONq98xv3YiW9
	pMO26Gie1/lQttvoknILzWy31OWpuPIRGv9t124VslsrggsZXUZ7M8gypLThoW7cYO+0HSCdjLd
	lZeiLbWcMg7MdW9g+A7yNYokMnQ22s+1VMrzjkKCEwnPPf2qLXvlLPHjZ8xi+0at2LLFEI2Q6d0
	cR7/HDdUcKfSEsNr36tHohlhEJgxE6I5hR2wKR6jyE+1ufIh3YDHNXXIsEP0Wg1f45R2u3PM0bI
	F+0aLmBz9MnfYuIdHjYfYEp3oyJYtF+LJr3PJthaMcZ/l9QFNyjNi0vkJfPwgg==
X-Received: by 2002:a05:6a20:72a5:b0:240:1d13:ccc1 with SMTP id adf61e73a8af0-24033036dfamr3237262637.11.1754476800296;
        Wed, 06 Aug 2025 03:40:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHs/OHoirDrVPeMNrslzB+S2OHot+QToIGzIuPvUCTVFUcXivoOOkUtzhYR5Dm3Rusx+t0sVw==
X-Received: by 2002:a05:6a20:72a5:b0:240:1d13:ccc1 with SMTP id adf61e73a8af0-24033036dfamr3237229637.11.1754476799836;
        Wed, 06 Aug 2025 03:39:59 -0700 (PDT)
Received: from [10.92.206.236] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfd026dsm15164022b3a.95.2025.08.06.03.39.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 03:39:59 -0700 (PDT)
Message-ID: <f47a57f3-f397-41a0-9c14-dcafbd1185b5@oss.qualcomm.com>
Date: Wed, 6 Aug 2025 16:09:52 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/38] drm/msm/dp: split msm_dp_panel_read_sink_caps()
 into two parts and drop panel drm_edid
To: Yongxing Mou <quic_yongmou@quicinc.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
References: <20250609-msm-dp-mst-v2-0-a54d8902a23d@quicinc.com>
 <20250609-msm-dp-mst-v2-1-a54d8902a23d@quicinc.com>
 <g6wqvbszbrw6gnvxz7cjmhx4rc53kyulcr5wjekfjaisontikl@723odzngtlnd>
 <326bbd02-f414-48e3-a396-4b94f19054f7@quicinc.com>
 <buvgxzf5u5wkj2nxd6rquvcktjmxoclwrkkmxeih6pnikubqe3@yoytvnayvxtv>
 <014d535e-ca9c-4707-9ff4-7afdd489b780@quicinc.com>
 <521402f9-06c7-4d49-b78a-080b06378fd8@oss.qualcomm.com>
 <29900293-d297-4151-9bb1-2e7d9dd40a11@quicinc.com>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <29900293-d297-4151-9bb1-2e7d9dd40a11@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOCBTYWx0ZWRfX8P7S5y7/GV0d
 2YhEXpgQ9jLvY1fnOiPHU0gF/EQS4p5Ckj37EhroU+0mFRCj7qlULkrfXER8TRq/0/BuajdWoUQ
 vagaWMtryw8SLk7q0sDAxUUBc/7aLEsOuIH+1wjzp1qv2aU+Tgb2K3hSw2SqM+W5NukMRo4Km2q
 vGatO6Oeo5p81TX/2XQ4vBqDdM1WwjBIz9M1Ys4aod84d1RPO5ZNh7k4yB9uTH5p8Luh2aWBAa+
 H7Xf7mgH/0vbz/eta1lDAIGV8DTU4QRxhkyn/JZYEh5u/tWSoZ/XDoC1twSnbJoCAQoLdznBUnt
 X4bZ+3Bb4zhXHGJc6PAK4fy1dn/wsUQMWh5C0p8K6rSmgbx+XsGr4T+Quw4kxwKlO2KlTqlr828
 Fcd1Bibp
X-Authority-Analysis: v=2.4 cv=J8Cq7BnS c=1 sm=1 tr=0 ts=68933101 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=oNfeFjo7KokIY7eomS0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: lsoVYHrJnZVgD_-l163j_rviky864nfQ
X-Proofpoint-ORIG-GUID: lsoVYHrJnZVgD_-l163j_rviky864nfQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_02,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060008

On 06/08/2025 14:33, Yongxing Mou wrote:
> 
> 
> On 2025/6/27 20:40, Dmitry Baryshkov wrote:
>> On 27/06/2025 10:49, Yongxing Mou wrote:
>>>
>>>
>>> On 2025/6/25 21:32, Dmitry Baryshkov wrote:
>>>> On Wed, Jun 25, 2025 at 04:43:55PM +0800, Yongxing Mou wrote:
>>>>>
>>>>>
>>>>> On 2025/6/9 20:41, Dmitry Baryshkov wrote:
>>>>>> On Mon, Jun 09, 2025 at 08:21:20PM +0800, Yongxing Mou wrote:
>>>>>>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>>>>>>
>>>>>>> In preparation of DP MST where link caps are read for the
>>>>>>> immediate downstream device and the edid is read through
>>>>>>
>>>>>> EDID, not edid. Please review all your patches for up/down case.
>>>>>>
>>>>> Got it. Thanks~
>>>>>>> sideband messaging, split the msm_dp_panel_read_sink_caps() into
>>>>>>> two parts which read the link parameters and the edid parts
>>>>>>> respectively. Also drop the panel drm_edid cached as we actually
>>>>>>> don't need it.
>>>>>>
>>>>>> Also => separate change.
>>>>>>
>>>>> Got it.
>>>>>>>
>>>>>>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>>>>>> Signed-off-by: Yongxing Mou <quic_yongmou@quicinc.com>
>>>>>>> ---
>>>>>>>    drivers/gpu/drm/msm/dp/dp_display.c | 13 +++++----
>>>>>>>    drivers/gpu/drm/msm/dp/dp_panel.c   | 55 +++++++++++++++++++ 
>>>>>>> +-----------------
>>>>>>>    drivers/gpu/drm/msm/dp/dp_panel.h   |  6 ++--
>>>>>>>    3 files changed, 40 insertions(+), 34 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/ 
>>>>>>> drm/ msm/dp/dp_display.c
>>>>>>> index 
>>>>>>> 6f05a939ce9e648e9601597155999b6f85adfcff..4a9b65647cdef1ed6c3bb851f93df0db8be977af 100644
>>>>>>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>>>>>>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>>>>>>> @@ -389,7 +389,11 @@ static int 
>>>>>>> msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
>>>>>>>        dp->link->lttpr_count = msm_dp_display_lttpr_init(dp, dpcd);
>>>>>>> -    rc = msm_dp_panel_read_sink_caps(dp->panel, connector);
>>>>>>> +    rc = msm_dp_panel_read_link_caps(dp->panel);
>>>>>>> +    if (rc)
>>>>>>> +        goto end;
>>>>>>> +
>>>>>>> +    rc = msm_dp_panel_read_edid(dp->panel, connector);
>>>>>>>        if (rc)
>>>>>>>            goto end;
>>>>>>> @@ -720,7 +724,6 @@ static int msm_dp_irq_hpd_handle(struct 
>>>>>>> msm_dp_display_private *dp, u32 data)
>>>>>>>    static void msm_dp_display_deinit_sub_modules(struct 
>>>>>>> msm_dp_display_private *dp)
>>>>>>>    {
>>>>>>>        msm_dp_audio_put(dp->audio);
>>>>>>> -    msm_dp_panel_put(dp->panel);
>>>>>>>        msm_dp_aux_put(dp->aux);
>>>>>>>    }
>>>>>>> @@ -783,7 +786,7 @@ static int msm_dp_init_sub_modules(struct 
>>>>>>> msm_dp_display_private *dp)
>>>>>>>            rc = PTR_ERR(dp->ctrl);
>>>>>>>            DRM_ERROR("failed to initialize ctrl, rc = %d\n", rc);
>>>>>>>            dp->ctrl = NULL;
>>>>>>> -        goto error_ctrl;
>>>>>>> +        goto error_link;
>>>>>>>        }
>>>>>>>        dp->audio = msm_dp_audio_get(dp->msm_dp_display.pdev, dp- 
>>>>>>> >catalog);
>>>>>>> @@ -791,13 +794,11 @@ static int msm_dp_init_sub_modules(struct 
>>>>>>> msm_dp_display_private *dp)
>>>>>>>            rc = PTR_ERR(dp->audio);
>>>>>>>            pr_err("failed to initialize audio, rc = %d\n", rc);
>>>>>>>            dp->audio = NULL;
>>>>>>> -        goto error_ctrl;
>>>>>>> +        goto error_link;
>>>>>>>        }
>>>>>>>        return rc;
>>>>>>> -error_ctrl:
>>>>>>> -    msm_dp_panel_put(dp->panel);
>>>>>>>    error_link:
>>>>>>>        msm_dp_aux_put(dp->aux);
>>>>>>>    error:
>>>>>>> diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/ 
>>>>>>> msm/dp/dp_panel.c
>>>>>>> index 
>>>>>>> 4e8ab75c771b1e3a2d62f75e9993e1062118482b..d9041e235104a74b3cc50ff2e307eae0c4301ef3 100644
>>>>>>> --- a/drivers/gpu/drm/msm/dp/dp_panel.c
>>>>>>> +++ b/drivers/gpu/drm/msm/dp/dp_panel.c
>>>>>>> @@ -118,14 +118,13 @@ static u32 
>>>>>>> msm_dp_panel_get_supported_bpp(struct msm_dp_panel *msm_dp_panel,
>>>>>>>        return min_supported_bpp;
>>>>>>>    }
>>>>>>> -int msm_dp_panel_read_sink_caps(struct msm_dp_panel *msm_dp_panel,
>>>>>>> -    struct drm_connector *connector)
>>>>>>> +int msm_dp_panel_read_link_caps(struct msm_dp_panel *msm_dp_panel)
>>>>>>>    {
>>>>>>>        int rc, bw_code;
>>>>>>>        int count;
>>>>>>>        struct msm_dp_panel_private *panel;
>>>>>>> -    if (!msm_dp_panel || !connector) {
>>>>>>> +    if (!msm_dp_panel) {
>>>>>>>            DRM_ERROR("invalid input\n");
>>>>>>>            return -EINVAL;
>>>>>>>        }
>>>>>>> @@ -160,26 +159,29 @@ int msm_dp_panel_read_sink_caps(struct 
>>>>>>> msm_dp_panel *msm_dp_panel,
>>>>>>>        rc = drm_dp_read_downstream_info(panel->aux, msm_dp_panel- 
>>>>>>> >dpcd,
>>>>>>>                         msm_dp_panel->downstream_ports);
>>>>>>> -    if (rc)
>>>>>>> -        return rc;
>>>>>>> +    return rc;
>>>>>>> +}
>>>>>>> -    drm_edid_free(msm_dp_panel->drm_edid);
>>>>>>> +int msm_dp_panel_read_edid(struct msm_dp_panel *msm_dp_panel, 
>>>>>>> struct drm_connector *connector)
>>>>>>> +{
>>>>>>> +    struct msm_dp_panel_private *panel;
>>>>>>> +    const struct drm_edid *drm_edid;
>>>>>>> +
>>>>>>> +    panel = container_of(msm_dp_panel, struct 
>>>>>>> msm_dp_panel_private, msm_dp_panel);
>>>>>>> -    msm_dp_panel->drm_edid = drm_edid_read_ddc(connector, 
>>>>>>> &panel- >aux->ddc);
>>>>>>> +    drm_edid = drm_edid_read_ddc(connector, &panel->aux->ddc);
>>>>>>> -    drm_edid_connector_update(connector, msm_dp_panel->drm_edid);
>>>>>>> +    drm_edid_connector_update(connector, drm_edid);
>>>>>>> -    if (!msm_dp_panel->drm_edid) {
>>>>>>> +    if (!drm_edid) {
>>>>>>>            DRM_ERROR("panel edid read failed\n");
>>>>>>>            /* check edid read fail is due to unplug */
>>>>>>>            if (!msm_dp_catalog_link_is_connected(panel->catalog)) {
>>>>>>> -            rc = -ETIMEDOUT;
>>>>>>> -            goto end;
>>>>>>> +            return -ETIMEDOUT;
>>>>>>>            }
>>>>>>>        }
>>>>>>> -end:
>>>>>>> -    return rc;
>>>>>>> +    return 0;
>>>>>>>    }
>>>>>>>    u32 msm_dp_panel_get_mode_bpp(struct msm_dp_panel *msm_dp_panel,
>>>>>>> @@ -208,15 +210,20 @@ u32 msm_dp_panel_get_mode_bpp(struct 
>>>>>>> msm_dp_panel *msm_dp_panel,
>>>>>>>    int msm_dp_panel_get_modes(struct msm_dp_panel *msm_dp_panel,
>>>>>>>        struct drm_connector *connector)
>>>>>>>    {
>>>>>>> +    struct msm_dp_panel_private *panel;
>>>>>>> +    const struct drm_edid *drm_edid;
>>>>>>> +
>>>>>>>        if (!msm_dp_panel) {
>>>>>>>            DRM_ERROR("invalid input\n");
>>>>>>>            return -EINVAL;
>>>>>>>        }
>>>>>>> -    if (msm_dp_panel->drm_edid)
>>>>>>> -        return drm_edid_connector_add_modes(connector);
>>>>>>> +    panel = container_of(msm_dp_panel, struct 
>>>>>>> msm_dp_panel_private, msm_dp_panel);
>>>>>>> +
>>>>>>> +    drm_edid = drm_edid_read_ddc(connector, &panel->aux->ddc);
>>>>>>> +    drm_edid_connector_update(connector, drm_edid);
>>>>>>
>>>>>> If EDID has been read and processed after HPD high event, why do 
>>>>>> we need
>>>>>> to re-read it again? Are we expecting that EDID will change?
>>>>>>
>>>>> Here we indeed don't need to read the EDID again, so we can 
>>>>> directly call
>>>>> drm_edid_connector_add_modes. Thanks.
>>>>>>> -    return 0;
>>>>>>> +    return drm_edid_connector_add_modes(connector);
>>>>>>>    }
>>>>>>>    static u8 msm_dp_panel_get_edid_checksum(const struct edid *edid)
>>>>>>> @@ -229,6 +236,7 @@ static u8 
>>>>>>> msm_dp_panel_get_edid_checksum(const struct edid *edid)
>>>>>>>    void msm_dp_panel_handle_sink_request(struct msm_dp_panel 
>>>>>>> *msm_dp_panel)
>>>>>>>    {
>>>>>>>        struct msm_dp_panel_private *panel;
>>>>>>> +    const struct drm_edid *drm_edid;
>>>>>>>        if (!msm_dp_panel) {
>>>>>>>            DRM_ERROR("invalid input\n");
>>>>>>> @@ -238,8 +246,13 @@ void msm_dp_panel_handle_sink_request(struct 
>>>>>>> msm_dp_panel *msm_dp_panel)
>>>>>>>        panel = container_of(msm_dp_panel, struct 
>>>>>>> msm_dp_panel_private, msm_dp_panel);
>>>>>>>        if (panel->link->sink_request & DP_TEST_LINK_EDID_READ) {
>>>>>>> +        drm_edid = drm_edid_read_ddc(msm_dp_panel->connector, 
>>>>>>> &panel->aux->ddc);
>>>>>>
>>>>>> And again....
>>>>>>
>>>>> Here we need the struct edid,since we drop the cached drm_edid, so 
>>>>> we need
>>>>> to read it again. Or we can return the drm_edid from 
>>>>> msm_dp_panel_read_edid
>>>>> and pass it to msm_dp_panel_handle_sink_request, then we don't need 
>>>>> to read
>>>>> drm_edid here. Emm, I'm still a bit curious why we can't cache the 
>>>>> drm_edid?
>>>>> It would help us to access it when needed. Emm, i see other drivers 
>>>>> also
>>>>> cache it.
>>>>
>>>> Yes, they can cache EDID. However, in this case we don't even need 
>>>> it at
>>>> all. This piece needs to be rewritten to use
>>>> drm_dp_send_real_edid_checksum(), connector->real_edid_checksum.
>>>>
>>>> Corresponding changes can be submitted separately.
>>>>
>>> Got it, thanks, will separate this patch from MST patches..  Even if 
>>> we use drm_dp_send_real_edid_checksum to send connector- 
>>>  >real_edid_checksum, that’s only when the EDID state is incorrect.
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ 
>>> tree/ drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c? 
>>> h=v6.16-rc3#n1020
>>>   When the EDID is read correctly, it should send edid->checksum 
>>> instead.
>>
>> I wonder if we should fix the drm_edid to always set 
>> real_edid_checksum instead.
>>
> Emm, can i understand that is another issue exist in the currently DRM..

Currently it's more of a design issue.

-- 
With best wishes
Dmitry

