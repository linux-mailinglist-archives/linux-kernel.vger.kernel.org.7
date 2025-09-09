Return-Path: <linux-kernel+bounces-807612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0017B4A6F3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 700491888B36
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC66287250;
	Tue,  9 Sep 2025 09:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nLKhNHL2"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D341027B332
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 09:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408984; cv=none; b=qx9DFCPNLsUcYOe4jQ1FqDIez5aBxW6ur6yXTnBg0bcqVqKHwORHbTY/Xpoya6Unhsf2PQDrXT1R1wZ+BzqYxYALJ3sQMKivw4WO7UDZYn+4lPSDA109gnR5oFvL9xMeRJpJYvVCZWg0lWH3U22bO7G+uoTKQxC0liPE40aCGwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408984; c=relaxed/simple;
	bh=+iRk3GZBaP2PL9IMjGaAxI8oj1q+MIx1QCjF6rwLYrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mEp3v37bucFriC2rby9vBH6yZ8/DvTeIQ+pRH7Ymf2HsEewQYxciCzK+EkMjeGAtEGvWA+ji6+8pg4hRpGcgAXETJBmB6x0Yhp7XgMGHhLNtttpejawaIWxJbaRgt3h20tPbYz6Iflx/6Cp/5zbHYH7wINXxNtO1c6A5ZRCT/ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nLKhNHL2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5896SbDV028461
	for <linux-kernel@vger.kernel.org>; Tue, 9 Sep 2025 09:09:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xQLSJJKoOAxMywKNQ5ccnaCy0rBzwUBIGaUQg1SaW2A=; b=nLKhNHL2ewzJOPud
	lZhZtHzpkeoIViVIMcU7VaJf1n28xgKVWSCY74A8qqc8NAsyDfDPdgpNfqKqs5S8
	DALDhvWpu1iOU0eZEeKh014H+CYEOpDICzIvxMlPWJus7mG+vTUN4h6bt3qfUMDH
	raoRK5dImM2TjFOePAWN8g4xZcgx3keguaBxIibSZNzQUrGaAqjJB4XakATEAHqz
	JYk9zbodMs8kWnhZUhgKP0OcE/rqc57I3sDRiyfNHOd2O3K62rq1rgRdydDLUNIZ
	2BHXMxLQ3EPK9L+UizGxe8aL00oltypYg3Hx3Rps+iaVKr/LafMXbKmeKswA7izl
	xOaggQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490aapfxb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 09:09:41 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-812c3483afaso124447885a.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 02:09:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757408981; x=1758013781;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xQLSJJKoOAxMywKNQ5ccnaCy0rBzwUBIGaUQg1SaW2A=;
        b=kCAX7ccjvbtWkG3fey9RzgFyWzTIKg6EwaEEeUa5eAYDJ9XSreFcwjBcWRyG5V1T6M
         JOXNu2Ivn5FC85+8l6PhqPRzIWAyXGzB7qyc3ND633/cEM/OT0/2lcDvdNbOULSh9/f8
         ciYQrFeh784mtRTt6Ad/3u33gesXlev1um6BB1mYtNeGfzxav2h1/EpKApRc1wKivBKi
         pEq92y9T7gKv+/lumIqVdgRcVSPpTiGs1PtGg6KNURVHnP0lbFXCs28WE4I6ckJh7fPS
         eiwXmBm30Yiw6spxuVORG9XiSJUl1foNY+VP7/Bd3Y//O7vxTR3oLf8xCjSw5b3F7e/w
         M5jQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZxLoDfElMDHIf5+TUm8Mi4uQwtGcYxvNEUBnYr4RGtQ3lenqYQOZQLmll+w9Ws/RIKcKMFYCyKSg91a4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz3K95vWKHJ4qXphVcdT9/CC5uYYLQ2rswh26ZOCfinVrvu6NB
	IbCRKnbh8KsL5B/S9HKl3SrEfIC87cLFFVL0tPoTJApHR+E6hn6tJLWh/jSlcly3jcBYLZQ4r/8
	8qjPiYkrJ/L78wZHL2ANg27RC9vJcIfsARf/l4Nht1ngWB1t29e1KxIvBVcY4kPz1/IM=
