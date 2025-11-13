Return-Path: <linux-kernel+bounces-899199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E92F5C5712D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE2974E5DB3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023322FE582;
	Thu, 13 Nov 2025 10:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OX9cuSGu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YM0qVUW7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15972D0607
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763031532; cv=none; b=qsNZcE8YIi4zEloRs1OKZufH636oBTP595UtByrSWRaah3fOfU1ssIiaqV6+nccLatXprMjGc68QSdL5H1+51BRQ7gSQ3t6Ju+RlU20U0PkPB/U2au6db3yz+AJziXB8RycNim1BtSc++7a30VpW400VcCbRRifdkClYr86fTvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763031532; c=relaxed/simple;
	bh=0SfTgwIzPX/BA/JPrecUkCRKouOa5PWWI5O6ZWAA/DY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PcEZ+rms2tLkuRJJLnrjTGpDjo0cbXn0d/ANV/wEXHcnLgD+3OlAtn8DNV+nknRfjYD7LDyIzTZGgIM0bfzl5LQjY056sl/NoOlHbgw6ltW7ctZdWsPO4Mey6d8NDS7NJnaBQm8PVYKxeUn38mLu/iJzVfXXnJkpXu4zkzlo4EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OX9cuSGu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YM0qVUW7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AD6qbe23873609
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:58:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jgBPaO5vYeetCNzgFhvdCRkSv11ZkxPO6+3HoWQmMsc=; b=OX9cuSGue2w3yOTX
	RFu0kR0LgWyxuJjvGc9Ya8ZqJu/ZqNoTzEstbau0fpspsTIz7A2U4jGS61BnCtCN
	mEYsktpis3zl9MYBs77wYRrjIyaC6W/8QJD/51E2bNPgb9Iv+K1g1izUJi8I1Lpg
	HzZQaqYNNmysuiKoJAVqbDA8E7jho/Fi4LdG4c89xIA1kf0v7crDJl6pP0iO629q
	pCVL8VYZ0TBBAGpqHTB7GkTLgRmc0Cw1zBzr09i2kVJT8wlPD8Di08D6tanVIyft
	ejsV1xCAzPbKU9jkEpynvoDWKlIQTmNxWfm7ecuemCUk1P0cYWFz2BAx8zsxDbbs
	Ce82oA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4adaeurrgy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:58:50 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4edb714b16aso1581921cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763031529; x=1763636329; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jgBPaO5vYeetCNzgFhvdCRkSv11ZkxPO6+3HoWQmMsc=;
        b=YM0qVUW7JOstpF8Kuv2+fm0Rg1K5X5g3WNov7BBdTqfaGo+S81rzzFx1iWUKMqqobN
         EEgtqeWpayXg4kI3ern4fC819b+pbJbkYpoMEs13XWLaZonjKKZxlqLkxDb02EkyxxZv
         crhwmqckv9r4f2SiVhUYcpig2fs3VqqR44sjUy2K8NQkWKe+LM8L35DwehE0Dah2FQcr
         LCpTUsz/zYk5EB+hBTMMn972NaBPyIFgOV5WOaRYQKZG1YCW353cbvq3gBXCD+9LWaZe
         1Dw5WwaiU6FPAd4SZuZberg4vWp6c2Y5aNmSb0SjVYzPYgmxolNtrpadcN+YYyoxp/UG
         7Hlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763031529; x=1763636329;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jgBPaO5vYeetCNzgFhvdCRkSv11ZkxPO6+3HoWQmMsc=;
        b=xDPxChgp5iDxY7+mX+z+9EDsuMa09wGijPXAF+O0MQvERm5WFIPZ4k14Wz5p6NiIA5
         m4efHNTtzr3GULut0b0/7BbGzfKU6r233zlZGKgJciWs7mC6BFl7sWJNqcomlMS3vYvC
         LoI52XL4x5AxjfuwuKPYXqQ9mMkaBs2NpvtiHCevFZr6mUBAcGI8Pp9ZzyyTNO/wOK/G
         t6f8U4YmTYzM7dNMYU3NpxDfEF/jAZJWMBp3tphdw/ViKmAGPnrwrh8Kx2tI3wt6lykl
         hekmhm9WS58StbeKiHxt5SlJnxwrNJc2yoIJCDeTKJ93WKSi7g8K8+3TH8C35namkp7B
         Bx/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUbiFgKF5ojUzt1DAucB3U8bSqKciP+6C3tKOGAxz+gafriHObu8UFj1RPg+XHZM3f9s28KGVQ36bpz82k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFqPnUuuBIHHqmTVv227O+vU6dIP9Hs3mSGA+jpNG5ytxCKv8Y
	PDDe1ZfJcXVx7qgZTfFEvbHs3S5Zhk5scWMloO31PYhF4xta3Rl17dnQhqijmPT0NDFa9h5QqIZ
	D21QZzIuFDvznG6PxttxLRVRqBGHE/vH6ugXK6bJbDiLgHQ53OR255T/ZW864yf/L9KI=
