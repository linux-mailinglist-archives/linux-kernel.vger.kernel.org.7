Return-Path: <linux-kernel+bounces-737236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76108B0A99A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 19:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9231E1AA886E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 17:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2592D2E7643;
	Fri, 18 Jul 2025 17:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I/7pbHCN"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C152E7629
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 17:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752860254; cv=none; b=h7fEHxM7sA9BhwDLEb3IykQsuSQmGw3tb90MuQ4I4FeG1ReWYvM4YbcXhQRnfCzyU+Hqz6ReopIoeIbld7+u+ctYmfTSxN3FiNWj/wYyFIJseSlk81OLB0hZAVw/erppzv06m5lP8VHZzNrpts7SMVnZIwPmYQfFNz9PUGS7qE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752860254; c=relaxed/simple;
	bh=Jp1XqFkdELGuoMkw/LjGQL5oKQgMBjwV/r0rNb05WHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bp5TtWxp4IIPzHY2IjQO2vRre2vLMW/7wajibDBLSPHHWv0+oCPLXNUUrOkR/vUpQ26fodOU/ai2MuJKYcZ8KLULSQEh041vK+t28gPhYIGBv5fh8UgVfslNkQGFQFx4VDfY6d/MPKne682/AMS5oJbUIj2WY9IPvzPo2l5Kxu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I/7pbHCN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IG6Yna032365
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 17:37:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DbmW9l10evhVj/WcPjTCyWMiSSALM7/4VQmz6IFqWv0=; b=I/7pbHCNKoxqjt0d
	p9wMuOFhH2rdGi+3XLuuJLcfUwd/5RaHKxwdyXJNPFumvuRqFKKsMeG7g4r7rOMb
	CIs9AslrXszcPrdE0bKqwc+10M9bh4gH4ACiPDSNjs/ClEGKlrgznsjAmq9VlfCu
	w6tVuyZb/jcc0EYFm4WKxffWg9CHTlVOlavnyjh4iF57NUpk6gDV6Me6w11BOqCy
	Evx5A3WTTVq7koEHgj2LFUPkrUf3ACEBSGd6ljPLvS0hfM5EaASqu75m9LeYtsjd
	nbLdlR0pDSFzjrGtshLeakqx3/fxvSIsxG1CPGm9BSPHnKvsx1x0gewdK848eR51
	183yfA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ug38cm16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 17:37:31 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-748e6457567so2162298b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 10:37:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752860250; x=1753465050;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DbmW9l10evhVj/WcPjTCyWMiSSALM7/4VQmz6IFqWv0=;
        b=ThxgA0takhJ8L6JruFB1DdxqcbBnHXAe79+cV0StBRN6HOxUAbExNfHFdL72T7qGdo
         pWRO/zaIFadznvNSPTSV/OgWG6ziWA+aRGemPD3OyWPj4KZJEUrHlwrw5ks0gvUkmjKX
         v6VP5hukBQlAant0bF2R5d4fth0ANVzFjFRj84zw7tIhvUxBAmZzOKiA1sFsrTbzJGJ9
         EFTrblGSQUjHSa3o/8KNa0BAcKaglJ40R8nfBNAIhK5GtI6VZSGGoe2eEsMh3cUQ1PM5
         RYTPwf5zU1drQzWdG4Y0jleHqUoQ85x18x8JIKlprnDNJg1EO6mHPNOl3YRztkuW8yP9
         5SkA==
X-Forwarded-Encrypted: i=1; AJvYcCVXBFpeH4BCBJ5YURQtL3y3Goq2LfCVOE84J+yl/+ej4zQedylk0BSqfSDza6jABOoeOSnmMhigXBze7qg=@vger.kernel.org
X-Gm-Message-State: AOJu0YybxvQqTgl4HQT0dYAawjs5YgxcPZFWzLGMdsV3zacfE/GdGbcL
	osqzuhb3RHAop87vZNH3bqIT0SPs4yvxtag3mqhaOM41gwT/9fMFf7s/wujsQxCXVkB4w/Y8cQz
	LMkA0h3teWrmLKKXZyG+8W1gYZsVLwZ4twZ/8LpVQFMVPuHhs/db7UrlsU9J+iFj+kqw=
X-Gm-Gg: ASbGncu6UOfJ8vqBhGE9DUHy5edsw/cCjaUDMIBeQPRHPcI0FeHES1A053OtzWwL4Ab
	xjdkOsTvFxttEF0v2gwUZqtoaT2ZhVkKTCvZFlb1alVx4r23d8SGA/FV3TA2bDOLViJQrTJLDHa
	vQs65cfueX/OuVcQEOPXXjcU7dONhE8E8FUR+qvF+Sx/QJnRYp82gQB58fuHUEnsYehiH6ApMDp
	xPMg4IsVduo76L4P+2QAx0wOdSRJGC9qN5B4q4vQW2CD+tB6CWuswyE+vLBqRbiiTMaexfK83hH
	ctp4caC/vreDPLFB7YFw3KOdOojsMwtxlRurBdpQGjYVe+m67k31XzLmY7N43HxdQ0k=
