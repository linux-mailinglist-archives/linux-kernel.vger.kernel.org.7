Return-Path: <linux-kernel+bounces-773246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D38B29D35
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E540417DB60
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A108E30DD08;
	Mon, 18 Aug 2025 09:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dr4jJhpB"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C0D308F05
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 09:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755508034; cv=none; b=KJ6RPoD+P5BPRhb3cdilkkDXg2HVHUlOJKD+ipmVuwRfUfsyLsK9UWsvNGyG3E/oNPtJK0FsUB+FCYsghrHSEFRr92/AnvJWsLe/EupBSPBpC/aAFkCVcz5ESpRZobRt35JtKVYOwtlT4TsB9VEZRBJig/A9M2MEBXV6kjC29zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755508034; c=relaxed/simple;
	bh=wyq/7YeczeadlIcGxtjwBRjfO2o1GBWQYroM9CBv0ZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LIV5wdkwpD709EzQEdSmX0Wkb6tPVeu2SB4urgtTCUwBFgwFY/GQ4w+Y2KQlibT01Mh/gRXu/9VODyIMx4b1NmeUm97XdqZzx+Pz9bewcsX/G4W6dQ8OU8JbaHR8IUSR+LSL0vH/v1/KN5wrwXSRtktn1roj94nvns/ke9Vdka0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dr4jJhpB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I7JnJm006647
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 09:07:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dUhpdrCm+k4CB4DE4j2STl3XU1CxkFy0Dl3z3gmHHDg=; b=dr4jJhpBWkhC0hl4
	KNLVhV/EZCKuB+KOy5yVaf2hs2kkScwOO6ssaq/q8+U5Xn7JAEinUEFQ9SA6ryyZ
	JMF+/dZqa4Zo7nyFDJapRonWHDsTxMDbZ8nOVrZJ9bfQ5H1zqMIf2xIURrFo83Gw
	PSIBNUh84K6nqP0KDtwB+jfYYspay+z8aKEKGLsfwFarNUEtWjgd9Jj+9WuLpJ7z
	nLTxaGjXxBV3jpI5pNBDNW3zmGcy0doPL4PVYeDoPwnMGIpvLeqOFKo1bvOZsdDX
	suBTREPKnWfiqFobZEG7NlTzIajO2kH2qGoq1YES5vZ/1pTwHDTCEfichPJ4e2xL
	CB/Iiw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jj2uc1y0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 09:07:11 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24458297be0so94672585ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 02:07:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755508030; x=1756112830;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dUhpdrCm+k4CB4DE4j2STl3XU1CxkFy0Dl3z3gmHHDg=;
        b=n0DtnnoN08aql2XcJe6GLn0dDu5fjaUBGIeCGB7NJ9FyLHnf/x6cUfn+B/v8+7hcjP
         giomx+MIBGQNujx1MtNi9dsF5HXqip8y9doabXSy9CdHdED5RV65+qndiw+55296GVvN
         w4xGzg+kOyxGOvpKn8HWbG1BF279TTD7d+IKDG4pevh3cvbsOGz5NKnEuZ0ItbuAF5QG
         sk19rp6S3kvzLK/kxK9qgZHgdA7j8ms8zKV3iIZLREdZq9Qhu87TFUrYrFFBuC6jNT0l
         Ac/k8QXwtI+KpbzfP/D2Pokcv9PWaqIKdjvMEmjdaiLyPAhwgYF5rlWrVY8Bl3TKHK9o
         5OUg==
X-Forwarded-Encrypted: i=1; AJvYcCX3VcNCTdbxmEZo6+xoyVF0EyB2zzj2p4EZwGiWYB5J1fMCSSszzovK2SinFYie9tl4ocCDXl+TJXP8yO4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3cQsrLdy4lMEGI/Z54FPdfeLkEv0U4WRqlt6e86SZnn8lckL/
	SChAN5p4YQD0yUQagpR9daJqQq9Yf1cvRBn5j8yJH/JM65nGvDkOixatCNJbgnhTRmJCe7kQ2KA
	PHldDupRroUMnGtRh9XgxJ4PLTmA+pOtQdfV3WGvFkztNeD2klFBkJ/PHk+FcQE3dJZc=
X-Gm-Gg: ASbGncslMXrBf9fB8WvdDXhNaVoGJLm7kPyYCZttKG+nGR+cMnKkpkjA3QslnbuzWgZ
	LB0Haxy51sp55hMOyvYlmjFga9DpzOvU+8LYjW1gars5zStj7FzD6CM1JP6Hmj8yw03/DdV0Nu6
	aIWLmG/0Qrfs7vCy3FbSvE2Oy/WT1vclLFP5/OXj/U9/cvLC/NdcZhW0Dgh/IPmBXDl1y+w0E6F
	GjR7Pf57DkJSCGv4xn3wpMyyMH2ZdiHiucMJC9hIfFT75yAaBVXxkkNnK8yX5rDKiFgr1Ou8aoc
	EY6yb2LBtPSPGqQEcRNGr5QHXE17YQVBs5vJicoRPSXxzk0bTf6XQ1u/asN+1ErBeI3rIVEWXg=
	=
X-Received: by 2002:a17:902:f64d:b0:242:6f41:2351 with SMTP id d9443c01a7336-2446d756f8cmr135618935ad.14.1755508029990;
        Mon, 18 Aug 2025 02:07:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEh9JX97qwlZF3aEKy3JEAMK4ybJH6tMcLrA2mXkPjaM+Z0DmqdjxHsABWyv6WSPHfpsDKwwA==
