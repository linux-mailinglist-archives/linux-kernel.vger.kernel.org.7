Return-Path: <linux-kernel+bounces-834752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B76DBA56C8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 02:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 484411C071BF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 00:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE1C1B87F2;
	Sat, 27 Sep 2025 00:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dcB57Lvf"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89F313B284
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 00:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758933271; cv=none; b=qCfnr+6GNR0jaF1tQ3JHjewJhEM7oPxjBk8mOPJdMbS+CThhuLFINgNpB6Y0hJ967Lmmw6AQoBwvqmC1UZOuED4+O+0qMQib1Y91AzAjbuhI7b8RLnbT0TL7qAGWuIVgXZQ/YbhidmUshh6KrOb5AWIrU/7EOKqKedNZN/E6I8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758933271; c=relaxed/simple;
	bh=Ie1+3dOmzn6F/oLn0yks7AubPDSI2bOKAARyt9PpkzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iq1IiZ/cI2Z81kcxJ8XZq4qC3Wj+mOig0dZE34rgbLYuXaKVyjDWz+Jd600Zm2uW4HLbtsS+HdLoJ1eyNjFYYhA7bHzaqwbEmg261Ph5ISagY9VQ4N4sQw/txDJL9vWVXX21S6QvgQAhzkJ3x6WgslHipGmcZ68anC3jlPCYU7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dcB57Lvf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58R0Jkvq010803
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 00:34:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RcvHuJWCbk3BM+dDfbEeuaA/xZMstL+kCgs1ypKPlgs=; b=dcB57Lvfe3uZsrIs
	nDRj+QPZE3erPi5hptVnoU8pG7SZFqJVkcAvGtQzj1ZqiOstWvV2gxaptDPlRIfs
	XFKJlibWgim3QDRKeM1BYxWvgwsLzqFlVvKwCtUk3U1UQ/ELRdQ1DQd9O+he97OR
	PObWWdi57Ro6HRSH9iPXq4WZnmhDATWgbMURlyxS/465f3+365NrHzCVWJ1iG2//
	PfaJdY5OkXCncWTAWbk/khzN5PFAAGnwZ8KPSvH727AnsVijD/Euwg1Q5hxOtc9a
	ZuNF4DYRFl1vaSzgO2pJpgFoP1JgCamrCKmXH/+I/g//5n00mm06eE6zWPXNS6xU
	utxBrQ==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e59mr0p5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 00:34:28 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-8921abd6c84so3251643241.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 17:34:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758933267; x=1759538067;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RcvHuJWCbk3BM+dDfbEeuaA/xZMstL+kCgs1ypKPlgs=;
        b=omf0G+XGiXsW10RkB99dzOp8663QABsBan4vtfLlqKhzjR3stS0IsdHseq/xJSRubz
         Zj3PPqTgakpkffI4DfPVGP7OuF1TS5xQM7NiEsGuP5I5fPsPEyQKspDOmtWV1y7l5c2j
         L/QTvSx5y0TBOjnlM+yUr3mYjadeMj+gygbCKrCnCBi0K6pYwFX8slmHIebA5rSVlSDO
         YmpGD2P6B5NXla6FwaPMTg6SfBdMmRAX1lhzobIu6N/TtMzQRJJ6tOFR79d98dy8K8JK
         Rs08Mk0Yp26MvoESxhaydJebweVAjYEF64c/WSj40f3crIoMNdjS16Vjs6tCRHe33QXf
         XHew==
X-Forwarded-Encrypted: i=1; AJvYcCX2a2+ncfKYD9cyK2ieihHhXLbOUyvMjMs/LDA2bBV0pQnXFgSSckPauMRmvKmGhPrG06jtM6D+zUc/6d4=@vger.kernel.org
X-Gm-Message-State: AOJu0YymOygT+H4ZY3Y9lPIec58PL+9Qs21DgcP8PID3emonjegntan3
	PK28z6W3U4/Ig3nUxgy7M33x+yLuBIbJh4qA0jq+jFkjPhDH7s7Uw/KDwhotkP1v12zLFzcwsO1
	/pyfStPT/3qP3KSVYVxs+WOC/bur3CRcpYHC+Jc8Qa78aO6Z5hmLY4lueTyMzqd8/9ds=
X-Gm-Gg: ASbGncunDwWAd9a0QAOqhXPYrkm1yNxbYjJ6kliyDer7IAZXbLkAMRRzmryccWrUIn2
	PqMg00yh+YK04SSQ5qlU64EIE0kp9/M07c0dJoIGYwXHVt1mcSsIRGKeWh2avbOXx8mRT0CKe2v
	pNg1gftZ0GQjiM2fymwKLnzXqyMbidG4CEzXMHimn/5Ai6MDTwaoPa8r+dIHNlv/J9P8DJFqH0v
	R79wDOMCAVV57/PpNYl/MqbMQzTc/HVYMGwnU5u6lFaDXqMQfyd+VXJOdy44m60Yk4UR4NidCvL
	bc80Z/HRiVSh9G7TSHNqkXxk2MQP9qZ2PvnbrpFjCpcgTVCKxP3+23o65NvckrGI9M2JcVC70Te
	1VCg8Zfk=
