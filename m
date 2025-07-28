Return-Path: <linux-kernel+bounces-747359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 617E7B132F1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 04:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67E5318958F8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 02:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFC61E6DC5;
	Mon, 28 Jul 2025 02:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IlmXr5nd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17E51DE2AD
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 02:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753669635; cv=none; b=l3N17hRwyFP6kdbFGeg0UbXLr3ePQI7XUD1dM/ruEKF0A2pk39UAHSqLIXh1NzKQsMRbMxMi7RUwhVFW0pmxUheJd5lQoTEWHLRjaeHSsUch7MFIzZPEiqhkIG4Fcs0mu/lJt6BWEWkh4jFXdCjDlbBeySdNAB0FC+DshJKGoDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753669635; c=relaxed/simple;
	bh=TDNNE8kLWoaqDvl0HrsSokxjegNquj7Qcvi9WmjNkKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pLOwBd6yu8R2VKsAmV6br5nFrwAFgQKlR17rGg1sw0UceBgEC4WJWfzDbDcGTg3DMg/V8uvIQE+oTCxqppLIMqw68L8QwXTFRE4QhrswjJ+hLhFarQhXydCccapW61BtIeYuvJzAWu9Ty1EaV0u/Uqlnj/SCj77hAUrAYT/ppB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IlmXr5nd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56RMrdPK018053
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 02:27:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xxnnDu5M7jCNHq7v1GM6s5NrgTWX4qsvmE046sHg2u4=; b=IlmXr5ndPyg31XsO
	plsjtpCP2fDWjaX6GBxG3EnwwK7+gHBWyKo1M2Xx7dcGnoR4Vf9DQOd2ld/4zO8u
	S2ZKbuSo4vRVFaRDRBjeq9mujB0PQrs0wZ28PsLoUQ/gltAE4tsw2nnrbinBYU3Q
	N9NpuDuIU3tz25uYyqd0xwnMsEQRcPGxzyZz7k5lNQJKYlnSu+3EJnCN1cJk32Xr
	S78i//kVJvKsUYvLzLdg1fq1KmpAThfRx+WpM5E44n+q/E63/5lk24mYdFqVddT3
	VIbxaVZpsxWFWl/O4HEYndKd1p9IkbvAkN8Xcx8KCwohgeGJtnGNUNyCBhho3GJO
	I/dEFA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 485v1x8ahd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 02:27:12 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b3bde4d4d5cso2973636a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 19:27:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753669632; x=1754274432;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xxnnDu5M7jCNHq7v1GM6s5NrgTWX4qsvmE046sHg2u4=;
        b=h1pM0lPRm0hL8g+6Jo2oqgxj4XPQE8R6LB1UYDXMgTAdQCZNV0XTqXoncmGQNT+01n
         wl8jJs6FD2YhQrWlpPdAoAxJO35llpRdz3Swurw76hZ5jConbliakaxWAAbsFCzJuvxW
         Sng72hYmMdm13Y0GrCws5Z5PNnoqpNLyVQWQSf889SFYSb2mmjGW84dLf5m1nfG5SBkM
         BAtUwzU+s5/O2i58HmNhMfb9B2FpUWpl7b3v75BS2bLYmXQh72qQW3cxtBQqQG1k7jvJ
         T19Y3yjQ7SFz90umcHvfwwHXcqFlfrnbJBP30IwYNhyLbVDWQo97L7BkrzorIbVrmtsR
         EIJg==
X-Forwarded-Encrypted: i=1; AJvYcCX1yF/dsdzebB3Qz3AaJsFJVMqwclVlk5EWtjz9CyUwhRla4EfXFXrpodubE+zmBjFCkML7OOg2AVfxrBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIaMOu98uko/F8yee9/VqihvyarJu507lWTnc3aedKqlqaayJL
	0vcQh/Pldf2C35DtjzdfeIMjML2u3HepTrpd1hJaVqwfqAAho/YjmVz257dQWFi8d59DfzmFPYd
	pLRXIn9QZpYylfrhtmxtrNwk0iIINItnRJyyzDOH/RR4QFxXXsgUhVZh19ZU524LpIGs=
