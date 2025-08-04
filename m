Return-Path: <linux-kernel+bounces-754901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0CDB19E37
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 11:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADBF31798EB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 09:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E4624503C;
	Mon,  4 Aug 2025 09:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H/j00l76"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4398F246780
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 09:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754298269; cv=none; b=foogMEJ/zWFwgMG8o8t1wAqiK4PDCT2oMYcpjcwmUt81+aL6FKJnZe+0YCZ1Uwq6hnbiNmTOnKfRGc+AuInoz6KUq414RrGSkkYIH5jaXdArZi1gXAlAnC5kbNe6aWnYuItTkF1/A8l6jO9f2N+607KtjGjn+FurxzMHMaw2j0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754298269; c=relaxed/simple;
	bh=3ynaIvsBNRVvZd577WmJObLTK8KxkOoTLbIepnKpTrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nWUwbfGGMMkjKWV6Eyz58hfvZ0KRNfTSydcmfXUw2VJW/JVAK0tqZs1UFXyJMhUMlVmYnmGKps8+IWIYKRlt/HYNproAqBu+nLPYWqD6NZITD14vUhfMrtfC3YEDOkbkHGoP6rNsmn7IlCXcJvprTKIths/I9yQBQOgX15maXqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H/j00l76; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 573NmrVF026828
	for <linux-kernel@vger.kernel.org>; Mon, 4 Aug 2025 09:04:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yxj88AoDLPC4Xz7nvIZCrmjG+oBu2ULVQ7Y3/Wt0Pxc=; b=H/j00l76Mr+gYapm
	+ZtxUX6bjTjpCIenYszeIdCS8nnZ+QQ7m5Ja34mr+hTJZ3N3w4ClQQnp7jW5sQEy
	kB4zFodR5A65bMjtX0cI9EDDKEvW1WyOqCDZFthtLgb9exhVJ0CAGt42dgiCYQzU
	WT0WmveQ62UM9ig64TDyxkD3he9zgjrl26+NSII0Ox0P6oc7So5KYV5de6y0KKto
	wZqCavNdiTBD62Yww9JsFsuOVHeEmhUDBgyBMQIGq/K/3bbe/sQRV+BNPmCW27oN
	oEQWD4hC/wcRxehaOfK5IIEkLhqh3OCMRXZJ6BThHhpBEoN+3nO4KJMvtdlA3dPw
	a9QMGw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48981rmhwx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 09:04:25 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e48325048aso84983285a.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 02:04:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754298265; x=1754903065;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yxj88AoDLPC4Xz7nvIZCrmjG+oBu2ULVQ7Y3/Wt0Pxc=;
        b=HQSQo4ZR1jUE99NIT2FlQJE6ZNOgizghTZO5aWMFhZQ1c9fLe51eFetqAyGj78o8r4
         TYGBtrWGxpZg3wkjQdtnCQYRK7ioTyNIJBrf8SKwk3z5722SDS1q7/cDq38KME7XaHab
         PH/yyULYP9TE7P/gnQd47l15UwvI93rMRRQRCnDl8nVYNkzo7GbxbOb+ZOV8LJ/OoEHK
         4KlYUlalojk/RENLB5AGQhcK85wNz0/KcdTqx30Aeyvu5mdCTmeeEnh1tr4zgywiZQS7
         Z9nCaozwtR2HwewBlvAOH4XI1FYymFGWrJqHmbkt5A5MdOuVj5gy33l8+JHAO4ZhOQl2
         G31g==
X-Forwarded-Encrypted: i=1; AJvYcCWQIUXqlN7kFXA5W2a3Hf7hEuqhgsrj1TqoQWhWEVGgz3t+mY30LVX16rclKj1mu0nQUeTFEv/MxABHbmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNec4LG1tNKloWc/pkqXwmLKT9GmD8TJv/TUnc5Rcma24NuPO8
	q0CGrKHrGg/T9Ywf3oPn24fmgGhNLpIfqkDdxSux2FG4kVINlcRTo1VlbPO1xJboBE4CROpYHl6
	CSBknp+Nl92Zc1S4iOpMCQLK1TFEeWcRrRWp6Q5hyN+Yqd80nmxSXVl/mwhaA1T/vZrM=
X-Gm-Gg: ASbGnctjLvIhulWgNQriIe8/Mv3sg8xd9lVtN6WgZ0ofWS7N4qIh7unXGRSVqQtsm4W
	HdfDDAmaFcLFEVceMapBxf5ChaM1J3dwCdRhC0WcgkPYm/8DtlXQnFaQpTO+dtM/USMaFq4W1LM
	fAMCetU7gZGbMq+uMxDbeKon4ZqaVjBhAl95KxhFWrTvk5fWWOwgoDLhhs0RHc/ZfKr92scwISu
	FvgBv0lO4r+GYyOBMDnBjEYXLvPkZ4jz1I9i5q2MbyJXPqDXqNCiRBndPivf4esBRmDzTbTmhWa
	Czrt0xkMOtxENBdvOvq4JtiFh0txx77tRAep1djvQlLp6T417rxa2bo7S4EqiH0r+B+Xsv7RyvP
	psvd9XK24adwPsgZhQg==
