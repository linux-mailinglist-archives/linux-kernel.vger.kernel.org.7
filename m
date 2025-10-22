Return-Path: <linux-kernel+bounces-864180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 845CBBFA1E4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1D4719C56BA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 05:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1732EAB6B;
	Wed, 22 Oct 2025 05:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="itPyFBoZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631501FC0E2
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 05:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111979; cv=none; b=qFEPYqP57a6PJX1jNd9IALgTEQWrnOBgvZ4/Kp9kNo5jdr5FbOoUhUdZoYsdfqhJoojW1Fi0SCNROeKmmWMbNUxd69pMeLXMxWhTlqdJ8BVlo+FA9Vz4k758aD+eEJbggzlOFDzXavKhDruvstN3IeZ28qW1U92zbA2slmr43Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111979; c=relaxed/simple;
	bh=GPbtRPqIECeP0yclKwXqY9pSqHQ2lvzxM9YJWlNlbnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jBn4EopUWFtP47ADUVKlBt5VKUIq/+tjtzxTtaPiEVXNiJAUkHL2NbBFBF8q0oxNa6sasRUQz5fkCyNcHqXRj0h2uzKQri3tct/l9bFdX2hI1baZy1TWcFp/iujtFUU4oY+FRh/zTxvv+rrG31g6gK8++W6UukWSzHAf1ENg6iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=itPyFBoZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M1hV9g020418
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 05:46:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CainteRZ8Zd8o7nDkOh94ekQdPJKyfGA6FMGoE2UxGE=; b=itPyFBoZ7vZullgn
	Lbeb/ol/nIwiqcLEAHc2JyyC+bS5ma8gFXGt6j/WWcN3iYJdkV4P36mr9iwtV8nS
	GPFshO7E8mZVVKnKSMPlx8prY1iQeW7w1YJA+kByRsJ/xVoYRzJsnTZy6sa2jHEt
	D0sogVEKIuLQnjx25lkmkJEEhJpbVsnPWtZudFpCLL8MHrkh723JqjWJz41pl8+R
	Z2ygefy2h12LYzMNjr6dt1uFOrxZoQnkc1HaXjLt0cVczJBcUGeHrC6Riwle7Mlg
	/V2pNaW6PqKFQJrfDS9gNDq/D6YAB8I6hV8KDLcsCbva7kHMn18d5ok3neVX9y3b
	/kxv+Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v3443csc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 05:46:17 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-33baef12edaso5951579a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 22:46:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761111976; x=1761716776;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CainteRZ8Zd8o7nDkOh94ekQdPJKyfGA6FMGoE2UxGE=;
        b=FmCUK+DoWXuw+ZZ8h7sNob3upxQFUTirBlB98iTE2t/vRDFAFcrWjA5NkY4kG2NbnS
         Inq/cM+bQcwcNBnf5oFabeZ9X4lCi0v0x+QrEeZPKC6bIjM1p0VxNdtULeS5txVaXAcX
         iz0atcck9WB6ssnpTNR8BwLHlKaOpMU4czKB+GQzqIK2qDTibmGriDKPc+/E/UTWLzkj
         9Gu9Ub1TnXCaSt2u5+7BqZFEZcOl6ECn4sp5F0xLf3DBQ9DXbYajvbo71ZC5DD4bbxTG
         rv1OwU9O6n2ur47I1vEqeO+IF2A36J8CEEtQAGxisnqzwNrVkMLUrX5GN3tmQlVLzJ9a
         8eHA==
X-Forwarded-Encrypted: i=1; AJvYcCWtLGMYOtdDnScyegmDDU5Rebd7tRljgKLTTbExFz12RWh/jnA4Iy9YXgPbwnXTS6bbYMfbR4EDUm3Pd+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD6T4wgVbTV+ll69dLSMQbKSmL69t4YQ670DiaWHzbgW7xa8wb
	DdEgeBRMtdjapdAN99YvXciJ6s2xuJT3cQUCaijvInTUBj4Xi6IzYlwd6dQFwFZOWZB4WuQ4ICG
	v7AYyoxcyZdY1827QnDXulYFB0yh9GQWRQtm0wSTUIewMY2gl/CsbM08fa2e49xa9I08=
