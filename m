Return-Path: <linux-kernel+bounces-781443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D80DB31283
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97901605889
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3583A22CBC0;
	Fri, 22 Aug 2025 09:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZGLmcP9n"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529D72ECE80
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755853521; cv=none; b=TuS2NF+5iKVZXi/W1OcGg0R50i5ioHmaM77F0ClwPIPpxbOJ3ZE8h+IU/O6kRW1FGff9sN7hK5oHY5/GiEuVeBOW3UU41r/E6w1atUDXycNOaZFl8ern45Ca/xDpkhRpYJi1bG8pr7+F0bxQhILEgUVDrDaJUDvsj1CeOJG6OyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755853521; c=relaxed/simple;
	bh=DLY5vD2G1U8kuKjZ8Y13igWoq/avK0swelon1k2VJEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rPXxEwt8YrGBDELsNU0aAJu9S3DBacTFwEgsHvCt+LFWZpKp5Eo8gOESOr2QrqvfquhvQn78oJe4tfahtetz+xI8flpsw/Geen3GGdrq04fhScqJfC7HegnJK1p+a0Olu5o8yDV3OrfwfrbKjIBmI942eKYvOukSQxVQoCp3qDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZGLmcP9n; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8UKBO020884
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:05:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	we5kOYIR9rQ9t3N19Qt3EpeOAg+A9dfHS8z2hNw9bB4=; b=ZGLmcP9nYIXNfPDT
	gU9FtFbEBKZSTsVW8aLigBY5uEQ/hnFdyNcvyHFUZD9fPKNDnHTRCJBlN8/Qt7UC
	vBgrKPcz0yA2adVkAsptuqijCFbVEc8H9ejj31wnFtreBmRb6oCLnNZ3NGVJfbmP
	8GlXXefuEt80YiooSQ0riLJyEJ2oSppWw4XNysM51MQSLPJ6xKkw0JDyZ0cyHUh/
	K1p3uKUyoZCwLheemmfi0z/PcE5UNZynhwHqy+njDzVy+o9yURLG/LQXcMmJ8ouV
	nWcXj/CFMTBlFX8adGal7WHiD83vbzUXo/jA3NBQJOG/2FDu0ZOIZgdWiWBZb9am
	M/mYpg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5290mh3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:05:17 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70d9eb2eb9bso4225626d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:05:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755853517; x=1756458317;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=we5kOYIR9rQ9t3N19Qt3EpeOAg+A9dfHS8z2hNw9bB4=;
        b=NIB505H43GuQsYASZMCgYWRUttuCO+aZ/nfj+lrR2Ci2GLPCrKigXZ1avm8MZL3zG4
         TMLa2dS4n/xwcxmGaZqQYF2FcMjQD4VWDrvby1bNBMndnzpZQKDfLb+6TTmsjs4Za0RA
         x9Povb0DsFGWVpiL0/OGYPxvfHgi0H5Y+k2BU8Xv+0KYnWsAlom/silB2LKI2g0UXCCQ
         /HcWiIIyQmvjWbzgGJITYYZZ9MKKpyHIziRmhfJ1qxa4zipnaWBZ0tL4LLrvriYinUkU
         40ILDQX82h4NSj4daGcobeLN9SphXFnlANw0SbetIFI0ucskVVY9dOgwcrIB31XAgt7d
         KYyw==
X-Forwarded-Encrypted: i=1; AJvYcCVgOkooKvB/Lf8XcIvY/uqYTkYyRW75dTwzSRuvJkdMm3Wt2zb+62IZu6E+Tin1UXkNbMX3vNnq3MBFQRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YykAknXxMJKr7LS2/Oac0yugqGau50f+mD8JTXYi4Hg5AJ8t8hq
	GxmcE0iwrIBrUjBiG2HuZIOn7JfLgcXWTLxLTNtY1xGcmpmkkjN5uUjS5W4o0VsB679HGE+tSJE
	N2LnMJ8y+pDIDz3ZyObNZ3nq1Is3vqN1mSrbOHr2S9C7o7RfeFGyswOBpyeWEbyyNICY=
X-Gm-Gg: ASbGncvSDMPNP/7L0TGmH6Der6pHlAlHbOaR2ytTioWcJxvxixmSP6qPUr5wqhxdQRo
	l6qK1mG/Ih+CKqIjFK5UdKGwDLefgWTzYYyw4XAceitK9jF8YBuSq/oLEu2A5iB7WJoCjCTlkB5
	BgXAjNj93QE/cNjGVN/UHj0GjlATeSobCg42KSFFAdL2Y+oZOtIAzChpgtXqVkLgK28fh4cL3oQ
	v1XLzw69tNQd9wrWJdi5C8XN2LbD3Ef0L8wJwkUdD2oRjagOCYCO1zNzipkV3CGEzkYBjiaCzFm
	HfHL4/y41nnJPSZ4KACXl8e51eEct+xgE/JAEOjYgCZIZwgFb5L1cXXrVZb7Js1ucc6yHfR7H1O
	uSdfp5YkURkN8z2gGjA==
