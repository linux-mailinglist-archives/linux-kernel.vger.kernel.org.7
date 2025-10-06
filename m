Return-Path: <linux-kernel+bounces-843092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1CEBBE640
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 16:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EF011899A18
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 14:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863041C6B4;
	Mon,  6 Oct 2025 14:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h1Ky1CZZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0112D481F
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 14:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759762002; cv=none; b=J03d/gyxGSz3Bc3WGhqsBpc3TubuN5BowfEItxb4C3CVqSoUnX+SP3BzW1jsNYr2GvZ50CnujgV3JkDMcuJ4jhZQ+bGyOqgYNfxZN9GEr+GauZu1RrrTGC/aGRj70UWZXqc+0IgFEMmKUD6CB9RuSb3g4Jcc+NXKPLd4OKJ+qyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759762002; c=relaxed/simple;
	bh=0SjfYUn+LCJtD0uklCJCg4enUtxBtyoQ8WI40LJdw0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YxkvoYi0hSE8/hn2xSokVN14st6awHLwH/SPVkDuOjRMiBa+HwNEcHi6mWqA0zWQbWVrpoYy93BNS5IWHmS32PjGW/zSW7yL5XVZBuc1dHrJKSjT9fXSb6d9goCfK++DGsWiqxCD5PMPtqTq7MDf9sgkmyKpX9rXc/Xy+UZ6XK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h1Ky1CZZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5961EICV028800
	for <linux-kernel@vger.kernel.org>; Mon, 6 Oct 2025 14:46:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6k8/Nl9l0oEKhW7IAR62snQP4zksIlUAzpUwmdh3B9c=; b=h1Ky1CZZGQ8Jocws
	SjigahduATYPCpJIoCBvDjaQmdcLVgTgm6/Ui9U2rMHSnK0lPHeVUyevBA7a0zcz
	I25Lf5WTGac3yWJMQXqjqjSO83/OS7osr6ug1Jtv2wH1rYD2ugmM+F42feaz3ydc
	i0bQP6fkJtE6s3c+rsfu0dGAPMuBPBYOzr6pSi9J7uiY9dTizhjT3Ugc4CTP9Lgk
	wy7WDlY+L4BJWz0j+YC9TA55VuY/NgJJNXyqSxJueVGWsrtRmVriSCXcDycNJj+r
	w+ECqNRTd6BpsJO+5duhzKVpwQNrBP7S5pF9koopr0JhtT2VasgtsXqT8wJXSsQB
	jcg81w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49ju5xc54h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 14:46:40 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e4b4e6f75fso14944361cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 07:46:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759761999; x=1760366799;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6k8/Nl9l0oEKhW7IAR62snQP4zksIlUAzpUwmdh3B9c=;
        b=Tvly7VriwGcXBPFeg1AH2ZPuVJcH9Tq6G5x0yP3LGNH6+nbv5M5yhNWklyuIbSkZDF
         NeLXEewuk7Rm+2q4uG3g16ekRJ5AXW7vHGgBvvIo2n7Vj809r0/gUeJf+c3RpdOhzAPR
         hKMrBeOwQd63saPXY5XZAm9pLkAKjWv+5hWwwTVsGohkkIHRajPD/IwlRvR0c+pYBCrq
         IFqlhnfWsUVhAUWa6YGXikRr8fwVfn8ZA9nNGOrR5V6zN9aWFwmUa8VfN6GZA2HSIXpP
         JvD/9fdGPM2KA7znCBJ3Tbg6TfQoulSpE6IB/PL7c57dgE8xvxyq9LYUYgZ4k3LY9k6P
         K7Ow==
X-Forwarded-Encrypted: i=1; AJvYcCXaaZoNThIfauO5h4H5gKbWL44AZJHJuFNZ0e2JN+bEB8UAMS6GKbqoFAP9PGO2H06v8GSzsOfYebiN6Ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqgdA8Ykp1UOgXo46QDEyoKC/sxwjqTPitlvj2b0HQo1K6VbLI
	+g8Va0sxN3kR8emenyaTOBX6uRbiR1xgqQAVMHJdX+Sfk5Z1PDHorITslGtKoCnnuDKHSWmU8iO
	ykAnCZjUOQL0x0i8fLoi9vSXuvIUqPPaD1w22eCxegBQaHjFUPEMbPa6Yy9m2K/FstcI=
