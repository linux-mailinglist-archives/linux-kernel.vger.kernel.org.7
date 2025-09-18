Return-Path: <linux-kernel+bounces-788388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9ED8B383B2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86386462C3B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3B2352090;
	Wed, 27 Aug 2025 13:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TgrrppWR"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7BA28504D
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756301296; cv=none; b=thQndauP1WxmxkPTZREy1W6YWuKz7HmDOoRnzxkHR+nTxAPAxDS6BjEYVsLmAk8wWfGlhuIaBprqNULiaQAtDX2IMgtuloFZuYVBDvqWzSaJ+NIU9WurTCj7dWa2CWaMglQlp4fmr2rhpc87DMG69yy8i7qMwZNDkhnI7ncw59o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756301296; c=relaxed/simple;
	bh=NDCxKDQql+H+s4XkAlY00C8kLGs1OE0xl7zRLx5uJcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jzrmRA9dWx//bXeIlU3BGxruUXOy7KQfv8M+4x1vWQu6x11HYSUcKNLzZztywAakJt0DrMFZk9cX5pDKL1JzeDa+9m1IojL/zCOHNj/EGkJK+IyhNqtS29AhNsWO+jldngfHCa07w747+mE17BhpcY3CdZxtPBgJ1hj8oibFyRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TgrrppWR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57R6kQqd027576
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:28:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b6quTpF8lR620w9+wcbq204uyppZxMXlERbN+86W1g4=; b=TgrrppWRbNdt4yIr
	PXxE70i+ZxYtPJOJn0k7NJseMjEcTHHnvG4VFYfYb8MJhenupHgGqcItJRNqDHP2
	1B90YawHW2BEetJAEIF148Ws2qx3CllLpYFMhb/gcX+wGnosSSE0nhCecZgaTBZm
	ORCVOAac64Cw7hC6SHURHvTANJeSDiRDW4nyFZfhiVyPBi7ObQk+484eGD7vqWzW
	hMk74uVXrfAQ4z5HB0s1dWNVKv8Plp56NDz9Mp1ctEIlRKK9eS9/Fv6AjHoi45bQ
	m4pFkFIbxOK1nIruG9yDZAoI1rtuvcv2/u/B84xrNrDIYQxHVqY+cZr9FPqTS+6S
	iWQsTQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48se16usbg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:28:12 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24457f484d6so24858705ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 06:28:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756301292; x=1756906092;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b6quTpF8lR620w9+wcbq204uyppZxMXlERbN+86W1g4=;
        b=j124y+1YJDnyxN/m6V2P8aJlqExdxNc9UeYb7PZwD2DDSk9krbuPyXlUwyfpnD7HFU
         6fwHT7qsU/vL0z+jhUXJpAOk6zfCkVYNWUd/vkg8msfLNeSDurD/EfkBVJ6qst0i1PjX
         6WmZ/xUEtqsMOAX8VypOTnHn0GalOXPC/CDVsxliE8O1qkXg1zwAAmrq7DCac08swvZw
         uCU5Tt/2UmtjjBmZpOFFPWHKUJW3NRuxuY5J47loFeF0o7Ew0t7XMUsW+7t5drxd0hQ+
         cWNZORZv0TktdDl7dQMoJhpBgDjNmZDo/3CIrI0LZQDc5C2uXlx5a836rNdBobv6YJBs
         6XJQ==
X-Forwarded-Encrypted: i=1; AJvYcCW930+xEtHNUDrUiectqXQnq2LRxPzb5bmZiYjas2Xj4zeX8MjTG3gpSF5G8yWfnqcl3kgHtujTxVTRC/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMHGD1keVN96wBPdYID3iphZWYYh6qWA/Z3vKT3ORW9xHFQBkm
	twiRDAJEEhEarc+xgyDWnLdsLXAHvcWLPmrCoFjbdXQihWiKMGsQpQDBW1MBVbcOrbekRDKqbZw
	tv1PZpLeEJV9aE3EByC5jLe2gQVXNioL59FjXcNKK8V4AsN1Uw96/E6l3ttxTJ9GDnj4=
