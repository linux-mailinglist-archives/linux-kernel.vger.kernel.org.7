Return-Path: <linux-kernel+bounces-888999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC98C3C75B
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0B88189AE59
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D92734F494;
	Thu,  6 Nov 2025 16:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b0rvNLlC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hT3t62ty"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FE534F482
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762446280; cv=none; b=fM93iX3yAskSabGiUqnm/7UQE1xg8qZC/+8I8W+BXvM8bC6hsSS+kWUw1BOPk/GfjnL4szlFh/TMKCljoOslo/5XWZ1FNBlSiGu9rlu0QczqLFz01RSQXdrTkWavF31zSv0u4J6O6l4WEr/avb7Ph9KdQ6aMekIJYgrzTwA61RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762446280; c=relaxed/simple;
	bh=rjswRZ8fYhP4ZArBfQ59SFM5Xabj5yCS0dt7YlTsIBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ofh5QeXM9r/UDiU3iHwqysRskixp+yJ0dTTJzOO2qNGcCuWRyNLAtYU75q4JYKmfxva5hcGcmFGyChSUFmBo0J6bFBZjbrbgYwSReQH3cQEulCG40Px5ren7b2eqhgkMK6jutOtEXW3F+ggym4dNxFL2r5wyFcxuNe9xEjoV3W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b0rvNLlC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hT3t62ty; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A6ASkIV3748580
	for <linux-kernel@vger.kernel.org>; Thu, 6 Nov 2025 16:24:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4eBKMzZBS7fv3JxWVRUTQzW9MQESzHB6KUZ8he5atGY=; b=b0rvNLlCuRSAqU10
	QdM4/aLzdJesi3j2jAsxbWDNVM9jS8r2Zjegojx38/hThIiv/it3wlKlm0uPASmm
	Sm/PjjcpC6zjZs52DuAUsUSUTCRUFrQFMooZWwCLKRCTUkRRk/oGNEl7hDJ+x+OA
	L5yfJpw6om0dlhsC6QTyzFthp0/j0/FOO0I87J8VVz8wrq/wuJTKJ58sssvw321z
	X39vL3kPJLON18e+YhsDsemYK+OG7rJUTf/TsjURSGXJ863gt1c/S+zyt7jPjnXm
	boxpkFNlkZv6ICMyHAi9akLPjjGF/2wR7Bqe38Bi0JCXva85YH0qK1rTC6rB/QRD
	h8iuXw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8sy6h1ek-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 16:24:36 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ed5ff5e770so3278271cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 08:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762446276; x=1763051076; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4eBKMzZBS7fv3JxWVRUTQzW9MQESzHB6KUZ8he5atGY=;
        b=hT3t62tyawdm4M+vhAs5eDxGJJlZZdVai4bQim6ByhCHAj5Nh5dTpZGTRXtPYofhlB
         +uX+8S4TrpltJu+wngAO6W+55c+Q3qzDgMTQQKhCjIbzEGWGxG0l2r2G4bMSiTUiGSYk
         7ElN+Jnr1Fdaq7N2EKdh5tXnZnnoio3yVhW7uGRcWWeCJskK7yko0RTVXCxTtMa4k5JX
         QaxM9bKHTR0rpyor9/xeXRLC7ugE0mqcZu8fNoO/TlYYHaqamYtGDHhIZWdzCSkT2Of6
         suEg3dfVdfdIEx29swaxLC6r70OO5Xl4UYPfpcTVfAF/wQxH++k2jHUrdBoEne0EZs/o
         YUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762446276; x=1763051076;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4eBKMzZBS7fv3JxWVRUTQzW9MQESzHB6KUZ8he5atGY=;
        b=A+cmH2+VELXqupKi+SXmKSROg7eh9QrOS+gWbGwlhIzKvO4nkXfZw6W8Gf33g+aT7C
         I8ksMEd7bNdXM/IZRRwaB7MDisM6mE5tQ2lrSs3stURLQTNmKK/0H+m3N2NGApJr11TU
         QJ1KR1msTQBlW3pl7RPzKvAp005ZLvLNzPipqaMIapk7leZpmkcYtENuuP2uzqHHAoGb
         R42r604PuwzApxn6ruZIp8C0pmkg5J/rEDSaaVLT8pDIdV5EK5byVb68bn9RkxRpiLuW
         D0rjALB3xV0sMN5+Ljov9JMtLbZf/hVWQox4dUkVfS/wCni4Q6GFSXyBdfNDqUeiedrd
         5dtg==
X-Forwarded-Encrypted: i=1; AJvYcCXo7kkUrmUYHdRBJdL551Hi5aLCL7+orIAtMsQs0V1xku9DfG6xQhPKWaatnWxczw7GN0vHdwvvsxgaK2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOXkbRiNMWtZF3jTQDauAa4iBht6hgdSJbgEVdD4shE3bS6dpc
	u4suQqyTTh14ebJZ+5bvay03YrRFZppywKn20Cc59kVRwlDAkG09LcB1lqzTzJjM81L3AakHgQl
	YIBinu6qP8sIrPet8Vxb2kFuxIYPQKOG+6drOuOyD0g9Cr2Y+gQslgjhoY/o6Bki1rjQ=
