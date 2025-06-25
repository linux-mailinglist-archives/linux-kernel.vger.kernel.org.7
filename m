Return-Path: <linux-kernel+bounces-702472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D6AAE82CE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 14:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CAEE179D92
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 12:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485B425B31A;
	Wed, 25 Jun 2025 12:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="azCxKbog"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B309020ED;
	Wed, 25 Jun 2025 12:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750854892; cv=none; b=DoRUAZ1MaFLFb1FEkT5LwmBFOKvG8xpB+/p+G78wT8Fy9mlvYCSyGTU7+3CsSGyobOwe8wIc4sNlPYoFm713BboDNOV9Y01dcqY6izwVx35+zGxorE9+chBP5dFTSSafsO7Vq8U2w1zLcVhYnnVaHBsTBJkiQoPt9DXXVe2GqKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750854892; c=relaxed/simple;
	bh=9FhYVDrdLZ5VjW+0Ah29m4UJOAVYqjG2+onF3ZIMwZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=j3AKFf6mt1E6EM5fOgSzMyCsONBTyTAl7CjWShO1GLOPk05Ujs3iRYaWzFlBBqA+IoI2Fld4J1wFanYmoXhoe+AON7QTedPu6oRK48qFCU/9k3MkQiRIjr8fZlt+hMGG4O0bY9KgNv87g7QVvBdWxeXZ0SU22saDMAGzDR16KXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=azCxKbog; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55P4mSoh014580;
	Wed, 25 Jun 2025 12:34:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sMNeCsP6aEEjrCF1A2Ao71q4AdmLWkcOmD22tOr0pHY=; b=azCxKbogRtG0wj3W
	Xquv5xLBf7+m/PPBD5aXiYQXmSS91OoGGxdTCFB0xDrW3W4LaFLlhKhKB+RS1lCg
	qefserPac6a9xkucACLxzkw8iMqd65nN9r2q6aBYpbpEostrkrS4YlQ+S7slCY/2
	3LEFZSOx3JsECglnPkcYOuKB17A/r6rNUnOk9l/72ukYnynkqV3NN6LTcgJSGxfG
	cy1WR/N+FnfYzmZIRhw3K+q8hKsO2i8m+qJxkfmNDyL0R5mCdSZx9CpA5ep6TAJh
	IcpICphL5ldtnvfIIpyTIgq0p9w38/K3WoVOWkZMm8v1DxKLuUl5EE9l4Z+YWzlm
	NfIkTw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47evc5rxkx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 12:34:27 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55PCYPvW006427
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 12:34:25 GMT
Received: from [10.253.74.126] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 25 Jun
 2025 05:34:21 -0700
Message-ID: <1be2238d-7bb2-4ef9-9c7c-81dab0dcb559@quicinc.com>
Date: Wed, 25 Jun 2025 20:34:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/38] drm/msm/dp: remove dp_display's dp_mode and use
 dp_panel's instead
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
CC: Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar
	<abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        "Abhinav
 Kumar" <quic_abhinavk@quicinc.com>
References: <20250609-msm-dp-mst-v2-0-a54d8902a23d@quicinc.com>
 <20250609-msm-dp-mst-v2-2-a54d8902a23d@quicinc.com>
 <kq6tb2wnte6v5z7uxgzc22kjwcevgvcdluzqbelvnbpbxlkotd@ltlv3u2guj4u>
Content-Language: en-US
From: Yongxing Mou <quic_yongmou@quicinc.com>
In-Reply-To: <kq6tb2wnte6v5z7uxgzc22kjwcevgvcdluzqbelvnbpbxlkotd@ltlv3u2guj4u>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: A5fEs2y5qBG5WZiUFjViBtmCKRrZgR7U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA5MiBTYWx0ZWRfX8Qry7gMxD872
 YgmSdvl96a/yE7h9vY2OScA8aeQnw+y/Zql+LP3r4qeAanWMetEyoq+FN56ZpyTDZERsbZjsvQQ
 mUxiVNJQgiDrrzgbrKkDtykFfebeExcgsARcbEGsLsQZ81iJKhMrYHv/gKgxhxbaAkFGQlqc9+q
 5z9YoOLjIMIxm+OG3rokXy6W4jG96DpfiTuhPRx0WyhmEr3wPB4P/irzAHQEygweuJw188AYZcc
 wbFfJfXyBR4gFGSv2r101Y1cunoVD+gnQ+yHRH1glPIVpdUR3FtLumtXTATLh3yN23BM4tkl3Cc
 Yp9030Irkw1+vjWTvtxQPqPJz6D3sRZk6bEdT1oi+BMYKJOdyRL6I2i6IOPEL/0AOH2dSA1oKNU
 YAzkdVFdDM+hBZ+znAoKVCMf22VN5Y5e78qBTE3GvXeoAClo7Dil+mtjF7pvtIC9PwOWtWPO
