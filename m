Return-Path: <linux-kernel+bounces-827111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F83DB9057A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAC713BEEE0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB24305042;
	Mon, 22 Sep 2025 11:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QgGg0dC6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A30304BA4
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 11:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758540298; cv=none; b=cpwIZjQnw2dw5M+N/FAjrMr4MxOoMUV4g0U5S7/6gLrFlapUR39VP6RjO5VdVkgRbH9g6rvXa8d0cA1wWsYz+OUfV/rHVJH0e7ZQgHZQ+fXod5QtPjw7Z6EsFGBtd5cNZrV+dmOxhZkpRNU16kfs+sll0NuBJXclPTA2/Ow9fjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758540298; c=relaxed/simple;
	bh=igUJVoAn28btOF3Drs+Jwi38T6h4G1rqrTuYeaXV2n4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W10OG357JBhPwUoCr2BIa8SMPtPDM2iHQRJdfQ8bdZEuXYmDCzwBz3N4hvZhT/2hKF62yagcLXfAFRuphir6O8sYKEzL8KED5knN1Jbkoy2BjVZ9q46GCzFMDckqUoYqq79hy+uuPPeeWeSyBaaw18fZlr0mUAO/ud3SwitzjQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QgGg0dC6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M8vYHf017365
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 11:24:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vhPS2DpVO5rMmjT/67K3Kgtn22q0loN6kh/+0Y18da0=; b=QgGg0dC6cMzJyY5V
	U4MIXE3SNPYSAo/GeX3s0AWO2iV/lZaMuwLV0Wp+fKBapBNp4ektQDDYmqerkttY
	if8+54j9ruF+bdo6p1HGdUhq+2gUwpJx0/pf2/F2OIQso1V9BQf7rKJUjjZK8TBM
	0VX71Cj4f2xbJSX9E1+Mli5BelOeuNLKtODYfkpmcoFGxuqHxnFkylKLSljR3CBN
	dz42Io3C3ivdvjik6hVWpJIKVCKDzbz8K5HX6Ek3d+0jZByGjxTvk/o3/oin5EtJ
	47qDlqVQ+pXDxj+FxFRrXJ29B3NrIF5dSBDPyxPem+71jcwg3T9suQ1knjYycfCA
	eSa8zA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499k7svnj0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 11:24:55 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-26b3e727467so9423815ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 04:24:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758540295; x=1759145095;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vhPS2DpVO5rMmjT/67K3Kgtn22q0loN6kh/+0Y18da0=;
        b=tTua7E/aBnguulUDA4wyhP1l+U8MxLMZSICONb8U8Ttw8HuqbvfJm8wV0KCxNFE69U
         1u8UuqWmIA/7BcQsHZYncp7uIHPRHe0qRkUrAvqoSPrqmQoTD4dv3gpQ/YNO7OiZ8CYz
         gzHwehHbKhNTnhz9q5HVax5zgbgVBTEiDPWPcu6NBJXNacQ34fhgIrEOinQoIQHE7ZKC
         esLvVRuCuNmexAg9VhXzy1Qldf6in17yI5AXOdin0RIHH6T1nCBT8aX4Eq8LkaKq0xH8
         /wXx7MFttOlB6/hoUn3LOETAAY/eh9RwiIp68dLbgVOVYdwBAwKO6LvBfiVuiE48+cg4
         xXpA==
X-Forwarded-Encrypted: i=1; AJvYcCXBRiStOiX5OMfnWBRHb4CsmXALduZuqLGSpX9XnQYTcFiO9rPYTzDGjNv5Xca7pHJijbSUwsH2/Wq8hIg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy26DFZ2vmDmJyfkYtrePF173feh52PzjKLoBUng6M1GsZvvxA/
	h9fTfGjXaJWQppFQkvjpffMJHIyAyU5KK0ioLmppgS685naUC0Msi/HWvFqxX0oIZHbCrQuniEw
	xvJHFLNkCwmAUmjOZIsiydnUqFb/RaYrHeQWqRmRq41jo+4Dohnpop6IpwGk4svhb1sw=
