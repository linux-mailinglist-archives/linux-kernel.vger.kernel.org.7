Return-Path: <linux-kernel+bounces-871047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 297DBC0C528
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F9294F2B2F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630842749D6;
	Mon, 27 Oct 2025 08:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nNzumApB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3174E3C33
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761553925; cv=none; b=S0tRBRC2+GMbOcT0u/J6LlTX5lDPegZcz/h3X54dunbNOpzliD470jfH2FbHIsneuspw88RnU2lcaDiG+0/TKU6INRL5gRfqbTFUumrKT+ynxgA4V4BOALL0uM6Z0Q9jjxNe7G5SnjSbkxF/vfvI9P01/6qdK1QYMpWONn58r+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761553925; c=relaxed/simple;
	bh=RSfpfphYkf73MtZSBd82Y1Axxx/IQ+C0kNZbF1z7ZpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g9SNbLPJFgWQZYE/zp7uvNx4SbEfrv3RZf0IRT4bEdYZwB1FISP/q/JBnR2TxrIQ68PoUmtq9sD/aWdaHGvJ5KerMC3PnNis57tOmOVpJ2Mk9g0mpAvuv4/oK6TIv6xbzRggmgmR4TYRBejMnfZe245AovlHcE+oO9r2QDCm9ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nNzumApB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59QLFRla852402
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:32:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sx63s+VEGub670xFqR/IElGnwDWu9CRZ/VDK1Eqvsfs=; b=nNzumApBBadV2W8f
	P66xcqTSanCcCCMHYJtUWYzjf2B85ip0FS+lIhm6g6sVeoLOKPpNTAgdOVUtVl6T
	nWnXoOrGV5sHHIsb5a9eoUI7GCd/03MB0ABWhs0OGLcPRASVdZ30/2JK4+fGd2Ux
	cuHwTLvstHhN77xqbjy38xNgBweO5eHOeabb5yEJFhwJTc3gSzVn5LtsaSl41pEt
	CkiEz7HuQIslr4tCgt5KEb3AGLGlasX8dKk9KISmT9dhXKIDjxZq+HhbAr40lPoo
	o/9Tm/pwom/OSDpmTKBjfICwqQlHjhh/eOENKJJnsnfhL+at1Xdwz9W38XU0v9ZK
	WOjQfQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a1ud1s8d8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:32:03 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-290992f9693so41935135ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 01:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761553922; x=1762158722;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sx63s+VEGub670xFqR/IElGnwDWu9CRZ/VDK1Eqvsfs=;
        b=kWEQgT+CWUq4aZZ8TmGd3hnA0QJiFxLEOO34rNF/MsAAzR4ZUIm031rwxDJuMrqSIU
         sNAcuZm7bpr73LaAa1qgxqTQkVe7+4gsWCnn4YdQ703wjXAzUgGkYnP/zP8rWl2JqUwz
         GEU4RxEPFoyJg/8Oh7EmJC7jsgnm4P61IueAUyQDKVA0eSuNdvEcRMtpIUY0iHM0gqBx
         9NRoHvvD6S4vL460hG+BBLSoXQPVM07uqPhVJFjF8Jt2OUy4CtVe3eguGZpx8M51E2hs
         hFVC10LltHxAXYwNyOzhr2Msr+w0VWvv9boL7pxrp9kzp8fq3EYnV9HwB4RwvVYs4WKn
         EjSg==
X-Forwarded-Encrypted: i=1; AJvYcCX+jOpMFFJIpJgMi0HFSpm79IcQdKyua+/a57WxgGRUrPhYHpsqvcVvaW0+GnPFwS5vgQMXnYfTzNJTxVM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7V9YQUNFoRS26ACsgbA0EXf3EshT8TEV4P7/RK2MizUShVYUb
	a4Nh8g0b6bcvGMhEsBS/bjBM4AlWOebYbiH2wdRBR2etmboAY+Rd+dMmPggCiVW3AC28B28OLzx
	zH+H246qZ1wYc8aV+879G9muS3UkgiXaFQWGnY241pI9W/LSSn/YKGZwwUIy0v79IKV3Sjg2OU2
	s=
X-Gm-Gg: ASbGncsYfCpfB9IzLIeAHRWuuJSPQE1Z07ihbldo5/EHvM+gses1YmTr+e7Scj1tAV6
	v2R3mw1k24e1odYsq9UVcfkJMJcEccin8lAI+yfPhVsaFUDw4/CoskOrNwnf7bDZzjM70MIpRoH
	Co/bp39VAbITxjdplc6Wg3U4PWoCxjy79tiVse8WRUErdvkmMWRCS2H98HtMRUn0r5xPvcdBv70
	t1w41Dcu1jSnpZaXv9gjaKS1oew/+xCJiAUo8uQTfK0JhQWxDJZjdw83mcfU90jgdC2XuOLpHKe
	S3Jrh/Zwv8CMDWnUncb0nJ5IZ7ObSx1Oe4TpSEPM5RnVQ0v+Td5CWVo8sfpURFSBUMP9sxH7lPD
	XXQ+eLADx7sY2ipeczUSTkOg7DTYd/oGB
