Return-Path: <linux-kernel+bounces-777582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40265B2DB55
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 675591C20650
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFCE2E2EE4;
	Wed, 20 Aug 2025 11:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eCNU/iKn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51842E54B6
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755689651; cv=none; b=P6QFU4H1zG6dpKp9QhIMveJald2W6h1OAXgDWFaXYas1lbXPNB2q4y77/ig2cFyt+i7sZShpV2xHDFb8xmgUAByYiDxRBzfNeW+52BeGoeQhMLkQaBuMK1v9xSPoS+zUWzV4lr+MVNlzGZYs7VQ7p5Pi6+E5oJPrBrd2tDHezOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755689651; c=relaxed/simple;
	bh=fnFlSvGRR/TSyKfoUhH+X2EynjQebmFIrPk4G7+w8Kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rq6l3/tDcW5cbu6iUX5KO98oAx79YykpWTkQkw+nrIexxusgoshF5gej0ahIneGiRGBKT8Xk2cpnswzTGzmPwZP/5V2najoYc0PEmbXHqze4M5+hg83WcfuGF+0tnw+znrI/yUDOZS/FiIRIPbk/Or8TkaDsN5i0dTdjZf/V09o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eCNU/iKn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KAABoI006060
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:34:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=XcNX4ZDYiBJ7hPbbX3QqeNKI
	VB3toybrjSkdSm9Gk44=; b=eCNU/iKnkqs2/ujRIBoZ3cftAZtZMetCNlRfqUcS
	WBDmgpb5vugP2hRdIcOiP+bTSMIgTQ47Ax+2hnGjqmlxM/13uTFqFs/SC4j6bA+J
	nLUx+pO3Uc6UG3QnR5IYcVJcJV+PHR8bBwBy/yZtefRJvcoU6zXuqUNNLD3JRKiW
	IrjKsYtFqMvvQ0AR2q0XNA0eggWzuVla2/gY0AsDXVP0L3PuEh73qMlD0vSSQuaw
	qRqQaF3gaZq9Qpm5dZRyy+roT3jMPAHnSjEYp5TYJC5ZeKCNgmOLkc0CVjTvUavU
	wc1/3eWdLpk7HpxWlfX2c3/sTguSODbFm9i/Upn9w6kotQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52chhen-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:34:08 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70a927f570eso141473916d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 04:34:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755689647; x=1756294447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XcNX4ZDYiBJ7hPbbX3QqeNKIVB3toybrjSkdSm9Gk44=;
        b=oOiiYPPaJowqw2R5YGPuzlVBdsNHkcWFnSJmJQl/mwbaCrosJy1/OQ/8/Xhs3GjhoF
         +rcVDTpyEB6wmMRNJ+d4dZZb1fQd18zUVtjG/wxkpysYqDMSxQdd/oa4kgk0+h/GHgNv
         Cf3NIlLBoDeG/Q2LJcXnBvwus0dGKOoIKlFYnYe4zf3OUJ/+i+Y2zc4ICF/D7ZjNpdYy
         kXGdO3KuT177KlaK+tiNPaaTKNLonkqJlWIH24MDFLez1ZNsouwpcLDW6XgURJ+e4xyF
         hpZRgsxK5SBT0M4qnOhS3uOkrpoSmiqTxbQKH5HOMiUn6QcH39vhuLqtHhVzFYx3UbbQ
         dszA==
X-Forwarded-Encrypted: i=1; AJvYcCXLA0jHhaLuodPZTZTFEei7KtzulgR1z+O9dJpLDg/UCGDcWqaStEeOLppyDeUfj0V5281CHdAvYEeQn2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVocWa9P6xEl4EwouZuL5McbwYWfhWwxx6oSkw4rz4bvKlgsFx
	wctuEdDzpMOawCp5T454GPGOx7MBdTa7CONYXSJXKW9NcjlxcDSg/omSKkkt3/OCXbMQ86sMlRO
	OJ2bQUsz6B64YbLLEPyMn7PbLGceQHsaLvG7Z0VzyfYPvT0VK2RdVhjwwaVojdZylRUM=
