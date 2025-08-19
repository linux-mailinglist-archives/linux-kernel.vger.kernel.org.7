Return-Path: <linux-kernel+bounces-774828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8818B2B824
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 05:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ADCA56230C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 03:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F622FE577;
	Tue, 19 Aug 2025 03:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="o+AlCtZE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB572561AA;
	Tue, 19 Aug 2025 03:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755575847; cv=none; b=PGam90v95kfBjzuXZFzJOJ8/ibEghg2Q9ivqAtjIk6tQKqnq6LcOWfE8lmsDlmxgQLalgkaA4AjqFOZW9N9i8B1kkvq8FHWc7wt0ug3jj3tdErekDTr0C6ayY5jlOK9ClvXj47pwH5KX0j6N8tqv9WOPnLeiaKq/XPaMuN6jHME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755575847; c=relaxed/simple;
	bh=At2jkJ8aylYF1xB9MMvdNHKYV11RS+nZpADpXo6y/dE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RyG60ztFiyyG4T67KVHWuA9MKbOTKIATPjbh3hBK0H1OLihpbc8mec/h9NMOQoNQmFIWt6joOjoQ6XxkUSUT7izjbEtfjiIIuZvztsu2mBaOwQXL/XQzVmSCLp2L/3dlPBpiUS24hpxFiQjuBAG3opS1aeXEgXlXExnTo1cTWVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=o+AlCtZE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57INmqqO007382;
	Tue, 19 Aug 2025 03:57:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	StMDBVKortgOhhJKsIQ9RZeB6Vb16l5YgBhhvbiZ/wQ=; b=o+AlCtZEd5BTscSX
	G65sB7a6O9YxJjPVnmJExwawBBEoIuGcu0ZXV8lfvBVBv66uxnkdixRT4DStowfb
	R32qpCR3AfFBktoaYTPV8NIyI/wZnsmsPsD3Rc3iDRhM0QqImX6Lpg8i8DY7AhgU
	wfJaxege8uuBpp1A4WjKX9Bzo/7EWjHOa3wKobklD6K/6tlXHsBKmh0igDGSdAIJ
	uajmWaKrNTqiyyUiePg0DAgKblFtTdZBY+vxGXveh7+JsrwK7gSvJCTMhXbGJd6E
	sKMBhjEPQPSg5hp1+oyLjYazxJWaBkiuPBcNBQLf08qlYS8iplA9Mb7mWwopqKz+
	kPRPdw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jhjyf3a6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 03:57:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57J3vKml007261
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 03:57:20 GMT
Received: from [10.239.132.245] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 18 Aug
 2025 20:57:19 -0700
Message-ID: <1aba663d-67d2-4672-805b-7ffc20d0e2ff@quicinc.com>
Date: Tue, 19 Aug 2025 11:56:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] of/address: Add error logging for of_match_bus() in
 address translation path
To: Rob Herring <robh@kernel.org>
CC: <saravanak@google.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250811095342.2383808-1-quic_zhenhuah@quicinc.com>
 <20250818164907.GA1437284-robh@kernel.org>
Content-Language: en-US
From: Zhenhua Huang <quic_zhenhuah@quicinc.com>
In-Reply-To: <20250818164907.GA1437284-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fpj_S3QOfyFX3NNkQgva-P_rQgsIqzP7
X-Authority-Analysis: v=2.4 cv=ZJHXmW7b c=1 sm=1 tr=0 ts=68a3f621 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8
 a=FjxdCwQbLTSeBlRUKooA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: fpj_S3QOfyFX3NNkQgva-P_rQgsIqzP7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyOCBTYWx0ZWRfX2wCq+ARmxauj
 X8ElKeB8qM5sfa18fhOZEu82RckkFzBiNrXHR1HqB+8m6QNnYTC/IzBG66cO0eXQpcTmwPAfWlH
 GxSNTfiVdUY64Q0A83mdwDHaPabS/PNxxfyE2YJELe2QIv9D4rBXiO8yGMlR1e5HwkbxtkVpnN9
 p85bCoojgDcv/vGLtnsu16dGJ8Db3B2/i+fG/QMn07uLZlJjgdvudIHCY6ybSib82Qxo5f5gEOs
 vcgRqeaas9IEEEgAKtJKMVzYQxfCX9y3+wBugHjUwHDYEjFhfM2KKNwyGYrb5dXqqgDOb4ZqQts
 bOWQsu8bdByG6DqUipauGRN54RmrIvfqBQM1iavD4NsiYmiCTClUTK+ljh/09Eg87StbdgjUX6M
 RH5ZdB8B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160028

