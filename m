Return-Path: <linux-kernel+bounces-827079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 257F8B90379
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 12:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2587318A343D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEA43093B6;
	Mon, 22 Sep 2025 10:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kaREty9V"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547DD304972
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 10:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758537598; cv=none; b=jVvtdHVOxWG/KPaNzQBmANoc4X57R2I66VUefH5pa8MiPHAE3RMLjv437zF5gZD/swqhnP9ojZ2FPHDAmyBIF3e/2RvpbcWa1VFfEozXHt4G8KIUxH0SL/NzR760bvdAI488ZXuTsrruU7hKDwJ1/f6/V6IhXrGa3Dlbru9a/rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758537598; c=relaxed/simple;
	bh=twUcl12npOG8qzI9GA9aXYM/D+zCfltEzGgWykDIeu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pcYL7+a5ot66N7avDRK4tO5Jt08agLzUDAuicLwmEsm1ks6f+itefnlbQrHu588bogjTLuJUPXiP6Bo+LtzdTXdZAryyaXnAoFz126a1bOzGRCQlmEShh8qzhgQFm4jaws7vP0I8WSqmJePb/lwObhJHb7wcWsN4V8VfTFu9kno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kaREty9V; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M7GPMA029201
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 10:39:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S/sA8nAMeAFMELZqIPjuLjJ4XtaKTMC4EnJ3WDadUqo=; b=kaREty9VXGeciDLI
	tCvv1KCyLhUfKm/djj2m4hnm9nMrsHRkwQzZgWImpLtgW00/4d39/gq+ziey5ral
	QSHeBxAucErWvK23cbWyWyvXCLMWdjufjUHvB0bGfHWcY2QaLk6QCTi3ReNYrTiR
	DJkmfa100TLfOC5xs5R+m3qOmLXAg6RfKqWRo3LlUGS3Q8ixL6C4tdba4NLLFS4v
	0yffZl8J5fGt178CwkdUL2tJpUwed5Y+/wAuOWw2sDaS+lrtPHx0tZuum52E3MIQ
	S8ih2sgoJweK4CzFWVrznjiSBOOB/l60gbOu2vx5X2mUhz286H1xsFLitauhQMg5
	2AMvNw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hyempsu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 10:39:56 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b5546169b7aso37779a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 03:39:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758537596; x=1759142396;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S/sA8nAMeAFMELZqIPjuLjJ4XtaKTMC4EnJ3WDadUqo=;
        b=H6vy5cK1jdul0096o+N4WsSdL8gP8KekTNXEaaZqOz9Zu4IWpHYeqiloLgRUTU25ZL
         Pa7vyz4M7/eZfdeuu93HW/C9QyEYb3FI/ewJtovU6+Axf7pNwPZtdeDuF7lPD7nHcnvo
         qHuiQtpg6TX7NgpCYMxIv9AtfBJU4MCWe6szSyZF349k8jEe4OMrlZ1Tth7Y+uDYVwH3
         9VXFBuP/ClZeRk7QzYqfbI9vK6y1coBWCE7xffrTUvWGDcWQrFmV5jcfdh41oCgzHdY8
         PeJymNPVboKfbJ8qGowmYSbn0MYI1mhbT605fyYtq8Jnp4+ErZg7FL7B3IG3pjVwkrZ7
         76cw==
X-Forwarded-Encrypted: i=1; AJvYcCUOOFdJ5df5WtFd+gZwSbh4rDzKdAzp54sohB5F8zDGdsiuPeul0nr37q19E+8FqvCm+zMNDxD5Dt6rSZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YybXujjTrQq6fNKwXpbbPXL44m6i6TREdJWBVPmQla2u00ZyrkU
	ZCLgoCk1XxKjun/dyC5yxX3KhAsbgPZaWpTiCDWrHHUzJOaugvDvALSiOeIQtUSmP7lnwHDAOMq
	IJIN52zGe9aMfDcdr0n7bvKu/N2JK2pmQ2WY/nKClSouS+soDdjyeajW366M5L88DdKM=
X-Gm-Gg: ASbGncuamtF5P4Xs/nKdFKInyP9CSYRe6mm5My10Rrr0srJHbNUHLjDv1OaY63ByTkp
	XvFTIpaTDC0uWm1fNKk0Ge3ykK1mG0beg6No2xd8jwPwA7jB+gtS1zBq6LqrdV4vDvXARbgNak+
	gRf1pOHivMbFctGyihTs/2c4Oc+HFESCKg/lWFbSs2b7KiDG4oyT8R+4mryedm7mpbNTFY/HXhz
	p77r928XwHfTwXJAlRpci4VhudkgJkXiCaftNKVkHtg0vSd8BIRGF5ecJbyjMUtqxyQIk079wAC
	zGcapUWY/U4Z8IPVf7/qt9fCaf+vKIzzCKj+RnxsXkm3w4gsyRttJjJiTcHaqdFMeg==
