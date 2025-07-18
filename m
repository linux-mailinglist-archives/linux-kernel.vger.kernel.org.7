Return-Path: <linux-kernel+bounces-737201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 181F2B0A912
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 19:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D38A13ABCEC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 17:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641742E62DD;
	Fri, 18 Jul 2025 17:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LtPNppuR"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523372E5433
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 17:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752858409; cv=none; b=Y2oXUh/yVVL7b1xIkSA7rcKn0kIkl3QOnFkmlzQ28ruFrN8gmtXmrH44C8lzxaggGZmyYEg+QD0f8ahF5jah04SOJeAOoHoN/Bs33Kb5xToc9r1J0IcXfLndFX4HKi2pGXz/DJHvUql6tYnkxemnIWV5PN/UuTQejQJ68dU/xvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752858409; c=relaxed/simple;
	bh=+DY68w5ZNmT+VTpHTgPRVOK5a5ospGjPiJz62zw1bC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qx82W2hbSL1ix5TMaYKtP/labOXO9xRZR2gOkAAZkpPlUciLwD9HyqRchmH7wg8Sj+x4tLlZ8IWYtdb/+Ne5aZ6E9UD2mCSskWE7f8QjUUla4gjDcRXstOVtDUn77gfiyNjusAoRMhiRUaDTCjs15X79HfJmZ5iXBYnOtLXq0tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LtPNppuR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I9bxwA015972
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 17:06:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5vUfMJSGq73ZhN2Mdd4o8iq4iDMXCQpQz47NqFacc8Y=; b=LtPNppuRlpljDRB+
	7ENW6FqiASG6BFMKPAXEWzfokX3cmkanxm2ltmj/sGrkdVxbRUOdqsF7hAE53+Fa
	NGObv5q+71AxPd2yaGzcETuNCYr2jRLdhx8gQHE8+4gMZpQ3tjRleqJ3CFLwcINY
	cQp71QxTno2rwd0fDQY+fJrLsdUZNVkklDOMyk9XHD6a1rL9UnnuZP9zIHnIQ+AB
	5oKI/StVoKSBKV9wdEUNBJcBTIOXeC3rbBLBmquiX9PxlP2lHz32+ogsq5/X+g6Y
	iTlLtxB3iooW/FcCI4VGQxncb9GyuDXM8nNy0yV+6Bvm5fJ88aKhivOia7j58+HZ
	OyEzXA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47y3tc491s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 17:06:47 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-311ef4fb5eeso2373463a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 10:06:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752858407; x=1753463207;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5vUfMJSGq73ZhN2Mdd4o8iq4iDMXCQpQz47NqFacc8Y=;
        b=PQYU019A7l6M82qPMS+8ekxanXecUt/az90Qi6LzkbdmBSwNOmbdM2DQv8sjeqYUYE
         wqsMZ7RqW6s2RNUSesoXWVoku7ilx+fgfGgXpdJUtnqc7mynETP12T31LCqhfCwZq0dw
         8js0n7tCbxgjHgSkWLv6m0L0JpNtn+CteGIi6Xl/X4Sez45ZNxYi3QPeDBtcMuWeEM4P
         ZoXdLVmZ7fa5Ma/BqcWGGc5oaqnW3RyGGMhi0Hrwbm7RMCDr0G0y+sQWsYLrdJxkrlBo
         E9ey4q6MQcZm78Ify4dQVydyG0DhePd1mtbAf2BkvkDN+cQdSnQq80B85dggDeUu9RAj
         c08g==
X-Forwarded-Encrypted: i=1; AJvYcCWuy1iCeDx8u/Sn/8rFXLhyeuNiXKfSuHTyqisdBEtp4GUdjSC9VUVtiAer4gFVF8IFmpJitzTF1bdDmks=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhH31GBzIh1fom3LsQl/avAysIgsmxFN1cnhit0k8vbmOCDSMQ
	Y/2NqtTMh/gAXpU4PNN2UWfM9Y2x58x/iLFLpneyxmYOqFtppNIW4+M7IDAh8owrg5n/9S5qytP
	ay4Xzwrdt3epWq7Nez54NzS9fVVwBw06uLgkcYsAZXJFIcZ8hKHBhs/3xnhIhEO1r7kc=
X-Gm-Gg: ASbGncvFNtdtnHLJ4h+kCNUg+ETZJDgfBfgav0lG6LDP04amYgZqpbOGljkYlccbrMc
	PU8WACDe8pCYGwhptAUfOgS33bhIYSTuPx7ks06Tai6zvWO1sriT+0fmGdxCOn/VIlV476aXR+A
	0sk0ys/3O6r6xoUaClnanyt5P516LZSjs41ULQ1XKbFPfU+kFCtSY6kPLz8PL/t+GGF1GgsdOSE
	6yk5oQWD8fzXfaT+DUl7xf6OaRUwlh8BUVZtHAu65aWschVrX272dUe0uOKWrJdqrTguZZVYN78
	WFx/H6l96CUbAoiNuf4Cumc1P0hxVSIfWYB8lbnWq6qAiuJpYQgAkVf5ogi6E+qpBt4=
