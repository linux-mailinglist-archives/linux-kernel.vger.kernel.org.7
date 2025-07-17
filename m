Return-Path: <linux-kernel+bounces-735428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FEBB08F25
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DE19A6183C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB642F7D04;
	Thu, 17 Jul 2025 14:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oa4q5Wy+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24D52F6FB3
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752762361; cv=none; b=jQ3ZMW9vL8d++KbnpBIKLlNfJmQ+CoNwf/rfoI+fCvrm0/qQyCG9qCu7DG71tv8Mvc/SHPZ3GMDIXOsN7mBH1EQnbJK4yJ2MY607JuA6NxtVex8vACNU1c89n1QShkIcRME2jaUVMz+VdU75rwmweQtAD8W87ExJYDflvmshAFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752762361; c=relaxed/simple;
	bh=rxGb3b6rCytVM4Jnnuf3rJk6tteWeN3eGG1kBvQvorY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b32ITmBCGj26Mpbchw/cfTs6McvaYh2loWGESy4a4f/qSMP1zifadvU9ufhfV1PSklfbwhrI4amMHOWKRs1H845QaYB7sSlRwFRJDQ0t3LUZqXUWQ/WZYV3zLCkwdnhg5CXUBh/xs9qvYg7B/La8HGu/Kzdf6GywEkID267l5tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oa4q5Wy+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HBOGLQ030415
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:25:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1Tbo3hxwNdSzKN2ImQHTT4RdnkySw0TT6Zap49m8D/s=; b=oa4q5Wy+T8sLAGIf
	FgF5dPkHpCTu7jQjBrxEwjNvCiTI38WvdqHlfP1NY/WmOpb5W0eZvN1UrbDr2swb
	HufGsGHUPJs4Be0mnCF/F6VAh9iLgkJzpX/LIhBZQnHfoVh6JRY2c6YvSuZ1ncj+
	bbe+ocvufrvQQGdVmTqn3U63sr+ZZm1yTs5h8BNekTP4KfspFNEpuB9v4yH2LreC
	v4e87fBGq/cB689ydf2wVM1PdXaFLlMnfyTQjmDS4seZFrfCbiyBtzTrnzE+8Kyn
	rCheOdqOx1BJNeqUJz191rXnhwBv0vudkyAQirEbq+aUDhyZ4zve9wM+g4KAchjv
	t1723A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47x8x7mtte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:25:58 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ab716c33cdso4410301cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 07:25:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752762357; x=1753367157;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Tbo3hxwNdSzKN2ImQHTT4RdnkySw0TT6Zap49m8D/s=;
        b=C5WqtVa1YFa0Ugx95BsCVfKvWBtt0HXn5gCO9Xr5nuE459LWYM9ayf/eKrP5AIFffM
         OP0tlXDUuvDMqy9i390nkj29X+EjJ1blrruhLLmh11CqS7VprroHek08R3U96KTRaxzy
         OAq0JL1mYTNklD3kgNf3kPhz4IA1KEen4Aaec+jBmeDsRnB6Oj5sZCLl7rAx8R3xQHbY
         1EQL+QorVk0xeKDoM5rWOyZASbzDZNWpPL2rdHDxk+z4KLnxPfMLSIHIb/jTzIe+u4BH
         q8lQlpPziVI4rLaTXY5UHtis8dAEcxGiYsezKIJv7+2xeOPilOW3GY6KGhIbbw1CjrNE
         TvIA==
X-Forwarded-Encrypted: i=1; AJvYcCVHs8qfLI+fZEQNFzCINMDjsokK0+TtXCqMp9fOmCnMQnPfR27bOsWYIq9VZRzjo8hIm6e7bSeab8512TE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzoIywqQarHOEykR+bkaPcmIGNNxMM14V6/tG8TpdGC893ZlM0
	vSSTI8rMokzZ9fQCD+QSHAKGITAHiUzlOjRZlgTRacHf/NZl3VhB297VPXGHVjcwLCMAWqfUkDQ
	BefRpEZYpmOOhO8XaAPaxjJAZOEAXl3e6Mdnw8v64fvT0+dVdUi4rv2HwSYkL5IPufz8Fg/1E/u
	Q=
