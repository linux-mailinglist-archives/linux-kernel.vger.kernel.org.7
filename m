Return-Path: <linux-kernel+bounces-737158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22709B0A896
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D0A55A521B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5E72E6D15;
	Fri, 18 Jul 2025 16:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jh5w+yIQ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3072E6D08
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752856658; cv=none; b=ncpbueg9oOuMmWCzqvGHulI7Opewv6KOGf0WZGEzxgfvGB6uszxrUBVwFrUQTgWQWPrpyf6c7fpjT3okcJ/yQX5hW7QyOgrTkJed05gN/ryYwAU2CEE2ipG2VVXbQABl7Oq5P5DtCv/sJMjZVerV6iZSdYijAPjUKKCAfNT1UOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752856658; c=relaxed/simple;
	bh=twxh0YDbsy5bG2ICpRMFh+TxK2HYQr21LmR3HLWkcg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T+61hNK0OKqHjVFxzNM5eT7gi97cTiiSKE1alzpWgzoIwhJ8JJRb3SAyXgN5iblwGuwQvQvZsOroC4P/dwXRf8KepcnCJR52FnKYgmirdLi/8ItxA7wxL+jNideQomHXalQS4FGWyzt+f1gelhPKcCIvVMk28lWGsz0jSwKRHCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jh5w+yIQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IEHH4k022256
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 16:37:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6ZegwlQ32iOxl1i+QMZet/CdzL3ki4WTCIaMhmI6DoA=; b=jh5w+yIQ/PZJavnM
	t8UNy6oanuFBNUU67lLQmR94C2gMSxvSRl8qjlSntcQePRVL8Hl2Aul5vY4n2Lhr
	34gr6hK7wj6sDUGOMm/6IlvczcwH/D5fqq+1ozSDyLXYJjqLIR17UmI6lMucjB8t
	SZi8A0yWW/oZVDhXmEvIqAmmAQoFjrQoqnyc0lghq1DSm9iOZhO2NIsN5M2iWp8A
	3MN6zqA1rRGqrWnxvhWFpx/1MnXYfzAc33p9Bn8Jc5rpvVscDsC3jYELWwVcKnE0
	2o1h7ZGy6NoqlT5UYwx2079BxL3pY3bdk0EbOVG3NJQY+xYw9Nf9vKsHkVfK8PDj
	AEsX0w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wqsyc9p1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 16:37:34 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-31215090074so3500302a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:37:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752856654; x=1753461454;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZegwlQ32iOxl1i+QMZet/CdzL3ki4WTCIaMhmI6DoA=;
        b=cNbRsoO2KhIjglMd8F64wUIM8Pi7kODk/3TVuUBqhQATlBBqK8OJwdgsyYRRkEHqYI
         qlaN2FsDZl8XM4erja9J5JDhvScCyGa3uqRjkWV1y9jePjZD/tVoWvBEnE5kt21Fvm+x
         kwAmRq57c/GkEIomtLSacLWJ8uB9nVpnabPbN1zvc933zV6KTcDFDEtuYyGgdvPYaC5U
         /lCrWGfoYL//m7+zN3yWeY2U0WI94Po4065fC3YTjrrYgzGpiHoU9NZVHqTZAvNk6S0C
         Ul6fZ68I3mZncR2mY4I1aBnoMv1/8uuBBpS3xw/aFi+uTLGp0N5PKD3EXv06/1dyFodi
         hOjw==
X-Forwarded-Encrypted: i=1; AJvYcCUHeKP48IsrA2zVFY5PUQQ9pc645iK/YobpIDWV5pABdFIvqB8REpiBUQZv6kNlad5TCAPxQuChJffvDyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoE8rdly2GJaM6VuYz77uB5t1YIZ9idOlVbLGeX/53wtqJUg5v
	Xzt+iYkW7nJJ1SslG1s5iCKReWf6/CP2oJONvahqLSph3TeeMN15e8cT/57yQ0Cupm4Y9qiY1zl
	/NHnoTPK8GrPquo/MVvoTqwEs6q/D3lU0UeYej7JmMAameuM/igS7F+VTqfDSoVZ/rNc=
