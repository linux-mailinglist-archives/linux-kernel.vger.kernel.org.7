Return-Path: <linux-kernel+bounces-832295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B04EB9ED70
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5A8B3ABEDE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512462F532B;
	Thu, 25 Sep 2025 10:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G24+X3dk"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDDD1C831A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758797967; cv=none; b=GPYdZfCCkJaRDmihut3QyOwRZMGE8VJsNGpaMVgyyXuNaiz+JwWbRiDRCZy0woj63OmxiLtTHyKXGjCHXiNVI7BsWXdP9NcK28SViOLnC3zdPO8r8fqCCYUsNGVyhjLmx5+tssIrLunXxLlo7FZMnn1oRYMJ4yU7zablpmqQ8F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758797967; c=relaxed/simple;
	bh=R5x3h0495DdIrVSN5lvm9yHguCQJl5KmFHn9n/Zq1YQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r+gLB2RZbLknUuz+fL5FyhJ7uRPOoekysh/U3YIDfYB0e0XJink31yU/7SMApwrlZXZYHfQYHR4eam4Do6lvfdxaxygH6hY1kG0pGI1AG51U4J68Q+F9WpUrwbRnqEBU0XssYCAz1VEftZgZMWytk4bFMN5s36mpihAJLEIZnmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G24+X3dk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P9q3nk025366
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:59:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	thyQ4gLxv6irxf9BVNUnhB21i9mNFbZtzkVAtGKuDN8=; b=G24+X3dkpPLPETW3
	lNXQi06gBKqb7BM9awdovx+GQh5ttHiUwf0Q5RmLjs7RdkAQec7sLVMpU7zCQrfw
	n9SuNrgWJGDuQgawngH0ZXEbjKzYIMebjYJZt/E4sYlYRxj4IKIhOa3EEAAHa0LW
	oID29d8dMKPy32hZTgELHaDa62iw7KpHSqBpXuzt3ixPc/b/Ge9Y7shG9bh5WaZz
	xIKmbHjEIIbxYk5yfJR9Yg+cKY/DCArKPNSzzMb+zTUZmXlSYHhG/LAc54zBX9k0
	PTIg+zaEKDE0sqooUpIfz7DPFnVxm9qhk4vmTLd9ZZaW1KyYGtcOrcKKa1Tw8fn1
	4TB8kA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hyf059c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:59:25 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4d88b669938so1759181cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758797964; x=1759402764;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=thyQ4gLxv6irxf9BVNUnhB21i9mNFbZtzkVAtGKuDN8=;
        b=edhnv4lskJNm3EhScB08KH9v+95CvVmvzHF10nuqUTYpcIKgP08L/41Ua39MJnlhf9
         JUsqAFNsB1ivKgZTOFALF4vBerggYKpX3E07fhJ2SHNFe2AC4co0PDfAKD2L4SvqN5zW
         5I7xQMxShE+d0hBYmQDpdNRBYRWD3TjlJGVspKOQscSs+u5NbvMGXv4eLUfZpJxm6aYg
         up+SVvkGnfsxtBJhbUd8vC0B3ns1SObfjfSbJl9eysW6AHIU2htWlFaBrZ2KPpbDFOjS
         OzD3AP2n53wbISIu6rT7FxGAA6e13dFIkVHH21QJlhBLS6LOloP7i7S8TOAMYcD38iio
         CmAw==
X-Forwarded-Encrypted: i=1; AJvYcCVuJM4CuPhJGDH1K5BscFWFYvv0j2rcLPHTMUdu0OpK8vYoL6mf1XA2tjNZE67RoO52ExPXCC5095yjkW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YztYuX98c9W1jynZCoLgm8XXMG0NdBdakyzBKqhay66NMfQCwg0
	HI6jKmPnCzg7EtPZFg9vYSY5j4Ra9aPCyxkTwnrD4RrIrq3s+wGcWDhOpedznxkVlMUCH+AeGY1
	9iOlUEiORtjrkfgF0sAWoAkQ+Rz4t/Oo96GJ5LVRChSUNLR3ZzRLGLQdR9oLWe/2MeuI=
