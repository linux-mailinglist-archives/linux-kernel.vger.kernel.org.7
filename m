Return-Path: <linux-kernel+bounces-870503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB476C0AFB7
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 19:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 443E2189F51C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 18:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA4E24DFF9;
	Sun, 26 Oct 2025 18:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hvfy2GNQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245A722423A
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 18:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761501816; cv=none; b=bseM9GB7xPZIjwdQTCsXAhg2/PkBxt4ViGUxoJ/8IzTChwMAK8TDE1lU8MgZPpnPZmyeVBI1YWjiZ617swYM1Pq2/bSuA+HDNiWtuL2WdEVAzkj6AQgRt4Swn/dcjXESwSsgk3WG/AUKfxa8PeiB2omR1PVFxfUoLC5F+Lh+vMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761501816; c=relaxed/simple;
	bh=cORcqgdcKWHgG9pVbbHOxGzCp1SD0U+vVcRQ4D4iyHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e4JBVuLUji9tDoPffWO0mzy4xF+u+lgVRMIj6SBRumdQtE/zNxqFwG7ytTuh5PTTpPsYMUvGJjsBPqEiGN8eRkrr6gXT2VJdEvzrkbxjgF6MEGe8dGP9algmhU1aD/5No6hv/ThHWkf8JkVYagpgQsTiajUuwmIGUVMSqnHle+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hvfy2GNQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59QBuho43893255
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 18:03:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZxrMFflhLeg4QntPw4Vis45Isvn21+Tev92z2ffrZmo=; b=hvfy2GNQaHhcXsCo
	6Crq4SC2k96LQJ7RLMhCFJZ0jRFG0Pl0pKYeGlR1LS9GqqpFWV3gMNsnb7RkWeyQ
	DgOtNNqjxxvzmXHqj22Vp0QLBVw6GfpAzxpNTlcYrj3gWSt/tg8jpx/XhDD6CRIk
	lyc70ZRKmPRRdc1ZjwXzNFnNx6RcPsKThKhOkjOnsOM1BEL5mqcu/FeY1YlkJvD6
	BH6qNLyTWC22qmIaOEqwA6Yyl+WEikkGorAYaLokBeMTOqegzqayGvHWPfxWbx1i
	4xHiRQgmEbYpu4F0OSg7TTg6RBDkc+RZRkgtJcLp27z7U5ky8VfmRwCzPbTJ9hnX
	nh+O9Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0pmqjc25-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 18:03:33 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2924b3b9d47so35927665ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 11:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761501813; x=1762106613;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxrMFflhLeg4QntPw4Vis45Isvn21+Tev92z2ffrZmo=;
        b=WKZ9FUmYCVyBM+kUcz0aGZRd3pdH+z4v6FOxew8F3qPcI8547NxgA2sAoJH+9+ySu2
         sN2PSKB5nHzBxMU8OCq3pY3kF6caeS8yUsCugGJPpvOsyz9JfubrSvJJNoUrcaBuw1nN
         E6OvEAxvQvDi8BgKIwwRcxsSMQsWUZ0oWzepLGBlpQ0vQkn9XkhBi1dZB6KCkwOorpgc
         jVpwt3FpNaaNwDH1PE7bIP9gWo9qwnvQDNma7UMkKU+uan+CT73wxbDEW35sV2mQ3Fm2
         L+HoFQceOhVTVqV4HZohn3edYCEoadRXL7cgWbzFKr4TU8PZlCphp11hJD0L3XBGHTth
         xc0A==
X-Forwarded-Encrypted: i=1; AJvYcCWUnU4BbRCcBpbMdMx4B4lnkl/c0Kq1Zba6pR4fHoATix7VtI6q5guXTrqwkLKVdSy/Io7TYuwAJuFtBJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhF9dax3uCGJJwiFn55pa/ip6rQwWbhlsfXNMgWXKpvK+pGon1
	dw5OGYgZB0gec/ht28vPZvlVWntCRDBH5OK/2llpBL4vLG6JAYjyMPUKGuxFJ+6uX99C284m6Mt
	Ool2Vr8q3NWxeesNpkklOsP02wjTgvsABSDyHK8FJjSlbqFkADF6PImT1cMOAUzZZTdQ=
