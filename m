Return-Path: <linux-kernel+bounces-778296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42231B2E3EE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 19:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 623FA60214E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 17:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F4F338F21;
	Wed, 20 Aug 2025 17:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DEGzZc3o"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB242580ED
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 17:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755710460; cv=none; b=juDYikt8cfj3fyetddtpaqGBIv+K+3WHajcQ/HiU+JkbLF2wa7/OHGQXDtelOVo8zTfG+yccUXuyJefmdYLH/sHJpyBk1On/LsiKZN7eLs8cZJwrrtnI5UP/2sR8obyN/rYdN6ZeeVVCgZaIW4FsN2yaxeE6tTaAHoLYbXCly28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755710460; c=relaxed/simple;
	bh=NRHD/SaoUKlWxG5x9K1o/sFuQugTQx5lbwzhpuZgFko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVuqji4b9WZVvi3SZOYm0PSl4w3Y0Sy8S6vvrG2kwsdzrmUeRGWUsKRFTdY1fj7ejPJST3Ld8h/76pBkt31ohtRd9Cxic0qle3f7jpRn4i5MI8mQe8hYGxiLb5/MThe3gN8DXstYPjbHKDnmZIxUY7ekx+UnKgmEjv0Scoe/1Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DEGzZc3o; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KA3asd006919
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 17:20:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=7BAeafa+hTBdTcNeLE5VaCsh
	Bcl5DTEABVk9scTlNkQ=; b=DEGzZc3oiQjwyaP8JugAHAU8Ok9rmeh7iSPUi1f7
	uuQWrBVeFjS6fMME7mCxyvZxXl9BZvUiMulfji/6sBAaqmRCH/WPVFlZjR4u45T3
	1HOlBP1xIvyhwNjpDb+tIunimtAnJcvOPehbcH1QjRMrJ6fmyMB8BwWAFgVMLUBb
	RoucNp7vLI/PFQheFxIAY8W1R0U0RhH9Dd195fsfs98IkBPmPcLn1zlw/nG2K07J
	Meyo3uijjpvOu8qQnm9Ho2nkL3R87ZY4xu6YH/1+iKadh3VJUWLS4pG3/5qgqpmN
	2NgMtvv0md46q0SOMgBTSmkQ8iTd86cBcMvujYfH773l1w==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5292ga3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 17:20:58 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70a94f3bbdbso3316866d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 10:20:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755710457; x=1756315257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BAeafa+hTBdTcNeLE5VaCshBcl5DTEABVk9scTlNkQ=;
        b=wy6Xh/xDKmWMyOolCntVEb3hh1bBeYYsSw69VYybmcb/BPONuba2MdMHHCiBJIaCuk
         YRNWpupwv/Y4eJ1dJn2Dri8qZ0Li0Y4985YNwdDZ+f21BojPTcRrr+RQS4tHTK57hWhv
         BCJEcaIro+7803KJqVnct/t67G5afY7hP2u30JiTdP0r+m3thJgJbAT+Dpe1L6yMGgUS
         bpKWVJiesW8lXirL7+t3/kpu2CQug6V+sWTSv/faoJNbRiJxS4vTpLP8dk/Be6DZQ56w
         jc/x5SDLm9fNMn38e/QUJTxkLZE9u2JGxQF1goyeAYWDQKRvK7lZh1SNz0X5H5dMJt+1
         n5ww==
X-Forwarded-Encrypted: i=1; AJvYcCUdQOg6am+SNYGcF08tnxMnT958blCLgiBnqc8Gm6fHWWMlpadRHeU2JclevII3tFjSOY4cqfut0bTtxHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZZX+Ul0wjIaa/V9jy6JovPNelZfF6PIcypRaQfmzsUbzbY+me
	93T4XBKyzYlzDjZlteTMQn01M4j6NU+jUrhStf0a/V2IsH0+kiyb6nzXOVUWMyzBumA+XszGMx8
	qZm/aPwIB4+MafugbRz3cKNBt9PAq+2EVSNGYzjqoUezbD2jDFZcvcZMmAM8i88bAMh8=
