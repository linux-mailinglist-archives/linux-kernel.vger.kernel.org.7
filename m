Return-Path: <linux-kernel+bounces-835711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64693BA7DD2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 05:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 256323BE33B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 03:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F7F2135CE;
	Mon, 29 Sep 2025 03:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a+QkdYWQ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD91A92E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 03:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759116539; cv=none; b=O7GvgZTsvGBXuLMd+llD7jb1Wv+U4k+idzdMUSeON8tjITr+y0c5Q4QzKC9qIg+q1wg933TOwiIDyESORB1a6W9P6ERaJpKYMjoUNUYz06TqL+u7OcjCsL2hHU6olerR/y+Lu5crBoWyLJK7jMe19gNQPEbcWl/ekcEiPuf4XIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759116539; c=relaxed/simple;
	bh=d+oWh3J/8FcYuoWe0/ZRwK5kyq7hn3yhAFbF2sHJPCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tai4OCLKK1DMo7mfh6ZyT2gn5HJFKs1iyHQfbxyHrDiNtXkPF+GFiw5APdP3eMZuUt+iYpKtzrvAECaZApzpIRvAGzcMbv73m9bRWsW3W3UR4lJeYxxr0zdpa0qvClsDsVVm2QNdRWdTzFq2QxcvxJ/ELnPbz/4U5udJzStjcl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a+QkdYWQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58SNgwGY032185
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 03:28:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BXCM5FcXq8QuKbX49yIS6uSqjr5lzhikG+yLwyTe8JU=; b=a+QkdYWQ5EkEBw9H
	Gu0LM28SZiFyFQXUL8HFZhu8BsedFlrS0kYWBlnHqvopX64wTCL8sQ9YpDPskDHd
	3+w9ts4q1UueKxBGop0Xlilxa5jhH76iDv/pHJ01K25kbXySamDhXPub/rzN1gT3
	2qTbgmZNaNfQ3ktR6M5y+D5vsypoDc+x4zVHzPKiaPORdo0RbwapyOrL9P1Iu2i6
	gy29QUoOnt8S58e85o8v5071+24jYD9NUJSevnKl+Hai0ZWDpTzFi7CPvWO83NMV
	6eRhoVpBvX0I1Tv+mF3Rx6kr5dQH0nmZjJ1SYwCmjIQe3LVMqJs8Eqr73qHul9ex
	5LtS6w==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e5mcm02w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 03:28:56 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b5af3efa195so559048a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 20:28:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759116536; x=1759721336;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BXCM5FcXq8QuKbX49yIS6uSqjr5lzhikG+yLwyTe8JU=;
        b=eMIqBa1anbA4zKs+45am3tdx3QuQmK0IxQKCH2oWN0P7dKTjdoYkVmRgqT58N+EfbB
         qSwA56edcQq0yv9ZsJzj6mSZ+iHDCiWi83WIO5fjxEKLz2LMrgRbd8GjvBGs0vJZOTrE
         XR4dX6JnoYNWYrc1f2cafiB0rvZ9tdkTY70L/oAsgYXj+oqgNjCjUN2gL9/5Bxp2IZWC
         HsKO2R3NBnkAuVOV2oI02oDrmwaIgWNUkP8yCevg3CjzreIC+f8qenLNbkv+SMEHYiLI
         zFDILRQkmrfkBQb5n028vL+fEDbCU++E9EJ/r5IhWm4LF5F+m9QGZ/jv8f7BNq4qN0Gj
         LmEg==
X-Forwarded-Encrypted: i=1; AJvYcCWxxOsZFqyk0fCEpaRO2fj2AVcL2JqFCX7JNbf1L73RHzpHhVpBW/VwNvSIbbc2nsLRm4EVS0JW8lsFA4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGb1ZYEcAsbB/koU/Myw69cJUkpubZzmzU8ADVWtdJgYG8DQHu
	PmNwsun+0iNhdGsIFzc/0gTqD8Y/G3hEFVkpDutiirRDK67/rRwl4c6Z2CHIPEeVymYNomYLpf7
	U0aASq/BNXH84h9IRpT2eCBYawyZu/J0vNhhIrZBPou2crP3lkVB4h+rZXZ0+eK7A6xI=
X-Gm-Gg: ASbGncun6WzEJxlaI/+rYFjqj82InSLqguVOc2Iagj8ko/kYbso2PFgfAbky1lOLT4j
	9NObDbvd8f8p/tonBy1r36T5Dp7/j+OBQ2wI9TiLnvDeyrJzu0X5wVcWqO5C5Zvbvvkr3G9Iym+
	DjZjgQUlrA5L6jR9VLDPbXCL/oy3b6AtCrxD2neraaDMI/7lTNGdq9M+p263piH7FgS6OPALCG3
	QoZR3MTwjjw21RONVYGLx/2sTiD0YBBr5CVT9N6+9xHePUvLw0hF+yexRRtOxEIVgyjXmqXGMu/
	9SJgTYS7hRHH8E0IINeIsi9Z8etTRTOGoAP2Zx6ndKxH6yIViVLqrY5ZCcNfYwloH4O2RGCXf36
	9XJtucCaXzWnpaZ4UjzbiTzqOgoOtqUpRA8w=
