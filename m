Return-Path: <linux-kernel+bounces-653900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A7DABC057
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 16:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8E143A50E2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 14:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE7F281525;
	Mon, 19 May 2025 14:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dd8WW/JO"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0785280313
	for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 14:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747663988; cv=none; b=dnb2FN/LW/9ScDNpVR1BAxgCsgri71TFA7cVh6xpgRITkOyHlbF+K+lQE6sWAreQfV4p1r0jMzJbBP7KEv1b5fkrnuUggzMMLDdLqFDaMeZhDrJsaojtQFDyQUy0t96j5lypAJE+G4HnnjmNach2VB4lLYJp9jkZAPnZLnZylU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747663988; c=relaxed/simple;
	bh=Xhux39lBBQKuPR8VzWQRXBJuBTgP/d/kAe1GmAif5J0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=la4aZtO2G+FgwK6noqdg2cGzNshKJGkkoN4klLRnxD9ENHy0v/B3aUEbaKXzrOKD2ExZEUMu92OggTF891R8/v6zQEnl/1FwWj+krV5OHvVe0cDDkAMRhdsprCK2V6sHNFBe/ulfmsP9B34b/6z5RUkwVtUACaTg3uTsXZPO7bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Dd8WW/JO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JA1mjJ009793
	for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 14:13:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rCaJgluMmfXFVWvhFvT9T3CnWrQInCYbxFEso2AuIX8=; b=Dd8WW/JOvAUB19RG
	Y6xDTbA1jTR2Yth+8Dm3JLB+/nA8sVLWgwOAbeirpRRaYG5NV8FiRxzVCde/8V7P
	+KzXH5hfwXj78nmqfsqcEzY27BJxhNIsllTGkYNpwlklOVU8yfWV4G2scIksGDtj
	DbQdEUl7Jr11OMgmwwjnGGsExHDGBo0QpyuRlnhPOH4W5cxqXoACUfdWZeynylXz
	Od1M/Q2nSzFTk+cBHW4H81zmnKHquPArOXN6QF26H5vSu84gYoZ9TQSD1R5QVP+y
	3QXY76mtfTaaRhPWgGa9ocjQZzRiEQzEtseqQClq1MpqygvAioMbsQ7bRl5wOW0a
	dKwa0g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46pjm4mh6k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 14:13:04 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-231e6e1d988so37356095ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 07:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747663983; x=1748268783;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rCaJgluMmfXFVWvhFvT9T3CnWrQInCYbxFEso2AuIX8=;
        b=QvKTGzNWxkR9QLKvtKi4p4ltHoEz1+FCFTqHwFo11hVBoE63ob3Gw2k2fsyqElJPkz
         B1zvgJXCpOBbNHgDcnnhMnCLF84Ipnc8d53+ytiEvI2AGHSBgSUTwKBgkTfyVyhsLNXe
         7FvW+YDIwP6oqmDV7VEyRs8c6BEFV20NcD7uMhgW0hwKekoT+A59AbMSgrTGebELQr/g
         1ugTAgqeuUmz1sNXVYof3jRjXk2cmH2drfBArdML/VUG80FJU8e+uDWJ8COS70tkyehg
         qQzeSC30Rbc/pwk1MnKEjNzfJQH/5VjSmqLpB2GCKg/MS4HU/B3CKiP9SkPUKsnurEet
         OQSA==
X-Forwarded-Encrypted: i=1; AJvYcCU8yfIxS+OWzCt12cB1es0AKa6tWTF5+0OPs6cUEprBC8v8e9mtyeSwiipoq7DR9/+sXUcRPUw+K3e1TY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuBs2YIKVnZIWqTQFd7celKwbD9GLx4nVXhF+b0/g/24WC+Jbo
	1rm3OAuXgYXqlnmtRYvM2/8wQtMDeCmT23c471zhP9pXMBxFVdD9OdW7PfryypRns3wzVNcAcot
	GDBflWhUkapx44paiKywWf2386S3enM6zBBhpKHxOxyb5y0nqZkF11VYpgaR63yfNfl4=
