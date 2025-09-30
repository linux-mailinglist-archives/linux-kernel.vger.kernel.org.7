Return-Path: <linux-kernel+bounces-838077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7386BBAE616
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 20:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB2894A5BCA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 18:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE3A279918;
	Tue, 30 Sep 2025 18:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oTirnR1U"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670502773D4
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 18:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759258594; cv=none; b=IeXdmddEIjwd9D/lQYJuLP74ftZ9q05fGBpfw8plMe0lqhOrETRo9mLQZouLiJHiIg6La0voEvKet2JmX4mFdEf7+TagxlTlX/baa4/KmHW4KIsfZ4ziEiX9n1cNgtCTJdHtm+Purkt4U7p2sn/pUtV1md4k3cpLOyqtvtchrLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759258594; c=relaxed/simple;
	bh=PXtwsRcd1qYqDjPebUu6RRAgyQt+A86WEtDc3H9/ElY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVeYIfp8CJC+rjIORuzQPvQWEOx2Dgfof+4WV2pB59gfy9gi6x1hR/09AGMlUPeEinssp3mtV5e+/WqSSc9wjdpll4aOhpw6GsPMNjRH/VmLOnwYa8WZdrVfsdb8h1Thmp4EqADZB9Tf2oHU1RX7kpu7UCK41Tjf4xXhxGot7lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oTirnR1U; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UBWrso011778
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 18:56:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=V/OMvPsmXCvICDYI+aDy61hj
	qbzRWVVGIUnKyYVKzhY=; b=oTirnR1UkTKN58dV8P9Jap/U+OeRj/e/lysnnON8
	3SYP8Lou9EM1WsG7Lw00xyGHA6qvYqjgH0q9rL9mtg5uvFlkCHskkhBGQbA5IhZv
	piCfpgKIo/Be6Vcp9VMymKqKY4etJeBfCSBPZpV2iFUjpMBkQPxBT9xhQQ70kpZW
	l47QLoNbT4D/DR0O1YR3HUFevRB9hWB30ixAN6bNRY6rKPCdXhVPMgfUzUFNWsGm
	XQpLFJmXpoNYMF2xrp2rfzQa54ADdkC63TlQOQY3X5PZW6BsQqEUEKeTFlURgGR4
	dwjcPRJtRs8NZ+pAmXSj3dd5NA9678BU2YVX6P3SSp3YaQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e5mctgdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 18:56:30 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4de801c1446so101573681cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 11:56:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759258589; x=1759863389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/OMvPsmXCvICDYI+aDy61hjqbzRWVVGIUnKyYVKzhY=;
        b=VijecCeXnh98bq97UdLjqaBWQSNqdufHTKms6fRoPwy5OOKTtKKyzoCkFVs3rcviEm
         +ST/eQA9jb4+ZANuUCqdaC3fPRDMN7UM8YEBx5t0VV9KNURiQa7BeZdO9v0MV0ApWPGV
         7dPgFwxRXbs//5PkpT/zP2qvbLGrGGTRWX7LuyCStjVDYQJgNFywFficr9Dsv9+lqY5b
         TW86KK09RRUu7SwbTl15qOQ1bucs8vHkGj8YZKjcQ+4J5fkaHiOk4JJH7m3lzW3E3W9a
         sAWlWOeeSZDoS9i6kV8QW5jsgaVGEB1liOQU5DDZ+9nJ+ILSvKHX7i0ZEp7uOBYpWxJW
         bgSg==
X-Forwarded-Encrypted: i=1; AJvYcCVDEukyw9SECzHW7HhU1OoWTJAVUA/yYfjrQ3Tc7/Y7/lnJlV1NZVp6JqGOQnPo7H7goQzNvrD3TSaXnVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYtbgkWhrkK4LSjYVjp14kAKxz/cosSqz0AM44h3JEDKZApqXt
	m4ks2TxpdhtenzZ2gwZSdugqDUG317ZBET6bwO8MaN2EKRoAocmz/joAM/ne3sEyj/aXxzcFoGy
	dAipUypbI6+AwASg05l9G4+uEyte0jSeUwR9zyMMoSatvIxZb6NlACv5ol93lDMYj1vo=
