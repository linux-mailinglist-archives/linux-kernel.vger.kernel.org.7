Return-Path: <linux-kernel+bounces-884804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77813C312E3
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 14:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68B631884A43
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 13:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B7231A562;
	Tue,  4 Nov 2025 13:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CGmhIGZJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FdTOZNsn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C534316908
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 13:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762262186; cv=none; b=XLR3r0ZpEFX+iT3MJGa8ImQWJphV9A+pWmayrJlXdlA1dneZlt+vII6qfa7SzgYxK1mL0gZMaLCpqSPkK3ltDk98sRcOLxowdvTIZPqIle1fglz35Ft9QhhPFo1AA5cSb5Hny0M9tu/9XA4p7PW6n8PO40KknZ5MWR71ArpBLFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762262186; c=relaxed/simple;
	bh=dahnfKSQZXYULZ5tpN1l5CdbLbc02qJ3aJMjuy8fydc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h0hFdyidDlGi5pS2Xi/LSlZ0Iz0GKYnqySVxanWAawE23Du+fUtoWTYoTdYFoT7fqba9/FkUcRk/2YcX3pL3iSGzBApLNkjQmaIndA/Vn1XMqKkHqo3vaTsWnWbaAuBpehcsiPNK62ar4brtOxsRNWbg6UEaUHHRn4etFkKRiA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CGmhIGZJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FdTOZNsn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4CgHHc1988390
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 13:16:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tCkbvOaLp4lIGumAdGTHtAA0z022CSMFZ6B3cK81eBA=; b=CGmhIGZJf928EuFa
	YjJDL73yAMsOTF9bxfON1lMw8XS6GO9aOAg2GY5bokJm1oThIcZlDXaHWL5783qv
	sevzARvJpmeroMqwQDcD/ybRd2IU3OUtGiIunE7EOvWHG1QRUy27OH5zxb2/dOBC
	NZiJI7ULK26ZihycpczXb6BzXb9dp546RRiDF/QkxNU9he+lNPYJl0yyD5ejpHk3
	6FJdQD+Z76HIV553LjTUggT3mER5e2mhDTwmWHXshm5a5oUP9DykTCDrjdNNT8YK
	8i8rPMdcMyCpwyvKKeSOfUJZSX2ULhoGVQG0YUBH94Xbc6iXLoDQs//L3GjvSBKM
	5yXuJw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7hbjr4rs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 13:16:24 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b969f3f5c13so2606921a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 05:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762262184; x=1762866984; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tCkbvOaLp4lIGumAdGTHtAA0z022CSMFZ6B3cK81eBA=;
        b=FdTOZNsn00/p1kYx86iwQv9F9hAsvGYtaociYuvyuG68ZVHRGh7DLhNnrNc9tjh4lL
         kPxxWKW1qDOJW01XqV0i6IXb5CmtHJ2k+V2rQSFjPRc+CNsAyD8HstG0f8Y/4ldbHmJF
         tgpxvZmOYZuL5vB0n2kFjQ0y9b2XaJYBro/Lp6n3KUs5isAgAls2RQZXWJ5cWkivrdS+
         akb1pJo56ReMQkoC9rgCYENmjYijt0iEL2qM25n9peqXJ45Ic5uQ76xGDbmrGanw1Qjq
         z98kpkk0Y1k6CMvLvhorwGKcF9DT0MfF/7H9URwy7dErxO9pVrPbzEHPttWMd1ZMZVWq
         kWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762262184; x=1762866984;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tCkbvOaLp4lIGumAdGTHtAA0z022CSMFZ6B3cK81eBA=;
        b=f8naItg7a0NfVIzwuK1rczP593TrchShkR5yut/SHC88LSFIteTQoOMS+qE/XTM+ND
         zCFUMtJFbhrM+hMir9U1osIIZXt4+T0nfXGdlFpS3LzsLDBTPup3kW+UdSAuC0tUKr3g
         QFr56ogewY3YDkjv1Z7UPi27USF6aOgEGWZUPAfErawXduytjTDnG5xJumHHewKMAlEj
         BYxZnTfrJ+tIsxi2VqHTWziUvtbNMzy+XXPPSppDp8kbJvOiwrSiMiLmXeZ7ojFDH+x1
         21gJU9OagNmwjrWuymrkfQErvgJPkr7HKq4ET9ltqpNNbMyiz659bjfjPoQC7wS6r8i1
         IxeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRC7EAFbjKfY7ArOJvmS0MZRTG9BwV0YSNh6QGiktBP+9OlqoicESuLwlcw7WlRrVYhCKyFgzMjXf54yk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx7H7pkILSHu8lnmfDOwN7bkwEAcsBee5DZLxF0DJkfSE1eXzu
	fj0HcTIF9SA/6kkoxhe1vlQUMNHCpnALnbOIYqeKPyrGw72hWzdLQLljFggaqY/cp96C4nKpMxD
	H+z8DsiMNoZY2uquL6AorNu0x2Fww9c86RRgCW0xND4D4REu/rKO3Xp51GHPJ98H5T+A=
