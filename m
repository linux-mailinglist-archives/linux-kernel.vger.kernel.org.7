Return-Path: <linux-kernel+bounces-759089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A18D2B1D84A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 14:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7518E58331E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 12:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A0E256C84;
	Thu,  7 Aug 2025 12:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oibpcH2A"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D581253B59
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 12:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754571202; cv=none; b=mnOUjnBdybt7KAXxXQKERqG15VGYW3bHiF7toxi/Bd8NU0etYC/IK+wqZTBSxxEs318wvCFea6QnUP2EXeW/jJQP1NQRiAlhN7GDhup8gLDXxMzTZmQT7bkm8hz+NDY/kub9B0dHfTGQ3w+XDjMiCzzu2NCt+A9tl9pEiah2oDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754571202; c=relaxed/simple;
	bh=GnP7q9QS7PYmZnYRIwEV7jCYPkQp9Tbz9TTFQNPo9p4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jeccrlY0/qaoSCGGRv90VAqvosmFzDeUNaNBpev4r7HP1HyJwRlBWR7I9hLwOZbcpU0x8cBDy+sEd71AksTrQvOXrdtKtK9CO0JadUv4HvrRZPcruFpLEsEkLFBwZ85km254yDKRwVZ+3Mig8BzHhwmT0qvJWepMAmgtflUummk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oibpcH2A; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5779D3n4003741
	for <linux-kernel@vger.kernel.org>; Thu, 7 Aug 2025 12:53:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yXbBrsAVWEUto+2EQni7MAiMKvsV9MQuSffRI/E60ws=; b=oibpcH2ADyMlCBjX
	9iP57ZSxmSoHzWRIfFMoTD5j3aMxAc84g599PE8Dasua7yWxJ42d+6tSFWFAWU2o
	wzBRQK39vIzY9BCyzCLwcnGkh/cYn9Tc0Z6VL7fvFlhCMTc03Jzt1Na1j4ym3i16
	iXp/VhpQyLDDkF/QlSbCWH2ntBZic0NtqyOZYUFDR+r4khyLQv8dAKxRsiuez6Pi
	4UIl83fOUVZ4drulwDPVesIzGHGMQRBZFn1uO1Cim7r9fSSSI/jljS3mc4JPSOvs
	QqwITLwf71RGz4DxrhB5IiQZxLpcRRLLE8t9L5KfUdLj1J0IJgkXutIG9KAWkJRL
	ht6sVA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpyae9df-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 12:53:20 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b08f6edcedso3262211cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 05:53:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754571199; x=1755175999;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yXbBrsAVWEUto+2EQni7MAiMKvsV9MQuSffRI/E60ws=;
        b=ei5SWsn14nzf+/YyIAipm5m2MqJB1UW1Squ6GlRUZYxS72v1F6h8vcqbOZGRasFXwe
         rss8x65gyVsdml3J4CQNhbN2A6zMq+UtW/7iXDHWj2UVwzV7o+PCCpS659/T3+tXBzmx
         eh/F6LN+HZ5vKBb6yfsvoLAgXH5t8h4zOs4sc0OlQJmnSJbfGmKuN2kC8tImy5nsRVNp
         2RKx69CLeNxzxfKdp0/lQzebeeDWYQo7ZjG5gf2Aq51wzAqjFvQwWOgOzNPb7k7TlPEy
         Sxt4YXdUTxPbNEinhdoLFxpOx+lpxbJbti39CvDJo4332n/AIadWd+vJ/iWunFU02qgY
         eq2g==
X-Forwarded-Encrypted: i=1; AJvYcCWwvh9s6ZRR/gFlcaz2fB66Rox9eZcT0FBUUMD3Z06KOO3HdXLUMSPa7MHu9ZyG3W4uLLzyayKlb/LQ08E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye/Zq0Uq2zQSP+UZua1rqZZQYs+Awit5bQCEhELdGVdpNop5aH
	6zbPwnACY4F0Sicwp0+gWu32vY4+RAwohcY4J+f1CeRwBV6o9vHpNJeUJ4OllKAhqDZgYVthare
	xDMj0tAWKwWhky0OmrI/THs2xYLy9bF572y8a2tha+xoFIyoD7/QzSO2w0+CtjOVhTlw=
