Return-Path: <linux-kernel+bounces-806778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F08B49BCD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E1AE447D07
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F9E2D978A;
	Mon,  8 Sep 2025 21:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tc5b5iEx"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B721020C001
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 21:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757366690; cv=none; b=RwUeE85hzXW3LJNp5gNpx0FwZLWFPbtSOyevHP/ZQiieXyFZgTS/4ErfsRRbwKIrWwC79o4iTuZ7vRDNoctiuTRyeM4aJek0muazvIBd7lplFs4ZtBlnPvqNt9vuJUSLVYwKPiJSeAj7OpmxYlFblX27q1OaEgAuYEzVH+/wDZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757366690; c=relaxed/simple;
	bh=GrhFo2xxSW0RZwQnGTIAcXGZnUBnPSqYurMfcGY7EEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9Y2siEI6VL0BRmvCoIgdCP06YkqF8sKLO5jJNqQnZCzVikwln7zyeGHSJK82xoKPM3Hi1E3KjgWIZmVGW2fL1NbkSvSNXrh0ufCWuk4hX6fXIHQSsXshwon4H5tMFnOB39TkplAKQU3lSoLG2iIi21hinsQ3kkRkK7kbO72d88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tc5b5iEx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588HYUYo012376
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 21:24:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Ho1b7eZtsIeWGcXrm1h2k9Iv
	wHibecXwGDuG/9qhAHQ=; b=Tc5b5iExEKbkAuWZ4q8AdY9qYBS1FP/drxF0UoVD
	H6fwJOkLBnR3yuUNgZecFdht/kpP35P6hQniI0vI9pmhsmv3WKo2d9qioVDj8TMd
	yclT+HuM6eIaTGXQx/dFAm/mYs7yLLer0eSY57cuA0nWUicGExDtr04LH7ym3WRe
	IJgz5dMhU1Fx1sY3HsLp3+yMbMuf2IyLbqm1E1TXv89TjP+Gy9hlsmTsBt+VsavQ
	kglAfOjQhpISYs2ucWXpXdvKNcAiQ3IUOVdJLlFVFColP0ZI9B+yMQJwH+ttvqr9
	lKSppt5vktUojfp+Z9Ymiqqv3lf214AE4PE+6lbiXNySNA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490cj0nyrp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 21:24:47 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b5eb7b2c05so106064261cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 14:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757366687; x=1757971487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ho1b7eZtsIeWGcXrm1h2k9IvwHibecXwGDuG/9qhAHQ=;
        b=X+9J2xqZL61faUJaS/lzzt4fhcO3yGAhimoKiC74ecoSVANTm7IkgMK7HK2ALo4CV8
         Qz+uN60HumparsuDem8pm5Tb2igGs0j+phmD3b0Px9MpiyYvlQ7P2tC/DrWw+62u07Ly
         s7zrTGJyLiy77Nae6eICc4tK2nH/zsgkJWKmpwBh2r7XII1r+02ptXp1XlALWIUzt7Jh
         TFD9dA+TUU3nHXal/Vyt7+zZLJfwJAOrSkJpwpdF2i4sRsSQ4nZ55qDR2yGg2M8UVn6N
         b0QMeSIbFiPvCGyeSTwasorIn//v3AXYDcmBpCVSbHO/WzAjsHNhmlFtmFKWY4OR4lT4
         LHaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHTirdZE6yqJTD/gx94qI4/W70i0AHE0EmsdG5FU016f8VYD5W4SziGP12HK9JtkarVNlu9yjnpaQm/Do=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4XIkOtf4JztAIuTJBRwuzEmVxa35rM9FtZUa8oBmrt4oRPe4F
	MsOwBq8tgTJqr1UGvCOTWsRB72eMPUjbOPbFYjQD36fg/Gu2i3cm0LzhLMmspY6eChRwDN16vbj
	FI6GLOz2tsAJ7t84wRlBnVK7fATXBSan/ImnGwRrCBvwzqt9v6hjqvGkif3UJL4DE3gQ=
