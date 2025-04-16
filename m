Return-Path: <linux-kernel+bounces-602753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA576A87ECA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 13:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6F333AD2E5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 11:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2C0290BBE;
	Mon, 14 Apr 2025 11:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EMH8o4Ui"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B11128EA4C
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 11:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744629217; cv=none; b=aBVv+BlCT9IovtkKvRmS+3BxLLE88481RDHqHvKs37Vt2U8VKkIqC8fp7G7wcqgIpJMTlWtTgZSiiHUhKFGcKfJyw0WR6UBb7ZRM2XSee02KIF4522dPqk9Dkq7nTjCnHi+1XRqELVPUQDsiML0A9HdIdRDyIEd43HNrlD/QC7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744629217; c=relaxed/simple;
	bh=m/dzqwNGxtnJQJBQ7oNtj1eDf156GpRDme2iFk0S0ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ssmw6o4O1f63lbAcDWc+fKBc2sGVHg/XZFISSDnZcb2ddDKHOt3fJ6Z4jw2d9182217X25YBPgDZKNI+iW4jHyFRhqZtnFRH3f5/wUXm5JM1uZhDwIkcDkDb1Y/ZV7UYS+nZwFC7r4kVXifiDNjcyZax7q2xtC6UdArnIN+xuR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EMH8o4Ui; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53E99rh1016340
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 11:13:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0EbZ/7NYSQIH2cjZdJu66a5YVTDn2d6A3WWziI79Ht0=; b=EMH8o4UiuC80ePp5
	bTfw+V5gsrNTJyr5ErSeCcejqaOEE7efz0FI6/+TJd+hSUi/Pn7oqsw9/uPrNrIK
	01F3VCO5qtsWnNBoxrPHR7/BukU6wQLZFdSiC0o/j9pZinVPSWOEIvflzJ+uEmw9
	KwdDovqji/+ymjp0OGqYdu5+ZQhICieELp6b3yKBQWwf62Tk/WlF7R+H35SiYYd5
	EXg0oprAgxfHyfCpzm+ksPBnh6RMSTkbgP+2tqQ9wZYBZE8JqxivdiVU+WqWiN/n
	AaFT744056+93JgbBUuSKrGcnxw5dG8NANk2LIAhxvqhI1oNXPG+AMKNqButGZHf
	LrDcvg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yfgjcapm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 11:13:34 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-47708fd6446so5586661cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 04:13:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744629214; x=1745234014;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0EbZ/7NYSQIH2cjZdJu66a5YVTDn2d6A3WWziI79Ht0=;
        b=MHRz2qTB8+ITGuXapY9IuK5wgRFgMIlM7Yl/sOgDV4znpjbGyu77eB5YGi6Quc6NSm
         6I3WunjM/pcxQoNHo6NOHmiVqlcaMqkg3CeEexyiwvt1njzKwwoBvgi1WQY+Whr0Nrr0
         K8hiWCy+qXE57H6uwfA4hm3kGuzzds3uXkvJJJSKh5yoGzfmuPa3y4BkCU/MFXwgqIab
         +Nb0DpDPqMK5z8yYd3vZ5wYuh50Qd9agVKYrh1Ct1i7LD+NixbrsoTajEx5C5BC5Qj2L
         RhYXKC7d1sadIqJr94PnIPbM8chCNC52NnpbhZyxrv4xajRfHLAJs3q0sgH74XxkYpEs
         vdng==
X-Forwarded-Encrypted: i=1; AJvYcCVBWXXzm8OP17zeIx4dTeqAHVmbF/HX4RG46brIn/5Ldohscfcui9H+484lit+6Cz0F/pNoawehMBMmqeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAWapzkvyukv56zWgj6B7ahjY77TFmKATfy5pus70Gqd+SSUGk
	nuWgJjjUsK9Jc2ii7c5S7kh5fy1SFFMKpwStsK346d63XcnUPKKXypM1fMGURWn+T4dC3eD2uEU
	yVCbhKC0ec1Z+9KGdLWXCaJs5xh1+K8mtng9x6Cul5lMUsUV0SDLeXRnb3gq5GVE=
X-Gm-Gg: ASbGncsEbJ8rNk65TS7LP7m8MFcc5+nm2NxXSfoH+mPElAku8P0F+PBDuCgaCywl89/
	Is3iR4iyentzCKNGCjd2K1j4l5EuGZ5MGeZ1zuJ9Hz7L0uHMWQfuIeURTELCsfdcbrz4DxvwHHV
	FMDUbhnokI6NJ1Z9nl0MKWFGAlXkjZ7Ad726DTI0xG0YXHPQn8BQdgrRbDcOeyP8tEVHMV0fBmI
	x6+ufLLMoaTAblWUxzLJOtb6Nlxypiy3P8dbfWY8KCuUoeTGAvGbQkm0whqsUyicbJdNu91sYKc
	VAJKKpPQ73ZMv8VCN4hKCS6LCTJZuy7UuInsmHaz/KSGIz7hpTaaiZCvz7xMfig0dA==
X-Received: by 2002:a05:6214:f0b:b0:6d8:a091:4f52 with SMTP id 6a1803df08f44-6f230ed2d8emr52865056d6.7.1744629214017;
        Mon, 14 Apr 2025 04:13:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1Jbmw7xqykDTZc49xLzKxc4E3Rb3zQy24sMs1xRcp71xMPft8CUZbEMdUMS6+juIPQDVqtw==
