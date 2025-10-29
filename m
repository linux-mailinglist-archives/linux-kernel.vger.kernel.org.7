Return-Path: <linux-kernel+bounces-876594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E71B2C1C0EA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A01DF5E32F8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335283469FE;
	Wed, 29 Oct 2025 15:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TCdjSgLy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UFtuu3sL"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97153345754
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753061; cv=none; b=W0GHAa0KCw+SSTG5itpis/ZEvSiScGqDkkUDv7+9YK2almY/YHFW2HIUfonsGHJJ+pqSf+UE2+FvcuM9OnrkZhnSCBQkV/FP6yFyuszQahAZGq4ndYESiF1xAAj2EVH9CYJa9xmMqLc3w8OUzJUmpO7WgnT5+weyTmCIolrjN8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753061; c=relaxed/simple;
	bh=KpjAEZlJlBH4L80ic3H39uXImkiiZ0w2wk8+E2WzktQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k6BMHRZMf2NVJALj6nKklSgKjKCBy5I0O2a/1Pko49Uto+NXIurDZZMNRW8adxBSsrtrU8Nk846kOG6Vw7HYvEhfH+eMMvYS4T57ypLbsyz4b+zA0aLiC7rDAqKtcAVANif74DDx7+5K7UhqKfM9DvDEZmDY21O4KIDUHZYo+8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TCdjSgLy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UFtuu3sL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59TBeGCj435098
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:50:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ocDUjoSdi/BgXh7Ha09Y7XwcUnscyUVs5abme4yE1bk=; b=TCdjSgLyHetg/SV2
	EQLSXW1obmCMlyu6lRzxRqPzs5+c3HHomrRz8lRFmZdEaN5DfK0hcl4D+uL1U5Oq
	1g3H6Hz9sEv/vDKJ9WBWOAZjzT0brIw5xXZAYvsCJLMfWUaOAVrIDHdWX+w2W+8T
	lGzuAvxiXxJAXrbpizZSxcmLibBhmLfxfyXTBNBP2QSFxZB5KsQ0HE9L+ztaMDT9
	PK7cquyY2yX1ElB2lA4XGN73unLxB3n1pKetZabRdiwmIt7Q8zg6o/vi2nzB4KNX
	6aZqXHbw0uHYdhvH5+s1GeRj2HolJBv/uPXWLFfBQkSuM8jN9s3Jj8Wsjl7jYhKD
	zxeJwA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3j8jrrt1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:50:58 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-294baa12981so567555ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761753057; x=1762357857; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ocDUjoSdi/BgXh7Ha09Y7XwcUnscyUVs5abme4yE1bk=;
        b=UFtuu3sLcGe6JfeuLsG3YgfbCDwTDvw7SCmm4ZWR8qIViccHjFaXS//7KrQjGFJv6C
         cbqJNyuui4TyLv7AfYbIZ0QPFNOf7u4Z31YQcW+rXElPe7x6Ar+2vrVRMYxGuvPPMDwL
         tMpKSs/AuVV5BvII11sPD9MXOE5XQWynVVjgqzmi4ZAmGVFm+8T9NJYj7yg96pCau+Yt
         9R7yskrN3Wd2ncjJ2y6NIi8y0mUPYHr4DkIRANQOjlnBS9uEwdB9Ii8ru586gZksLqu1
         m5tU1SiJ675kguJojckZw6lnn3JpvvPP18zCqw70khSaRw+w1kSmX5ccJU4wFfNmFd3s
         pP7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761753057; x=1762357857;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ocDUjoSdi/BgXh7Ha09Y7XwcUnscyUVs5abme4yE1bk=;
        b=q0XIhgsJ9oG6j41tbjipTX5zp7gor542WJ5R52XGUaP3yAID1ZRTQVxXZyDX9FvPzm
         H+ayun8Sk+uP9m83oK+y1zvphs6igexjRdrpQ6H17hah4JWzW/5wQHsKTOM/rk5WLKeA
         LDhU2jLm3fNCwRcGvnD+kOCb4wx3IyDNIi5olhEv7PwJsO2YiG7f0MDS43VguXdjpytb
         nGtptziQjfHgso6jWVrJ6aqs0UeFBPEotSexsi443B5gWZ3g1/rdooi/9xhivkWeHvBt
         epa3+PTI4oncGI38eYoULW7lVDSH9ClnS+XyarO4F+QNulwvVTmVGNVK0y6GwulmZrPo
         BYyw==
X-Forwarded-Encrypted: i=1; AJvYcCUs40ATZx5ROZoLP9dtaZaV/JWMemG/RCqSh71rGS/omn78/B3xilkNYZUDRAtRpiyCTh5WTPNV1DdkPfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzinJVIcjCvqX+uASbes/8WX4BCxITlKyUU01UmRggRIRlYaITy
	8N4mMf6oKKDclkKQGUQzVwXpSgeNoJD4s9VFuithQRBoHCZkoGuLkXmLCCHHLK1AZinH0OtiTmJ
	FIR8JzfFQte++2VsrgUA7wnjmoTSNJzt7KZSsdiIUAm21EwgQ+PKeOZkxK/oHV6qBz3g=
