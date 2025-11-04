Return-Path: <linux-kernel+bounces-883944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 917B2C2EE16
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 02:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BBA03B260C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 01:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8B623B627;
	Tue,  4 Nov 2025 01:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="edFqSMLY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XMzm+XSk"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8492972614
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 01:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762221039; cv=none; b=uy/EBt6xtB4IxmHobMFxXX6I2B40njveILoJOLAGDnIkXNUeq6yPinYdQj4iFxVA6uQB18qXGz6Ds1PRTiXGJKApfRuwkXOP9QXY3n8+0QYdaQqs+qKU6BTh5y/iVnnG35niinsJI9JYhlgAd2JVAiNmLRbVQRHDfnKlEGLZFcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762221039; c=relaxed/simple;
	bh=PibFDQ25ugR62we1fK9/nybor8EzFUEB+4IMfRigMNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=feIl3p/Q7oBnx8lxnqRgDW7UaWKQHR4JzpYxRn8G+3yGOk93GCOAqcry1EdqiqoOsFelisOToyZxK3ehLWYHsB9S85mBKw02gxKY74Q8WXoXSpnkU9reUzs87XKyUNdcaPsOvlSCuR/sJqK0N1y8sHelJhE6zJ4vIRoh2y+9vAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=edFqSMLY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XMzm+XSk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A3H69Cl3659464
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 01:50:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wPYsBBo7fnXXXzJItxQunK6FnbnE6vdOwkJ2g13GBko=; b=edFqSMLYL4iqumzS
	j4ABtpoBJtIxQmPiy+j7fFyfaUT4PU5s9PLb1/PGtAWOmO43OtFkQIl2Sr2g4qkN
	hhKfHvgxQCCjX/3orQ07aN8cGTzQ35S6lQh3+O+gtqsyrNHS6ma2tEQ7ConeXqHv
	gQCSzhGf7OfLpIb/RJD+4K4nJNLgHZbrDq3IFB5igYZiuuQjwF+hLkgYH+B0QRWI
	NHZLqhuO19O5FZqJoxtwk3XcOCwh6ZTUkGzl+K3g4BzzpWkzfiRk0+iPxdH2zaON
	8LzQYjdVGrzPpR5HZ8K+V8aF6y+hRPW1+P1mMiZJZ2zLUteL9NBN4Ih6gENbRBgl
	aKbylw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a70ge97t5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 01:50:36 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3416dc5752aso1488438a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 17:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762221036; x=1762825836; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wPYsBBo7fnXXXzJItxQunK6FnbnE6vdOwkJ2g13GBko=;
        b=XMzm+XSkJeFEhk00DAphHmwhsDp0ytQlf1TDI6F9qPKFqX9DRUtiLlMW9svEcY5aAv
         xyeo7gNmtshXrLbp9RbB+hAW5FHf8TnQDehI9J1yXW3Yk81dtah0OjM12gzn6D7EJn7j
         qo1/Y4BJQ76+LlUUgixvBzhjT6hjyPg+/5YSJaRYVcbhU/zu2APDxBW8HlV3t7Bfowjm
         mmC9bYyoOXKsE84T3r5ctTb1iJDokUbmrBCbE3AwnWS90jS0j13Zp7LRD21Bw8RYfvOH
         forZAmz8zV2OtNZavXtKeDEkWpp3pCAP1IaVYLV5xo4/FHJfwRr+LZ0dKtz5CvMEc3Sa
         QKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762221036; x=1762825836;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wPYsBBo7fnXXXzJItxQunK6FnbnE6vdOwkJ2g13GBko=;
        b=fLEBsXBm4mV1kEL1AdGCIHNRS8ct7YWLcZacjAJsSV5aD51Gurdv2qlQ4KvXhnVUCm
         fHYX6/T/iHKEuKuWnXfYi6sZVT6NcqPIS5Zdi1QwZjVSHFqOOzkzrVqhHWivhNawGGJm
         FpfsJULDfbZsQgVIfGu7viMIdAcAWeeHWBgJL6lGmtMmAqnJGO/MrkNiwHbIGpvzZ8lT
         WDm9cWloSYLIs+MA6gFoORY/hgzy6hhee7e9WJPPKfeNDNhwWY0TYgL+tATysk5e34g1
         fai6L/qOEajC81/pkbOPHBowIOZ1X69ZmYLGvrGjQUrMNpb7LpQXhGivkbLOYLdrtY58
         wooQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUFtmfizbQe7E+fXjOngsg8GglsRnz8tBEJGmEr8a2kdtjLvRcvtoRu60NUnFzWWcViUzlUzom74HDRT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxTFyoyDOdSt2PlfYyiC8vWNULuSb0N7aVDPnYIv8h9jlWbzA/
	/HclbtdNfP7eAvr8t4JCJxNQ0VoH06em6gOG8oDOOzMk8JAEBaslyaiuOwlOvbt2QZ2j3u5Nyvu
	ek9av+d55V7Q8AyLxIe6LbKCo9/Id5OtPmgDK42rcBgaFbKDE1t2VQ/0L/5I+PhnjUps=