X-Received: by 2002:a05:6a20:430c:b0:224:46a0:25ef with SMTP id adf61e73a8af0-2390c7f698cmr13397778637.16.1752860250370;
        Fri, 18 Jul 2025 10:37:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGS+WhE3jQDC0YVjY/4E/XNzovaX5vUwzvI27UOQtAKYgfzXmsNsUeiIAZoMDUSIbvOYGM/sQ==
X-Received: by 2002:a05:6a20:430c:b0:224:46a0:25ef with SMTP id adf61e73a8af0-2390c7f698cmr13397740637.16.1752860249913;
        Fri, 18 Jul 2025 10:37:29 -0700 (PDT)
Received: from [192.168.0.195] ([49.204.28.43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c84e2b48sm1581307b3a.19.2025.07.18.10.37.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 10:37:29 -0700 (PDT)
Message-ID: <2f5b5e6e-5041-453e-b3f7-b10b40bc6f57@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 23:07:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] clk: qcom: gcc: Add support for Global Clock
 Controller
To: Krzysztof Kozlowski <krzk@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: sboyd@kernel.org, mturquette@baylibre.com, andersson@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        quic_rjendra@quicinc.com, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250716152017.4070029-1-pankaj.patil@oss.qualcomm.com>
 <20250716152017.4070029-8-pankaj.patil@oss.qualcomm.com>
 <aHjJG2nrJJZvqxSu@linaro.org>
 <40534488-24f6-4958-b032-d45a177dfd80@kernel.org>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <40534488-24f6-4958-b032-d45a177dfd80@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEzOSBTYWx0ZWRfX9DAkPeDJxlDL
 f6qQfvK/jWPF0W0YBp3fpE1wQ00CzU5bW202NwTxGvZ5OZM1JO4j6M2zSxXMBL+t9ow2WmVf2m+
 25mm//v8ukpkRKbnqsljxWEgO18yaHgLHmXyKga+5ckchk2NRGtUHtt7u6E30akMYBm63WqswGu
 yOIYTOLPwgKhqlEXK1/w/YNjout28K6ibqu+TmvGSQxwBboyrWY80Bjoelm4fy794ulEXPpYlmH
 E0ZFdi/a3VGa1D1IDYk+T8+jLKEiMSZkVe/HpQxkUKSy1dWg+YzWUA567pQ/N5/IpgSMAyWUu+I
 TcaU0oLM3QtURd2DNHrZgXf0b06Kf02Ecxn8XPAb9MQw3U44WuENASsUOG2fHnYCT0CWoqQBLXs
 VbD3eJxu53eMtOyquMNC5Lw3OFxYI7o2uVC7qyhwCdQOCwPylb8uvytB212XZ2UhXgGS+oUy
X-Proofpoint-GUID: KPhG5vtel0j5dlSxQcAJnUOAcXRbglRF
X-Authority-Analysis: v=2.4 cv=SZT3duRu c=1 sm=1 tr=0 ts=687a865b cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=tMiizUMu9hGndvLFPAJAbA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=ZEZnheZsc53CzuolOOIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: KPhG5vtel0j5dlSxQcAJnUOAcXRbglRF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_04,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507180139



On 7/17/2025 3:38 PM, Krzysztof Kozlowski wrote:
> On 17/07/2025 11:57, Abel Vesa wrote:
>> On 25-07-16 20:50:17, Pankaj Patil wrote:
>>> From: Taniya Das <taniya.das@oss.qualcomm.com>
>>>
>>> Add support for Global clock controller for Glymur platform.
>>>
>>> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
>>> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
>>> ---
>>>  drivers/clk/qcom/Kconfig      |   10 +
>>>  drivers/clk/qcom/Makefile     |    1 +
>>>  drivers/clk/qcom/gcc-glymur.c | 8623 +++++++++++++++++++++++++++++++++
>>>  3 files changed, 8634 insertions(+)
>>>  create mode 100644 drivers/clk/qcom/gcc-glymur.c
>>>
>>> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
>>> index 051301007aa6..1d9e8c6aeaed 100644
>>> --- a/drivers/clk/qcom/Kconfig
>>> +++ b/drivers/clk/qcom/Kconfig
>>> @@ -645,6 +645,16 @@ config SAR_GPUCC_2130P
>>>  	  Say Y if you want to support graphics controller devices and
>>>  	  functionality such as 3D graphics.
>>>  
>>> +config SC_GCC_GLYMUR
>>
>> Wait, are we going back to this now?
>>
>> X Elite had CLK_X1E80100_GCC, so maybe this should be CLK_GLYMUR_GCC
>> then.
> 
> 
> Yeah, the SC is meaningless here, unless you call it CLK_SC8480XP_GCC,
> so the authors need to decide on one naming. Not mixtures..
> 
> 
Glymur follows the "SC" naming convention, and historically we've
adhered to the format: "SC/SM/SDX/SA_<Clock Controller>_<Target Name or
Chipset>". This structure has helped maintain consistency and clarity
across platforms.

The case of X1E80100 appears to be an exception—likely influenced by its
unique naming convention at the time.

That said, I’d prefer to stay aligned with the established convention
used for earlier chipsets to preserve continuity. I’d appreciate hearing
your thoughts on this as well.

-- 
Thanks,
Taniya Das