X-Gm-Gg: ASbGnctoiqKaq49VrW51s8otw31YvzU8M7IrwGRD/UwZyQ878Rg7C6A/W0RGj9HvlBp
	FUPTrZbDsR5yNmoZradkFbHssFOCBb1JQshOCumGAoDzwbwcYXc/9KjMQY9x9pTEE2KsY1YnX3s
	bZoycJDeG+FuxVf716Skyd9YG/ouUWu8jpIaKt+scke40IM5IIYpTp32+JtMJbyNh5xkyXj2kkr
	dY2S5DzbNUo9VW5se9yMfjbwRaAoXUNFlju8VzIHPilQCdWUqlfLcpPznBZrxRcywAIbig/MZNt
	7MhyIXjPVxidbBjtWKGkb/QVZYIli4r7dZBzGtbigeQtu2lzAJFsZ0j6vh4SvP6XgfXqJMb+v36
	H1dkLOpXo99WL2uFURm8K8g==
X-Received: by 2002:a05:622a:11c7:b0:4ab:6e68:1186 with SMTP id d75a77b69052e-4da47c0d937mr22146831cf.2.1758797964359;
        Thu, 25 Sep 2025 03:59:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUVWdEjYs2bkzwUN/xuc5Wz72tF6RLq4Ho16B1AXq/HlO2v38RaPGkkTGGDSOB2UYbs7/jDQ==
X-Received: by 2002:a05:622a:11c7:b0:4ab:6e68:1186 with SMTP id d75a77b69052e-4da47c0d937mr22146681cf.2.1758797963760;
        Thu, 25 Sep 2025 03:59:23 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b35446f7806sm146672166b.70.2025.09.25.03.59.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 03:59:23 -0700 (PDT)
Message-ID: <66a5084e-3f7a-452d-ad5b-5867528f57a5@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 12:59:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 23/24] arm64: dts: qcom: glymur: Add USB support
To: Abel Vesa <abel.vesa@linaro.org>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
References: <20250925-v3_glymur_introduction-v2-0-8e1533a58d2d@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v2-23-8e1533a58d2d@oss.qualcomm.com>
 <dzjj344c6zlkg4rvi455xoedhd4d2kjvodi6yftv7svhvvmxbz@kwq7rkq45tms>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <dzjj344c6zlkg4rvi455xoedhd4d2kjvodi6yftv7svhvvmxbz@kwq7rkq45tms>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: KMm9r8kUARhcwkYuRC6uTdh859bzCNB0
X-Authority-Analysis: v=2.4 cv=YMOfyQGx c=1 sm=1 tr=0 ts=68d5208d cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=ekqebYJK4Q4syn5Z_ywA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwNCBTYWx0ZWRfX62N0g+27sVU3
 t2dnnNXrgtv/8GbYnKcaSiHVIX7tR0klLwQaDaSxYFyhkgDQm/EQQQSyIhf3KAve419f+gY9SOs
 FRkWEwVU6MXU9sFUkxEYPD7Kis2CBCJ8m2zfKix2xyOmsLkl6/dNsPgRpsjyv7VkiBsXYk9pdFu
 r4Lz6MZdzuu05Nk/MWHw6lRGkUVLgVLlnBzxutIYBzsbL/OdQehnUpwYiP2dsIRqtFFIOx+57kH
 90X17kCGikc/3vQW+1J3yGJ0dMmvXxdWXGLT3J/Ms0zjJXjJsAzGUcjgZrPw4p1itiRVYyDdu9t
 LTwrx9L07T11579GCxeHYnMaGzgg+ufzu281Rcq/ReAYM6s5w5pWHVfitQ0TcH85ExpFZbuczz3
 WFtqT6Ky
X-Proofpoint-ORIG-GUID: KMm9r8kUARhcwkYuRC6uTdh859bzCNB0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200004

On 9/25/25 12:54 PM, Abel Vesa wrote:
> On 25-09-25 11:58:29, Pankaj Patil wrote:
>> From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
>>
>> The Glymur USB system contains 3 USB type C ports, and 1 USB multiport
>> controller.  This encompasses 5 SS USB QMP PHYs (3 combo and 2 uni) and 5
>> M31 eUSB2 PHYs.  The controllers are SNPS DWC3 based, and will use the
>> flattened DWC3 QCOM design.
>>
>> Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
>> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
>> ---

[...]

>> +
>> +		usb_1_ss0: usb@a600000 {
> 
> This is usb_1_ss0, but then you have usb1_ss1 ? 

I'm in favor of just calling it USB0/1/2/MP/HS because that's what it is..

[...]

>> +			dr_mode = "peripheral";
>> +
>> +			status = "disabled";
> 
> So you have the glue defined above, but not the actual controller (compatible snps,dwc3) ?
> 
> I don't see how this would work.
> 
> Same for all other controllers.

good morning!

6e762f7b8edc ("dt-bindings: usb: Introduce qcom,snps-dwc3")

Konrad