X-Gm-Gg: ASbGncv0IsyxWofJ11NOjHa0I6L5BrJCWE5WxnHu5iHru5KhXeECZrqMhmNI/f2GZ61
	+f5hUl97JEJz767lza8QQ2a30vTCmZ6TBvi6L6gSK8Jguv0SY3ZLz5/ammEX7V//JYXZgcp/5R7
	42fLl2XLzwzIQTah3CzfNKlYmbYzw++MRJMfI0pwhF+XKwfZWy5pW7G59fgS/8iKFFLt6zf/g7B
	HeWc9ilCV4Z/I/SSQ9Rxl7nHvKed5+eRT+e6tpKx/OjYlQ/T4RUKi3CLlomzMs3BZ/WZqbhdAUu
	BHMr8Zf1vqq9QBEUPqUQk8bTksSnIQ/WYPufyx6Hab9cZI2L6IasYjB9AEc+TjrSiw==
X-Received: by 2002:a17:902:d4c5:b0:267:c4fa:e269 with SMTP id d9443c01a7336-269ba40a079mr100698025ad.1.1758540294877;
        Mon, 22 Sep 2025 04:24:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+c5b351K4AXCSVsRHuVDsbJ0ksLZK6y2QQ3N9fyfPYi1xv4nAje1JQyBpRpK9QX3Bk658FQ==
X-Received: by 2002:a17:902:d4c5:b0:267:c4fa:e269 with SMTP id d9443c01a7336-269ba40a079mr100697835ad.1.1758540294349;
        Mon, 22 Sep 2025 04:24:54 -0700 (PDT)
Received: from [10.64.16.135] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269803416a2sm127178725ad.134.2025.09.22.04.24.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 04:24:53 -0700 (PDT)
Message-ID: <f4a5ffad-ca5e-4a54-a39b-4ed69ab3a729@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 19:24:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/14] phy: qcom: qmp-usbc: Add QCS615 USB/DP PHY
 config and DP mode support
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
 <20250919-add-displayport-support-for-qcs615-platform-v5-12-eae6681f4002@oss.qualcomm.com>
 <bfpgktxgo2hb6dpzy3i7jdr6w4de5boorx4n6qeapct2vre4sn@4z2mnppridn5>
 <14cdf3a4-714c-4136-8c1d-99392e7911f5@oss.qualcomm.com>
 <2ewxoe76rrii4w3n5b6wl32vmatcp2boj75o65cuq5nx4f2a55@7cn6m7oxzu6c>
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <2ewxoe76rrii4w3n5b6wl32vmatcp2boj75o65cuq5nx4f2a55@7cn6m7oxzu6c>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxOCBTYWx0ZWRfX2O9HZKUjROLg
 3uiZ93gKTl+jEquOcGeCkrwHZfY0Q2oKZg5IazT0nAS7dzn3z7Uq6VRxEw3IJraLhnTUo9ZQ6YZ
 JJF0U1aytk3Af+Ch4eOU9mnDcElFMvDkcmdsE8j+XpDXCqHNpZ1KjsslBmIkz1cJjFBApw+9VEY
 mBY/GWvp4Lrmmx41srOh8Ka4ymUYlLn0RilMmmKILh3iqzm+FeQSzjuzzKtF5jP2P3r4BGF/KDF
 UKlHu53iZrO8unRLcQakxLeOlNhuzsLuxz0EPrymMbSgW7W+rNvuJ5FoaTVDBb6MJ+U6APXWHcN
 MFrdw8tuUFUWsMcVUWpDH5zisTMAyElCw0fKF52tCb6D58LaP4TMoTKLqkyZVx5cOMtDXFU9r75
 HcdWZQKN
X-Proofpoint-ORIG-GUID: NLmm28vDa_4MoLjZ_Ddp84iPMtsK1eir
X-Authority-Analysis: v=2.4 cv=bvpMBFai c=1 sm=1 tr=0 ts=68d13207 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=XVeZa78dugChcG7OFuEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: NLmm28vDa_4MoLjZ_Ddp84iPMtsK1eir
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 impostorscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200018


