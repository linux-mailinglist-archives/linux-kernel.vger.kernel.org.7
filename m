Return-Path: <linux-kernel+bounces-813690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D2EB5497E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0E76AA5CB3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B302E9EAC;
	Fri, 12 Sep 2025 10:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C4+R0dLt"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2512E974E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757672356; cv=none; b=N8otTt9dKG97N8mo9sg27R9h79HfR6XIvRPyN3lUWBq2ZPQUbE7fdiz36g/keTYb2RloL+WdwinkQk13+1fc+q7C/jPaTOOErFM9fjNhWE3OjnmRQbnOkrRo1lKDbPqC0GBKftuWiiY+6KptuG7XxCIB+30tnmcIwUPbKaSq4Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757672356; c=relaxed/simple;
	bh=I0AbldHjxCRbeGIEdLoOhVRMAU2Sr337P73VKagA0xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MwiEsSkEuXXO/0S3j+hiBOpHm6LxEGIPX7Mst18Goozom3lVNno/Ew2vu5NasUd8GKMmTbmoCi18CvdpU6DUrBkiOxeLP1RhkwaqYQgTjNKx3Ba+czLc7PXx0JmVaTiPlwgFm64PN1zx2243Tcfns0oh1VV8WTSr53eKdgwe5JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C4+R0dLt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C9fCxT018529
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:19:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+8BSRPhlzIdQp9y41D5xs6eH
	qedfNxQ0XWH6TT8qk+k=; b=C4+R0dLtc/nLAf2A6VgC54MT9HbrdeDyVK13a/Z1
	PEIUskUXc1uO1YjMazZiUE5+NXV1y8wDStE96FPmCHy2mLS7NktygpJf4xehUJXf
	KpyWMq0ySs4JXvyhhKvTkNCBzEbb3fhMq/TXCNV8rr5Y1vMq2OGN2xTB5mj072us
	/T5jcwsU0HALTeQmHKE/HYWPdlk3AcXq1vS9Pmv2V8+RL1FXOMWtg/+QkuTLjNvs
	Qg1MsCni9U3nnZ2CY49OApKBJg1vm8QdxnfnJOt5ebchQDq7LfHn8a65R359n5ei
	QskQueW2QmZhueOgjo+CW7dX9RXAGXRY8WQwCORKH1F04A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e8ak510-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:19:14 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b60d5eca3aso45062211cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:19:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757672353; x=1758277153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8BSRPhlzIdQp9y41D5xs6eHqedfNxQ0XWH6TT8qk+k=;
        b=xTihOllAQoKULXatzj+i4UDsmSYe7lznslABK4sV+WCNxBk1iR3kAO7K6KP2Yrxldl
         TGx52X1ebvAbBwi9vQ9eMzmGoOLhHkmmyRLUbOGMyghR5aLJfkxk/EK//xziGs/O0smD
         l+ZzmSPJ9th0T1L7GSCSsm080nsIBz2/zvgbhC9v24YatbEuF5RPGPNc8HaT7Bru8JDW
         7BTdDXnUHmodNBc/Ed1Ft+u+kGn9Yx+tB64O42XOIEVNkqkooUKBg5xhzaiHxtx8NPQi
         TvsxEhddRShPbv4yGXNQ/PBYpZYdMFA+VtO1Fv8Chg89wdC7kex6QIbTj3xxA9LVkSsE
         tCBA==
X-Forwarded-Encrypted: i=1; AJvYcCXIIOl1LZuhJn/q+XwZOxWwjMzFRLvRdUkSQXM8f+QqBaHq0ob5ji0yWHRz1Ny+wdr7OhUtAGWxVin2qTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn9bXsV64AV5WiOJ2bGuovCS8GeEl/UdOtO40iih6zLnOGNRhp
	DwDHLDe6J1wyz6e2D+F08IKRp27C/Zd4yJmhH9mu7jVx8TR4TER1jgIVCJ/WvAiXTLlxhA6Lx5D
	e7FS4f33U6uLIw47/DjnV6mZPpS9Qg1AtkCObk5ju94KMOHvEIX3EYXvlx4ZV9v9n8Jo=
X-Gm-Gg: ASbGnctHPStfc7xCBY6CL9i/fbphKD8bkPjc678tPC+HHmde0CedrF0dnyg054fUeO9
	uURArHgPxDhmSdVxNaVz/1+evmCdPDrkhTg7LTyHZeZzEAG8TUMBJk9Gci70enOt3K2XNfTSwFb
	oqV7Wzs+nzdZ0Rrg8VQgra+IzUjir7B253K9VUc0pOvZz6HRwTQOk1/w0UBwX9EbGJ75ntHjKMO
	D4DwazUJofZQ+rSh0te1VrA3gVGJ2juPDzqdegoi5oQyxnhcLVUHoMpfnsuRPFGg6mnc4CMoBdU
	gF3Hx088dfFmg4JQQMsxcmo9vvQEU7ae7/4aFtBRfLTJTNUjLLSvNETunCAZEqFUkLepiq3XBmJ
	AitwlQMBHaUApW7GkPjc9rql+YEtqJEnPsd5qdbMMe7eufI8PJ/ds
