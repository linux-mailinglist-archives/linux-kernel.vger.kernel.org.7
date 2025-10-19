Return-Path: <linux-kernel+bounces-859516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B73BEDE0F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 06:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06FF73E4769
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 04:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3851EF0B0;
	Sun, 19 Oct 2025 04:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XVWZ7fwi"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A91135950
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 04:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760846910; cv=none; b=VmiHrpZPMRd1dsNPDcCgzCSc0z218FE3lVjzUvX7c7aI0/S+OQ0/gm4VQgn4KzuKNWLY3cLjceA2CVpqf/pyJ0jCcipkxpRdc38m2yRI6dtvq/NwpPIc4iwPyLockqe/jBTu1lzcCOF5evZqcsV9CJkeOhSxJb5KBhB9josDEiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760846910; c=relaxed/simple;
	bh=PYQScSZOYoE1QyTJBk6buoc5qNLZZCr+32xrpVAzVuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCekSEL7MASuw7btwpXT91NHMVcWYOqdi7vRKx+U6+1K4OeMG4CdIGM88zx0I7KaxVM3qs0OZk/gGt//FPUDeg/Htz79oMXlSbnv2Vk0ynmV5IVy06ndDEOREUKSvFa/V49rJfvpzfOYOzztpWn3jR4dOZTnpYCK43ZPCL909ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XVWZ7fwi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59J3Xd9A032378
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 04:08:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=eXtIl7gx2a3Jyse1CDj/YUds
	dckxFLnn5liYk/3DXnQ=; b=XVWZ7fwiNdHgJNJA672XFIDVSSDeXZsLaXAdgl4M
	zCHJrfEgm8LrYeUW330MrzQwl9M+tTIK3iP62ylNyAiih2Q8lqrICU4NGQ0aNEZg
	fBg6VzLx8Mjr4xJqnvKna3Xz6mzOsoOCHKk0X4fQPC6G72sl+X4EBIpQoVVNAfAb
	d/OBzlHz9JiGXXKeual49iQZnFnMbx67EolgQ9kq4XtHma93DecF8XByHabxEe93
	a0qldw06+YOTeTvz3yy4vNO1FcMnAyhBKSUHdwIZWLLBQK8PCVkheivK4BEwrgIK
	J1CBZsKbH8olCx74m0LWXdCJrubXyL2gKFb/Sz20PRpw2g==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v0kfa189-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 04:08:26 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-797ab35807eso147406016d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 21:08:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760846905; x=1761451705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXtIl7gx2a3Jyse1CDj/YUdsdckxFLnn5liYk/3DXnQ=;
        b=We+gf932+wTthQ25Ni4uDEuRuPBnnSRPUdGni7tsUv5fxl3SbPehzFwHqAE4usHtdC
         5cCsoN1pcK7uvcdeFxEnv47psZP0Iml61zXYgkhxayVM9ZrYSYLgnwrU5kr7cSVtwMeR
         DfK/oM9mbUfG+zxU+nkaQhHjYEf5pkPGlPg8Nk64PxrZhD9Q+/pN6NqV9K6wZXmGrS0E
         VV1Wy8pXJGC04yb7ZysdZG2RRxFWK+RaHmEq+Mo3+IlRhQHnrX3kYexMYPNVQRyej/dG
         W9KIhaAQxuRs7+wpkvDNik0XQ1BxJwhvk3Kg9iqERSKk6Qtg8JXFzSv4B4+uashRwlar
         O/BA==
X-Forwarded-Encrypted: i=1; AJvYcCVGdkLYMS2YR6BybIjdHqEUXhikz1BttjZxot6slPwOtLGs5Lbji6rMpb3JsEo6gSXbQ//6ZDT3uSLU/1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnwqW3aSDnvKsQGZAGMkWIKRv+HvnHjSW4//W+SFyfQ18b+HOh
	Pw2lHbGOKHMPuohnfCa3IhynUjHww6SFQ2DL66cL+H0v2KfIr75BfwHzOsxan9d9Q/I9eRMuwMD
	FvoxhfOvf84N8NLHpWdQVgdGqFDgrV6cwhhqgl5Wc4STgp6Wmohvqkl6fLw6hSJl3Ltk=