X-Gm-Gg: ASbGnctfyF23D3ghywjlAtKxtl8FT2vPN/+QKK/MIzVO9fhX5fBMw16xHOyLN2C/53K
	+tX6zl1Iw51OkAVbaPc654IfvdG0vg8IjbgmLG6tPMMUjVfnebX0nijneiLyfrXT2Sesz+/VgIe
	f/K9OpNxGoE8epw8W5naeK0U28si562Zk2XlEdNzPWg4WNfSyu0Q7jLZezsKLef+oiqQD029WG/
	PhBaOlvb/g/jDl6dptexzEFrpK/gN7Wni7ZWJp1cANal1Xja3ePEUe9TwnB62wcy5zW4h68XFIo
	szi02XBJmWjbCPs0lNN8WMH8dx3LpP0KU3ofNGQxlQmmUue94wq/EGefdU93z0vTImWbyAaFdgn
	Kuf0onFRtrfrrytKf4Fp4pxnw38NaKwbkBU2Uv/9iCcQ=
X-Received: by 2002:a05:6a20:12c7:b0:334:9fbb:35c3 with SMTP id adf61e73a8af0-348cbfc36e5mr20524457637.46.1762262183505;
        Tue, 04 Nov 2025 05:16:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJ96wFJAi6EOKorEp/J4xzwntMqgifOhvphrTFuhOkUboj24jia9QeZ94B+cMWoPmdjudC8w==
X-Received: by 2002:a05:6a20:12c7:b0:334:9fbb:35c3 with SMTP id adf61e73a8af0-348cbfc36e5mr20524417637.46.1762262182906;
        Tue, 04 Nov 2025 05:16:22 -0800 (PST)
