Return-Path: <linux-kernel+bounces-736610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52514B09F65
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 11:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05F327BFDE1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E28296150;
	Fri, 18 Jul 2025 09:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MMa3nh+j"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6992949E5
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752830602; cv=none; b=PC7EC54SEZugWN2aL6Fhvl8VHxB3JtG16LXuVOlMInzY/3nKV1d7VGqtNmzZG9AMskbaWUv5DzFf1q83veyzpylAsUfLuT/vR36IyZfIhqiImxQT7st7faw4ugG2KiZbBohtiAJPjmgkLjQuFRVVr2mD40RF7h9IhM9GKPplO2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752830602; c=relaxed/simple;
	bh=RcdS4qXRNHqoIFtflPy8p6xxpU4RVnQO+PYcwJzQfzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UtX9gK7UGauOootCWpdWBSrt2i5R0l9uamhGunKOsWm9ZjjNFZwx13pU1LwUHu9a0iNfV5U379LUblOUGPYard/eIgICPEjhZO+SAN56DNQ8gdUKwDuLufbPuQFPudUjvprwzBGVEenCY1ycNJlLAPsP9AT0eaZ1TkubLQogMGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MMa3nh+j; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I04Qsr016007
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:23:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R9tbdwW74cZEyqwu7Rui55/J0rnn4mTkIqlUTKDRA+4=; b=MMa3nh+jnbnhJj/n
	qLQLWRiB8S65cc2Ewc0lGtk7lveJn4/SBE3pbMdBizMtCXuUyixMc1OkNBN49KTg
	nZ2nREVccb8OVDQpqgK9wlOQzuN3Nf2BvQ0TRg0R2Rn2mBmRxSIcxhMhGzpisIjt
	nB7dKqeET01QFmvtrzYIznq9zZ9/ZCDczjvrnHLO++e8lONjZZP2sFNykCgKnMma
	Ixi2/NtSYvZAnKU14/XT7d6a7oQB+YWRG7OsJ+QTB8LVZC6euEmaZlwiWK1GiWc+
	mwLdpRPLgROVQm59wwns/lyozmb5pEi94KDrerDGy5uFiHm8xmxM5cuqN8dz7swz
	iY3WEg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47y3tc2t1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:23:20 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4a9bcdc73c0so5179641cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 02:23:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752830599; x=1753435399;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R9tbdwW74cZEyqwu7Rui55/J0rnn4mTkIqlUTKDRA+4=;
        b=hVj5MPAwhOAm9crhU4aIxw+BTeGBvJ43fH9C98ETBf0Bk4YnpjNZjmUeE4C+OhYhrl
         F+Jit2NPvermj2E+6qRWmCC+EVDTOqq75jW4b1z+oV5nTbZzeV1Hcdm1qe23KHApL5jt
         TrLSMbcQpjBnUSjyYFYRJHCMiwmUpFI8AkAA+46UwKkvj2BqEPjEsWdXM6p9Q4i7xcqY
         0krgBRGUkJK7alXFWmXKpsP0d46ze6XeMd+o7aTnxDV5KfKX4Ar5z6UgvxoZfuhQJOkG
         ZIiZPWdTllSz3hPHx6BfSeIIaqZoPjVyGf6Ky31j5ELdYENEJ0vUCsgFEKqIA0XtCFWe
         fJ8g==
X-Forwarded-Encrypted: i=1; AJvYcCVp9yR+otV4k5CNdfGyprk3aw1g/TcSqU/U6WRv7bS5fvML1LsBjaNm4OY2dZ9B1YFCTgXmX39k3GHOME0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9tF7cXwhVs3v1Rr9wmSL9K+RAfe8m+UTH2XUexYrT8kEmFvaI
	AKy1wdeATlIcJCaQLuF+OyozLhHNphAVqQiSD56tKU+JYcfwgBesWmK8z8RPNypPbwgKjuVXjgq
	t7pFVsRBkVIczZ+8I7dK5i5cizqnVOaUY9bq8rZ73ICTuNVUkUgZOrY5f2XMS7WKQBmI=
