Return-Path: <linux-kernel+bounces-813945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A250BB54D61
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFEF0188A549
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE281305E2D;
	Fri, 12 Sep 2025 12:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mDZ+sMVz"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC013064BB
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757679011; cv=none; b=BA0SC19UBn8VSpEKhDA0Joj/zBTPPKwf3ht2aNRnuaoGU+hFBDW5OQIMg6ix6MDo5LBNhsrCPw1+pSsVzkGIck4kP/z699JE7okQz5dMjO4fyAc3gUBIMnjzxxHxL4wd558k2cL4o/BwdzorHTzZX4gorUcPimWtlWT5fJ4Xfm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757679011; c=relaxed/simple;
	bh=JVRX127ZdnnrJQmZw4fn7pA8JbWfejoo/XtTkFCpBdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8zVQji60WZXyrJW+Ya/tI8SzsSZSM1FkanQKu4sS4x5Soan10jbvyEjT02aPojvmO8KMpH7I34LH/9+sVqENk2fRvX+pr8UuyVxck0EXZkxshUE1lZfhgUM81hT9UnY95PVK9xdg7Xz9GMhvR+WY8pJF85GfccfaEawUH3bfGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mDZ+sMVz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C9fJoh009081
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:10:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=dUewbymExetqos/pBiWHZiBD
	APIskSwpfO+nHDhO8vI=; b=mDZ+sMVzzT0+YVrLCIiX+PhRLvmJOSfFfErrhw04
	m6AdFsZDmcPt0Obm6ckzfWx4Q1aZ5+S4nMGWp+miK4xCgs5METyJJPCetrGb1hy4
	+UiBpuZQR8xqIlvMCmrq6SANVmDRdwdAnkOEtTJSEuFEb1BfJM/LJq0hyjPNc4H5
	tNPyF+h1AVv7BmcAQYO97RKAKwZbiuj/Y7CfN2Co/OJz6LGNPURlDJXr78NYKlb4
	Hul7VxkCW05y/MIGDcpS60WXLZmFOUPfsNqoq4jPLFeOmYLJxbBwJZfXxMZUG8iM
	Vrrq/6Nj1dg4sWApmDsmlbdnIwHXY61EDnwe65LTxzYACQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490cj13hn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:10:08 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70fa9206690so53943616d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 05:10:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757679007; x=1758283807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUewbymExetqos/pBiWHZiBDAPIskSwpfO+nHDhO8vI=;
        b=bg2UJIdDISFY9pY8/Fw0cvZnxwgPsfuTKUbKBh952ym5sTsQCurAIBv5mxdCWDIYxY
         s7Iub9wav2kiG9mIIexSz9fGS6rgxZJxtO/o7BYaZk+evJEE4wDiO59yuw3HvUMR8kp+
         hpreZ62D4SeTH4p8I+S3b5rYcrkpxYV9he1dLHt1QgJ/5N6XHqWo5rpHDn0KEoSp1GCb
         B1W3/i3GnO0X5vbT0f9jqC8ldgy0iTL/UNnt0WS1vvXTUyEEtakkfTHRoxlFNps1ErMh
         j5+/yQFKaMVpmu3zdyL+HIIrvMCVs4k2uMGHT9I2CPJSz+KopUlh5GoulreGsjw/++YD
         3Eew==
X-Forwarded-Encrypted: i=1; AJvYcCVIFatCOgxPpdqLxEEwJCOOriy4zCRq/eoW/wfBoX835zVVjfPxLwxeuNmXu6ERQJciwOJ3qGbZl9lB//g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9zw9bdJ+C5cGFDSrotbg4iZcz6L1VhapNf5yG6g+w7/7fQdrG
	GYYwWIBxgV4tk1lGKTgM9REe4LRJJR/ZNn+XqFS+R879ausBvguXVLV14OlqwdTlvv5fxuDyMxD
	SviNKgBGXs21qYVv1pZu4GUAFPvl7+TKPYpVabKZq9enqp1wCR0217WsGmcFuYND8O1Y=
X-Gm-Gg: ASbGnctBQuCs5MixaYu3UkiPUTdr3gx1zRMjVk9tPIl0c556Vwvc6X2/mLr2wns44Wk
	4FMMmhTDExvojtYR6F7kfbpTx1ZeFg/wOjDde5TpIUPEqVw9YiZ1zaj18SLiT+f563P2Wm0bAQE
	vcxVBbAgNSqEsn2+qMLhLGeVpFZp8P0WvXZnRBlOdmnQipHvwV+ttIxVLo/vg9su+btjbJcjeK3
	KIjBWPTEJ1RzW7oDyuheFT35E8yxisjnpPQfAuvvTn5l9K5FSr5ZNXoQOMVRrgzx3VGQrK/oGkl
	PtON2G4ABLgL3DgOIHK2vM8aRia6SokFaAvJOTsqVEF0qj5/dZplZbLVw6A9NCUNRWszDakFMuU
	j0KE8LQdbVbOI1npce930Wv6pKpmEDE+Sm4L6G1vMNVA0O5wdLgYz
