Return-Path: <linux-kernel+bounces-852429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C7034BD8F7F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 14D944E911D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2F3308F31;
	Tue, 14 Oct 2025 11:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H9asrrT4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5452D2FD7DA
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760440667; cv=none; b=G4/2jPios4v4b2Zv29MwPSKAhEJkmv7yWO7/QrfEcC9nPWnlVFOh8P2Md40+Zf+Hj/IhbgytovvKPuZ5ZdobzJLqjBJph6gapLTg0FzMknd0hFtvOhbhuUxuyWGlGzkEYnDkgqNPD1Vccc0+LsnRpA7vl4nIygxd5eP21XxM/mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760440667; c=relaxed/simple;
	bh=bcWK4fTg7nmETJsA+UvAWm/nyqtvjq/XP7JTfGZhudw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uJUlh0AVUVvznignchNHwTrloPY4wHMcapQOll99GAsli62Tci3POH547z+WGCaLu7WrNunyaOQcgGm6gS7kMpUG6LBP6yCC9nujTv1+CDjAuJNoGtWHttDkBgX36HjdLyfx0fStU4P0oUGfWHThE9iqt16DXs12rGfalFQLWLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H9asrrT4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87HKJ018088
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:17:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nTY/sBKgAT5aIZEsNJ7UkmXTNK2/xLiJmfXa3OXwmRY=; b=H9asrrT4bziTSUTF
	V6VBtIcf7EuLi3O1jaqyR11GQleaKwyBfoy9BMBYgZWVlru2W8E5gsaIqKNjCcul
	zzyWUoxK0d8iakUfcA8ynHWAZXLz3gxTvD98F9/ucQXl/Z9ju644Yu5Wm8UyXbUz
	Zhp/ZjLX5M5x+Kj/TF1/KzAgIs6HSdWKn1w4TYVuK0nB9wencMJ3q3Vjfu9Oz7NT
	+HapQzwEfru9IrInZNZ7gFllqSXnU5KRQT06jN8uHzncNSHtnvpvFF5ms0UcwaKM
	ntTKAKHLm6D8Zl8vg5PtTDQ0fqEBASJ8kVBbBsWY6Od+hyhAhi5CEY5XMTcfHIQH
	kS5zuA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfes07s5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:17:45 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b62f869e558so624480a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:17:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760440664; x=1761045464;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nTY/sBKgAT5aIZEsNJ7UkmXTNK2/xLiJmfXa3OXwmRY=;
        b=DvJJTu0DsyzixhewzMRY0SV+ZDi7X0sGeowOqsFHR+c7sM806Ea/5LZ+9hucviTl54
         cbzkrPKtamt4dU7fflRComGPdqjZUCoLBLb3O4Srg/Va//wA5wT/3NiOviGGOMpkAO+f
         oBvbESusYopAHaWsLlSvsFzpZWgFrRQAjVUkoQ9VRq7zTg4L75PN4yOXestv6hNW/aL6
         OyZKUt5Vo2ibKzgr7b9wZitCMjfAtpZrEA3YLcX7RMH0Wn3bVtc/5Nwjo+tqltvidFmY
         hJRRuoHmxX1mPyiPzDs/bNAAd3wqGMo8cCJoHDb9DCYBrsJlfPkmLDoKH3cPzAkjuFOr
         WwIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrQE2TIgGW3L6eXAZTveweeRWAts7KipAnovqw2dcd0G5y3q8pRp4O7QHThKxRpAa7abREphix6sRCMXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHu7E37CFpqyirNijWNNbh8NFlMYB5fSmFSJuELUe18pmsWQtH
	vEJgo4mWBTGwfp7v3Seg9u3QjP92dP3n8gQy1wSERB6+YeeknQNUSVuPX3K5vY+Ks/pVayO+C02
	kxKy3RaTtLavs5CaA2WtRfQqdZ633TJ552dTMpFpqgLR4/1vJpWpJSFOvVpkjKUSt97g=