X-Received: by 2002:a05:620a:40c6:b0:7e8:5bb:b393 with SMTP id af79cd13be357-7e805bbb656mr66103685a.4.1754298265103;
        Mon, 04 Aug 2025 02:04:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHT5U6nf7OFxjlAHz3AXwYcJmyL/ozw3xGtfssCSEsyIVFeEN+uSY6B0F2EWAEjbDHiy3UmaQ==
X-Received: by 2002:a05:620a:40c6:b0:7e8:5bb:b393 with SMTP id af79cd13be357-7e805bbb656mr66101085a.4.1754298264504;
        Mon, 04 Aug 2025 02:04:24 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91aad117dsm695375766b.77.2025.08.04.02.04.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 02:04:24 -0700 (PDT)
Message-ID: <93403461-c0b2-4c0c-91b3-8cbd4c1c5ebe@oss.qualcomm.com>
Date: Mon, 4 Aug 2025 11:04:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: spi-qpic-snand: fix calculating of ECC OOB regions'
 properties
To: Gabor Juhos <j4g8y7@gmail.com>, Mark Brown <broonie@kernel.org>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250731-qpic-snand-oob-ecc-fix-v1-1-29ba1c6f94e5@gmail.com>
 <72d5f805-1637-4c82-af25-e78b978c5799@oss.qualcomm.com>
 <8883471e-57b9-4492-8d4a-aca3b4538682@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <8883471e-57b9-4492-8d4a-aca3b4538682@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: jVNPsGSobzUHdlAZtMOW5dpoDhC1tHzC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA0OCBTYWx0ZWRfX0twx5xRsBMFZ
 gVA6rd7E3PQS6FcA5e/hHkL1wXShpY72XAylERkuz9w9Z2YfL+nL+hEhurzhOQ/+6tbu4lIh9zg
 +uK+WFUscYnrhlg24OZVZEbZMh7vX9fhM2K+wKI0n7IQLbh1uc/hjZzPPn9GHzygT1Frk4rZuXd
 OTmvUYsFGXmtMT9O0eOSbGFwnvc7zn/G1rhTzSQNeZN8Iimpv2plfcxbcONm7AoOa9THQapqIlk
 5w7uS7gCmVctUFvgSjXFNBRn0hiNM6uKFQV7f+BexMruq2UNNVcab3479XWEbT7F7VKAQgUTVSJ
 OBsleThVYBYK4MXQKqcXHCdt8o4TFp2GbDDsfJieIP1tib5OH+K1wI9twzMYrQyCmSPleo6m1VE
 EHlYDZ70hqipXDaVqPFd0kcRnPo7o6uyqSP3BYpdeQ2MylzH3W5supFnTj0v8GJhYHIvF+FV
X-Proofpoint-GUID: jVNPsGSobzUHdlAZtMOW5dpoDhC1tHzC
X-Authority-Analysis: v=2.4 cv=a8Mw9VSF c=1 sm=1 tr=0 ts=68907799 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=sgHexgGcLWnyGziH-awA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_04,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040048

On 8/4/25 9:22 AM, Gabor Juhos wrote:
> Hi Konrad,
> 
> 2025. 08. 01. 13:56 keltezéssel, Konrad Dybcio írta:
>> On 7/31/25 8:11 PM, Gabor Juhos wrote:
> 
> ...
> 
>>> --- a/drivers/spi/spi-qpic-snand.c
>>> +++ b/drivers/spi/spi-qpic-snand.c
>>> @@ -213,8 +213,16 @@ static int qcom_spi_ooblayout_ecc(struct mtd_info *mtd, int section,
>>>  	if (section > 1)
>>>  		return -ERANGE;
>>>  
>>> -	oobregion->length = qecc->ecc_bytes_hw + qecc->spare_bytes;
>>> -	oobregion->offset = mtd->oobsize - oobregion->length;
>>> +	if (!section) {
>>> +		oobregion->offset = 0;
>>> +		oobregion->length = qecc->bytes * (qecc->steps - 1) +
>>> +				    qecc->bbm_size;
>>> +	} else {
>>> +		oobregion->offset = qecc->bytes * (qecc->steps - 1) +
>>> +				    qecc->bbm_size +
>>> +				    qecc->steps * 4;
>>> +		oobregion->length = mtd->oobsize - oobregion->offset;
>>> +	}
>>
>> How about
>>
>> if (section == 0) {
>> } else if (section == 1) {
>> } else { return -ERANGE }
>>
>> ?
> 
> The current way follows the implementation in the qcom_nandc driver, so it makes
> it easier to compare the two, but it can be changed of course.
> 
> However, since the 'section' parameter is an integer can we agree up on using a
> switch statement instead of multiple ifs?

That works too

Konrad