X-Received: by 2002:a17:903:185:b0:269:8ace:cd63 with SMTP id d9443c01a7336-29489e773fcmr141431395ad.30.1761553922370;
        Mon, 27 Oct 2025 01:32:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0XF2U4phwBqiDvn2bL/HXA0I40/tXYhgsNsdk2eMlASGSo5k9irm8PXwBWuFXZfmiIvaHag==
X-Received: by 2002:a17:903:185:b0:269:8ace:cd63 with SMTP id d9443c01a7336-29489e773fcmr141431075ad.30.1761553921898;
        Mon, 27 Oct 2025 01:32:01 -0700 (PDT)
Received: from [10.218.1.199] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d2903csm72918725ad.63.2025.10.27.01.31.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 01:32:01 -0700 (PDT)
Message-ID: <e4ebf454-93ae-47be-bb12-2ab363812b1b@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 14:01:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] dt-bindings: usb: ti,hd3ss3220: Add support for
 VBUS based on ID state
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20251027072741.1050177-1-krishna.kurapati@oss.qualcomm.com>
 <20251027072741.1050177-2-krishna.kurapati@oss.qualcomm.com>
 <TY3PR01MB113460779967E7BC8FEE11DEF86FCA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Krishna Kurapati PSSNV <krishna.kurapati@oss.qualcomm.com>
In-Reply-To: <TY3PR01MB113460779967E7BC8FEE11DEF86FCA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA3OCBTYWx0ZWRfXxFOA+1nWwIRf
 Nc09AuQfzxkO4s9Yuq/eZKiMVlUbkKLl3jMCHayZ84XHLtzU2N1QyedH0T6W7BRfk/qgF3mKpge
 MCK4AN5zSCwSFRaiTzH61lbRkoTZwVO/jnKRBYq/HsyvQXO49vlJBDpjbXQ6UNPowyW8Rn/Xt6j
 3cen86qDlL/yo7+p4sJhZEWWBT0cDMISelywap+0/RKU+kASUWR39hKNyNNe0Cu60b6inoDQI7A
 kE4t/aWuVmXLQze6S2NzvDOhzHtIZGSyt0Oyj5M3cGtZmfglqeOMkVaOAfCvd98tyZwuT0qY3Hb
 AbrYddZKd+MulMi2jxOyyhXSMWA+KfNCM9oCkA8Ad5NwWlareRwN6Us3NfBiNYOofR4SQLec4nY
 jEA1zTk8XhpV3jns8/wG+7G+nw9zPA==
X-Proofpoint-GUID: A_WHNz5MtmOh0_rPDmw5WxC2gTUhHLHd
X-Proofpoint-ORIG-GUID: A_WHNz5MtmOh0_rPDmw5WxC2gTUhHLHd
X-Authority-Analysis: v=2.4 cv=UqNu9uwB c=1 sm=1 tr=0 ts=68ff2e03 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=uVO98WeOcy1yjMVTFfcA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510020000
 definitions=main-2510270078



On 10/27/2025 1:02 PM, Biju Das wrote:
> 
> 
>> -----Original Message-----
>> From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
>> Sent: 27 October 2025 07:28
> .kernel.org; linux-kernel@vger.kernel.org; Krishna
>> Kurapati <krishna.kurapati@oss.qualcomm.com>
>> Subject: [PATCH v5 1/2] dt-bindings: usb: ti,hd3ss3220: Add support for VBUS based on ID state
>>
>> Update the bindings to support reading ID state and VBUS, as per the
>> HD3SS3220 data sheet. The ID pin is kept high if VBUS is not at VSafe0V and asserted low once VBUS is
>> at VSafe0V, enforcing the Type-C requirement that VBUS must be at VSafe0V before re-enabling VBUS.
>>
>> Add id-gpios property to describe the input gpio for USB ID pin.
>>
>> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
>> ---
>>   Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml
>> b/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml
>> index bec1c8047bc0..06099e93c6c3 100644
>> --- a/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml
>> +++ b/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml
>> @@ -25,6 +25,14 @@ properties:
>>     interrupts:
>>       maxItems: 1
>>
>> +  id-gpios:
>> +    description:
>> +      An input gpio for USB ID pin. Upon detecting a UFP device, HD3SS3220
>> +      will keep ID pin high if VBUS is not at VSafe0V. Once VBUS is at VSafe0V,
>> +      the HD3SS3220 will assert ID pin low. This is done to enforce Type-C
>> +      requirement that VBUS must be at VSafe0V before re-enabling VBUS.
>> +    maxItems: 1
>> +
> 
> Maybe to help DT users, add an example for this use case??
> 
Hi Biju,

  Adding GPIO to dt is a generic thing. Also this is an optional 
proprety. Can we skip adding an example.

Regards,
Krishna,

