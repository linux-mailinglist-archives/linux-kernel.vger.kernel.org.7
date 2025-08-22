Return-Path: <linux-kernel+bounces-781384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72485B311DB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EEA61892839
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 08:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7002F34CF9;
	Fri, 22 Aug 2025 08:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AxqMHrST"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015802E9EA4
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 08:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755851383; cv=none; b=faNVYLpwDdTLL5wyzi/4xrTwqVM6DgVZxPVz2VrRD5DJz+AItIjOc8V8oErp1DU8ZHVHI3kicnYEgQfvy3fQ1HdDSQYnCKfaQKjmNta0yLxUHAKULwaHmm+AaIfzPvXD00wXk//S+ESTCWgqJJvGxeMZ69UJeNMPKopzG9SGhks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755851383; c=relaxed/simple;
	bh=eIGAVOG5UYxMgF69AVIsJE82unZ2cb331FgNJNUNtRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KOCyetioJUEEQiGAGcse6xJZRQ84uxffHVSFhDhtTAe4Z5KWY2BSiXMe5WApu4Yprump3U6J3/sFz+9AIMguFjQXUNB/rd7G0n8pp60gUOujJWRFvkrwgoqqdfbjRNrT9KGla0e6FJBX0d4ge5L3X58Skx7g/oCowb9RUgTJKas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AxqMHrST; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M6uTSe027779
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 08:29:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oSsDA9Wis3g7ZHaqsLK1duB5UsS6ah4PJUuVmp/O+e4=; b=AxqMHrST9IWjYEoP
	fN++E9sY1jxjQ9liy2e/OKWul6NkClxhHLI//FgfJxhpReMOEI6zQCgzWNV/pH5v
	nza9XqKygXKL+tkyO2h+6FmC55IFeWeUPrnihtiG7erRKNg9Dxedqcaz1mPNZJTB
	CJ1aoiWxHrZCHPHDAuhJbfaHoFOMHXuj0AGUzZLY18e+yKP5OUEeppRbUXBBkM+X
	DeEJkOMxrLHlUqR3jk6jzS8GPDOJhJ+H6VBHF5a7rc4rct30AxsFpk2J0e0bV+ns
	Sp9bg77tK0U9E8+Z7VaESBM4mx1RLdS3RZK3WhUNX+ZEPAwqIx1hHddvI99BrsfZ
	wKlUdw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52crg6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 08:29:40 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b49c7295627so34992a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 01:29:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755851379; x=1756456179;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oSsDA9Wis3g7ZHaqsLK1duB5UsS6ah4PJUuVmp/O+e4=;
        b=l+gu+Vm1DwfJ11aglqToojsIuxq6sQyet/viAs2VYo0IgaYyL88CNuq5yoVpl36wPu
         B+agr5JxTDOd4QM0dzVsv3zTs7Zma0Yu6+fERKxnJZH7w/hKRpARCpXTSgYlthCvH5/4
         buiHYT9avNmq9lSs3vkuuNErhEx8UxsUK6uXvFw/B2cpv5pJVvI0RdJIe+NHlA9EHYsm
         G2yKADaNl/NIizQAYwHJxz4rnscqdMD/Otsi9qgZm4w5a1UTY6mUiv/zh6mM9ldfB3Uz
         9ELcQg1BCfVFgq0wxAD9XeWy4suvWqFpo8yKJC0lQpqIVAB4mGMfEcrr+ZLZo54z6WMW
         IKCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTjX0S3CclEfeW0tR2r1hAd9r6Ia+SX2nA33kVBZIUH2a0XAxxqjua1F6g6ixIb6waO6tNlT8h/8+jgO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyYDGaStfhZ//YgF8IDqvYsE4mXeE1SgtGADUJsF0S7SWbqhEi
	9ZtK+KZJPF7IBLrYNKfemlTnlp6/fhsIw6uDMyheiRNeVAn9tViRLbvFOUYvf+CI26t8R/8DHfS
	yABMEm8IucSFI3w9GRSVdnGRk81c5UYAYKegmL0ea0BHXY/WM1GPFqrBDmzpgghrIct4=