X-Gm-Gg: ASbGncs5nIeOkfoj59LBzS4LRbXnH66F5aJ1x4jpmiq+DzeYU4mROK2x2dlutRXhJOu
	JfMwz//xhfI13AUfd0gk+9/vbQW9PUincYm1t/oQxwEjOetLHOQu02bUd5oQSSMUq/vEOTJOejJ
	uVvrZTzoJtI+6zuUu0aeDpmGgix3mj7IRGkCQJUEbxIEmNGGKW0gifuS+YNfp6hCaU3iOu0bteq
	VJUgkHIveCmAHPeCnJ+E/+AoNuaMQyTr03RIkOLXO9jEk7Al/bSfZY0LgaDYhXYpluydOW3yTgS
	JMGozaE8XE+fj5xhu1FHdUUr3MvLAt7OZQBVHkboPSn4SleTgtB2mlFX/MX4WiN8uYv0q45mLET
	SNLJerYusTbul099VsmUUAw==
X-Received: by 2002:a05:622a:190f:b0:4b5:f4c0:5fd with SMTP id d75a77b69052e-4b5f8531717mr75858871cf.8.1757408980778;
        Tue, 09 Sep 2025 02:09:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElaS7VsMyAK4sn1lpqAU55/RUqGD6nhMUESe+uEL6+M2kFs4PMy1dM3B8kVdWzzm0FbO3i4Q==
X-Received: by 2002:a05:622a:190f:b0:4b5:f4c0:5fd with SMTP id d75a77b69052e-4b5f8531717mr75858671cf.8.1757408980330;
        Tue, 09 Sep 2025 02:09:40 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff0d9b1b53sm2545589166b.96.2025.09.09.02.09.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 02:09:39 -0700 (PDT)
Message-ID: <b879cf3f-4216-4fe8-94a8-48244efbffd4@oss.qualcomm.com>
Date: Tue, 9 Sep 2025 11:09:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] arm64: dts: qcom: lemans: Add GPU cooling
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Connor Abbott <cwabbott0@gmail.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>
Cc: Gaurav Kohli <quic_gkohli@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250909-a663-gpu-support-v5-0-761fa0a876bf@oss.qualcomm.com>
 <20250909-a663-gpu-support-v5-4-761fa0a876bf@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250909-a663-gpu-support-v5-4-761fa0a876bf@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=eMETjGp1 c=1 sm=1 tr=0 ts=68bfeed5 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=7IyadIS-_L4Ux7daf1QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 4ci9B_gWfo5X48cyufy7e-6ZcUNQRjPy
X-Proofpoint-ORIG-GUID: 4ci9B_gWfo5X48cyufy7e-6ZcUNQRjPy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAwMCBTYWx0ZWRfX4UqXJMHjMs/t
 R6wlM1g0wB9i/jCmotKeLkAkrYJXaasMZg9x9DwMZIwVpq5pPMKuIQNIcghI43h2ubUNvkPaODQ
 zSyUqtfl4MbBzosPlHvkuKSEUo+qoE3mN6Rvch1RtYxm4fBTl6QY4akmJaNdA7n75KLHwDjB4sZ
 eqQIfhY2kZofDhd3PmbzH4pI4w/vpWuk6oDOpgAUt9FcWC6obCPEXkTCmRlyNjX5Ggkk7zWLEbe
 +SaWX7M8RkpelAa7RgXfKqPeGxOYWvuRHTlPyx/Ap9TBViJ6IFiSuFO/G6US4RcPKnzY4hXrX9d
 uqEuiPuklAMdhL0dKHsmUqqnsnsoQ/a33TkCeO1oNNrpAV28LczJ5kP+kTrv9f4h6iM/kagazzk
 slJZSRev
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060000

On 9/8/25 9:39 PM, Akhil P Oommen wrote:
> From: Gaurav Kohli <quic_gkohli@quicinc.com>
> 
> Unlike the CPU, the GPU does not throttle its speed automatically when it
> reaches high temperatures.
> 
> Set up GPU cooling by throttling the GPU speed
> when reaching 105°C.
> 
> Signed-off-by: Gaurav Kohli <quic_gkohli@quicinc.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

you'll probably want to turn the 115 trip point into 'critical'
(which is fine to do in a separate patch)

Konrad

