Return-Path: <linux-kernel+bounces-807989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A46F7B4ABAD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C33FB7AC0C2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CBF31D754;
	Tue,  9 Sep 2025 11:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="maynvZp7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF5E2472A8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 11:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757417048; cv=none; b=Ak1dtnLWNFcIk+z0njVtomGaruiUIUI8KDET+MVtOkWHMDyFZ5B7VyVeyz9KTHYLew7mPAf+c8pqYTmqjZ4KTInGUJwaQbPdfhuHlNrs/ntTcDp3jNGwhu7JejVBFzz8Ep4gA52KAash37lWcoy3OPtsbzJIaE/+fUioDZRm3aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757417048; c=relaxed/simple;
	bh=+Ysrimkdyuzm7m4Q32oXzG0a4lsvmBDiJ/IdfRlQM0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iZUhPXMrRhdb1IpplMf4Dv4MGaXQqpiGR6ZZKNbDFMUzcYLDn0dENyF6gKLCcaKgMpz1pfTY+Cbn1H0M6YMOO/OecapRyLwuawldQFG6HeBHAn8mH0lC0Pimh7Y4s+QfKEhfVOw0cxiK5AkG7h5wAZw7Nx+ScMUzyr8LEN2s3rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=maynvZp7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5899M33O002349
	for <linux-kernel@vger.kernel.org>; Tue, 9 Sep 2025 11:24:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eUg01/Afr4AMNQRrBFnV7GmqqBeNc1amI/Kdd18PPvM=; b=maynvZp7JMq7mPtf
	IpmJDExs+dNasB/q8wpITQp3+Py6G2WhCxEuReS1o5dcS0Rv6EAB6baBsRBbUG5/
	A/fMNmp2XIrOBVP3ApvX/sq0EQsWGmHSrZjsHdi9sTI2J255e8jHTUkQsNMTb5yz
	KMEcqrWnOF+xi85XZdNZ/fmQGu8aO/wSFLvo7EUo3GsjiGQvIBXkA50WZ2PxK4hB
	9i0L5XOlryOiiduJHp2vc09E0zrou3Win2Z/fsdW781j5skEPKqR65Gjx2JHmW3R
	I9i0tRs3MfKG+PhA/1gJWJLpcepekM+Ux9mNakcnN7U8NE3JeFsOPZireGbAXGTt
	xoCkiA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490dqfyuyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 11:24:06 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b5f15a5f3dso8101611cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 04:24:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757417045; x=1758021845;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eUg01/Afr4AMNQRrBFnV7GmqqBeNc1amI/Kdd18PPvM=;
        b=PXER0H9xUUbribyXJvNyZhyUMqBbORlsr/BvNTf+KprdXwzqYCxXFKNfpmqAxsWsdn
         iKe8+tCCase4I13O3qZ2WgSMIWQLfZkbgVLhCXDzzTzdgxxjzBu3JbIzXlQQQ9njXkZQ
         pJgm73m06gqKniKIUvU+QkFNMYrx7BJfvZBlS2U3ofjJPSkN5/gGrniUFSCH5TAY3lS0
         CFxhJW+JLQSodPqTy6v7lE9BHeKiobY+unYHF1VrwORAguDaBBKKMblg5yDpnJjAkgMV
         WSt5DQhsHWFFBmpM85AXJJPEgs3nb0B4KjpTIhNHUMnmABF31dyywzvPPnasfGX1WyGh
         wUiw==
X-Forwarded-Encrypted: i=1; AJvYcCW8ESqFNYL9KPrRcZ2Ox4Oz0PUToyhasYWqpvIxskpB95v9ll+Nxw5pfH7HIqZizin9dqDhxXbgOblVLgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFobestVBDm7NhxzEc9gN4oxdcuOOIDfQFw7lHoENvdE+7UrBd
	+BtWXezCHxGuNNXtEZW/EYSuIZrjxaOO1MGzpYSOdkM0Fc4QW/++Ngtc9Qxbf90ybBobDogtQSb
	66kbKcilGV+r+EJ5a2xckIpiqHJpSxE0LrrhlhmROxqlrqfFJQGh8W3qYqH0wDwFOQ4c=