X-Authority-Analysis: v=2.4 cv=caHSrmDM c=1 sm=1 tr=0 ts=685becd5 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=e5mUnYsNAAAA:8
 a=COk6AnOGAAAA:8 a=B2EfgWTHHLW6iEZDcHEA:9 a=QEXdDO2ut3YA:10
 a=Vxmtnl_E_bksehYqCbjh:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: A5fEs2y5qBG5WZiUFjViBtmCKRrZgR7U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_03,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxlogscore=999 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 phishscore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506250092



On 2025/6/9 20:48, Dmitry Baryshkov wrote:
> On Mon, Jun 09, 2025 at 08:21:21PM +0800, Yongxing Mou wrote:
>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>> dp_display caches the current display mode and then passes it onto
>> the panel to be used for programming the panel params. Remove this
>> two level passing and directly populated the panel's dp_display_mode
>> instead.
> 
> - Why do we need to cache / copy it anyway? Can't we just pass the
>    corresponding drm_atomic_state / drm_crtc_state / drm_display_mode ?
> 
This part works as follows: .mode_set() copies the adjusted_mode into 
msm_dp_display_private->msm_dp_display_mode, and also parses and stores 
variables such as v_active_low/h_active_low/out_fmt_is_yuv_420 and ... 
When @drm_bridge_funcs.atomic_enable() is called, it copies 
msm_dp_display->msm_dp_mode into dp_panel->msm_dp_mode and initializes 
panel_info in msm_dp_display_set_mode(). Then when go to 
msm_dp_ctrl_on_stream(), the parameters are updated into the 
corresponding hardware registers.

This design has been in place since the first version of the DP driver 
and has remained largely unchanged. Originally, the drm_mode would be 
passed in two stages: from msm_dp_display->msm_dp_mode to 
dp_panel->msm_dp_mode. Since in MST mode each stream requires its own 
drm_mode and stored in dp_panel, we simplified the two-stage transfer 
into a single step (.mode_set() do all things and store in 
msm_dp_panel). Meanwhile we modified the msm_dp_display_set_mode 
function to accept a msm_dp_panel parameter, allowing the MST bridge 
funcs' mode_set() to reuse this part code.

The following patches: 
https://patchwork.freedesktop.org/patch/657573/?series=142207&rev=2 and 
https://patchwork.freedesktop.org/patch/657593/?series=142207&rev=2, 
introduce msm_dp_display_*_helper functions to help reuse common code 
across MST/SST/eDP drm_bridge_funcs.

If we drop msm_dp_mode from dp_panel and use drm_display_mode, it might 
introduce a large number of changes that are not directly related to 
MST. Actually i think the presence of msm_dp_display_mode seems to 
simplify the work in msm_dp_panel_timing_cfg(), this patch series we 
want to focus on MST parts, so would we consider optimizing them later?

