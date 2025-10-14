Return-Path: <linux-kernel+bounces-852443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4B0BD8FF8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E58064F26AA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E283130C61B;
	Tue, 14 Oct 2025 11:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f6qqLXBl"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDA830BF69
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760441158; cv=none; b=kphsnkydbXg765ZBIYjCWXDbNekv1Vsh2AINpziZeQBlO1lBlcRl/IBJ5hd6pK8rzzmiZbVM5vxg9Lh1T1iZ5W71I1jGr7Eux2Z7ykBG0Ox8yzTc/u2wO1ol6pdkyN/UGMDx0mHf6c++LBDx8oYnE3O12PtB91BZ5er6XCpyCG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760441158; c=relaxed/simple;
	bh=j686w3OYPk5TRiSL4y3TUeaPyqS51Ap3zi6yDNE7Sl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NKA/LSC9SQyYuYEMCqghaGtNRcWGszR4xPs4uqO8ntjmv07+qodEYFO2nrnrWegOLr0N2kN2hXcxvkev9oRSUdNp722pL0/OMjT8aRhXwrVMuOeq1kHGLDFMCnI3yIzyQAefg+3GkpGJshj0dXtzZd1rxkrU4IUgRNsvpof1mpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f6qqLXBl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87KNE016311
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:25:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lB6sFQ3LeiBx00eAv9moG4oCFwLs4x2w8B2DPiD6Hkg=; b=f6qqLXBl9CpFDkBF
	RhNN9adguwXk6DD/nBJfQGSnXfPCr9mfRDJwKmkOhwBzumRbrjFW/5RE2K7PyivO
	dCCidrcSqjxY3vqARhVOCnUz6gX0E/O1L0NECosMXb7rcItIy3dBCoqzVZnsTY1x
	oDMNmidK7J2AsHzNUcwO7Dpx7hA8vRQM8LZ/NgmZKZeJ+xva3z5ZXOAFkeGxlXYg
	5aKCJcyu60uoIOxpkxW7wbWO3f/M53rdEcnNpqQU1HWiprzTtNXPoQ/vuwIwoih7
	h5dPeRLu3xC+u3ZUcO+7XsvFw49cRwhg4p/opOOzrl57jtWWn06MMe+3iBes2Fhr
	RAVNZg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfd90abd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:25:54 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32ed9e38bccso2157124a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:25:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760441154; x=1761045954;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lB6sFQ3LeiBx00eAv9moG4oCFwLs4x2w8B2DPiD6Hkg=;
        b=wS/X1hF3LZzh0B3vFyGUoWMeOW08AIAG9yJ1oV8AZFDQS/oW/p2ev5bFFuyd+3b+Qr
         5h2obYswO4VpwfJvzAu6TkCeZdCqxh9dyRAQ/uvqtbYS3eG8nwslDbUyKJjkL8zO/fK2
         2Pl7FeY84venjDkKgooFsbNGUU2YfTQ69Qg+2+IXIzgAgoA/0djPmAz44/akg9NjJLk/
         mygagPtsyrpoq1Xa21sz5VPAFRBeIqewAIMbIa5TVsHA0FNcMTmNC59MregdmOvtkXj8
         lu0V+DBP2jn0FdywYS3+/GJnPkB7E4JvevT6KpNu4FSN9sh8/XlO514xThisNF/4JJJd
         pRpg==
X-Forwarded-Encrypted: i=1; AJvYcCUiUdjt/qLkNYhLj69V+NjZPvlckoUl0Mhkz+ewa2TSixKeBgMYleKVd5UA6NRla/4LK6I6UC6Sr+gTIPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFY4t7XPJJUnvh3LHw//2NO2eSgvYmGOcn3MugRPo2jMUPYXFG
	RcBrP3pzBPk6yoS2BKRC0qoOqJBMJZu6Rj8URrgvl/4Lq3wnjiuRrl5ZWzipQBc0nZoGBeOh1fV
	sLyXkQEyojeGk4SPyL9SEZ8mQsYMS1IuCMT7Z0jmxWkI2sggoQAJwoJ1aDBBiQ+vH/Zg=
X-Gm-Gg: ASbGnctNHUkHwu/Ee9maOTvTRi7WuX/7/7N9Ni51VV790I5MMHnJjRvavSbXU1/QiBU
	oN96nraBwsd+lRycA7ve1LsP/yOSs9lTYcqwyqQyWjcaV3jwUE2IlZ/jVszrvw06hRibh2OeOlF
	c2U4TROKrCwv7Z50qR3+p3JTlc5cxjgiNPKVcj+S5oLBNvVqk+cGzDlgOEaWExjuNvRFm8SVKaI
	iElT2RtUeWR687EfcCBuMYaRl2wP8lbNobc+1HtRi3IIv/0IP04Tm7DeAuaA/hdooca/jGMLTzg
	p3Fz2I/+UGn53UDJ//91wbDk3gH4eZuUi/LAv6W9X55MKkqFbF9kwwUOqXHxrVf/n0+nQsYGCuN
	S90FgDl3HsX12QAmrTGz2R0dwpQhiyhIevl0=
X-Received: by 2002:a17:90b:388a:b0:332:3ffe:4be5 with SMTP id 98e67ed59e1d1-33b513ae791mr16920121a91.7.1760441153641;
        Tue, 14 Oct 2025 04:25:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlyXxDUchBxkJ8hKzcSdS8zUzwWZdwgzzM7euiuaBwsEcgugKDNWgcZSO4YiCAcVeXe1f/pg==
