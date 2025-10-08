Return-Path: <linux-kernel+bounces-845344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F60DBC485C
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 13:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2BE1F4EA38D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 11:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483431D95A3;
	Wed,  8 Oct 2025 11:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZSXCnHEA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB6824679F
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 11:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759922116; cv=none; b=nJ8Sht2TzhEmWwKdxVqwDJx5Dk9FSDQiMHaCkD2RL13CPV9pWNo5U2YaWkOpWU4YYxUP10Vc1b957HNPuLOgEjHBFmKgB2Hcr40rkTYX/mSZxA5mDbtxwRAN8cA6hvY9TWCKbClo6aZo9bzbzl3Ide34o5pFkkn0600fRZ1I+E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759922116; c=relaxed/simple;
	bh=wWnVyzijTaXYM8xRXWXruZLI0i53tO5UZxS0bwONy4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WkAoiNOPgBwcCPRGxy5BQEI3m3g38Uywqj2ug8g5iiK64ppslLMS/5AQy6xA44cIJXD/IpfGUFW2om9NBMHjovXkv7CoRgzZMikGjXo8/rS1D6ptEviw65i3+ktoTHNqFKKZUrfVPuSuxaU5Mgpv+PUjXnh8rZ/X55de7lxhUmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZSXCnHEA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890OSb028818
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 11:15:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EffddiefyYfOOHaQK61w1botCVru6MZ1eFfoN02Iyrs=; b=ZSXCnHEADqmTBe4U
	0ReFXRa/SSZ7GCIiNdfSQhS7xYhfkP3PNgDdIjRoPmexk2TVhP2CoEbCJlL0xOrO
	zCwqy4mtIV8L3OV49s/dAjY6uAo6xM+XN0ydiMSlZ9nncuZ0gSbooene1sHdy42s
	9IbT3CyTOo3HBW5tEXtGuXElst0gSkPZdtvd7pRE71pF/e49qx7R7TY4z4gRFq3f
	pV92ynk10rpCygUo0j+YWTQGxeH9LHD20DihSuSzPRsK7LaJ3prUKwWPwNbLhbJF
	42k0riTdF0apM2lfTx4/38r/CgeTA7V6Pk1ylXApBWqYM9ZDQlbM92JDf+cQOy0z
	1sXtpw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49js9e2cxs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 11:15:13 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b62ebb4e7c7so3793664a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 04:15:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759922112; x=1760526912;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EffddiefyYfOOHaQK61w1botCVru6MZ1eFfoN02Iyrs=;
        b=BEJkcDL6WnuXSXebmrys1flyx2tDnZf2fLfwMVaJsPEyFq1HNTjNluW4QQ/wjQiuyA
         vzX/N6MOZLfAI45hdR9imaseH6Oje4pkgtsPLk1kjMcFV+Y7fTLYbYequASbArHEik3/
         l5iyb08l/LCA10yPoShxWNUrBTYi4fldVeIrMD0szFyb1PVRqkzKXI6ir8Y+IXpn7eoF
         NKOotTH1hvEOFFh4VGNvMeRUXQ0BThJbzJLb9gcYilSSTfsC/6hW0iDxkYJwJwwuhY+J
         G+4AJxHKVUjD4ViMGGTgYMfdA8gBeLmJc8JJ5XFMEn/j88uKr0wBUPvEdMnZggJ1NpqR
         Eucg==
X-Forwarded-Encrypted: i=1; AJvYcCXGS50oah5k2GzWs3/l5fgoFcEGK+qWUMIMAWjD5YJt4G4s9UuaeRRfq4gL/uxcYsac3V1qCLk6PVgKwyU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv1jPUlDMGC4SmfHeYEok16HDOY5IW5ss7006CHCOw0R/QqBre
	ZAN3Q4L+vHB57yH992jbtq/UhftAuQTJ0zv0AFcj+8I0i+mldIifJng9u9e5ipb+iZP+LJVxaD5
	mSMx1Am2T0PHTKcyaWqFxHe/W82xwPiIBuPbP6TsI6YzpK7mEgiqLf5hmZHU3f9KONJsOCjCPEX
	8=
