Return-Path: <linux-kernel+bounces-832113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DB7B9E5E5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C6324C66DC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8562EC096;
	Thu, 25 Sep 2025 09:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JbgDKJX0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199AE21E087
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792630; cv=none; b=KmXYZsvwAKRCGYZwT8z7Yr0HsWwTBWzgxhRkNiyYqFqeVCk5TFPCraqa5e8xsyHbJEMILubGgKE0BMKTalSslDCUmM4P5VG+QCAJihattujvzg23UtHeFw+jglDnhaTewxVMYADem5wcwyH7BQtG8gZZSZ4q4UwspGRvunkfnSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792630; c=relaxed/simple;
	bh=8N6KmcZ3o0RKZfH/SDgkpHo3kvKOR9AZGJho3gtBrkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fxSGxPNU8vTm7RuSY/4uIaZoi7vVfgJxo3DAw1ViR4ninhMdrTBMHOhcXEkOM3FOU56Jt/VDR7nW49t+qmz25FPw2Uv+qGAQmqoqdZrX5sY0390qp+4nrjo32aBoHK2Mlh6PDFE6R72XpT/1Aqr0R2zQrfaOCp7/gCcgsqP+cnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JbgDKJX0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P1fA7U017420
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:30:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Iv8LC4BuQ4SAYhRCgkZysNJWxVrScti2b4sGHDBPz6U=; b=JbgDKJX0icycF9G5
	MdA83dtx0SE75ma8JY1SQ4hqHwzXjIS9ub6BM9mpP16w98poJhKFiz44Txh5YwFe
	dq18c8I9NZalxoDFiZ2Mpw5e5YdsK4sqrE6bx/h/UTskQ3vINlOwGgl+EUSjDQv/
	3TU+OKt2nYqhnGFzi5Y+EZjNaG/pp4CCp3obyjHf2KQpDsKNEWTlvPuFren4b9GW
	lCxpl2FX4iT3A8q9zLfS1QIjxcbMt9/Yn7IjncuI78ZyWKlelag0dhzpyd8MOn0u
	+ODT4VSpNfp/LfOtlzTIEPheAUK4pYH+lRItGI6CITlQSgI4DtFLwzZ9mS+Td5za
	B8Vssg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bhvk0wp9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:30:28 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70dca587837so1567566d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758792627; x=1759397427;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iv8LC4BuQ4SAYhRCgkZysNJWxVrScti2b4sGHDBPz6U=;
        b=JO/JfOy9j1cbnV1PptRmuHRuNMRwFk3nPQ4tm1FO7GhErmh4x+ifCQ2LRamO5KyYAC
         LMowQvlL1aDgGLPCaTv3XiGsZnUo0uf2Qdma7wMnEzMb+wiyyyszr57AGPauwd7IPwgP
         2oSk4vS9ImDRDeHB8p2R0W6CN+ID7HEdCpGBL8bZz+HhaI5SkYhlYYEeFGEB+UVufXJJ
         zJT3lWUjXgpOtz6MkL9UEDZBzxqSjLWAiux8AF8kjE1jwT1N1i2F/t+f3OjL+Lr6U/Cx
         lJGNfb+3FSU1z0zxx5ANbd1efuLetXidk2fmt6+XxgjXa9GizzzeTGHC0Ec0MPdtsx6M
         HBvw==
X-Forwarded-Encrypted: i=1; AJvYcCWXNBFbVoRqQEQpZojHjlQJ3MPhcfpV96gGlE9eOiJlgnSXFDyhQLdYynMYNdry/HW36J+vcYhxJW4MnNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWP8Yf6sv83wqkHtzN7h3rmfyLpSzbr5Drsgdf2fiI+iAhnHBi
	x51P5fz2/POvxGiSVq4kj0+bqzuWuNiPHgn6lD5fxJ6mieSkYGApONvoRTMVTHcjEvEkIEE3el1
	SQyDvmiOLlnov1K79jKQ/KooBnsGassGoFmQVVei9w37gWI9G+xB8y9wtQod97827dN8=
