Return-Path: <linux-kernel+bounces-877672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 083EFC1EB9A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6283618817F6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D37E336EC6;
	Thu, 30 Oct 2025 07:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aJmdIQy1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DdIOLyAT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C929E21883F
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761808883; cv=none; b=B8jC9qB7RIbjD+yfk/lhPSisfHgFXQhmPmvy9i1ULdOAxXWhLScVjt2cnVj2JxAlzRB4CYuPo0xgVkhb+63qJVeiIlAY44tFFw8kDg/xoESt0CdRUfrmcyQwto3TZBfLaRv1mUk0ZoI6ttm2xAf3tUaUQBKmeRZsIqOVIEYTBa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761808883; c=relaxed/simple;
	bh=3ukC6tbY/13+u4PbBz4Lf/+5E1gIoHSg+SZx7O+Z0U8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pXTHVzOoTNftEVPPWqdbPe8SvdVGgMNlt8+W1FxgQd7HK1AtFlgfi5ImydOH1OAzYdO4De6GBALVx6QrH60v0AK5PEwCoe/oD6OJYlNCPDDSClFaLtT6hik+6L1l5FKHala0uMOByE/WZvMABgbLlQxtWUz+UZWNmGZwS0TMeuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aJmdIQy1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DdIOLyAT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U2JwlZ4135755
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:21:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LrLH04bvWmhv/7dSuz9/jODN0MrjOzjLTOOh3RzYK98=; b=aJmdIQy1dzNp+YSO
	uYD5v7uBG6WccO2WyWuXmJygidw+st6zcZUCS7lIaBhlmZJpmOylw4iW5z7tzIQj
	CBaIaIFmECBjjXRoQLDWMk5s5RLgnz8ykhYfpF+El3Y33ArA1HM9BKRJQDrJlzg8
	Utf1dubsR4j27TTqKZRMdsjSU9OQpBCI2/hR9Hhwj3PsfUnCBk3PfEeOKWZiR7qG
	RhE9JMfGC5xei95FUIMhAjSAVkvwYXHdKtJtm1v6t1rUxO/+xxo0QgR//A2GwDB3
	/1UkAzswKyOkydIUPmcR2Yddv7v36LcZBzOJU4K+vB3kP8nvhREE+16xCZUtcZLV
	RkBlyQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3ff9uqne-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:21:20 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-33da21859c9so183869a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 00:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761808880; x=1762413680; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LrLH04bvWmhv/7dSuz9/jODN0MrjOzjLTOOh3RzYK98=;
        b=DdIOLyATS1Q2EdId0TVXEA4WVP0DCm/CWnOBu0Fbc884jB8RuzDUi5qm+MzVzwzMYJ
         66n0NWC19sDNNaJ6Os2qbaAg4dnMBt3RDWAxW33Q1agRJVmJHzfr2IYRfejsuEeOrJpv
         J4/8ZgtYgWKywoo1irSW5XdWzlLMUOCtMwU0fZOF8IfWPJqpPnrOx9o90FL/c+/L2alk
         R0DmfRcVSd2TgDyH9PtcWef7phJWFGlm62PGmrbfXVAPqAd8sNbH0UHK3T4NxKcZ/qGE
         O0vPgEmLImo8muq5V8FS1eBWv0zI4k6BLN8R12pH3ROnctNe+btgK8bm9Mh/Mgc9TiRx
         diwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761808880; x=1762413680;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LrLH04bvWmhv/7dSuz9/jODN0MrjOzjLTOOh3RzYK98=;
        b=Y+4h1wCTVuf43MBnz1lAh/ugihuZ4RTKipOswRcJpiKPGYGMr8tmuBC3fPQKSO/5nY
         jYPWOMookm8XVBHQRYiLHYlaYzH5XkU8saD/oSR8m3tkbGZOdwYMhxWARzyVH5I5PhQn
         UO311nU7JuffkxjAPu2VPFQnhYHY9KsRrG3VdUjylq2rBd8fu67+//HxeFeZkjxiiaPD
         4JKN6nwS6W7G212ULqyO8aTnaHrfQKm4plR5z3TQlMaHaAVND5u+KV50T19BCKNPDc3J
         iX2ZP1UWwTjd5wd/qpYhsZbiTij1uThFx1b9ZweRExQC5o5ov4R4+DkfiSuEIrUxBubr
         VLTg==
X-Forwarded-Encrypted: i=1; AJvYcCX3jCojRxiki5GtNl9VPHxIcHsJnftS1XzJcYzAHLfSfiU9Vz5eol+Kx85hPNeHBW+hSwK16gbLCG6HglE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFm6CHko9Cr3szkqvi2wIfZmmRZ3h/ZvflLJpgC9PgrN6T8bIc
	5oiiPe219w2pLcOGSolIiDZrF2xsIGiopVEUeWwHtDuAZVbWO1ilfXyl5eViwSzewFDtMXR6Obr
	Q3G1s35MyHxC7twR8JJGPvgydI6Go4Ie1tvoyMXA48L3LxnSzDMHwrA+mv5DN0X58Ioo=