X-Gm-Gg: ASbGncu3ilIDf3jzb1yyMuRjtB1AqCa6Q/YGK8DphYErGwzF0VIwYcuhvQQTsT7vLGt
	t3lBG9qV270vrPVJhQiyzt5mhyHlAQ/BRSk0GvUnbxYzHIfXLIIDfQDx8sH86ssiSMBmsYg6WuP
	bbfG+U7umD7ztesgoy3Aiblho2CmSC2fRJbjUMWC2doxe1YODybkpvOrntedWxVe9mFZn9LscQ5
	UXBy6wbB8mmzC7leIC5jrzqgONjxj80oVKDQXhRU+tb4PCqCyU12KVBEjSV9HlbnYeelQhONBbC
	QKeP3yZo3oY6gS+nJ/PxisJwS6/Ez9hA6NCqPfjMhxhIOXY7K8Xa83epqrtDHhHyAq9v6z3AEMr
	wFQU=
X-Received: by 2002:a05:6a20:72a2:b0:32b:6e33:7cf8 with SMTP id adf61e73a8af0-32da83e0614mr4191369637.42.1759922112402;
        Wed, 08 Oct 2025 04:15:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHD86ge8saAFK6qXLniY8kj2xnoyg29DHHxFtqkJCu4J95pDu9HmYbmCPGlP2aG0dKTCHvZZA==
X-Received: by 2002:a05:6a20:72a2:b0:32b:6e33:7cf8 with SMTP id adf61e73a8af0-32da83e0614mr4191337637.42.1759922111902;
        Wed, 08 Oct 2025 04:15:11 -0700 (PDT)
Received: from [10.218.1.199] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099f7ab4fsm17822615a12.44.2025.10.08.04.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 04:15:11 -0700 (PDT)
Message-ID: <1a428b7f-5d20-4d55-aa3a-e4feb580b82e@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 16:45:06 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] usb: typec: hd3ss3220: Enable VBUS based on ID pin
 state
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251002172539.586538-1-krishna.kurapati@oss.qualcomm.com>
 <20251002172539.586538-3-krishna.kurapati@oss.qualcomm.com>
 <aOZGgZc1F968uoR6@kuha.fi.intel.com>
Content-Language: en-US
From: Krishna Kurapati PSSNV <krishna.kurapati@oss.qualcomm.com>
In-Reply-To: <aOZGgZc1F968uoR6@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Hrl72kTS c=1 sm=1 tr=0 ts=68e647c1 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=JreEDKClX95j7y97460A:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: v3H6oTMJMJtS-jvDhpxj5hqtAARRw8Bz
X-Proofpoint-ORIG-GUID: v3H6oTMJMJtS-jvDhpxj5hqtAARRw8Bz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAwNCBTYWx0ZWRfXxNmgD863ADn0
 HCnVQWuJTc0wKD/cXPqdVvNu0C5TBksY+GRdcP5uVZnoUSc3apwASiOs2U36msbVUjttfhEELd8
 zZqAnyoU5PBDkI2wC/rhY9DjDepdKH/tWgEm4pVUj9kWnqhXlhhoGD3iNpTQYXjpeZs7ICGKGZx
 8pswJ7tKuUMedSRnpXh1ckd5737WByZlHaPa4BziWmmKeOYpgUPN5uIvfZSfjlgbdFBxctIiAkF
 Oz5SzRUwZA5avHk45kPhkP7RPgi/mjhj6pTTebs2KJ1L+TuxPVB0cdtafUYSprnA4aH+R3QvYTW
 IL6HWUKFkJQd3XyKW/JuM0Bhi3Ls6pqMqbKGcQrTkDd6qCO+J8ICZm3F0me2z2QkVEYaevZCz11
 n91ArvMvDwgNA3ujCEDvparScaY/9A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040004



On 10/8/2025 4:39 PM, Heikki Krogerus wrote:
> On Thu, Oct 02, 2025 at 10:55:39PM +0530, Krishna Kurapati wrote:
>> Enable VBUS on HD3SS3220 when the ID pin is low, as required by the Type-C
>> specification.
> 
> There is not ID pin on Type-C connector.

There is an ID pin coming out from HD3SS3220 controller to SoC that is 
being referred to here.

> 
>> The ID pin stays high when VBUS is not at VSafe0V, and goes
>> low when VBUS is at VSafe0V.
>>
>> Add support to read the ID pin state and enable VBUS accordingly.
> 
> I'm a bit confused about this... Why can't you just check the attached
> state, and if it's DFP, then you drive VBUS?
> 

