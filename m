Return-Path: <linux-kernel+bounces-835720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3661BA7E44
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 05:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F1E917870E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 03:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6CA21ABAA;
	Mon, 29 Sep 2025 03:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ALD1/oni"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8415212549
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 03:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759118271; cv=none; b=scUfnPU+zOUA8mInXgXtXSLLryVY7aPPFrITByh9VdzV4ZVUZhlezzqDtEYCzb1BP7lpQb6JbZiCpzdsfix2Ig+VLDDZ0DCf1eANURM1G3a7bNcg2Wf0Ds7lGLrZwIUpA7xYj5QoDssqJO6rICVdymeGp3yfusa9jaeddpuy17Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759118271; c=relaxed/simple;
	bh=iEoKhzPpfOdEKO/nolkZGQ09h0XsBnz8AzJd6bFhW7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KTDqIqTmRRU/a/WwQj/wdvSYAm0Di0T+HK+PmMBWq1mYiErIGqIGNdDzg0DoRHLVXf9P8lc8YVvVXCfNdRxNhi1TBywJIXfDGJZ5R4Y6Bx8/mjhbV9YvEXHrtGwRJiSZFrP2jN+pza20wfQYkY7eM26Cqy3SIK/BMu+rgnauosQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ALD1/oni; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58SNhIZZ030750
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 03:57:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x5IKET2ZNaGZqu6vqn23CHsftRhx4zpASBXEh2O62jc=; b=ALD1/oni7E0Qcubm
	g5TALLkBGTCUmHYW+fuNpKM4J3bcx8KZDvdu+AneTt15G8DKwFGe+o38O5wHM6K3
	q3c8oESGGT9smKgWgZ8Lrje/qBM5WrSR8sV98BjAZ3XTad223SOd2F/AqK5LCyVi
	fMFDHqMIILqZoznI6uyDf8STPoDe9dkHZ8lR+g4h6znO7mC+dxcYZ3RuiQ50+8eZ
	giwb0q3GaNaWJW9+77UwpCzCahaC2iU+k0xm8nJCb7pHtXbZDdQVMExvugH/eOH+
	v0w32g89HNFpe5HJI36KaSl/HS6Ax1nR6RXuXSZSMgVi4o7Bm4+gJl8e+jXEsmDL
	EqBjFg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e977kk40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 03:57:49 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32df881dce2so4396402a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 20:57:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759118268; x=1759723068;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x5IKET2ZNaGZqu6vqn23CHsftRhx4zpASBXEh2O62jc=;
        b=PAsbMOcUYYjFh/N7/T2CMGMOye/LlRD7e4+M2wjbX0pFh47+aKVV3UKS4NgG3Zs48H
         p9hT99haomsEJqx8vPtjLZSd4ShMPZ/DC1Eek2akqo7RU0BJ0vX5+WB3HCUqyQV5y92d
         OgTAfxtZavFTbrytInMWkv7haPTXDLFhQaouCgpjVx70LHWTWtmMzzuNVEdoAkmz2g43
         pX++93DJRxMQfNpYeAeC5fGOHozdp8M3fF5OehZRBcNJFjDuG5vlEflqwCtY/UhJceI0
         vS9FyV9eLRb4g2FMxWQiW83RjCqWJj/nikPQowrsTt/PD5UU9aZNLe0rIDKt0lLnE5Nr
         6cbA==
X-Forwarded-Encrypted: i=1; AJvYcCXL4ovNOkiYbED6aWzepFQwfp5DD8XHaXQ0oRuPh2A2hk1UVQ88mDE2Bs8+GJ11P7CrMttGp5E5/1t1Otg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJHZ6b0cmmY3MJHXc9TtzKlpUr0dHE9Vn9N5uWvym/q5SmI2b8
	+qOCuxasVCCiWoRQNrmquTwmriQ7NTc2R7CbjCwuSoIJVkBI9oNROEKcEPVVEF/YosxdBWLdJiM
	IziY53IdcsA36inIaCdHMehqZQXbf+4ayZ4vP9gXgJyHlC9RSZgHTURxbE6W3FgS3vgVKtSepP2
	c=