X-Gm-Gg: ASbGncuDYIvvABIYY5l7V5B5SKejZgSVKDdC29WjzX18GUKRDXpgJ4GUA4xtu3abRQx
	zrRvJZI75Rqeo6py1AKi5yBtGi/ywBTMKi7iAmVjMtI5YmUgCdAE8HPcqJjL0TZVfUs9tt/wYKh
	XQ+QM3t9YFr0j41rWz7YKVBIlx1+JSJFlM/p0X6zvJO2NHL0QXCZo8g4MgnpDxvEMxLq74qu7hT
	JMLstVXoYSX/CK5DTkbS1W0B5Xu2TPcWYTwYg3m8PY9lbWoFzT2FPBqEBatLnWuXAnFo4wLLGmx
	f1JXsuGDmDNZ/NIKXG0GReK/OVJLfuYzxU14OT+trd2u/8KKEsgbLyzxgZSXJxxxSWfBgzbjYgP
	Q5fdFRGWhoK2VnKfM1U9+Cg==
X-Received: by 2002:a17:90b:2d81:b0:313:bf67:b354 with SMTP id 98e67ed59e1d1-31c9f2a0103mr18430773a91.0.1752856653714;
        Fri, 18 Jul 2025 09:37:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJSpYJWt9gcJBSv5M7yM4Tjn3hnjTMDiyr0xa8abdyvUZWBHlraaApCwJghcG7Ye9/EcQihg==
X-Received: by 2002:a17:90b:2d81:b0:313:bf67:b354 with SMTP id 98e67ed59e1d1-31c9f2a0103mr18430722a91.0.1752856653333;
        Fri, 18 Jul 2025 09:37:33 -0700 (PDT)
Received: from [10.134.71.99] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cb5c5da0csm3170530a91.25.2025.07.18.09.37.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 09:37:32 -0700 (PDT)
Message-ID: <0261da76-a1fa-42ff-9941-4ce235a449d0@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 09:37:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] arm64: dts: qcom: Add MST pixel streams for
 displayport
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
 <17ea4f08-daf0-406c-8760-23a23417ec1f@oss.qualcomm.com>
Content-Language: en-US
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
In-Reply-To: <17ea4f08-daf0-406c-8760-23a23417ec1f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEzMCBTYWx0ZWRfX1a1dtvykbaAQ
 LUgc/Y8pvVrf25pjwpIP73tLxbrTS1H9hy+ZISyHrODmmPDPkrD0npiOweVLEC89z7k9Ax19+YB
 U5vwYKfORRwIMKWOxWmkRysp3YtohDZKFWDCdp93xRUpgL3001M70hOP64nOTVMFZIW5wf04+0G
 9cPiikU0rP++mncxUjqietRtPpnoe6DqoAyClXp7p2OpXD0sZSzgEKdLyABTyjyNdyu8U2Mv02x
 SbR6HknotYq1YG6pE1C083bpmjhbLXZi6hOgUZc2JJcSonJBau8QQ/FESnBGXc+cknIXKaGX3id
 amJOuklE+VOC5VysTadcpGbPQxJyaT2W58hu1vgt230JB5NwQ+ruktL1/lR9ZeseYS1j4HyR0nS
 IpFhFfIsxxQvMVqfaIUDdXh3ysclSUHflndr8mMbWqQ/wdLt6euyqABJbxwItiRjEbWyhlVn
X-Proofpoint-GUID: tOjd5DKlyM-_MSafxNGhI7AUFWKQuK8s
X-Proofpoint-ORIG-GUID: tOjd5DKlyM-_MSafxNGhI7AUFWKQuK8s
X-Authority-Analysis: v=2.4 cv=McZsu4/f c=1 sm=1 tr=0 ts=687a784e cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=Q06rUcgQto-sQqt8d9IA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=687 impostorscore=0 mlxscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180130



On 7/18/2025 2:23 AM, Konrad Dybcio wrote:
> On 7/18/25 1:28 AM, Jessica Zhang wrote:
>> The following chipsets support 2 total pixel streams:
>>    - sa8775p (on mdss_dp1)
>>    - sc8180x
>>    - sc8280xp (mdss_dp0-2 only)
>>    - sm8150
>>    - sm8350
> 
> I think 8250 can do 2 streams too, no?

Hi Konrad,

Yes, 8250 supports 2x MST. I will include it in the commit message.

Thanks,

Jessica Zhang

> 
> sdm845/sm7150 also have the clocks for it FWIW, but that doesn't
> necessarily mean they're consumed
> 
> Konrad