X-Gm-Gg: ASbGncvlgqH5vsdSs1/noNDm/5SsfLZYbzOOL55Wvde2XmkCquLeFcCe0j0el/k7u+7
	xoksF6FR7Hp6kXINQYeX44wP0wf4Y3F5gqdFPDaSHq8vEXFLvMZhOmRcS7fxJSQKU1PggDZnhP+
	sflsc/b7vvNdtKo3jXMah7e1400xePRzhtrsDiRgkOk5FZaRel5nuSB4R9Wj5/xQ7ByLpkwb7wt
	6HG5lJO3H/R1sGHT7PS37u0lDEjrsrtjlP/dxLVMnUf4xfyVvE97tBsA6FZtAFzJFTLHogQkh9h
	fSAuKviO+SALod+TLOAJlnoPzI0YwbYqY1jj8vPqTA1yezTeVLQS42I6ExvEHs20oj8liSa5IZ8
	9dAVLqZd797GM0UvXq3pCqW8rnk8FBnpdphupE/1qK/Yy1G9JJ8AT
X-Received: by 2002:ad4:5bea:0:b0:70d:47a1:cae1 with SMTP id 6a1803df08f44-70d76fe9438mr40332706d6.23.1755710457140;
        Wed, 20 Aug 2025 10:20:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3n6czrojJ1Kz94y4cHToXW3HPALrWfZWenYGCqB7SJfzmkaV8Sa3oCpRIK2udtGSo003JlA==
X-Received: by 2002:ad4:5bea:0:b0:70d:47a1:cae1 with SMTP id 6a1803df08f44-70d76fe9438mr40332396d6.23.1755710456562;
        Wed, 20 Aug 2025 10:20:56 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef369bd7sm2676457e87.68.2025.08.20.10.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 10:20:55 -0700 (PDT)
Date: Wed, 20 Aug 2025 20:20:53 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: venus: firmware: Use correct reset sequence for
 IRIS2
Message-ID: <ddc557rrzuz54r5hlnblsopl2t4ca3wle3eaanbwa5yavgwtcp@mamxnhma5tw6>
References: <20250820-venus-iris2-no-tz-v1-1-9ebcc343195a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820-venus-iris2-no-tz-v1-1-9ebcc343195a@linaro.org>
X-Authority-Analysis: v=2.4 cv=Aui3HO9P c=1 sm=1 tr=0 ts=68a603fa cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Zxh-gqEWaZ_blzi-cf4A:9
 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: GEXULKxjr4B7zRRV1oVgf7HpL2xIXequ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX4Cv8Jk9Xp903
 q17C4NxgkQ2mopq1OugTfoYWTP1tMXVtjaIhjXgJd+yzP2SFtXPF7nHRVYXOM46w535SvWED7Vx
 hb2AeuSm99GG7QH0EDBmVd/8x1yzfL6y8nma5f1r9C4GLJ/3AyvprvAW4tbBpoHdiHXcLhMzXYn
 NGBCGz2PqOlufM3bOsWKfIUSZ2n0y9av4SYkWglCqwbCoUzcw8twUrxoqykfNtNe/OyMrKBBiq0
 jcCDYwrCXxrLC+eS5yTp4cYj/8/mdGzuGXZ9m076/ECnHcbqdIT9pfzAdgbbP35qcsEJmYGv8EL
 nZRsVS0bmPsu7P8tZvgoO3gcgc+y3imkcO59qDt6SC6r1aJm1J3odz3zfKBe1DFtPwQe6yflwDC
 cD6wpsJgnrfAM6QaDhpdTZeJb3XV0Q==
X-Proofpoint-GUID: GEXULKxjr4B7zRRV1oVgf7HpL2xIXequ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508200013

On Wed, Aug 20, 2025 at 05:16:39PM +0200, Stephan Gerhold wrote:
> When starting venus with the "no_tz" code path, IRIS2 needs the same
> boot/reset sequence as IRIS2_1. This is because most of the registers were
> moved to the "wrapper_tz_base", which is already defined for both IRIS2 and
> IRIS2_1 inside core.c. Add IRIS2 to the checks inside firmware.c as well to
> make sure that it uses the correct reset sequence.
> 
> Both IRIS and IRIS2_1 are HFI v6 variants, so the correct sequence was used
> before commit c38610f8981e ("media: venus: firmware: Sanitize
> per-VPU-version").
> 
> Fixes: c38610f8981e ("media: venus: firmware: Sanitize per-VPU-version")
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/firmware.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