X-Received: by 2002:ad4:596b:0:b0:70d:6de2:1b32 with SMTP id 6a1803df08f44-70d9723e3d8mr27746946d6.62.1755853516768;
        Fri, 22 Aug 2025 02:05:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxMWfBZW68IB/KZovde+NRVxhgZvhNidsma5/daN4tO/i9zHYH0AJAj9sHGZxcIBJB4AMYUw==
X-Received: by 2002:ad4:596b:0:b0:70d:6de2:1b32 with SMTP id 6a1803df08f44-70d9723e3d8mr27746106d6.62.1755853515855;
        Fri, 22 Aug 2025 02:05:15 -0700 (PDT)
Received: from [10.207.49.70] (84-253-220-51.bb.dnainternet.fi. [84.253.220.51])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3340a48b46bsm32794951fa.36.2025.08.22.02.05.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 02:05:15 -0700 (PDT)
Message-ID: <d4e1f836-afbb-4cc7-a5fd-fa961e3203ec@oss.qualcomm.com>
Date: Fri, 22 Aug 2025 12:05:15 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/14] phy: qcom: qmp-usbc: Add DP-related fields for
 USB/DP switchable PHY
To: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
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
 <20250820-add-displayport-support-for-qcs615-platform-v3-5-a43bd25ec39c@oss.qualcomm.com>
 <7b6utbnibia767bp55vhvg6ghdavb66ubdpabyguohuwtmz3mp@unvm36jttota>
 <8922ae6e-9be6-49f7-ac84-d4a1dd60421b@oss.qualcomm.com>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <8922ae6e-9be6-49f7-ac84-d4a1dd60421b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=I4c8hNgg c=1 sm=1 tr=0 ts=68a832cd cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=JdIsBVl79nXNK9flUcZCTw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=G97a9vFw7kLByEIGoT4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: 7-MXdqAT0p1LL9fPF_e72r-XeUO6wSph
X-Proofpoint-ORIG-GUID: 7-MXdqAT0p1LL9fPF_e72r-XeUO6wSph
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX0A/X/PZE7/33
 3AtFWIr7hhmRmbosNCCO+LMxLfEwg5c8BlPVvDfu8H3l1dMBRoxdmzIS4Whjv4lvMINVD1FR6Kf
 VYnOSE6cpQsI3ZgTNdsZU0LSGKkUeicAYJYzuQlx58wOod2ALGKx/cE6s8MHekFp599pNc5UoRO
 ZVLUSjMOEXHgvXTmSpqq6q+rPL7CNQKspIbfXKEJQ7uHCIbdSCNFoX5mY46rbMAcE0A9Qk1MJnY
 ahOjz3A/M3jQiOknPr9pWYfDVexMVffpCKOo130/eyblb0BY6ug6+H8WK8hgk20l1YO+cqFVcLk
 DCH8SJKI8vytVgL/zg9u9sWBBM9qgn3MnlpNy4i4UheAkuC/3ii9wGwdfRrRlzcp+Iya/xBtabS
 L1BNwekG4RXsjMEjkNGAiCOKYxwxvw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On 22/08/2025 09:59, Xiangxu Yin wrote:
> 
> On 8/20/2025 7:47 PM, Dmitry Baryshkov wrote:
>> On Wed, Aug 20, 2025 at 05:34:47PM +0800, Xiangxu Yin wrote:
>>> Extend qmp_usbc_offsets and qmp_phy_cfg with DP-specific fields,
>>> including register offsets, init tables, and callback hooks. Also
>>> update qmp_usbc struct to track DP-related resources and state.
>>> This enables support for USB/DP switchable Type-C PHYs that operate
>>> in either mode.
>>>
>>> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>>> ---
>>>   drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 73 ++++++++++++++++++++++++--------
>>>   1 file changed, 55 insertions(+), 18 deletions(-)
>>>
>>>   
>>> +	struct regmap *tcsr_map;
>>> +	u32 vls_clamp_reg;
>>> +	u32 dp_phy_mode_reg;
>>> +
>>>   	struct mutex phy_mutex;
>>>   
>>> +	struct phy *usb_phy;
>> Should be a part of the previous patch.
> 
> 
> Ok, will move usb_phy rename to patch 'Rename USB-specific ops',
> 
> then shall I need drop the |Reviewed-by| tag in that patch since it will change?

Depends on the amount of changes.

-- 
With best wishes
Dmitry

