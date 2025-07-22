Return-Path: <linux-kernel+bounces-740171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C454B0D0EB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 06:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EB52540595
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 04:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B28828C2BD;
	Tue, 22 Jul 2025 04:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IFc8kYO+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB95A28B7D6
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 04:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753159239; cv=none; b=agIwRoU4+JFNJ9gI8LBBZqMST+E/fll9JQ4CLU2Ki0A89q+ahZGCQYhpJQls9TeegCfRUfTzKiS1tED/D4BXdEl2TvfjZLAtW8imGRI7WfxhfDmw+rive/NFUXiBE93loIQHFvJDeqndQWcrovIEBH31Qkj2hT2kSDyyA6CCFrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753159239; c=relaxed/simple;
	bh=DcWnCV5wiDFMtlUyE+DQhJbXPHzzcnoo0XyLl4KiE/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WLBQYmRud2bJKr+JS0cyWgDkBttwAP5f0ECo5KP2sAdzU5+T/hi3G2T3jHuczBOKulr0C8U9Kf0mtIk95Siqizt5tVJzW1VZdVfYw9CnMcxn5LTkyUr2h5d8Dwq6lm/LgRebeKjHu8HxPywFrRChBHr4LN4NazWDYcpqgl4g0ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IFc8kYO+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LIhEBZ017492
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 04:40:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QcTGOBXUA+STk52mHs0W4PauDtLBRWn0+OXc0q8RYuI=; b=IFc8kYO+nhkzRTcP
	awect8oHXP0U/GDih52NV7CPNIpPNbBkERPbpHB1s61G6FfD2ExRFdytmIh6Q71P
	cMXk28h6Mm4mg+miGb4f4OY9k6RPlw+0mS3zuEYivF5KbJ18HWuBIT5JwHpLw7dF
	07sR39aZLa6RpLhFkaVL+Nw8lYfuWR9BuA3gmlSWG9K4FC+BRHXDY9DMCvm1S580
	++eXtMmjupA7HPhNWcwPvN5ax9uHhudOpouwmbKubs0BI1AZKKYZhmHZPNQxoDiD
	CfTmQ0Vse1I2V/cL974KZXj1rIXm4ag9pKTDYpBJmCQmU9uzvlARyT+8JHLw+W4i
	hHMtQw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481t6w16wd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 04:40:36 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-75ab147e0a3so4194675b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 21:40:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753159235; x=1753764035;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QcTGOBXUA+STk52mHs0W4PauDtLBRWn0+OXc0q8RYuI=;
        b=OGuunuG6m1SUn/ATFY2eAaKGq6oWAfP4y/y3qvwtALXzzi2/3ct2v6nMvdUqWyocQF
         d27Jk5MVZGGVlWPcnhDBDmNLox17fdGguyEZ7gYZR/eWK0ie3YDfRJzd/Dmg5Dcus8hG
         3KX5ZyiNODmal2Seh8WMTZPUsB4iBfYdqAtACo4vR3FLk6ijzk2kqcG0mj9PgokuVHxV
         NzcD4fnIF7/qs1MLPdIU/G83i8IG5XXWkmXfVgv0UXccnGq+3fk5f+oCRk9Og5t0s1Kk
         EsmjS3WhlMJNkRl2/5sShORHj9FHcLXXuokp15MwgvGkv084PgCIi/qYbZPB2P2ZOUlv
         lcoA==
X-Forwarded-Encrypted: i=1; AJvYcCVtFSUFA1phmYF3RFnNuxSJfahJJLX7v6Xct99NFZFA88OmAtnzmJuVDWZPh2DK7sLUh87UUXOPxTumOIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfM9FMVNJkZmYj2izPREg+UFssQbWCyrQfQ+TdklYhS9fza1aE
	K51i1zenxgGmL2d1pKXJQ+mUaIjnL9cARoJv06HXqvsAvL673QSsVEdepi/jim7L5ANfvIX2ivX
	V4IgTVS6QB6jXvF5daD8ueQO8UGFWLVJuhvvKcxsH/5Vf4zWGXBQn8aYm8V96BKSM3rs=
X-Gm-Gg: ASbGncsBJQCUEyFMBm8gyxL9QuPkMuvI3XhR8aNrAgd8GLP4w6uaXB61MTFnHHBaKFy
	zVxAM0vgEy2lRtdysN1T5vI/jMf9R3Psj5Vm8syeEsFyup6l6IRa/e+ZKG81HzFummhvOchRDAq
	+DYKEAtRN67zPjL02Eb4sdizxFgU+LAhBX2K4auKFaW1MMXEqtypVgU4NKYVCUlyJrLuHGFmLxq
	yaC/A0QUXTphrebSwiJO2drOkt2P5x9gYVW6xofc7y+xUI8zDbI/O75Tbv9fNC2b/9eQ7cfCfUw
	u4Dh1u05cvADDfmia41J4wfzgzKyq3KWD8EZOxT8YFp3db1txFhwaSh5NSCQwNt+2smR0Zu0pTh
	/FKaBYglRbV5/7ePzxA==