X-Gm-Gg: ASbGnctN1m2FCEroCpWHFx20IjRTYTgc53TPHrOoDdcCieCBILfZ40jyd5IPh7bGPM7
	LXPaqpoDFWKd3p+5x+9qn8IuoRFX7IQluGmJm628oHNtloKZfe3+33usHL3oV7SHhaappVhEEyT
	N4X/sW+aTsVS0q73nsKNK5l/2SqsnziWfNr62QP1ut/cHYvd+w9IUuC6w3Z4VCyQBPK8ZDica8Y
	mZtNg+3mnkLyPuSStvep/dyWtIpeb3bSarrZpe2aP+NGxxchrG1Ia3G5oD9VYjPnOOUKNOyP0cp
	p8A5yoz8vlFuc5tla/HoHaDdNlQmfP4LqeKqBXQqIksTgG+wrJRn/u8ZD54wB1dfmy3+aMhoaVk
	3Id11aBhLPuTy/4xzNSyk0vAMLU2now77ncQ/Sxb3je1bKFX1A3wGGCuF
X-Received: by 2002:ac8:7f4f:0:b0:4ed:2f2b:aadb with SMTP id d75a77b69052e-4ede794dd10mr20846381cf.12.1763031529009;
        Thu, 13 Nov 2025 02:58:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdQDsxtlP4V4oPmd1PqozO62xfFzJpWU31Y99QHzv5aGDzw9SGa8isg87xEOWg69/ZZScEyA==
X-Received: by 2002:ac8:7f4f:0:b0:4ed:2f2b:aadb with SMTP id d75a77b69052e-4ede794dd10mr20846131cf.12.1763031528471;
        Thu, 13 Nov 2025 02:58:48 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fad3edasm140259166b.17.2025.11.13.02.58.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 02:58:47 -0800 (PST)
Message-ID: <8ebd7250-fa3e-4705-a5e6-f01878389df5@oss.qualcomm.com>
Date: Thu, 13 Nov 2025 11:58:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/21] drm/msm/a8xx: Add support for Adreno 840 GPU
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse
 <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Connor Abbott <cwabbott0@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20251110-kaana-gpu-support-v2-0-bef18acd5e94@oss.qualcomm.com>
 <20251110-kaana-gpu-support-v2-15-bef18acd5e94@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251110-kaana-gpu-support-v2-15-bef18acd5e94@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: a9Rm0fc2AaVkdav4T0aJ5h31UzTcrdSc
X-Proofpoint-GUID: a9Rm0fc2AaVkdav4T0aJ5h31UzTcrdSc
X-Authority-Analysis: v=2.4 cv=JPI2csKb c=1 sm=1 tr=0 ts=6915b9ea cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=1fD9zpMYXuRVFxAoecEA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDA4MSBTYWx0ZWRfX6jzuf29W4kbw
 iRLFIGQGPhNxHMQSSIgwNYczyGBKYBaOSECf2iMTbKvrEGtTBx/9oLbk7PnioDnYSkHMvm5elj+
 P5FydRWyQW0W2weA3J6aAJb92+gFWeYKUs4glyionLDQywAvsa42B3G+5QChNYppUcoPuSBb463
 W8rf4KsZjh8kOYbKwlt642f8IuqudalMkTJQe0RPIxfSKkTUqKLxh9YBvv6tU1oPepx85VazfRb
 G8OEnLrlgsQiPBrfl7beO+bjvUzGUnQRFaR0bIzhqlO/i0ZNQTWG5jjp0j5zI5G/rVHqzSNZAJk
 9s2d03MHAT3PEK3aiySXnBcOYDb9zvqLoQCqzC4czlhTynWptQyQXozFHp5LmuMgReexl76ri+P
 F9/4rGtHVKYDBXL/twZ1YrgJut65+Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_01,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130081

On 11/10/25 5:37 PM, Akhil P Oommen wrote:
> Adreno 840 present in Kaanapali SoC is the second generation GPU in
> A8x family. It comes in 2 variants with either 2 or 3 Slices. This is
> in addition to the SKUs supported based on the GPU FMAX.
> 
> Add the necessary register configurations to the catalog and enable
> support for it.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

