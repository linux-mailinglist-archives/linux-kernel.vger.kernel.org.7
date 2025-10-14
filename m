Return-Path: <linux-kernel+bounces-851826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB97CBD760A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 807F14065D6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BC9283FDB;
	Tue, 14 Oct 2025 05:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E/9jFdlN"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB23245023
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760418828; cv=none; b=UHCcxV78s8edF25L/K5PxBKtXmq/+T5oVzjvq/O1If2JvZuuLgZjjHUgiuf29Y/TQ9p7jrj+42hjxU12oNn+BIfIRfsIywu94x2BjXRUSJuY63S07TZha9mf/MiSL1dnvKSmIhvu5lw2lPWhzriYSkHK6PtgjvGvDiJnC+e4auI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760418828; c=relaxed/simple;
	bh=bg2eUKmsZctaIiMpNyHeUX3SYQYKQEYGpTMYvlqyEHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cYVemd9dvBebx12TLcA4608r6lia4R3W5rf0uj72vLoqtLFnuZrCBHTj51pySArizcji7+JHUG0OvW9oJ7gbY3BdAmupxDyLMHsPzwweUcEFKY187S4k7SF6UDQmuRmpV/m4c667aebcBgtAUuYpfAeRfEXZ+s5xXXPek3Iofps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E/9jFdlN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DHDIEL003064
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+r0How+FgbvW7VMlqsJ4Gwuo804o+0P5HhOrz8Iggic=; b=E/9jFdlNSvFvItD7
	Qgq0RBSkVGdOZfLgEObr0J86FI+KK26fpJjhYxtVY8tgCnqNlvNRbjRMkzRqt6JQ
	ArDaXV8CMspBS5tFtbXimHIzyQJyATNXeZA2R3kqOzMIVd7B3b44IdRFc/HVKLkz
	QQoCed0JcovfJ7mfl1h+rC0NhybFtR4eQmc9wdmDWqxNARoLM+0LWxfkK7LpamYh
	JaU62yc0RAd3qFQvM0UgHTVMuHb3RZnBpFgxjhTTEs2nWWoV7UC2jLs7KDGqG8FK
	VTAEKQdlmMTO07Wp05ypqYmmTaJ/HJrcq25nUXpiINH0UmD3tAwIYF5XG8vhcQ1+
	7/ekVw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfdk762m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:13:44 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-286a252bfc2so84267955ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 22:13:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760418823; x=1761023623;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+r0How+FgbvW7VMlqsJ4Gwuo804o+0P5HhOrz8Iggic=;
        b=Z55IFf50hVXAX8VNKNo2u1/kJbrBtfH3wxMLjQeeW+NdUZI+1ALF5o7Kf5p+rnxlpc
         HR+QqIvRPcxtioQgBac/JzJM/UDmsHTdeha3AHrIArZBkvbCKPxozG43zCmhIklcC5XE
         7AcuspjgrqDLxGU5FgXfBsUMFSNOtfHgyeQ5r+O+1GLpddv38fREF7koA4aXLQY4HdqB
         cH4YJGKf+VC2qVD8m2uDvYBkbC5O/jqRF9zPU/BTBBz+PdT8n2RhW5EKVXOigfWTrJZz
         40Sop7WHpZGY5J8cmbJklKX/gV2SB6iyyS6Ks7E/Sj3gOPLKxW1/7luR7oeQaIStq9kb
         Jb0w==
X-Forwarded-Encrypted: i=1; AJvYcCWfGEa2ovX5FT8JJq701hWDtAJU+F81CBrfLQzsUvx81FP4MciTNXV4AejzMGoONCkjA1K+AXO+L8zNf90=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdvZGrI52Maoq7oLC/cvChVTEkYVAm7uvs2eUscQG9kDt0I4WO
	A6mX3Cno0AECutHeoupR8pKd9XMQpjW1FtPECwc7FFW4MdrhKJ8vka8zIKg5429TeoDCqPeABqB
	7cvJKgERwMydyGVY9xOr1+/erWeLQ6Ri0N5eSRNEliJhV/4IfWKNhi6orQ/846WUy+SE=
X-Gm-Gg: ASbGncsR15mQwqpeHE0RoeMQFFtuBPf83G0pKDYQINHe1Vs6dhfm/YifWD8n0J/G9DC
	Cs3Dorcc0YN4fKOBBZm21g1ZHwEomyZZyGekWLM5BNSn8Y7e18vK3HbU29CqgzBuM8+WVV5jO8G
	Do4RW7RpNhsa4t1yyU+SKB8JX9blQwbq5cFMxLCOx8++BZkMHflTtfMU0hOQMXcqQ1Y/1H+wxuQ
	mA38jGAskMZede1/VCveykQ2R7D28NGgDPrwn4sOQT0AaU4cCWqcUZemEelJn7YI+P8niAQVF0l
	uuIFXJFFlmTHqkjRWxwJBCAWCRXDFE6/73jh9PTTnJn8lqNMQn8iIbofHuoeVqAe/pafB9/6kiG
	iRpYRG7RO5IbJUfzwARMVkxEGf9dLWyAOrcE=
