Return-Path: <linux-kernel+bounces-745804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7392CB11EFD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A72777BDB09
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E34F2EBB80;
	Fri, 25 Jul 2025 12:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kUZpjctD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA83134BD
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 12:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753447544; cv=none; b=uMs6CXjTEfrcM4i7BUpQzqrRM9mAw93yaboj7fil26kaBsYY7ACUBdCh1xIKdDTHefm1nPRQ9JEw0F0GRe8xoE2zg+XyAP5nCO0q3Nwjy8ZCUB9drnNZUzkLoWRKb6if26TEC7bEXzs38y6ufewldt1iqEt5/IGXEFF+zyTcbaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753447544; c=relaxed/simple;
	bh=QbTw8SJUtfP777UsDGFoqMnCn6JvOeRYHiQ5q8JZcsI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mbRzkZriQonkfAUH0pesKcOL477GLedcC/zXlhmc7tX+ZpOeP0vruuH4MTsLGTEr1C7j3qShTHka9EOOlAlqnrwicB+i6NQRQShH7V77p8S6L6/OeM1+fPpGDZYUXeUmUEQUmuwbY0Abodzf5jpMk7m9C7nHoBpmgq7eJ9tzGmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kUZpjctD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P9AOeq018948
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 12:45:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0Ti6JBDX7nM+D4zJHf8kiJnbDj8pg05R7/KSmm41Raw=; b=kUZpjctDqkxBfvad
	j96F8rk5gl0uWY8j4DzKunEAA4aRD4nepQTQFjQlezvZm27C5MPY6kF2ioaMxTJa
	IbIiWdwecMSiAfIrjFUha51L9cRgPTV9mQqKUeHaov2dPTvcjRfxeQupEqMbmMv6
	Bw0LBAX09XPjdXi3aD2PicxTYBx+eg1yQ3vNwooki0Hl9RWTvTGk15LOPYtxdHwA
	2qDUeQtnvNlhIzgeODSVXE7rU2HJwGpLoRKRNaFTE1tENfDWbGo5qKpAxpaRkmas
	A4Zy66as0OM0g6XB1egbDg8GnUhsLJWmaAbHwqbChB01u7TRC5gU7/Jot1m1WTot
	Cf33pQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483w2s23a4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 12:45:41 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6fac0b29789so3049886d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 05:45:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753447540; x=1754052340;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ti6JBDX7nM+D4zJHf8kiJnbDj8pg05R7/KSmm41Raw=;
        b=D4zrD1Gt4EaVlZ0wcq17XkOwLWMV9/xDmfZahwkLsy4Wr5yFAPjfmbcm8guDlrUU7o
         +QucPqucd8Be/kZvWE9Yrna8ywcvavuHz7xDH3cDJDDNNkNVU0i/uA/zVirxpjZi7ttY
         2DKOBPjPGLPykk/Y+XZOsNkxfEQ1ut4FvedY0ub+LpodmyjT5U7CioSWGInL4Cqhfudc
         45XBRJnTCabV4pcZG0TU5jQ+qMB9ExPWg7SCNQD6UzrCXMNxRo20qd3B0DqQTgjmVxQJ
         LmFSf2k+bO6SFazb0b3gejEG2XYAjPne+zS1ad9qVRX1WwfLgYcVXmSbG2BnhdV33WbJ
         nqRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwy9zBrrWZuPg+UvQyilXC2m0nq5L0pgXF4AXlNIk9sxhdP6DxArpGQSrBJ+X7tIbflZqM6A7O1JtA2lQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLWGaeKAzfTP7AdLPeWYf4a1cFn+Kk95Jw7lagS+LuCXdruPf8
	t6fxZ3b8P4LsMUoWS3aGvSKecMJnBzsY3PMsKONYx3AydjwynU1WvHKQp7E7Uo7MWFj5ZH1O0Br
	mymNXVCUem6WsZsTCXsgkpnjunJk/qfWn3pkQZM5mdVB0tpaT3DgjBZV8QIXpPBTF+ZU=