X-Gm-Gg: ASbGncuJeatzRSGkH6vWOu6mc04VUk3j2SC/+A+/cizkhKWUNOwJDKP6iPx0FDLeYmP
	EpZzFneQLiLx8V+v0mM2xZKHtEvWSV4jLx2BgAzc23ZZDJEBnX8k56E9zO08ve7myncEhTKJD+k
	1bQR4c/xG6eN9LXy17d+SmHQRtoK5xtEiUIvfNgPftinXXp8alIsySeGlbaZcHf3p+EmT+0U4ud
	3owC/LR+NMyEJExDJjnByxUeyUvxdeiwdsY6Po/dfs9haDQunyqPVTmOOChXM1iQAxVyJJjZycX
	dT+a4Y1KtBK9Vbo4St2RhIBcd9j6k4B2TEz8YV5WhX2zaCyBGN4mE5xFpzymCPTm0hZVf0JoyUO
	44IAoSAT9XGeG/u0vi0ClEC9GeVp4z6xJI1mHAt2HHgVdf0GFCbT7fDMA
X-Received: by 2002:a05:622a:1a98:b0:4e8:85ae:5841 with SMTP id d75a77b69052e-4ed814bd563mr30310111cf.5.1762446275414;
        Thu, 06 Nov 2025 08:24:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0kA54XRtpKBsm1SpgXQVoKL6TSJayG4yUU0vcxufAOcFBD1zUUWSqrNIKZ5aSJxENxX7sPw==
X-Received: by 2002:a05:622a:1a98:b0:4e8:85ae:5841 with SMTP id d75a77b69052e-4ed814bd563mr30309261cf.5.1762446274069;
        Thu, 06 Nov 2025 08:24:34 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f85f8c7sm2485290a12.27.2025.11.06.08.24.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 08:24:33 -0800 (PST)
Message-ID: <01de9616-825b-4fbb-83cf-e0bf91e8cf39@oss.qualcomm.com>
Date: Thu, 6 Nov 2025 17:24:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: mfd: qcom,tcsr: Add compatible for Kaanapali
To: "Aiqun(Maria) Yu" <aiqun.yu@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
References: <20250924-knp-mfd-v1-1-6c8a98760e95@oss.qualcomm.com>
 <b623c7f6-f28f-49ba-b6f6-25084117a6b3@oss.qualcomm.com>
 <l4mb5pi7kz7uuq6o3eueoxl2ngt2sdd6dv3kyudw6i54co5v5h@w6ya2nuas322>
 <ad00835e-bc20-4f97-aba6-e1b4f5e97191@oss.qualcomm.com>
 <f2q7a7r7quq6pplcn3kklwrhdc6hxa5zvc7osygshtyurwyvi4@t5iyragt7irh>
 <b5ecf5e7-4dc4-41ac-9b56-7c52afacb950@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <b5ecf5e7-4dc4-41ac-9b56-7c52afacb950@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=AYu83nXG c=1 sm=1 tr=0 ts=690ccbc4 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=NvqmdPLM_IyHh0VbTxoA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDEzMSBTYWx0ZWRfXxk2fivnKp2xK
 NQZGmismLC1QIr8IagNv25L55lGH38L5cgCIqbTyQdy1LQDlpOG3Xe9USGwIuujC4AEdHk2wqXq
 ZzRYPTj6XeS9hf+A5Qc2AK5KlQ15H9wEqfJr9qlpyBk4IsEjWMjAEYQJzOBx8z+PAMl26ScRw1M
 nZJf6mK84Wb+eYoK2vUB5D2gf0O2rIEqnvEJn0u+yCK+4dh+/GtrRZLK49yVVLqNjU7d5wQdQS6
 Taryw05ZFIJJgVOIfGV15Bs531F+VUjhcUnYbOlmaIplNiv+UpEqxlX+ncYNAJrq0LnkshZ4C9E
 +dmBPVO0TJHSwRytLRvgVNPQEOvW5+HWefzFmjsi23hGF5i8sdfYDIou2Gp+jUdX2Cse3392vFU
 kq+KAFDSZmfXZ+mSb7/DSADsVMZlbg==
X-Proofpoint-ORIG-GUID: SA2hJmo_ysDq-erFQxXbmWJhdC6tUPe0
X-Proofpoint-GUID: SA2hJmo_ysDq-erFQxXbmWJhdC6tUPe0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511060131

