Return-Path: <linux-kernel+bounces-832444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F599B9F552
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3755174CBC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76311DDA1E;
	Thu, 25 Sep 2025 12:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jqA18vdS"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504B61DFDA1
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758804423; cv=none; b=MjmGWp8pfrEHXA4N5XNCae/j0WyL5RKU/ntVv2WI+hTGi7O36dViXW4mwJ4HipHH0CmtDHv6+dZAk2Gbs8EmHGWTX5f9RSVSYK9SGH+HEaMdoruwpEAiE2XNPuwsi5DJHXfdniG2/ybK8U+ik9EFRScw/gSbKny9NcXqv9/1Grw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758804423; c=relaxed/simple;
	bh=Sf3l9CHT01uRYsHEl0V9vF5wYANn0cN2l7qyPLMGwTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eKBDrUAnldbQu2wZ+N1ZS7BXv9fEtKVJZXFzRVzuz2YkNZXm60+YW0SPMgxhc6OViFoHdNT6PvjOe8YC30PgVsT3VyfPW6WKPKKnEfLAdCpMXWh8rzBNhq4Ve7aCILwe9hQbZ4nQ1xq08zCPwfaozXFEu8rEhuwKxnLVaukIOWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jqA18vdS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P96XmY029044
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:47:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m4djSLZXtAvXlpgvFemWia+EmnebRJaAYcpun5RmN1I=; b=jqA18vdS63rgkH/K
	9+QNA3ax73bNrzpf2zfelbtIBPv4o2/DH89fghA6RWHiuJU8cfIM9dyshIvvTnrJ
	jn6EYeC1f0eXlgPmx87Qg1xdMvc4gqciVdiAe7In+xzeeoRK4n06NJZZycesxz5+
	tNeGsPb7julQXchhf+ha9QcGFdXvfLFqRClCEgVTCMKOyKZZllXLCpOgKNvZLEqW
	KU2kbYpMkW0TczT4mz63TY5PzV/U2AUYh6+3hsfkUXLOIbh7gHZGN7pt2o4fRoit
	bMOCdXa/TitRujTI3m+dwRzoPrxaXKB6Kyp0/jTmuLez0EdnyISLAIit+Psmu1xC
	s0IwuA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hmp0fs8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:47:01 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-82b15c1dca8so36158585a.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 05:47:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758804420; x=1759409220;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m4djSLZXtAvXlpgvFemWia+EmnebRJaAYcpun5RmN1I=;
        b=Y5vm4n38KIpCtwTSS8EZfVqLXqBCvxv9y20dpZt3TOuNd/2botHeEUW/R6Bu0WIWcj
         uD6ZOf7yOQ1ocNxQF2M/ioO5SLSxbXFfl9v8xzVBtSo9N/Vs9wM0fBEBD9IVb7M/20UZ
         5XVe7FEW5TcSLTWCiRAmoDaxQxe8fH+dGhS4D5BalfCS5Fg1WLuljJEPWeAAqd1Cdig5
         5wrepxj1tfj/emu+VPTas+PvjgAiew9nfz1WcRLA81JJDA7uc65PzUcOGUHU+LxHoChq
         CK59VGbpjZtWIut5bqtPebOCn3ImPGD+OmtyZgPE3NhKzjxLhJg4GaXG5dPjBOqGJkQs
         GTow==
X-Forwarded-Encrypted: i=1; AJvYcCVeUzLDAQP12PENHKyIwfCvJhJ9NXuKt3bvLTEUV9GggN2DeKIHVA75/4+En1VkPfBRT87pU6bDeVu7y9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdxE34039gPDTCxqYkb9uZ9F5lTVY/CSLKyZPmim44C6zFu6zi
	DVSn23j6eeLctcCLHMnTUoUhSidRrGM88XB3RpcdfPjbUFLwFIr0dX/7Ah9Q8Nxh4Ex0TrWg7d2
	21tBbrBeyigL539LUXbPJwAdcf7d9ViL1fJXCIlElpNYO6IuDSYaMTYbzmM6RUbSMuM4=
