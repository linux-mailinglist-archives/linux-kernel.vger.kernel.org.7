Return-Path: <linux-kernel+bounces-762359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2906B20574
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 192FB169969
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFFE245019;
	Mon, 11 Aug 2025 10:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mG5tjr99"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8B423A9BD
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754908384; cv=none; b=s7Ia0TY3oN4LpMidaXy1qAFFtJ6pkWAfi9GPltgNP2tsooanCQd6ME3fcIbkP9yKeNwmtuoQQ/CCm6Ouogck2AbtaLJ06Ug+m2/jmjOfPO4H3n1vz3zl8RhG6YzS1Co65IzjGebs8lZJWO1rLIMGc8NNbX9J/qYG9WjBgizxkWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754908384; c=relaxed/simple;
	bh=aLfJkOIeEAJCZhqqFdhGsi7u4fwjQHYOZWwmnW4Phc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RQwG3ZPw7wfuQEIKiaraF/V8nyCJt4c/hdT42aiYHhDybb6uNvQdWaIy44AUrdGvzPS1AzTNIaRV1u0tIKcfw0qiGLkDfZ7JGILGwgnP2gsVrsoAJPwyE90umC0+8GvAdIUCmB0F7qHcjqAXhI8ip7eXVOQzFIaN3dCNzeob50I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mG5tjr99; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9dBcn007623
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:33:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MjMB/32U3IxFc2us9Kf8imiZjXbuMlwszLS0hiGM4m8=; b=mG5tjr99fG3HM/K+
	gsVYrKBFytzpoSkdOeGguGQlrImiIhoMQf8baomBjICJwRTkMzWsnrYB1CJd07hZ
	pxytLO3mYmtgZ5dRBni5OnBnw5wTdR9Ula19M0ukg7r6dYBzdJIyIfuhOiABPrI9
	FsbtTkPZHGr+N/VMZHYD32CBlOIub6nQDBFxCrOXLaUbDWqn563tUMhWUepmVSlq
	ZQbkqjbeTqCKhMGHjT0qyjT8FYA9rzffpL0WeNTB3WQvFJvrLDZEwXo7pjEZNgBW
	yKxZ15jdKRUrd2uhK+RoY5+5GhruKDnFdvue2NNnveLXnLtEwTWNmjkMour0Km1F
	auZOVQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dv1fm7gm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:33:01 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b07b805068so9103261cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754908380; x=1755513180;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MjMB/32U3IxFc2us9Kf8imiZjXbuMlwszLS0hiGM4m8=;
        b=ZdsF9xNP6xGMCTGEVsWmQMEDkE4RD/fUA9jojs7GeGDJrD/PJTwJlLNIH4S7amPBhb
         Ed4Lctkx9tSbSUe7ho5Ev3lT7tFG7FeA22MBsr7AbeuMSdsoHoPgOFtxGPxt/BuCzB5H
         ADqsNuKPIOSJwM8kJZseiqjtHUMPPXk5czdsolESRX1SsPt2H/JQnUR3oT1v5lt4rbIa
         JwSMEh6gsgP+QI8weUSvauYW4IJhcX7HlIFPgmNJdv1okNMcHabCcyoy++GPDhWlgr/N
         PTO6K/Q7g4ULqBYvUTnBAgT90OONGbNwBRwAk5wXAEoj3sPAbiYyY8ovDaseO462EDn+
         3P/w==
X-Forwarded-Encrypted: i=1; AJvYcCWXjG6m5JOcHuyDo1wW3G+V3th2DFuQkVMgh9qRLtS9gJHkgFSNEEqgde4kbJWLCYszx71e2QqTCZC3abM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf5SJqpDOCOMkZ+/kAfiWFq4vxX7oRlvuC892W8Az0l93oqy23
	piD2lkrdPq9poAs3yvImrWcypMrtblmr145HQ33JaX2HwyfDLN+AHqUYUm2tRltwqcy7ZofSOfJ
	I3MeQpdEGzWMhWwmpLaJhtVZwtb/cLbYKkLyOcwPNrKGGmBn/HYNOPFmDoNTbIARR5ZM=
