Return-Path: <linux-kernel+bounces-885236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB33C3251D
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 18:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5050634B0C0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 17:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE82B339B35;
	Tue,  4 Nov 2025 17:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LbRGfxV9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c8/6Tcsz"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7174C330305
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 17:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762277114; cv=none; b=LS/DGJkYb7eobtAssjXGiC/cJ35mlqag9sQ5kWFYlpQ2Bjku+Q8dwj+OTMo6dcjEup3WxS6dbquJ5LJQrq9mZ5mM5yapLQRe9xiFUOswzhspWC1zV48Mzi9rhTIPKpEEdjYj83Z2B0ZVNoCMM/hOjrJQc9RWBj5BMYKvddD6TCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762277114; c=relaxed/simple;
	bh=nnjUB7LL5+SU4kruAo+s/uJqZUqYb9G1b28dkS2e//8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UttsxvcyUA8glaP9IyKfA/1mGQapz+5P29tniPY3BBxF3RB2sCXHA8FHDyHGRXo2Bx3UJ9OM+xXcAmxIAvh1DkSiNpXilANrmiGmywScoV7rNEU8tPjv0Ae7iI0jZSfO+2ek72y/guvnieW38cMFc1JcnT6UJYFflA0JW0o5kzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LbRGfxV9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c8/6Tcsz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4Gg9V92547412
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 17:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XqomMh4cXtCMhqeRVoWkhlqju9FTNhESCKlR4nUZAiE=; b=LbRGfxV9m3rOEpez
	zwqGcxrskCA4S+0x66f5+tbJp9QbP1R6m3zHNhiEhhUOJGrJ84ccRuBuur0md/5x
	fkeLSoCa7s6EALNryjMiFt8oRGSRnx40ak9aiwkQVQxJ2xtwrd/JUmfXmUlOWfXC
	HzwNWd01jgEFOwD6eVVkqzRbpT/AxwcrtV8B14qzlbjYgp3nfZ+dAG2zeGk/ZXTz
	srYI0OOUx1oua1CIHnV7gJUjhWi2CRblLoe6ANYxT/Va50gde9E6mT4/OroTrvfD
	FmlmtDv/EVJrcf79Qv5ysS00ML+gDZTD3AvZ7Lf9g78XWx55Ch54MiYSlyMhrJHU
	7QKtaA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7fgrh7r5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 17:25:12 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ed0633c433so17822051cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 09:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762277111; x=1762881911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XqomMh4cXtCMhqeRVoWkhlqju9FTNhESCKlR4nUZAiE=;
        b=c8/6Tcszz5THkRbDFlfNMcgmDxY9jCuWUZ+MgVADWY0rB7i1hxtjkDzZDq72RIC5/o
         gb+qr0hFNjELZp5TkVIFhGrOfL+ctZ4437udqDipm+H/8B/wqb3GbGADmopLGzTXPuo1
         AWSs/kGx/Lm/sNBaa5jvMvcO/uPlh4TDSTfzd9ekkDilkJpdBfTQRkKCvBlUgwWocZO6
         hi17w9dbPffodOQ20bWQC1rNB+Q6tZJ19E9zaEzPDZLMG7mjP8zi/CMvwu24pQgZZqbj
         mbVeUlWKs/gflmPw1kEoGPXIjEsSPt2taJQzN5Fy3AcJKXkdRPTeuFJmfbW+jqSCCEbH
         H2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762277111; x=1762881911;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XqomMh4cXtCMhqeRVoWkhlqju9FTNhESCKlR4nUZAiE=;
        b=hX3wFRGIvG+WH/5UHzvLS2/G9cNHAa8S1qpC0f+ssP8Iyy30A40zQJJuhqhCb+ihkZ
         agUTUqhdvnwd/0JJ63RbeNCdEWt5RMHyRQbgGj92/ZssLeAiE2NVNZ/KwAgJ65x+CLa6
         lP7PkunlGJeylaSjEWUr9kAkN7Xeff1EQuOKnu/e6saHXPci2kjl5DNs8h1RkaGgWPDq
         60o8cdLMSDoi6DXRp/8Z6B6ngEQ7CcBgWxc+fb81MPqW/pqFfI6WeiMIlEunmsFOdB4R
         2oxjAkQfy68mRMtj4egt4acUfRpVJRcBFQBjjFRmo2QIDxb49d0EE6g0svBt9ByfbfK1
         cQdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyZG9i11dDm/fymYi+SKaGMcoqTovq+qbC+1EfyoJ/dqL62u8TXVhFz64+UoxjjZ3sjTlx3gpKf5pk9KI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDfoUzab9uYzDfWn0jKBRjV7Vm6Q1GbOt7iyye+ifbrzevIXqL
	NF0sSk94NYa3cJB4Gg1vs1rM2eKT+/F/6Ix4GObJ/KxOuvpuyHtyMh2ld1UQe86B6NCxJk+UtT4
	bV+x698pPwsLOam7goyYR8gVEF91AsgulGjVHiMrUx0tBoJ4a2bcZYnXQe72achQbZXo=