X-Received: by 2002:ac8:5d51:0:b0:4b5:4874:4fa5 with SMTP id d75a77b69052e-4b77d07ee69mr30002831cf.18.1757672352006;
        Fri, 12 Sep 2025 03:19:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDr/xf3Xq/zG3qRRgOoMRE9GeT+a6DC6K2ISKAktnMWoKUg/v0LpRmDDlLQEuN+IJgK34ztQ==
X-Received: by 2002:ac8:5d51:0:b0:4b5:4874:4fa5 with SMTP id d75a77b69052e-4b77d07ee69mr30002371cf.18.1757672351305;
        Fri, 12 Sep 2025 03:19:11 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e6460f138sm1035638e87.111.2025.09.12.03.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:19:10 -0700 (PDT)
Date: Fri, 12 Sep 2025 13:19:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH v4 08/13] phy: qcom: qmp-usbc: Add USB/DP switchable PHY
 clk register
Message-ID: <6p43oxn57kke5eotoqtt5gqtmhmgeteoymewqm3ko5q5veyegs@krkh4dwdno5i>
References: <20250911-add-displayport-support-for-qcs615-platform-v4-0-2702bdda14ed@oss.qualcomm.com>
 <20250911-add-displayport-support-for-qcs615-platform-v4-8-2702bdda14ed@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911-add-displayport-support-for-qcs615-platform-v4-8-2702bdda14ed@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=H7Dbw/Yi c=1 sm=1 tr=0 ts=68c3f3a2 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=Prb7D_9PTKkpd4Urf3EA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: IycCndT7tZTAvGaajhUVhHlIe3O0WD8q
X-Proofpoint-ORIG-GUID: IycCndT7tZTAvGaajhUVhHlIe3O0WD8q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOSBTYWx0ZWRfX+1cRtp96R0XM
 rFQStVYMDpKaeV+dbxxEeRiQz3qeYWOhak2qPWgl0mFNM2VMbsizkWybUJY22BMFa5j8Y/m5Nwc
 t1j+Zi1rSvJqT6Isoq9x1Y2W3Uldu5iDWjZ9wUELSoGdSaWSxtvgJFUne/u6B/xKWXfBEDN0NPY
 YhqRe9cy+inyswLIqeXQv9xpIUw6/BTWzlKmoSOMPC3T2t8tVbQJ3dKk9r/V4IQ1lLHDW3Gilw4
 klEC7XK28gu+LTVlH0M7kLNK6m0CLcP7ZVPu9Bl5Ghft2HsikmoURvjy35ZUl7k74rY+BNseUxx
 gxKT1+HID6sV8wogpq9aNw4eHenOtSlGfHEKMjL7DpREzM7rgrasP4NA6kuoDpf7MjWSAELMDwW
 PAHr8dR8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_03,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060039

On Thu, Sep 11, 2025 at 10:55:05PM +0800, Xiangxu Yin wrote:
> Add USB/DP switchable PHY clock registration and DT parsing for DP offsets.
> Extend qmp_usbc_register_clocks and clock provider logic to support both
> USB and DP instances.
> 
> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 208 +++++++++++++++++++++++++++++--
>  1 file changed, 195 insertions(+), 13 deletions(-)
> 
> @@ -1276,8 +1291,11 @@ static int phy_pipe_clk_register(struct qmp_usbc *qmp, struct device_node *np)
>  
>  	ret = of_property_read_string(np, "clock-output-names", &init.name);
>  	if (ret) {
> -		dev_err(qmp->dev, "%pOFn: No clock-output-names\n", np);
> -		return ret;
> +		char name[64];
> +
> +		/* Clock name is not mandatory. */
> +		snprintf(name, sizeof(name), "%s::pipe_clk", dev_name(qmp->dev));
> +		init.name = name;
>  	}

Do we have any guarantees that memory for 'name' exists beyond this point?

