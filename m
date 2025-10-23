Return-Path: <linux-kernel+bounces-866533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBBFC0007E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE8811885747
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12813043C7;
	Thu, 23 Oct 2025 08:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ohX0fM+w"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99031302CBF
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761209676; cv=none; b=KQUSTdPW2K4sHfK45Y0D/e9iMezpvqw3yDYhxdncBCQOxHG7uIIgS8ELy+CbdvG6bDE4QPW07L4yM/i1jgvAxh6UWrIQqOtkhB2txsxVTzQsIdGyATG1Fv6Yt12VfzA8FKt3yGLCXOw0x8JcsUGWH5mzyW+3QjhAXm8syOzuubo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761209676; c=relaxed/simple;
	bh=EgUd9oZyKs9/r4LdN8rXs0xqEb4OFiwWfWnNVNoIOlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VA0wK1ZVrUI1/677cRtaXJlrSthKlmmlaapQrVtJVLpr+izlNK2OL3xtf5rYdJ3Ur3KlKvcDkVT9bE1SMPVQgvRbtYM4uTTX98iQySrBTZAdCP0GYF08Z8k+d3FDdcgYP0JbfMMBFpFynpPvT9LlYOQApZMCJCUc4Am3kc3jvvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ohX0fM+w; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6shOs018549
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:54:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	O+kY6GOqcTlWO4lw3FX+jZ0tYJgEXtsfTgJYQ2jiDJ4=; b=ohX0fM+wRThWRQfj
	6sf8f2ut88azFR/BJmuAyg4YRj202Z65M/uvuXF6EXBnp5Joc61swYD++mBxtt+t
	JPlwb89iBrm2+JF87NwcBO17UGS0vCRULf3J6wgiCtP1XW+JPJricGXrzz/lEznV
	hAgtISHgVaT0RxDdFgH+IXpBl1/6V78haa/25UwsG4va8qSsM4EIOYOYxYf4Nvti
	yQ+MvdB7ILfWYKdui5ApOKpUkN1T9KcvZI0r62bg7z8n5F/W8t6cAguHdeUG+16T
	0FtHVBcamz5gY68Bsjb9HuhPiP/UA3FiCVpjh5dvNSdpIsmgpC8ZwOsAmaj21uuP
	5vz/+A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v08pqxku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:54:33 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e890deecf6so1255001cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:54:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761209672; x=1761814472;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O+kY6GOqcTlWO4lw3FX+jZ0tYJgEXtsfTgJYQ2jiDJ4=;
        b=tMyGldMOcCnt4A1cj0urrBSeN7DgWXxblwta/PWxfik1SJePjQXw5+yAQKyUeuQpGz
         w/cq+/JN9rZEHzpdaS2G00na8UcmtEPA91X80A0IfhKG7KOpaWQ4S3Z05jew1GejRwBt
         SLtAxoZ80tcIPxQcQWAHKdCd3k9oggeO9kjF+kvn6iWfkmGYLjFPvZCbStOlvHqtNnIa
         TEZRfoVbiXt78EBBJHfBvglijo1wRkghYMEFepVlkzd3Sr9lKA5e8Eh4RhCyeKxor79j
         yGBGOS85pwA8lMRViDfOp8gtIO+GxcOKQeaD426xLAEonUIiDU7YjojkOgPY6FgGAFMs
         EXqA==
X-Forwarded-Encrypted: i=1; AJvYcCUbWmtAZKeXS7qQsW5PqdPlF9+y8cDK8emXZ6pyESkIPB3iXrs1ZVaObihFFTbSX7J612/T1TC9KbBzv1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6LBSONJPoarvAv/fc3MQgqJ4Zy0ClP4ni0RXUHhppTakmrad6
	DvUW3m3/jaPaOzKQVk09ehGp+ndVBO6lJJSLJ/Zk/mrpFJl70wlgOYFEKfCmrHnv31+eMt1vHMP
	M2NYPhoMfmVuARHMaMvOxB5cZIOOSWKv+9sSFw5/0q4yrFjrm64KNP3LwuwsCU6Wh72g=
