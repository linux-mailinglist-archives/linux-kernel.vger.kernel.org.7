Return-Path: <linux-kernel+bounces-876029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9FEC1A6C9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 036DD358B9C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D023B357731;
	Wed, 29 Oct 2025 12:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PV8z0OSS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Eh/1i3Zu"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B6433A036
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761741013; cv=none; b=p4TiZyEfJdfBfrMFB9UzAXNLULwZD/KYmAVS7B9lSFjuXC3pEVptffNfcSIw1CXPHHLSMIG2nTvek8VdWnDQrKv+cGj28dfiAT9g2iI0bxlxqe5+usi85wwYVAovR/gyemBJ4KzeqbQe+0LAs1wDcwgx9BUX2B36CKFbRihkDxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761741013; c=relaxed/simple;
	bh=kG5m0dyjBmsIXWdS8H3YMGbeyjdHEsjIAHd68POJ7Eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jusdCRn1TN2WCt/l1CDPXoLveCOpALtUY38ZJDTAxF1cYC3V9d9/didFWbiyddGECvr6qzkr+JVAt2ObWDnofmafKU+fX3ephErGgIHG0l/v4h/Sn9DNZrKvrcoJU4c/SkfEFMiWGxjFqSa/I83K5BFgYS32C2F5YrRyKy4JaIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PV8z0OSS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Eh/1i3Zu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59TBtl7N3676878
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:30:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TMUc3tJ7ZtFekmGe/5Q8FFBOdVi1pg7gP6RmhoyB/Ls=; b=PV8z0OSS7fuvvlNo
	d7s8xqEfukZ5V7h4g5zYmaZoXaL80TPf0ipHRn/xM27wKepv6LOcP+Aq7AfU7wn0
	djbLwHYiWjEfZO/fxGy+SJVAPnJcJSb7+A2VBTlcMBSOUgly3kk4FIrwK9/JgEJW
	0vMhMZdX7jZKEuYk/d/3UKj1NIvY5U7t3O69BbH/UDSHJ8AOUZ9KHpo1kcWfuHys
	e8vynn4G3I6316tBXlXcLdRkUclTt3x3eYpHeq2wg1LY/iwc4scOZ2z0rZSawSTJ
	BYIXImBp+B5rAm4a1p+zzvtujM8T+7HmUL1pcI+mt6CvM17UgsZhvZR2ha7joFpa
	WQKvnQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a1jg2q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:30:10 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7a264d65dbeso4814575b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761741010; x=1762345810; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TMUc3tJ7ZtFekmGe/5Q8FFBOdVi1pg7gP6RmhoyB/Ls=;
        b=Eh/1i3Zu93qDmz6Dq2wttOnY9ABA0CsrOHmUeDF2B0ziXAR4+mfX8Cc/PSTWGd9D7H
         tlxCmQU9xCHjLoJ+8JQPRUN1QHD2NIDHEQP5vb+WKvy388oWYT2+rRkUnAuxFxTrZdXJ
         h0LSzBSPz9Ba8b9lMZAtC1pvme+oTDJJvNF+6+ntfWOt7R5Ajae7DRLbY4b/4WyUt92X
         RPFVWOfHxQcI6Gn7ByxNxEwHwAEW1FGM31Iq2P7pTpJW8wKQTsYhYclSGL6BuUYvCYVc
         wChVzRgSBEa1bh57R/R53FULjCStme2QsuXbgX1OMfpEyLJb0rDquAAszFFVb5XWqS8k
         9HTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761741010; x=1762345810;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TMUc3tJ7ZtFekmGe/5Q8FFBOdVi1pg7gP6RmhoyB/Ls=;
        b=R8C8IcBrepBa0LSlgqTsjVQKo0AmZse0K8YRy81zF9fr/NBjeMWOFgRlqiRtUL31el
         S/Z7pJ0C/cKDltCX0xsUIQ3Ky2xIYQkmfw9EvNLMd7KHCksaZvTPNc1dfb/UVbYpelnI
         TFuAcPeUzu0PdG7HUPsuqQeUBytUL0j0GMNLOrvPqlOsnDDX9d3YcOuInrBvsnAwlynx
         WOUOJrbpOIS47g7RLMqlzwdw9I7BWW/9Fow4xKO7ew+9aP9urILX1ZOmH2OauPz9Et3A
         OgKJrggHelpMxaoowGgg7lsihQJunPPIMJI0ChTukUZJ3vu26DPXNC8gAXE7EHLcwOb2
         dUbw==