X-Gm-Gg: ASbGncunuSN567+sZwDwurfXMtSGxFZ8nK+dpxi8b29lU+1WlBqm8ncT+oKMz7TPMud
	sAFUkptlj8CZl/z9A0nabt+SbIHNK1YxJHia0AseEXNZ9Qbl8LCXDbik0hnjkxIg5g3/nOaGmeS
	xO3chogM31vKscBR4PxZ9eZGq+zZ1rHwW2yzu/UWm4Zg9NgfJGqEyididgapySeoe0XWNnQkAcV
	Nxh1cVfOFkRCReadmySbGcmLu/It1uyjO5D0R00NMC8Q4L5YOMZm0XrCO7mfR2d78A4jKHran5u
	jzmL9UOhUBDXad74PuB/8/GL9a+CQm6qQfVl5y7F+w6rAEzVf8u9GJMXywJoL9INA588ZvWp7cP
	qWtQ43lBWs9Q4hFVnQskrCqIj1RzP+p4AeX91qKSTHhUX7bijzik6+HVvs6qkvZRh
X-Received: by 2002:a17:90b:3f4b:b0:338:3cea:608e with SMTP id 98e67ed59e1d1-3408309b548mr17530413a91.31.1762221035855;
        Mon, 03 Nov 2025 17:50:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyansn7mgWcP4IJb3o4e3eOY6gRagfuQjf/6eMbS+UTgq1USmHgRvZurhobqtjJlUa7yjUqw==
X-Received: by 2002:a17:90b:3f4b:b0:338:3cea:608e with SMTP id 98e67ed59e1d1-3408309b548mr17530383a91.31.1762221035316;
        Mon, 03 Nov 2025 17:50:35 -0800 (PST)
Received: from [10.133.33.139] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3417bdc53d8sm363780a91.2.2025.11.03.17.50.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 17:50:35 -0800 (PST)
Message-ID: <133a1f4a-c578-479b-8906-0a70b8a74947@oss.qualcomm.com>
Date: Tue, 4 Nov 2025 09:50:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: kodiak: add coresight nodes
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251103-add-coresight-nodes-for-sc7280-v1-1-13d503123c07@oss.qualcomm.com>
 <114cb239-d0b8-4db3-8972-77ec3a24825b@oss.qualcomm.com>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <114cb239-d0b8-4db3-8972-77ec3a24825b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ukWfbWCZpIk9JG0j7lWAZq0BVyTWg6bw
X-Authority-Analysis: v=2.4 cv=bqBBxUai c=1 sm=1 tr=0 ts=69095bec cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=1GZQbPL2OVBrrJn17Q0A:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDAxMyBTYWx0ZWRfX+Lya0u8HvjK7
 7eBVpVR1uIbwCPL+togjMqP3bR1lhl9Pt/KKAJKO5Um4iL3H9S+1uePTJ1O7GVHI0KyqwE1UjyP
 tUVuPhjwhO2azLsVd72+O7I12MpP07jNOjkdpc8/LYfoGYTSUDF0UnYwivV7PZcDnnl5S3VLceH
 sHmcP2NoPVT/hgilpQHrmoEBNdYM3TIGJM21ezfb9/nSfmf8q4HLW7kcdNls/NYNxo+G8XVxu8q
 TdjubjFNHegU7y+WzlQOiXeohcB6cnOsXBpciFSTQCoqPzC+SMjyCnJL3La4TFnGHIkrE28QNMw
 gefCgbE3evC51Wdz1UUKzfxlIce0O+XjqsJmtiriok8TuRChaEwCyjJ2h+8nvRtNb0R8XFh50h8
 iu55Myq4tlA/PvXWcUkUz11u9OTrxg==
X-Proofpoint-GUID: ukWfbWCZpIk9JG0j7lWAZq0BVyTWg6bw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511040013



On 11/3/2025 9:15 PM, Konrad Dybcio wrote:
> On 11/3/25 9:35 AM, Jie Gan wrote:
>> Add TPDM, TPDA, CTI and funnel coresight devices for AOSS and QDSS
>> blocks.
>>
>> Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/kodiak.dtsi | 290 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 290 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
>> index 3ef61af2ed8a..09aba1645408 100644
>> --- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
>> @@ -3338,6 +3338,85 @@ stm_out: endpoint {
>>   			};
>>   		};
>>   
>> +		tpda@6004000 {
>> +			compatible = "qcom,coresight-tpda", "arm,primecell";
>> +			reg = <0x0 0x06004000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
>> +
>> +			in-ports {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				port@1c {
>> +					reg = <28>;
> 
> Please use hex in 'reg' (just like you did in the unit address above)
> 
>> +					qdss_tpda_in28: endpoint {
> 
> and leave a \n between the last property and the following subnodes
> 
> [...]
> 

will fix it.


> 
>> +		cti@6010000 {
>> +			compatible = "arm,coresight-cti", "arm,primecell";
>> +			reg = <0x0 0x06010000 0x0 0x1000>;
>> +
>> +			clocks = <&aoss_qmp>;
>> +			clock-names = "apb_pclk";
> 
> I see 15 more CTI instances following this one at a 0x1000 stride,
> followed by a TPIU at 0x06040000.
>

I defined this CTI device solely because it manages debug behaviors for 
STM, ETF, and ETR devices, which are already supported in the upstream 
kernel.

For other CTI devices in QDSS block, they are related to other blocks 
which are not included in current patch. May introduce them in the future.

Thanks,
Jie


> Actually a whole lot more debugging hardware. This patchset looks
> tailored for debugging AOSS< as you briefly mentioned in the commit
> message.
> 
> Would it be beneficial or useful to (perhaps in a separate series)
> extend the support for those?
> 
> FWIW the various register bases and field sizes correspond to what I
> can see in the docs, I can't speak for the port numbers. Please just
> fix up the style issues I mentioned above.
> 
> Konrad