X-Gm-Gg: ASbGnctBv8kQtR6Jh5A0MF8O4Hd0tXsmIEjr8zZ45OPeelmIv3V+PwGlhJQx95zfasJ
	Bjind5kuIqFV23c1xoFT196vNPj17G9U7OW9Tt3XaqQl/eEielHfokWlgWUx4vgDw7fNV7kVSyk
	v2M+fgPGtjUbfzbGYhhUUQDphJTVQyTsnmjZOSpRKoiJ7eYYiRpZG56tuOP0fxcI8ihV09MWHU5
	JXCPEQL6P8r9UBygk/O8CPdrYBkhDd+ZAFCeGLQM2CnroM5gcFJ3ZdTYdYljRKGkml4gi6wkztn
	PPJmsHiQjRlHWQL3FpE8lQp8B9cf0ZdKOetG9s+LkG2KRZGhz69ByvJiVqdnZA==
X-Received: by 2002:a17:903:2ece:b0:224:283f:a9ef with SMTP id d9443c01a7336-231de35143fmr144134425ad.6.1747663983180;
        Mon, 19 May 2025 07:13:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOyFknI1B/0ShJdLNtgetMKBIvN9RE1Qjwwuij6mD4Q1x4BLuZcO7/mmxxHNOCBDtnP7jDsA==
X-Received: by 2002:a17:903:2ece:b0:224:283f:a9ef with SMTP id d9443c01a7336-231de35143fmr144133945ad.6.1747663982607;
        Mon, 19 May 2025 07:13:02 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4edb0d0sm59771315ad.254.2025.05.19.07.13.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 07:13:02 -0700 (PDT)
Message-ID: <cf4adaba-5601-40b9-bd17-1b1bfa686b0f@oss.qualcomm.com>
Date: Mon, 19 May 2025 08:13:00 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] bus: mhi: host: fix endianness of BHI vector table
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250519061014.12225-1-alexander.wilhelm@westermo.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20250519061014.12225-1-alexander.wilhelm@westermo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: doq3AVnU6M4-LqWCgM7buiwbrtoEWFhC
X-Authority-Analysis: v=2.4 cv=C4bpyRP+ c=1 sm=1 tr=0 ts=682b3c70 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=N9GNhs4bAAAA:8 a=EUspDBNiAAAA:8
 a=rGmKAQFIsUGY2xqShAEA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-GUID: doq3AVnU6M4-LqWCgM7buiwbrtoEWFhC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDEzMSBTYWx0ZWRfX2iktUEe1+hkC
 CEufZ508TG3AplR4gZdQAPBs/EZYAEDie+ApTfhjnUmLxW7S/uW0YWvaFYH4gwjmVLgHNXTXcDP
 2qNbAqE8b1b92jmRZIH+OO/PkGIXMm0eL7+iyx8D2jFN76TJ30DM0dJxlv+5paaJyiAhp0iWK+9
 WN8+zTEQ2ToTW5YjPYVqIOVzmZBQJrQbdlxXtORwS495t0B8100Ctip96N+wwJumTKjg5dHg66N
 Z+vKI5qC/HLQGKfi1AuiziDY5qMOOOntgv35gLbQvF/ZhnuD4G46c2qseorSNI3TiGl3cJwMVr9
 Q7RRMgrga3W+oAA7YMsIl/qioVW3raSaLYNeu7QxKuqWdwo6FrMNBTxoXoUSWdgkqLfZ2MIX/lD
 KFYxLDZZnjAT+0mQnaW6k3PNS4qDO7yejM/d6nG+eJOhylcoT6sTKIZG7aIli7Vvz88Pjkd6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_06,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505190131

On 5/19/2025 12:10 AM, Alexander Wilhelm wrote:
> On big endian platform like PowerPC the MHI bus does not start properly. The
> following example shows the error messages by using qcn9274 wireless radio
> module with ath12k driver:
> 
>      ath12k_pci 0001:01:00.0: BAR 0: assigned [mem 0xc00000000-0xc001fffff 64bit]
>      ath12k_pci 0001:01:00.0: MSI vectors: 1
>      ath12k_pci 0001:01:00.0: Hardware name: qcn9274 hw2.0
>      ath12k_pci 0001:01:00.0: failed to set mhi state: POWER_ON(2)
>      ath12k_pci 0001:01:00.0: failed to start mhi: -110
>      ath12k_pci 0001:01:00.0: failed to power up :-110
>      ath12k_pci 0001:01:00.0: failed to create soc core: -110
>      ath12k_pci 0001:01:00.0: failed to init core: -110
>      ath12k_pci: probe of 0001:01:00.0 failed with error -110
> 
> Fix it by swapping DMA address and size of the BHI vector table.
> 
> Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
> Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>

Shouldn't there be a fixes tag?  Probably pointing to one of the 
original MHI commits given what this change is touching.

-Jeff