X-Received: by 2002:a17:90b:3dd0:b0:315:aa6d:f20e with SMTP id 98e67ed59e1d1-31caeb675ccmr11172870a91.4.1752858406630;
        Fri, 18 Jul 2025 10:06:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECNd4Acv4j/c4235fliuFvXE3ktSNudNK8CmPHlGkQnotpSNMV7ho5S5lABhdRD4LGMCNDEw==
X-Received: by 2002:a17:90b:3dd0:b0:315:aa6d:f20e with SMTP id 98e67ed59e1d1-31caeb675ccmr11172834a91.4.1752858406140;
        Fri, 18 Jul 2025 10:06:46 -0700 (PDT)
Received: from [192.168.0.195] ([49.204.28.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cc0be8707sm1455548a91.1.2025.07.18.10.06.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 10:06:45 -0700 (PDT)
Message-ID: <0057e05d-efb6-4114-9a3e-f1166a8e99a8@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 22:36:40 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] clk: qcom: Add TCSR clock driver for Glymur
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: sboyd@kernel.org, mturquette@baylibre.com, andersson@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        quic_rjendra@quicinc.com, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250716152017.4070029-1-pankaj.patil@oss.qualcomm.com>
 <20250716152017.4070029-4-pankaj.patil@oss.qualcomm.com>
 <vawtojqbjrtoso4pjoza7vpaiog37hu6gbt7g6mmwbnmwladtx@ebh4amrwxwkk>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <vawtojqbjrtoso4pjoza7vpaiog37hu6gbt7g6mmwbnmwladtx@ebh4amrwxwkk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Z5PsHGRA c=1 sm=1 tr=0 ts=687a7f27 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=tMiizUMu9hGndvLFPAJAbA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=n_IKRFwyw7e_LvP1qQUA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: 6ELU4OP3xoX5dfnAbsWKi8Of3E_ksSst
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEzNSBTYWx0ZWRfX5bDd2buXZFMW
 sX3hobqm6oj+i0EuEFy9u2cx3EoekFcEIYoVVH2r6Z73ohTGSt0QP7/rmVn64sf31VZu0f6jnT/
 qsF/GL02YYclscE/UbRcfni3I88aO4yywfpMOYQI3YqsQY2GRtGzbBliaYGPc3WObltYPlXdDZk
 v+9C/yGbfFQLTn24Rq8laHAigqfve0W6t8v4L6qw/prYq2rBxBOodTRGBhqw2A2MVliPDdroSj8
 uer/2je+jVbP94UPEZieb8K5mP6djntXvuEUYYRFu6li6pQy6zPq2wvhaki7QZhX0fN3nAZqIFJ
 eJ51yHtTHZOBrGpVg9tb4HAQ2e2dfzVpesNd1nTvWGi66qAEKtDk8ECsJ79G+dAQoUEJU0bIOxb
 Lfrh9wS4dDVcQw/TYaVr0C0k6i3E0eTRxBN4JBBu9bxhueYYcDebr9mySK3bTw9NNh6k++xc
X-Proofpoint-GUID: 6ELU4OP3xoX5dfnAbsWKi8Of3E_ksSst
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_04,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxlogscore=958 suspectscore=0 spamscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180135



On 7/16/2025 9:05 PM, Dmitry Baryshkov wrote:
> On Wed, Jul 16, 2025 at 08:50:13PM +0530, Pankaj Patil wrote:

>>
>> +
>> +static int tcsr_cc_glymur_probe(struct platform_device *pdev)
>> +{
>> +	struct regmap *regmap;
>> +
>> +	regmap = qcom_cc_map(pdev, &tcsr_cc_glymur_desc);
>> +	if (IS_ERR(regmap))
>> +		return PTR_ERR(regmap);
>> +
>> +	return qcom_cc_really_probe(&pdev->dev, &tcsr_cc_glymur_desc, regmap);
> 
> This is just qcom_cc_probe();
> 

Will take care of it.

>> +}
>> +
>> +static struct platform_driver tcsr_cc_glymur_driver = {
>> +	.probe = tcsr_cc_glymur_probe,
>> +	.driver = {
>> +		.name = "tcsrcc-glymur",
>> +		.of_match_table = tcsr_cc_glymur_match_table,
>> +	},
>> +};
>> +
>> +static int __init tcsr_cc_glymur_init(void)
>> +{
>> +	return platform_driver_register(&tcsr_cc_glymur_driver);
>> +}
>> +subsys_initcall(tcsr_cc_glymur_init);
>> +
>> +static void __exit tcsr_cc_glymur_exit(void)
>> +{
>> +	platform_driver_unregister(&tcsr_cc_glymur_driver);
>> +}
>> +module_exit(tcsr_cc_glymur_exit);
>> +
>> +MODULE_DESCRIPTION("QTI TCSRCC GLYMUR Driver");
>> +MODULE_LICENSE("GPL");
>> -- 
>> 2.34.1
>>
> 

-- 
Thanks,
Taniya Das