Hi Rob, Thanks for your review.

On 8/19/2025 12:49 AM, Rob Herring wrote:
> On Mon, Aug 11, 2025 at 05:53:42PM +0800, Zhenhua Huang wrote:
>> The change introduced in
>> commit 045b14ca5c36 ("of: WARN on deprecated #address-cells/#size-cells handling")
>> triggers a warning on the direct ancestor node when translating properties
>> like "iommu-addresses"/"reg". However, it fails to issue a warning if the
>> ancestor’s ancestor is missing the required cells.
>> For instance, if node_c lacks the necessary properties, no warning will be
>> generated. Potential issues will be trigger further.
> 
> The point of the WARN is to only to check the immediate ancestor.

Yes, that's exactly what I wanted to point out. In fact, during the 
translation phase, a warning should as well be issued when checking the 
node_c as described below, Otherwise, I noticed that the translation 
failure tends to go unnoticed in practice... which is further leading to 
other issues etc.

> 
>> node_c {
>> 		//NO WARN
>> 	node_b {
>> 		//WARN on missing of "address-cells" and "size-cells"
>> 		node_a {
>> 			xxx = <memory_reion>  //contains "iommu-addresses"
>> 		}
>> 	}
>> }
> 
> Whether a warning is appropriate here depends on whether there's
> 'ranges' properties or not. If your schemas are complete, then they
> should warn on missing 'ranges'. If ranges is present, then we should
> get warnings if #address-cells or #size-cells is missing.
> 
>> Since of_match_bus() is now expected to succeed in traslation path,
> 
> now expected? Nothing changed in that aspect.
My bad, The wording may have caused some confusion. What I intended to 
convey is that for example the of_device_alloc() path, as described 
below, of_match_bus() is not expected to always succeed.

> 
>> routine __of_translate_address. Print an error message would help in
>> identifying cases where it fails, making such issues easier to diagnose.
> 
> For errors in the DT (as opposed to errors using the API), it would be
> better if we can check this at build time rather than run-time. And
> generally I think we should already, but there could be some corner case
> that we don't.
> 
>>
>> Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
>> ---
>>   drivers/of/address.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/of/address.c b/drivers/of/address.c
>> index f0f8f0dd191c..cd33ab64ccf3 100644
>> --- a/drivers/of/address.c
>> +++ b/drivers/of/address.c
>> @@ -515,8 +515,10 @@ static u64 __of_translate_address(struct device_node *node,
>>   	if (parent == NULL)
>>   		return OF_BAD_ADDR;
>>   	bus = of_match_bus(parent);
>> -	if (!bus)
>> +	if (!bus) {
>> +		pr_err("of_match_bus failed for device node(%pOF)\n", parent);
>>   		return OF_BAD_ADDR;
>> +	}
>>   
>>   	/* Count address cells & copy address locally */
>>   	bus->count_cells(dev, &na, &ns);
>> @@ -560,8 +562,10 @@ static u64 __of_translate_address(struct device_node *node,
>>   
>>   		/* Get new parent bus and counts */
>>   		pbus = of_match_bus(parent);
>> -		if (!pbus)
>> +		if (!pbus) {
>> +			pr_err("of_match_bus failed for device node(%pOF)\n", parent);
>>   			return OF_BAD_ADDR;
> 
> If there's no case we expect of_match_bus() failing is correct
> operation, then the error msg should be in the of_match_bus() function
> rather than duplicated here. I'm not sure if there is any such case.
Yeah...
That’s what I initially did. However, in a case where the node doesn’t 
have a "reg" property (as with the "default" of_bus), the path below 
will call of_match_bus() and fail. In such scenarios, its failure should 
be considered expected ?
of_device_alloc
	of_address_count(np);
	..
		__of_get_address
			of_match_bus()

I moved the error checking into __of_translate_address then, limiting it 
to cases where actual address translation is being performed. Because it 
appears to be MUST successful in the scenario.

> 
> Rob