X-Gm-Gg: ASbGncvUVofyt15x2/WqPzvGQE8HOaEYXrYThM1MEwt5Q7/zIMBb+ip/RbZWnr371vp
	BK1O0rt1OVkecKF8FzLsgiSGD26fw8VxnnVylLV+IHyHyUJ//Z5l1KZ9UWzowRQDymGgr0oMeav
	4x0DMJscTQQgLSZZXrm3xLfIuzMizFObKwLr1UyM+KSU1mIDh38kIU3pmmrIuuCDK+4wQyCZ2qk
	3HmXMWbfhpQem17Su1sLGuF1hHAO5J5N+sL8Rk20FCZOzzK+2aNQ86e2ObwwdmlQSemd8njRsWV
	chs6hyL/hLSKNOA72TWsXOOAZtOwfh+U7132SzbJ8/Z4EKq/O1Uo/32CfquCwg6TRYFBZCREuwV
	HC0JZfnfbAa7mucnQ67ICcrnhB0E9VA==
X-Received: by 2002:a17:902:da8b:b0:246:b41d:252e with SMTP id d9443c01a7336-246b42c6bbamr98937395ad.2.1756301291557;
        Wed, 27 Aug 2025 06:28:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGA6gBgzbMmU5Z3ZUIL62xQWLNNWghkywPFsB5di/g623cSVN2BoKy0/7fsAZ0g2TCIv6pig==
X-Received: by 2002:a17:902:da8b:b0:246:b41d:252e with SMTP id d9443c01a7336-246b42c6bbamr98936845ad.2.1756301290930;
        Wed, 27 Aug 2025 06:28:10 -0700 (PDT)
Received: from [10.133.33.166] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-248a2677f81sm14018735ad.149.2025.08.27.06.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 06:28:10 -0700 (PDT)
Message-ID: <f3cc06c1-25d2-40f4-bd77-8a9c51b40efa@oss.qualcomm.com>
Date: Wed, 27 Aug 2025 21:28:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/14] phy: qcom: qmp-usbc: Move reset and regulator
 config into PHY cfg
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
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
        Konrad Dybcio <konradybcio@kernel.org>
References: <20250820-add-displayport-support-for-qcs615-platform-v3-0-a43bd25ec39c@oss.qualcomm.com>
 <20250820-add-displayport-support-for-qcs615-platform-v3-7-a43bd25ec39c@oss.qualcomm.com>
 <ofvzduf5xyip7w6yde2xwsrvv3tdh7ew3yyzeya2qzpqty3j7p@bnetyjowhdn5>
 <6f7c3962-ccfc-4400-a77f-399b06da93e1@oss.qualcomm.com>
 <llrt3xnd5gagovnmyzqebp2da5v67bkxjntfcgc5r5auamspyj@7v5taph3i3c4>
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <llrt3xnd5gagovnmyzqebp2da5v67bkxjntfcgc5r5auamspyj@7v5taph3i3c4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Rz3JzrK4OA-iUJp3Br6dPvB_3mhYryj_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDEyMCBTYWx0ZWRfX2pwuXZd4G3YY
 nBOFxgYOAn3modH+Frrc3XtEshFU+VcSBDRbUvrgAYVoDUbsV2BolKmY8RSUfJCGdMMqeKKHzuT
 +3UZcNPWOSyRx7DUk1E2O+329aQYQ0JQIua55wYcmQ29TAxF1A6pqgXH/I8TYc9hgB+fCo3jSwQ
 B1gcPtJaLUJ3Y1LfjYT+xKqXdBO7V9VhS6095lV+VHnavAcnYirO4Yct91FzgNQbQP3zdT9EZMh
 +YUHwcOubkwQbgfnDI6d/bKr/rgz3ZRjFJDAOHuoGEQFXT1O1NLviWEOiV6q35Tf4ilaoYmV19v
 W7Z1vBXd50JcBEIT7CYN6h5jjdqFaYcmrk1AgfPc+gaKk8A2aWk0wynGhugJjcUsexWMsjXxGEv
 yva7Zamw
X-Proofpoint-ORIG-GUID: Rz3JzrK4OA-iUJp3Br6dPvB_3mhYryj_
X-Authority-Analysis: v=2.4 cv=CNYqXQrD c=1 sm=1 tr=0 ts=68af07ec cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=snPlLZzmUMwuVAg1AH4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_03,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0 spamscore=0
 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508260120


