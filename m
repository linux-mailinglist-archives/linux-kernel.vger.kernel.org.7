Return-Path: <linux-kernel+bounces-846554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD19BC8558
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 11:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A25C4EC4C4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 09:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22862D7804;
	Thu,  9 Oct 2025 09:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="chGpUj2Y"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF08262FFC
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 09:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760002587; cv=none; b=YF5M84Lz81BDVX6fs9wXeJr4WvUggrJK8uNi4FqI2LGB4XP7QG37iQTwBKKTaS/udSO7FRIY2GdQRiq7phktA7/iFeQAwcRZGQAZhncAtuOuK1WpT3n475OSYqH2kAICr5xDk6BTJlsQdo1LYoKZuGbjIw4JkIe2JhOqEK6SQH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760002587; c=relaxed/simple;
	bh=gfxmdc0fvddAxG4b/OJJKinGY5tgGDXqj+bN4HMO/MU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PpmZFRhhd7CPaFi8wfHf/nenmM8JpZ3oXWnXKkQsqBEn7VZncL1eukqejrrsUCQ4uydPb/4lvIPji/N4xy40vut5Xk3abZmbDAXCtCQpTUXNcSMPEGRC2t9IxUbhsH9KFBZTN+OJ7s7f4L9N7C6wk4gSqlNSwsFX2j/VLmmGoSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=chGpUj2Y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996FSmD006842
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 09:36:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZlENfdV3NK35Sf3xLY1YxG11Zkc9wWwP7JbbV+drP6A=; b=chGpUj2YCMy3ZVAn
	kDhkvrgRbb9lsz7nO5BGZLYpXfCmUn2Liu5uHm6Hjc85VZV+4eYGLKxwCMJJrF4j
	+znwDfsIXEMAg88geZDDAd7ZRSwQ8y5lD27g/XeVRdzkegxTnMHoPYrcQgWXGyhX
	AHTMD3Fbl3QH0jQAWGWzZg+xgBQ7elMU6w6BzMEfaMHLjAc4tkii5mUblEEfpW/0
	lPVZtT2SbM1LhxBLARTjGj6NNhIAywG4PKHmX4QvzrYicFUTCBJvU8+OCMvdtunD
	yfVo/AX6no8BIRCY5JbVv6XBc3g3rnQJX3rcHQU03ZAscjw/Gt2l1OBST1nVGx5y
	/r+/XQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4u294u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 09:36:23 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e56b12ea56so2353541cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 02:36:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760002582; x=1760607382;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlENfdV3NK35Sf3xLY1YxG11Zkc9wWwP7JbbV+drP6A=;
        b=oTAldX/jKrZxkL//EIsj0djSnv54s1rqlZV/95GSIsO4tQ4qUfpiPNwrKLsRN9W5PP
         kEMDRquAbcfpqu+numR5RmmWmSAfklLIlBAU01ptczyO0O7OzJLUOALyTVQjoC6HYITe
         3GZRr/CrRLzdvkQ0xFFRpEu0rgjcvkwVSH2IjGYJFHsYOtP4mIwqQmCtgcRA+FNrmAcJ
         lYeHNHrxnmcktXyCaqsmvgUcNf8+XIhyO3N49PUB3k62+TEaomSgdpdk4A8JVOWBcqaI
         wuVAeSCJEtbJghWwnhoq+QUw58EhoxqMhAKtxWMv2gLvMox95rshH8n/M/6O9S8Ozj/e
         Z41Q==
X-Forwarded-Encrypted: i=1; AJvYcCUuOgb/5H0oSbb0Ef9+DJerJdEtQiySfaBgvB6EF/iAqhkqzx4WpxSc0KKEoUJu8OC3RB4HfdfC080gOdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPXid+lIZBqn+Yhg8jNGX2QTpUyKNwsPmLQmlWfhkAo/X+bbVt
	L7kx5pY83REk5LO+up0mxn+g1dzWL3xxPBG1LvQUE0qwtcXnTCUBDu1mvh0sLJ4Jjjs03eOpKUf
	FGDRoYnyE6hheSBxT1FOBVLUbuDKPIDC0nE3iiv/NQsjP/ezA1KB4411BKW6ZjmwV3ms=