On 11/6/25 11:16 AM, Aiqun(Maria) Yu wrote:
> On 11/6/2025 5:06 AM, Bjorn Andersson wrote:
>> On Tue, Nov 04, 2025 at 01:35:01PM +0800, Jingyi Wang wrote:
>>>
>>>
>>> On 11/4/2025 12:02 PM, Bjorn Andersson wrote:
>>>> On Tue, Nov 04, 2025 at 11:34:25AM +0800, Aiqun(Maria) Yu wrote:
>>>>> On 9/25/2025 7:23 AM, Jingyi Wang wrote:
>>>>>> Document the qcom,tcsr-kaanapali compatible, tcsr will provide various
>>>>>> control and status functions for their peripherals.
>>>>>>
>>>>>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>>>>>> ---
>>>>>>  Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 1 +
>>>>>>  1 file changed, 1 insertion(+)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
>>>>>> index 14ae3f00ef7e..ae55b0a70766 100644
>>>>>> --- a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
>>>>>> @@ -48,6 +48,7 @@ properties:
>>>>>>            - qcom,tcsr-ipq8064
>>>>>>            - qcom,tcsr-ipq8074
>>>>>>            - qcom,tcsr-ipq9574
>>>>>> +          - qcom,tcsr-kaanapali
>>>>>
>>>>> It looks good to me. Glymur didn't have this functionality verified yet.
>>>>
>>>> You spelled Reviewed-by: Aiqun Yu <..> wrong.
>>>>
>>>>> Remind for review.
>>>>
>>>> No need for that, reviewers will review when they have time.
>>>>
>>>>>
>>>
>>> Hi Bjorn,
>>>
>>>>
>>>> But that said, most modern additions to this binding follow the common
>>>> format of qcom,<soc>-<block>.
>>>>
>>>> So I would prefer this to be qcom,kaanapali-tcsr.
>>>>
>>>> Regards,
>>>> Bjorn
>>>>
>>>
>>> qcom,tcsr-kaanapali is used to distinguish with binding for GCC:
>>> https://lore.kernel.org/all/20251030-gcc_kaanapali-v2-v2-2-a774a587af6f@oss.qualcomm.com/
>>>
>>
>> So, qcom,kaanapali-tcsr is the clock controller region of TCSR and
>> qcom,tcsr-kaanapali is the non-clock controller region of TCSR?
>>
>> Sorry for not understanding that earlier, but this doesn't work for me.
>>
>> It's a bit of a lie that TCSR_MUTEX is a separate node in devicetree,
>> but it's always an nice chunk of 256K in the beginning (or end in some
>> cases?) of TCSR. But for the rest, there should be a single tcsr node in
>> DeviceTree and that one node should be a syscon and a clock controller.
> 
> I've been dive deeply on this tcsr block. And actually the tcsr clock
> controller part is a very small trunk size(0x1c) of the tcsr block. And
> this block have contain other multiple purposed sys registers. So maybe
> we can have a more discussion on how to have device tree node describe
> this situation? It is not straight forward that to have a non-tcsrcc
> related area being described in tcsrcc.
> 
> What about option 1 (tcsr_mutex + tcsr_dload_syscon + tcsrcc):
> tcsr_mutex: hwlock@1f40000 {
> 	compatible = "qcom,tcsr-mutex";
> 	reg = <0x0 0x01f40000 0x0 0x20000>;
> 	#hwlock-cells = <1>;
> };
> 
> tcsr_dload: syscon@1fc0000 {
> 	compatible = "qcom,tcsr-kaanapali", "syscon";
> 	reg = <0x0 0x1fc0000 0x0 0x30000>;
> };
> 
> tcsrcc: clock-controller@1fd5044 {
> 	compatible = "qcom,kaanapali-tcsr", "syscon";
> 	reg = <0x0 0x01fd5044 0x0 0x1c>;
> ...
> };
> 
> What about option 2 (tcsr whole block + tcsr_mutex  + tcsrcc):
> 
> tcsr: syscon@1f40000 {
> 	compatible = "qcom,tcsr-kaanapali", "syscon";
> 	reg = <0x0 0x1f40000 0x0 0xC0000>; //align with the whole hardware
> block design.
> };
> 
> tcsr_mutex: hwlock@1f40000 {
> 	compatible = "qcom,tcsr-mutex";
> 	reg = <0x0 0x01f40000 0x0 0x20000>;
> 	#hwlock-cells = <1>;
> };
> 
> tcsrcc: clock-controller@1fd5044 {
> 	compatible = "qcom,kaanapali-tcsr", "syscon";
> 	reg = <0x0 0x01fd5044 0x0 0x1c>;
> ...
> };

Is there anything wrong with what we have done for x1e80100?
______________________
|             |       |
| TCSR_MUTEX  | mutex |
|_____________|_______|
|	      |       |
| RANDOM_REGS |       |
|_____________|       |
|	      |       |
| TCSR_CLKS   | tcsr  |
|_____________|       |
|	      |       |
| RANDOM_REGS |       |
|_____________|_______|


8750 was different because someone decided to stick the "TCSR clocks"
into the TLMM address space, but it was a one-off

Konrad