X-Gm-Gg: ASbGncsNsf6goXSXrPx9AiTYR6o1RgRmvzgTgEOPWuXNGlyfaILkVcvJTImtnqrsgTm
	rtXc6pkCecBpOr0SOv2HLNqLDSzx/rzGyktmR1n9Zl5/UnDHBieNbnY/4938tx7bqiLnRuILpUo
	KGcMVFuYK9xwl5OIz+Y2uHGP8npJgMEc/fu+W91HBepM3vwisYwB77Ng464w8b00dSN7dHVbahA
	wkN0QNxkI7ja690AyCz9BgQmD3kAmiZ3SmyzwiyeUSZeFx9KMGL47phdHbIZHuDuimYKS50wmxc
	kLON2skVLIwqkkHRKtfj4qOlKD0OiXnT12bj0XlDGF9kz67gxKfve5rQ/eJ+WIqlQqDxS7LGiGg
	fSpx+5/8RHRz9TPKN+cQ9+STAeJ4=
X-Received: by 2002:ac8:5fce:0:b0:4b5:e606:dc13 with SMTP id d75a77b69052e-4e576ae6a6bmr104989771cf.10.1759761999065;
        Mon, 06 Oct 2025 07:46:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGV4qtXsuroQqkzlZTq/F/Z7vHu5HpR6meIRrGUsREceJXJahZyUefmBMArcJ8DeNfcQay4eA==
X-Received: by 2002:ac8:5fce:0:b0:4b5:e606:dc13 with SMTP id d75a77b69052e-4e576ae6a6bmr104989291cf.10.1759761998335;
        Mon, 06 Oct 2025 07:46:38 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970a4bdsm1164471066b.49.2025.10.06.07.46.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 07:46:37 -0700 (PDT)
Message-ID: <d1a5fe84-69bd-4e94-a92e-640f35c8d013@oss.qualcomm.com>
Date: Mon, 6 Oct 2025 16:46:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: msm8916-longcheer-l8910: Add
 touchscreen
To: Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>
References: <20250919-msm8916-l8910-touchscreen-v1-1-c46e56ec0a3b@gerhold.net>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250919-msm8916-l8910-touchscreen-v1-1-c46e56ec0a3b@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=FooIPmrq c=1 sm=1 tr=0 ts=68e3d650 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=pGLkceISAAAA:8 a=j8Cu_9a8AAAA:8
 a=EUspDBNiAAAA:8 a=JOwjkeT_cYTZ497o5dcA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=A2jcf3dkIZPIRbEE90CI:22
X-Proofpoint-ORIG-GUID: 0JLBGsdn9UXY_shxFgfISLUuQGCCgEXI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyMiBTYWx0ZWRfX/SyJgZez1TzZ
 ineSYbo7dvBTaLi8gZr5MTbQcpUsjI8rxydF+BCGAbI0agPcQdgvpMOhEPJsz1r0JnikSy6xiB8
 d64e0mhgdGc7PrQfdxWIHWZi6mlMnlXzEgsz2RtbtNgq4MfN6uiuFMr1mC81CfNMvL0qS0DkqGB
 f9YrMvI1ltHlqQ/UeWcAsXZ0bcYMJRR0Cz7G7xXHyhw6nO43LQTCTZcT18VkcrSFLfd9uR/ycdM
 E1bmvJmRIWhB84hOWHk8j9WJWLHSmvZX8JmJrCov8MV7XVtoC+b5ykXGAv418SdF//C9ZFaHshi
 1wz4RBSgmMQOcvB5rn3pNJ5AstR5Uq+hZhzp6tZP60NYA75srdwiluJSYWRZ7/U85DNCbGInKIE
 +Khel8JPdnzact4POdqy6m4jAj5zDA==
X-Proofpoint-GUID: 0JLBGsdn9UXY_shxFgfISLUuQGCCgEXI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_04,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040022

On 9/19/25 4:49 PM, Stephan Gerhold wrote:
> From: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> 
> The BQ Aquaris X5 (Longcheer L8910) has a Himax HX852x-ES touchscreen,
> which can now be described with the bindings recently added to linux-next.
> Add it to the device tree to allow using the touchscreen.
> 
> Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> Co-developed-by: Stephan Gerhold <stephan@gerhold.net>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

