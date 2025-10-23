Return-Path: <linux-kernel+bounces-866195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 297DDBFF204
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 06:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 187A94EFF48
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 04:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72594224AEB;
	Thu, 23 Oct 2025 04:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EEu4mf3I"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E317824A3
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761194191; cv=none; b=Evm4LePFl87yaw7l7regf1SKHXCGuqAcX00jd/nMBjtcIxxgWOjO48Sq1mGPDwGMqKcfBqIYdr4pdeXS+Ae9wvfiY2wVUF1Rbg4bIxat+uBrWkrbyu1iSuaG6haRawOp3XXl1V3dCy6XvdHDfgrmxnNsCdYPcWBjmbZyJoIt9oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761194191; c=relaxed/simple;
	bh=q9ZYUwpWsoIG8dAqgBP3NNLQlgwhwwoE4WrO6rM/68w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CZSdL0AGmLooKFP66pxNVLXsGYLLIc5g0EHeSgCNOVTys6krZC5Hii/kt4w6EVjoviyZ/mf64XHfisp9pXr0a6aJP3BlHq8Mr4IQJV0lY6yb/cRrwhDhzKuTVceLhS2YziFo623GydIVJQluh8V38OMuIaYuManFnwVCsuh2O48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EEu4mf3I; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MIemUa018580
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:36:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Te/7zwDTfvlL9FM8UAQtQJk/d8U0toBIwktS4I5P+YA=; b=EEu4mf3IUJOCsm0g
	PEFuo6r44ERQH49I8Uv1QoTljIrI7VHSqCEHSD7QCS//CbFpVXy2WSTpxaPCXQcl
	7/AtT0NtNeZb9vd43Tv+whDicH87nsV047Oe1GkgG1uT8t5RN/Wezpem0WzVFAQ4
	7wa7pCLDg0/5Ufnwl+5hujXFPqRYRR3nNSHLIvVmIJKeygIN1fVLqc7Tk09T9uZR
	mIzzaqmZnbN6hHDWWn+GsBoDgGDFdiSCSTlsth9MYg9Q9FxmWJzqbRT8f2oQuDGu
	lydOmwUBqWw+J4ozkGlryt47YbnMlttCS/9JBYSZ73wWxKamK8YbD4SUKD8ng6Sj
	0o4vOw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v08pq7xd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:36:28 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-77f5e6a324fso835139b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 21:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761194187; x=1761798987;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Te/7zwDTfvlL9FM8UAQtQJk/d8U0toBIwktS4I5P+YA=;
        b=pEAjS7QEp75CIKmCUPJEEmEJxduroVy9NKsfE2wlKxtvoi/WgdHpppNYOeJzgMixM9
         X20+/HlogRjOTs5mZR59QHnfYpXeIxxelerPLFH1PV0DRMH8amHQRDpQ+0xuFTMiQDrN
         nzs9ObO7SkrgU9a+pGu5obAcwmkjkT350aB1Rv/30pmyALItQApl4YhE51frZNWD4RXg
         iKmHa+RKw3f2cqUr7Thh7XPl3R6a4ZsiZ2OBj/qpo/blZsT8XTgV8kmPy8EfhRRMvbyi
         29RhTb77VDrZ/2JB5Yvj8+eKiksIK2RlBOUgEzmRpBBhQMI5lBjq0l71eKy5FlZJ5Kcf
         oGgg==
X-Forwarded-Encrypted: i=1; AJvYcCXVBI+WIAu0jip5/YtG3uv/DSMxA6szW/SVz4M56yJaS/GDstmh2vCQopa/L+DLcU8dsQPwvELBblnZXH0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf8EVcZQ5N2dJmKsdtJVc5f7MKe8t4urHLBLDZCDaAUrrdL2xr
	fQ763cHX1rK1UO7oHRxcKhw7+oKt5HRjn6Q5s1BPpoT0yc/84s8oSzmcWLxrioeWcvYUU2c8ebu
	kw2ArE+qI3ak2kFUTkTJ1JEUQ9iqFtzGXX5V0fui+vegc00mgZFcNcHtDV9d/yb81zPg=
