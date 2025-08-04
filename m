Return-Path: <linux-kernel+bounces-755610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2DBB1A927
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 20:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A247177783
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 18:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354DB286D49;
	Mon,  4 Aug 2025 18:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Iw6gbHDx"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4702321A44C
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 18:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754331812; cv=none; b=GXVFNuLv9ik1T77HGH/3C3p1qg0IkxP9pDaZcfj6P11d8pQ/Xy9XuKisNfOWfkXfTwe4bl6FBzKWdItcbIxN3FNSQAxnRcAXrXmwZeV2HEnbj8mlmWVseBLNFOa2fMKHWbqooMZ5rS95+7ABLBMxeyod5NRddNsy2Hu6teP/Fas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754331812; c=relaxed/simple;
	bh=7ltBgKMR/FXKtfkI/2GQriZny8l37rhY6/xi4aaQris=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TCn8zNISwCfyyVye5syFZKJLTQ5NXti+mz9vRGea4O0+dmQyFSNJ5IoHkyz8ciwZD79vMK3DbMwNELH4PViUBQcmXXSpUXM9dp3nx69bL4xIITs7L8SAypQx8Ddl1a3UPk/RZsleyqESw2IZwBJSx0yTLC1TOgRRiTETg2SQcdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Iw6gbHDx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574GDkwP000777
	for <linux-kernel@vger.kernel.org>; Mon, 4 Aug 2025 18:23:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vwAUZbzwPdudDNVv/ZAIuba9HHKqAhFmjC3T88l2J4A=; b=Iw6gbHDxCHYU36ep
	Z1ih82wqrLcJ60Jx1jMfihgJ4t260bvWB8/w+H9aP9rjZdGp16cY3NOYYKeqHlvF
	VbcOA4x34lvTegp2sP3eUPDpuCsLj29f0BmVO8EM0QrZlL/V7yrTuqG4uapeLk+C
	CnW3ZpFgkPfqu4ekxqER7fX5Z912SEEuCYfHVuqHkMd4nPlRNKnCoM8b2DVUgxNF
	vAunVdMw8N6khbL+2wuOvnJZLos6WCVsWAEnRdjNywwCOuIQJhRD/yBv+sPVJR4u
	4+NYvZeE2PTr0kvAvNCWkt39ETdfK97iKa0OWo+gdkrFThGZPMAuzn1nEEijKi2U
	zfCGVg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4898cjp74r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 18:23:30 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-31eb0116716so1458687a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 11:23:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754331810; x=1754936610;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vwAUZbzwPdudDNVv/ZAIuba9HHKqAhFmjC3T88l2J4A=;
        b=ApuH9CZ6r1qb8qIMZYcxjYV1xIOU6jhscQFd4DRLCM1M193eZwWRaughfffxzvu7jA
         iwikHDYku6bkL81TYwRvycIJYuMSr8HqxrlZIU1M0GJAzclGp5aP/SolkEzgzKUzR3rq
         xN+jq3cNH/AroC9jfpsBxMqeeLpjHBcX/j/kyrhs3rZk9DxRSuTIttoDiPwZEXgGTeBM
         nJXythH9T5yv+Pk/PvdRGxersf/Lu95CxgFRFNo5lQOQcFFB8d7QXdqpiNxuZZUjnR2/
         Th5vsiRrgsxGLkFJ21TZdN/W8KvDyMf/8LqtCOvb+jNMHXue1pDF4N/SX206sKcFNbNO
         6bfg==
X-Forwarded-Encrypted: i=1; AJvYcCXEpcQ0+TOdjlROLE34B4mKGWDbl1q/uJtEDdhez0UzeYvEMDXCnu69E3THVsRuElFtPK+a0VbzTT9Iz+o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz26hrCXhfweceGDOCmBxXkny8eUbfqNfJ2emIUnhW2cJ/KHbvp
	JzaAvIoJnAULo69B5+LE7ZcdJFad8QO86dPxhhkZGyRRRGJdxDFewVTXOPqKhgjAmle2Ob2N4XI
	ws6yzUmA9OzV0oCg/BvnxaajkAYAKXAStDz4usa+AGC3daJedmcICqFIPC404IBSkuPQ=
X-Gm-Gg: ASbGnctoSHkhhM82G/7/kWV82cn67Ap22lnjj0tIL2kZjRfNmSK91GPri1NvFOD9Emi
	LYj4pszPk3vWJRgkj1q6UZ3PbPARRUDd//YGgGV31KXGNvNnVYX62IGsKcoj7tQriMXi8lzSeLl
	W/gLyWwvHEktNWiMOnXcWdkXBnAwMW+q4DXV8NZYE4dDGimWn6ouv1Mcmo7ZZ33Zdoy+eYyP1uP
	gIrLDeGwaWoOrAPmp4c1tVvlpJfeJNGTgPuG+ZpCMs97GaqMFpTW43X+S8e1JRrdOehW8x4BqZo
	YhfiiinbS/QYgezhmR6nvS5kP0mfWhSUwZykBMD1aVjYj098d6tnZXfqp1Hqjj3u3rienU/Tn0j
	bo4BROxZxWf2iijD2/UYnnVj5rPdf5ljL