X-Received: by 2002:a17:903:1b2f:b0:272:a847:cabb with SMTP id d9443c01a7336-2818ba15c22mr78998445ad.28.1759116535933;
        Sun, 28 Sep 2025 20:28:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTMPBj1tCYC1tlWu171y4/7crBZa1AWAZ4SMl5J4neepttiCfPv+lqw8NhHYdwwrWdlvP3Xg==
X-Received: by 2002:a17:903:1b2f:b0:272:a847:cabb with SMTP id d9443c01a7336-2818ba15c22mr78998235ad.28.1759116535509;
        Sun, 28 Sep 2025 20:28:55 -0700 (PDT)
Received: from [10.133.33.234] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69a9668sm112686175ad.112.2025.09.28.20.28.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Sep 2025 20:28:55 -0700 (PDT)
Message-ID: <c8ecafd4-43a7-4d16-8e18-91ea8a51b92b@oss.qualcomm.com>
Date: Mon, 29 Sep 2025 11:28:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/20] arm64: dts: qcom: kaanapali-mtp: Enable modem
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
 <20250924-knp-dts-v1-15-3fdbc4b9e1b1@oss.qualcomm.com>
 <iexa64nrdqmwitvunl3inmgtmhufphl3p4p2kbvhgcsb2y6l7j@5tpt23yd6jzh>
Content-Language: en-US
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
In-Reply-To: <iexa64nrdqmwitvunl3inmgtmhufphl3p4p2kbvhgcsb2y6l7j@5tpt23yd6jzh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RMC+3oi+ c=1 sm=1 tr=0 ts=68d9fcf8 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=OM6vnnba09aMTPLxVAcA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: Hpw24fri_X_SvMayZ989D6XoEFU0eirs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAwNCBTYWx0ZWRfXx3FlUS8vKSOv
 2N5tkVjjUQwEocEq/nP7xbL2u3xOttSZVbedVHqm8oPusDTabdBaRQRV1+etmKYAHtHMFbGuWkb
 scJfLsMNmpQbybKQAPNVp4swliLuffq/hlgDrPzLoqTCuZDOfvypIIL5R+xOFzxNkTkZMfng8qI
 z5ut2YvwiLoCJU+zZCjikWmb/wcgmTFULiDo41E5ypOH6t8L6lxr4Fb2y+KdEraKYQyb6aQG3zy
 8Ezm0nFEgsvbbmD6tbOEOWoP+09u7H0Yn/lBqunMGnluyDXvk0QHY+Xs3Q3QeWrO1H9jMcJMcSH
 corguUbWSoRNVRfhY5uukFtLM6nrklNBzcxH7wF7F4H0lqWzYDJwj/U/AfHF9fQtzCb2QyK91CR
 Bo9Uu8nXXweIzoUYeff8v6rcsfUgnA==
X-Proofpoint-GUID: Hpw24fri_X_SvMayZ989D6XoEFU0eirs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_01,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0
 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270004



On 9/25/2025 10:10 AM, Dmitry Baryshkov wrote:
> On Wed, Sep 24, 2025 at 05:17:32PM -0700, Jingyi Wang wrote:
>> Enable the MODEM on Kaanapali MTP board.
>>
>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/kaanapali-mtp.dts | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts b/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
>> index 2949579481a9..8d1b3278389e 100644
>> --- a/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
>> +++ b/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
>> @@ -1263,6 +1263,14 @@ &remoteproc_cdsp {
>>  	status = "okay";
>>  };
>>  
>> +&remoteproc_mpss {
>> +	firmware-name = "qcom/kaanapali/modem.mbn",
>> +			"qcom/kaanapali/modem_dtb.mbn";
>> +
>> +	/* Modem crashes after some time for OEMPD load failure */
>> +	status = "fail";
> 
> I can't call this 'enable'. Why is it crashing?
> 

We see it crash after running for sometime, it was following what SM8750 do
to mark it failed. 
However, we will follow that Bjorn suggest, omit this patch or enable it in
next version

Thanks,
Jingyi

>> +};
>> +
>>  &remoteproc_soccp {
>>  	firmware-name = "qcom/kaanapali/soccp.mbn",
>>  			"qcom/kaanapali/soccp_dtb.mbn";
>>
>> -- 
>> 2.25.1
>>
> 