X-Gm-Gg: ASbGncs5Det+dirgvIcIhyxkGR/x+mG4CRs/Etipoq3dwOiASOOiTKDtU4NX/rYGkwP
	J1mV4EMkCvn3snyCobXOMb/jFBuBMaOg/QRuNfPNTtyjBC7wQhl3NLl+PetQz5uLAurKxDyzvr+
	Qh4CzxnTsLVvTKsE51pmLIioVwAX1ZedxEUGTwJKm6nzXexxUKVi5/dpdQJcW/5mQo9EyGIJusj
	9Me1T7rTj6RfW4Fv+cWigSpqZhCzevigcgBcuITqyGu4O6ggTBmRbxPTYycKdP5RjaUXbn59z8G
	XXunfYoSn4yXjQ+zMK1cmedLABLDXCFZ7b9ZLupqUFYTmWCWyNv6aZ2g9epinl+VsgYdQA26cIB
	P7RIiHgc5JR/yFE92/Wes+54cpV/OUeJzByWlJo2oSmXFdgKeXRnTHeLORKJhl4zvbr0RQQ==
X-Received: by 2002:a05:6a00:94c2:b0:79a:905a:8956 with SMTP id d2e1a72fcca58-7a220a6f5e0mr29848811b3a.14.1761194187026;
        Wed, 22 Oct 2025 21:36:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2iZTTTkLGieebOdiAnwWUzMqAciGlGLz0XjSkE0wYgzufXC9FBsckdcIVLWGDwsKK6RcgSQ==
X-Received: by 2002:a05:6a00:94c2:b0:79a:905a:8956 with SMTP id d2e1a72fcca58-7a220a6f5e0mr29848779b3a.14.1761194186528;
        Wed, 22 Oct 2025 21:36:26 -0700 (PDT)
Received: from [10.133.33.160] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274a9d3c7sm1015217b3a.26.2025.10.22.21.36.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 21:36:26 -0700 (PDT)
Message-ID: <7023b97a-7c99-49bb-8371-3f6601e644fe@oss.qualcomm.com>
Date: Thu, 23 Oct 2025 12:36:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] dt-bindings: soc: qcom: Add qcom,kaanapali-imem
 compatible
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
 <mwin3lfvpcwxxhsub2whcpibuayk36f4ljrodvithfygqad5w4@cg4h6peh4v4a>
Content-Language: en-US
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
In-Reply-To: <mwin3lfvpcwxxhsub2whcpibuayk36f4ljrodvithfygqad5w4@cg4h6peh4v4a>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAwMCBTYWx0ZWRfX4CjRzx0/344P
 SfSeP0yM5LdFNA7/tWLZeEotuUTsnHoWrJu5dldrZqclKBjIjtyJh1vRdd/wYuJcpy1LyyXfxia
 lkxWCfAaB20UxTjkLdAqCo2ocd3oxpyoBtKwwA6/qdlrvxMduvztGGOLa+UhY5PJnl3Dki+1OBM
 D+bVy3nwadLlNoJ2CpoVVQUaVdCZOvRePFj5wnfbC6I7w7lJVxdRHNuRI5llFghKTggj0lRZlN2
 hYSnUF3l+OMmjphriLjXs3JAuTiFKG7pUlRgT6VrntpOq+qKxoJ6+XeMyVmtdrZaZxwurW89y4q
 zlHvLDoo1YUJJdVlTAYSECdZjdX1T6j7LcvZuWTbGp40YcjBZD8XIwmY6pVNkCIirQkmQaNadME
 pn+l2jPixkbi2MoIVBf0FqUiETyj5A==
