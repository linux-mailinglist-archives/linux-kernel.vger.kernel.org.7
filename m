Return-Path: <linux-kernel+bounces-749319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6388B14CE3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3BB9546934
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EA928982C;
	Tue, 29 Jul 2025 11:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JJvb/z67"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B2C1DE891
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 11:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753787868; cv=none; b=l1WZ0cwTDOgwd7ncNDHvb+ARJY9L1iql5tN2UKBkftnF2aY5ikdWN+a0+/DZirDym5DGka81J8duk2JX1uIf5gVYf3Ef0Ck2Wz2G9x+Nr2akvXMDU24Uz9h3q3YmEKM84zzPd1w9TAvwDyJwYuHDeSsUshbCiLOYg50T9VRumzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753787868; c=relaxed/simple;
	bh=w5fSSjhlZE4kaSUhjPO0bjn6UL+qxNFnllPhL6OPLvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oxaa5op86JhxQfYOtzKFjDZyf0ZO1IIbJwgF8kHBGali4tuY0RLHJmOrPK1R3gWawJRpXTlIejrFxCwk6eSAoSGAcQATVBQqOqd2vGhxvGWALbVMuazFYhIumoi5RR8QXgXl94BNcDM0uMWrHS7DXrZLizTqDg+HwPEEs3Wix8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JJvb/z67; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T84tQn017481
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 11:17:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JYLypgdlK6xbRh65r51fMOTrMAj5xEpWl/0YTtrCvkg=; b=JJvb/z67ZXOEaE5K
	/aMBVM25cxtou/PSxH4NgdnI3Qjd7ItDqfqjueg3qY+TeT2CytUhRTi9oFmqAp9F
	hbsHYs0CBWl8TyDuEqXtmmpmiFAw2GWsILSYR6/pB2uSs8CZf4ZkOq5Uo7PKIqjj
	Oi1ly92bAIK2WH0+o6VggFLza+JsAzvnjEdxUK5V9vMJ77EfaMzqIpnomTHsQU1G
	QnLl/W61rlzE6UmWwIqeD3/cAbmB54pwkW018lDuLecB0KwH/VvyHQpEkNpkeOa2
	pNchutBn14Chx763CGg7whjj3KKkLSUFjApxE/438YcuOrr+w576cO7nyGP9wnOa
	lIsqlg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484p1afunq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 11:17:45 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-7073ec538e2so10812506d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 04:17:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753787865; x=1754392665;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JYLypgdlK6xbRh65r51fMOTrMAj5xEpWl/0YTtrCvkg=;
        b=WDBrpwynm/06x3auG5ifjydPUUa79rcB+eeQ7mF9+5UFOpyA7WkjYUUZW7Cn8sl+Jj
         d/UmbiJjp/fBpbQ0YjJYNXO874Hy7Si2mcCfdQnyM+6/vWilTSRiI0iE+Pd3UWFCdQ8t
         JqXAwVvhNRfvuJzO3kUt/0GfLyIi/wmQ8UtczZhI7wr303XApsY+vTWoMK1JlUaC/mv+
         1hY8Zlx6yZybI91/JQ0QU3BAC1sqUt+gzHzSlX8mcoO0Zzc96yuf6EMhuYhie2TT5eVB
         IdhWqDfU4SOKSwSWRprrlxsjTUPB5PvGWlDPge2Me6koVtFyuql/JYJ6dEfCfmWLSBVK
         /v1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWgkXIakS8eHYMnrzavAqAqA5JY/qEMv+n81SJrwcZf+wot1SHzZRJ3BWL6WZMvZagQ40leH0LPBhDRsfk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk6TQYIKha9tbdNcwd3cvZpBY8xhrWAUO7SZUx1k1SmQQ00jFR
	IWyQbtb6UXqk+5aulecqqzOitM/1atIBJhn1wx9xxpLJeR1X3hXB2O8Do/01v6pXkGM5nCq4CXb
	TZZ5g77ObIkzg2hlxfQP//MmumUOtD64XjtWXo1JDUNjQacKWDNIYQynjeR7ATOJwvDA=