X-Received: by 2002:a17:902:db02:b0:25d:d848:1cca with SMTP id d9443c01a7336-27ed4a9210cmr101101305ad.35.1758932777142;
        Fri, 26 Sep 2025 17:26:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGl/VvGzXBiAsVCQPQ5JSyszwVAPZ3CE+4Pj60nC2J+bmZi/TFe45otM20FRy6jWafZOYKjuQ==
X-Received: by 2002:a17:902:db02:b0:25d:d848:1cca with SMTP id d9443c01a7336-27ed4a9210cmr101100975ad.35.1758932776652;
        Fri, 26 Sep 2025 17:26:16 -0700 (PDT)
Received: from [10.73.53.199] (pat_11.qualcomm.com. [192.35.156.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d3acfsm66321885ad.20.2025.09.26.17.26.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 17:26:15 -0700 (PDT)
Message-ID: <89375a6d-782f-8b89-bf16-1d13b7a525ed@oss.qualcomm.com>
Date: Fri, 26 Sep 2025 17:26:14 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 07/10] phy: qualcomm: qmp-combo: Update QMP PHY with
 Glymur settings
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, kishon@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, robh@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250925022850.4133013-1-wesley.cheng@oss.qualcomm.com>
 <20250925022850.4133013-8-wesley.cheng@oss.qualcomm.com>
 <oecyjwj7ouufjbiq2fpvlhhuaof5agm22fdsruf3ppayiu4kkm@wvi4no53x64y>
 <5e9e2824-923c-1328-dd7a-a8b496c44a70@oss.qualcomm.com>
 <exe3i3lgeor6bdokdqzu2nlenlbtjgv6c3swek3phirsinjnhp@tb5x5lkf2i26>
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
In-Reply-To: <exe3i3lgeor6bdokdqzu2nlenlbtjgv6c3swek3phirsinjnhp@tb5x5lkf2i26>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: VqTyvlYSm92GfxB-nZT9uiifxrzlRExB
X-Authority-Analysis: v=2.4 cv=O4g0fR9W c=1 sm=1 tr=0 ts=68d73114 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=ZdW6uxA9NKXbfdqeeS2OGA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=sM_2IyiB1HmcMQZSuvwA:9
 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-ORIG-GUID: VqTyvlYSm92GfxB-nZT9uiifxrzlRExB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAwMSBTYWx0ZWRfXzEuXlXCVQnSL
 xxcM8KeMs2CaxEmvzRp4GsFqug2C340HetBKLASey285epFPC2sBmplOG7zYJviJIniLH84yhIv
 eBDaS1w27/FMbtgX8wxEB3+JciLNjEHOAYbq+luLVhhOWlZJp95sE23PCnZ9P6OMDf67CM6dkUj
 9Fv0lK/UADYtF+IWtEERjE1pgf5UoanVLLFt6HoeGAIbn/uLPaOW35N6DPqMJ0iZU/VOHbiuJRa
 j9e1b6LS8CpB8esHmNwqR/hQ2nEGVkAuUmRC4eGQ92Yj0+A7PQ1awj08kYGE+4eXv6c1PsxRCgy
 nVrFccj616IrFfWf9BX9ii7/Ka1/Dhj4TwE/c5gMxVUCisLPwQOYjL9K+h2OeCNXBJ2Zexz3CPH
 mhMSQUln45bnF44QNcuyv0xBY3GScg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_08,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270001



On 9/25/2025 7:11 PM, Dmitry Baryshkov wrote:
> On Thu, Sep 25, 2025 at 05:14:30PM -0700, Wesley Cheng wrote:
>>
>>
>> On 9/24/2025 7:54 PM, Dmitry Baryshkov wrote:
>>> On Wed, Sep 24, 2025 at 07:28:47PM -0700, Wesley Cheng wrote:
>>>> For SuperSpeed USB to work properly, there is a set of HW settings that
>>>> need to be programmed into the USB blocks within the QMP PHY.  Ensure that
>>>> these settings follow the latest settings mentioned in the HW programming
>>>> guide.  The QMP USB PHY on Glymur is a USB43 based PHY that will have some
>>>> new ways to define certain registers, such as the replacement of TXA/RXA
>>>> and TXB/RXB register sets.  This was replaced with the LALB register set.
>>>>
>>>> There are also some PHY init updates to modify the PCS MISC register space.
>>>> Without these, the QMP PHY PLL locking fails.
>>>>
>>>> Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
>>>> ---
>>>>    drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 311 +++++++++++++++++++++-
>>>>    drivers/phy/qualcomm/phy-qcom-qmp.h       |   4 +
>>>>    2 files changed, 314 insertions(+), 1 deletion(-)
>>>>
>>>> +
>>>> +static const struct qmp_phy_init_tbl glymur_usb43dp_pcs_misc_tbl[] = {
>>>> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_MISC_PCS_MISC_CONFIG1, 0x01),
>>>
>>> Why is this V4 all of sudden?
>>>
>>
>> Hi Dmitry,
>>
>> Will fix..
>>
>>>> +};
>>>> +
>>>> +static const struct qmp_phy_init_tbl glymur_usb43dp_pcs_tbl[] = {
>>>> +	QMP_PHY_INIT_CFG(QPHY_V8_USB43_PCS_LOCK_DETECT_CONFIG1, 0xc4),
>>>> +	QMP_PHY_INIT_CFG(QPHY_V8_USB43_PCS_LOCK_DETECT_CONFIG2, 0x89),
>>>> +	QMP_PHY_INIT_CFG(QPHY_V8_USB43_PCS_LOCK_DETECT_CONFIG3, 0x20),
>>>> +	QMP_PHY_INIT_CFG(QPHY_V8_USB43_PCS_LOCK_DETECT_CONFIG6, 0x13),
>>>> +	QMP_PHY_INIT_CFG(QPHY_V8_USB43_PCS_REFGEN_REQ_CONFIG1, 0x21),
>>>> +	QMP_PHY_INIT_CFG(QPHY_V8_USB43_PCS_RX_SIGDET_LVL, 0x55),
>>>> +	QMP_PHY_INIT_CFG(QPHY_V8_USB43_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
>>>> +	QMP_PHY_INIT_CFG(QPHY_V8_USB43_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
>>>> +	QMP_PHY_INIT_CFG(QPHY_V8_USB43_PCS_TSYNC_RSYNC_TIME, 0xa4),
>>>> +	QMP_PHY_INIT_CFG(QPHY_V8_USB43_PCS_RX_CONFIG, 0x0a),
>>>> +	QMP_PHY_INIT_CFG(QPHY_V8_USB43_PCS_TSYNC_DLY_TIME, 0x04),
>>>> +	QMP_PHY_INIT_CFG(QPHY_V8_USB43_PCS_ALIGN_DETECT_CONFIG1, 0xd4),
>>>> +	QMP_PHY_INIT_CFG(QPHY_V8_USB43_PCS_ALIGN_DETECT_CONFIG2, 0x30),
>>>> +	QMP_PHY_INIT_CFG(QPHY_V8_USB43_PCS_PCS_TX_RX_CONFIG, 0x0c),
>>>> +	QMP_PHY_INIT_CFG(QPHY_V8_USB43_PCS_EQ_CONFIG1, 0x4b),
>>>> +	QMP_PHY_INIT_CFG(QPHY_V8_USB43_PCS_EQ_CONFIG5, 0x10),
>>>> +};
>>>> +
>>>> +static const struct qmp_phy_init_tbl glymur_usb43dp_pcs_usb_tbl[] = {
>>>> +	QMP_PHY_INIT_CFG(QPHY_V8_PCS_USB_LFPS_DET_HIGH_COUNT_VAL, 0xf8),
>>>> +	QMP_PHY_INIT_CFG(QPHY_V8_PCS_USB_RXEQTRAINING_DFE_TIME_S2, 0x07),
>>>> +};
>>>> +
>>>> @@ -1667,6 +1899,12 @@ static struct qmp_regulator_data qmp_phy_vreg_l[] = {
>>>>    	{ .name = "vdda-pll", .enable_load = 36000 },
>>>>    };
>>>> +static struct qmp_regulator_data qmp_phy_vreg_refgen[] = {
>>>> +	{ .name = "vdda-phy", .enable_load = 21800 },
>>>> +	{ .name = "vdda-pll", .enable_load = 36000 },
>>>> +	{ .name = "refgen", .enable_load = 936 },
>>>
>>> Is this a meaningful value?
>>>
>>
>> I need to adjust this value.  I just want the load for the regulators to be
>> in HPM, and after taking a look, looks like based on the rpmh regulator
>> table, I need to be voting 35000.
> 
> Please provide a value from the platform data rather than just the HPM
> boundary.
> 

OK, I referenced our power grid for the correct Ipeak for that 
particular regulator.  Will update this number accordingly.

Thanks
Wesley Cheng

>>
>> Thanks
>> Wesley Cheng
>>
>>>> +};
>>>> +
>>>>    static const u8 qmp_dp_v3_pre_emphasis_hbr3_hbr2[4][4] = {
>>>>    	{ 0x00, 0x0c, 0x15, 0x1a },
>>>>    	{ 0x02, 0x0e, 0x16, 0xff },
>>>
> 

