Return-Path: <linux-kernel+bounces-877872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3992BC1F3C2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B179834D6DC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967D7342160;
	Thu, 30 Oct 2025 09:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A/keo+Gw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kcPS//iF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B5D34165F
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761815911; cv=none; b=gPu2LJMlFIgP60zSGao3SAXmfzNVV7JuxgiDNUC04UDq82ZOzJiZyvhPITUtL0ZeQXs4DjY7XhkXeE8w5RckoPvFVQ6kh3+/zqg69xTZR3srWz37EEURwh2SFS9LlWrcY1kX9BYHbbv7zpc5ODahvna8DsURcN8svwQDGoMyYH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761815911; c=relaxed/simple;
	bh=RN5Gy2e44hs4pd5k+0pZ6+992/Fz5/HWJsqtJRp1kF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FsxxPzXcYQsqF0EDD633rgUfXXlqIdPV35JsRdlfPiFN34BloFx/6xHeY1W0Gf0WSOBLHdZrRqs4JLNFGXIeCGNW9BDubn5wgXNnb9JGjzfTLr6b4wZ+VONCKwSJc3oWWsMUkIwqlFT7duqRvkVdm6bamm/A5X8z6BO7CWzPIUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A/keo+Gw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kcPS//iF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U2Jw3s4135755
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:18:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oHEMia+Pz0ierHzqmwDGQUplMNYjbhxw/U4nXbi2Fyg=; b=A/keo+Gw3dIP4hy2
	Hz27P8102pPNoLOWa0j56Rz3MBLe0+OIubXyDguxYIynIKbC5OUsg7XAP1IumZ6t
	IGM3VGRwiotpM1XONEXmkHAy5E29HxK6XaB3CFzJj/LhQM7BLRa+D5UzIxYhb8G2
	zWz5ejuD+FLPXSArWe4U0cfOsm4isOzDQcC+qrq0f6nLqxJzDCkqREK3KHNu0GAB
	rbTf46q7N7fVBRN6OvN27I2Ye/gbS3Iw0zPxasTD6G0ZwHt7xsGQ68kBRWRF6qdn
	MWG0MC4Gz2t8Ds1T8M6+PAW2osPcUHvFDSv+YggzAu6JyXHP7yCWY/4M0YbDSVAG
	0nrw8w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3ff9v2cy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:18:29 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e890deecf6so1373561cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761815909; x=1762420709; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oHEMia+Pz0ierHzqmwDGQUplMNYjbhxw/U4nXbi2Fyg=;
        b=kcPS//iFTKK6uacw7cY+BRyd99AIzEAwBWc0IpCbml60w7s1fiCHI7Y7fpGAY/nfNB
         KVPO3Ak4TpdX1LhcCih4Ea9hFpFGKjXpQDbLgiW7cCEepVdCIW++00x4ChYz81+biudE
         h+ufjHNjlcYGdhcDOafO6soddpzxSAHS+Uw8Llmxk1vuit5ee9vzsCs3TddEvr0Fe97Y
         bSRsW/F+00hi5HPvmzrR2Stu7tZKToT1wDnAhQzIml9Frkd7QKj0PSL/aGzuLBxsjxBn
         8W6vjGHTNpP8x0VPRSkBXbZfPbNeD2d2Nnw9VJsGdDB84jqOogDLmr46b2g480ImQgEy
         RnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761815909; x=1762420709;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oHEMia+Pz0ierHzqmwDGQUplMNYjbhxw/U4nXbi2Fyg=;
        b=flLALSnCFkoOUCN5b6PUAhCgmHnh8oJOWq15b6blR388QY4GdV6tEIeRSaRrSWCgL6
         WPndpkfWhnBgA9iOqrJkP3bnmkzC348tweRQQcP0YsB5B9K2e8T4QEe95rHtGltmAIBL
         QpRdP2y+6dRmf1VSOSbawASHoiMD1UxGHY3yToo7kkVriEfSnPu09rG7j/b0XDBRyo4O
         uh3Eol4NFMFqatQNAWRVH8OmREHwMhVkF+zglcheDCxzhFHmPEfWYiLwzVtLTOgJX97U
         gEpw5Yn7SO2ye9ie6OBAAwdbrhJkmJiUucc7Ts8wOp0E2ShC3yzRnrpqr2mSBK6ntGio
         3/sQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkeAYxqtz3MmIAobGXeBi/0OnUjW7rDXVHqOKn5fkhhNdKafPKFDm89FztD78m3kS09VvLay+KR/pkwrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXRQdk9eA9Ao6F8gqoF3mWyU9iddGFEVSeI7pkMhMmi8jc74J1
	w9U9ZEKkNV3faZAD9GUHT3N6JANw2k+FpoG0LCAyYd0sbchq2T2fVpOfMCOYAcyvKzJlZHNFh/y
	St2j0IZ4qNGw+61HKUsOiX7dU8mBhl9MpprWGFD/wdMSMLJfacThXi5T6GK2RGg9+Wic=