X-Received: by 2002:a05:6214:f0b:b0:6d8:a091:4f52 with SMTP id 6a1803df08f44-6f230ed2d8emr52864726d6.7.1744629213585;
        Mon, 14 Apr 2025 04:13:33 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1ce81c5sm880990966b.184.2025.04.14.04.13.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 04:13:32 -0700 (PDT)
Message-ID: <c14dfd37-7d12-40c3-8281-fd0a7410813e@oss.qualcomm.com>
Date: Mon, 14 Apr 2025 13:13:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] arm64: dts: qcom: sar2130p: add display nodes
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Bjorn Andersson <andersson@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20250314-sar2130p-display-v2-0-31fa4502a850@oss.qualcomm.com>
 <20250314-sar2130p-display-v2-10-31fa4502a850@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250314-sar2130p-display-v2-10-31fa4502a850@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: xBqjmI7iBN0pSx_U07wAm55PC0-oggf-
X-Proofpoint-ORIG-GUID: xBqjmI7iBN0pSx_U07wAm55PC0-oggf-
X-Authority-Analysis: v=2.4 cv=Cve/cm4D c=1 sm=1 tr=0 ts=67fcedde cx=c_pps a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=KKAkSRfTAAAA:8 a=M9PBs-WKjKzZjRsr6pgA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_03,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=689 mlxscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504140081

On 3/14/25 7:09 AM, Dmitry Baryshkov wrote:
> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Add display controller, two DSI hosts, two DSI PHYs and a single DP
> controller. Link DP to the QMP Combo PHY.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

[...]

> +			mdss_mdp: display-controller@ae01000 {
> +				compatible = "qcom,sar2130p-dpu";
> +				reg = <0x0 0x0ae01000 0x0 0x8f000>,
> +				      <0x0 0x0aeb0000 0x0 0x2008>;

size = 0x3000

[...]

> +
> +			mdss_dp0: displayport-controller@ae90000 {
> +				compatible = "qcom,sar2130p-dp",
> +					     "qcom,sm8350-dp";
> +				reg = <0x0 0xae90000 0x0 0x200>,
> +				      <0x0 0xae90200 0x0 0x200>,
> +				      <0x0 0xae90400 0x0 0xc00>,
> +				      <0x0 0xae91000 0x0 0x400>,
> +				      <0x0 0xae91400 0x0 0x400>;
> +				interrupt-parent = <&mdss>;
> +				interrupts = <12>;
> +				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DPTX0_AUX_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_INTF_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK>;
> +				clock-names = "core_iface",
> +					      "core_aux",
> +					      "ctrl_link",
> +					      "ctrl_link_iface",
> +					      "stream_pixel";
> +
> +				assigned-clocks = <&dispcc DISP_CC_MDSS_DPTX0_LINK_CLK_SRC>,
> +						  <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC>;
> +				assigned-clock-parents = <&usb_dp_qmpphy QMP_USB43DP_DP_LINK_CLK>,
> +							 <&usb_dp_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
> +
> +				phys = <&usb_dp_qmpphy QMP_USB43DP_DP_PHY>;
> +				phy-names = "dp";
> +
> +				#sound-dai-cells = <0>;
> +
> +				operating-points-v2 = <&dp_opp_table>;
> +				power-domains = <&rpmhpd RPMHPD_MMCX>;
> +
> +				status = "disabled";
> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@0 {
> +						reg = <0>;
> +
> +						mdss_dp0_in: endpoint {
> +							remote-endpoint = <&dpu_intf0_out>;
> +						};
> +					};
> +
> +					port@1 {
> +						reg = <1>;
> +
> +						mdss_dp0_out: endpoint {
> +							remote-endpoint = <&usb_dp_qmpphy_dp_in>;
> +						};
> +					};
> +				};
> +
> +				dp_opp_table: opp-table {
> +					compatible = "operating-points-v2";
> +
> +					opp-162000000 {
> +						opp-hz = /bits/ 64 <162000000>;
> +						required-opps = <&rpmhpd_opp_low_svs_d1>;
> +					};

> +
> +					opp-270000000 {
> +						opp-hz = /bits/ 64 <270000000>;
> +						required-opps = <&rpmhpd_opp_low_svs>;
> +					};
> +
> +					opp-540000000 {
> +						opp-hz = /bits/ 64 <540000000>;
> +						required-opps = <&rpmhpd_opp_svs_l1>;
> +					};
Weirdly enough the 540 rate isn't in the clock plan for the pclk
and so isn't 162

> +
> +					opp-810000000 {
> +						opp-hz = /bits/ 64 <810000000>;
> +						required-opps = <&rpmhpd_opp_nom>;
> +					};
> +				};
> +			};

[...]

> +				assigned-clocks = <&dispcc DISP_CC_MDSS_BYTE0_CLK_SRC>,
> +						  <&dispcc DISP_CC_MDSS_PCLK0_CLK_SRC>;
> +				assigned-clock-parents = <&mdss_dsi0_phy 0>,
> +							 <&mdss_dsi0_phy 1>;

Krzysztof recently introduced defines for these

Konrad