X-Received: by 2002:a05:6a00:2189:b0:736:31cf:2590 with SMTP id d2e1a72fcca58-75724876a95mr27257789b3a.16.1753159235219;
        Mon, 21 Jul 2025 21:40:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1twrNaoE58MjndE1bdJRlSy7dI5BpM3+Jd8iUPOsl/CmInJrgSot5/C3EE7tyMWUpjbzqFw==
X-Received: by 2002:a05:6a00:2189:b0:736:31cf:2590 with SMTP id d2e1a72fcca58-75724876a95mr27257748b3a.16.1753159234693;
        Mon, 21 Jul 2025 21:40:34 -0700 (PDT)
Received: from [10.110.120.151] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c84e20b7sm6725618b3a.28.2025.07.21.21.40.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 21:40:34 -0700 (PDT)
Message-ID: <0b595166-d3b5-4b01-b8cd-ba9711c88f30@oss.qualcomm.com>
Date: Tue, 22 Jul 2025 12:40:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] arm64: dts: qcom: sa8775p: remove aux clock from
 pcie phy
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Johan Hovold <johan@kernel.org>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
        mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
        bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org,
        kishon@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org,
        kw@linux.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
        qiang.yu@oss.qualcomm.com, quic_krichai@quicinc.com,
        quic_vbadigan@quicinc.com
References: <20250718081718.390790-1-ziyue.zhang@oss.qualcomm.com>
 <20250718081718.390790-4-ziyue.zhang@oss.qualcomm.com>
 <aHobmsHTjyJVUtFj@hovoldconsulting.com>
 <86e14d55-8e96-4a2d-a9e8-a52f0de9dffd@oss.qualcomm.com>
Content-Language: en-US
From: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
In-Reply-To: <86e14d55-8e96-4a2d-a9e8-a52f0de9dffd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=SPpCVPvH c=1 sm=1 tr=0 ts=687f1644 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=_GfwqhGknvAR8v4wHWsA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDAzNSBTYWx0ZWRfX2YVSVWKWzKre
 PKl8p7amiokv3SCakZRKgGUnsFSi6tFhz4qPprZtZ6qO7elWDxVrMxJeYx+ubCL5uvfQzn80Nl1
 9cabDw6qn927+0cTpARLS+YK8wNzji2OK7pFrnFlQX9EroghCBSTO01MZTYjhwkQaZb3VcD4tFL
 8SflKd+fX3xhooWcMNYznpBqDNR5+TISQtKyWkpyruZPLdEWwqHyksM+VsQI7V7tAAvXtxHOLy7
 hZRSxF52Cq4d/7yjg+DN4TRpO8Xo6/5E8WyCw+Up75iGeY6Lj03QwpIQkJAxTp8umg1bqVz9erN
 XAQM/8dteSm3ZHl62YTL7UWYWd+3H2ZznX5RP+/0Amkh77TeaPxA9wVmtMQxYDBV7Ja2nKFBkxe
 fiCT19cjvJQVM2Bj5t75tn+VKRPJBU0eFaviYxgJ4vgqlF2X4tGFNAxzMBvnddis4DZij3uL
X-Proofpoint-ORIG-GUID: WnNLDapsvaV81N4MyR7ITbRT1rTYyOJ_
X-Proofpoint-GUID: WnNLDapsvaV81N4MyR7ITbRT1rTYyOJ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_05,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507220035


On 7/18/2025 6:53 PM, Konrad Dybcio wrote:
> On 7/18/25 12:02 PM, Johan Hovold wrote:
>> On Fri, Jul 18, 2025 at 04:17:17PM +0800, Ziyue Zhang wrote:
>>> gcc_aux_clk is used in PCIe RC and it is not required in pcie phy, in
>>> pcie phy it should be gcc_phy_aux_clk, so remove gcc_aux_clk and
>>> replace it with gcc_phy_aux_clk.
>> Expanding on why this is a correct change would be good since this does
>> not yet seem to have been fully resolved:
>>
>> 	https://lore.kernel.org/lkml/98088092-1987-41cc-ab70-c9a5d3fdbb41@oss.qualcomm.com/
> I dug out some deep memories and recalled that _PHY_AUX_CLK was
> necessary on x1e for the Gen4 PHY to initialize properly. This
> can be easily reproduced:
>
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> index a9a7bb676c6f..d5ef6bef2b23 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> @@ -3312,7 +3312,7 @@ pcie3_phy: phy@1be0000 {
>                          compatible = "qcom,x1e80100-qmp-gen4x8-pcie-phy";
>                          reg = <0 0x01be0000 0 0x10000>;
>   
> -                       clocks = <&gcc GCC_PCIE_3_PHY_AUX_CLK>,
> +                       clocks = <&gcc GCC_PCIE_3_AUX_CLK>,
>                                   <&gcc GCC_PCIE_3_CFG_AHB_CLK>,
>                                   <&tcsr TCSR_PCIE_8L_CLKREF_EN>,
>                                   <&gcc GCC_PCIE_3_PHY_RCHNG_CLK>,
>
> ==>
> [    6.967231] qcom-qmp-pcie-phy 1be0000.phy: phy initialization timed-out
> [    6.974462] phy phy-1be0000.phy.0: phy poweron failed --> -110
>
> And the (non-PHY_)AUX_CLK is necessary for at least one of them, as
> removing it causes a crash on boot
>
> Konrad

