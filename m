Return-Path: <linux-kernel+bounces-860780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDBEBF0EC2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 228E134B92C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63935303C93;
	Mon, 20 Oct 2025 11:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ajy2SNsN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41717246783
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760961074; cv=none; b=WK/SvBffefGjztiG4zM6taHi7oWZPdBRX5fEeXRlrLMX7wat4yslJcfNa79MzpR4uYgF4/5Nl5QWeIECD9P54uSU6sqnxAKuIuJmoXRYuqaVhhyUXu6sUGFR4QPCfD06L14GvgNEsbytfFlaPz2yFsvv5vY4yk8vuOL9wasXy8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760961074; c=relaxed/simple;
	bh=3l8Mpe21IMJZ36Vru6F8BdwTtWxRFRzgQWuducNxevk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f0QFjpUmmfMkA9tLEz4QfTVY8AFStrPkEMdETPYUtteKRc0XdX2SrthiM9vqGVwr88Pni7AaQwpZ53ThcVQQIV9KoOLxkmH8pjacHXkdED8JgowhfW1OTSnIg/XSOGKqJuGUUkjFzymdTAXifEUZpz80eH85rqO6SWrgqJ59df8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ajy2SNsN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KBktCN013109
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:51:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	snBgGKuWB4UoFzX3BzQo/X9MRDaf9rRWG1mdK2nsjBI=; b=ajy2SNsNq0av0MGQ
	axcgju1AOR/YNbcoBnpL33vXwNRigab4/PMgpVDIpp2li9zMHr4TRT7WQX+gJnvp
	vvojYGl6mUR76Ap8Zf8WrrEfnmrQ+lFmjKUz9Bx5jmFNTWRrHbFxcMOX4n5mMzCS
	CMSwLVEG+swyQ0sIz7xnnmeBCllKn5bdO6RxH7G1rwI8h3+NHnzWxhHYFESiiVkW
	5qhrn4l3L1/R+b7/6xzLoadii0oCTOIeBOsTlvWjzG8Zkk+pvINx92bqeLSY6xdC
	RynGgrn2ErDgKodwSclu5JGdoVntrSFe3vE9sdQ+CxhhPwovmumi8MO1/MBqSVlc
	a5youQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v3nfckhn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:51:11 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-87c19c8393dso15265206d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 04:51:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760961070; x=1761565870;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=snBgGKuWB4UoFzX3BzQo/X9MRDaf9rRWG1mdK2nsjBI=;
        b=REhzHSTMtphAJDZ3qGqsD+fn49HAFpqaUf8hSwk6uVVM6zS1KVmEFCjZxRLfov4JS1
         QzARVJTn3aZzY+1ryV/wo0cQb7iQ2lAAgJrVTk7+ApQvtxAFW75wFs9GdegqC+PX4Qi3
         3SfHz/eRWY7pJ4AC/YDMxjkYKxUFOQSZctO+hSHFvE7zzX8a6tVvNoOBMjavnr0m4+8E
         iHnpHVM1VXLTFVVVqF+VwrXXD+2erPtkkXfMN4LRwn6wVxxVBHk2E90YfRPY4v2rMUac
         jnKY2XVLTcEM3SaZ3f7bZt7VjnYAREN6+VUU1NnDFsJ9QWPDavtLCDGosEhQ4Wd32C5j
         tAYw==
X-Forwarded-Encrypted: i=1; AJvYcCUX527PbWq2p9ra2JfqvtotOczDmvpNH5lMzFvgltchr6LTyWejByPWlYOxXQ4JiHMQMJMiPFVqZKBa/VE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1UdfRoQ+VsWS5Tssb4Zwpk3Yjn8moPYQXz/qVJF6Yd+ySxKbB
	y5TdWPuPeZWVGwNpur9CqSNbLyS7hGwPuoGq1VPECyhUrFFt+/vayo4HDFILFMiUqbFkCi4uf95
	Zn5b/5p3XVm97qbPTzYea1H5by4ahimI5wHmGUYs/qmcgeO8ggCVoHa62SxpFcsgf9kI=
X-Gm-Gg: ASbGncv4nUWvROaO+/AFgw4WsL24WB9CCw0C4lpUb5G1+vQeoe11Ln67ChO5oUDa+EC
	LO1Bc3WPIThg+65leYhoo7182n1m9ALwLmqyAZVX8Il3F801OOysi9LGp2LA3w7Re+0nTnQO4Or
	r8lnXlj69qzp+WKAL2DMBIXd6gQZZdXgVJDlLgoYetSGefoaq/YmfgRhKp2wyHDjyLT1sC3jc7x
	Rykjto5X+SR+aU2JW9bPdBKCwCPDf3vz7GBxLI9GC/taRzSBfKhKc0IkSEiLwTF1SmKO5/U5RaL
	w00Js6tvDqN/wZNRAZToEFW+XYs4lh2l8cWqzb01bSRVL1M9sCkq8f/gjdYziJMNVfxlfzfhnfu
	Faq9QbKGB4zAMjsXQZKUgnv4lryHNoHvHcj5PCCjryGTVzfchzugu1gYg