X-Forwarded-Encrypted: i=1; AJvYcCUjXbUoFXO0H1AC4+tHbY1nQ4By+DLrlEcMcq1yPl6nOS7FMqPOSGF8q8L68A+jQwQacbJV0cac3kt7Qtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwymP1UZWWk+CWivWwUE7dagAnMbSMqKKS/H1d0KB8gQ3TkkMjv
	O5j5PSGLB+aMDltE0JaRKt7E7qu6nkVZhqtdygz6/18QGp5LL/LPU9IGQTDzLoUGP0Jd0YHL8Uq
	wUe2VIw7A8WgsoTFRXOcpntzaCPYb6Fp6tBxJBVo4+PTlvpYWq342oVO/FQPIBUMfIXGSQfmSPD
	o=
X-Gm-Gg: ASbGncto+KCkWzoOGWKhNav+YjUv/+l0PKOvt91iBS4KWIJUBtjcfPhAOn0AKTO7Dar
	6y/xPaOpMSuPMGsnZmsG8eYHks/1PorRvOnj/P2txRzUwgvWajX1FtBGRzvyvpjprLknzpHDjPu
	pcJa2QF727Tx5StuFNK2KyrO5aK/ylERe8xZgxIiTLnb9g+giBItU2Rwks9G/yeNgCrsT3QvtVr
	Hkn6NvuLRPDHjpjyvhFMGgeC160fPjQcjYrjCYHQ5jDhbnYfa+XcHT2GeVEVNOEFdX9m/Cp21PR
	vwt2el02jVefTQ8TTKfLStE2NVr9wi1ZCr0YB63h4RpggL0oO8OE9VjfQjvWfmiMo+zfdJWHm/H
	F47CCTO7Is+pluOGdrJlq+UFZ+00Ii1Rx
X-Received: by 2002:a05:6a00:cd2:b0:7a2:7a36:46dd with SMTP id d2e1a72fcca58-7a4e2df8684mr3535364b3a.5.1761741009600;
        Wed, 29 Oct 2025 05:30:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVwrrfaLG8ulMxEQ6t0UsGwp3wouMxuPndkKaFYkveJm2eyV1MsmhSCWLET27rZ8SM57ZGSg==
X-Received: by 2002:a05:6a00:cd2:b0:7a2:7a36:46dd with SMTP id d2e1a72fcca58-7a4e2df8684mr3535313b3a.5.1761741008921;
        Wed, 29 Oct 2025 05:30:08 -0700 (PDT)
Received: from [10.218.1.199] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414015724sm15081222b3a.14.2025.10.29.05.30.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 05:30:08 -0700 (PDT)
Message-ID: <a8046f0d-ee74-457a-aafa-6473c67c6ab8@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 18:00:02 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/3] arm64: dts: qcom: sm8750: Add USB support for
 SM8750 QRD platform
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
References: <20251024151521.2365845-1-krishna.kurapati@oss.qualcomm.com>
 <20251024151521.2365845-4-krishna.kurapati@oss.qualcomm.com>
 <a117b105-a734-4f67-9bb2-c06728e79083@kernel.org>
 <6297468b-77d0-4202-8ec1-3e731acc43de@oss.qualcomm.com>
 <6234e22a-c119-419c-83b7-2a53467951da@kernel.org>