X-Gm-Gg: ASbGncupHAfz9doxeY2y7xaaRlh2faBEImFuFUqqzzdSlOgfEiJ6wLjyG7pK3+ckyZw
	lZDnxsqpDisUJRHI/4xv5N3h2aTzrlAr16MtOGjnCiRnfdKr9x2t00Md+KrTqXmh6WMgTg40oIe
	Ogm5OzVXgZbXjFZ2jqekILzjRUzDL1TLm6K9qTPy2OsHyy0QAyBS873l05YPew6ItYmbdUVvYDr
	8ukRCGEVsG/b+CcvS6EDDBEk8tkyWBZr6e4Spp6WnfK4KYj+WxlmQm8m0qwfwqvExnj5Jacb8/f
	47jU5y+eIJYKSXagTnzxiA19U5czz993j66ANTW5WZv381lmmlodwCgYB38GG6Vpt7thIhyitjm
	6UxJ1R+P3Ut2eYbTyyQ==
X-Received: by 2002:a05:620a:284c:b0:7e3:297d:ec32 with SMTP id af79cd13be357-7e63bfc3749mr78312185a.10.1753447540330;
        Fri, 25 Jul 2025 05:45:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfLV1ZY39q/r+UCCQN6SW6T2ISL2r6UJg3mQuEZwzTcICCrxo2zw3qZqg9ajzuJjSd2TQxHg==
X-Received: by 2002:a05:620a:284c:b0:7e3:297d:ec32 with SMTP id af79cd13be357-7e63bfc3749mr78309285a.10.1753447539691;
        Fri, 25 Jul 2025 05:45:39 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af479228a3fsm271198866b.0.2025.07.25.05.45.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 05:45:38 -0700 (PDT)
Message-ID: <353b1b08-a57a-4f29-abc5-8d6e36b3190b@oss.qualcomm.com>
Date: Fri, 25 Jul 2025 14:45:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] leds: flash: leds-qcom-flash: update torch current
 clamp setting
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
To: fenglin.wu@oss.qualcomm.com, kernel@oss.qualcomm.com,
        Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
        Fenglin Wu <quic_fenglinw@quicinc.com>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250725-fix-torch-clamp-issue-v1-0-4cf3ebaa4c67@oss.qualcomm.com>
 <20250725-fix-torch-clamp-issue-v1-1-4cf3ebaa4c67@oss.qualcomm.com>
 <fb79df7b-1c7b-4085-9f12-35b7cd56bb87@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <fb79df7b-1c7b-4085-9f12-35b7cd56bb87@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: XL_yBVvoSImiK6mip4BMUvq2EiH8psLz
X-Authority-Analysis: v=2.4 cv=IZyHWXqa c=1 sm=1 tr=0 ts=68837c75 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=Vp3g0LN821RPyLkq7IwA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: XL_yBVvoSImiK6mip4BMUvq2EiH8psLz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDEwOCBTYWx0ZWRfX+t1vxz3pTjhr
 yviZsjyHZpv03x05srI7bMbfLSb0anqM+meB78YScgsCCohm6No9CfA2nZVD/s9sapvJX3sC7Ey
 WOmGR+iVNh7uUpugPvoCg9k+MspjwxVbn7PWseod5Eo5oDAldVnCCNP3780l9XsQt8tdKhoI0IW
 0QJlX5DJQPouiWG7L3BSc7yhzg1dVW/ss/NxWVpE75+UiQfCseNrCEcZrwgzYx5uxkUf2MT6Yyx
 RcEkv56DycmsdFqCJsuzc3L9jUJYIqZeimaJvIsMoVBtdzyWfHbwKhqZwCOmwv4tXQdiEvh+a4+
 z3ioa+gsS/NBn6dk7pf3VIZfQxSuTbzmQ2iM0MdbziYEHyvJZx5d397ko0MsbCE6gqVifTQba9P
 OhMQ542Nt1jRhuHPMtNVwt31MTVFGGbFDq9xQbXHqUY9SGXX3qkDHBnlNQV0Q3MKKEwxqOwp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507250108