X-Gm-Gg: ASbGncvdVuX3Th/7Hb4RvasP05OkghNQAwjHJvwbTSDC2URawx5Ca7OFLK5a9QttC8/
	w/SSir1+V3q/WIgSDCyfTmL4C0rl0zLoiKp8HVDPo4QxCJQZvTDETJiyDabGUD26xVh13h7lHbC
	TRtN0FkmuogNJ4uHjjlwoQWr+4b9gvTW393t4gHJkXXJi0HTNNCyc7LLNk1DbV+yHpkxiuOw0zU
	2aVycn1MzL2Jq6BdZJGz8FgwJzpPO53eoLR5waxHG8Glz+FmzqIjGSsjwoBPEZkD+paOfE8CI3U
	Shag9hyOSTH81zpTT4oAYB8eVfoBaAmDqqulMJL2pBCLgnDf6LwsqtxhmwI4i6heGdrcXLnTVtm
	FnBh/F2SHb4wOeTyeVr59hX5Kh9l7TElKmTI=
X-Received: by 2002:a05:6a00:39aa:b0:781:1f5e:8bc4 with SMTP id d2e1a72fcca58-79387a281famr13224006b3a.6.1760440663708;
        Tue, 14 Oct 2025 04:17:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNqg1GAF0T4XgAhZMO0oLfa/blFZ3V9pL/XkmLQdf76VR8zUgzVCBYeKkV8ezLitvhxMOtCA==
X-Received: by 2002:a05:6a00:39aa:b0:781:1f5e:8bc4 with SMTP id d2e1a72fcca58-79387a281famr13223974b3a.6.1760440663219;
        Tue, 14 Oct 2025 04:17:43 -0700 (PDT)
Received: from [10.133.33.159] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b060c4esm14901588b3a.14.2025.10.14.04.17.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 04:17:42 -0700 (PDT)
Message-ID: <8e6720e9-6e9b-4530-b2b8-4e27a74665c5@oss.qualcomm.com>
Date: Tue, 14 Oct 2025 19:17:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: Add DisplayPort and QMP USB3DP
 PHY for SM6150
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com
References: <20251014-add-displayport-support-to-qcs615-devicetree-v2-0-1209df74d410@oss.qualcomm.com>
 <20251014-add-displayport-support-to-qcs615-devicetree-v2-2-1209df74d410@oss.qualcomm.com>
 <mij6av23fni6i4yb72xbjv3s2mil4eankjwt5n7jbafslvilem@qsk3644ilgcp>
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <mij6av23fni6i4yb72xbjv3s2mil4eankjwt5n7jbafslvilem@qsk3644ilgcp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=R64O2NRX c=1 sm=1 tr=0 ts=68ee3159 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=Y-oTvv0IyMzSHJg1AAYA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: lqvBqH1fEbo-y7gLd_LuuJDy02E5Ptri
X-Proofpoint-ORIG-GUID: lqvBqH1fEbo-y7gLd_LuuJDy02E5Ptri
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfXzhF9WBFLl5qo
 X6u/GOQyUkgT9ouHuNGKzvvQK+GTsVHkumpCOrHR8nXQHHDZIoQQJTcUw0vzYsVyMKJl1XCWlKA
 Uvbt901ed8wO0yQ34Y6CFwN70f3A7JWhFwJlpHzZezCWAE79RPF3n3BHRIprjrm/CfWZeTlA1T2
 PJ7Iwk1UFU//Cgnrs6dw7Klk5p5/aBH0aV2GmFAtUGM6rl/8k0WFCQul97v9/a9h7I6B5MIAbch
 eQQsBBh8Zti+GRvmZ5kBbsjr7S2IZu8hQIjiNIXuoggyUieUkOG7rWkpTRYSmtv/aRoZhmjW0s9
 VqOMPvfEEaZ9HXMH+D9bLy+MnB+cBVyk9bzZ4vZZ4yvF8mxrpwL+wnWjF6N7DmE19JabEe97rSe
 +2fiJdAk6HeF9Wb3OOogGGY0//fbFg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110018