X-Gm-Gg: ASbGncvtWtMTrl/90qrdAx/NAXktwU/kQI4TU3V6JuuKDajK3eoItKJssPZ/H3l4w/y
	y+o4Yq41BZoGeUJyKRI+QwBIi+pQ54g5C5QAcItXO7OYM/Y7VcKjjftZtbwRIFfsgPJ7MEihXTy
	SwpVEG/RX8TjHRX7a1Sf+QxT/JULXJTUZrUq5eUy4t99Czhdg8nmBOWY78BTryiL1Tl31+MtJis
	f3NgpywsNDxIK8bWn0psdYBsi/SRMX+AJKwRuIFD6OSJXv599c/+vQXEgfldhSxxwbS8dV7RA/o
	T2tE72Ryg8pKcI5FEkLRtWfUDyyxJ4Xc2CIiYaIVO0cifmik4UEkOcdU+xQ0ybkRUuATEzC4sxu
	Mkytj46VirRct/RKiukbD1PHEdImFUmAXqhQ=
X-Received: by 2002:a17:903:8c8:b0:251:5900:9803 with SMTP id d9443c01a7336-290c9cbb8a9mr440697165ad.21.1761501812697;
        Sun, 26 Oct 2025 11:03:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJRu3/mHPj8RD+WBVtrofAc2L/JstTu/NuEjFDA9FcFUaVPHjzkQlaT0MDYYLsiH2Q/0vnBQ==
X-Received: by 2002:a17:903:8c8:b0:251:5900:9803 with SMTP id d9443c01a7336-290c9cbb8a9mr440696825ad.21.1761501812087;
        Sun, 26 Oct 2025 11:03:32 -0700 (PDT)