X-Gm-Gg: ASbGnctKs4FL19VhN9sL0vvmXPMccdWDGQZhBDJKCg8ugqavv6GZH7vYAdKF7NWfomU
	sd3QiUZMWEf0iJZKlkx5Pjhgb231x6rs0N8W1p7oanDlxZAV8YpnILJ0AV2RceRfVBfREnRuwrl
	gcv3PVqqsJPNFaApKDoC/pxnrN6Va1IltmLn7BQ3BcM1ZKWh7y6k1mkjyqKwZa3Drh/FA5YDbA2
	7HyypnfD2BYP7I4PIGVfELGob+6iRzslIOE7H4IceKf//7TcvDIAGYW01zYiVkpH7NSNIS8YNnG
	kH08nu6YUJ8D3DIGgL1DC59tP0klvS0FffVYFxwXAxIgM/+nItFuVrfk0QlS/bF1BC88N9i2+BB
	HL0/O4PG4Fu4CLO6AI/bsHxbdvIG4UWTz1FbzPozjWjtIMz2yPOBHLip7kQ==
X-Received: by 2002:ac8:5a49:0:b0:4b7:a8a1:3f2b with SMTP id d75a77b69052e-4e41e825e31mr9552131cf.64.1759258589040;
        Tue, 30 Sep 2025 11:56:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtCiYt7FMAzWgeneawmAeX/wzn69Dw7nDlfMUDs8bcGjbCrdSrmalKVFRpAjd5R/gcKR6Agw==
X-Received: by 2002:ac8:5a49:0:b0:4b7:a8a1:3f2b with SMTP id d75a77b69052e-4e41e825e31mr9551721cf.64.1759258588450;
        Tue, 30 Sep 2025 11:56:28 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-586a064a22bsm2621293e87.59.2025.09.30.11.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 11:56:27 -0700 (PDT)
Date: Tue, 30 Sep 2025 21:56:25 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Xilin Wu <sophon@radxa.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] phy: qcom: qmp-combo: get the USB3 & DisplayPort
 lanes mapping from DT
Message-ID: <uozgwot7yuwmaiwmqoo6ickblpqe52tnj44tnxcorygqxwou52@hksvktgq5zp7>
References: <20250930-topic-x1e80100-hdmi-v4-0-86a14e8a34ac@linaro.org>
 <20250930-topic-x1e80100-hdmi-v4-2-86a14e8a34ac@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930-topic-x1e80100-hdmi-v4-2-86a14e8a34ac@linaro.org>
X-Authority-Analysis: v=2.4 cv=RMC+3oi+ c=1 sm=1 tr=0 ts=68dc27de cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=jDN6A-fuz-j-nsQmgYgA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: zwbwoc9A4FwJkH0IO8hkkPDVciY_JEtV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAwNCBTYWx0ZWRfX74XyJaT/jSBJ
 NFDTw+O75CHXfNWQHX2hkQNl/40QCueItxaz++OHbhggV6Hb359hc+uaIm27boXL5IBaSLabEX6
 CWrx0h58Pc3vxeq7VpRckDqHwbKUimqrOoAxJhwIWntHCyksB0SiVV3Plsalgmr2ly9AkfMc+IG
 L5SzPXgp/TmYxUx8NqnMDkGAPI0LtApy8ROMmwR0G0QXIIUmh37iHcHxMVTztX26st+9Utsprwz
 UiDKY8pBSbc3ksvteO2aDeG2uHIjxqqB+bbIqHacM6stjEuQ5sZp00TqbxlUtZZrwvZK/wT+0aW
 NoPUKNcK1959nUum7k5XTgdSQf8E9nUBFBUl+sk6rEwf4OIF8Hj/FVsWIulNNVcQatDNGAHbi4m
 fWJbqjQKo0qqSLoFgVjX/0XZShQYbw==
X-Proofpoint-GUID: zwbwoc9A4FwJkH0IO8hkkPDVciY_JEtV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0
 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270004

On Tue, Sep 30, 2025 at 09:39:48AM +0200, Neil Armstrong wrote:
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
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 145 ++++++++++++++++++++++++++++--
>  1 file changed, 137 insertions(+), 8 deletions(-)
> 
> @@ -4167,9 +4269,41 @@ static int qmp_combo_probe(struct platform_device *pdev)
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
> +		enum typec_orientation dp_orientation = TYPEC_ORIENTATION_NONE;
> +		enum typec_orientation usb3_orientation = TYPEC_ORIENTATION_NONE;
> +
> +		ret = qmp_combo_get_dt_dp_orientation(dev, &dp_orientation);
> +		if (ret)
> +			goto err_node_put;
> +
> +		ret = qmp_combo_get_dt_usb3_orientation(dev, &usb3_orientation);
> +		if (ret)
> +			goto err_node_put;
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
> @@ -4189,11 +4323,6 @@ static int qmp_combo_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_node_put;
>  
> -	/*
> -	 * The hw default is USB3_ONLY, but USB3+DP mode lets us more easily
> -	 * check both sub-blocks' init tables for blunders at probe time.
> -	 */
> -	qmp->qmpphy_mode = QMPPHY_MODE_USB3DP;

SHouldn't this still be a default in the 'normal' USB-C case?

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