>  
>  	init.ops = &clk_fixed_rate_ops;
> @@ -1286,19 +1304,176 @@ static int phy_pipe_clk_register(struct qmp_usbc *qmp, struct device_node *np)
>  	fixed->fixed_rate = 125000000;
>  	fixed->hw.init = &init;
>  
> -	ret = devm_clk_hw_register(qmp->dev, &fixed->hw);
> -	if (ret)
> +	return devm_clk_hw_register(qmp->dev, &fixed->hw);
> +}
> +
> +
> +/*
> + * Display Port PLL driver block diagram for branch clocks
> + *
> + *              +------------------------------+
> + *              |         DP_VCO_CLK           |
> + *              |                              |
> + *              |    +-------------------+     |
> + *              |    |   (DP PLL/VCO)    |     |
> + *              |    +---------+---------+     |
> + *              |              v               |
> + *              |   +----------+-----------+   |
> + *              |   | hsclk_divsel_clk_src |   |
> + *              |   +----------+-----------+   |
> + *              +------------------------------+
> + *                              |
> + *          +---------<---------v------------>----------+
> + *          |                                           |
> + * +--------v----------------+                          |
> + * |    dp_phy_pll_link_clk  |                          |
> + * |     link_clk            |                          |
> + * +--------+----------------+                          |
> + *          |                                           |
> + *          |                                           |
> + *          v                                           v
> + * Input to DISPCC block                                |
> + * for link clk, crypto clk                             |
> + * and interface clock                                  |
> + *                                                      |
> + *                                                      |
> + *      +--------<------------+-----------------+---<---+
> + *      |                     |                 |
> + * +----v---------+  +--------v-----+  +--------v------+
> + * | vco_divided  |  | vco_divided  |  | vco_divided   |
> + * |    _clk_src  |  |    _clk_src  |  |    _clk_src   |
> + * |              |  |              |  |               |
> + * |divsel_six    |  |  divsel_two  |  |  divsel_four  |
> + * +-------+------+  +-----+--------+  +--------+------+
> + *         |                 |                  |
> + *         v---->----------v-------------<------v
> + *                         |
> + *              +----------+-----------------+
> + *              |   dp_phy_pll_vco_div_clk   |
> + *              +---------+------------------+
> + *                        |
> + *                        v
> + *              Input to DISPCC block
> + *              for DP pixel clock
> + *
> + */
> +static int qmp_dp_pixel_clk_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
> +{
> +	switch (req->rate) {
> +	case 1620000000UL / 2:
> +	case 2700000000UL / 2:
> +	/* 5.4 and 8.1 GHz are same link rate as 2.7GHz, i.e. div 4 and div 6 */
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static unsigned long qmp_dp_pixel_clk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
> +{
> +	const struct qmp_usbc *qmp;
> +	const struct phy_configure_opts_dp *dp_opts;
> +
> +	qmp = container_of(hw, struct qmp_usbc, dp_pixel_hw);
> +
> +	dp_opts = &qmp->dp_opts;
> +
> +	switch (dp_opts->link_rate) {
> +	case 1620:
> +		return 1620000000UL / 2;
> +	case 2700:
> +		return 2700000000UL / 2;
> +	case 5400:
> +		return 5400000000UL / 4;

No HBR3 support? Then why was it mentioned few lines above?

> +	default:
> +		return 0;
> +	}
> +}
> +


> +static int qmp_usbc_register_clocks(struct qmp_usbc *qmp, struct device_node *np)
> +{
> +	int ret;
>  
> -	ret = of_clk_add_hw_provider(np, of_clk_hw_simple_get, &fixed->hw);
> +	ret = phy_pipe_clk_register(qmp, np);
>  	if (ret)
>  		return ret;
>  
> -	/*
> -	 * Roll a devm action because the clock provider is the child node, but
> -	 * the child node is not actually a device.
> -	 */
> -	return devm_add_action_or_reset(qmp->dev, phy_clk_release_provider, np);
> +	if (qmp->dp_serdes != 0) {
> +		ret = phy_dp_clks_register(qmp, np);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return devm_of_clk_add_hw_provider(qmp->dev, qmp_usbc_clks_hw_get, qmp);

Do you understand what did the comment (that you've removed) say? And
why?

>  }
>  
>  #if IS_ENABLED(CONFIG_TYPEC)
> @@ -1429,6 +1604,13 @@ static int qmp_usbc_parse_dt(struct qmp_usbc *qmp)
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
>  
> +	if (offs->dp_serdes != 0) {
> +		qmp->dp_serdes = base + offs->dp_serdes;
> +		qmp->dp_tx = base + offs->dp_txa;
> +		qmp->dp_tx2 = base + offs->dp_txb;
> +		qmp->dp_dp_phy = base + offs->dp_dp_phy;
> +	}
> +
>  	qmp->serdes = base + offs->serdes;
>  	qmp->pcs = base + offs->pcs;
>  	if (offs->pcs_misc)
> @@ -1537,7 +1719,7 @@ static int qmp_usbc_probe(struct platform_device *pdev)
>  	 */
>  	pm_runtime_forbid(dev);
>  
> -	ret = phy_pipe_clk_register(qmp, np);
> +	ret = qmp_usbc_register_clocks(qmp, np);
>  	if (ret)
>  		goto err_node_put;
>  
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