X-Gm-Gg: ASbGncuqplZ8jpqLqFaJZmRkYtO+HePHVkxsCC5IVZPmi979LnJbNUJpk+okW9YmT2Y
	ba+pbOQNfuFvtvAu9y3HCARYwwBxpmzRZMtJSt4AFxrlI8tirXgLncvk5bTpGFYqumMi35/Hb8l
	otomN8YNznAAi+GeGlVB4qBTtgRE3D8aPeAlGIvSMzcBQHd3Qqas0nLOh3aHenR6Qh71l0H7RAL
	+kRLDrEkvPmnYfsNKMP4Vkgj3WlCvqaS2GXNj73L4ittHTUH7Cdno8GYHQ55JESWz0hRNs7Y33J
	vC6VOdlB1DTX8spH3FoKdNyCr+bPel5MyPUjmgnSDOG8YGyLcNoXt346KZeFopvK8Jihq9MmM7I
	xEc62EHhiQAJFkXlpFmmupNsOt5rc4lhV8QXrbsr9o5f1SBcPsyc4
X-Received: by 2002:a05:6214:2467:b0:704:f952:18bb with SMTP id 6a1803df08f44-70d771402c7mr20425616d6.46.1755689647355;
        Wed, 20 Aug 2025 04:34:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKE0JSYrOpvMO2WcRrh53W2VDmbQ14HSNNSlF+so2tCr9GefhcpbJA6wUwasEOVbgwxfyTww==
X-Received: by 2002:a05:6214:2467:b0:704:f952:18bb with SMTP id 6a1803df08f44-70d771402c7mr20425116d6.46.1755689646629;
        Wed, 20 Aug 2025 04:34:06 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55e084e46b7sm233240e87.48.2025.08.20.04.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 04:34:05 -0700 (PDT)
Date: Wed, 20 Aug 2025 14:34:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, fange.zhang@oss.qualcomm.com,
        yongxing.mou@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, quic_lliu6@quicinc.com
Subject: Re: [PATCH v3 04/14] phy: qcom: qmp-usbc: Add USBC PHY type enum
Message-ID: <cueyo7huj2m2yt46sjk3atfktft6y5slhhtslwmi44r7h7lxbn@5zvwxtdmk34t>
References: <20250820-add-displayport-support-for-qcs615-platform-v3-0-a43bd25ec39c@oss.qualcomm.com>
 <20250820-add-displayport-support-for-qcs615-platform-v3-4-a43bd25ec39c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820-add-displayport-support-for-qcs615-platform-v3-4-a43bd25ec39c@oss.qualcomm.com>
X-Proofpoint-GUID: pfFdSepcTosX--gYm7RsTFAWOU6Q1Zdz
X-Proofpoint-ORIG-GUID: pfFdSepcTosX--gYm7RsTFAWOU6Q1Zdz
X-Authority-Analysis: v=2.4 cv=Xpij+VF9 c=1 sm=1 tr=0 ts=68a5b2b0 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=LJgbN-Jd--P93uwsTkIA:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX6JkuTHC6BTtP
 UIRw5jnyo2KzqejOVxcpF4Qv8xzm/x8PchVFvNk8s2In/lKKeAcDgStqQc6ya3kykndyVPa6Qz7
 /XAkhqO6TakmHnUTwaGNFvqs12IJf47cMCuhniY5UAFbL6wpJo/6KeV0HmjNOyZOUtRNS/0HGhs
 tGlrH8XJUmD4VlwxD3f44yUjOPzy5J233kJSuYnn519Oq5Rx71obzBk+aLaGQrzdHRtim4OJyY4
 kM/SK8FEtHK0kxi2TAPUce11sTczFs0NSex1JOoG74tNGmG2VO43dfNWcYqGn7rbrxlKwQgq8YZ
 T869KFBv14c2kHi2KEK3uRo/dRw4/7jatbYjLK5TkrFCJDSmilHzri2u+dSgRiC+sdfVSP8fyqA
 jf3z+neU/gFP41Cegg+eF92ZfCAZeQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0
 adultscore=0 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On Wed, Aug 20, 2025 at 05:34:46PM +0800, Xiangxu Yin wrote:
> Introduce qmp_phy_usbc_type enum and a 'type' field in qmp_phy_cfg to
> differentiate between USB-only PHYs and USB/DP switchable PHYs.
> 
> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
> index e484caec2be20121cfe287c507b17af28fb9f211..5afe090b546977a11265bbffa7c355feb8c72dfa 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
> @@ -284,6 +284,11 @@ static const struct qmp_phy_init_tbl qcm2290_usb3_pcs_tbl[] = {
>  	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RX_SIGDET_LVL, 0x88),
>  };
>  
> +enum qmp_phy_usbc_type {
> +	QMP_PHY_USBC_USB3_ONLY,
> +	QMP_PHY_USBC_USB3_DP,

Drop, you can use presense of DP offsets in order to differentiate
between USB3 and USB3+DP.

> +};
> +
>  struct qmp_usbc_offsets {
>  	u16 serdes;
>  	u16 pcs;

-- 
With best wishes
Dmitry