X-Gm-Gg: ASbGncuUwm01mrbEqbuKmPRX9VEAZBU+0jM1M0Mzqal8/WBMl9W0pbEUbyylRx+dpYP
	BSZupTmWryTdbyQsN4N4jWI05IoQ9QVv7YPMB4igLd2rwKto88Ydf6SojzUNixFSuKZgjy9d1uK
	chATDeEZ4TK7kzei0VJZcjDdrEixu7CijEhct1AmnSwj5f7oAiPovBnZzZwYr7mROrtkpoaTqWK
	ApUKW5E7qe3jrKKaiP7cnF5ZMPhCVe2dvN02/G1nfYgDsU87Se8uVarmWRyunM7DIrVFs4J6TBq
	c0AlnrmNXX7+SQ6DfkpGNR1pRF32zTpMuSVMAZYB4rselFRNm+aDsA0XzJCPKDbbx2VQrKUU3yR
	fjvOdW4XrJyMQSubwHQYpQg==
X-Received: by 2002:a05:6a20:6a10:b0:220:82c7:309c with SMTP id adf61e73a8af0-23d700530damr16725383637.7.1753669631933;
        Sun, 27 Jul 2025 19:27:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1TYV05TAbYf0Mn8FQUW8ymE6il92dGhFdjqipkgdv9WjaAwbfX4QISLwpca7BCrJRR2sf6A==
X-Received: by 2002:a05:6a20:6a10:b0:220:82c7:309c with SMTP id adf61e73a8af0-23d700530damr16725340637.7.1753669631325;
        Sun, 27 Jul 2025 19:27:11 -0700 (PDT)
Received: from [10.133.33.111] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640b2dbbc2sm3923978b3a.95.2025.07.27.19.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Jul 2025 19:27:10 -0700 (PDT)
Message-ID: <f4f46e92-3d49-4bcf-a23e-223c758f56e9@oss.qualcomm.com>
Date: Mon, 28 Jul 2025 10:27:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] leds: flash: leds-qcom-flash: update torch current
 clamp setting
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, kernel@oss.qualcomm.com,
        Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
        Fenglin Wu <quic_fenglinw@quicinc.com>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250725-fix-torch-clamp-issue-v1-0-4cf3ebaa4c67@oss.qualcomm.com>
 <20250725-fix-torch-clamp-issue-v1-1-4cf3ebaa4c67@oss.qualcomm.com>
 <fb79df7b-1c7b-4085-9f12-35b7cd56bb87@oss.qualcomm.com>
Content-Language: en-US
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
In-Reply-To: <fb79df7b-1c7b-4085-9f12-35b7cd56bb87@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDAxNiBTYWx0ZWRfX9aEbr8qSWxv9
 2/CyM1Pg/j9H4SGrqE342Zu0A8BnJvfgfBxBOFVVRXYnprV4LyJtnGretLg0tVJvKl9hC5inzbO
 ffv1Fo68IQMkLMgEExbLkAT6joDXBtNMp3k6RRkgZahZ6qMrvVF+r6jH+8DGdz4Cp0XtD0XhoOA
 zDff2RIjW2HBRXoBo9K3+mXItdwTQlL7Pw4UXjUejREbPAYyLAy3rxL6ACEa9sUghDBYQVkkdZS
 58qlcilkzkx9g1sLe7nRajbWJtvma7NVMLFdgIfP4FAyfZX+0uGHLYLE9GQ/7evBwvMIumVS8Uh
 3g5OuGn2vc5Rw/v+bcbXvHBroY96Qe3gllQ520rnZKYaOtrDikvJGjSYAAWIXHWgQRscBEs0yUA
 Z3Vv+IU/EK239aaTHdIrLBZTW/kMhPsH+ND2ob5wWrjr5KtwGCnQlE7T+cr4Vz3Tgx1V0TNs
X-Authority-Analysis: v=2.4 cv=JKw7s9Kb c=1 sm=1 tr=0 ts=6886e000 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=lsAvw-e0HvHL9ToLdg8A:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: 9Tln-KixjfLtFZ2gXXC6QznqTLGVwLVd
X-Proofpoint-GUID: 9Tln-KixjfLtFZ2gXXC6QznqTLGVwLVd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_01,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507280016


