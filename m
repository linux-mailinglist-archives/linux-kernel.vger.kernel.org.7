Return-Path: <linux-kernel+bounces-875908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7357AC1A17A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 50A354E6B74
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37B93346B9;
	Wed, 29 Oct 2025 11:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kBPu1obG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b5smWCxt"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F5532F758
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761738161; cv=none; b=jthwlqfuiBV4oRAM9zBczZT1ET4++c6RsuU6y6IU+angTJBOKxj+NTeGDq5egIe3oPzuNkca1fUkbsfLcuI+dh68/GA/P5LD7WJg/BdJemOwrwRFmSSe448x5JfTQ2a6QXEX/CFh/Mjp8WSfcgR5pF99mf9DfvM8LMQn4bkMs7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761738161; c=relaxed/simple;
	bh=GK+h9CifNt1/N8ART1U9SkukAckkPwLv+RPCo//wacs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qb2xbq9DnHP8G1wSJQmYzJ1SrdvZp5BDtb7gWxTxzpi5m8ViFXX6ZECdlEYCLDTE2N5cRndUEgfptVDwADLuUJ2iS9o2t7cl2uTk2rsM16Eqe1H0TKmfD37d5YHD30hD0cq3V5HmFzqLQFdMrHUTwEZ2ZgsUH/+cM11eiHcuF40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kBPu1obG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=b5smWCxt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T4uxb23663627
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:42:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	82QGbvIm5tIICRw6Xgbk0nOud47sW9k/+sQlIS7mO38=; b=kBPu1obG6oBpAV/w
	rX6X70BPCMPWiaukpiTfJP+34elZvgCzHBot/M9AVAFwmeqqDGCwdp2IBOkKE5Ud
	+AI3X5yJlR8i+f1tJargKwLo8JBsMR7jgVr9kMZsR87LILmaV1GLpUf5vIyiCqs3
	fwr1I9PbworcjvrFg9aK7FSfI0tvRr73SuFCZUUN76gUvQ8Td8SiE+Z5OGhRbs+1
	GG3alG/4DMG7NhoI1S/dWUamLbesF9jlmwDrwvTbonXjn3zI0cbrUZt8jaMYA1FJ
	QtHDYgMe0WO2zqjvN97P2ydt1lgWAKjnvGJref17Uea6tGqBsCS0dJzlxOmSr45O
	vqQqHA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a1tb75-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:42:38 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7a43210187cso2401127b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 04:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761738158; x=1762342958; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=82QGbvIm5tIICRw6Xgbk0nOud47sW9k/+sQlIS7mO38=;
        b=b5smWCxteP81vgHgT3zGSnQjtevKViAfvvl/oAizWixhLPrFOEgeJrP0HyHLGQXfyC
         LukVoiGdsjZg9sPDbTcGpmyDJMCZSemMqwD4TrDTRLWT3GczHRV9U381ni3NPc5PQXL6
         7eCQeHoCNkX0KxRvvsSV/L5bUqmeNYUbuwHjVTicEbsawj4TONYNp4FKnJNlSnL4SnFu
         HA+Fco+lDlhkBk7dh0fSOPvsvWp4aG696Lrcicvfkw25wjafUN2o87+boocDbFjPf/Mv
         8uNc2akCIwCTexWh57UwJ4mfrOh9Ngh8loGEpMbiYrpvYHd6lRsBxIQNfyBgl55l6TzS
         nW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761738158; x=1762342958;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=82QGbvIm5tIICRw6Xgbk0nOud47sW9k/+sQlIS7mO38=;
        b=ZgEIZPsYIMbrQ33foV3sCgDcSJe1ucnqnDCxexzWQ2fk5A5TqnES7XyPyhSTKNFwZB
         mvDFAiD3VrJetLZ3NJ/TdCNaJhkrEOczsx/IW9jDMzNe6dYVzlvAGYzNhhTiUoMgQ5dm
         8DZJFRgh6OIDuZS3yyeHIMigoXkNgKccSbFBX9hjhyO5cUOFGd7DNK2k9b+TwFlUaag2
         b6D4RWLTm7ulpl7lWHoFgaUvoqrD9vBLmKKia6xy1OO7MHvd32sfQFW43M3Fha/gJlVf
         OxEN8SYZFEF7iKAfwObxL5O8CkwnAMZ0LwGYnqcdSfOUAbCvhv2w2nxzdAfSgfdx7ukP
         eRrg==
X-Forwarded-Encrypted: i=1; AJvYcCWbZn1h/D4N9L2mcWFnVjoSD+WoS3PK5cqoOM0wq6kxp8Tgop8bD1cVRLDkYZ3xl+4pXa/FI48vZ0cNUJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIeDPWaBwgOjqR4r/2rwNGqFwKpxmdbuTQ61NaAQcfPONdbQE5
	zXKLyR6RE3jWvAwqPYToYXgpHU+dUjOAZuRD1j4fHwQO/T2vHw23Lib4ezALcPN9PUBf2/G8wKG
	LLqtW/hQTM7syYvk92DjPgNJJgmrSckaiJCip/jkbfg4V8INboP3n/mn2+/QrI/uF93I=