X-Gm-Gg: ASbGncuGhh5NqtXoNEMxK0PgdSZeeo1EnGk3zPXRuJoYrJSIGkvGx5fHUygTK6mMPqM
	9Bg9Phzmsojs+ELoxjnuL2p0cJ/UAGsiRaSVca1u5RVP74nHV86ctUBRoZweyeRgfoHtBB3eR6o
	QVVlIuL5YtDG8XP2fxc/1xy+FAxLIGHAKzCUs6rT+/ST+DoIFdOavYrXraw6smd1lZn2aDlqYgP
	e+LiWlY4jr2arsbVw6YqbsnQg5Scb4ENoMvGVOqmMWsPIGyV+v0UlA1M2r3uMSgoL4o3FgPa4F0
	2SxdFv5bX+eGACVQIsPyqd/mBck0BsAgOvWmQGtVhzGjyJd9BRBIhjwXbXF0cmVDXmIur4NGB0t
	JIlyH1ZjMEMhOMEIGBrHVJR3zVqdvG5SKgzrZ55F6PN8Ymn6ZGj0K
X-Received: by 2002:a05:622a:4c83:b0:4b6:1abb:79f5 with SMTP id d75a77b69052e-4b61abb7a44mr7384921cf.28.1757366686688;
        Mon, 08 Sep 2025 14:24:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9mHK3xIysct+OJsOitEaI0FFJVfD8DwRlzV1DglA6ed+m8l9nen/ZfTvHn0M3YqIVLtYHdw==
X-Received: by 2002:a05:622a:4c83:b0:4b6:1abb:79f5 with SMTP id d75a77b69052e-4b61abb7a44mr7384521cf.28.1757366686023;
        Mon, 08 Sep 2025 14:24:46 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5680c424fc9sm36306e87.9.2025.09.08.14.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 14:24:45 -0700 (PDT)
Date: Tue, 9 Sep 2025 00:24:43 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v3 4/5] phy: qcom: qmp-combo: get the USB3 & DisplayPort
 lanes mapping from DT
Message-ID: <dfhvmeo3pnjubgiwvakpzhzgl6uwlopyrkwuqyhfqw6jfh4mty@t4lhuh4jh6af>
References: <20250908-topic-x1e80100-hdmi-v3-0-c53b0f2bc2fb@linaro.org>
 <20250908-topic-x1e80100-hdmi-v3-4-c53b0f2bc2fb@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908-topic-x1e80100-hdmi-v3-4-c53b0f2bc2fb@linaro.org>
X-Proofpoint-ORIG-GUID: AgLWroq_BnCQafGJXUbRgFF954XdLV5n
X-Proofpoint-GUID: AgLWroq_BnCQafGJXUbRgFF954XdLV5n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNCBTYWx0ZWRfXxnfS6XJTxUOP
 +Eb5UwGAMM8ce5VnC2LcK5TC0iSr3pVO036xvGNYupchValIs/t7x1hFLgzOvIQKo1jvybqtD0d
 BGsqV2k0+diEgKkCqHHqSu5S1pYjPLZ0KsufHfvTkm7i0YhI+3mDVYyrllf6IB0gHFU397gJ7Ow
 73HGgS3rQC1lk7E53FPYiuX61h3mURM6qD46/g0Y9neQRpaUggZmfEl5jS/CNRysby2wsGXLQcn
 uQoR2kqwA7lBxizSHKJq2fpPhs5dxDN9OV3VTWVSvCaplFuvKdHQTaIOpnvu1Zk8Y0PpEboE16J
 dLVFT3CPhpZSjgTwsTaFN6VlDyphdzsZywSyS6C7FxpSpQlAUVYYSnsfEqa6GBPnn8wRFKKAhYD
 Meo8NS56
X-Authority-Analysis: v=2.4 cv=QeFmvtbv c=1 sm=1 tr=0 ts=68bf499f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=V-D1fa0CeKMiCSXBIY0A:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060024

