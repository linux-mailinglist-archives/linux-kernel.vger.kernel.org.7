Return-Path: <linux-kernel+bounces-735430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A19EB08F2C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 656AFA614BD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5846C2F7CFE;
	Thu, 17 Jul 2025 14:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aNM8qraK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D4B2F7CF5
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752762380; cv=none; b=nagxsJbxRo/moLszZGZD5/0VN41+wRA+xbWvZeQuHlZ/gwPMTq8Orsi3UpfGhFzTqr16lWXtNm2pNUAOBvsObnjBCHy3U5OQY6HRpvU2OteBzgrm3k1wpR7liQ5jPzl1bpQcsnvFougLDLfZKGPJSi7qGfYqtzbsaldkzOxV08Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752762380; c=relaxed/simple;
	bh=A1VK+VUAYmGD2wv3tLZrYHNa/XhbNhwlQRV0o44VqeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pf7BzwFqD4SgbFM/J/fvikxUO10hgHo+xmPqpZgqnTcCFjQyvx7E1UCFQQaa37rVnRabt55Wu6GOypZotNE1GZA8OoH347mmXyuSBXJMIrsp95qAN4C/V6LtFcNOXNtjqWTvrUuNsdDf2lgK3GurjtnRstAsaPn4qT2dpQWdqak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aNM8qraK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HCZ28M007297
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:26:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UW0SHDq7HM8cFjQol3zMTWFN0cbf4VsE3FOoKzadPAw=; b=aNM8qraKFYw2c3Yx
	BmvuremjN1AniXLdkRm2PrR9i7lT0bjW1el8yTEt49UlpnZEErP/ypNkWsHhc1QS
	RR/gVFkUbGnI4jz42HBV/OXmUQzhpCfCIFy8n7Y0ZFe+zNpCk7MFaXbgWt4ahnal
	Oi09lZ5kVEc7XqGawOMPZjrLX7z9Jzz1qGrb4VhB26nxKXptHPCSCGJ7ojW/myeY
	0JY8QRTKIge8z2jlzKxyeUTJ6zh2bzarrIGkwNBsNn4esGdje/ojfO92/pTT2zyH
	zMpLauHgKfBLoP5pAWQ5GC+e1uZsS4CG9YEIAv/KxhEqc/BNvFnnikdgQ7QiIUeD
	a3ko2g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wfca95sb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:26:17 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ab5e4f4600so1861221cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 07:26:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752762377; x=1753367177;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UW0SHDq7HM8cFjQol3zMTWFN0cbf4VsE3FOoKzadPAw=;
        b=R2y7h5todlseVivux4HU8+jUEpYMDbXcSNDDdiCD8QV4fX6qk9mLghUL536ENxnqnz
         vUyftGnYM8yEuTHHh78fWgNoCb9EOsg4B2W/zdLLi++zYk5f+5Be6P65BGask+DpyhjY
         3L80gk1+X5NwdYIvmSPKPF5zCq6ofYgVnBh/x15Kt9L2KIE6YG+bu6lqehIBnWVnGX45
         FJvsLfkEc4/GSr5mSo4IiCbF1WYyO9Kr7LV5955171uBbFZIoUhvF90EkUeLlVB8EIGt
         uE354LuCcYs4l231X8PDOQB/DFlwib2sf+6SxSdTQVTOOBVXOfIX3PApgp3dYQEJBJOY
         BICg==
X-Forwarded-Encrypted: i=1; AJvYcCX9g10yGIls8vkAzDi/WxgwdaB0Sqx+24Oyls4I/uIHXk3gzpP32SZdMUfZCfKQQd077XRczRsVku4LmEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPnynUMNUVfiNNVjOmwNQR5DCXHXOp267VzFEzyiqrSSOKU4yO
	uIMdBzFrSy2gNEXa07fRBNOTdgUjQ0SWLhB+ZSWfDwZprn1GKit/IKHQ0rszw9ZLYwo4IfJ3GoF
	Qq+74t+2bPh7/Oh3PPvMbh+i++7XmFRfH0VU2D05kAWxtAi5+Ci6cNZCzCfauuuwEW7c=