X-Received: by 2002:a17:902:f64d:b0:242:6f41:2351 with SMTP id d9443c01a7336-2446d756f8cmr135618585ad.14.1755508029517;
        Mon, 18 Aug 2025 02:07:09 -0700 (PDT)
Received: from [10.218.42.132] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d554619sm74574605ad.141.2025.08.18.02.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 02:07:09 -0700 (PDT)
Message-ID: <5f3261c3-3e44-42a5-bac7-624ce4e7041f@oss.qualcomm.com>
Date: Mon, 18 Aug 2025 14:37:03 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sm8450: Add opp-level to
 indicate PCIe data rates
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20250818-opp_pcie-v2-0-071524d98967@oss.qualcomm.com>
 <20250818-opp_pcie-v2-2-071524d98967@oss.qualcomm.com>
 <20250818090240.in7frzv4pudvnl6q@vireshk-i7>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250818090240.in7frzv4pudvnl6q@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=MJ9gmNZl c=1 sm=1 tr=0 ts=68a2ed3f cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=jYHQ0JWC-Ns_2KpUhz4A:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: EkJSuDlylPmEUON4cxMG63flsTeIkEub
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzMSBTYWx0ZWRfX7xunVdPWBm6B
 kiUUJsjrr07f7S6AaPlySXlP+n8hmMvqY59BBsY89trWp5z7Yp2lPWDR9PkdiH4pQBLusYLabwb
 OhXH0lB5D/1zmTF7ytuPxCcs6F90j0cIYiFH0aEZE0qZa0PZWSog4WgpzN91gz7aRjrWdh6xuMl
 OH7AQw8XSkP8LAJm1JX6njDPbIJCpDZJWkMAfJ6Ka2TMa3McJm9ch/jOYC380Jssx9oZiny/B8B
 2GE3bmNLnFvl/o5ixT6vX0U8FINF42lmKthsT91JKIwPq347yoMwpoge8zrZA24vtNQNwAJt2na
 IguEk2DoQ/0VWIGUDo9Qgwr3aRPqYhpqxz/Q2PjWh7sSXELnPM9BCF8xiUCIottA0ce/V/Ulxnx
 SLm7q7Jj
X-Proofpoint-GUID: EkJSuDlylPmEUON4cxMG63flsTeIkEub
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160031



On 8/18/2025 2:32 PM, Viresh Kumar wrote:
> On 18-08-25, 13:52, Krishna Chaitanya Chundru wrote:
>> @@ -2210,45 +2213,67 @@ pcie1_opp_table: opp-table {
>>   				compatible = "operating-points-v2";
>>   
>>   				/* GEN 1 x1 */
>> -				opp-2500000 {
>> +				opp-2500000-1 {
> 
> Why mention -1 here when there is only one entry with this freq value
> ?
> 
>>   					opp-hz = /bits/ 64 <2500000>;
>>   					required-opps = <&rpmhpd_opp_low_svs>;
>>   					opp-peak-kBps = <250000 1>;
>> +					opp-level = <1>;
>>   				};
>>   
>> -				/* GEN 1 x2 and GEN 2 x1 */
>> -				opp-5000000 {
>> +				/* GEN 1 x2 */
>> +				opp-5000000-1 {
>> +					opp-hz = /bits/ 64 <5000000>;
>> +					required-opps = <&rpmhpd_opp_low_svs>;
>> +					opp-peak-kBps = <500000 1>;
>> +					opp-level = <1>;
>> +				};
>> +
>> +				/* GEN 2 x1 */
>> +				opp-5000000-2 {
>>   					opp-hz = /bits/ 64 <5000000>;
>>   					required-opps = <&rpmhpd_opp_low_svs>;
>>   					opp-peak-kBps = <500000 1>;
>> +					opp-level = <2>;
>>   				};
> 
> This looks okay.
> 
>>   
>>   				/* GEN 2 x2 */
>> -				opp-10000000 {
>> +				opp-10000000-2 {
> 
> Why -2 here ?
> 
>>   					opp-hz = /bits/ 64 <10000000>;
>>   					required-opps = <&rpmhpd_opp_low_svs>;
>>   					opp-peak-kBps = <1000000 1>;
>> +					opp-level = <2>;
>>   				};
>>   
>>   				/* GEN 3 x1 */
>> -				opp-8000000 {
>> +				opp-8000000-3 {
> 
> same.
> 
>>   					opp-hz = /bits/ 64 <8000000>;
>>   					required-opps = <&rpmhpd_opp_nom>;
>>   					opp-peak-kBps = <984500 1>;
>> +					opp-level = <3>;
>> +				};
>> +
>> +				/* GEN 3 x2 */
>> +				opp-16000000-3 {
> 
> Shouldn't this be opp-16000000-1 only ? This is the first occurrence
> 16000000.
> 
>> +					opp-hz = /bits/ 64 <16000000>;
>> +					required-opps = <&rpmhpd_opp_nom>;
>> +					opp-peak-kBps = <1969000 1>;
>> +					opp-level = <3>;
>>   				};
>>   
>> -				/* GEN 3 x2 and GEN 4 x1 */
>> -				opp-16000000 {
>> +				/* GEN 4 x1 */
>> +				opp-16000000-4 {
> 
> opp-16000000-2 ?
I tried to add the level as prefix as that will indicate the PCIe date
rate also instead of 1, 2 to make more aligned with the PCIe 
representations. I will update this in the commit text in my next
series.

- Krishna Chaitanya.
> 