On 7/25/25 2:37 PM, Konrad Dybcio wrote:
> On 7/25/25 12:04 PM, 'Fenglin Wu via B4 Relay' via kernel wrote:
>> From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
>>
>> There is a register to clamp the flash current per LED channel when
>> safety timer is disabled. It needs to be updated according to the
>> maximum torch LED current setting to ensure the torch current won't
>> be clamped unexpectedly.
>>
>> Fixes: 96a2e242a5dc ("leds: flash: Add driver to support flash LED module in QCOM PMICs")
>> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
>> ---
>>  drivers/leds/flash/leds-qcom-flash.c | 16 +++++++++++++---
>>  1 file changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/leds/flash/leds-qcom-flash.c b/drivers/leds/flash/leds-qcom-flash.c
>> index 89cf5120f5d55bbb7e24faa8c3a946416f8fed46..9c2e41cfddcf2d50d5a633cb157084371a631d74 100644
>> --- a/drivers/leds/flash/leds-qcom-flash.c
>> +++ b/drivers/leds/flash/leds-qcom-flash.c
>> @@ -1,6 +1,6 @@
>>  // SPDX-License-Identifier: GPL-2.0-only
>>  /*
>> - * Copyright (c) 2022, 2024 Qualcomm Innovation Center, Inc. All rights reserved.
>> + * Copyright (c) 2022, 2024-2025 Qualcomm Innovation Center, Inc. All rights reserved.
>>   */
>>  
>>  #include <linux/bitfield.h>
>> @@ -111,6 +111,7 @@ enum {
>>  	REG_IRESOLUTION,
>>  	REG_CHAN_STROBE,
>>  	REG_CHAN_EN,
>> +	REG_TORCH_CLAMP,
> 
> This is not the name of this register on at least PM8150L
> 
>>  	REG_THERM_THRSH1,
>>  	REG_THERM_THRSH2,
>>  	REG_THERM_THRSH3,
>> @@ -127,6 +128,7 @@ static const struct reg_field mvflash_3ch_regs[REG_MAX_COUNT] = {
>>  	REG_FIELD(0x47, 0, 5),                  /* iresolution	*/
>>  	REG_FIELD_ID(0x49, 0, 2, 3, 1),         /* chan_strobe	*/
>>  	REG_FIELD(0x4c, 0, 2),                  /* chan_en	*/
>> +	REG_FIELD(0xec, 0, 6),			/* torch_clamp	*/
> 
> Please keep it sorted by address
> 
> 
>>  	REG_FIELD(0x56, 0, 2),			/* therm_thrsh1 */
>>  	REG_FIELD(0x57, 0, 2),			/* therm_thrsh2 */
>>  	REG_FIELD(0x58, 0, 2),			/* therm_thrsh3 */
>> @@ -142,6 +144,7 @@ static const struct reg_field mvflash_4ch_regs[REG_MAX_COUNT] = {
>>  	REG_FIELD(0x49, 0, 3),			/* iresolution	*/
>>  	REG_FIELD_ID(0x4a, 0, 6, 4, 1),		/* chan_strobe	*/
>>  	REG_FIELD(0x4e, 0, 3),			/* chan_en	*/
>> +	REG_FIELD(0xed, 0, 6),			/* torch_clamp	*/
>>  	REG_FIELD(0x7a, 0, 2),			/* therm_thrsh1 */
>>  	REG_FIELD(0x78, 0, 2),			/* therm_thrsh2 */
>>  };
>> @@ -156,6 +159,7 @@ struct qcom_flash_data {
>>  	u8			max_channels;
>>  	u8			chan_en_bits;
>>  	u8			revision;
>> +	u8			torch_clamp;
>>  };
>>  
>>  struct qcom_flash_led {
>> @@ -702,6 +706,7 @@ static int qcom_flash_register_led_device(struct device *dev,
>>  	u32 current_ua, timeout_us;
>>  	u32 channels[4];
>>  	int i, rc, count;
>> +	u8 torch_clamp;
>>  
>>  	count = fwnode_property_count_u32(node, "led-sources");
>>  	if (count <= 0) {
>> @@ -751,6 +756,12 @@ static int qcom_flash_register_led_device(struct device *dev,
>>  	current_ua = min_t(u32, current_ua, TORCH_CURRENT_MAX_UA * led->chan_count);
>>  	led->max_torch_current_ma = current_ua / UA_PER_MA;
>>  
>> +	torch_clamp = (current_ua / led->chan_count) / TORCH_IRES_UA;
>> +	if (torch_clamp != 0)
>> +		torch_clamp--;
> 
> In case anyone's wondering, ((1<<6) + 1) 4 * 5000 == 1280000 which we set
> on some (all?) devices

Scratch "the + 1", I had both the width of the field and its max
value in mind.. the rhs still matches..

Konrad