On 10/14/2025 6:18 PM, Dmitry Baryshkov wrote:
> On Tue, Oct 14, 2025 at 05:42:11PM +0800, Xiangxu Yin via B4 Relay wrote:
>> From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>>
>> Introduce DisplayPort controller node and associated QMP USB3-DP PHY
>> for SM6150 SoC. Update clock and endpoint connections to enable DP
>> integration.
>>
>> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/sm6150.dtsi | 110 ++++++++++++++++++++++++++++++++++-
>>  1 file changed, 108 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm6150.dtsi b/arch/arm64/boot/dts/qcom/sm6150.dtsi
>> index 6128d8c48f9c0807ac488ddac3b2377678e8f8c3..cdf53d74c778c652080b0288278353e20c317379 100644
>> --- a/arch/arm64/boot/dts/qcom/sm6150.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm6150.dtsi
>> @@ -17,6 +17,7 @@
>>  #include <dt-bindings/power/qcom-rpmpd.h>
>>  #include <dt-bindings/power/qcom,rpmhpd.h>
>>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>> +#include <dt-bindings/phy/phy-qcom-qmp.h>
>>  
>>  / {
>>  	interrupt-parent = <&intc>;
>> @@ -3717,6 +3718,7 @@ port@0 {
>>  						reg = <0>;
>>  
>>  						dpu_intf0_out: endpoint {
>> +							remote-endpoint = <&mdss_dp0_in>;
>>  						};
>>  					};
>>  
>> @@ -3749,6 +3751,84 @@ opp-307200000 {
>>  				};
>>  			};
>>  
>> +			mdss_dp0: displayport-controller@ae90000 {
>> +				compatible = "qcom,sm6150-dp", "qcom,sm8150-dp", "qcom,sm8350-dp";
>> +
>> +				reg = <0x0 0x0ae90000 0x0 0x200>,
>> +				      <0x0 0x0ae90200 0x0 0x200>,
>> +				      <0x0 0x0ae90400 0x0 0x600>,
>> +				      <0x0 0x0ae90a00 0x0 0x600>,
>> +				      <0x0 0x0ae91000 0x0 0x600>;
>> +
>> +				interrupt-parent = <&mdss>;
>> +				interrupts = <12>;
>> +
>> +				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
>> +					 <&dispcc DISP_CC_MDSS_DP_AUX_CLK>,
>> +					 <&dispcc DISP_CC_MDSS_DP_LINK_CLK>,
>> +					 <&dispcc DISP_CC_MDSS_DP_LINK_INTF_CLK>,
>> +					 <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK>,
>> +					 <&dispcc DISP_CC_MDSS_DP_PIXEL1_CLK>;
>> +				clock-names = "core_iface",
>> +					      "core_aux",
>> +					      "ctrl_link",
>> +					      "ctrl_link_iface",
>> +					      "stream_pixel",
>> +					      "stream_1_pixel";
>> +
>> +				assigned-clocks = <&dispcc DISP_CC_MDSS_DP_LINK_CLK_SRC>,
>> +						  <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK_SRC>;
>> +				assigned-clock-parents = <&usb_qmpphy_2 QMP_USB43DP_DP_LINK_CLK>,
>> +							 <&usb_qmpphy_2 QMP_USB43DP_DP_VCO_DIV_CLK>;
> Missing PIXEL1_CLK_SRC assignment


Ok, will update in next patch.


>> +
>> +				phys = <&usb_qmpphy_2 QMP_USB43DP_DP_PHY>;
>> +				phy-names = "dp";
>> +
>> +				operating-points-v2 = <&dp_opp_table>;
>> +				power-domains = <&rpmhpd RPMHPD_CX>;
>> +
>> +				#sound-dai-cells = <0>;
>> +
>> +				status = "disabled";
>> +
>> +				ports {
>> +					#address-cells = <1>;
>> +					#size-cells = <0>;
>> +
>> +					port@0 {
>> +						reg = <0>;
>> +						mdss_dp0_in: endpoint {
>> +							remote-endpoint = <&dpu_intf0_out>;
>> +						};
>> +					};
>> +
>> +					port@1 {
>> +						reg = <1>;
>> +						mdss_dp0_out: endpoint {
> I thought that we need a data-lanes property somewhere here.


Ok, will update.


>> +						};
>> +					};
>> +				};
>> +