X-Received: by 2002:a17:90b:388a:b0:332:3ffe:4be5 with SMTP id 98e67ed59e1d1-33b513ae791mr16920082a91.7.1760441153080;
        Tue, 14 Oct 2025 04:25:53 -0700 (PDT)
Received: from [10.133.33.159] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b61b11ca9sm15658229a91.24.2025.10.14.04.25.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 04:25:52 -0700 (PDT)
Message-ID: <7277bc17-112b-4fc9-9099-243d216893d8@oss.qualcomm.com>
Date: Tue, 14 Oct 2025 19:25:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: Enable DisplayPort on QCS615
 Ride platform
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
 <20251014-add-displayport-support-to-qcs615-devicetree-v2-3-1209df74d410@oss.qualcomm.com>
 <kxwavurs7ebp5f22gxutvw4thwm24twqpahszhyxsodsikunja@7hl3y65ppqmo>
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <kxwavurs7ebp5f22gxutvw4thwm24twqpahszhyxsodsikunja@7hl3y65ppqmo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: it5wRZNfPyJDq7IoQjCTazcyEtoSLjSE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX+xIm6gCBxCfB
 ckzjw47StAJfyvgzxdtXoa/wWbIz1S55NgbFj0DIJWSP/2Y6ATIE00ghl3Ec4qyRKrsPbQFopsI
 Ag6lZ51ixTFfAIpmiIwJwqnYbf4hJKFPG1GXTxKh02BzXh6Xm518Jy/H8NDi+TP7sn0hExHTRbI
 HxFfrwgt7vpbFrvmjh7v75dXRboJyPU1EXugTUUObNoBWu3EKxUHwA+58FnwioMbkJt9otP6ijp
 ecq41A6DKNsspz4F0CMrDCPzkvLHAjLpYMGB3xaSUSAPeZpMgnzUC85St4NFcuOYjYTSmoYwUVr
 LXfuHd3hUBSQZd7cxMBxNu9kXuskCGeMbSoh15Wj3UouV18yUk6D7pbSYD9vFfMRP3et9v3RhIE
 zbcXhA4ODk8YeQ7zt4V5dR9tFXX4fA==
X-Proofpoint-GUID: it5wRZNfPyJDq7IoQjCTazcyEtoSLjSE
X-Authority-Analysis: v=2.4 cv=PdTyRyhd c=1 sm=1 tr=0 ts=68ee3342 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=lUa4T_ycwPSD0wKDvOsA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018


On 10/14/2025 6:21 PM, Dmitry Baryshkov wrote:
> On Tue, Oct 14, 2025 at 05:42:12PM +0800, Xiangxu Yin via B4 Relay wrote:
>> From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>>
>> Add DP connector node and configure MDSS DisplayPort controller for
>> QCS615 Ride platform. Include lane mapping and PHY supply settings
>> to support DP output.
>>
>> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/qcs615-ride.dts | 31 +++++++++++++++++++++++++++++++
>>  1 file changed, 31 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
>> index 9ac1dd3483b56f9d1652f8a38f62d759efa92b6a..0b8bcabdd90a0820b1f9c85e43b78e40eb8a9a38 100644
>> --- a/arch/arm64/boot/dts/qcom/qcs615-ride.dts
>> +++ b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
>> @@ -39,6 +39,20 @@ xo_board_clk: xo-board-clk {
>>  		};
>>  	};
>>  
>> +	dp0-connector {
>> +		compatible = "dp-connector";
>> +		label = "DP0";
>> +		type = "mini";
>> +
>> +		hpd-gpios = <&io_expander 8 GPIO_ACTIVE_HIGH>;
> Not the gpio102/ 103 / 104? Interesting.


Yes, on this platform the DP HPD signal is controlled by the pin controller
on the video-out sub-board, not by the TLMM on the SoC.


>> +
>> +		port {
>> +			dp0_connector_in: endpoint {
>> +				remote-endpoint = <&mdss_dp0_out>;
>> +			};
>> +		};
>> +	};
>> +
>>  	dp-dsi0-connector {
>>  		compatible = "dp-connector";
>>  		label = "DSI0";
>> @@ -423,6 +437,16 @@ &mdss {
>>  	status = "okay";
>>  };
>>  
>> +&mdss_dp0 {
>> +	status = "okay";
>> +};
>> +
>> +&mdss_dp0_out {
>> +	data-lanes = <3 2 0 1>;
> It's not a board peculiarity. All QCS615 / SM6150 devices are affected
> by this twist. Please move this to the SoC DT file.


Ok.


>> +	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000>;
>> +	remote-endpoint = <&dp0_connector_in>;
>> +};
>> +
>>  &mdss_dsi0 {
>>  	vdda-supply = <&vreg_l11a>;
>>  	status = "okay";
>> @@ -623,6 +647,13 @@ &usb_qmpphy {
>>  	status = "okay";
>>  };
>>  
>> +&usb_qmpphy_2 {
>> +	vdda-phy-supply = <&vreg_l5a>;
>> +	vdda-pll-supply = <&vreg_l12a>;
>> +
>> +	status = "okay";
>> +};
>> +
>>  &usb_1 {
>>  	status = "okay";
>>  };
>>
>> -- 
>> 2.34.1
>>
>>