X-Gm-Gg: ASbGncuF/ET0ENToq2zPAp8KiWR1an4Icl6Cr4uinZ+DsNn7y2fCsbpXnptWdiZJJhe
	PBhdpZ9r1z6IoTKKeD86ko8SlGxhCvaZoSjTLikKaX2NlMT0Tjz0EWqmnvXJ35D0RvdTijVhfas
	uTzZEy3RdkkjSjsrG8fizH492I6ryzqh3MSLDTWBIjDzOL5a3jKPyBeWZ8Lj6etdSi3sYWW2Jao
	IbtdEg8clNPo40MYQ2NKjEIFoaqDLAxPsmRfCzfYKRLVbtr+L8skXJsrSmg04fmWMwzmNkLsL8A
	RBvBBN2hyDX1DINvICnBhJ5uxMjm9XyBW4OCUGbNO3ZJ+l3AIKfOsowuBK23aZ+YgHye7f8BYcM
	2BUOku2Ki3gqdCNnokEJPBQ==
X-Received: by 2002:a05:622a:1355:b0:4b2:b591:4602 with SMTP id d75a77b69052e-4b5f85310efmr82329521cf.9.1757417044946;
        Tue, 09 Sep 2025 04:24:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOYBxYQlHjTy/WbyUCGub1yhV3/MlPIzezVg20ZIjr0sOh6+2yeuVD3SEZgmzVo3u8oI9Dqw==
X-Received: by 2002:a05:622a:1355:b0:4b2:b591:4602 with SMTP id d75a77b69052e-4b5f85310efmr82329251cf.9.1757417044226;
        Tue, 09 Sep 2025 04:24:04 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62c018f663asm1086756a12.43.2025.09.09.04.24.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 04:24:03 -0700 (PDT)
Message-ID: <12ae186b-9816-4269-ab3a-7aacdc7cb954@oss.qualcomm.com>
Date: Tue, 9 Sep 2025 13:24:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] phy: qcom-qmp: qserdes-com: Add v8 DP-specific
 qserdes register offsets
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250909-phy-qcom-edp-add-glymur-support-v2-0-02553381e47d@linaro.org>
 <20250909-phy-qcom-edp-add-glymur-support-v2-2-02553381e47d@linaro.org>
 <3xw54kzk36u7zrfhgva4p577nzle3ctzi3lyhcxapczv2bhceo@23zcaylkqoff>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <3xw54kzk36u7zrfhgva4p577nzle3ctzi3lyhcxapczv2bhceo@23zcaylkqoff>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 4nmECZaXCmOdP56HT7iYUNomooeNaSWZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzNSBTYWx0ZWRfXy88BpRNp4CJx
 fYKRScwfGjcrUOdVnJpx5ZwuuO/1JNk+b2UWSlG5A+esb2HYZQ9gCeFiCww9TtS/nJChZQDPayq
 z72cVIC4AfnCaE/8+7j9wSkLAobXa/3B9M8hsmHLgzJZruTOK3TUgM+bN1RECEAMhky4iz8IxSN
 9n4uhW/2JHnXEaBaXzdRG0zIZ4k7JIizdiub3W+fH4fhTxoiVURsLkN2PlfHOZITYYKNB09Zn/3
 4Km8DVqz//6oF9z2bZXKAc20+4CZrtc3azymM2T5RfShdhXdaqKF2KuZR8E5NPxyk0gclpTSMiW
 4fvh0ooHpvEPj8DiyJGNrBYWo5vcTKM9Vy980eJyYwZHcTg6p9yiVfE2IfV/hWXbe6tMbvgnf1b
 1qwwj9Zx
X-Proofpoint-GUID: 4nmECZaXCmOdP56HT7iYUNomooeNaSWZ
X-Authority-Analysis: v=2.4 cv=N8UpF39B c=1 sm=1 tr=0 ts=68c00e56 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=hW6Tvmzh9q5i_Tc9j78A:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_01,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060035