X-Gm-Gg: ASbGnctpJLg/JlleCp6uAr525WHy/SqvIfZN3xf4gWZhMGJUFZfGwuejnmg++iPqv9Q
	lCJmeUJbmYHHDK2iIkFOm5ZinWbqaFrlzyL8j+eVc0PJB7drlAAvyC2+z2uhaOVK9LQfw3bH7oq
	stQRUk+uFhcI2HILz7Tv54OcVtUPiwQbQwjfdfK7KGt+O8AlVG9XniCbnC9vc0z8MDpTXcFY392
	0YNkZO+RVAtGprxpCGP0Zn7AuCXt5XyaFcws0A9SdlRJ7rEFqz7zyBXFbjHMbRt2yBsbjtdh1No
	u5E/vZnjZy9OdMHftvr/oLaloRdGzV3e17liMsGxYfVU0NC6Zq3/GQswXUTKLUXnaNNgKrMh6oU
	gkAkeDSIWyLMbp6tPG+JU2Q==
X-Received: by 2002:a05:620a:1727:b0:84d:f048:d795 with SMTP id af79cd13be357-85ae0dc2b92mr287456085a.5.1758804420227;
        Thu, 25 Sep 2025 05:47:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFb6/eSVSPaLmQN76rHLSNw8JAIbpMfof7DPaUmUXWN6Zyw726mb2YnBoPc4+zEUrPWqel5g==
X-Received: by 2002:a05:620a:1727:b0:84d:f048:d795 with SMTP id af79cd13be357-85ae0dc2b92mr287452085a.5.1758804419583;
        Thu, 25 Sep 2025 05:46:59 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353efa4c35sm160873566b.26.2025.09.25.05.46.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 05:46:59 -0700 (PDT)
Message-ID: <25deb71e-f3dd-4766-b520-07ae72055e99@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 14:46:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] clk: qcom: clk-alpha-pll: Add support for controlling
 Rivian PLL
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com
References: <20250924-knp-clk-v1-0-29b02b818782@oss.qualcomm.com>
 <20250924-knp-clk-v1-9-29b02b818782@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250924-knp-clk-v1-9-29b02b818782@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YPqfyQGx c=1 sm=1 tr=0 ts=68d539c5 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=4MofXZx8MfQD9CL7cgkA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: Efta3T8m8loIP-P7EcbTEYFasGQJLvWa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwMCBTYWx0ZWRfX+B3jFxUGKbri
 uFmXy5+WNTj3YV8JTZnhe80FUDSiWH3zV58usoWlPgmyu6+5YTLpCxcrXr4ozOLKljv2OvMSFAq
 CVXaf6HraLbBmRBJYtDi3hvfaTX5n0Xbp5ZC+hSp368k7BwzFTLmIRcphSPYsrXsdku/KDu7XHI
 g1XTt7LDTTeDTEqKS4Ez9XSYgW8Vma9H9RyWSRs5yXfCOjQetpoJHxhY2og5UIwIC6whY6Xuo1A
 PLEj5Tr/yvkNi0KNYraWz/bWw637vo2O+ULJF+9tRSqbsedtSg3wrbGAQ4YF6Gqo/w8CFdWxlAb
 SKIpioA/eCUCQhGOR4eULrHnry14tZ6NVLUw8io4ZHajXpUoxEmo6+JqgiBJ/kMtNcKpaiue2jk
 PKNUUP/1
X-Proofpoint-GUID: Efta3T8m8loIP-P7EcbTEYFasGQJLvWa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200000

On 9/25/25 12:59 AM, Jingyi Wang wrote:
> From: Taniya Das <taniya.das@oss.qualcomm.com>
> 
> Add clock ops for Rivian ELU and EKO_T PLLs, add the register offsets
> for the Rivian ELU PLL. Since ELU and EKO_T shared the same offsets and
> PLL ops, reuse the Rivian EKO_T enum.
> 
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