X-Received: by 2002:a05:6a00:1894:b0:77f:1a6a:e72b with SMTP id d2e1a72fcca58-77f3126ad87mr2512340b3a.5.1758537595660;
        Mon, 22 Sep 2025 03:39:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzeuarlsbMfcKnTGM+3OHSIOvq4mUD5eYqtObyzudC9HyNv9RqGfR6ipfD9BvwEsV1pOsHsw==
X-Received: by 2002:a05:6a00:1894:b0:77f:1a6a:e72b with SMTP id d2e1a72fcca58-77f3126ad87mr2512307b3a.5.1758537595213;
        Mon, 22 Sep 2025 03:39:55 -0700 (PDT)
Received: from [10.64.16.135] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfc2473d0sm12066251b3a.27.2025.09.22.03.39.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 03:39:54 -0700 (PDT)
Message-ID: <bf823249-18e3-48af-a291-63b89bf83163@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 18:39:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/14] phy: qcom: qmp-usbc: Move reset config into PHY
 cfg
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
References: <20250919-add-displayport-support-for-qcs615-platform-v5-0-eae6681f4002@oss.qualcomm.com>
 <20250919-add-displayport-support-for-qcs615-platform-v5-5-eae6681f4002@oss.qualcomm.com>
 <z6x3bwb7izywozeran5aq64uw4tiwlbwx4kekoy3vv3vt7qyip@2ibiat5focw2>
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <z6x3bwb7izywozeran5aq64uw4tiwlbwx4kekoy3vv3vt7qyip@2ibiat5focw2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Yc3wv09Rgd8ZhOVP8JRsbmTD4NDGCFOA
X-Authority-Analysis: v=2.4 cv=YMOfyQGx c=1 sm=1 tr=0 ts=68d1277c cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=kiRbvkIhkhXhhATYQ8oA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwNCBTYWx0ZWRfX2Fyk5Qenf6Ke
 EVkNCySbw73qXFaWphCNZBF53RXk3N1o6lDqLqprhYPv9MwfX+XpT+9ucmUsX5oC4Fje4WuaKOm
 F7hOh4XR2dozon33KHDBCSMVlhZE0x63EDmndTYoiPPQyEpAveHz8f3fFT1If6CQTwmmYEkbYQj
 5D4UDbZMtiqpFkJu46FmWfoOd7958hmdHfFcVxvYQ4sJEUvCtMQGkZx6/IKRJg0F36jxzxFJd1r
 fHdd4ZVjs21X29VSEvKAo0qXeTilqfQpYuanA+d1jlBkbkITeY5IfiEekd1Zy+pbtieGoXmxHEb
 HM8vICM3sfuP+tV6KguKicQ39jIGMbksgJSXgA/zPv7NVcA99cbdbuV0KwulV+DVGjw1Vp187zN
 2PFGw2rF
X-Proofpoint-ORIG-GUID: Yc3wv09Rgd8ZhOVP8JRsbmTD4NDGCFOA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200004