On 8/22/2025 6:08 PM, Dmitry Baryshkov wrote:
> On Fri, Aug 22, 2025 at 04:29:28PM +0800, Xiangxu Yin wrote:
>> On 8/20/2025 7:30 PM, Dmitry Baryshkov wrote:
>>> On Wed, Aug 20, 2025 at 05:34:49PM +0800, Xiangxu Yin wrote:
>>>> Refactor reset and regulator configuration to be managed via qmp_phy_cfg
>>>> instead of hardcoded lists. This enables per-PHY customization and
>>>> simplifies initialization logic for USB-only and USB/DP switchable PHYs.
>>> Please split into two patches in order to simplify reviewing.
>>
>> Ok, will split reset and regulator part.
>>
>>
>>>> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>>>> ---
>>>>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 108 +++++++++++++++----------------
>>>>  1 file changed, 53 insertions(+), 55 deletions(-)
>>>>
>>>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
>>>> index 61128d606238321d1b573655b3b987226aa2d594..4e797b7e65da0e3a827efa9a179f1c150c1b8b00 100644
>>>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
>>>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
>>>> @@ -421,8 +421,9 @@ struct qmp_phy_cfg {
>>>>  	int (*configure_dp_phy)(struct qmp_usbc *qmp);
>>>>  	int (*calibrate_dp_phy)(struct qmp_usbc *qmp);
>>>>  
>>>> -	/* regulators to be requested */
>>>> -	const char * const *vreg_list;
>>>> +	const char * const *reset_list;
>>>> +	int num_resets;
>>>> +	const struct regulator_bulk_data *vreg_list;
>>>>  	int num_vregs;
>>>>  
>>>>  	/* array of registers with different offsets */
>>>> @@ -453,7 +454,6 @@ struct qmp_usbc {
>>>>  	struct clk_hw dp_pixel_hw;
>>>>  	struct clk_bulk_data *clks;
>>>>  	int num_clks;
>>>> -	int num_resets;
>>>>  	struct reset_control_bulk_data *resets;
>>>>  	struct regulator_bulk_data *vregs;
>>>>  
>>>> @@ -514,9 +514,18 @@ static const char * const usb3phy_reset_l[] = {
>>>>  	"phy_phy", "phy",
>>>>  };
>>>>  
>>>> -/* list of regulators */
>>>> -static const char * const qmp_phy_vreg_l[] = {
>>>> -	"vdda-phy", "vdda-pll",
>>>> +static const char * const usb3dpphy_reset_l[] = {
>>>> +	"phy_phy", "dp_phy",
>>>> +};
>>>> +
>>>> +static const struct regulator_bulk_data qmp_phy_usb_vreg_l[] = {
>>>> +	{ .supply = "vdda-phy" },
>>>> +	{ .supply = "vdda-pll" },
>>> Please fill in the values for all platforms. It well might be that they
>>> all share the same current requirements.
>>
>> I checked previous DP projects and found all platforms configured vdda-phy with 21.8mA and vdda-pll with 36mA.
> No. On SDM660 and MSM8998 DP defines 73.4 mA for 0.9V supply and
> 12.560 mA for 1.8 V supply.
>
>> However, I didn’t find USB load configs in downstream and from SoC related power grids:
> Please check the actual HW documentation for those platforms.
>
>> QCS615
>> L12A: VDDA_USB0_SS_1P8/VDDA_USB1_SS_1P8 Ipk:20ma
>> L5A: VDDA_USB0_SS_0P9/VDDA_USB1_SS_0P9 Ipk:50mA
>>
>> sm6150
>> L11A: VDDA_USB0_SS_1P8/VDDA_USB1_SS_1P8 Ipk:20ma
>> L4A: VDDA_USB0_SS_0P9/VDDA_USB1_SS_0P9 Ipk:50mA
>>
>> SM6115
>> L12A: VDDA_USB_SS_DP_1P8 Ipk:13.3mA
>> L4A: VDDA_USB_SS_DP_CORE Ipk:66.1mA
>>
>> QCM2290
>> L13A: VDDA_USB_SS_DP_1P8 Ipk:13.3mA
>> L12A: VDDA_USB_SS_DP_CORE Ipk:66.1mA
>>
>> sdm660
>> LDO10A: VDDA_USB_SS_1P8 Ipk:14mA
>> LDO1B: VDDA_USB_SS_CORE Ipk:68.6mA
>>
>> msm8998
>> L2A: VDDA_USB_SS_1P2 Ipk:14.2mA
>> L1A: VDDA_USB_SS_CORE Ipk:68.6mA
>>
>> It seems the USB power requirements vary across platforms, and the
>> 21800 µA load for vdda-phy exceeds the Ipk range in most cases.
> Ipk being ?


IPK: Instantaneous Peak Current


>> I also tested removing the load settings for USB+DP PHY, and DP still works fine.
> It mostly works either because we don't allow mode switching on older
> platforms (yet) or because somebody else has already voted and that vote
> keeps the required mode.
>
> As you've started looking on specifying proper current load, please
> finish the work.


Discussed with chip validation and power SW teams.

The power grid tables are primarily used to ensure each module receives 
the correct voltage, and they define the Ipk for each submodule. 

While they don’t specify recommended regulator load values, the Ipk values
reflect the expected power domain strength and can help estimate the voting
strength needed for each supply.

Since regulator load is mainly used for voting, I’ll define init_load_uA in
the next patch based on each SoC’s Ipk values to better align with hardware expectations.


>> So, can we keep the regulator config as original qmp_phy_vreg_l?
>> static const char * const qmp_phy_vreg_l[] = { "vdda-phy", "vdda-pll"} 
>>
>>
>>>> +};
>>>> +
>>>> +static const struct regulator_bulk_data qmp_phy_usbdp_vreg_l[] = {
>>>> +	{ .supply = "vdda-phy", .init_load_uA = 21800 },
>>>> +	{ .supply = "vdda-phy", .init_load_uA = 36000 },
>>> Typo
>>
>> Sorry for Typo, will fix in next patch.
>>
>>
>>>>  };
>>>>  
>>>>  static const struct qmp_usbc_offsets qmp_usbc_offsets_v3_qcm2290 = {
>>>> @@ -569,8 +578,10 @@ static const struct qmp_phy_cfg msm8998_usb3phy_cfg = {
>>>>  	.rx_tbl_num             = ARRAY_SIZE(msm8998_usb3_rx_tbl),
>>>>  	.pcs_tbl                = msm8998_usb3_pcs_tbl,
>>>>  	.pcs_tbl_num            = ARRAY_SIZE(msm8998_usb3_pcs_tbl),
>>>> -	.vreg_list              = qmp_phy_vreg_l,
>>>> -	.num_vregs              = ARRAY_SIZE(qmp_phy_vreg_l),
>>>> +	.reset_list		= usb3phy_reset_l,
>>>> +	.num_resets		= ARRAY_SIZE(usb3phy_reset_l),
>>>> +	.vreg_list              = qmp_phy_usb_vreg_l,
>>>> +	.num_vregs              = ARRAY_SIZE(qmp_phy_usb_vreg_l),
>>>>  	.regs                   = qmp_v3_usb3phy_regs_layout,
>>>>  };
>>>>  
>>>> @@ -586,8 +597,10 @@ static const struct qmp_phy_cfg qcm2290_usb3phy_cfg = {
>>>>  	.rx_tbl_num		= ARRAY_SIZE(qcm2290_usb3_rx_tbl),
>>>>  	.pcs_tbl		= qcm2290_usb3_pcs_tbl,
>>>>  	.pcs_tbl_num		= ARRAY_SIZE(qcm2290_usb3_pcs_tbl),
>>>> -	.vreg_list		= qmp_phy_vreg_l,
>>>> -	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
>>>> +	.reset_list		= usb3phy_reset_l,
>>>> +	.num_resets		= ARRAY_SIZE(usb3phy_reset_l),
>>>> +	.vreg_list		= qmp_phy_usb_vreg_l,
>>>> +	.num_vregs		= ARRAY_SIZE(qmp_phy_usb_vreg_l),
>>>>  	.regs			= qmp_v3_usb3phy_regs_layout_qcm2290,
>>>>  };
>>>>  
>>>> @@ -603,8 +616,10 @@ static const struct qmp_phy_cfg sdm660_usb3phy_cfg = {
>>>>  	.rx_tbl_num		= ARRAY_SIZE(sdm660_usb3_rx_tbl),
>>>>  	.pcs_tbl		= qcm2290_usb3_pcs_tbl,
>>>>  	.pcs_tbl_num		= ARRAY_SIZE(qcm2290_usb3_pcs_tbl),
>>>> -	.vreg_list		= qmp_phy_vreg_l,
>>>> -	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
>>>> +	.reset_list		= usb3phy_reset_l,
>>>> +	.num_resets		= ARRAY_SIZE(usb3phy_reset_l),
>>>> +	.vreg_list		= qmp_phy_usb_vreg_l,
>>>> +	.num_vregs		= ARRAY_SIZE(qmp_phy_usb_vreg_l),
>>>>  	.regs			= qmp_v3_usb3phy_regs_layout_qcm2290,
>>>>  };
>>>>  
>>>> @@ -637,6 +652,11 @@ static const struct qmp_phy_cfg qcs615_usb3dp_phy_cfg = {
>>>>  
>>>>  	.swing_tbl		= &qmp_dp_voltage_swing_hbr2_rbr,
>>>>  	.pre_emphasis_tbl	= &qmp_dp_pre_emphasis_hbr2_rbr,
>>>> +
>>>> +	.reset_list		= usb3dpphy_reset_l,
>>>> +	.num_resets		= ARRAY_SIZE(usb3dpphy_reset_l),
>>>> +	.vreg_list		= qmp_phy_usbdp_vreg_l,
>>>> +	.num_vregs		= ARRAY_SIZE(qmp_phy_usbdp_vreg_l),
>>>>  };
>>>>  
>>>>  static int qmp_usbc_com_init(struct phy *phy)
>>>> @@ -653,13 +673,13 @@ static int qmp_usbc_com_init(struct phy *phy)
>>>>  		return ret;
>>>>  	}
>>>>  
>>>> -	ret = reset_control_bulk_assert(qmp->num_resets, qmp->resets);
>>>> +	ret = reset_control_bulk_assert(cfg->num_resets, qmp->resets);
>>>>  	if (ret) {
>>>>  		dev_err(qmp->dev, "reset assert failed\n");
>>>>  		goto err_disable_regulators;
>>>>  	}
>>>>  
>>>> -	ret = reset_control_bulk_deassert(qmp->num_resets, qmp->resets);
>>>> +	ret = reset_control_bulk_deassert(cfg->num_resets, qmp->resets);
>>>>  	if (ret) {
>>>>  		dev_err(qmp->dev, "reset deassert failed\n");
>>>>  		goto err_disable_regulators;
>>>> @@ -682,7 +702,7 @@ static int qmp_usbc_com_init(struct phy *phy)
>>>>  	return 0;
>>>>  
>>>>  err_assert_reset:
>>>> -	reset_control_bulk_assert(qmp->num_resets, qmp->resets);
>>>> +	reset_control_bulk_assert(cfg->num_resets, qmp->resets);
>>>>  err_disable_regulators:
>>>>  	regulator_bulk_disable(cfg->num_vregs, qmp->vregs);
>>>>  
>>>> @@ -694,7 +714,7 @@ static int qmp_usbc_com_exit(struct phy *phy)
>>>>  	struct qmp_usbc *qmp = phy_get_drvdata(phy);
>>>>  	const struct qmp_phy_cfg *cfg = qmp->cfg;
>>>>  
>>>> -	reset_control_bulk_assert(qmp->num_resets, qmp->resets);
>>>> +	reset_control_bulk_assert(cfg->num_resets, qmp->resets);
>>>>  
>>>>  	clk_bulk_disable_unprepare(qmp->num_clks, qmp->clks);
>>>>  
>>>> @@ -921,42 +941,22 @@ static const struct dev_pm_ops qmp_usbc_pm_ops = {
>>>>  			   qmp_usbc_runtime_resume, NULL)
>>>>  };
>>>>  
>>>> -static int qmp_usbc_vreg_init(struct qmp_usbc *qmp)
>>>> +static int qmp_usbc_reset_init(struct qmp_usbc *qmp)
>>>>  {
>>>>  	const struct qmp_phy_cfg *cfg = qmp->cfg;
>>>> -	struct device *dev = qmp->dev;
>>>> -	int num = cfg->num_vregs;
>>>> -	int i;
>>>> -
>>>> -	qmp->vregs = devm_kcalloc(dev, num, sizeof(*qmp->vregs), GFP_KERNEL);
>>>> -	if (!qmp->vregs)
>>>> -		return -ENOMEM;
>>>> -
>>>> -	for (i = 0; i < num; i++)
>>>> -		qmp->vregs[i].supply = cfg->vreg_list[i];
>>>> -
>>>> -	return devm_regulator_bulk_get(dev, num, qmp->vregs);
>>>> -}
>>>> -
>>>> -static int qmp_usbc_reset_init(struct qmp_usbc *qmp,
>>>> -			      const char *const *reset_list,
>>>> -			      int num_resets)
>>>> -{
>>>>  	struct device *dev = qmp->dev;
>>>>  	int i;
>>>>  	int ret;
>>>>  
>>>> -	qmp->resets = devm_kcalloc(dev, num_resets,
>>>> +	qmp->resets = devm_kcalloc(dev, cfg->num_resets,
>>>>  				   sizeof(*qmp->resets), GFP_KERNEL);
>>>>  	if (!qmp->resets)
>>>>  		return -ENOMEM;
>>>>  
>>>> -	for (i = 0; i < num_resets; i++)
>>>> -		qmp->resets[i].id = reset_list[i];
>>>> +	for (i = 0; i < cfg->num_resets; i++)
>>>> +		qmp->resets[i].id = cfg->reset_list[i];
>>>>  
>>>> -	qmp->num_resets = num_resets;
>>>> -
>>>> -	ret = devm_reset_control_bulk_get_exclusive(dev, num_resets, qmp->resets);
>>>> +	ret = devm_reset_control_bulk_get_exclusive(dev, cfg->num_resets, qmp->resets);
>>>>  	if (ret)
>>>>  		return dev_err_probe(dev, ret, "failed to get resets\n");
>>>>  
>>>> @@ -1146,11 +1146,6 @@ static int qmp_usbc_parse_usb_dt_legacy(struct qmp_usbc *qmp, struct device_node
>>>>  
>>>>  	qmp->num_clks = ret;
>>>>  
>>>> -	ret = qmp_usbc_reset_init(qmp, usb3phy_legacy_reset_l,
>>>> -				 ARRAY_SIZE(usb3phy_legacy_reset_l));
>>>> -	if (ret)
>>>> -		return ret;
>>>> -
>>>>  	return 0;
>>>>  }
>>>>  
>>>> @@ -1187,14 +1182,9 @@ static int qmp_usbc_parse_usb_dt(struct qmp_usbc *qmp)
>>>>  	qmp->pipe_clk = devm_clk_get(dev, "pipe");
>>>>  	if (IS_ERR(qmp->pipe_clk)) {
>>>>  		return dev_err_probe(dev, PTR_ERR(qmp->pipe_clk),
>>>> -				     "failed to get pipe clock\n");
>>>> +					"failed to get pipe clock\n");
>>> unrelated
>>
>> Ack.
>>
>>
>>>>  	}
>>>>  
>>>> -	ret = qmp_usbc_reset_init(qmp, usb3phy_reset_l,
>>>> -				 ARRAY_SIZE(usb3phy_reset_l));
>>>> -	if (ret)
>>>> -		return ret;
>>>> -
>>>>  	return 0;
>>>>  }
>>>>  
>>>> @@ -1228,6 +1218,7 @@ static int qmp_usbc_probe(struct platform_device *pdev)
>>>>  	struct phy_provider *phy_provider;
>>>>  	struct device_node *np;
>>>>  	struct qmp_usbc *qmp;
>>>> +	const struct qmp_phy_cfg *cfg;
>>>>  	int ret;
>>>>  
>>>>  	qmp = devm_kzalloc(dev, sizeof(*qmp), GFP_KERNEL);
>>>> @@ -1239,13 +1230,20 @@ static int qmp_usbc_probe(struct platform_device *pdev)
>>>>  
>>>>  	qmp->orientation = TYPEC_ORIENTATION_NORMAL;
>>>>  
>>>> -	qmp->cfg = of_device_get_match_data(dev);
>>>> -	if (!qmp->cfg)
>>>> +	cfg = of_device_get_match_data(dev);
>>>> +	if (!cfg)
>>>>  		return -EINVAL;
>>>>  
>>>> +	qmp->cfg = cfg;
>>> Why? This doesn't seem related at all.
>>
>> I added the |cfg| variable to simplify access to |num_vregs| and |vreg_list| in the following lines, 
>>
>> avoiding repeated |qmp->cfg->...| usage. 
>>
>> If this is considered unrelated, I’ll remove it in the next version.
> This all gets clogged in a mixture of regulator and reset changes.
> Hopefully it will be more obvious with the patches being split.
>
>>
>>>> +
>>>>  	mutex_init(&qmp->phy_mutex);
>>>>  
>>>> -	ret = qmp_usbc_vreg_init(qmp);
>>>> +	ret = qmp_usbc_reset_init(qmp);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	ret = devm_regulator_bulk_get_const(qmp->dev, cfg->num_vregs,
>>>> +					 cfg->vreg_list, &qmp->vregs);
>>>>  	if (ret)
>>>>  		return ret;
>>>>  
>>>>
>>>> -- 
>>>> 2.34.1
>>>>