Content-Language: en-US
From: Krishna Kurapati PSSNV <krishna.kurapati@oss.qualcomm.com>
In-Reply-To: <6234e22a-c119-419c-83b7-2a53467951da@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Nu/cssdJ c=1 sm=1 tr=0 ts=690208d2 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=yTxWjB1dP65ezAuFSf8A:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: Cb4grkgDE2YF5kqxsZwsQIjGVjIP7KUw
X-Proofpoint-ORIG-GUID: Cb4grkgDE2YF5kqxsZwsQIjGVjIP7KUw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA5NSBTYWx0ZWRfX3RYdoGA5FOVv
 vCTrGxFxDxlWS7q32Nj/nDh8YDlxk7kY/WIs26W7ch0vk5quJRPcK862fjwaPlHc4hNbqnov9Oo
 guehQafPLL2GpILbuRjjjSeGVZhdQKCknEY7hk2p6T7+JOQ4ZArOAHgASJi3r+QjWWK7CB4Y/wc
 K+JVxSe7eY1lJsiAWa+1LW4nzHN8dk/KO8ukhGhWdQCIg2GPYAUCpIZuYeCAzS751gy+Vad9PWy
 g8w0lvcMC2KHK27cJI+vyE7AfTgHEdMzVn5V+9761W8/NSqhEML1/QGZLw/l/uubIWgHJDZGQ0r
 rBloaNGWKxRJZaHPVa2qnKx8+YOsjDX4ZcUf6j40ggMJkGF6e+PFShi97XUGjkU+Rzso0Z0RwjZ
 WXPYSl55JzB33UtPWwPWPH+LzDKITg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_05,2025-10-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290095



On 10/29/2025 5:35 PM, Krzysztof Kozlowski wrote:
> On 29/10/2025 12:42, Krishna Kurapati PSSNV wrote:
>>
>>
>> On 10/29/2025 1:37 PM, Krzysztof Kozlowski wrote:
>>> On 24/10/2025 17:15, Krishna Kurapati wrote:
>>>> From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
>>>>
>>>> Enable USB support on SM8750 QRD variant.  The current definition
>>>> will start the USB controller in peripheral mode by default until
>>>> dependencies are added, such as USB role detection.
>>>>
>>>> Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
>>>> [Krishna: Flattened usb node QRD DTS]
>>>> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
>>>
>>> NAK.
>>>
>>> You ignored every previous tag - multiple reviews and tests, and then...
>>>
>>>> ---
>>>>    arch/arm64/boot/dts/qcom/sm8750-qrd.dts | 22 ++++++++++++++++++++++
>>>>    1 file changed, 22 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
>>>> index 13c7b9664c89..fc5d12bb41a5 100644
>>>> --- a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
>>>> +++ b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
>>>> @@ -1054,3 +1054,25 @@ &ufs_mem_hc {
>>>>    
>>>>    	status = "okay";
>>>>    };
>>>> +
>>>> +&usb_1 {
>>>> +	dr_mode = "peripheral";
>>>
>>> You sent something different with issues.
>>>
>>> Really, this was a correct patch. Was reviewed. Why you decided to drop
>>> all this, drop everything which was correct?
>>>
>>> Your explanation:
>>> "- Removed obtained RB tags since the code has changed significantly."
>>> is just wrong. Almost NOTHING changed, except completely unimportant two
>>> node merging.
>>>
>>> NAK
>>>
>>
>>
>> Apologies Krzysztof,
>>
>> On first patch that adds changes to base DTSI, there were changes moving
>> to newer bindings and merging child node and parent node. I should've
>> removed RB tags received on that patch only. But I was over cautious and
>> misinterpreted the rules and removed them on the other patches as well.
>> Will be careful the next time.
>>
>> Also is there any issue with marking dr_mode as peripheral here in usb_1
>> node ?
> 
> No, I think I looked at your other patch. Tthis was reviewed at v4 and
> v5, which then it was changed breaking sorting order. This one looks
> correct.
> 

Ok.

I will send v10 tomorrow. Can I add yours and Dmitry's RB tag on the MTP 
and QRD patches and then send it ? I will implement feedback from Dmitry 
on SOC dtsi patch in v10.

Regards,
Krishna,