On 9/22/2025 5:45 PM, Dmitry Baryshkov wrote:
> On Mon, Sep 22, 2025 at 02:58:17PM +0800, Xiangxu Yin wrote:
>> On 9/20/2025 2:41 AM, Dmitry Baryshkov wrote:
>>> On Fri, Sep 19, 2025 at 10:24:29PM +0800, Xiangxu Yin wrote:
>>>> Add QCS615-specific configuration for USB/DP PHY, including DP init
>>>> routines, voltage swing tables, and platform data. Add compatible
>>>> "qcs615-qmp-usb3-dp-phy".
>>>>
>>>> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>>>> ---
>>>>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 395 +++++++++++++++++++++++++++++++
>>>>  1 file changed, 395 insertions(+)
>>>>
>>>> +
>>>> +	writel(0x3f, qmp->dp_tx + QSERDES_V2_TX_TRANSCEIVER_BIAS_EN);
>>>> +	writel(0x10, qmp->dp_tx + QSERDES_V2_TX_HIGHZ_DRVR_EN);
>>>> +	writel(0x0a, qmp->dp_tx + QSERDES_V2_TX_TX_POL_INV);
>>>> +	writel(0x3f, qmp->dp_tx2 + QSERDES_V2_TX_TRANSCEIVER_BIAS_EN);
>>>> +	writel(0x10, qmp->dp_tx2 + QSERDES_V2_TX_HIGHZ_DRVR_EN);
>>>> +	writel(0x0a, qmp->dp_tx2 + QSERDES_V2_TX_TX_POL_INV);
>>> Are you sure that these don't need to be adjusted based on
>>> qmp->orientation or selected lanes count?
>>>
>>> In fact... I don't see orientation handling for DP at all. Don't we need
>>> it?
>>
>> Thanks for the review.
>>
>> I agree with your reasoning and compared talos 14nm HPG with hana/kona
>> 7nm PHY HPG; the 7nm COMBO PHY series has orientation/lane-count dependent
>> configs, but the 14nm PHY series does not. On QCS615 (talos), the TX_*
>> registers you pointed to are programmed with constant values regardless
>> of orientation or lane count. This has been confirmed from both the HPG
>> and the downstream reference driver.
> Thanks for the confirmation.
>
>> For orientation, from reference the only difference is DP_PHY_MODE, which
>> is set by qmp_usbc_configure_dp_mode(). The DP PHY does have an
>> SW_PORTSELECT-related register, but due to talos lane mapping from the
>> DP controller to the PHY not being the standard <0 1 2 3> sequence, it
>> cannot reliably handle orientation flip. Also, QCS615 is a fixed-
>> orientation platform (not DP-over-TypeC), so there is no validated hardware
>> path for orientation flip on this platform.
> Wait... I thought that the the non-standard lane order is handled by the
> DP driver, then we should be able to handle the orientation inside PHY
> driver as usual.


Yes, I have confirmed this with our verification team.

For the non-standard lane order, handling flip requires swapping mapped 
lane 0 ↔ lane 3 and lane 1 ↔ lane 2 in the logical2physical mapping.
This is a hardware limitation, and with the current PHY driver we cannot
propagate orientation status to dp_ctrl for processing.


> Anyway, please add a FIXME comment into the source file and a note to
> the commit message that SW_PORTSELECT should be handled, but it's not a
> part of this patch for the stated reasons.


OK, I will add a |FIXME| comment in |qmp_usbc_dp_power_on| and update the
related commit message.


>>
>>>> +
>>>> +	writel(0x18, qmp->dp_dp_phy + QSERDES_DP_PHY_CFG);
>>>> +	writel(0x19, qmp->dp_dp_phy + QSERDES_DP_PHY_CFG);
>>>> +
>>>> +	if (readl_poll_timeout(qmp->dp_dp_phy + QSERDES_V2_DP_PHY_STATUS,
>>>> +			       status,
>>>> +			       ((status & BIT(1)) > 0),
>>>> +			       500,
>>>> +			       10000)){
>>>> +		dev_err(qmp->dev, "PHY_READY not ready\n");
>>>> +		return -ETIMEDOUT;
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +

