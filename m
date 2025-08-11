Return-Path: <linux-kernel+bounces-762365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4D6B20596
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 845E6188CB46
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7791B274FC6;
	Mon, 11 Aug 2025 10:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lDV5h0nd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7295423D2A0
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754908435; cv=none; b=d/EK9264hqTMTsJGu0A0nTFGWOJ1czMCQOcrgvMEinHHls9RYXvfb4CrA6orSRz3rHTjvJ4y1plFuZOou+ynqLhb6TVa3VeMR1yZGkdoS7rdpg2w2PvYxP/Po5SYvTj1XCydp9Wfu5T2q0NdC9I9NNZPuVbWGwGO/J8S7oVjsrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754908435; c=relaxed/simple;
	bh=n6bYWBbuvYgd7Of4AkNGNr2HVdrMAtKaVoR0TN1D2LE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UUeUr5/iT2cRFgE4+pOeKNL5IIOQO+BLnquhNTpL88hRKiU51UyM9WcLwBL4SxVKepIT6IKnAq7Qq2mYdOg8+QVC/3G5fKeh99TYl4ITCpgKFZ6FALID8ewmh8/VN2vPQ+poJ1QDgiH2Vi/SQad2db31vNZK+ZFcPBQa4rYkwzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lDV5h0nd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9dFfg029260
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:33:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wsD7GGJiNnfcvjretasZ/pNIYgJDbc71adqR86O7WrU=; b=lDV5h0ndMZZUeAuz
	0IysO8UnRQboBN6aqIGD9Jg9X3+MijLbMAA+Uab6Nf7FA82Jv8fXiU+QRYyzzXTY
	MpsLtYG7yHFlGthLlH+RamQCEAmEXi/n9212GiRtUqe08WkkXHf31r8mfulJqSIH
	hTmRm5xTc8JmaG8LynS4/k73FpXTWEkJVBI5s6YmNlVFYVMS42nydyWej9nG1eQO
	yS6g3wRIZs+UiPdwvBS2gad/iNpqa8sQ+nORwYYqurup35SULgLo3vfwICoO3EO1
	yFP6OaBQ4C8f2hbrbohrj13gelABMRCrN9BuQ3FT6j7hlaLWtmD7FVZlZNfLttQU
	S1enwA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dygmbygq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:33:53 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b07ae72350so10905431cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754908432; x=1755513232;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wsD7GGJiNnfcvjretasZ/pNIYgJDbc71adqR86O7WrU=;
        b=R7X7q6aBOWYI43yDkdptIW0yPuprupAX5IxHAJe+1ZQt++NBZnH6OWTmNfqoXouN4H
         GCuWbdnj8C0lubSosgIZhgipQwFqaPxzXbKI852y4Nky3rRFgpuKIJK0w52I7dWC/EUq
         SiNrl+iRJWThEKQXAAlD+8XYtn5uvwk0pdwg5GgsxnX3nl+lsP4RFlQwtEAIgsWq6fkk
         FVmBYCx1uFn6GvAxbjdfohM2vLhlQ9rFITyb3T/b+qAJbCXuCzwuhZzxapHVtljqOMMj
         gZSTES3o9eIR1PDurv+BfYsby328lnH8RCe+X9Pdwue4ONqfk0vK9QRnjIXeGBTSzbZl
         4ovA==
X-Forwarded-Encrypted: i=1; AJvYcCXhk9iYjVctsTxZyvusYs7F2bkxusUmMms4R10SIb0uqoOlI+to0ngSEC7X2oq6OOgygqrEcJo4pipHEGU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmt6r2HFbwnLFtXqX5Of2Gc/gZw+L4pB1VxLlAzFWzw8nP0rh2
	Be7HlRH0PE9UlWmn4l2Vd1OZxOil7X9PaQmAwHDEFjbvucofwtURdnAAItk2gXBX2aTOAwuXBz1
	Kvl2SB3Dc/N6DjRjJiFsrlrWILO22MqJaoFNs0gTRZ2ihkIh6BYA8kF+0pPGAEgN+0jE=
X-Gm-Gg: ASbGncu3xZZ9wKqAF1hsthrgY+fH6s/GnM49ZL0oOVm25TLpIWQgKpZiJ0I7WaF+o+A
	dF9YvVSoN4WNJqtpyS8/ckwIlsqqC5kQzTMdRDd0g+scLMAiAOzZWLA9xefhcXY/QVbBsb6eOPJ
	YmSWT5eSRi0W4vo/Nxu8rOm92Ggi6COMd72uFvk3745yihd9Ok1R3zYHk3NxU7c+vdBMXCH4mdf
	13gjEhujV9+XxZC9HmXOA3n0wEhdGFCbq3ZuwvHsofesMHE3vrp8K4UKpjut55SSAjDH4wHRiS/
	CYQyDVoWBqljM9vvhTa9jmAa94Llm7vizkhKC7SUZSOmaMgEckb6LTVJfGWXVOECcWtz3L3f2RJ
	PI8xxof8K+hHrArUQ+g==
X-Received: by 2002:ac8:7f83:0:b0:4b0:af21:80b2 with SMTP id d75a77b69052e-4b0c16c4306mr54913861cf.0.1754908432532;
        Mon, 11 Aug 2025 03:33:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFWzMOx5lf2Y5IZtNHNRwVFoW5v7W5IA4jlN1pRSARbMIRwDiUHjzbS30nEqXIzqvbxbYx1Q==
X-Received: by 2002:ac8:7f83:0:b0:4b0:af21:80b2 with SMTP id d75a77b69052e-4b0c16c4306mr54913671cf.0.1754908431941;
        Mon, 11 Aug 2025 03:33:51 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8eff60esm18546387a12.13.2025.08.11.03.33.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 03:33:51 -0700 (PDT)
Message-ID: <2a74d3d1-62ed-4a5f-823c-e1ca376ba104@oss.qualcomm.com>
Date: Mon, 11 Aug 2025 12:33:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] drm/msm/dsi_phy_28nm_8960: convert from
 round_rate() to determine_rate()
To: Brian Masney <bmasney@redhat.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20250810-drm-msm-phy-clk-round-rate-v2-0-0fd1f7979c83@redhat.com>
 <20250810-drm-msm-phy-clk-round-rate-v2-3-0fd1f7979c83@redhat.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250810-drm-msm-phy-clk-round-rate-v2-3-0fd1f7979c83@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzNSBTYWx0ZWRfX8orPVXXl6kUe
 Ed9YPYven5WOkgTQVMs22Pol8kHwOpzu1pU7WJXZz7V64hcFfUa+fAxYHLtL/h2hUzgcyPd5TqT
 BR2Dc+s5rk3tj15RmT+zgFHeTru1pVD9zZCfRpkzXUQKfwHYPBd5lHr72llZ6jZGXV5Kemo0hVh
 hwP63p0fabnmluFzhEVtkBavQvNx/7V5NitV/IMY8LNrllcrcV7cczM0f/KrwfkpjPEjvQAtjcj
 TSmXjuRHMuuPopneVqgT6Ence0/3zYCjVDfckVdEXhGuf56NqnqQSmPyabvGKZomuQOkjdtHjrq
 f2543ao5yUxU4nF5i7IxFa2fXtzs+4a676GHAwv73pCthjEg/4vzXfqlO+ae8uBRQtpvS7LeOK4
 /eHWwOop
X-Authority-Analysis: v=2.4 cv=FvMF/3rq c=1 sm=1 tr=0 ts=6899c711 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8
 a=aS93HcZ8ji4XsMPHnqgA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: kaaUBsbqutX-lSYR4TUEysYMOpr_zbFd
X-Proofpoint-ORIG-GUID: kaaUBsbqutX-lSYR4TUEysYMOpr_zbFd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090035

On 8/11/25 12:57 AM, Brian Masney wrote:
> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate() using the Coccinelle semantic patch
> on the cover letter of this series. The change to use clamp_t() was
> done manually.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