X-Proofpoint-GUID: TAP-51-Y41ZXy4qJHJMpQBenFyAstqnl
X-Authority-Analysis: v=2.4 cv=Up1u9uwB c=1 sm=1 tr=0 ts=68f9b0cc cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=BJhlq6_3M5jb6BGk8hwA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: TAP-51-Y41ZXy4qJHJMpQBenFyAstqnl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180000



On 10/23/2025 8:06 AM, Dmitry Baryshkov wrote:
> On Wed, Oct 22, 2025 at 05:42:58PM -0500, Bjorn Andersson wrote:
>> On Wed, Oct 22, 2025 at 12:34:58PM +0300, Dmitry Baryshkov wrote:
>>> On Wed, Oct 22, 2025 at 05:05:30PM +0800, Jingyi Wang wrote:
>>>>
>>>>
>>>> On 10/22/2025 4:49 PM, Dmitry Baryshkov wrote:
>>>>> On Wed, Oct 22, 2025 at 12:28:41AM -0700, Jingyi Wang wrote:
>>>>>> Document qcom,kaanapali-imem compatible.
>>>>>>
>>>>>> Reviewed-by: Eugen Hristev <eugen.hristev@linaro.org>
>>>>>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>>>>>> ---
>>>>>>  Documentation/devicetree/bindings/sram/qcom,imem.yaml | 1 +
>>>>>>  1 file changed, 1 insertion(+)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/sram/qcom,imem.yaml b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
>>>>>> index 6a627c57ae2f..1e29a8ff287f 100644
>>>>>> --- a/Documentation/devicetree/bindings/sram/qcom,imem.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
>>>>>> @@ -19,6 +19,7 @@ properties:
>>>>>>        - enum:
>>>>>>            - qcom,apq8064-imem
>>>>>>            - qcom,ipq5424-imem
>>>>>> +          - qcom,kaanapali-imem
>>>>>
>>>>> Can you use mmio-sram instead?
>>>>>
>>>>
>>>> Here is the node: 
>>>>
>>>> 		sram@14680000 {
>>>> 			compatible = "qcom,kaanapali-imem", "syscon", "simple-mfd";
>>>> 			reg = <0x0 0x14680000 0x0 0x1000>;
>>>> 			ranges = <0 0 0x14680000 0x1000>;
>>>>
>>>> 			#address-cells = <1>;
>>>> 			#size-cells = <1>;
>>>>
>>>> 			pil-reloc@94c {
>>>> 				compatible = "qcom,pil-reloc-info";
>>>> 				reg = <0x94c 0xc8>;
>>>> 			};
>>>> 		};
>>>>
>>>> other qualcomm are also using imem, could you please give more details on why
>>>> we should use mmio-sram here?
>>>
>>> https://lore.kernel.org/linux-arm-msm/e4c5ecc3-fd97-4b13-a057-bb1a3b7f9207@kernel.org/
>>>
>>
>> I considered exactly this when I wrote the binding back then...
>>
>> But the binding defines mmio-sram as "Simple IO memory regions to be
>> managed by the genalloc API." and the Linux sram driver follows that and
>> registers a gen_pool across the sram memory region.
>>
>> I believe IMEM is SRAM (it's at least not registers), but its memory
>> layout is fixed, so it's not a pool in any form.
>>
>>
>> What Krzysztof says makes sense, but rather than just throwing a yak at
>> Jingyi, it would be nice if you provided some guidance on how you would
>> like to see this turn out.
> 
> I tested, pretty same approach seems to work:
> 
> 	sram@14680000 {
> 		compatible = "mmio-sram";
> 		reg = <0x0 0x14680000 0x0 0x1000>;
> 		ranges = <0 0 0x14680000 0x1000>;
> 
> 		#address-cells = <1>;
> 		#size-cells = <1>;
> 
> 		pil-reloc-sram@94c {
> 			compatible = "qcom,pil-reloc-info";
> 			reg = <0x94c 0xc8>;
> 		};
> 	};
> 
> 

Thanks for clarify, I will drop this patch and make the change in dt.
Meanwhile change in sram.yaml should also be required.

Thanks,
Jingyi