X-Received: by 2002:ad4:4ea3:0:b0:70d:f55f:ef97 with SMTP id 6a1803df08f44-7621c32efaemr78241816d6.1.1757679007372;
        Fri, 12 Sep 2025 05:10:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGj9V1c+2coOy5S3o8/s5vrGQ5oy6OiMW/P7QJhRZCoPuqb8GRBAOCSvwHquRJ3YcZvRDvPSw==
X-Received: by 2002:ad4:4ea3:0:b0:70d:f55f:ef97 with SMTP id 6a1803df08f44-7621c32efaemr78241266d6.1.1757679006733;
        Fri, 12 Sep 2025 05:10:06 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e5cf2f446sm1136422e87.42.2025.09.12.05.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 05:10:05 -0700 (PDT)
Date: Fri, 12 Sep 2025 15:10:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com
Subject: Re: [PATCH 2/2] drm/msm/dp: Add DisplayPort support for SM6150
Message-ID: <ds5fisf464z3i4b6hz2ca2ul4u65d4rmjzvst5plfvdwywo2qm@gzgffhfpp4ib>
References: <20250912-add-dp-controller-support-for-sm6150-v1-0-02b34b7b719d@oss.qualcomm.com>
 <20250912-add-dp-controller-support-for-sm6150-v1-2-02b34b7b719d@oss.qualcomm.com>
 <budeqnh65mcmtc5rscbgvy2nz3woptxnht6sddzg7jhttsnx5f@bwf3kyvbrfaj>
 <d9c55e72-0683-4eb3-a22f-015a799e2c79@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9c55e72-0683-4eb3-a22f-015a799e2c79@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: RgpBigyGL0e897xEu5-f3nUuBdBXXoa4
X-Proofpoint-GUID: RgpBigyGL0e897xEu5-f3nUuBdBXXoa4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNCBTYWx0ZWRfX1e6XSjrwXi+t
 exE5M+h3xgW1VOoBQ7DHuSHjMGZDtXRoNJj9DMlzTyq5C7RDJB0KzuYCopmNFXQBnsVjJXSSCDb
 I/k0HBQ7X/4xSMYUl80ob0zl4IeaNellsEexOHhqOuoc54fJWAjfZSF0MfStTNffxw/qGETJqJ8
 Clx5lemK7LIifM/AgOkf+a2VVQOIMBl9aMcrvrqFqphf5eevujfgXW7OhZ0CvyXVVxQbnJam3ss
 kfqmUx2u0wIqc/0HesYawFzm3l+mvPXzbUUOxUFF9BKx4Re2u4bBQvXglwK9ia+25KSicTlMA7+
 Yi8etT1I/XHekgjBCCxYjb14qMaENo9ZyrzYw+2q2CjKSdzs/SJinO5dmmuseoM0PRH2TvNlkQx
 ET91SPwR
X-Authority-Analysis: v=2.4 cv=QeFmvtbv c=1 sm=1 tr=0 ts=68c40da0 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=YvU48llmxf4k0NmX4icA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060024

On Fri, Sep 12, 2025 at 07:53:50PM +0800, Xiangxu Yin wrote:
> 
> On 9/12/2025 7:47 PM, Dmitry Baryshkov wrote:
> > On Fri, Sep 12, 2025 at 07:39:17PM +0800, Xiangxu Yin wrote:
> >> Add support for SM6150 DisplayPort controller, which shares base offset
> >> and configuration with SC7180. While SM6150 lacks some SC7180 features
> >> (e.g. HBR3, MST), current msm_dp_desc_sc7180 data is sufficient. Listing it
> > SM6150 supports MST as far as I can see.
> 
> 
> Yes, but since msm_dp_desc hasn't been mainlined with MST enabled yet,
> I went ahead and submitted it with this commit message.


The commit message is misleading: it makes one think that SC7180
supports MST, while SM6150 doesn't.

> 
> 
> >> explicitly ensures future compatibility.
> >>
> >> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> >> ---
> >>  drivers/gpu/drm/msm/dp/dp_display.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> >> index d87d47cc7ec3eb757ac192c411000bc50b824c59..ddb22b50490035779904d4cab20e2fee7e0f9657 100644
> >> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> >> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> >> @@ -196,6 +196,7 @@ static const struct of_device_id msm_dp_dt_match[] = {
> >>  	{ .compatible = "qcom,sc8280xp-dp", .data = &msm_dp_desc_sc8280xp },
> >>  	{ .compatible = "qcom,sc8280xp-edp", .data = &msm_dp_desc_sc8280xp },
> >>  	{ .compatible = "qcom,sdm845-dp", .data = &msm_dp_desc_sdm845 },
> >> +	{ .compatible = "qcom,sm6150-dp", .data = &msm_dp_desc_sc7180 },
> >>  	{ .compatible = "qcom,sm8350-dp", .data = &msm_dp_desc_sc7180 },
> >>  	{ .compatible = "qcom,sm8650-dp", .data = &msm_dp_desc_sm8650 },
> >>  	{ .compatible = "qcom,x1e80100-dp", .data = &msm_dp_desc_x1e80100 },
> >>
> >> -- 
> >> 2.34.1
> >>

-- 
With best wishes
Dmitry