X-Gm-Gg: ASbGncv0IIMYIPjN6htEI/6SSqK/LTR8LnUhQSA0sd+HPRa7j5I9QRzJ2EgUUproNfX
	A1sbek8ONeDhyEDYrEOClJ+3fI6RXqW3KYg7vU6+bbq0AawYqD/MjRLCyt1WRCjuRWYtA154kdY
	khXnL8r0DQAuMt6raXFCrGc5wAJ022BUxh+CiVbwM8DRfEwPOt/C0U7pISfW1m2Wyk/NL2X9wae
	JdrFlzt2ixoI2lIEYikU1IvBycLmyEkTY/0jbcR+yorpT6syogHT/DrNYnOShg84RoA6fAot1UT
	/ulncQU2om9wd+bbGNgAqmd/H/X0VtB20jK6POSAxWAVgCRv4pEhvj8Ue8p3nem6dnpk9e5Lw03
	oAkY/J8Tl3DcLSJZe1O9hxf1NinAhi9yetsbEB5VLDkL9TNg8IwaVfpsf9oxteh9f/ycoag==
X-Received: by 2002:a05:6a21:4d8c:b0:341:fcbf:90b9 with SMTP id adf61e73a8af0-34653c0cc95mr3991171637.4.1761808880203;
        Thu, 30 Oct 2025 00:21:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzZrHhcc1HTqPJ7CvrAphUHOthYYbudWGXcSpWUVourKLOVpK1kqUouzpCpiUJ1uwL+BHxGw==
X-Received: by 2002:a05:6a21:4d8c:b0:341:fcbf:90b9 with SMTP id adf61e73a8af0-34653c0cc95mr3991136637.4.1761808879701;
        Thu, 30 Oct 2025 00:21:19 -0700 (PDT)
Received: from [10.133.33.251] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b8c0d2364d5sm3941558a12.19.2025.10.30.00.21.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 00:21:19 -0700 (PDT)
Message-ID: <da6eebe0-13ec-4168-aac1-2eef9db3bd13@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 15:21:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] arm64: dts: qcom: Add DisplayPort and QMP USB3DP
 PHY for SM6150
To: Bjorn Andersson <andersson@kernel.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20251024-add-displayport-support-to-qcs615-devicetree-v6-0-c4316975dd0e@oss.qualcomm.com>
 <20251024-add-displayport-support-to-qcs615-devicetree-v6-3-c4316975dd0e@oss.qualcomm.com>
 <xjes5h45y44cahs7avj4xngprwnks3alnf25tsbptyvckajz3q@lhawlg5vamls>
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <xjes5h45y44cahs7avj4xngprwnks3alnf25tsbptyvckajz3q@lhawlg5vamls>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 30GskWbonjkjmdG7CebRPDzuFrZaJPoe
X-Proofpoint-GUID: 30GskWbonjkjmdG7CebRPDzuFrZaJPoe
X-Authority-Analysis: v=2.4 cv=Cf4FJbrl c=1 sm=1 tr=0 ts=690311f1 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=tU0UsG_G8rlFAKuj474A:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA1OCBTYWx0ZWRfXxnuR1QdbOeKn
 cgJSmOJra6m4QjOEhMHh78B5dQfkf3/TJHEpXKfTdht9AyLRxtUJ5PI+50v07mGmrmwyWmshYvP
 aw4/hFdRrpbT8GycdSfh2S8Hzd8Zaqao2wflGsR3T3ObGb1NC6HFw6/MO4+VDVgL5Dq1dHD0xey
 rOwHHbUSdMDzSayP+Smp2UhpJx0TUSmqfIJFD4hf/j8azsmNi40lLwCohz9Ii9s/Q6U2VUV5pfS
 NHC/p+Yd9hb4gwXPBCoWXbAFGUK96qI7P+ao+1eZtUgCl1kKmNjchfBNQgel/5X1qmH5N/5RQHi
 qoMoL0muIfvw1lzPMft5T8e/U5dFoUXiuPcPzKoZ+W51drIn6lLBt7JBg07LVOwBvfB6JRvRttH
 Yjwy3MtAIYpTyMhod3ntFcouJ3ZvbQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300058


On 10/30/2025 1:32 AM, Bjorn Andersson wrote:
> On Fri, Oct 24, 2025 at 01:21:03PM +0800, Xiangxu Yin via B4 Relay wrote:
>> From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>>
> Please fix the subject prefix and drop the "for SM6150" suffix.
>
> Regards,
> Bjorn


Ok, due to sm6150.dtsi have renamed to talos.dtsi in newest version.

Will update to 'arm64: dts: qcom: talos: Add DisplayPort and QMP USB3DP PHY'