X-Gm-Gg: ASbGnctfLYCVq3HcS//deTaHd3uqArhvKgblRMhNlM8qFJ2VmOVyW3pZCObQ7LYTtLQ
	jjokGvSTokpsjwgSI5OXsypDQggc1KJgEwG7NkO2AUKjbuQgF9ygNBFYmwJNVk+2xT6v1hCS+ll
	wAPbXh/IdFOrtC6pMjUKy0/BujCGcsQItddDE1j5JIqvNPY2Z0XI8Tw4L/F+WKEJvuntPGGWXQ6
	u3A9VhzBB6HAZBdLyF0CnilFAIqVnwMErhUBWvlLQPOxRRVdX4bu1NFa5QXYgvMMi7xaR3qkg2l
	OEWbhrhiVS9Uc1qZ+erMRR+yOei0gr+XBlqFXhBcXA5+w3LGvGrpu8yeYTbaYhbtO4iodJPnqQN
	tlNBYSyrYEaZT2BIPHA==
X-Received: by 2002:a05:622a:1ba1:b0:4ae:dc5b:5fee with SMTP id d75a77b69052e-4b0beb027a8mr54331121cf.0.1754908380511;
        Mon, 11 Aug 2025 03:33:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHZ3U7a4gt2KHpyBD0mE2prizsWoPQrACXSYquI2KmbQ+tAz00IMulPe82iKcOcMiQR8P9Jg==
X-Received: by 2002:a05:622a:1ba1:b0:4ae:dc5b:5fee with SMTP id d75a77b69052e-4b0beb027a8mr54330881cf.0.1754908379877;
        Mon, 11 Aug 2025 03:32:59 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3361sm1997594266b.39.2025.08.11.03.32.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 03:32:59 -0700 (PDT)
Message-ID: <e410c5f5-227c-4852-9223-a935584fbb75@oss.qualcomm.com>
Date: Mon, 11 Aug 2025 12:32:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/4] clk: qcom: apss-ipq5424: Add ipq5424 apss clock
 controller
To: Varadarajan Narayanan <quic_varada@quicinc.com>, andersson@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, konradybcio@kernel.org,
        rafael@kernel.org, viresh.kumar@linaro.org, ilia.lin@kernel.org,
        djakov@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Md Sadre Alam <quic_mdalam@quicinc.com>
References: <20250811090954.2854440-1-quic_varada@quicinc.com>
 <20250811090954.2854440-3-quic_varada@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250811090954.2854440-3-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 2UW-ZU_E6o75ymCV19VQ5kwrYzCvWeWD
X-Authority-Analysis: v=2.4 cv=cLTgskeN c=1 sm=1 tr=0 ts=6899c6dd cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=ZSjPvR6QFvROfIIkwVUA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAwMyBTYWx0ZWRfX8uEDEU4H35wi
 S26hNkt/uDq2E82TIagA/QDRY2jCGVZiQFGye0aUH8UVJO7+rk8JswlNtPN8tEMCk6MaC+i1LOi
 iCYQY4WkThHvwF3kr/nxhI9z0mU0Ujx9JIinXKgpyfOtfjkSbBgT1LzgTdjCYDGvBls1nnzrHYI
 zLyrDuh0LfSz5t8wsx+TYHHsQQp3Xp0gF/Fdd3uu6VkbPcM6MdKHtKaIuA2DoXMNeyyal6ksR+5
 Hwe3t5vuiDZOuc1Vnb+YCVLYic6Cp+HPnBQEfSIVTIO5A7w0aoGzmxeeQUnfo3PEv2PTsbKZz6K
 6Q6Hthd1tPcRSCZ5IJXXQ8uIq3OmH0qTktOza3P7B0VRASJQbFW+qHMlKVqqULx3bJZWfeR/t0S
 uz6pf+RH
X-Proofpoint-ORIG-GUID: 2UW-ZU_E6o75ymCV19VQ5kwrYzCvWeWD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090003

On 8/11/25 11:09 AM, Varadarajan Narayanan wrote:
> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> 
> CPU on Qualcomm ipq5424 is clocked by huayra PLL with RCG support.
> Add support for the APSS PLL, RCG and clock enable for ipq5424.
> The PLL, RCG register space are clubbed. Hence adding new APSS driver
> for both PLL and RCG/CBC control. Also the L3 cache has a separate pll
> and needs to be scaled along with the CPU and is modeled as an ICC clock.
> 
> Co-developed-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> [ Removed clock notifier, moved L3 pll to icc-clk, used existing
> alpha pll structure ]
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