X-Gm-Gg: ASbGncuXDpipB11AEaENzDA9kRM9ep6eY4H8wf9VO9r+eDwZlb7jMggq9mhEfHRNt5e
	erTiwyZ0ne6Rl+YUn2leZfE9mXnoqRKvtIMq7zTQpJH9vSY7xrsqSMaum8MUO8f0vqpih21hjnb
	ylviJRA9NQwwNGRcanx5m1BTucKfLKvmpsgzkvSmUaLzfHg/GC/bteasMlilmm1Om7mI9Ex+Ghv
	xZH0IOr002th7CJiU19InZRmuowb3bWXM5Y052IQ8wVGuI5rVDQsa0zCQZhLK1mHR8qV6km9yFU
	ZW25HOWdhZbvnG89LfIQowOkjp+l5UMryV/VwRrnKbkYDama8wD6a6rRGhalcg1wzUdMOf0JJ8e
	K1kCaEvlo6SMgcW/0QQ==
X-Received: by 2002:ac8:7f89:0:b0:4a9:a2d2:5cd5 with SMTP id d75a77b69052e-4b0913afaffmr46123631cf.6.1754571198947;
        Thu, 07 Aug 2025 05:53:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjQb/F3Dpx5m3xJ/1/7FQiIn6sY7lvvbOUgnmMTP1/s0ChpRZyk3AJpceI/KbTkc5i5SrlQA==
X-Received: by 2002:ac8:7f89:0:b0:4a9:a2d2:5cd5 with SMTP id d75a77b69052e-4b0913afaffmr46123471cf.6.1754571198465;
        Thu, 07 Aug 2025 05:53:18 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0def2esm1276255566b.61.2025.08.07.05.53.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 05:53:18 -0700 (PDT)
Message-ID: <f5090a1a-64a8-4a42-af6f-36937b4ad51e@oss.qualcomm.com>
Date: Thu, 7 Aug 2025 14:53:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: qcom: scm: preserve assign_mem() error return
 value
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250807124451.2623019-1-mukesh.ojha@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250807124451.2623019-1-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: GqaAag-xIOwFgbSqnKe2TyLcOa4RoDL-
X-Authority-Analysis: v=2.4 cv=MrlS63ae c=1 sm=1 tr=0 ts=6894a1c0 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=_VHsfAAm7Tyy6ljEudgA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX+iopnMpbgGXp
 nGF9paDv4NC3A82n+zqObssUFwfVwrjw4/WiE8TOlYOAlvoYfB+XEqRuuVXHrYt0XzHoYLNodno
 13fWWv37rMn/x7pLSnTwSGmjE5h25zhp25hVK5HGQJ+AhixFjbjjmiobpKZVUG6PVu6OWOlD9de
 tzIXJcyMwH0GMq9u800I0SHK9EBYs4YOmPxpJOikCl3Mmk1Y84f7R4U4/MnIXVe8CElKF+FVFH8
 SV0tgxM63srrlMM9DdJpYbMkYbl14SyazsHoWMEEOdO913eKBHoUAClpBMtiKflHRAGE3nOyEFs
 wKILHT04QJSzShB14u3/LKz1Pt3vKoPmmU7uhmrwNhSP6OgpmbuyhTbD0kf1+1uAq21K2COQ5G4
 x86NY+JT
X-Proofpoint-GUID: GqaAag-xIOwFgbSqnKe2TyLcOa4RoDL-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0
 spamscore=0 bulkscore=0 clxscore=1015 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009

On 8/7/25 2:44 PM, Mukesh Ojha wrote:
> When qcom_scm_assign_mem() fails, the error value is currently being
> overwritten after it is logged, resulting in the loss of the original
> error code. Fix this by retaining and returning the original error value
> as intended.
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