X-Gm-Gg: ASbGncsWIeJcl6shTusBwu3xzzlSUy7InW382jducWpVJh/Se4TTCN0HbMT2J3UkQJE
	NHuyfH55BWi6fUnGtZ532XLdQQztyE8MfBauSqJsjfGGjKTDcgKLG01kDvR+1+u60/4E4/B/Ha7
	5j/hFH9/fhVPeJh6pnJ5obpy4HvjIRJSAnb535O++Byhilo3/ZB5xSzKfw3oHJ6W51ew1Qzq1E/
	VGvKyLpRN8P3np0Bg8pNZNE48Ar1V9KMtwLLSgQHJavLpNes0+mXq1Eyfh0aEeNurgdWaawWzg8
	ZQd4rcsgcxWkZDRAQ03H7TfbkZKaWfUhy/yGdZS3zkDJGXL5Y/u6Ypjj7AVHtY+uRv5mumc17Zc
	u5nG64Axl7vFUbW4hhtptZ2iYW2PwfBjFoXMA8G5cH4tBF94Ohuut+nLW
X-Received: by 2002:a05:622a:50:b0:4ec:f123:230a with SMTP id d75a77b69052e-4ed725d82bdmr3092821cf.13.1762277111508;
        Tue, 04 Nov 2025 09:25:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0AZ0NEqJyAxkO9tPQooyXaYVFUIJ/Dkxa/d3F8NW2e4gkuIPHPgeyXln246n3SP6taM5GUA==
X-Received: by 2002:a05:622a:50:b0:4ec:f123:230a with SMTP id d75a77b69052e-4ed725d82bdmr3092491cf.13.1762277111059;
        Tue, 04 Nov 2025 09:25:11 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7240540d7csm257218666b.71.2025.11.04.09.25.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 09:25:10 -0800 (PST)
Message-ID: <8103d16f-6b03-474a-83bb-b2e8ba9b9cbf@oss.qualcomm.com>
Date: Tue, 4 Nov 2025 18:25:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/14] firmware: qcom_scm: Rename peripheral as pas_id
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20251104-kvm_rproc_v6-v6-0-7017b0adc24e@oss.qualcomm.com>
 <20251104-kvm_rproc_v6-v6-3-7017b0adc24e@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251104-kvm_rproc_v6-v6-3-7017b0adc24e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: lKHa_2gDe_wkvwFJzQ9jkIFkQjDUicsi
X-Proofpoint-GUID: lKHa_2gDe_wkvwFJzQ9jkIFkQjDUicsi
X-Authority-Analysis: v=2.4 cv=b7O/I9Gx c=1 sm=1 tr=0 ts=690a36f8 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=1x7xYhVcW7TDj72elYYA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDE0NSBTYWx0ZWRfX7JeFWTTxQDeo
 ud+xF2BQCWwWU8ZZQlGol4ZDJgeWwJpwIptUhqB3osuCR4gB8mn35fu8Q2SDKNGkRgotSOOdf2B
 vQcxmNjQdC7zZ31jd1cQ00UtsvnlnOTDlmICilOmNwkaLiEaN+VzntovsXIJfDDc1NAhGl4sBSk
 X4XzrGhvIAIqY0uVisrzp7M7ED/V0uiMw+8ISTNc3C7pXl6TIeeSqVTA96crQJ6VYQkSFLpKy8i
 19cu2uQ7HngAwjqkulqkTR/Z6GQ0jZvAidfzJrnntpxtcj0n/dsjcR950hcBgT8S8+/qpy3aKmL
 IpRv7tmLPpgIGZ2QAzvHU2w+V6IKjv96p9O2zx/f6gpoEuI97uhhtBZev/95gndIbeHU5fIwwco
 wysUFW8MeYauMoLSmAZGt3AxPP1AQQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_02,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040145

On 11/4/25 8:35 AM, Mukesh Ojha wrote:
> Peripheral and pas_id refers to unique id for a subsystem and used only
> when peripheral authentication service from secure world is utilized.
> 
> Lets rename peripheral to pas_id to reflect closer to its meaning.
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

