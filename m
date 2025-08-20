Return-Path: <linux-kernel+bounces-777603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF651B2DB9A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CD881BA6D6B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8792E54D7;
	Wed, 20 Aug 2025 11:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B89iNIsy"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406B42E3363
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755690363; cv=none; b=YyNYYiXNCBuV5YXUth+x879Js6pRXvSIbnGc0f3TIbU6N+8QCWcEYZZqTpXLHlCmr8QPUYw1hXN7aXK2NGjlA8UTVKx5CID10CeDob20L0HNMu/wD5ypXggJj+NKAnz2gRGXv7i6Lck5tt8hpXSNGaEs8j6D4tA1jUW0VKIq0vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755690363; c=relaxed/simple;
	bh=8r05lY7gF/iBShhxcOR5TR/q1dpTHr0X7S5saZrhy8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAGPcPlXupyQdku8EW/0qKbyvNP1lWtLpKP1U5IGz3KYF60LLcKV5u6Ikvg3myqDt7TKcSm01TtsVRntQxxYVwWPItnyyoYzYSp/XhIHnd8RtI54N8kbyTMjLuIYOYLMwU6uLMQpr7GwO93RdZZyCD6OeOV65pk3YovATZBJdQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B89iNIsy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K9wSfA025245
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:46:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=86Ln+09pzyozcQ/MppaK2YJ1
	etLMTMvIuD/Ncqfow7s=; b=B89iNIsyfpDobeJi/CKyI3/jrxOpQ+j9kBlRJmMt
	oREaLSNisve+CUXbIxSjxOHyK7NRV29nBJxgrtbXZ9wixa3qempgSqCMBFOISd2I
	aXXYfKEmz8jR9Ulph1oLhCuRyvkjcuD+oHqosGJXPkEYVd/UoUAImN007rwM3MLD
	ag6Gza9tPLGhGtYbPWD2AoyITlvn25eSjqkpGpgRnS05zRcQfrbAcfoAhjixaRtr
	WwBiD7IhRQZDHdIN2jjC9u2k5RDC+CwQPJdpnb/sSLg/BWOv8c4KTSJueKqtyfqN
	QIe4VrhJxUtK/GKAhUebGerKKN/I4DvYbwbtwjvxy+0FOA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5291k2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:46:01 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70a9289baafso17243876d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 04:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755690360; x=1756295160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86Ln+09pzyozcQ/MppaK2YJ1etLMTMvIuD/Ncqfow7s=;
        b=wx93BXmlgGBGE06vX1HYMt1xOzRAcNpwOeMlINFqQQqkgWnbbZ22vK9VyISUsKnXaC
         vz6WSRBfCu8fdPe06CUq6Fnjc5EJ03ez9K4zPVhOCRaCJR7+wZUJVih6GoHYOnFYm3kx
         qjs+G3m918QXsE8kJBzDOPW5j+B+AIMZXvscwx76RtHqW2K0wrGdtgAGs7PlNSk3i2az
         fZkwQH4aHUI2GPfFwy/bd9zLUF6FbBDVTpOlznGFHlYFCv0nWCOMfZ8uBLQjaLPi9tbk
         gGeUligZe12UwHyyqLKQupJxzZ5JYZKf/wUNaVRZs8+ci8u7NnJhVCJMdcSCBSaMjrXN
         54fQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3U1tue70JXU3TrXeZP07NwvyAEGAtY7JPtnp1jtmkifvvQ6Mxc3mBMqJiT83IQHygDuafoUAH3KL1zJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLkhtlCNlSVxvH/9TOZmixnC6dwQJ7ifvTVtfVt1dXXfo6yAyE
	zGPDNLwgbRle3kZQxLSMH7dIe8Qb6QOFqvGsXomeb2Pd23D470cI7liCBBYafafZcKqZ08KFaSP
	bkzaQXt2aaDjiSYPv8Ls6nCo1PMv4E/nDGCgVt1a3BBm0BQtjDvEhswsMrRF3c7or2Cc=
X-Gm-Gg: ASbGncsr0q/7KCiepO8P1yYznGvEEBwSRYPOm537B5RiIwRqxk/O33487dVgXHYXErH
	diiT7dlkfTC6IpQT7pVUxNV1T47whyqFqTalOQK4EHzCZSXNnd4ay7drJTIfLaVX72wt64W0C3m
	sb+79FO/svtIF4f/fTBwqBZM6sp9lSefTI+jvEJw/nF77xqLqx8pEtvMDSehCmkBgupPfNO/cOK
	84eZFd6I7AEx6XwhcSfpFjJ8EjV9zQ0FUVrtXyV/66O8GqCGs8zZ90/hIOv7tdGKwdAAkqSSL0L
	bpubk77DB6vwNoeStfKxi398vZh3no0OaTdL/8ff/Pw6uMrXdYoMfjjPD+7OwCr+ExWq2S72Vq0
	i2ey+6Yjkxe1EnFjDyYptp46t3YWMkg7pWBVFqnhRs4fVaSgO50di
