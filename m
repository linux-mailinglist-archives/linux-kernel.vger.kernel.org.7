Return-Path: <linux-kernel+bounces-838621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8179BAFC1F
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 11:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E6CF2A2F61
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 09:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950842D9484;
	Wed,  1 Oct 2025 09:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BCcdx13r"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9464727F16A
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 09:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759309380; cv=none; b=q7RsXBj9/+/pmAhIzCFqJVU00rXuuMdz6sStNYBnOcIVwl4Yhk/0v9V8jvOzqmW08Hzdu3Hzzd9QEXMetosMQs2irUX9iisaovl5NfN8TIc073qUyA9/ns5viFWPoTX5Uzl7Qr6vijY8anLVskGpPKURtsNVwc2/7n7+kTvto/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759309380; c=relaxed/simple;
	bh=rz85/arNz6RsO3g0zililQ8uETwv+F0iyZRoWVQC+EE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gRv5mCXzv20E668g6UyFFGCDzCLDPMtb7EDVJQJYjNrNOlXP1LKEyiLsPnibURISjHQayGdYWvzaAR2NGtSLzrbgwdoGmNkC8YWS3UtILcfpWkCJKJSm7E/E2P8jpTz8vPaHqTSN0XtB3OrfzT9ZY2WrJ6jTblzGmO1aXhUDYrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BCcdx13r; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5917KfUa020544
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 09:02:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZPfFz+jJCaCOBtaru36gwrt+7dEJBz4BRIuDpZVmIA8=; b=BCcdx13rnITI8ibx
	ZWmYphcSmweMZGvlDEINVH610zwPBu3VzVjK01VAhTl0Ov3bPR315XcEEH7e9IjQ
	nHmRXKVFyeUVIR65WC3gJ/mOhlld3Qo6x6zhPGKCiZYhUDc8CGscbnhBiuLYjYA9
	uwQXEvAgoJUSW3+QXp+WcJWFyvQjG+QyshfqvfzaAjcbII5zbaqxkd0AIr3ZwIsB
	IYw37j5gO038nJuXYQNFRvzNxUABAD6tX3KWmogw6wH/z58M+ueS2KlmYoAhdbxU
	sGGckbI3XAHV1nNvO70PYnMkGFKUZ28QzU2jeElyiLhRPr8Tt8C30ZCZ7VwORBA7
	7xW+3g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49gyu1889c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 09:02:58 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e4b4e6f75fso710671cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 02:02:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759309377; x=1759914177;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPfFz+jJCaCOBtaru36gwrt+7dEJBz4BRIuDpZVmIA8=;
        b=fMkvhs5JS7n9kk1Bj2xYv2pvOrsUZwsWl0FRQmQ4h7aQhrRuUOYwtNv9N0KcvB0Kg2
         aodxgNkXa8T9R2RxCo0xCGvX/Ns7XEejT2YYXWwpLPGvbY2eegLf+Oxbq9oXvDNQMn97
         QwrWnjKGVI46fKf7lDyGoJd3RtUl1NfKBYy4mDZG2jWmQW4BLfn7ZA41YTiWnv6+aI4p
         wPLVSKhe36tXQXUGYrg1saXK3Qd1F9czK5S+74K/bzE1ITnRqHRoca9j5O6jFnJEuWo/
         sO6aNfaBJEnIhBIdLocFF0/CTCO8PDwI9rF5+zixxe0RvcN0agu+OwKbnHw1bhynbazh
         YkAA==
X-Forwarded-Encrypted: i=1; AJvYcCW/1Da/OtvPCpDdP2ZktFT+ghGjlPfnk5Nl34edHtRefYoPCIV/2F6Lh5w+ovBPca8HDBH+C0gpCNU4wmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhnxXLt1cOwUar4fdWHQa+C+VlIrr3ZV/5vIwhUHNQGPchvWes
	EsAi4rTWWJVSdUipefNwmXFCDEFxded5FycTBO6Zh9AxOdTi581k8k6Pru/QRESH3uDzBsepp8k
	TEHgHG/cHG7GgsJG6wPPOzYnbDqKm8R+3zIgwgK8AKmJ0DlnjlV3349SFq09cnsp5IJQ=
X-Gm-Gg: ASbGncv1pifyw+vYpb7mvWwyqY0PIbilAFMseB/NCGv91nmSupJpw/rjB1gNW96lTte
	8F23Q8zI+WbA8a6AfQzRzjRgNYG8kAbBPpL2oi3dy5Cvf+hBE51sEoaJGvWcdw8HEb6NiKjnTFa
	caUuHsUfC+VdHLM9+jZ1weNhjGFHvzCNDd4PgSInrGzyxjJxPbYtii8XxuObG+5go5qJQwG6RJi
	fiqT04Ht64tcYt4cSImN/U5UH/PKzd3ZlGOYypWQItO1FnGpjKFKbsKtt2kyTJtqTN+pLZV+Hh8
	xW2vAvp3AXkUgmhWKixwKnTfe9+///tA7pG2TAAsbGXkLPHJpZDAfSZnRWajf0lBJCU5zxuG8CD
	Gz8qqVXshW0tG9aGXW+aZwDYVkTk=