Thanks~
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Yongxing Mou <quic_yongmou@quicinc.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_display.c | 76 ++++++++++++++-----------------------
>>   1 file changed, 29 insertions(+), 47 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index 4a9b65647cdef1ed6c3bb851f93df0db8be977af..9d2db9cbd2552470a36a63f70f517c35436f7280 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -92,7 +92,6 @@ struct msm_dp_display_private {
>>   	struct msm_dp_panel   *panel;
>>   	struct msm_dp_ctrl    *ctrl;
>>   
>> -	struct msm_dp_display_mode msm_dp_mode;
>>   	struct msm_dp msm_dp_display;
>>   
>>   	/* wait for audio signaling */
>> @@ -806,16 +805,29 @@ static int msm_dp_init_sub_modules(struct msm_dp_display_private *dp)
>>   }
>>   
>>   static int msm_dp_display_set_mode(struct msm_dp *msm_dp_display,
>> -			       struct msm_dp_display_mode *mode)
>> +				   const struct drm_display_mode *adjusted_mode,
>> +				   struct msm_dp_panel *msm_dp_panel)
>>   {
>> -	struct msm_dp_display_private *dp;
>> +	u32 bpp;
>>   
>> -	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
>> +	drm_mode_copy(&msm_dp_panel->msm_dp_mode.drm_mode, adjusted_mode);
>> +
>> +	if (msm_dp_display_check_video_test(msm_dp_display))
>> +		bpp = msm_dp_display_get_test_bpp(msm_dp_display);
>> +	else
>> +		bpp = msm_dp_panel->connector->display_info.bpc * 3;
>> +
>> +	msm_dp_panel->msm_dp_mode.bpp = bpp;
>> +
>> +	msm_dp_panel->msm_dp_mode.v_active_low =
>> +		!!(adjusted_mode->flags & DRM_MODE_FLAG_NVSYNC);
>> +	msm_dp_panel->msm_dp_mode.h_active_low =
>> +		!!(adjusted_mode->flags & DRM_MODE_FLAG_NHSYNC);
>> +	msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420 =
>> +		drm_mode_is_420_only(&msm_dp_panel->connector->display_info, adjusted_mode) &&
>> +		msm_dp_panel->vsc_sdp_supported;
>>   
>> -	drm_mode_copy(&dp->panel->msm_dp_mode.drm_mode, &mode->drm_mode);
>> -	dp->panel->msm_dp_mode.bpp = mode->bpp;
>> -	dp->panel->msm_dp_mode.out_fmt_is_yuv_420 = mode->out_fmt_is_yuv_420;
>> -	msm_dp_panel_init_panel_info(dp->panel);
>> +	msm_dp_panel_init_panel_info(msm_dp_panel);
>>   	return 0;
>>   }
>>   
>> @@ -1431,10 +1443,13 @@ bool msm_dp_needs_periph_flush(const struct msm_dp *msm_dp_display,
>>   bool msm_dp_wide_bus_available(const struct msm_dp *msm_dp_display)
>>   {
>>   	struct msm_dp_display_private *dp;
>> +	struct msm_dp_panel *dp_panel;
>>   
>>   	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
>>   
>> -	if (dp->msm_dp_mode.out_fmt_is_yuv_420)
>> +	dp_panel = dp->panel;
>> +
>> +	if (dp_panel->msm_dp_mode.out_fmt_is_yuv_420)
>>   		return false;
>>   
>>   	return dp->wide_bus_supported;
>> @@ -1496,10 +1511,6 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
>>   	bool force_link_train = false;
>>   
>>   	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
>> -	if (!msm_dp_display->msm_dp_mode.drm_mode.clock) {
>> -		DRM_ERROR("invalid params\n");
>> -		return;
>> -	}
>>   
>>   	if (dp->is_edp)
>>   		msm_dp_hpd_plug_handle(msm_dp_display, 0);
>> @@ -1517,15 +1528,6 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
>>   		return;
>>   	}
>>   
>> -	rc = msm_dp_display_set_mode(dp, &msm_dp_display->msm_dp_mode);
>> -	if (rc) {
>> -		DRM_ERROR("Failed to perform a mode set, rc=%d\n", rc);
>> -		mutex_unlock(&msm_dp_display->event_mutex);
>> -		return;
>> -	}
> 
> It should be done other way around: keep this call and drop
> msm_dp_bridge_mode_set().
> 
Emm as reply in last comments..
>> -
>> -	hpd_state =  msm_dp_display->hpd_state;
>> -
>>   	if (hpd_state == ST_CONNECTED && !dp->power_on) {
>>   		msm_dp_display_host_phy_init(msm_dp_display);
>>   		force_link_train = true;
>> @@ -1604,33 +1606,13 @@ void msm_dp_bridge_mode_set(struct drm_bridge *drm_bridge,
>>   	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
>>   	msm_dp_panel = msm_dp_display->panel;
>>   
>> -	memset(&msm_dp_display->msm_dp_mode, 0x0, sizeof(struct msm_dp_display_mode));
>> -
>> -	if (msm_dp_display_check_video_test(dp))
>> -		msm_dp_display->msm_dp_mode.bpp = msm_dp_display_get_test_bpp(dp);
>> -	else /* Default num_components per pixel = 3 */
>> -		msm_dp_display->msm_dp_mode.bpp = dp->connector->display_info.bpc * 3;
>> -
>> -	if (!msm_dp_display->msm_dp_mode.bpp)
>> -		msm_dp_display->msm_dp_mode.bpp = 24; /* Default bpp */
>> -
>> -	drm_mode_copy(&msm_dp_display->msm_dp_mode.drm_mode, adjusted_mode);
>> -
>> -	msm_dp_display->msm_dp_mode.v_active_low =
>> -		!!(msm_dp_display->msm_dp_mode.drm_mode.flags & DRM_MODE_FLAG_NVSYNC);
>> -
>> -	msm_dp_display->msm_dp_mode.h_active_low =
>> -		!!(msm_dp_display->msm_dp_mode.drm_mode.flags & DRM_MODE_FLAG_NHSYNC);
>> -
>> -	msm_dp_display->msm_dp_mode.out_fmt_is_yuv_420 =
>> -		drm_mode_is_420_only(&dp->connector->display_info, adjusted_mode) &&
>> -		msm_dp_panel->vsc_sdp_supported;
>> +	msm_dp_display_set_mode(dp, adjusted_mode, msm_dp_panel);
>>   
>>   	/* populate wide_bus_support to different layers */
>> -	msm_dp_display->ctrl->wide_bus_en =
>> -		msm_dp_display->msm_dp_mode.out_fmt_is_yuv_420 ? false : msm_dp_display->wide_bus_supported;
>> -	msm_dp_display->catalog->wide_bus_en =
>> -		msm_dp_display->msm_dp_mode.out_fmt_is_yuv_420 ? false : msm_dp_display->wide_bus_supported;
>> +	msm_dp_display->ctrl->wide_bus_en = msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420 ?
>> +		false : msm_dp_display->wide_bus_supported;
>> +	msm_dp_display->catalog->wide_bus_en = msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420 ?
>> +		false : msm_dp_display->wide_bus_supported;
>>   }
>>   
>>   void msm_dp_bridge_hpd_enable(struct drm_bridge *bridge)
>>
>> -- 
>> 2.34.1
>>
> 