Received: from [192.168.1.9] ([122.164.83.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f18315bfsm2412021a12.5.2025.11.04.05.16.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 05:16:22 -0800 (PST)
Message-ID: <b81cdd25-3da7-4dd2-b69b-2f7b131f9610@oss.qualcomm.com>
Date: Tue, 4 Nov 2025 18:46:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: sram: qcom,imem: drop the IPQ5424 compatible
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251015-ipq5424-imem-v1-1-ee1c1476c1b6@oss.qualcomm.com>
 <20251021-quaint-hopping-tuna-0dade2@kuoka>
 <cfb94b1a-7ad0-4067-a08b-2af358edb768@oss.qualcomm.com>
 <45a74411-32a0-4a28-a738-9f44d66c0de3@oss.qualcomm.com>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <45a74411-32a0-4a28-a738-9f44d66c0de3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Uv5u9uwB c=1 sm=1 tr=0 ts=6909fca8 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=8axTHWJ9fAdUHyy7aoPncQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=_CKE_32nWIW8_9EVYHUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: m6Lv5-bgGtYLnRH20d1hwl47qyd8KVY1
X-Proofpoint-GUID: m6Lv5-bgGtYLnRH20d1hwl47qyd8KVY1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDEwOSBTYWx0ZWRfX5jHx26I/YOWT
 6An3pQlxQJmRNrNsN7HghtdT6Fl0aHtCCSvQamj8O8/di9VgmwnE1wD+B8xTkk0oTRQ9B3IwJ5p
 VMRb1H5H2pGcZG+Rlnhxmzyjy+t8wiKuuZh8MNMICNtDMI4t4/WAjO3t/dz7gykirhpUumMxED9
 4O2U/qrxv4AHYWx037IDCuTE0gBoEPPssJaC9iO2rhPv0yedRehmb/2F1d+CLGcPoXF52NcDnm4
 pFhwamkSoDEXySsfjU+fAkwISq9LXwS4hQZbP2ofG5ephPt9E8XEptJYkBs2fqSvH/0ApoSK+YY
 d9Uz/YyAJhXoW5u26zF+tNv4WZr3xoxkzsWTnBrO+yg2O/X+6TAb0cm1QiUHxlv5ztYLnlhGoF6
 q/DM8NKwmDlsg2OW8xptjLlU5obLvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 spamscore=0 clxscore=1015 adultscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511040109


On 11/4/2025 6:18 PM, Konrad Dybcio wrote:
> On 10/27/25 5:59 AM, Kathiravan Thirumoorthy wrote:
>> On 10/21/2025 12:32 PM, Krzysztof Kozlowski wrote:
>>> On Wed, Oct 15, 2025 at 11:46:58AM +0530, Kathiravan Thirumoorthy wrote:
>>>> Based on the recent discussion in the linux-arm-msm list[1], it is not
>>>> appropriate to define the IMEM (On-Chip SRAM) as syscon or MFD. Since
>>>> there are no consumers of this compatible, drop it and move to
>>>> mmio-sram.
>>>>
>>>> While at it, add a comment to not to extend the list and move towards
>>>> mmio-sram.
>>>>
>>>> [1] https://lore.kernel.org/linux-arm-msm/e4c5ecc3-fd97-4b13-a057-bb1a3b7f9207@kernel.org/
>>>>
>>>> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
>>>> ---
>>>>    Documentation/devicetree/bindings/sram/qcom,imem.yaml | 3 +--
>>>>    1 file changed, 1 insertion(+), 2 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/sram/qcom,imem.yaml b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
>>>> index 6a627c57ae2fecdbb81cae710f6fb5e48156b1f5..3147f3634a531514a670e714f3878e5375db7285 100644
>>>> --- a/Documentation/devicetree/bindings/sram/qcom,imem.yaml
>>>> +++ b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
>>>> @@ -14,11 +14,10 @@ description:
>>>>      transactions.
>>>>      properties:
>>>> -  compatible:
>>>> +  compatible: # Don't grow this list. Please use mmio-sram if possible
>>>>        items:
>>>>          - enum:
>>>>              - qcom,apq8064-imem
>>>> -          - qcom,ipq5424-imem
>>> And where is qcom,ipq5424-imem added? This is supposed to be one patch.
>>
>> Kindly excuse for the delay in the response as I was out of work.
>>
>> This is supposed to be added in the sram.yaml binding, but I haven't completed that yet. Between Konrad has done some rework [1] on removing the imem.yaml and combined with sram.yaml (in his dev tree). So I hope it will be taken care along with that.
>>
>> Konrad, Can you help to share the plan on when the patches will be posted for review? It will be helpful for reviving my other series[2] and obviously yours too :)
>>
>> [1] https://github.com/quic-kdybcio/linux/commits/topic/imem_sram/
>>
>> [2] https://lore.kernel.org/linux-arm-msm/20250610-wdt_reset_reason-v5-0-2d2835160ab5@oss.qualcomm.com/#t
> Let's get an answer on the Kaanapali thread and go from there
>
> https://lore.kernel.org/linux-arm-msm/176222838026.1146775.13955186005277266199.b4-ty@kernel.org/T/#mb3284a3a0bc3a9cda9cc6c0fb9433e8c2dddea2f


Yeah, I'm also waiting for the conclusion on the thread.


>
> Konrad