On Mon, Sep 08, 2025 at 03:04:21PM +0200, Neil Armstrong wrote:
> The QMP USB3/DP Combo PHY hosts an USB3 phy and a DP PHY on top
> of a combo glue to route either lanes to the 4 shared physical lanes.
> 
> The routing of the lanes can be:
> - 2 DP + 2 USB3
> - 4 DP
> - 2 USB3
> 
> Get the lanes mapping from DT and stop registering the USB-C
> muxes in favor of a static mode and orientation detemined
> by the lanes mapping.
> 
> This allows supporting boards with direct connection of USB3 and
> DisplayPort lanes to the QMP Combo PHY lanes, not using the
> USB-C Altmode feature.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 132 ++++++++++++++++++++++++++++--
>  1 file changed, 124 insertions(+), 8 deletions(-)

Looking at the patch... Would it be possible to make it more generic? I
think some of the RockChips also have similar combo USB+DP PHY (and
similar issues). I believe, Mediatek might also have the same issue.

> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> index 7b5af30f1d028c592500e723ecd27b54ed554709..f3f91a69dc8b81e049cd06f7ab4f04baf57776cd 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> @@ -13,6 +13,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> +#include <linux/of_graph.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
>  #include <linux/regulator/consumer.h>
> @@ -1744,6 +1745,21 @@ static const u8 qmp_dp_v6_pre_emphasis_hbr_rbr[4][4] = {
>  	{ 0x22, 0xff, 0xff, 0xff }
>  };
>  
> +static const u32 usb3_data_lane_mapping[][2] = {
> +	[TYPEC_ORIENTATION_NORMAL] = { 1, 0 },
> +	[TYPEC_ORIENTATION_REVERSE] = { 2, 3 },
> +};
> +
> +static const u32 dp_2_data_lanes_mapping[][2] = {
> +	[TYPEC_ORIENTATION_NORMAL] = { 0, 1 },
> +	[TYPEC_ORIENTATION_REVERSE] = { 3, 2 },
> +};
> +
> +static const u32 dp_4_data_lanes_mapping[][4] = {
> +	[TYPEC_ORIENTATION_NORMAL] = { 0, 1, 2, 3 },
> +	[TYPEC_ORIENTATION_REVERSE] = { 3, 2, 1, 0 },
> +};
> +
>  struct qmp_combo;
>  
>  struct qmp_combo_offsets {
> @@ -4167,9 +4183,114 @@ static int qmp_combo_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_node_put;
>  
> -	ret = qmp_combo_typec_register(qmp);
> -	if (ret)
> -		goto err_node_put;
> +	qmp->qmpphy_mode = QMPPHY_MODE_USB3DP;
> +
> +	if (of_find_property(dev->of_node, "mode-switch", NULL) ||
> +	    of_find_property(dev->of_node, "orientation-switch", NULL)) {
> +		ret = qmp_combo_typec_register(qmp);
> +		if (ret)
> +			goto err_node_put;
> +	} else {

At least this needs to be extracted to a function (or set of functions).

> +		enum typec_orientation usb3_orientation = TYPEC_ORIENTATION_NONE;
> +		enum typec_orientation dp_orientation = TYPEC_ORIENTATION_NONE;
> +		struct device_node *usb3_ep, *dp_ep;
> +		u32 data_lanes[4];
> +		int count, i;
> +
> +		usb3_ep = of_graph_get_endpoint_by_regs(dev->of_node, 0, 0);
> +		dp_ep = of_graph_get_endpoint_by_regs(dev->of_node, 0, 1);
> +
> +		if (usb3_ep) {
> +			ret = of_property_count_u32_elems(usb3_ep, "data-lanes");
> +			if (ret == -EINVAL)
> +				/* Property isn't here, ignore property */

In all thsese error cases we are leaking a ref count on usb3_ep and
dp_ep.

> +				goto usb3_mapping_done;
> +			if (ret < 0)
> +				goto err_node_put;
> +
> +			count = ret;
> +			if (count != 2)
> +				/* Property size is invalid, ignore property */
> +				goto usb3_mapping_done;
> +
> +			ret = of_property_read_u32_array(usb3_ep, "data-lanes", data_lanes, count);
> +			if (ret)
> +				goto err_node_put;
> +
> +			for (i = TYPEC_ORIENTATION_NORMAL; i <= TYPEC_ORIENTATION_REVERSE; i++)
> +				if (!memcmp(data_lanes, usb3_data_lane_mapping[i], sizeof(u32) * 2))
> +					break;
> +
> +			if (i >= TYPEC_ORIENTATION_REVERSE)
> +				/* Property value is invalid, ignore property */
> +				goto usb3_mapping_done;
> +
> +			usb3_orientation = i;
> +		}
> +
> +usb3_mapping_done:
> +		of_node_put(usb3_ep);
> +
> +		if (dp_ep) {
> +			ret = of_property_count_u32_elems(dp_ep, "data-lanes");
> +			if (ret == -EINVAL)
> +				/* Property isn't here, ignore property */
> +				goto dp_mapping_done;
> +			if (ret < 0)
> +				goto err_node_put;
> +
> +			count = ret;
> +			if (count != 2 && count != 4)
> +				/* Property size is invalid, ignore property */
> +				goto dp_mapping_done;
> +
> +			ret = of_property_read_u32_array(dp_ep, "data-lanes", data_lanes, count);
> +
> +			if (ret)
> +				goto err_node_put;
> +
> +			for (i = TYPEC_ORIENTATION_NORMAL; i <= TYPEC_ORIENTATION_REVERSE; i++) {
> +				switch (count) {
> +				case 2:
> +					ret = memcmp(data_lanes, dp_2_data_lanes_mapping[i],
> +						      sizeof(u32) * count);
> +					break;
> +				case 4:
> +					ret = memcmp(data_lanes, dp_4_data_lanes_mapping[i],
> +						     sizeof(u32) * count);
> +					break;
> +				}
> +
> +				if (!ret)
> +					break;
> +			}
> +
> +			if (i >= TYPEC_ORIENTATION_REVERSE)
> +				/* Property value is invalid, ignore property */
> +				goto dp_mapping_done;
> +
> +			dp_orientation = i;
> +		}
> +
> +dp_mapping_done:
> +		of_node_put(dp_ep);
> +
> +		if (dp_orientation == TYPEC_ORIENTATION_NONE &&
> +		    usb3_orientation != TYPEC_ORIENTATION_NONE) {
> +			qmp->qmpphy_mode = QMPPHY_MODE_USB3_ONLY;
> +			qmp->orientation = usb3_orientation;
> +		} else if (usb3_orientation == TYPEC_ORIENTATION_NONE &&
> +			 dp_orientation != TYPEC_ORIENTATION_NONE) {
> +			qmp->qmpphy_mode = QMPPHY_MODE_DP_ONLY;
> +			qmp->orientation = dp_orientation;
> +		} else if (dp_orientation != TYPEC_ORIENTATION_NONE &&
> +			 dp_orientation == usb3_orientation) {
> +			qmp->qmpphy_mode = QMPPHY_MODE_USB3DP;
> +			qmp->orientation = dp_orientation;
> +		} else {
> +			dev_warn(dev, "unable to determine orientation & mode from data-lanes");
> +		}
> +	}
>  
>  	ret = drm_aux_bridge_register(dev);
>  	if (ret)
> @@ -4189,11 +4310,6 @@ static int qmp_combo_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_node_put;
>  
> -	/*
> -	 * The hw default is USB3_ONLY, but USB3+DP mode lets us more easily
> -	 * check both sub-blocks' init tables for blunders at probe time.
> -	 */
> -	qmp->qmpphy_mode = QMPPHY_MODE_USB3DP;
>  
>  	qmp->usb_phy = devm_phy_create(dev, usb_np, &qmp_combo_usb_phy_ops);
>  	if (IS_ERR(qmp->usb_phy)) {
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