X-Gm-Gg: ASbGncsoKM1Ae9HK1KXT8aYBD5SZw5lfLkdy0OzekA82778gwGr1xYCa4wNwQ6GBF/U
	QBzrVF0kgXu1P5/aXnR/O6gohQ0Fj1KQvUUEPaHyIBnGru5HpGgcyYWz9dvcDVYduulvN0OZ91/
	ZNv1lML9W/3SjerGcPLXKDs9D56NmRcE+5YVERUpGFXBl4d2FcxJAb7CzYAcVhRbY/Ll1R0jCZG
	iFKiUOo2y5OFhyP8vnLuonNNkeyVRLNbBOs54aYK2Oe2+u1v0xbDRaXXypBTqhyUZM1c+Y2tmMT
	Roc0H5X+Mss7fJITKmXEuL6GZ2RNwKh8SnS6tH9Xulkt7La1Q8YVPN+SXuTrU+XaIwsCxNN86As
	2eh1nuZ4xfDJp5IyejxtSse1YdAlUqYzrU1Q+eiO926uOg22hp0iVxZFm
X-Received: by 2002:ac8:5ad4:0:b0:4e8:9126:31d2 with SMTP id d75a77b69052e-4ea116d8880mr88761771cf.5.1761209672456;
        Thu, 23 Oct 2025 01:54:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0aAmSfr46dZLh5UhB2ylY04gff4weBDJCYoHERSwwINQG5pvdmyITIQLDUR4FdUXmFCjh5A==
X-Received: by 2002:ac8:5ad4:0:b0:4e8:9126:31d2 with SMTP id d75a77b69052e-4ea116d8880mr88761591cf.5.1761209671942;
        Thu, 23 Oct 2025 01:54:31 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d5144efd3sm165583366b.69.2025.10.23.01.54.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 01:54:30 -0700 (PDT)
Message-ID: <879adf4f-492e-4107-b034-dbd3a4866f40@oss.qualcomm.com>
Date: Thu, 23 Oct 2025 10:54:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] dt-bindings: soc: qcom: Add qcom,kaanapali-imem
 compatible
To: Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Jingyi Wang <jingyi.wang@oss.qualcomm.com>, Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eugen Hristev <eugen.hristev@linaro.org>
References: <20251022-knp-soc-binding-v2-0-3cd3f390f3e2@oss.qualcomm.com>
 <20251022-knp-soc-binding-v2-1-3cd3f390f3e2@oss.qualcomm.com>
 <g2iviaqetgxf5ycz2otzkpmmc4goo7xuyjmttuu254bfzqqvkf@4vybjh4eghpm>
 <4eebcb7d-1eca-4914-915a-d42232233f9f@oss.qualcomm.com>
 <dwfvko3hszsoh4ihnz3qdpsugmocbkrbhosijdw5q3bxh64kuo@o74as2li74px>
 <lz4sbvzfiij3qsa4d7jeblmi2vfubc4ltf435sh6tcs53l6fbq@7f3tfm7yiyjc>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <lz4sbvzfiij3qsa4d7jeblmi2vfubc4ltf435sh6tcs53l6fbq@7f3tfm7yiyjc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAwMCBTYWx0ZWRfX+LkwzKA48w3p
 3C/HdmW3c11khnb8isrA2v83qlB4dXPEGSPsl8z3zwcXMU2SByGKKc14A3lMGW1DReb4k4tZSmF
 /ZAh41kmD2VsXAQhLP5uZE3qOuAKslDDWoZwiaXuY9u5m89xyglNZBVNBep5q2a8Dv8GGvhQ8RW
 sEoCjzPsS67eyALU99DNimk9N2GvC0qs0w5NUZMka0GoxHgjRbr4XKYob9/Ucpv8/z0uyRD16yx
 E/dZvEgjrUwK2gqHmHp/2FfEGE4OWalG9EBBmc1nBCnEbnQumGjOpRmOkWFGWXjDKg1FgB9X0I9
 wXRCW4+uGnNq35nlirFsXisJplAZum43c9DLrkhCUgSHUrSgMPaxYi8NUy8/vFae773GZKE/fIB
 MlGG4Hl4ISmGfN5PJKf5NdJ+TiPcEQ==