>> Introduce DisplayPort controller node and associated QMP USB3-DP PHY
>> for SM6150 SoC. Add data-lanes property to the DP endpoint and update
>> clock assignments for proper DP integration.
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/sm6150.dtsi | 115 ++++++++++++++++++++++++++++++++++-
>>  1 file changed, 113 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm6150.dtsi b/arch/arm64/boot/dts/qcom/sm6150.dtsi
>> index 6128d8c48f9c0807ac488ddac3b2377678e8f8c3..9741f8d14c72ed7dd6a5e483c5c0d578662f1d31 100644
>> --- a/arch/arm64/boot/dts/qcom/sm6150.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm6150.dtsi
>> @@ -14,6 +14,7 @@
>>  #include <dt-bindings/interconnect/qcom,icc.h>
>>  #include <dt-bindings/interconnect/qcom,qcs615-rpmh.h>
>>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/phy/phy-qcom-qmp.h>
>>  #include <dt-bindings/power/qcom-rpmpd.h>
>>  #include <dt-bindings/power/qcom,rpmhpd.h>
>>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>> @@ -3717,6 +3718,7 @@ port@0 {
>>  						reg = <0>;
>>  
>>  						dpu_intf0_out: endpoint {
>> +							remote-endpoint = <&mdss_dp0_in>;
>>  						};
>>  					};
>>  
>> @@ -3749,6 +3751,89 @@ opp-307200000 {
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
>> +						  <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK_SRC>,
>> +						  <&dispcc DISP_CC_MDSS_DP_PIXEL1_CLK_SRC>;
>> +				assigned-clock-parents = <&usb_qmpphy_2 QMP_USB43DP_DP_LINK_CLK>,
>> +							 <&usb_qmpphy_2 QMP_USB43DP_DP_VCO_DIV_CLK>,
>> +							 <&usb_qmpphy_2 QMP_USB43DP_DP_VCO_DIV_CLK>;
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
>> +
>> +						mdss_dp0_in: endpoint {
>> +							remote-endpoint = <&dpu_intf0_out>;
>> +						};
>> +					};
>> +
>> +					port@1 {
>> +						reg = <1>;
>> +
>> +						mdss_dp0_out: endpoint {
>> +							data-lanes = <3 2 0 1>;
>> +						};
>> +					};
>> +				};
>> +
>> +				dp_opp_table: opp-table {
>> +					compatible = "operating-points-v2";
>> +
>> +					opp-160000000 {
>> +						opp-hz = /bits/ 64 <160000000>;
>> +						required-opps = <&rpmhpd_opp_low_svs>;
>> +					};
>> +
>> +					opp-270000000 {
>> +						opp-hz = /bits/ 64 <270000000>;
>> +						required-opps = <&rpmhpd_opp_svs>;
>> +					};
>> +
>> +					opp-540000000 {
>> +						opp-hz = /bits/ 64 <540000000>;
>> +						required-opps = <&rpmhpd_opp_svs_l1>;
>> +					};
>> +				};
>> +			};
>> +
>>  			mdss_dsi0: dsi@ae94000 {
>>  				compatible = "qcom,sm6150-dsi-ctrl", "qcom,mdss-dsi-ctrl";
>>  				reg = <0x0 0x0ae94000 0x0 0x400>;
>> @@ -3844,8 +3929,8 @@ dispcc: clock-controller@af00000 {
>>  				 <&mdss_dsi0_phy DSI_BYTE_PLL_CLK>,
>>  				 <&mdss_dsi0_phy DSI_PIXEL_PLL_CLK>,
>>  				 <0>,
>> -				 <0>,
>> -				 <0>;
>> +				 <&usb_qmpphy_2 QMP_USB43DP_DP_LINK_CLK>,
>> +				 <&usb_qmpphy_2 QMP_USB43DP_DP_VCO_DIV_CLK>;
>>  
>>  			#clock-cells = <1>;
>>  			#reset-cells = <1>;
>> @@ -4214,6 +4299,32 @@ usb_qmpphy: phy@88e6000 {
>>  			status = "disabled";
>>  		};
>>  
>> +		usb_qmpphy_2: phy@88e8000 {
>> +			compatible = "qcom,qcs615-qmp-usb3-dp-phy";
>> +			reg = <0x0 0x088e8000 0x0 0x2000>;
>> +
>> +			clocks = <&gcc GCC_USB2_SEC_PHY_AUX_CLK>,
>> +				 <&gcc GCC_USB3_SEC_CLKREF_CLK>,
>> +				 <&gcc GCC_AHB2PHY_WEST_CLK>,
>> +				 <&gcc GCC_USB2_SEC_PHY_PIPE_CLK>;
>> +			clock-names = "aux",
>> +				      "ref",
>> +				      "cfg_ahb",
>> +				      "pipe";
>> +
>> +			resets = <&gcc GCC_USB3PHY_PHY_SEC_BCR >,
>> +				 <&gcc GCC_USB3_DP_PHY_SEC_BCR>;
>> +			reset-names = "phy_phy",
>> +				      "dp_phy";
>> +
>> +			#clock-cells = <1>;
>> +			#phy-cells = <1>;
>> +
>> +			qcom,tcsr-reg = <&tcsr 0xbff0 0xb24c>;
>> +
>> +			status = "disabled";
>> +		};
>> +
>>  		usb_1: usb@a6f8800 {
>>  			compatible = "qcom,qcs615-dwc3", "qcom,dwc3";
>>  			reg = <0x0 0x0a6f8800 0x0 0x400>;
>>
>> -- 
>> 2.34.1
>>
>>