X-Gm-Gg: ASbGnctkUgFvuHjVzdshdlHeKoQNKSXuHCgwBS8RitMOPXBOQwfeH4JI01M+D1hQJZC
	xhBDZ++mnSa70vqrZcO8u0vheKMpB1BUNaqMr/a1ufudo49y9npr2rGbKRvTBxWckhPEbn27Rvm
	+8QjQpjzNfgr9BfUFYHJ7hLkcxnZTcjV6AMv5OiVr+A8xHfA3USecrgdwoZRv8AiY33+fN1WVPa
	IDKdnBjwU6hgvFvQZcd19UI7H+uormkZNQplCSs3fOhvkHh6lxLyFIT6fv4q3bJPGOAysqwldI4
	4lFR99UVuc18Q7hxihGBkbJ8Cdqfe1+A/1siEAGzlnWcYJtRvOfSnnN0Cwi6ckipPCsrpD0eWTP
	mVeYIroMyx0oO2jDaDWLfv608dS6aj1k4ow==
X-Received: by 2002:a17:90b:3f8c:b0:339:a323:30fe with SMTP id 98e67ed59e1d1-33bcf87acdcmr21722173a91.14.1761111976597;
        Tue, 21 Oct 2025 22:46:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7gmWeAdo/ledsoYbIw1NxsAbbcauz1W825kuXhtPHAlp3ip6vJYAzoO9Gi57NsoB2yrPBQg==
X-Received: by 2002:a17:90b:3f8c:b0:339:a323:30fe with SMTP id 98e67ed59e1d1-33bcf87acdcmr21722145a91.14.1761111976164;
        Tue, 21 Oct 2025 22:46:16 -0700 (PDT)
Received: from [192.168.0.166] ([49.205.252.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223f11f0sm1409058a91.13.2025.10.21.22.46.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 22:46:15 -0700 (PDT)
Message-ID: <9b9dbab2-7dd2-1ec6-4dec-50063171dd15@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 11:16:10 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 8/8] media: iris: Add platform data for kaanapali
Content-Language: en-US
To: Bryan O'Donoghue <bod@kernel.org>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishnu Reddy <quic_bvisredd@quicinc.com>
References: <20251017-knp_video-v2-0-f568ce1a4be3@oss.qualcomm.com>
 <bRFGFB-aXU67uJWfk8UwBE0tOCTXpquadL2rGHbdcoY0nEdQ17cATN_K1Khk6RWZ8cGONLIs9N6XLd_pe9CHOw==@protonmail.internalid>
 <20251017-knp_video-v2-8-f568ce1a4be3@oss.qualcomm.com>
 <9d39841e-d2c1-46e9-8745-1d4d8d073739@kernel.org>
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <9d39841e-d2c1-46e9-8745-1d4d8d073739@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: oA8-zYu0dXq1ZfrtEVOpbxHo87Anwm4w
X-Proofpoint-ORIG-GUID: oA8-zYu0dXq1ZfrtEVOpbxHo87Anwm4w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfXwLPcA8xgNHCS
 gWD/pd+1S1kwg/gbKKGUIi/HoNQ1dlT9rd1Jm9evi/UmLwT45sWVd/elOjLgut5dFleKYn1CBpY
 ej5tVUwsjOoGSr6M+nyJDix5Bo7lwtAOMDY9ogWVcm0oJEGYMu3Z5YV9wwK8kzSX4eZTmiYaQEh
 VMzv1cazfoh++y4vyg0iunHCnDFhBuSRAGAEgk7yutTXdgGqNT9CbJyx4AMYraMYaJbmPZ8A+QG
 /6lwl+nxa0Wr2Pf5GNc7wjWZc5hyDkBFSe9xzhnGUe39J39WUyj29NyWwkDn0iNGUiRNZuZtxol
 dLD7xYasxGsaZcBtkSzzoGu9q2v5YQBERvHODUI0BakD5uAA+5+a5+fq8LrA/Aw6L80ATMpjEvu
 WyvwrC5aMEurwY+rU7rEU5m3VKk8wA==
X-Authority-Analysis: v=2.4 cv=E/vAZKdl c=1 sm=1 tr=0 ts=68f86fa9 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=FoPg1IWog9mqHsjG+aRTFA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=aMGEy1ZA8zrtvtRU1IMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180023


On 10/22/2025 5:09 AM, Bryan O'Donoghue wrote:
> On 17/10/2025 15:16, Vikash Garodia wrote:
>> +    .fwname = "qcom/vpu/vpu40_p2_s7.mbn",
> 
> Dmitry pays more attention to this stuff than I have but, is this a released
> firmware ?
> 
> If not, are we sure this _will_ be the correct name that hits linux-firmware
> upstream ?

Yes, the naming was discussed and the bins are accepted in linux-firmware

Regards,
Vikash