X-Gm-Gg: ASbGncs+66OjxMXh2tD5ZvS2u2Dwer5ZAvKC4tBZclT96HNpPYyLKGOMUywAFAFrfxb
	SjTP6Fx54w8aWsT6Rm1+r75319lqw1wqd1gIWUAfs98t/JmQff9Pg8e8vD9+e/DCsUHPavnpkQG
	d+hR4Za92r9LBxf8Qic3353gB4EJXzSTyhrZ+lfhgY75yH9ny+u5TH5eCPB0Wg98fJ/s8uZfl98
	NFRtGVWQdpLbGyRbZTm2HAdnWwZ+5AYoWldmW3HVOKDHFsCb6ioKUJJQICRvCmIjepRPFQMVvln
	Yh8mEFdTR/89TRNioJ2/rAh007fpbzDSKAxhg9InI8UZvUJUwMGZFaHInXRpac/S4JQ=
X-Received: by 2002:a17:90b:314e:b0:32e:c6b6:956b with SMTP id 98e67ed59e1d1-3342a2702ebmr15297818a91.4.1759118268183;
        Sun, 28 Sep 2025 20:57:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuArBOJSGdH2d51k037g9fbFwwwtZi2aIpgGp3j1sTG3Gq9TQVKDuopvTuXrBfvMWjx4Po8Q==
X-Received: by 2002:a17:90b:314e:b0:32e:c6b6:956b with SMTP id 98e67ed59e1d1-3342a2702ebmr15297792a91.4.1759118267758;
        Sun, 28 Sep 2025 20:57:47 -0700 (PDT)
Received: from [192.168.0.195] ([49.204.31.98])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c55be61bsm9939207a12.48.2025.09.28.20.57.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Sep 2025 20:57:47 -0700 (PDT)
Message-ID: <fc8b2845-5c1e-4f4f-962a-b1b0009114ba@oss.qualcomm.com>
Date: Mon, 29 Sep 2025 09:27:43 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/24] arm64: dts: qcom: glymur: Add display clock
 controller device
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-22-24b601bbecc0@oss.qualcomm.com>
 <CAJKOXPd97tJ_1cRZQmKE_1-B7AqgRr_CJ1cYMe=v4hBb9Z3eog@mail.gmail.com>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <CAJKOXPd97tJ_1cRZQmKE_1-B7AqgRr_CJ1cYMe=v4hBb9Z3eog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: h1plgaZ572UVbMH9sALj0XEFOuDgw3BA
X-Proofpoint-ORIG-GUID: h1plgaZ572UVbMH9sALj0XEFOuDgw3BA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA0MyBTYWx0ZWRfX6h3cUCnt0gH4
 TsQMrwXYyt+mIqV4Q7+Q+TO30b9PbKRKYaRs0oBypItnQNNnNsPUI73Lq0UDOjziwngvY3tFbUt
 2K6IaG9mPvq692j/8ZkxpQvJB/DGgZ2V2DIu7BqwjDWwGZQLENpNazUa6+ld4R2onlZil2iDj/9
 ujMMit41C4VAaRI40y52nHDedH4re2XEHufwU0/f6wtatnC4vxgBpVY1wsIdWvp8STKtIAaSHSI
 TJNfyEug2sCU+yKEzgDSX2qpPrjh2xiScrsR5kClILXZ6Jl3HMMib5/a04nveLL0S1//5h6tDd4
 Ylee4wDlbccno2+iATSs38BNOAX3yzQkE10hFF1pfKzczw563Tg3uof52gLYh18pdb7YqMhB0Fk
 OLN/b6wFvuzdr/EBWKOe6XNplpnFSQ==
X-Authority-Analysis: v=2.4 cv=Sf36t/Ru c=1 sm=1 tr=0 ts=68da03bd cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=YGGbjFxyX1jBzPa45jwK0A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=fESiJu-7EXqA1LiMi5MA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_01,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270043



On 9/25/2025 1:48 PM, Krzysztof Kozlowski wrote:
> On Thu, 25 Sept 2025 at 15:34, Pankaj Patil
> <pankaj.patil@oss.qualcomm.com> wrote:
>>
>> From: Taniya Das <taniya.das@oss.qualcomm.com>
>>
>> Support the display clock controller for GLYMUR SoC.
> 
> One clock controller is not a separate commit.
> 
> Stop inflating patch count, you just makes it difficult for us to see
> complete picture.
> 

Sorry about that Krzysztof. As the display clock controller was enabled
later point of time probably it was kept as a separate patch and not
merged.

> Is this somehow for LWN stats? That's why one node per patch?
> 

That is definitely not the intention. As it was enabled later, it was
left as a separate patch.

-- 
Thanks,
Taniya Das