X-Gm-Gg: ASbGncvLR1RG4cjgqbsnk4pZKru++1TlEoQ9yEb0CC/EIW0YHE8yMrXhdExm9GHUP2E
	TuRsVLAvMjJNRsB0zXLKKWCUcwzvNAC80jNY/Fe6I4Y6VZ06vaeGFSvQ2yptDx9Hcsc4CWIISRo
	h0J2EmPC8iLHk4rqN1sRRZXFXbY23jx6HxpSlWzgXWqw7twIaVJp5CmMAEhzV5uphigWnBF/CBT
	t49q73E5cRMnMWeCtaAT8ck1j0WTUXQXa0B0yeRs501JOkuCTfAh8TWTTRWg7nIXi1vEtZiaJ9b
	HZipTm2JCUSnc12+TgSze9beu9tK+ucx2adIOo97EOv+B/gEAmK84NhY8/kISQEK9n/DbEIdYQA
	zZuX66nlz87ItD2yCe8faqfornKk8e4Scx2oQfuh6WdMDDqLjd7BCPpmy
X-Received: by 2002:ac8:7dc5:0:b0:4dc:cb40:706e with SMTP id d75a77b69052e-4ed15c7ab81mr56823031cf.13.1761815908488;
        Thu, 30 Oct 2025 02:18:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNCKE9kYbdCMSkRstEgNVCybw73OUFRcjBy2w5NSuhLAsNduqpvslgDuJLndZu+Bjw77eMCA==
X-Received: by 2002:ac8:7dc5:0:b0:4dc:cb40:706e with SMTP id d75a77b69052e-4ed15c7ab81mr56822621cf.13.1761815907798;
        Thu, 30 Oct 2025 02:18:27 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640342e5acesm6069096a12.28.2025.10.30.02.18.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 02:18:27 -0700 (PDT)
Message-ID: <7e5b3291-c36b-49a9-8a82-fc62d93f73f2@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 10:18:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] dt-bindings: i2c: qcom-cci: Document msm8953
 compatible
To: Luca Weiss <luca@lucaweiss.eu>, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251028-msm8953-cci-v2-0-b5f9f7135326@lucaweiss.eu>
 <20251028-msm8953-cci-v2-1-b5f9f7135326@lucaweiss.eu>
 <48a217db-b85a-411c-81f2-3106b60da86f@oss.qualcomm.com>
 <76f108e7-2ec6-4edd-8640-a82fc99f7dbc@lucaweiss.eu>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <76f108e7-2ec6-4edd-8640-a82fc99f7dbc@lucaweiss.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: v6lpT29AVC5eCi-1cQN8vxsr2lWAsK9Y
X-Proofpoint-GUID: v6lpT29AVC5eCi-1cQN8vxsr2lWAsK9Y
X-Authority-Analysis: v=2.4 cv=Cf4FJbrl c=1 sm=1 tr=0 ts=69032d65 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=dlmhaOwlAAAA:8 a=Z8tL6suUy-G7dtvowrsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=y4cfut4LVr_MrANMpYTh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA3NSBTYWx0ZWRfX/zFzIKpfUWlw
 Cl6+bZkpaJEYndbcw/FAp6MxbMGpbALlnV+ygeAadkMqCKX1YHzRq5ivGgpZarNqZEZsyn4hB/y
 AfJOuYfPsQsuewH0IWEIrPE3som966zMBJASEBSkchoETv/IQPC6anGAZyzLZIWMLsyUET1UXxr
 jt3Dasd5WmQQQegCYfmijKxfSe3nWz6JWB/R18rz5Zg4Rq7pceWdajOcILtCHRgbejwjLW/CSl6
 E4sFaZxzzlUugSJKYgVtUpQ/O/J7tLl9slryu1A1He/4Ran9KdatRjSEIIcoZgh8O9twTnzCfc0
 4dQOXMm1n5uhZwZHe5A24uJFPVMgJULsrtpLrjjqLCd5c504QUiQFwlkGoGyIUWYsCu8f84C/A9
 g+9XoJecskr7F7aZ6FV0BJJArdg0Ug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300075

On 10/29/25 9:41 PM, Luca Weiss wrote:
> Hi Konrad,
> 
> On 29-10-2025 10:36, Konrad Dybcio wrote:
>> On 10/28/25 5:40 PM, Luca Weiss wrote:
>>> Add the msm8953 CCI device string compatible.
>>>
>>> Signed-off-by: Luca Weiss <luca@lucaweiss.eu>
>>> ---
>>>   Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
>>> index 9bc99d736343..ef8f5fe3a8e1 100644
>>> --- a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
>>> +++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
>>> @@ -15,6 +15,7 @@ properties:
>>>       oneOf:
>>>         - enum:
>>>             - qcom,msm8226-cci
>>> +          - qcom,msm8953-cci
>>>             - qcom,msm8974-cci
>>>             - qcom,msm8996-cci
>>>   @@ -146,6 +147,7 @@ allOf:
>>>               - contains:
>>>                   enum:
>>>                     - qcom,msm8916-cci
>>> +                  - qcom,msm8953-cci
>>>                 - const: qcom,msm8996-cci
>>
>> Sorry for only bringing it up now - could you check whether
>> all the clocks that you defined are actually necessary?
>>
>> It may be that you can do without CAMSS_AHB_CLK and/or
>> TOP_AHB_CLK
> 
> Removing either GCC_CAMSS_AHB_CLK or GCC_CAMSS_TOP_AHB_CLK from dts leads to an instant reboot during bootup - presumably during cci (or eeprom) probe.

So just like 8939.. thanks for confirming

Konrad