X-Gm-Gg: ASbGncv1wEBJy/pTzmprtI4Mn4vpTtgzSiiiY+NjtKfjBYWyWWQh/p9mbc6esZHPPJt
	behKzRB9BDBjzJm5Yl8wLYJqS4NwDK31pzx/tFQCQN8aVtD+gUOYMcTlxQaRy0UukbvpLB3WAJZ
	Kfrrm84UXdYNWvdI5qBpk9U0m9Tz4taReok69EoPofbzeN04npmmgoOQERD7uXqMAhCdN45FOUL
	Z9ft7gOaaGNL9tJp5097T/DtNcFNBDdUGWDc0EcisL0YSDuSpLEqaKsmc8SDkErckXAy8dChDO6
	r8jq9mi1pMyST0NHGZeRgCvPpnrDpIqC7541f4pz28rnp78PByw7byZzzThhpMTfKBWj258mEEy
	HS3ySN9NL4chSQ2VYdAMz
X-Received: by 2002:a05:622a:1211:b0:4ab:5d26:db88 with SMTP id d75a77b69052e-4ab909ca3c2mr52125021cf.3.1752762376869;
        Thu, 17 Jul 2025 07:26:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMVUYbi7+xe6s9Goz1ayVoWHDR7708LV9kZl8tV1UuT+wHPjRTXIxBGxsH2MvlnarsySchIQ==
X-Received: by 2002:a05:622a:1211:b0:4ab:5d26:db88 with SMTP id d75a77b69052e-4ab909ca3c2mr52124771cf.3.1752762376427;
        Thu, 17 Jul 2025 07:26:16 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e90c70sm1397031266b.13.2025.07.17.07.26.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 07:26:15 -0700 (PDT)
Message-ID: <c9d85f35-fb39-4b9b-84b1-c14827f55f51@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 16:26:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sm8550: stop using SoC-specific
 genpd indices
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Ling Xu <quic_lxu5@quicinc.com>, Dmitry Baryshkov <lumag@kernel.org>,
        Tengfei Fan <quic_tengfan@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250717-fix-rpmhpd-abi-v1-0-4c82e25e3280@oss.qualcomm.com>
 <20250717-fix-rpmhpd-abi-v1-4-4c82e25e3280@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250717-fix-rpmhpd-abi-v1-4-4c82e25e3280@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDEyNyBTYWx0ZWRfX6ZCaQbxDNwDv
 hcGhEZFSw6YnmDD647UIcjVPjvqweSwlvv8EOKEmHBK57jtzJ14SgPAB8FPEtYKCCrntpcW8u/f
 edu1E0eFC3MzLKE3oCx0giMSVhfSfo9ZsVjxxOxyq9RF6RpLunkSqUf6RWMjxnlwwle0+XofJuF
 1jCIYrZdR/dI9yoXPMMaYOnTarV7uFBOLBJkOMEgD3w2DidYY5CxXPJCQ04WB9qFa7d/ZIatI/b
 QgC0iJhtwfXwRn8M85M24YJvUl60m9MqfbaLJtj/WWEQvzneSgSpb5w58MFO8O5IgKYXZSXCiD8
 F3Xl7NV+/6CEc9C5BBS2w0ywKQS5qyfuTPY9ehPAgJ7uCX0UuvgQYcrFZK6NVWvlL3mQ8iyT1x2
 RWNRiNDpEmyvcYoTGJ3c6VyCIEWOxeTMkl8Zz15k9vzQX7QGgs0wR/q2KkGuOcYRA2enmzlm
X-Proofpoint-GUID: Ol1f6V_sBZZW9DYO0hFutgf0fzka7xi-
X-Authority-Analysis: v=2.4 cv=SeX3duRu c=1 sm=1 tr=0 ts=68790809 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=GvB40MCZoslDJ7jKBQgA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: Ol1f6V_sBZZW9DYO0hFutgf0fzka7xi-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=756 impostorscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170127

On 7/17/25 2:48 PM, Dmitry Baryshkov wrote:
> The SM8550 has switched to RPMHPD_* indices for RPMh power domains,
> however commit e271b59e39a6 ("arm64: dts: qcom: sm8550: Add camera clock
> controller") brought some more old-style indices. Convert all of them to
> use common RPMh PD indices.
> 
> Fixes: e271b59e39a6 ("arm64: dts: qcom: sm8550: Add camera clock controller")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