X-Gm-Gg: ASbGncuxB3kPI+lwqJuNX6uGt1N0nJoAsfhByP3pzyY/zY/wtIFZouWKKexqNlmxDxC
	okC8Vs3SygI6epA/TIJJ6uzjYtiTUUAHdnp5C7v9J9MjXg9+IQMhYiMj2xkL/1aUd8TkOaUQ/Tv
	pr6UMvOgtMSEY1AdY7squWXwUcSMr5A4kRoEJl7V5rlumA1c2r9jpB8H+0lQAiKB0q+yqH7kpl4
	ystWaHQGvMkI2Yu2w/bHYL6IzFNZoSyc5AbJyM9GAKSZfHr2tH2Pwk5e8gmINf4kO4fJ7E0UaGM
	mljIVJiWkK0Yj1LGWSQg0yeZ8s9zUqylwnrLn8mSHqDTTg3aM6ACyiPqHoNj1uBYfe18oQwMeFo
	/TQIxQJ6mpK0psqeAWw==
X-Received: by 2002:ad4:5f4c:0:b0:707:4dcc:4f56 with SMTP id 6a1803df08f44-7074dcc58e3mr33456906d6.8.1753787865064;
        Tue, 29 Jul 2025 04:17:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVL/ipLCTE3KQBvxK0+K5+RyTudhg4FnfX6zILSoy/F5vK3nKlWwkqe0t7Ugz+vuHVlx/Q5A==
X-Received: by 2002:ad4:5f4c:0:b0:707:4dcc:4f56 with SMTP id 6a1803df08f44-7074dcc58e3mr33456586d6.8.1753787864544;
        Tue, 29 Jul 2025 04:17:44 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635a63116sm577931366b.90.2025.07.29.04.17.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 04:17:42 -0700 (PDT)
Message-ID: <1f6fc7ce-5826-4f59-89d7-ac691a3ae785@oss.qualcomm.com>
Date: Tue, 29 Jul 2025 13:17:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] arm64: dts: qcom: Add display support for QCS615
To: Fange Zhang <fange.zhang@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>,
        Li Liu <quic_lliu6@quicinc.com>, Dmitry Baryshkov <lumag@kernel.org>
References: <20250718-add-display-support-for-qcs615-platform-v5-0-8579788ea195@oss.qualcomm.com>
 <20250718-add-display-support-for-qcs615-platform-v5-1-8579788ea195@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250718-add-display-support-for-qcs615-platform-v5-1-8579788ea195@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: AmRviw_E6_XGUcS-KPeeWSpXrVE9AfUA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDA4NyBTYWx0ZWRfX/poTD4qFHEDK
 pXG5Usi5fU4sTTwLgwlrJH4y1TZaxtz+2JGPrO3Z1VeKFTSPWmu0JTm1uYGI8jXmFlqOU9x/wSt
 eaAgEYnnWCZ+ZOdGCrse3TCXf3vyMGp9NWN8rlFZXsdOuI2tZ/Gb0PoZaDa7j3fJP2th+1aR6cK
 n2+eei9oooBPxDNv6LGEVib6BwMfYbRLcayRUqazI1+h0OykbS6mZ3kOLxkpWywM0rLJcoFz2d7
 fG8Ndb+PlT2OEGUXUHF3FuV5GwECXlBG9q8XeQLlt8Oyr8nJsKUrg8zk43ZWHEVt7taDX75ca1U
 hfnayUvRBXNz2Qio4avQ3wKZXbkmR7WSTPaJT3TJmZKDv7nt+bCKem9p7v6PSs/x3isy5rXmbnP
 oM70RmlnIxK9Qy38MF9WL/GytpdRiHLqD/VaZ4kR9jWCuC7gujxfXqLUi4wliNV5A0Pufx0f