X-Received: by 2002:ad4:5aa3:0:b0:707:4a94:2203 with SMTP id 6a1803df08f44-70c6a8bab6amr59972546d6.25.1755690359761;
        Wed, 20 Aug 2025 04:45:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlaN2Z2SMVVXIYqO8llzjIfBnKuhBBs2TnJOJtmy1FbGCyh3MeXwdPwEtQXchEguz6D2cJ7Q==
X-Received: by 2002:ad4:5aa3:0:b0:707:4a94:2203 with SMTP id 6a1803df08f44-70c6a8bab6amr59971906d6.25.1755690358997;
        Wed, 20 Aug 2025 04:45:58 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55e02c31498sm660064e87.12.2025.08.20.04.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 04:45:58 -0700 (PDT)
Date: Wed, 20 Aug 2025 14:45:56 +0300
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
Subject: Re: [PATCH v3 09/14] phy: qcom: qmp-usbc: Add DP PHY ops for USB/DP
 switchable Type-C PHYs
Message-ID: <3pr7ninjxr4pgsz56dr6ojjmx27fzzszmtt6mx4r6qaqt25tnc@nrgx5qiqc7z4>
References: <20250820-add-displayport-support-for-qcs615-platform-v3-0-a43bd25ec39c@oss.qualcomm.com>
 <20250820-add-displayport-support-for-qcs615-platform-v3-9-a43bd25ec39c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820-add-displayport-support-for-qcs615-platform-v3-9-a43bd25ec39c@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=ZJKOWX7b c=1 sm=1 tr=0 ts=68a5b579 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=0tJ4ROd8JQyD-KrPA2gA:9 a=CjuIK1q_8ugA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: 1x8_0hAzK11R6aAABECH3Rn-vbtp1AUM
X-Proofpoint-GUID: 1x8_0hAzK11R6aAABECH3Rn-vbtp1AUM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXzgAGAmETO0U5
 YV0I3QCXp+hL4x1akLbms3iKYNs/HJrdYHyF/3lVfK9LunBCDJblHyI3MAlY5BFrF1dY987buKz
 zUqru+zJBQV09iNQXkVDFhN/MX/3rafMyNwZF6bIJrutTOSwyRCgKFVrjb/PtgI0BjF0lBBWsGD
 40eeuP5o8MuO8QJOuq19WBbQAVgMf/ZD5TVMIUhAj/olWkCdkDut9Otkt1ul001GM/AfwSijnKw
 fdU7Ei5D//qvMLVtsJ4HS7RQsF5iRXed7VkSkltQ4pgqx/Q6o6fXKaI4HeakPZfniimZkOO54VX
 WzmpXhO79TQBZYg750UAbpOHeT5WHFO75qU6/4lYFQerZxOM1eqQb5Wg26yALTe/KcsKlSO8P5U
 PI5QeCbiyHItxWnh6r5KJUJR6Gg5NA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On Wed, Aug 20, 2025 at 05:34:51PM +0800, Xiangxu Yin wrote:
> Define qmp_usbc_dp_phy_ops struct to support DP mode on USB/DP
> switchable PHYs.
> 
> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 163 +++++++++++++++++++++++++++++++
>  1 file changed, 163 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
> index 1508a4a5f57aff85318485b79528325f28a825a4..a1495a2029cf038bb65c36e42d0a4f633e544558 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
> @@ -22,6 +22,8 @@
>  #include <linux/slab.h>
>  #include <linux/usb/typec.h>
>  #include <linux/usb/typec_mux.h>
> +#include <dt-bindings/phy/phy-qcom-qmp.h>
> +#include <drm/bridge/aux-bridge.h>

This one is not necessary yet

>  
>  #include "phy-qcom-qmp-common.h"
>  

[...]

>  static const struct phy_ops qmp_usbc_usb_phy_ops = {
>  	.init		= qmp_usbc_usb_enable,
>  	.exit		= qmp_usbc_usb_disable,
> @@ -1095,6 +1248,16 @@ static const struct phy_ops qmp_usbc_usb_phy_ops = {
>  	.owner		= THIS_MODULE,
>  };
>  
> +static const struct phy_ops qmp_usbc_dp_phy_ops = {

Please try restructuring your patches so that there are no unused
warnings in the middle of the series. You can split the next patch into
'parse' and 'enable' parts, then squash this patch into the 'enable'
one.

> +	.init		= qmp_usbc_dp_enable,
> +	.exit		= qmp_usbc_dp_disable,
> +	.configure	= qmp_usbc_dp_configure,
> +	.calibrate	= qmp_usbc_dp_calibrate,
> +	.power_on	= qmp_usbc_dp_power_on,
> +	.power_off	= qmp_usbc_dp_power_off,
> +	.owner		= THIS_MODULE,
> +};
> +
>  static void qmp_usbc_enable_autonomous_mode(struct qmp_usbc *qmp)
>  {
>  	const struct qmp_phy_cfg *cfg = qmp->cfg;
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