X-Gm-Gg: ASbGncvf0D7KFkaB0ZMMMz+bDOcfAOAjriRxchKxe9V6jnfXIDyNXll9TPcaIbYjb0c
	Q0hg1brDxfoCEWXdkRMe7HS16M85GlOusNnCkXegyjCphBf4oW1mfmBxrwY1e7tMhevsN/LxLyh
	GQjfB6KUCcGtwhn78dP7mxyJJsPJDc3iqltYMA2nj0Mj8ddJPJr6PNcW7HngU01jXoNXkMhlM5k
	hmE69xClEafyZkduj3VafNFNHk47vqiOActADElUmIZ8Qs7c5ZVIgxdGuQ2rVOWyFsODVkQ40Aq
	Dm5Ori3iEBnUjQx55djqjGpQf7OZqh/ACx1wJ8pKj8939G0WAX4C+68YTrS649Watz3TWShU+BL
	aB+fv6J1p0Wq0JgMABrLYhxdM6ePSXRFa
X-Received: by 2002:a05:6a00:1742:b0:7a1:49f7:ad04 with SMTP id d2e1a72fcca58-7a4e2dfd22fmr3505507b3a.14.1761738157906;
        Wed, 29 Oct 2025 04:42:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE60h7iSnXrX8hGpp8tyqVaKcNJkQPbjBnD8dVqZHjYUw2lDZ67G334v4k3EVjp4iGr6sSeOA==
X-Received: by 2002:a05:6a00:1742:b0:7a1:49f7:ad04 with SMTP id d2e1a72fcca58-7a4e2dfd22fmr3505467b3a.14.1761738157365;
        Wed, 29 Oct 2025 04:42:37 -0700 (PDT)
Received: from [10.218.1.199] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a4140699basm14858553b3a.50.2025.10.29.04.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 04:42:37 -0700 (PDT)
Message-ID: <6297468b-77d0-4202-8ec1-3e731acc43de@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 17:12:31 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/3] arm64: dts: qcom: sm8750: Add USB support for
 SM8750 QRD platform
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
References: <20251024151521.2365845-1-krishna.kurapati@oss.qualcomm.com>
 <20251024151521.2365845-4-krishna.kurapati@oss.qualcomm.com>
 <a117b105-a734-4f67-9bb2-c06728e79083@kernel.org>
Content-Language: en-US
From: Krishna Kurapati PSSNV <krishna.kurapati@oss.qualcomm.com>
In-Reply-To: <a117b105-a734-4f67-9bb2-c06728e79083@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: GoKSbDJOgTg4RrsJET4vD0tyDbg5nDLt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA4OCBTYWx0ZWRfXyNEdL+xy1a14
 td7R1TYDUlZOypQ7oX3W7W/cE+//eGmclyXP5TOT+GwWAULqT3vFMN1ODCU7wTwtorZ718Fm5lO
 Rsr4zH8Hi5Zgqi1W+OalS76/BFiWZL+oZXVo/WfvMyd1MX32jvIrAu2VTTDmcDhjnGwuM/kEof4
 EiMHtY/wF0zy8STPGQsHwvQOi1rR84RRN28cunYfRUvJgFtubw69gMY/Ssk4fnchwrtXleiji4q
 0y/58hRQ4D66/5apBEshv2dfrYWsIsawCdTICvRyICMD87DT42QlgxyqGcqSgxbOAFQUwsX1dF0
 LU6xIRNXQtJ5n965lKXibOanghX/WIqmrN0WAtITHraVdFVqravvUvVtOTDYQyTHqG4Cxag2oAH
 LaXWlC+wCRc2WHv0OohcXXto25Au7A==
X-Proofpoint-ORIG-GUID: GoKSbDJOgTg4RrsJET4vD0tyDbg5nDLt
X-Authority-Analysis: v=2.4 cv=UObQ3Sfy c=1 sm=1 tr=0 ts=6901fdae cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=mnim3SVQaNIeGpcasOwA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_05,2025-10-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290088



On 10/29/2025 1:37 PM, Krzysztof Kozlowski wrote:
> On 24/10/2025 17:15, Krishna Kurapati wrote:
>> From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
>>
>> Enable USB support on SM8750 QRD variant.  The current definition
>> will start the USB controller in peripheral mode by default until
>> dependencies are added, such as USB role detection.
>>
>> Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
>> [Krishna: Flattened usb node QRD DTS]
>> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> 
> NAK.
> 
> You ignored every previous tag - multiple reviews and tests, and then...
> 
>> ---
>>   arch/arm64/boot/dts/qcom/sm8750-qrd.dts | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
>> index 13c7b9664c89..fc5d12bb41a5 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
>> +++ b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
>> @@ -1054,3 +1054,25 @@ &ufs_mem_hc {
>>   
>>   	status = "okay";
>>   };
>> +
>> +&usb_1 {
>> +	dr_mode = "peripheral";
> 
> You sent something different with issues.
> 
> Really, this was a correct patch. Was reviewed. Why you decided to drop
> all this, drop everything which was correct?
> 
> Your explanation:
> "- Removed obtained RB tags since the code has changed significantly."
> is just wrong. Almost NOTHING changed, except completely unimportant two
> node merging.
> 
> NAK
> 


Apologies Krzysztof,

On first patch that adds changes to base DTSI, there were changes moving 
to newer bindings and merging child node and parent node. I should've 
removed RB tags received on that patch only. But I was over cautious and 
misinterpreted the rules and removed them on the other patches as well. 
Will be careful the next time.

Also is there any issue with marking dr_mode as peripheral here in usb_1 
node ?

Regards,
Krishna,