X-Gm-Gg: ASbGncuqixlwmsrxVzUsDGIT8xuorqF7OpgXryZjBRAhMO2VW9dwNrhGe/zOYbZCxdP
	FQf9aSwHZlk+gA3rgpxbKrO3yAcJWdKO2XNcicQ7xn0113NyBIQb5yshzejDhQsw44ttJt+tS1y
	QcjyhFL5W0buulahLSh0Ejw8JL0FsjXm5RgbjJJ0o017mvvPbhjMdIEGxEZsUmj0lsYiGn1kHoW
	0FXGe8KeNi9S2DyTsQ0ccVSsluiUdyROVGBmkzi0v/Agk4O/hKMe+lxBU0N8t2qhxE2qgJDBy5E
	R3m9g+BiZBo3KbyAQfbm/KOBlqqRtfYlwiqrlVc4fnsAFUa51pHvmnB+rLSo3Dr+GjM0yG4Zat5
	cIUpQxviX/xMBX+wmLP4s2ZN5exaFtj/k
X-Received: by 2002:a17:903:45d5:b0:25d:510:622c with SMTP id d9443c01a7336-294ed216be1mr362835ad.28.1761753057359;
        Wed, 29 Oct 2025 08:50:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/ybW31CBc2TweYbVe1W/JMckbSYfIxWNZt4i/NOSFxwW7CpDlMTBjMmkJHcLrTw1Ehl7uIw==
X-Received: by 2002:a17:903:45d5:b0:25d:510:622c with SMTP id d9443c01a7336-294ed216be1mr362465ad.28.1761753056619;
        Wed, 29 Oct 2025 08:50:56 -0700 (PDT)
Received: from [10.218.1.199] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d23226sm157935525ad.49.2025.10.29.08.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 08:50:56 -0700 (PDT)
Message-ID: <469fc3aa-9b95-4b30-a704-d568a830452f@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 21:20:48 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/3] arm64: dts: qcom: sm8750: Add USB support for
 SM8750 MTP platform
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20251024151521.2365845-1-krishna.kurapati@oss.qualcomm.com>
 <20251024151521.2365845-3-krishna.kurapati@oss.qualcomm.com>
 <r5zjb7v2ngsbx2y63tmdhnm4gbpla5fki4uzpjhvn7sqmzsqi2@7637rbudt3z6>
Content-Language: en-US
From: Krishna Kurapati PSSNV <krishna.kurapati@oss.qualcomm.com>
In-Reply-To: <r5zjb7v2ngsbx2y63tmdhnm4gbpla5fki4uzpjhvn7sqmzsqi2@7637rbudt3z6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDEyNCBTYWx0ZWRfXzqASo2ChI01i
 Xe3SXvffk8PX0aMCPhHjCtrZdb6Gt82aL6kiS2nFel8YXwzNLq+Hfxp/i6ST/311RhIjc6tXmpW
 F8R9iA/R4PpadUcboFgSYC9aRGhUg11ohxYghpSAvScoDYwl+dB2U28VYWonbQlZs8Z3nRbudLm
 LZfs2vOtlTP52zoMjX/44JmMc5JQ/LR4mMlO/yc5liZi7Y9eAhmVQxNMiDlFN+hm/Z42moqQLJI
 ntqZ30eSmgXlGQ1gm65PbJXwfjeFHmJ91UUrMCQBWK6XQB+PldPv07L2yPoyqtTimO9r7a43IIH
 Qe5nS+rcudxTTO3R8XNSqjAT9G1lDW7rqjJ0Ohi4J/YuaDu+epGNynDDlzsUOwyYcTGJkhhCWcx
 Z8vjXkv2QFhIt6A0BmkiFhAtiRSU9Q==
X-Authority-Analysis: v=2.4 cv=FOoWBuos c=1 sm=1 tr=0 ts=690237e2 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=oOlcjaQNFUeFxkmBLZ4A:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: o_lhyrtNcch52bot7H_0lonZmM20GmxS
X-Proofpoint-GUID: o_lhyrtNcch52bot7H_0lonZmM20GmxS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_06,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290124



On 10/29/2025 2:45 AM, Dmitry Baryshkov wrote:
> On Fri, Oct 24, 2025 at 08:45:20PM +0530, Krishna Kurapati wrote:
>> From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
>>
>> Enable USB support on SM8750 MTP variants.  The current definition will
>> start the USB controller in peripheral mode by default until
>> dependencies are added, such as USB role detection.
> 
> Which dependencies?
> 

Dependencies like pmic-glink and adding remote endpoints for otg 
support. Till they are added, we can enable peripheral mode.

Regards,
Krishna,

>>
>> Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
>> [Konrad: Provided diff to flatten USB node on MTP]
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8750-mtp.dts | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
> 