X-Gm-Gg: ASbGncsAFIe/tzV+v3f1xQcxalVTgqNwpAbrgnnpcr+FXy49+xIUvU4eq5zxu6gmpkh
	bmeNjtgG6UDRForsteOeQHo49GHiRFAoM5ZbojPv1D9qH0L6C+JTadrdokEqECrzQ0ELhGess9W
	e1H9XCXHKcea281tFmsxyo5cjBAT/k4GwFrnOhiIVFsr0HCc0GmNwIbSvujfnITzCa3C5iODed7
	6Ssy9WGXhItw02xskRqfalU1eH0AQK4q1yKWnKuoaD/S8Ywyq/jly3urVeKkgKAmpKTchetwFhK
	J15SOlo9f2N39u4GcfxyvtbSlNX2kAO8cvLGIHU4rqZufEXYFDeU6Xe9T1uqrVegwC2ggXtTfBb
	UmqrshXtpkEIi0E+kEsoO
X-Received: by 2002:a05:622a:1b1f:b0:4ab:609f:d7d2 with SMTP id d75a77b69052e-4ab90c8cf06mr44175501cf.12.1752762357205;
        Thu, 17 Jul 2025 07:25:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNh5ls9nEoL9tUKQMnzpM+c6tj7YbKF0V/yi9uBQ+BeXiIHOFS1dk2lquey36qCD3DemVptQ==
X-Received: by 2002:a05:622a:1b1f:b0:4ab:609f:d7d2 with SMTP id d75a77b69052e-4ab90c8cf06mr44175121cf.12.1752762356562;
        Thu, 17 Jul 2025 07:25:56 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7ee4607sm1390774066b.57.2025.07.17.07.25.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 07:25:56 -0700 (PDT)
Message-ID: <ad40af48-7c43-4341-a4c3-73ddac129c05@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 16:25:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: qcom: sm8250: stop using SoC-specific
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
 <20250717-fix-rpmhpd-abi-v1-3-4c82e25e3280@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250717-fix-rpmhpd-abi-v1-3-4c82e25e3280@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDEyNyBTYWx0ZWRfX4i8W9+Ztlxo9
 aSRcSmMfpvavt+yKDaM6VtLYlVubIBCeUgUMyp9cOijiCpz7oiVdB2hGqC7qRy1REJ3C0qSGuFB
 s+ug5uxb0iBfQ3SQwMIsgZkbAVhxeEkuMsDkIyYMje4ZCwRpIvpmvmF5sAK4683OAG7hzoUDsUM
 J+SbPltPlZwePNuarddFCYC6hD3cs/4lMwo81dkExd0Ccl6DgXxHslxbBtQmPdPWhkNRiFYig5p
 k24TQVnipAVYBELTMGii6FWdMaZCXcbvjPOxEuKkNNeO50KGJmI74YeK1TJfPUUF0rRsDcEe0TT
 1H6KBmoBWLh+HBmdVtbgZdjh1ELGE0r6aIvhNZXeJhbLElEGiRh78d8GpHyf5Iz23oW3eUndMbK
 s5S5RcJ2q06E8XM3iCz57UE8Rc+JSyLAZHo/thxhgpwMOSjpu9eLFtkbGq9sNMk0nyBiOlBL
X-Proofpoint-GUID: QzgDbPG8sRJqGrLNBUsWVCMDUipkhAfF
X-Proofpoint-ORIG-GUID: QzgDbPG8sRJqGrLNBUsWVCMDUipkhAfF
X-Authority-Analysis: v=2.4 cv=N9YpF39B c=1 sm=1 tr=0 ts=687907f6 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=Cj4UM151Hv94rJL_BKEA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=822 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 suspectscore=0 impostorscore=0
 phishscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170127

On 7/17/25 2:48 PM, Dmitry Baryshkov wrote:
> The SM8250 has switched to RPMHPD_* indices for RPMh power domains,
> however commit 86a9264b6c56 ("arm64: dts: qcom: sm8250: Add
> interconnects and power-domains to QUPs") brought some more old-style
> indices. Convert all of them to use common RPMh PD indices.
> 
> Fixes: 86a9264b6c56 ("arm64: dts: qcom: sm8250: Add interconnects and power-domains to QUPs")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