X-Gm-Gg: ASbGnctNElEBGaIjvVFp+s0EEqhUI1fzVhINvuDE81mtOz4aqO3nSbtrzReFwTTHLyB
	+ShW5Ah2eA2i5jADcSGTrb0inN0wHfN0Oi260+g0yKWs1m93t6os0XQAso9fRO9eE97GEDchgv8
	mQkjYIYnYsYNfinUDVBg+ZsgtErggxdnPo1osSixamf/wc205lvGdX1hWWBv5mYCwJSVPCmRs2B
	qp18Ue4ozeTdJwZnqQdNlvBDmBNYC2vgkfBYFQoIdakLsL+EnoHvZ9gT6rBcXlQlSzRpB1bX0+P
	1kvxFEze9hd96JUbAZRrHKMPZeFqADmSu2n93S84R7scdMmD6jDPflJtQ7aH5Yxk2eOWej34PZ9
	KkCq2tuC7SENUGGvWZcoRPWR62HiGWEJ6cpNINqfiBTyjDtm74DGZMH7nAnMqZKl3uAHglS1P50
	eK+RiKzyLlSws=
X-Received: by 2002:a05:622a:1793:b0:4e8:b4c8:3fe2 with SMTP id d75a77b69052e-4e8b4c8412fmr34739541cf.11.1760846905199;
        Sat, 18 Oct 2025 21:08:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwjpMQMP09kJ0jfxgHAqYveaQLqrlnJM2EpETyDsZGjRJiaYgkp4Ad4myb57SXe9M/dpx8/Q==
X-Received: by 2002:a05:622a:1793:b0:4e8:b4c8:3fe2 with SMTP id d75a77b69052e-4e8b4c8412fmr34739361cf.11.1760846904593;
        Sat, 18 Oct 2025 21:08:24 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591def16b31sm1225608e87.60.2025.10.18.21.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 21:08:23 -0700 (PDT)
Date: Sun, 19 Oct 2025 07:08:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>,
        linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] ASoC: codecs: va-macro: Clean up on error path in
 probe()
Message-ID: <oghgx6bzhcd3uoju2exzijoe7titw5kuhyk5g6hx7rdcgjsvmv@fvsefyhkeaui>
References: <aPMyw_ryay9LA5SW@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPMyw_ryay9LA5SW@stanley.mountain>
X-Authority-Analysis: v=2.4 cv=E6LAZKdl c=1 sm=1 tr=0 ts=68f4643a cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=ebUXpRROGgZ4PK-tThsA:9 a=CjuIK1q_8ugA:10 a=zgiPjhLxNE0A:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: C5ckz_pswCczIZoRQyl-XXp6E8U1PCaD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAwMiBTYWx0ZWRfX2b3tOto04Xat
 JgWrpzTIBJQd957zl1WLXjusPWdn/YOELj649L25MIhOSa5iAPJ98/0Jz2IBfbrkFsfGBUCaL41
 hUKK4ppnPEZudcZ0H9UXFbQY9uHL5cPJ9VYkDzijuDglfmEPgDd96UWTwCWTStz3Aw6M2U2RtpE
 SAS28T5iNVWOImrq8P/CD1UdaZgej3IkBYx/mpWr6ZdkQ90I+ZkH3ciNVVKc7lhaEUSYWM8LiaC
 zgNieyS6xuwacScwHLLEc7B6lRSBd8AAF+VOHoKJ9dDJn4yHX9iXISlFRS1cRhrGQ/hHBtLbQAW
 iQnw80636lio4jaZ9NA90jk4AOn/+zt+VO9CthWg+ln3uMMfayc3euMNkPAaxJ6WaJl4blFR3EL
 AbPtyCWNFoy5R7Xon2ogy3zwU2MpEQ==
X-Proofpoint-GUID: C5ckz_pswCczIZoRQyl-XXp6E8U1PCaD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-19_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 phishscore=0 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180002

On Sat, Oct 18, 2025 at 09:25:07AM +0300, Dan Carpenter wrote:
> Do some clean up before returning the error code.
> 
> Fixes: 281c97376cfc ("ASoC: codecs: va-macro: Rework version checking")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  sound/soc/codecs/lpass-va-macro.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