Received: from [192.168.1.3] ([122.169.146.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d40a7esm56216155ad.70.2025.10.26.11.03.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 11:03:31 -0700 (PDT)
Message-ID: <f43d6bd9-abe4-428e-a675-32cbb9c719b9@oss.qualcomm.com>
Date: Sun, 26 Oct 2025 23:33:25 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] usb: typec: hd3ss3220: Enable VBUS based on ID pin
 state
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: biju.das.jz@bp.renesas.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com,
        krzk+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, robh@kernel.org
References: <20251025122854.1163275-1-krishna.kurapati@oss.qualcomm.com>
 <20251025122854.1163275-3-krishna.kurapati@oss.qualcomm.com>
 <9b059848-1512-457c-8437-8172e3726992@wanadoo.fr>
Content-Language: en-US
From: Krishna Kurapati PSSNV <krishna.kurapati@oss.qualcomm.com>
In-Reply-To: <9b059848-1512-457c-8437-8172e3726992@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: iqA-SE1TOnR-ubCBOsTvLRniLmNX7fYi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI2MDE3MyBTYWx0ZWRfX6nLnb3s/zQdC
 lVHINoavRFms86b4jle4i1dGh2IMppSMnWTRFTijiS1KOQufLV4sOFURPcBDw1uJw3vwK48Jdgo
 U++VX1ZbPsFLQl4cFk51EwnxJwlbzp7hv8azT6OX1NUDMTVkvFkJNAHCauiKfEx6cMs6xTF9zeq
 lqNpNyCfaZ+qVYAK60/SHO0XBx1AUA19ik9XmSSIwL06Zoe6Vn5iW84pXZOBH2huRX/GSq2jaKe
 uEB/zvT04rtOAxa99FU9qNre/38bXnv/sbaFZdPq00/9nkuNoR0nMKFecMbysnmtyhas2JfhMnE
 Aw3v9l2tdn90lQIYNCEoeHIGC8SpiqbIafmQzKENUSUxvmFFwQvL1ct/pw2AVh/NxTwoIE0+Mmi
 wFXBex63kjxDqvsR9DR+WFP8YhNe6g==
X-Authority-Analysis: v=2.4 cv=Vf76/Vp9 c=1 sm=1 tr=0 ts=68fe6275 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=os7cmxGP5G+7zi0Bb7vKnA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=StZl9DhFn1pbSIVtofEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: iqA-SE1TOnR-ubCBOsTvLRniLmNX7fYi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-26_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510020000
 definitions=main-2510260173



On 10/25/2025 7:44 PM, Christophe JAILLET wrote:
> Le 25/10/2025 à 14:28, Krishna Kurapati a écrit :
>> There is a ID pin present on HD3SS3220 controller that can be routed
>> to SoC. As per the datasheet:
>>
>> "Upon detecting a UFP device, HD3SS3220 will keep ID pin high if VBUS is
>> not at VSafe0V. Once VBUS is at VSafe0V, the HD3SS3220 will assert ID pin
>> low. This is done to enforce Type-C requirement that VBUS must be at
>> VSafe0V before re-enabling VBUS"
>>
>> Add support to read the ID pin state and enable VBUS accordingly.
>>

[...]

>> +static irqreturn_t hd3ss3220_id_isr(int irq, void *dev_id)
>> +{
>> +    struct hd3ss3220 *hd3ss3220 = dev_id;
>> +    int ret;
>> +    int id;
>> +
>> +    if (IS_ERR_OR_NULL(hd3ss3220->vbus))
> 
> I don't think it can be ERR. hd3ss3220_get_vbus_supply() forces it to 
> NULL in such a case.
>

ACK. Will make it (!hd3ss3220->vbus).
>> +        return IRQ_HANDLED;
>> +
>> +    id = hd3ss3220->id_gpiod ? gpiod_get_value_cansleep(hd3ss3220- 
>> >id_gpiod) : 1;
>> +
>> +    if (!id) {
>> +        ret = regulator_enable(hd3ss3220->vbus);
>> +        if (ret)
>> +            dev_err(hd3ss3220->dev, "enable vbus regulator failed\n");
>> +    } else {
>> +        regulator_disable(hd3ss3220->vbus);
>> +    }
>> +
>> +    return IRQ_HANDLED;
>> +}
>> +
>> +static int hd3ss3220_get_vbus_supply(struct hd3ss3220 *hd3ss3220)
>> +{
>> +    struct device_node *hd3ss3220_node = hd3ss3220->dev->of_node;
>> +    struct device_node *np;
>> +    int ret = 0;
>> +
>> +    np = of_graph_get_remote_node(hd3ss3220_node, 0, 0);
>> +    if (!np) {
>> +        dev_err(hd3ss3220->dev, "failed to get device node");
>> +        return -ENODEV;
>> +    }
>> +
>> +    hd3ss3220->vbus = of_regulator_get_optional(hd3ss3220->dev, np, 
>> "vbus");
>> +    if (IS_ERR(hd3ss3220->vbus))
>> +        hd3ss3220->vbus = NULL;
>> +
>> +    of_node_put(np);
>> +
>> +    return ret;
> 
> return 0 and avoid 'ret'?

ACK.

> 
>> +}
>> +
>>   static int hd3ss3220_probe(struct i2c_client *client)
>>   {
>>       struct typec_capability typec_cap = { };
>> @@ -354,6 +405,34 @@ static int hd3ss3220_probe(struct i2c_client 
>> *client)
>>           hd3ss3220->role_sw = usb_role_switch_get(hd3ss3220->dev);
>>       }
>> +    hd3ss3220->id_gpiod = devm_gpiod_get_optional(hd3ss3220->dev, 
>> "id", GPIOD_IN);
>> +    if (IS_ERR(hd3ss3220->id_gpiod))
>> +        return PTR_ERR(hd3ss3220->id_gpiod);
>> +
>> +    if (hd3ss3220->id_gpiod) {
>> +        hd3ss3220->id_irq = gpiod_to_irq(hd3ss3220->id_gpiod);
>> +        if (hd3ss3220->id_irq < 0) {
>> +            dev_err(hd3ss3220->dev, "failed to get ID IRQ\n");
> 
> Maybe return dev_err_probe() to log the error and simplify code?
> 

ACK.

>> +            return hd3
ss3220->id_irq;
>> +        }
>> +
>> +        ret = devm_request_threaded_irq(hd3ss3220->dev,
>> +                        hd3ss3220->id_irq, NULL,
>> +                        hd3ss3220_id_isr,
>> +                        IRQF_TRIGGER_RISING |
>> +                        IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>> +                        dev_name(hd3ss3220->dev), hd3ss3220);
>> +        if (ret < 0) {
>> +            dev_err(hd3ss3220->dev, "failed to get id irq\n");
> 
> Maybe return dev_err_probe() to log the error and simplify code?
> 
> Above, you use "ID IRQ" and here "id irq". Maybe keep the case case? Or 
> change the 2nd message that looks a copy'n'paste error to me.
> 

ACK. Will correct it.

>> +            return ret;
>> +        }
>> +    }
>> +
>> +    ret = hd3ss3220_get_vbus_supply(hd3ss3220);
>> +    if (ret)
>> +        return dev_err_probe(hd3ss3220->dev,
>> +                     PTR_ERR(hd3ss3220->vbus), "failed to get vbus\n");
> 
> Why PTR_ERR(hd3ss3220->vbus)? Should this be 'ret'?
> 
> If hd3ss3220_get_vbus_supply() fails, vbus will be NULL in all cases.
> 
> In hd3ss3220_get_vbus_supply(), if -ENODEV is returned, it is not 
> initialized yet, and if of_regulator_get_optional() fails, it is set to 
> NULL.
>

Yes, ret is better. Will change it accordingly.

Regards,
Krishna,