X-Gm-Gg: ASbGnctQjVp6A6cWyCHizMkF2tmqAQymzBIRj0fZywaDlC8pH/NvogP6+ABgarvQ6ef
	+KlUkHYkLDJo2A3Q+Bi/eKyhyloWuOLPbjxUjWYgO1VMIOoZBixURg/SH3XSTWy+iw0PzJ1ADTR
	aJSDkL8g5kFsKnscuWPbULdgqslqkJBVCZaclm9mYXz0gBIYNf2ymnkDiEyEOkLBdRuJXWp2n9G
	gGK/8lTJp2rMFRfQuaJKDItmwXvMGpZOi2epbWeDBpE7GVZ/JC4Rh2r3MJJZlqdfLrcCTFwFJoL
	myzjVL3M6AsPVMHKYGrCSV5d230Y+ERzzx2EiIcYXcwZX+yokGVUQB7d7QIOF0g4spc8kSCwucS
	zIWFFnYs73RWX8AOp8VO3Yg==
X-Received: by 2002:a05:622a:1905:b0:4d9:5ce:3744 with SMTP id d75a77b69052e-4da4b048343mr25294051cf.9.1758792626954;
        Thu, 25 Sep 2025 02:30:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF84Vn/lXM+1k1uOOSGaZwHXSDbKHURPqKNM2+JUtWDEXTRhKuuefGRswtdVWYy9+dsAxkAmQ==
X-Received: by 2002:a05:622a:1905:b0:4d9:5ce:3744 with SMTP id d75a77b69052e-4da4b048343mr25293891cf.9.1758792626509;
        Thu, 25 Sep 2025 02:30:26 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3ae3080sm934726a12.34.2025.09.25.02.30.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 02:30:26 -0700 (PDT)
Message-ID: <239bc397-c746-4ec8-969a-9e3f3c3dee3b@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 11:30:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] clk: qcom: clk-alpha-pll: Update the PLL support for
 cal_l
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
 <20250924-knp-clk-v1-7-29b02b818782@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250924-knp-clk-v1-7-29b02b818782@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: g1444uR10D26OTeS3aKPdUH4JY-GCKSk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAxMSBTYWx0ZWRfX0pgcyjT95LV6
 92e5GO795OaHAvwKo0T0EQLyHvC8z86+vqO1ORDAQcVGQk+K+13Kzpw/QIUyFE0xG25zWa6XE2r
 zegJxBqHceeFhq1lu+j3TBYZM81xGC/U4YGPSs18LDwQdQbMnQ05aQF8ReC+/eZRLEVMz+0xEGX
 pG+9MX9WmFP3d0EX/A6tgXzy9zgzlqAtmcCJLE9AY+UkcqFOuzj6bRpEX/9iDcQFOV0qiNqSYvm
 fQZNSO1L2b32yN4uMx5MGH0QADhwh53Q6FxqNqBIW6qWM6nQLEogbZW5upkI+7n3ZsYW/ZmFyPT
 ZQj8X1b5UpxfC8Yw6BgLDbaaXUD4/4ARSFKZ4qu0Pgt92ICe7MO0xWRBSgl4UCiUG6j0NA3yO3B
 ZmV0csqs
X-Proofpoint-GUID: g1444uR10D26OTeS3aKPdUH4JY-GCKSk
X-Authority-Analysis: v=2.4 cv=Csq/cm4D c=1 sm=1 tr=0 ts=68d50bb4 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=QDpnt0wtCZc4EWvjjt8A:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230011

On 9/25/25 12:58 AM, Jingyi Wang wrote:
> From: Taniya Das <taniya.das@oss.qualcomm.com>
> 
> Recent QCOM PLLs require the CAL_L field to be programmed according to
> specific hardware recommendations, rather than using the legacy default
> value of 0x44. Hardcoding this value can lead to suboptimal or incorrect
> behavior on newer platforms.
> 
> To address this, introduce a `cal_l` field in the PLL configuration
> structure, allowing CAL_L to be set explicitly based on platform
> requirements. This improves flexibility and ensures correct PLL
> initialization across different hardware variants.
> 
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