X-Received: by 2002:ac8:5a06:0:b0:4b7:7dbf:9a81 with SMTP id d75a77b69052e-4e41c1605aemr23476171cf.1.1759309377415;
        Wed, 01 Oct 2025 02:02:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFU9Szphg/SN7TMvpOPbN0MRBm6lNfueGopwk8fIzSbGuR1BhVcLsJaaOfRkusSv6notyn1SQ==
X-Received: by 2002:ac8:5a06:0:b0:4b7:7dbf:9a81 with SMTP id d75a77b69052e-4e41c1605aemr23475831cf.1.1759309376823;
        Wed, 01 Oct 2025 02:02:56 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3ae2cd7sm11618651a12.31.2025.10.01.02.02.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 02:02:56 -0700 (PDT)
Message-ID: <c0567a7c-9d21-4fd4-8140-99e72184dc2e@oss.qualcomm.com>
Date: Wed, 1 Oct 2025 11:02:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/11] arm64: dts: qcom: sdm845-lg-{common, judyln}:
 Improve HW support in dts
To: Paul Sajna <sajattack@postmarketos.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        Amir Dahan <system64fumo@protonmail.com>,
        Christopher Brown <crispybrown@gmail.com>
References: <20250928-judyln-dts-v3-0-b14cf9e9a928@postmarketos.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250928-judyln-dts-v3-0-b14cf9e9a928@postmarketos.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RfGdyltv c=1 sm=1 tr=0 ts=68dcee42 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=Gbw9aFdXAAAA:8
 a=sfOm8-O8AAAA:8 a=pGLkceISAAAA:8 a=bvKeCVLL_wdwnHjQap0A:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=9vIz8raoGPyDa4jBFAYH:22 a=TvTJqdcANYtsRzA46cdi:22
X-Proofpoint-ORIG-GUID: 1WmyP78wTKd0Il35wwBnVDqPvMp9O9Cs
X-Proofpoint-GUID: 1WmyP78wTKd0Il35wwBnVDqPvMp9O9Cs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDAxMDA1OCBTYWx0ZWRfXwdMaGV2ozNu/
 4IPaYQudQ8t2h+kmoWZzL+Rl+7lzDW7GAhMrgjBQLKKpVRItY9cRimUg0AMawuPmtAGzwGi4CX/
 IFRyz7SPv5tjEm8q4/GryR5eYjLRz5W+Ep2XIIPj8bTqKsH6CmYUBOUh9xl0yyz0KzJdkOcJ5wJ
 W8K3uJLhXKneSMkxsmjcmITwck9MOd5C2cBHrWG4CNZjDt3yhwXUhArWeZ8szWLe/MWx4zhoR9G
 /75mmBNhm+9DG8y2l3DOjYWTK61+lMMhVDiqHV5ciKTeb9l0BneRsZDBRM319Czwr/ttXmcVzOO
 ieI2GoLH1O/3gfUxL/gXG2MGJLBKutY5WEoeVKI8tMywz7u33Yg5SNj2WeWoxc6ArwoO2w0Q1Em
 RPMUSEb38/KtxahV/dlJd2eRXlbg0A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510010058

On 9/29/25 7:05 AM, Paul Sajna wrote:
> Rollup of improved hardware support via devicetree for LG G7 ThinQ 
> (judyln) from sdm845-mainline kernel fork
> 
> Notably, this patch-series enables full DRM acceleration and wifi,
> among other small improvements in individual commits
> 
> after this patch-series the main things that remain to be worked
> on include touchscreen, audio, and modem.
> 
> Depends upon panel driver patch-series https://lore.kernel.org/all/20250910-judyln-panel-v1-1-825c74403bbb@postmarketos.org/T/#r9a976ca01e309b6c03100e984a26a0ffc2fe2002
> 
> Co-developed-by: Amir Dahan <system64fumo@protonmail.com>
> Co-developed-by: Christopher Brown <crispybrown@gmail.com>
> Signed-off-by: Amir Dahan <system64fumo@protonmail.com>
> Signed-off-by: Christopher Brown <crispybrown@gmail.com>
> Signed-off-by: Paul Sajna <sajattack@postmarketos.org>
> ---
> Changes in v3:

Please run `b4 trailers -u` before resending to pick up any tags
you received in review

Konrad