On 9/9/25 1:19 PM, Dmitry Baryshkov wrote:
> On Tue, Sep 09, 2025 at 01:07:27PM +0300, Abel Vesa wrote:
>> Starting with Glymur, the PCIe and DP PHYs qserdes register offsets differ
>> for the same version number. So in order to be able to differentiate
>> between them, add these ones with DP prefix.
>>
>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>> ---
>>  .../phy/qualcomm/phy-qcom-qmp-dp-qserdes-com-v8.h  | 52 ++++++++++++++++++++++
>>  1 file changed, 52 insertions(+)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-dp-qserdes-com-v8.h b/drivers/phy/qualcomm/phy-qcom-qmp-dp-qserdes-com-v8.h
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..2bef1eecdc56a75e954ebdbcd168ab7306be1302
>> --- /dev/null
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-dp-qserdes-com-v8.h
>> @@ -0,0 +1,52 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (C) 2025 Linaro Ltd.
>> + */
>> +
>> +#ifndef QCOM_PHY_QMP_DP_QSERDES_COM_V8_H_
>> +#define QCOM_PHY_QMP_DP_QSERDES_COM_V8_H_
>> +
>> +/* Only for DP QMP V8 PHY - QSERDES COM registers */
>> +#define DP_QSERDES_V8_COM_HSCLK_SEL_1			0x03c
>> +#define DP_QSERDES_V8_COM_BIN_VCOCAL_CMP_CODE1_MODE0	0x058
>> +#define DP_QSERDES_V8_COM_BIN_VCOCAL_CMP_CODE2_MODE0	0x05c
>> +#define DP_QSERDES_V8_COM_SSC_STEP_SIZE1_MODE0		0x060
>> +#define DP_QSERDES_V8_COM_SSC_STEP_SIZE2_MODE0		0x064
>> +#define DP_QSERDES_V8_COM_CP_CTRL_MODE0			0x070
>> +#define DP_QSERDES_V8_COM_PLL_RCTRL_MODE0		0x074
>> +#define DP_QSERDES_V8_COM_PLL_CCTRL_MODE0		0x078
>> +#define DP_QSERDES_V8_COM_CORECLK_DIV_MODE0		0x07c
>> +#define DP_QSERDES_V8_COM_LOCK_CMP1_MODE0		0x080
>> +#define DP_QSERDES_V8_COM_LOCK_CMP2_MODE0		0x084
>> +#define DP_QSERDES_V8_COM_DEC_START_MODE0		0x088
>> +#define DP_QSERDES_V8_COM_DIV_FRAC_START1_MODE0		0x090
>> +#define DP_QSERDES_V8_COM_DIV_FRAC_START2_MODE0		0x094
>> +#define DP_QSERDES_V8_COM_DIV_FRAC_START3_MODE0		0x098
>> +#define DP_QSERDES_V8_COM_INTEGLOOP_GAIN0_MODE0		0x0a0
>> +#define DP_QSERDES_V8_COM_VCO_TUNE1_MODE0		0x0a8
>> +#define DP_QSERDES_V8_COM_INTEGLOOP_GAIN1_MODE0		0x0a4
>> +#define DP_QSERDES_V8_COM_VCO_TUNE2_MODE0		0x0ac
>> +#define DP_QSERDES_V8_COM_BG_TIMER			0x0bc
>> +#define DP_QSERDES_V8_COM_SSC_EN_CENTER			0x0c0
>> +#define DP_QSERDES_V8_COM_SSC_ADJ_PER1			0x0c4
>> +#define DP_QSERDES_V8_COM_SSC_PER1			0x0cc
>> +#define DP_QSERDES_V8_COM_SSC_PER2			0x0d0
>> +#define DP_QSERDES_V8_COM_BIAS_EN_CLKBUFLR_EN		0x0dc
>> +#define DP_QSERDES_V8_COM_CLK_ENABLE1			0x0e0
>> +#define DP_QSERDES_V8_COM_SYS_CLK_CTRL			0x0e4
>> +#define DP_QSERDES_V8_COM_SYSCLK_BUF_ENABLE		0x0e8
>> +#define DP_QSERDES_V8_COM_PLL_IVCO			0x0f4
>> +#define DP_QSERDES_V8_COM_SYSCLK_EN_SEL			0x110
>> +#define DP_QSERDES_V8_COM_RESETSM_CNTRL			0x118
>> +#define DP_QSERDES_V8_COM_LOCK_CMP_EN			0x120
>> +#define DP_QSERDES_V8_COM_VCO_TUNE_CTRL			0x13c
>> +#define DP_QSERDES_V8_COM_VCO_TUNE_MAP			0x140
>> +#define DP_QSERDES_V8_COM_CLK_SELECT			0x164
>> +#define DP_QSERDES_V8_COM_CORE_CLK_EN			0x170
>> +#define DP_QSERDES_V8_COM_CMN_CONFIG_1			0x174
> 
> The registers are the same at least up to this point. Would it make
> sense to keep common part in the same header and define only those bits
> that actually differ between DP and PCIe parts? (Is it really about PCIe
> or is it eDP vs everything else?)

No, there's a wild amount of variation between various "v8" PHYs and this
is impossible to catch by eye

Konrad