We could, but checking for DFP doesn't ensure VBUS is at VSafe0V as per 
the datasheet. So using the ID pin to enable vbus.

Regards,
Krishna,

> thanks,
> 
>> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
>> ---
>>   drivers/usb/typec/hd3ss3220.c | 58 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 58 insertions(+)
>>
>> diff --git a/drivers/usb/typec/hd3ss3220.c b/drivers/usb/typec/hd3ss3220.c
>> index 3ecc688dda82..44ee0be27644 100644
>> --- a/drivers/usb/typec/hd3ss3220.c
>> +++ b/drivers/usb/typec/hd3ss3220.c
>> @@ -54,6 +54,11 @@ struct hd3ss3220 {
>>   	struct delayed_work output_poll_work;
>>   	enum usb_role role_state;
>>   	bool poll;
>> +
>> +	struct gpio_desc *id_gpiod;
>> +	int id_irq;
>> +
>> +	struct regulator *vbus;
>>   };
>>   
>>   static int hd3ss3220_set_power_opmode(struct hd3ss3220 *hd3ss3220, int power_opmode)
>> @@ -319,6 +324,28 @@ static const struct regmap_config config = {
>>   	.max_register = 0x0A,
>>   };
>>   
>> +static irqreturn_t hd3ss3220_id_isr(int irq, void *dev_id)
>> +{
>> +	struct hd3ss3220 *hd3ss3220 = dev_id;
>> +	int ret;
>> +	int id;
>> +
>> +	if (IS_ERR_OR_NULL(hd3ss3220->vbus))
>> +		return IRQ_HANDLED;
>> +
>> +	id = hd3ss3220->id_gpiod ? gpiod_get_value_cansleep(hd3ss3220->id_gpiod) : 1;
>> +
>> +	if (!id) {
>> +		ret = regulator_enable(hd3ss3220->vbus);
>> +		if (ret)
>> +			dev_err(hd3ss3220->dev, "enable vbus regulator failed\n");
>> +	} else {
>> +		regulator_disable(hd3ss3220->vbus);
>> +	}
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>>   static int hd3ss3220_probe(struct i2c_client *client)
>>   {
>>   	struct typec_capability typec_cap = { };
>> @@ -354,6 +381,37 @@ static int hd3ss3220_probe(struct i2c_client *client)
>>   		hd3ss3220->role_sw = usb_role_switch_get(hd3ss3220->dev);
>>   	}
>>   
>> +	hd3ss3220->id_gpiod = devm_gpiod_get_optional(hd3ss3220->dev, "id", GPIOD_IN);
>> +	if (IS_ERR(hd3ss3220->id_gpiod))
>> +		return PTR_ERR(hd3ss3220->id_gpiod);
>> +
>> +	if (hd3ss3220->id_gpiod) {
>> +		hd3ss3220->id_irq = gpiod_to_irq(hd3ss3220->id_gpiod);
>> +		if (hd3ss3220->id_irq < 0) {
>> +			dev_err(hd3ss3220->dev, "failed to get ID IRQ\n");
>> +			return hd3ss3220->id_irq;
>> +		}
>> +
>> +		ret = devm_request_threaded_irq(hd3ss3220->dev,
>> +						hd3ss3220->id_irq, NULL,
>> +						hd3ss3220_id_isr,
>> +						IRQF_TRIGGER_RISING |
>> +						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>> +						dev_name(hd3ss3220->dev), hd3ss3220);
>> +		if (ret < 0) {
>> +			dev_err(hd3ss3220->dev, "failed to get id irq\n");
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	hd3ss3220->vbus = devm_regulator_get_optional(hd3ss3220->dev, "vbus");
>> +	if (PTR_ERR(hd3ss3220->vbus) == -ENODEV)
>> +		hd3ss3220->vbus = NULL;
>> +
>> +	if (IS_ERR(hd3ss3220->vbus))
>> +		return dev_err_probe(hd3ss3220->dev,
>> +				     PTR_ERR(hd3ss3220->vbus), "failed to get vbus\n");
>> +
>>   	if (IS_ERR(hd3ss3220->role_sw)) {
>>   		ret = PTR_ERR(hd3ss3220->role_sw);
>>   		goto err_put_fwnode;
>> -- 
>> 2.34.1
> 