X-Proofpoint-GUID: AmRviw_E6_XGUcS-KPeeWSpXrVE9AfUA
X-Authority-Analysis: v=2.4 cv=KtNN2XWN c=1 sm=1 tr=0 ts=6888add9 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=Frto0rYOkVf98Gw2rTwA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507290087

On 7/18/25 2:56 PM, Fange Zhang wrote:
> From: Li Liu <quic_lliu6@quicinc.com>
> 
> Add display MDSS and DSI configuration for QCS615 platform.
> QCS615 has a DP port, and DP support will be added in a later patch.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Li Liu <quic_lliu6@quicinc.com>
> Signed-off-by: Fange Zhang <fange.zhang@oss.qualcomm.com>
> ---

[...]

> +
> +			mdss_mdp: display-controller@ae01000 {
> +				compatible = "qcom,sm6150-dpu";
> +				reg = <0x0 0x0ae01000 0x0 0x8f000>,
> +				      <0x0 0x0aeb0000 0x0 0x2008>;
> +				reg-names = "mdp", "vbif";
> +
> +				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
> +					 <&gcc GCC_DISP_HF_AXI_CLK>,
> +					 <&dispcc DISP_CC_MDSS_MDP_CLK>,
> +					 <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
> +				clock-names = "iface", "bus", "core", "vsync";

1 per line please, everywhere> +
> +				assigned-clocks = <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
> +				assigned-clock-rates = <19200000>;

Is this necessary?

> +
> +				operating-points-v2 = <&mdp_opp_table>;
> +				power-domains = <&rpmhpd RPMHPD_CX>;
> +
> +				interrupt-parent = <&mdss>;
> +				interrupts = <0>;

interrupts-extended

> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@0 {
> +						reg = <0>;

Please keep a \n between properties and subnodes

> +						dpu_intf0_out: endpoint {
> +						};
> +					};
> +
> +					port@1 {
> +						reg = <1>;
> +						dpu_intf1_out: endpoint {
> +							remote-endpoint = <&mdss_dsi0_in>;
> +						};
> +					};
> +				};
> +
> +				mdp_opp_table: opp-table {
> +					compatible = "operating-points-v2";
> +
> +					opp-19200000 {
> +						opp-hz = /bits/ 64 <19200000>;
> +						required-opps = <&rpmhpd_opp_low_svs>;
> +					};
> +
> +					opp-25600000 {
> +						opp-hz = /bits/ 64 <25600000>;
> +						required-opps = <&rpmhpd_opp_svs>;

This and the above frequency are missing one zero (i.e. you
have a 10x underclock)

[...]

> +			mdss_dsi0_phy: phy@ae94400 {
> +				compatible = "qcom,sm6150-dsi-phy-14nm";
> +				reg = <0x0 0x0ae94400 0x0 0x100>,
> +				      <0x0 0x0ae94500 0x0 0x300>,
> +				      <0x0 0x0ae94800 0x0 0x188>;

sz = 0x124

> +				reg-names = "dsi_phy",
> +					    "dsi_phy_lane",
> +					    "dsi_pll";
> +
> +				#clock-cells = <1>;
> +				#phy-cells = <0>;
> +
> +				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
> +					 <&rpmhcc RPMH_CXO_CLK>;
> +				clock-names = "iface", "ref";
> +
> +				status = "disabled";
> +			};
> +		};
> +
>  		dispcc: clock-controller@af00000 {
>  			compatible = "qcom,qcs615-dispcc";
>  			reg = <0 0x0af00000 0 0x20000>;
>  
>  			clocks = <&rpmhcc RPMH_CXO_CLK>,
> -				 <&gcc GCC_DISP_GPLL0_DIV_CLK_SRC>;
> +				 <&gcc GCC_DISP_GPLL0_DIV_CLK_SRC>,
> +				 <&mdss_dsi0_phy 0>,
> +				 <&mdss_dsi0_phy 1>,

#include <dt-bindings/clock/qcom,dsi-phy-28nm.h>

Konrad