X-Received: by 2002:a05:6a20:1583:b0:233:38b4:7996 with SMTP id adf61e73a8af0-23df9129b4cmr7083564637.4.1754331809653;
        Mon, 04 Aug 2025 11:23:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSo4CpGz8MsdmAlTt6d4liC0i3VrBf4Var3mZ6vsWib4H2hyKGAUuPhG5lrgaiiFcSl4jckw==
X-Received: by 2002:a05:6a20:1583:b0:233:38b4:7996 with SMTP id adf61e73a8af0-23df9129b4cmr7083543637.4.1754331809193;
        Mon, 04 Aug 2025 11:23:29 -0700 (PDT)
Received: from ?IPV6:2401:4900:1cb5:a9d1:15b3:77df:1800:1497? ([2401:4900:1cb5:a9d1:15b3:77df:1800:1497])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bac0d14sm9521529a12.41.2025.08.04.11.23.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 11:23:28 -0700 (PDT)
Message-ID: <b376d130-2816-42b1-a8c1-1962ee0c2cd7@oss.qualcomm.com>
Date: Mon, 4 Aug 2025 23:53:24 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/2] Introduce initial support for Monaco Evaluation
 Kit
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250801163607.1464037-1-umang.chheda@oss.qualcomm.com>
 <551e85b1-e0aa-4d0b-a532-ec670bd055a2@kernel.org>
Content-Language: en-US
From: Umang Chheda <umang.chheda@oss.qualcomm.com>
In-Reply-To: <551e85b1-e0aa-4d0b-a532-ec670bd055a2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=MNBgmNZl c=1 sm=1 tr=0 ts=6890faa2 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=HCkk8rKoL5zF92MEZlsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: WzMse5slcsaS4P-XlsrxWtNpZYIEspkK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDEwNCBTYWx0ZWRfX22NJYZAprSz2
 ts3DMmPW/eEUDFrm1XA+OLlHc4DuOLA0QnHPvS9bJK2/+N4tIGGgND6WtyM5hTQF1MRZg/dA+CD
 0PRRDq2jMye9mKe6SFm8c5XyaM0CRMIT2A18udqbljMoxxSgAVDvsq7DP8YgX02SJ8iXZyQCj/7
 LNqkrD3k/9/3sBjXm0n1gjgB/91LRM4uvgtCbglpiWAj3rCRXzsIhvd7rPs8+AbCPAmlZewtdOW
 fZYAyyFf2lP514exRkKidqTeVOIt2hKqUxKt6GNPEu02qgJYtJ+F/CvXp78lu4cdDNhbD3qEd8a
 ykif+M+tras1ujFuhBAhQ0kQPKuIm1jxQTl+EnydJDqwB4GZC660VxBXP6+rulEPsIm1CQ6yZ/d
 SJ5/6zjH7a5JGeFQ98s6/dfjN4F+AFecFpsgKrvuqSxlyLkF8l54ajkGy4P7d1CCjNo12MRv
X-Proofpoint-GUID: WzMse5slcsaS4P-XlsrxWtNpZYIEspkK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_08,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 spamscore=0 mlxscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040104



On 8/2/2025 1:19 PM, Krzysztof Kozlowski wrote:
> On 01/08/2025 18:36, Umang Chheda wrote:
>> This series:
>>
>> Add support for Qualcomm's Monaco Evaluation Kit (EVK) without
>> safety monitoring feature of Safety Island(SAIL) subsystem.
>> This board is based on Qualcomm's QCS8300 SoC.
>>
>> Monaco EVK board is a single board computer (SBC) that supports various
>> industrial applications, including factory automation, industrial
>> robots, drones, edge AI boxes, machine vision, autonomous mobile
>> robots (AMRs), and industrial gateways.
>>
>> Below are detailed informations on monaco-evk HW:
>> ------------------------------------------------------
>> monaco-evk is single board supporting these peripherals:
>>   - Storage: 1 × 128 GB UFS, micro-SD card, EEPROMs for MACs,
>>     eMMC on mezzanine card
>>   - Audio/Video, Camera & Display ports
>>   - Connectivity: RJ45 2.5GbE, WLAN/Bluetooth, CAN/CAN-FD
>>   - PCIe ports
>>   - USB & UART ports
> 
> This belongs to one of the commit messages, not cover letter.
Ack

> 
> Best regards,
> Krzysztof

Thanks,
Umang