On 9/22/2025 5:39 PM, Dmitry Baryshkov wrote:
> On Fri, Sep 19, 2025 at 10:24:22PM +0800, Xiangxu Yin wrote:
>> Move resets to qmp_phy_cfg for per-PHY customization. Keep legacy DT
>> path on the old hardcoded list; non-legacy path uses cfg->reset_list.
>>
>> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>> ---
>>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 18 +++++++++++++++---
>>  1 file changed, 15 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
>> index 3b48c69f9c3cb7daec495ebc281b83fe34e56881..3d228db9ef0882eb76e7ab9e82f8122fa9cfe314 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
>> @@ -335,7 +335,8 @@ struct qmp_phy_cfg {
>>  	int (*configure_dp_phy)(struct qmp_usbc *qmp);
>>  	int (*calibrate_dp_phy)(struct qmp_usbc *qmp);
>>  
>> -	/* regulators to be requested */
>> +	const char * const *reset_list;
>> +	int num_resets;
>>  	const struct regulator_bulk_data *vreg_list;
>>  	int num_vregs;
>>  
>> @@ -428,6 +429,10 @@ static const char * const usb3phy_reset_l[] = {
>>  	"phy_phy", "phy",
>>  };
>>  
>> +static const char * const usb3dpphy_reset_l[] = {
>> +	"phy_phy", "dp_phy",
>> +};
> This is unused in this patch. It should go to the patch adding QCS615 DP
> PHY compatible and the rest of the config data.


Ok, will move in next patch.


>> +
>>  static const struct regulator_bulk_data qmp_phy_msm8998_vreg_l[] = {
>>  	{ .supply = "vdda-phy", .init_load_uA = 68600 },
>>  	{ .supply = "vdda-pll", .init_load_uA = 14200 },
>> @@ -464,6 +469,8 @@ static const struct qmp_phy_cfg msm8998_usb3phy_cfg = {
>>  	.rx_tbl_num             = ARRAY_SIZE(msm8998_usb3_rx_tbl),
>>  	.pcs_tbl                = msm8998_usb3_pcs_tbl,
>>  	.pcs_tbl_num            = ARRAY_SIZE(msm8998_usb3_pcs_tbl),
>> +	.reset_list		= usb3phy_reset_l,
>> +	.num_resets		= ARRAY_SIZE(usb3phy_reset_l),
>>  	.vreg_list              = qmp_phy_msm8998_vreg_l,
>>  	.num_vregs              = ARRAY_SIZE(qmp_phy_msm8998_vreg_l),
>>  	.regs                   = qmp_v3_usb3phy_regs_layout,
>> @@ -480,6 +487,8 @@ static const struct qmp_phy_cfg qcm2290_usb3phy_cfg = {
>>  	.rx_tbl_num		= ARRAY_SIZE(qcm2290_usb3_rx_tbl),
>>  	.pcs_tbl		= qcm2290_usb3_pcs_tbl,
>>  	.pcs_tbl_num		= ARRAY_SIZE(qcm2290_usb3_pcs_tbl),
>> +	.reset_list		= usb3phy_reset_l,
>> +	.num_resets		= ARRAY_SIZE(usb3phy_reset_l),
>>  	.vreg_list		= qmp_phy_sm2290_vreg_l,
>>  	.num_vregs		= ARRAY_SIZE(qmp_phy_sm2290_vreg_l),
>>  	.regs			= qmp_v3_usb3phy_regs_layout_qcm2290,
>> @@ -496,6 +505,8 @@ static const struct qmp_phy_cfg sdm660_usb3phy_cfg = {
>>  	.rx_tbl_num		= ARRAY_SIZE(sdm660_usb3_rx_tbl),
>>  	.pcs_tbl		= qcm2290_usb3_pcs_tbl,
>>  	.pcs_tbl_num		= ARRAY_SIZE(qcm2290_usb3_pcs_tbl),
>> +	.reset_list		= usb3phy_reset_l,
>> +	.num_resets		= ARRAY_SIZE(usb3phy_reset_l),
>>  	.vreg_list		= qmp_phy_msm8998_vreg_l,
>>  	.num_vregs		= ARRAY_SIZE(qmp_phy_msm8998_vreg_l),
>>  	.regs			= qmp_v3_usb3phy_regs_layout_qcm2290,
>> @@ -512,6 +523,8 @@ static const struct qmp_phy_cfg qcs615_usb3phy_cfg = {
>>  	.rx_tbl_num		= ARRAY_SIZE(qcm2290_usb3_rx_tbl),
>>  	.pcs_tbl		= qcm2290_usb3_pcs_tbl,
>>  	.pcs_tbl_num		= ARRAY_SIZE(qcm2290_usb3_pcs_tbl),
>> +	.reset_list		= usb3phy_reset_l,
>> +	.num_resets		= ARRAY_SIZE(usb3phy_reset_l),
>>  	.vreg_list		= qmp_phy_qcs615_vreg_l,
>>  	.num_vregs		= ARRAY_SIZE(qmp_phy_qcs615_vreg_l),
>>  	.regs			= qmp_v3_usb3phy_regs_layout_qcm2290,
>> @@ -1051,8 +1064,7 @@ static int qmp_usbc_parse_dt(struct qmp_usbc *qmp)
>>  				     "failed to get pipe clock\n");
>>  	}
>>  
>> -	ret = qmp_usbc_reset_init(qmp, usb3phy_reset_l,
>> -				 ARRAY_SIZE(usb3phy_reset_l));
>> +	ret = qmp_usbc_reset_init(qmp, cfg->reset_list, cfg->num_resets);
>>  	if (ret)
>>  		return ret;
>>  
>>
>> -- 
>> 2.34.1
>>