X-Received: by 2002:ad4:5c62:0:b0:77a:fa17:551d with SMTP id 6a1803df08f44-87c2065bc7emr122377456d6.4.1760961069999;
        Mon, 20 Oct 2025 04:51:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFi4TsWjjriGLTXDyCWtzNZZafmMb2+lKzlJu/Cn821IEoakSsLgIAHwrkmiDI+yaHV2vGUJw==
X-Received: by 2002:ad4:5c62:0:b0:77a:fa17:551d with SMTP id 6a1803df08f44-87c2065bc7emr122377176d6.4.1760961069463;
        Mon, 20 Oct 2025 04:51:09 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c48ab560esm6477728a12.12.2025.10.20.04.51.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 04:51:08 -0700 (PDT)
Message-ID: <50ac4730-8c9c-49ae-8a1c-db4c8d87804e@oss.qualcomm.com>
Date: Mon, 20 Oct 2025 13:51:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/24] arm64: dts: qcom: glymur: Enable pdp0 mailbox
To: Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-6-24b601bbecc0@oss.qualcomm.com>
 <fec06b27-637a-4923-b07d-1f0a1fdf4922@oss.qualcomm.com>
 <ca4853a1-67e7-4152-aea1-f92c9c25d7eb@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <ca4853a1-67e7-4152-aea1-f92c9c25d7eb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: FsTuJM2iSgdLuEbWrkMoMaWmLG_Y6VP4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyNyBTYWx0ZWRfXxBH+baAS44+x
 kkN4dgolBFDXpzGjMsWKKq1RPLxpz6t7jvHpaBZORzPl39yps6oxCL5L3UgvbViJvqV1H0LW5XL
 qTBRjwI3DF81ujQmDsbxj5NSyW1zdqAkt/Igo9Lz003qXLrFdmoOz/kft5H8O2fM0G1mEQ2U+MJ
 Q+Nah41lNaFr/+KQnSA5JMn4OYXADhIPuMenO+SF35qjA3b+6t+j0jOD0plvuCMxnpzo/0ETAIp
 HyLpJL/zPlP99OmBn87rXxjqqmUAXemdAANpmOp3ulJmExgOisDM+3k4Kb+f7LPxe58hHspyoTQ
 7cdLw0ARgKE4X7vQUKlx0k1rf5wv5gRvFtWSF3pubSgMzzpE7P+u9jlnOYrZf/ko+/CxZqJk2jN
 plspgDnkFPFiBw6qYZ4UaNRGXRL+5g==
X-Proofpoint-GUID: FsTuJM2iSgdLuEbWrkMoMaWmLG_Y6VP4
X-Authority-Analysis: v=2.4 cv=EYjFgfmC c=1 sm=1 tr=0 ts=68f6222f cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=WRDRb4xdkbWPci3HNeAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180027

On 10/9/25 12:43 PM, Sibi Sankar wrote:
> 
> On 9/25/2025 3:59 PM, Konrad Dybcio wrote:
>> On 9/25/25 8:32 AM, Pankaj Patil wrote:
>>> From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
>>>
>>> Enable pdp0 mailbox node on Glymur SoCs.
>>>
>>> Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
>>> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
>>> ---
>>>   arch/arm64/boot/dts/qcom/glymur.dtsi | 8 ++++++++
>>>   1 file changed, 8 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
>>> index 66a548400c720474cde8a8b82ee686be507a795f..ae013c64e096b7c90c0aa4cfc50f078a85518acb 100644
>>> --- a/arch/arm64/boot/dts/qcom/glymur.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
>>> @@ -4065,6 +4065,14 @@ watchdog@17600000 {
>>>               interrupts = <GIC_SPI 0 IRQ_TYPE_EDGE_RISING>;
>>>           };
>>>   +        pdp0_mbox: mailbox@17610000 {
>>> +            compatible = "qcom,glymur-cpucp-mbox", "qcom,x1e80100-cpucp-mbox";
>>> +            reg = <0 0x17610000 0 0x8000>, <0 0x19980000 0 0x8000>;
>> 1 a line, please
> 
> Hey Konrad,
> 
> Thanks for taking time to review the series :)
> 
> Will fix it in the next re-spin.
> 
>>> +            interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
>> I see this has 3 channels, with 3 separate IRQs (but one pair of address
>> spaces) - should we extend this description?
> 
> It has a single IRQ and each bit corresponds to a channel.  The mbox theoretically
> 
> hold as many channel as the number of bits. The third channel here is used for
> 
> logging and is disabled on devices out in the wild.

Your mailing client injects two '\n's every time you press enter
Try setting mailnews.wraplength = 0 in your presumably thunderbird config


Is the logging channel useful for us, on internal devices? We can still
describe it if so


> 
>>
>>> +            #mbox-cells = <1>;
>>> +            qcom,rx-chans = <0x7>;
>> This further seems to confirm what I found (BIT(0) | BIT(1) | BIT(2) == 0x7)
>> however this property doesn't exist upstream..
> 
> Ack, this seems to have picked up erroneously and isn't needed upstream and
> 
> can be dropped safely. This was needed downstream because they share the
> 
> same rx register space across multiple instances. This wouldn't be possible
> 
> upstream and we would be exposing all mailboxes that uses the rx space in
> 
> the same instance and extend mbox cells to 2 to support this in case when
> 
> it is needed in the future.

This won't fly, as you're essentially saying you're introducing knowingly
incomplete bindings, which are supposed to stay immutable..

Konrad