X-Gm-Gg: ASbGncvs7qjGukQiywBfNASnEhqbh0Zdz/7OhGGIVCNN57GINs19IV0TaeDO8mtQE8Y
	1uVO0GN8/QV1APETfkUsU5GC7OaV1bZmtTwyTjyN5IaesSVJn/s4eVp+Kt/1gRU4tTiqkNf/Xt/
	ZRBkzphvP04Pd1Y+wkMoJMgCqSyTo+9NNMWvLEVsmcJvAmif3RU/nUbaaBGzZwLAWfc5MrPDLJF
	V6coLAUxMZAHC18qrSNbtVACRPWUb2ayE0V1VehbZQQHmhivZvGNIVLGklBGckG+dhRqaSnqxOP
	S2OFTS/QPtHn1j2Xj6G4gC3NQSgFubEGHUekGwvqyExerPyvN0Pt1WpI1BHx/M91ey1q1XBM2Bm
	mzi0nd9woD2RmlfAq+bJ251BuuZc=
X-Received: by 2002:a05:622a:587:b0:4d9:c572:f9b3 with SMTP id d75a77b69052e-4e6ead21584mr61468441cf.9.1760002582484;
        Thu, 09 Oct 2025 02:36:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFswHdiOJUwRiwcv4uyVPagNLLBplb9cULvTlYReU61ImKDfBFX8j1A++FhoIl/DoaD+NWcOQ==
X-Received: by 2002:a05:622a:587:b0:4d9:c572:f9b3 with SMTP id d75a77b69052e-4e6ead21584mr61468221cf.9.1760002582059;
        Thu, 09 Oct 2025 02:36:22 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4f3c7e057dsm707731266b.88.2025.10.09.02.36.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 02:36:21 -0700 (PDT)
Message-ID: <d9d4171f-98cd-4e5b-862c-5711da8abf63@oss.qualcomm.com>
Date: Thu, 9 Oct 2025 11:36:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] arm64: dts: qcom: qcm6490-shift-otter: Remove
 thermal zone polling delays
To: Luca Weiss <luca.weiss@fairphone.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>,
        Alexander Martinz <amartinz@shiftphones.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251009-otter-further-bringup-v2-0-5bb2f4a02cea@fairphone.com>
 <20251009-otter-further-bringup-v2-2-5bb2f4a02cea@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251009-otter-further-bringup-v2-2-5bb2f4a02cea@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Vrcuwu2n c=1 sm=1 tr=0 ts=68e78217 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=7Ovdx5uLAAAA:8 a=6H0WHjuAAAAA:8
 a=EUspDBNiAAAA:8 a=8Sbc7aUHQeoA2S8VE70A:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TQZWkJv5rNK5-PaLMsrg:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-GUID: qK2DGaeGji5V4kVk6ToSynI1Fs-SewO1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXycWAxF+HGOXE
 zkwCGDxr2rylexRI4kngGUsuZwu+Z7bshemA9ULGISZ3hpKuO8yZbC9dpFmdKt3525XwP9c7aFo
 hjnP8u5jG1ddk8ryZP5rgOwCMGt5MU2S2qetKCzFyO1kdnz0GcVEJTONzFBT81GVVkposTR0Qbp
 yvMqa8nUuUPDRi6x3B5qes8usVDwIyIeJzx+hD5xIy/3xNbnJ9r/HYYsUDbxwRU49+/gZm8TE8Q
 I+ti+L99RqAukAZSomu86/rLdkpldeqrQ4sIEsQjXfDIIA77+MrVFYH8DUg01ZLQpEHNiooTG49
 O+QL4ZcY0JrghoIXOZCIuZIxnzuZV0ghxHLLkEIuTQIW4J2Tz5gwzlPzKVJvQJwlJYa9mhhFi7R
 5G3mW53zHCKhcFknWP+cI8atKUI1Qw==
X-Proofpoint-ORIG-GUID: qK2DGaeGji5V4kVk6ToSynI1Fs-SewO1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On 10/9/25 11:06 AM, Luca Weiss wrote:
> From: Alexander Martinz <amartinz@shiftphones.com>
> 
> As with all other devices in commit 7747a49db7e5 ("arm64: dts: qcom:
> sc7280-*: Remove thermal zone polling delays"), apply the same change to
> this device as the delays are assumed to be equal to "0" if not set.
> 
> Signed-off-by: Alexander Martinz <amartinz@shiftphones.com>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

