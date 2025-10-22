Return-Path: <linux-kernel+bounces-864556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E04BFB11D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DABE43A95F6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472C131062C;
	Wed, 22 Oct 2025 09:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CxVwLt9V"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2170B3112DD
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761123942; cv=none; b=qcDH4935gHRu0A55vWkoY2TXn/Ob5JOumZSyeJ0RckdKS4tVSAbNeIJMp77SfTldGUDIGsWYRDChLz5+z5fs4flKeqr5+FBToGgcNjBzabETYkTEWMrmqPkUeCJ7dnaegaHVSh5p6/y2nYNnVYxumEAOCcSZSjuO8y76u0/yQSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761123942; c=relaxed/simple;
	bh=wS5DT7BWV4uV5ZvU5mnn+fEhExFzCB+DRuJHf+SENic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HwmHUh+ifxbrOf2tgYs59EN7CyeB3DFeSKvwkrhrmhjYoa2PhTRd6vBuVtVg0HkAIqqmUJR/llnT4Q4CYoISMIdq4EF3UAs6SSqQNby0ttXNxBkwHY8FNUXtxHzwyS4JfQ/r6+sYzmZRcmsfTWTzYohAK9LgwG6tyJDGk4l6Ils=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CxVwLt9V; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M2TSfq018880
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:05:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bsrfquIJpzFXc2FilbTX1vy43Kpj0kOdyEtCjzikM2M=; b=CxVwLt9VZmlbDpod
	4+rfo2275Nw7STiLuhqhDRN2aYv/J+zSVoNj2gs14h6XPfwV/BhENRXBsTnp8t/g
	BjAimAFTbsJJ3KZRZCOCWYAxG1UjP56UixDqZ2lWmSBZH9TNQ7tXcHsrD3WDWAv6
	RchLEuRXQ22K+FjdP75aXTF7+3G1K3aeryAxJkgwMOUfXCKIB3N/SAfL6AOOmJSe
	fyTtUV+sskSr/3VauxP0wWU51rQfKmrRZv8sgD0HnZNMffuLD4JX12xvIjN3WxQs
	R5fa7yr6lWN7eMZLsIHeHuhIQDv3R18kaHJpDXAbcNktD9pBBjEpH9ii0N8LfzKv
	lBmU5A==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v469kxy7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:05:40 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7810af03a63so13949980b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 02:05:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761123939; x=1761728739;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bsrfquIJpzFXc2FilbTX1vy43Kpj0kOdyEtCjzikM2M=;
        b=E+8MKypoAapKt7EBHjnWabzypkoVHWtu/B6byhC3Kv45dp+MiPYTsFfWlHv4KNEpP3
         toTZiOL+rDCLkXDBY6pSIb+Qu4S95Dg9VccC+mbNfbVYGK3qkuAm+SjU/sxoPbACFnug
         66tJFLpZIqws5Km65N6G2yw21vw8Lg12xlFEUKXWmy+kug2z2EMhUm/LXVmXokFEluPe
         mrzkhEK19UU7dQHEVQsVkM2tEtbf9iS9WP5rajJXvkItD9eDHCgcvJudv4LHHkMvVLMb
         g5rrdoPNyay3ZgMTJcI99++519hgcDQRJdsAZRR4tdZTBZxwGwsWj9DWHkRhDt7qhAO5
         u1zg==
X-Forwarded-Encrypted: i=1; AJvYcCWf6Tjs9zhNCxq5rRq824lv1HbthsPVAeVQK6hmOhJtLed9fIbZQn25456rGixGcvNeb3PrDIybWxiM2sw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8sR4xZgTx2i54W6c/Gg7aJ5xLrNYP+rXzM/VknTwKP5qQ1JGw
	0bHAnnaSinxUvbhk7qW2Id5XB7JQJrnXKkiYPWbGJzK1C3A440UVQO6CDN7dmGNq03qkdm+uhzq
	zl0BY2t6c5p+BMmmD5FKtX07hAxoy5rDbbjHpYkwwfZWR9ztYHxA+25TcWT7ECPrmIp4=
X-Gm-Gg: ASbGncu71uzup73dkm4+FCy9m2lipHUl3G8rP9kSUK9KqZShp05ZZysGi6koP0nn77K
	O+tqjuKKVmRFM2eor0rmKqVj0EhnsFP0OOMtHdQfQ2hfZq65MMTtrg10eLFm2BsCPmLSRRcGoCd
	hOFtJw4KK+7jkqsgjT3ZaUSbrrULmGH/M+0yOxY8WoDrV4kk25qZSOgrRnMZbmYBQ6Z2XBgj/YF
	q4lHK05LSawxTGTS+JwykehCRaiXD6+shN9sRLyRJIFo8sfxVR0Ry9SRHmmWMux/YyTBzU9YdFA
	lakVMUPKhExTutqCM1NhiO8WqCUX/GSmT39tn+hot62vyiOGjMCqksXhWTbLnJcx8AtQAMO1kEq
	PX8L7tzkhSznGNSUK9wOI60XVDf9oRugF6Vai/aY9D2HBUYm8INcYTdvrkDpqtima3oru