X-Gm-Gg: ASbGncsIqYp3nKCG1I6rGsvGdHyxVS8sqXv/GF4s46b1EeOCVjh0WYirKb3VZ8w+hzH
	rqP6Fz+Lsv9ptlxE5231Wdf+Fl7Xdz/szqWDKXNjnx2RIDRNs09o/b7WoNaIHPrlSJISfHFaX6q
	p3d8KgJpYUvUIFNM7ASmqfdfnZe6mtCFkj8LXvms/lhgB2Skz//NdxsyKpRZYjwWbqgG59TyIGH
	GPiEPSwgYGQpyzPixDOeHDO/NsWxi5W+wo/SdDWI1Ghm3Ja0nhK/g2tttWhI78AHLlWN/00dwxZ
	p5Sbsm6uNFtoYoj3bp9x6SPMbBBivkVuFgFeUHnxTWtGjnAgBd0Vq5CLjPu6mxbdL63NWOgjCyq
	eBPbo/gBlwOeNBh4dYIRCh2ysSn1pyA==
X-Received: by 2002:a05:6a00:190e:b0:742:94fe:c844 with SMTP id d2e1a72fcca58-7702fc0c607mr1534969b3a.4.1755851379212;
        Fri, 22 Aug 2025 01:29:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECS6ht/YMt4fQ0cJ1W+rfpGn2MBw0jytRNBtzImRzLr3L0zMRCdBklcsnccWVDS9F20MVWHA==
X-Received: by 2002:a05:6a00:190e:b0:742:94fe:c844 with SMTP id d2e1a72fcca58-7702fc0c607mr1534945b3a.4.1755851378646;
        Fri, 22 Aug 2025 01:29:38 -0700 (PDT)
Received: from [10.133.33.119] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d0d3a61sm10220483b3a.16.2025.08.22.01.29.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 01:29:38 -0700 (PDT)
Message-ID: <6f7c3962-ccfc-4400-a77f-399b06da93e1@oss.qualcomm.com>
Date: Fri, 22 Aug 2025 16:29:28 +0800
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
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <ofvzduf5xyip7w6yde2xwsrvv3tdh7ew3yyzeya2qzpqty3j7p@bnetyjowhdn5>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: t8FolnwFj9hq8MZoX-siSoxmdEj2Ms5f
X-Proofpoint-ORIG-GUID: t8FolnwFj9hq8MZoX-siSoxmdEj2Ms5f
X-Authority-Analysis: v=2.4 cv=Xpij+VF9 c=1 sm=1 tr=0 ts=68a82a74 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=MEhiHkCBgsXSh6r2bIQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX3KnlYDZUvnAn
 Lstwh5r3Xtfr5LkzMZZywreJu/GDQMT10AuEl12mHQWoP+W8Y3WWtuUIYllrm2W3BuwKtz9rn8m
 Fo1K6Zv8YF2FHiY5K5HtRz6i31Qfx+Zhk3ql8pKqryuan4gf4fVXO9LoAIKNrWfwdGubklPSMue
 mW8cXfmV+LMjd8qX78f4JNMXyfI3vL/3EB9kAnHQqctyuzv5mVYUU8t6r2jSgyaUOmDZ1gCEmnO
 d820T0Ltg/JIxDhSs5kg0J+0M42zlffWdB8t8Jbtjd1jkfXeGmVI4EyNOftW/0tLVenir0YYvgA
 R23m3AgKyHkY0nXI+f3mJS+CGDWUMHcPyhsgsBVGIAISH6UwanK3pBAEHQI23lzcipzHYgg80WH
 JmwNHYcfFNTwvHAtLeh5l7sHzDSOEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0
 adultscore=0 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013


On 8/20/2025 7:30 PM, Dmitry Baryshkov wrote:
> On Wed, Aug 20, 2025 at 05:34:49PM +0800, Xiangxu Yin wrote:
>> Refactor reset and regulator configuration to be managed via qmp_phy_cfg
>> instead of hardcoded lists. This enables per-PHY customization and
>> simplifies initialization logic for USB-only and USB/DP switchable PHYs.
> Please split into two patches in order to simplify reviewing.


Ok, will split reset and regulator part.


>> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>> ---
>>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 108 +++++++++++++++----------------
>>  1 file changed, 53 insertions(+), 55 deletions(-)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
>> index 61128d606238321d1b573655b3b987226aa2d594..4e797b7e65da0e3a827efa9a179f1c150c1b8b00 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
>> @@ -421,8 +421,9 @@ struct qmp_phy_cfg {
>>  	int (*configure_dp_phy)(struct qmp_usbc *qmp);
>>  	int (*calibrate_dp_phy)(struct qmp_usbc *qmp);
>>  
>> -	/* regulators to be requested */
>> -	const char * const *vreg_list;
>> +	const char * const *reset_list;
>> +	int num_resets;
>> +	const struct regulator_bulk_data *vreg_list;
>>  	int num_vregs;
>>  
>>  	/* array of registers with different offsets */
>> @@ -453,7 +454,6 @@ struct qmp_usbc {
>>  	struct clk_hw dp_pixel_hw;
>>  	struct clk_bulk_data *clks;
>>  	int num_clks;
>> -	int num_resets;
>>  	struct reset_control_bulk_data *resets;
>>  	struct regulator_bulk_data *vregs;
>>  
>> @@ -514,9 +514,18 @@ static const char * const usb3phy_reset_l[] = {
>>  	"phy_phy", "phy",
>>  };
>>  
>> -/* list of regulators */
>> -static const char * const qmp_phy_vreg_l[] = {
>> -	"vdda-phy", "vdda-pll",
>> +static const char * const usb3dpphy_reset_l[] = {
>> +	"phy_phy", "dp_phy",
>> +};
>> +
>> +static const struct regulator_bulk_data qmp_phy_usb_vreg_l[] = {
>> +	{ .supply = "vdda-phy" },
>> +	{ .supply = "vdda-pll" },
> Please fill in the values for all platforms. It well might be that they
> all share the same current requirements.


I checked previous DP projects and found all platforms configured vdda-phy with 21.8mA and vdda-pll with 36mA.

However, I didn’t find USB load configs in downstream and from SoC related power grids:
QCS615
L12A: VDDA_USB0_SS_1P8/VDDA_USB1_SS_1P8 Ipk:20ma
L5A: VDDA_USB0_SS_0P9/VDDA_USB1_SS_0P9 Ipk:50mA

sm6150
L11A: VDDA_USB0_SS_1P8/VDDA_USB1_SS_1P8 Ipk:20ma
L4A: VDDA_USB0_SS_0P9/VDDA_USB1_SS_0P9 Ipk:50mA

SM6115
L12A: VDDA_USB_SS_DP_1P8 Ipk:13.3mA
L4A: VDDA_USB_SS_DP_CORE Ipk:66.1mA

QCM2290
L13A: VDDA_USB_SS_DP_1P8 Ipk:13.3mA
L12A: VDDA_USB_SS_DP_CORE Ipk:66.1mA

sdm660
LDO10A: VDDA_USB_SS_1P8 Ipk:14mA
LDO1B: VDDA_USB_SS_CORE Ipk:68.6mA

msm8998
L2A: VDDA_USB_SS_1P2 Ipk:14.2mA
L1A: VDDA_USB_SS_CORE Ipk:68.6mA

It seems the USB power requirements vary across platforms, and the 21800 µA load for vdda-phy exceeds the Ipk range in most cases.
I also tested removing the load settings for USB+DP PHY, and DP still works fine.
So, can we keep the regulator config as original qmp_phy_vreg_l?
static const char * const qmp_phy_vreg_l[] = { "vdda-phy", "vdda-pll"} 


>> +};
>> +
>> +static const struct regulator_bulk_data qmp_phy_usbdp_vreg_l[] = {
>> +	{ .supply = "vdda-phy", .init_load_uA = 21800 },
>> +	{ .supply = "vdda-phy", .init_load_uA = 36000 },
> Typo


Sorry for Typo, will fix in next patch.


>>  };
>>  
>>  static const struct qmp_usbc_offsets qmp_usbc_offsets_v3_qcm2290 = {
>> @@ -569,8 +578,10 @@ static const struct qmp_phy_cfg msm8998_usb3phy_cfg = {
>>  	.rx_tbl_num             = ARRAY_SIZE(msm8998_usb3_rx_tbl),
>>  	.pcs_tbl                = msm8998_usb3_pcs_tbl,
>>  	.pcs_tbl_num            = ARRAY_SIZE(msm8998_usb3_pcs_tbl),
>> -	.vreg_list              = qmp_phy_vreg_l,
>> -	.num_vregs              = ARRAY_SIZE(qmp_phy_vreg_l),
>> +	.reset_list		= usb3phy_reset_l,
>> +	.num_resets		= ARRAY_SIZE(usb3phy_reset_l),
>> +	.vreg_list              = qmp_phy_usb_vreg_l,
>> +	.num_vregs              = ARRAY_SIZE(qmp_phy_usb_vreg_l),
>>  	.regs                   = qmp_v3_usb3phy_regs_layout,
>>  };
>>  
>> @@ -586,8 +597,10 @@ static const struct qmp_phy_cfg qcm2290_usb3phy_cfg = {
>>  	.rx_tbl_num		= ARRAY_SIZE(qcm2290_usb3_rx_tbl),
>>  	.pcs_tbl		= qcm2290_usb3_pcs_tbl,
>>  	.pcs_tbl_num		= ARRAY_SIZE(qcm2290_usb3_pcs_tbl),
>> -	.vreg_list		= qmp_phy_vreg_l,
>> -	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
>> +	.reset_list		= usb3phy_reset_l,
>> +	.num_resets		= ARRAY_SIZE(usb3phy_reset_l),
>> +	.vreg_list		= qmp_phy_usb_vreg_l,
>> +	.num_vregs		= ARRAY_SIZE(qmp_phy_usb_vreg_l),
>>  	.regs			= qmp_v3_usb3phy_regs_layout_qcm2290,
>>  };
>>  
>> @@ -603,8 +616,10 @@ static const struct qmp_phy_cfg sdm660_usb3phy_cfg = {
>>  	.rx_tbl_num		= ARRAY_SIZE(sdm660_usb3_rx_tbl),
>>  	.pcs_tbl		= qcm2290_usb3_pcs_tbl,
>>  	.pcs_tbl_num		= ARRAY_SIZE(qcm2290_usb3_pcs_tbl),
>> -	.vreg_list		= qmp_phy_vreg_l,
>> -	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
>> +	.reset_list		= usb3phy_reset_l,
>> +	.num_resets		= ARRAY_SIZE(usb3phy_reset_l),
>> +	.vreg_list		= qmp_phy_usb_vreg_l,
>> +	.num_vregs		= ARRAY_SIZE(qmp_phy_usb_vreg_l),
>>  	.regs			= qmp_v3_usb3phy_regs_layout_qcm2290,
>>  };
>>  
>> @@ -637,6 +652,11 @@ static const struct qmp_phy_cfg qcs615_usb3dp_phy_cfg = {
>>  
>>  	.swing_tbl		= &qmp_dp_voltage_swing_hbr2_rbr,
>>  	.pre_emphasis_tbl	= &qmp_dp_pre_emphasis_hbr2_rbr,
>> +
>> +	.reset_list		= usb3dpphy_reset_l,
>> +	.num_resets		= ARRAY_SIZE(usb3dpphy_reset_l),
>> +	.vreg_list		= qmp_phy_usbdp_vreg_l,
>> +	.num_vregs		= ARRAY_SIZE(qmp_phy_usbdp_vreg_l),
>>  };
>>  
>>  static int qmp_usbc_com_init(struct phy *phy)
>> @@ -653,13 +673,13 @@ static int qmp_usbc_com_init(struct phy *phy)
>>  		return ret;
>>  	}
>>  
>> -	ret = reset_control_bulk_assert(qmp->num_resets, qmp->resets);
>> +	ret = reset_control_bulk_assert(cfg->num_resets, qmp->resets);
>>  	if (ret) {
>>  		dev_err(qmp->dev, "reset assert failed\n");
>>  		goto err_disable_regulators;
>>  	}
>>  
>> -	ret = reset_control_bulk_deassert(qmp->num_resets, qmp->resets);
>> +	ret = reset_control_bulk_deassert(cfg->num_resets, qmp->resets);
>>  	if (ret) {
>>  		dev_err(qmp->dev, "reset deassert failed\n");
>>  		goto err_disable_regulators;
>> @@ -682,7 +702,7 @@ static int qmp_usbc_com_init(struct phy *phy)
>>  	return 0;
>>  
>>  err_assert_reset:
>> -	reset_control_bulk_assert(qmp->num_resets, qmp->resets);
>> +	reset_control_bulk_assert(cfg->num_resets, qmp->resets);
>>  err_disable_regulators:
>>  	regulator_bulk_disable(cfg->num_vregs, qmp->vregs);
>>  
>> @@ -694,7 +714,7 @@ static int qmp_usbc_com_exit(struct phy *phy)
>>  	struct qmp_usbc *qmp = phy_get_drvdata(phy);
>>  	const struct qmp_phy_cfg *cfg = qmp->cfg;
>>  
>> -	reset_control_bulk_assert(qmp->num_resets, qmp->resets);
>> +	reset_control_bulk_assert(cfg->num_resets, qmp->resets);
>>  
>>  	clk_bulk_disable_unprepare(qmp->num_clks, qmp->clks);
>>  
>> @@ -921,42 +941,22 @@ static const struct dev_pm_ops qmp_usbc_pm_ops = {
>>  			   qmp_usbc_runtime_resume, NULL)
>>  };
>>  
>> -static int qmp_usbc_vreg_init(struct qmp_usbc *qmp)
>> +static int qmp_usbc_reset_init(struct qmp_usbc *qmp)
>>  {
>>  	const struct qmp_phy_cfg *cfg = qmp->cfg;
>> -	struct device *dev = qmp->dev;
>> -	int num = cfg->num_vregs;
>> -	int i;
>> -
>> -	qmp->vregs = devm_kcalloc(dev, num, sizeof(*qmp->vregs), GFP_KERNEL);
>> -	if (!qmp->vregs)
>> -		return -ENOMEM;
>> -
>> -	for (i = 0; i < num; i++)
>> -		qmp->vregs[i].supply = cfg->vreg_list[i];
>> -
>> -	return devm_regulator_bulk_get(dev, num, qmp->vregs);
>> -}
>> -
>> -static int qmp_usbc_reset_init(struct qmp_usbc *qmp,
>> -			      const char *const *reset_list,
>> -			      int num_resets)
>> -{
>>  	struct device *dev = qmp->dev;
>>  	int i;
>>  	int ret;
>>  
>> -	qmp->resets = devm_kcalloc(dev, num_resets,
>> +	qmp->resets = devm_kcalloc(dev, cfg->num_resets,
>>  				   sizeof(*qmp->resets), GFP_KERNEL);
>>  	if (!qmp->resets)
>>  		return -ENOMEM;
>>  
>> -	for (i = 0; i < num_resets; i++)
>> -		qmp->resets[i].id = reset_list[i];
>> +	for (i = 0; i < cfg->num_resets; i++)
>> +		qmp->resets[i].id = cfg->reset_list[i];
>>  
>> -	qmp->num_resets = num_resets;
>> -
>> -	ret = devm_reset_control_bulk_get_exclusive(dev, num_resets, qmp->resets);
>> +	ret = devm_reset_control_bulk_get_exclusive(dev, cfg->num_resets, qmp->resets);
>>  	if (ret)
>>  		return dev_err_probe(dev, ret, "failed to get resets\n");
>>  
>> @@ -1146,11 +1146,6 @@ static int qmp_usbc_parse_usb_dt_legacy(struct qmp_usbc *qmp, struct device_node
>>  
>>  	qmp->num_clks = ret;
>>  
>> -	ret = qmp_usbc_reset_init(qmp, usb3phy_legacy_reset_l,
>> -				 ARRAY_SIZE(usb3phy_legacy_reset_l));
>> -	if (ret)
>> -		return ret;
>> -
>>  	return 0;
>>  }
>>  
>> @@ -1187,14 +1182,9 @@ static int qmp_usbc_parse_usb_dt(struct qmp_usbc *qmp)
>>  	qmp->pipe_clk = devm_clk_get(dev, "pipe");
>>  	if (IS_ERR(qmp->pipe_clk)) {
>>  		return dev_err_probe(dev, PTR_ERR(qmp->pipe_clk),
>> -				     "failed to get pipe clock\n");
>> +					"failed to get pipe clock\n");
> unrelated


Ack.


>>  	}
>>  
>> -	ret = qmp_usbc_reset_init(qmp, usb3phy_reset_l,
>> -				 ARRAY_SIZE(usb3phy_reset_l));
>> -	if (ret)
>> -		return ret;
>> -
>>  	return 0;
>>  }
>>  
>> @@ -1228,6 +1218,7 @@ static int qmp_usbc_probe(struct platform_device *pdev)
>>  	struct phy_provider *phy_provider;
>>  	struct device_node *np;
>>  	struct qmp_usbc *qmp;
>> +	const struct qmp_phy_cfg *cfg;
>>  	int ret;
>>  
>>  	qmp = devm_kzalloc(dev, sizeof(*qmp), GFP_KERNEL);
>> @@ -1239,13 +1230,20 @@ static int qmp_usbc_probe(struct platform_device *pdev)
>>  
>>  	qmp->orientation = TYPEC_ORIENTATION_NORMAL;
>>  
>> -	qmp->cfg = of_device_get_match_data(dev);
>> -	if (!qmp->cfg)
>> +	cfg = of_device_get_match_data(dev);
>> +	if (!cfg)
>>  		return -EINVAL;
>>  
>> +	qmp->cfg = cfg;
> Why? This doesn't seem related at all.


I added the |cfg| variable to simplify access to |num_vregs| and |vreg_list| in the following lines, 

avoiding repeated |qmp->cfg->...| usage. 

If this is considered unrelated, I’ll remove it in the next version.


>
>> +
>>  	mutex_init(&qmp->phy_mutex);
>>  
>> -	ret = qmp_usbc_vreg_init(qmp);
>> +	ret = qmp_usbc_reset_init(qmp);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = devm_regulator_bulk_get_const(qmp->dev, cfg->num_vregs,
>> +					 cfg->vreg_list, &qmp->vregs);
>>  	if (ret)
>>  		return ret;
>>  
>>
>> -- 
>> 2.34.1
>>