X-Received: by 2002:a17:903:903:b0:24b:270e:56d4 with SMTP id d9443c01a7336-29027e60bf1mr282984315ad.4.1760418823187;
        Mon, 13 Oct 2025 22:13:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdt4dMK4a+NhzHfqRnuUEGX/Ugq/RdZkYVruAOzFTYYwT1X0g3D1TkCwSDZGCJIPwCSD702A==
X-Received: by 2002:a17:903:903:b0:24b:270e:56d4 with SMTP id d9443c01a7336-29027e60bf1mr282984085ad.4.1760418822759;
        Mon, 13 Oct 2025 22:13:42 -0700 (PDT)
Received: from [10.133.33.138] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e1cc8bsm150928265ad.38.2025.10.13.22.13.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 22:13:42 -0700 (PDT)
Message-ID: <6e21173e-dee8-4c0c-ac80-db53be92fe4a@oss.qualcomm.com>
Date: Tue, 14 Oct 2025 13:13:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/20] dt-bindings: arm: qcom: Document Kaanapali SoC and
 its reference boards
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
 <20250924-knp-dts-v1-1-3fdbc4b9e1b1@oss.qualcomm.com>
 <c2112d37-c937-4132-b9e8-e46b1fcd0516@kernel.org>
 <1b4979e5-0491-4f4c-8c0c-b7d519dbf54a@kernel.org>
Content-Language: en-US
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
In-Reply-To: <1b4979e5-0491-4f4c-8c0c-b7d519dbf54a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: uzNsenezL6qP_Yc5Mre0K2CDnIiDaNOw
X-Authority-Analysis: v=2.4 cv=MrNfKmae c=1 sm=1 tr=0 ts=68eddc08 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=chr4P-twNQjDrvfbXYUA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: uzNsenezL6qP_Yc5Mre0K2CDnIiDaNOw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfXxPYw+Ri/rnbI
 ogvWfBrYIj3+7LHNLNmlP/LQEGzUot5JFnsm7piUWWuDErw75pQlkaacicZ0BUsEo+2wWdPlGaE
 C3JSB9rWM7XeTGthqElQLPHJL+7tNl5C+xey3S9HziqjRltzlQyhLNp4gEq2ezOFmN0lEUIMopF
 LcsOkNEh+DZ49+Lj0Za8S4d6uL0K4F07lBEBvHfNGxKE+XP3rttyvHn5+Vb7fY9UDEiZQ2XSmUy
 PJeJHgs9d6RhZOmyF5q8doyl2gci5MZ9ppghlJRNkw/+lIHZcMjPrALYEKiqSOU//v++y2esNzU
 LIEIo3p1W4VcjMjpIFSGlnYmNyw0Ln2dFuKK7KUMv/BQllEtVAgiURSo4DpIOreYQx5Qiq3iSjX
 QjG9xapPcgZvv0NQecTeRUcElx4Y0A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_09,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018



On 10/6/2025 6:24 PM, Krzysztof Kozlowski wrote:
> On 06/10/2025 18:54, Krzysztof Kozlowski wrote:
>> On 25/09/2025 09:17, Jingyi Wang wrote:
>>> Document the Kaanapali SoC binding and the boards which use it.
>>>
>>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>>> ---
>>>  Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>>> index 838e3d4bb24a..0e84220e835c 100644
>>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>>> @@ -321,6 +321,12 @@ properties:
>>>                - qcom,ipq9574-ap-al02-c9
>>>            - const: qcom,ipq9574
>>>  
>>> +      - items:
>>> +          - enum:
>>> +              - qcom,kaanapali-mtp
>>> +              - qcom,kaanapali-qrd
>>> +          - const: qcom,kaanapali
>>
>> This will fail testing, just like Glymur did. I fixed up Glymur, but it
>> was rather one time.
> 
> 
> Ah, this will not fail testing because Qualcomm switched to code names
> from obvious model names, making existing patterns non-effective.
> 
> Not sure if this can be reliably improved now, ehh....
> 
> Best regards,
> Krzysztof

yes. I didn't find it fail the test. However, do you need me add patch like this?
https://lore.kernel.org/all/20250716162412.27471-2-krzysztof.kozlowski@linaro.org/

Thanks,
Jingyi