X-Received: by 2002:a05:6a00:2e1f:b0:78a:eff2:6c0 with SMTP id d2e1a72fcca58-7a220b1dd00mr22923273b3a.25.1761123939501;
        Wed, 22 Oct 2025 02:05:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmUd9zkX8gCBSMsvB3mHoi82sPlnQQBw5hd2VmV+Dvu5ix6FWXnT92B4liD5XBg1v3lQipeQ==
X-Received: by 2002:a05:6a00:2e1f:b0:78a:eff2:6c0 with SMTP id d2e1a72fcca58-7a220b1dd00mr22923225b3a.25.1761123938989;
        Wed, 22 Oct 2025 02:05:38 -0700 (PDT)
Received: from [10.133.33.84] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff15878sm13836649b3a.10.2025.10.22.02.05.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 02:05:38 -0700 (PDT)
Message-ID: <4eebcb7d-1eca-4914-915a-d42232233f9f@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 17:05:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] dt-bindings: soc: qcom: Add qcom,kaanapali-imem
 compatible
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
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
Content-Language: en-US
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
In-Reply-To: <g2iviaqetgxf5ycz2otzkpmmc4goo7xuyjmttuu254bfzqqvkf@4vybjh4eghpm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: I7fSuiaD71G3Ktvghl-07uw-sWrdvhbK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMiBTYWx0ZWRfX4HGolj2KG8cB
 q45ECDW8wXbEyMhNlynKWM85I28nte+wJdG5cppIY8a5qC+h2zMHQoEA4GUzlMacSH2Qhl/+Ca+
 IHAJZte4O9UncVWUPh6hX1aRfi7Lw8xahAHg/ta9+zhrrv3KVZ9v3zLPJs6Nqdl864qxQ8qqmM1
 2c8M52q4fa5f0rjmI1RgOu6I6PmWxCGylh5NGSjJE23pWorojrJ0DPLYR1QvosYxvVnvHv6IWDP
 46zQaDI6CACNZsS+Nt4i9W9t57FH+vh0WDbu4gkugQKkG4f8r94kBULfHsxeBINu57hqKr2hrBL
 n52VirCY3Yr7FyV32lRy8XAFhYBksB9MiIxmpkDDL72Pgzb41ybvdIZRetPVIyMmDUJs35zD+uI
 rysuOo2ucWlxbI80gZr6jxkG6/AR7g==
X-Authority-Analysis: v=2.4 cv=U8qfzOru c=1 sm=1 tr=0 ts=68f89e64 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=R3H_AMJDI8O4ISRxb2cA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: I7fSuiaD71G3Ktvghl-07uw-sWrdvhbK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180032



On 10/22/2025 4:49 PM, Dmitry Baryshkov wrote:
> On Wed, Oct 22, 2025 at 12:28:41AM -0700, Jingyi Wang wrote:
>> Document qcom,kaanapali-imem compatible.
>>
>> Reviewed-by: Eugen Hristev <eugen.hristev@linaro.org>
>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>> ---
>>  Documentation/devicetree/bindings/sram/qcom,imem.yaml | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/sram/qcom,imem.yaml b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
>> index 6a627c57ae2f..1e29a8ff287f 100644
>> --- a/Documentation/devicetree/bindings/sram/qcom,imem.yaml
>> +++ b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
>> @@ -19,6 +19,7 @@ properties:
>>        - enum:
>>            - qcom,apq8064-imem
>>            - qcom,ipq5424-imem
>> +          - qcom,kaanapali-imem
> 
> Can you use mmio-sram instead?
> 

Here is the node: 

		sram@14680000 {
			compatible = "qcom,kaanapali-imem", "syscon", "simple-mfd";
			reg = <0x0 0x14680000 0x0 0x1000>;
			ranges = <0 0 0x14680000 0x1000>;

			#address-cells = <1>;
			#size-cells = <1>;

			pil-reloc@94c {
				compatible = "qcom,pil-reloc-info";
				reg = <0x94c 0xc8>;
			};
		};

other qualcomm are also using imem, could you please give more details on why
we should use mmio-sram here?

Thanks,
Jingyi

>>            - qcom,msm8226-imem
>>            - qcom,msm8974-imem
>>            - qcom,msm8976-imem
>>
>> -- 
>> 2.25.1
>>
> 