X-Proofpoint-GUID: BsUU_6o_b-EitW8G6PitiYhlG0Anvt2m
X-Authority-Analysis: v=2.4 cv=Up1u9uwB c=1 sm=1 tr=0 ts=68f9ed49 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8 a=KKAkSRfTAAAA:8
 a=MbLCNjphmicZ8lnryvIA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: BsUU_6o_b-EitW8G6PitiYhlG0Anvt2m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180000

On 10/23/25 12:42 AM, Bjorn Andersson wrote:
> On Wed, Oct 22, 2025 at 12:34:58PM +0300, Dmitry Baryshkov wrote:
>> On Wed, Oct 22, 2025 at 05:05:30PM +0800, Jingyi Wang wrote:
>>>
>>>
>>> On 10/22/2025 4:49 PM, Dmitry Baryshkov wrote:
>>>> On Wed, Oct 22, 2025 at 12:28:41AM -0700, Jingyi Wang wrote:
>>>>> Document qcom,kaanapali-imem compatible.
>>>>>
>>>>> Reviewed-by: Eugen Hristev <eugen.hristev@linaro.org>
>>>>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>>>>> ---
>>>>>  Documentation/devicetree/bindings/sram/qcom,imem.yaml | 1 +
>>>>>  1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/sram/qcom,imem.yaml b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
>>>>> index 6a627c57ae2f..1e29a8ff287f 100644
>>>>> --- a/Documentation/devicetree/bindings/sram/qcom,imem.yaml
>>>>> +++ b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
>>>>> @@ -19,6 +19,7 @@ properties:
>>>>>        - enum:
>>>>>            - qcom,apq8064-imem
>>>>>            - qcom,ipq5424-imem
>>>>> +          - qcom,kaanapali-imem
>>>>
>>>> Can you use mmio-sram instead?
>>>>
>>>
>>> Here is the node: 
>>>
>>> 		sram@14680000 {
>>> 			compatible = "qcom,kaanapali-imem", "syscon", "simple-mfd";
>>> 			reg = <0x0 0x14680000 0x0 0x1000>;
>>> 			ranges = <0 0 0x14680000 0x1000>;
>>>
>>> 			#address-cells = <1>;
>>> 			#size-cells = <1>;
>>>
>>> 			pil-reloc@94c {
>>> 				compatible = "qcom,pil-reloc-info";
>>> 				reg = <0x94c 0xc8>;
>>> 			};
>>> 		};
>>>
>>> other qualcomm are also using imem, could you please give more details on why
>>> we should use mmio-sram here?
>>
>> https://lore.kernel.org/linux-arm-msm/e4c5ecc3-fd97-4b13-a057-bb1a3b7f9207@kernel.org/
>>
> 
> I considered exactly this when I wrote the binding back then...
> 
> But the binding defines mmio-sram as "Simple IO memory regions to be
> managed by the genalloc API." and the Linux sram driver follows that and
> registers a gen_pool across the sram memory region.
> 
> I believe IMEM is SRAM (it's at least not registers), but its memory
> layout is fixed, so it's not a pool in any form.

I tried to get answers for this internally, but no dice.. It's fair
to assume that's what it is though, I think..

We can probably change the compatible and restart my old IPA-IMEM
series which touched upon that while at it:

code+bindings:
https://lore.kernel.org/lkml/20250527-topic-ipa_imem-v2-0-6d1aad91b841@oss.qualcomm.com/

(incl. discussion with Krzysztof about mmio-sram)

dt:
https://lore.kernel.org/linux-arm-msm/20250523-topic-ipa_mem_dts-v1-0-f7aa94fac1ab@oss.qualcomm.com/

I seem to even have the relevant bindings patches on my computer:

https://github.com/quic-kdybcio/linux/commits/topic/imem_sram/

Konrad