X-Gm-Gg: ASbGncsC2OQ7heMvNe3kI1037XzV/yEnmgIiJYJjF3KzbsPAmS5IphSxEmID10DAUbv
	TzeLZ5em7uIdm4+bagoBS4V16+ftzS5l94IlQmDD/am8YzPh5zXAouV4RL6yY6SHDD9EWSPA2Lo
	emoknKCqGnlAKZ0RoNpKus5gFCrrpgRIdWPp9JP/R6Yydd6SQrel25yv8KToA2u6rdOr1rNKoKB
	MoxlGRRYEOdhZW0dvOIqdvRWBC3eS6EDwC0caOaEvCSKNel6O2yRDK8908Z/afNqrarBDTswV8y
	gNNhBbp0toUKUOSoj8a/FenWLzyb3Jvbx14c3xgGbh9C0PXA8RucOAV+EeTxep4NCzMnctxcxaf
	g4w7cjq0EvfxD3ZQpsqpR
X-Received: by 2002:a05:620a:27d2:b0:7e2:1609:a19a with SMTP id af79cd13be357-7e342aeef45mr582361885a.8.1752830599229;
        Fri, 18 Jul 2025 02:23:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEp5OpRRRlubBf4j3XB9hMRhuiSC9XEu5aCviHEU07bToJoCBMGtr/bqJyK9a710HZLckzjkg==
X-Received: by 2002:a05:620a:27d2:b0:7e2:1609:a19a with SMTP id af79cd13be357-7e342aeef45mr582357585a.8.1752830598696;
        Fri, 18 Jul 2025 02:23:18 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c7d9941sm87211666b.56.2025.07.18.02.23.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 02:23:17 -0700 (PDT)
Message-ID: <17ea4f08-daf0-406c-8760-23a23417ec1f@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 11:23:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] arm64: dts: qcom: Add MST pixel streams for
 displayport
To: Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Mahadevan <quic_mahap@quicinc.com>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Danila Tikhonov
 <danila@jiaxyga.com>,
        cros-qcom-dts-watchers@chromium.org
Cc: Abhinav Kumar <abhinav.kumar@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Yongxing Mou <quic_yongmou@quicinc.com>
References: <20250717-dp_mst_bindings-v3-0-72ce08285703@oss.qualcomm.com>
 <20250717-dp_mst_bindings-v3-5-72ce08285703@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250717-dp_mst_bindings-v3-5-72ce08285703@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Z5PsHGRA c=1 sm=1 tr=0 ts=687a1288 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=biz6BXDC6RXR6m6nPMoA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: LtG7l5Z4hgjhK7V2P5PxjzkFQDWMwbX1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA3MiBTYWx0ZWRfX9Ct0KH2ifA+T
 7hxd5xoUngQ7erxcw2CqGiQ1FSoe7yQWsBA/T2T9BdelEZnWOWrV+COEXtVFxDQnpTnSXEbTUTl
 gzCJLeeB148YVzb9w+9eNQMRhGz/6E/SHkguXxnzLticPqYz0h3fOAR5GtWS/RuyoGAOHcMr/Zr
 kFzkmbmpMf7tEJmtYkhuOuQDo1A0nEqBu08p2IhNsegpXfW1heoDB8ALJ947Hs+AgJjOT0193OJ
 qvK1ZdfGSXnNmKPpHeZiMXa4BJht5ooLfYFOqLwUF8D0Xoe+uIwKW7ggkcFQcY7yqrJjPvoso1a
 sW5eaR3iFJzKh69rASqw/YeyRp8h7Ghr0aHY1UJHQFDLv4twCPMbCSHv3y95bDFBLYLECXCje1n
 Kg4k0ilqIHz1ez/GiwowoVxQR1ewAZiuW8tmCdeERuOX2NgYYtf2NQdjaKFvBZAYeXakW8Sp
X-Proofpoint-GUID: LtG7l5Z4hgjhK7V2P5PxjzkFQDWMwbX1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxlogscore=577 suspectscore=0 spamscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180072

On 7/18/25 1:28 AM, Jessica Zhang wrote:
> The following chipsets support 2 total pixel streams:
>   - sa8775p (on mdss_dp1)
>   - sc8180x
>   - sc8280xp (mdss_dp0-2 only)
>   - sm8150
>   - sm8350

I think 8250 can do 2 streams too, no?

sdm845/sm7150 also have the clocks for it FWIW, but that doesn't
necessarily mean they're consumed

Konrad