On 7/25/2025 8:37 PM, Konrad Dybcio wrote:
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
>>   drivers/leds/flash/leds-qcom-flash.c | 16 +++++++++++++---
>>   1 file changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/leds/flash/leds-qcom-flash.c b/drivers/leds/flash/leds-qcom-flash.c
>> index 89cf5120f5d55bbb7e24faa8c3a946416f8fed46..9c2e41cfddcf2d50d5a633cb157084371a631d74 100644
>> --- a/drivers/leds/flash/leds-qcom-flash.c
>> +++ b/drivers/leds/flash/leds-qcom-flash.c
>> @@ -1,6 +1,6 @@
>>   // SPDX-License-Identifier: GPL-2.0-only
>>   /*
>> - * Copyright (c) 2022, 2024 Qualcomm Innovation Center, Inc. All rights reserved.
>> + * Copyright (c) 2022, 2024-2025 Qualcomm Innovation Center, Inc. All rights reserved.
>>    */
>>   
>>   #include <linux/bitfield.h>
>> @@ -111,6 +111,7 @@ enum {
>>   	REG_IRESOLUTION,
>>   	REG_CHAN_STROBE,
>>   	REG_CHAN_EN,
>> +	REG_TORCH_CLAMP,
> This is not the name of this register on at least PM8150L
The register is referred to as 'TIMER_DISA_MITIGATION_CLAMP' in the 
documentation. 'TIMER_DISA' indicates the flash module operating in 
torch mode. We can remove 'MITIGATION' to create a shorter name for the 
enum.
>
>>   	REG_THERM_THRSH1,
>>   	REG_THERM_THRSH2,
>>   	REG_THERM_THRSH3,
>> @@ -127,6 +128,7 @@ static const struct reg_field mvflash_3ch_regs[REG_MAX_COUNT] = {
>>   	REG_FIELD(0x47, 0, 5),                  /* iresolution	*/
>>   	REG_FIELD_ID(0x49, 0, 2, 3, 1),         /* chan_strobe	*/
>>   	REG_FIELD(0x4c, 0, 2),                  /* chan_en	*/
>> +	REG_FIELD(0xec, 0, 6),			/* torch_clamp	*/
> Please keep it sorted by address
I need to keep the 'therm_thrsh1/2/3' register fields at the end of this 
array because 'mvflash_4ch_regs' doesn't include a 'therm_thrsh3' 
register. Placing the 'therm_thrshx' registers in the middle would 
require creating a placeholder, which I couldn't figure out how to do 
effectively. Do you have any suggestions?
>
>
>>   	REG_FIELD(0x56, 0, 2),			/* therm_thrsh1 */
>>   	REG_FIELD(0x57, 0, 2),			/* therm_thrsh2 */
>>   	REG_FIELD(0x58, 0, 2),			/* therm_thrsh3 */
>> @@ -142,6 +144,7 @@ static const struct reg_field mvflash_4ch_regs[REG_MAX_COUNT] = {
>>   	REG_FIELD(0x49, 0, 3),			/* iresolution	*/
>>   	REG_FIELD_ID(0x4a, 0, 6, 4, 1),		/* chan_strobe	*/
>>   	REG_FIELD(0x4e, 0, 3),			/* chan_en	*/
>> +	REG_FIELD(0xed, 0, 6),			/* torch_clamp	*/
>>   	REG_FIELD(0x7a, 0, 2),			/* therm_thrsh1 */
>>   	REG_FIELD(0x78, 0, 2),			/* therm_thrsh2 */
>>   };
>> @@ -156,6 +159,7 @@ struct qcom_flash_data {
>>   	u8			max_channels;
>>   	u8			chan_en_bits;
>>   	u8			revision;
>> +	u8			torch_clamp;
>>   };
>>   
>>   struct qcom_flash_led {
>> @@ -702,6 +706,7 @@ static int qcom_flash_register_led_device(struct device *dev,
>>   	u32 current_ua, timeout_us;
>>   	u32 channels[4];
>>   	int i, rc, count;
>> +	u8 torch_clamp;
>>   
>>   	count = fwnode_property_count_u32(node, "led-sources");
>>   	if (count <= 0) {
>> @@ -751,6 +756,12 @@ static int qcom_flash_register_led_device(struct device *dev,
>>   	current_ua = min_t(u32, current_ua, TORCH_CURRENT_MAX_UA * led->chan_count);
>>   	led->max_torch_current_ma = current_ua / UA_PER_MA;
>>   
>> +	torch_clamp = (current_ua / led->chan_count) / TORCH_IRES_UA;
>> +	if (torch_clamp != 0)
>> +		torch_clamp--;
> In case anyone's wondering, ((1<<6) + 1) 4 * 5000 == 1280000 which we set
> on some (all?) devices
>
> Konrad

