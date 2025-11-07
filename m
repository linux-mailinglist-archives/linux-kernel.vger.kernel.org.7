Return-Path: <linux-kernel+bounces-889724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF73DC3E52D
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 04:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85C4A3AD7E5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 03:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A602E7199;
	Fri,  7 Nov 2025 03:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="akoRC4Mu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aUAkbeUY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7278021578F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 03:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762485389; cv=none; b=lpNCgiwo+7gp7dRJFv9J8BAOEnymO/rLnFPUXkwPEO8HmgvYUWMOwyNTmrPofEczNrc3Ujo0QupO5qdFJmtlHpPEvN7uWh21LJUt4kmLmK+PGzq71R0llE7uNxUJkRL6n374IaMSPK1njfBzWxR6SCvtafE16QHDutmdRdhTpaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762485389; c=relaxed/simple;
	bh=1morzm8NYa0wAvKPrknK4exKQLvQ7AJODwCifEu2fT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/sQRvOcvgux/vLEGmRr7QKXSxkpz7FhC+5Q4598ldYq9S82uiR1oim7JAzk93u+zw+VtcHi3SiufP2MJdOTeGgjpNOh00Zruyd3QrrWdAfCv82+9Le9ettWZATpcrUtel30NsV4wj+iz8RG6J9HRn7uvWvvAIQBo/OeIyU3y0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=akoRC4Mu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aUAkbeUY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A6GsV21584163
	for <linux-kernel@vger.kernel.org>; Fri, 7 Nov 2025 03:16:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	prIk2oxefhTBMGizLe5VBrcTGfPiFu9uI/8uXkNkJYM=; b=akoRC4MuJEYOHcOn
	GOEn/RdiVZ7pF80wuWp1tK7XtyCbDnPhVvV5K3NlayL39B5GLS7OVb0OPNdyxT0L
	UwlgfdmR1BjFq0wfhVEVCFiKlGUEBscmUObbhU6iO0ubpIMbjM5bd4E5zZ9OIj/X
	M5sESt2ytsYmiRF9TZzGrnbfCGUz9t5UFOM0LLFFFQZ1Px0dlIwUfHkLEc0iZu5J
	C8PQpcWoDpAL8QbKj/ol9Er8atBO+i01LkHnRLNc9NwK4T9KJoGjhZqUvV45MzJ1
	jeXa9gBi3NS9yHmaKTLj0vUUWVkMeUOZRSitKpdZW3qD8yQVQTZr4APjMCvGtMJ1
	ULCOfg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8ykthk8y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 03:16:27 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ed7591799eso8415811cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 19:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762485386; x=1763090186; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=prIk2oxefhTBMGizLe5VBrcTGfPiFu9uI/8uXkNkJYM=;
        b=aUAkbeUYR2CzB1FT67n+T3F2ltWI+PArEtEEU8txJTmTc8ivPVxERb1agImDues9mR
         TC/SIxDSnzdeX2xxDu03Dz7S0+2FijpQOqxPqAayXzROEs4x3khG1NWRRfHheZxnV9jC
         PKgIjsVEGSQc0so4QDwvWYlRY3fIEjjga+lrHyiq11/Q/CJi4JMSgwQyUEWiR7l4yiuX
         ThAxTYLiUePZraKJMeUMF8E9L16lvNLjPwj1slpeS3bi021hJPrGw834J6PK/saaOP07
         iq1rAMSUpWn4EaGuuMS3ix75cwA6RRSSf454nXn+6phlz6imMZKr2hirY90JaslG91F7
         7jew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762485386; x=1763090186;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=prIk2oxefhTBMGizLe5VBrcTGfPiFu9uI/8uXkNkJYM=;
        b=qTh9MCGOEprTH+iClGrw6Dwjy5I0ectaSHBFO9pyOPkwALMBYhwFJFd1NJs+Y0gj5B
         ltwoST7uCzKdx7TOV5kAiVxMuAIz2OXQ5U/afyo475b7KB8RZaN+1oARvMpfDFdp+JrF
         Qo8lYnqO9rxvXm7PDMy35IFkZHWRWMXR4DfyGeXkX3l4gb8n5N5yY8HDq+EDghT5hhc1
         2eGN47vZOn9+gB4Isq4/MYuHb2GtnuzkZf2szR7mekud335y2KAJLT74IRVOrKaqNjJ3
         Ul5gpNS9QK0mC3L5hMhoMaBHoXJdhWRMSr6eWLa726iNeAqrYQ1zQRBvr6/nF0Qqt8BA
         2KFw==
X-Forwarded-Encrypted: i=1; AJvYcCX7+CwH/BccG4D07iALmR85gY4qneKTYz/8CpVC2AI5LjDvBPCg000Alm5czpHmIWcGfJJlPUZKntd7ZH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YynHM5MYs4OGieSNVoNV/KahgJC9Qa1skh08sO3Ybc9Px9tNNs+
	bf17DK61Asp4vL3EB4bnA8it3n2tveCETqaMoBR4o+I0z4MiPy4wuRWcg48bHlxUp8ncV4qenyD
	LNoLlq+cGnIAX5kg7if6uL6AXt0IgPtl4l3rHdjVzfV4kVsGXgtqIXOlwsM6nAgCO1eE=
X-Gm-Gg: ASbGncu8jMLpOE6WgoTSicl81nHqFYB3iIn1Z8KBwqIQhiDU8GWsimqUqa5a9lnYztZ
	Jbx/1rgvebCVCmhdvaSHCBylYRBWuedVmTpn5PdVBqC4He0vRwHiHSEdryMLlckjkl8GO+s0R76
	zwJF3WtZ6kp0YZMTPzRPaYyzgAL6fxnOsurcUs8L6FmWYdAT3iahUJ/m1xYl/VJtz0gv0Tb2U7E
	WpujazaePdkHADDe86vvv9MKb6R7H9Kx5Hk5EzatoxKwRKU61x40dsH/VCLQHJx63WOhKLkz1dE
	g4OzB9BdW/wGwOOQKm88wzGm763W8DRlpBdOqR+Bi+cyuX8wb8Wrk8ATldFTNLxIqk0jtbHyjkc
	34e0C+7Bz8V7WyCm6m5D+/wPascrIVVY+tQUO7xIeq5WiFLbb6kvyS1gI1YuQJPHBNYeKvO7Hxa
	Ivs+XJG3FC1JAg
X-Received: by 2002:ac8:578c:0:b0:4ed:23df:6a4d with SMTP id d75a77b69052e-4ed94a83250mr20198651cf.68.1762485386328;
        Thu, 06 Nov 2025 19:16:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrhuAniX3epDvEEwBYOamZ5qOgePgMzHNWTJLDWUcznPxtnIGIxwFlzJYufCft4rDvBY1XrA==
X-Received: by 2002:ac8:578c:0:b0:4ed:23df:6a4d with SMTP id d75a77b69052e-4ed94a83250mr20198521cf.68.1762485385913;
        Thu, 06 Nov 2025 19:16:25 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a0b779fsm1134734e87.56.2025.11.06.19.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 19:16:25 -0800 (PST)
Date: Fri, 7 Nov 2025 05:16:23 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        Robie Basak <robibasa@qti.qualcomm.com>
Subject: Re: [PATCH RESEND v2] devfreq: move governor.h to a public header
 location
Message-ID: <cdzlgnun7kpn24hziut23njsnlnzl465hdquq4zfmur7ylt5id@ioaqt5ilixwt>
References: <20251030-governor-public-v2-1-432a11a9975a@oss.qualcomm.com>
 <CGME20251030182636epcas1p2b332b417c1c42fb559a6f34e9e9f408c@epcms1p5>
 <20251107005809epcms1p5f33e9560755367f0ba4b7df82c87fc85@epcms1p5>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251107005809epcms1p5f33e9560755367f0ba4b7df82c87fc85@epcms1p5>
X-Authority-Analysis: v=2.4 cv=bOgb4f+Z c=1 sm=1 tr=0 ts=690d648b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=40jZUBKxUhFIhurt5UIA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: HJqS9YB3vbCV_j_BFhlcl9Ulej9x0u-p
X-Proofpoint-GUID: HJqS9YB3vbCV_j_BFhlcl9Ulej9x0u-p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDAyMyBTYWx0ZWRfX0Ishb6jHdbi5
 H9ZKaccShjL83UasstrPx4cTpPRmQ+1M3jAmgrPYNGiZJ9sm8tDUWhtbKk9OZsurlRzodf/l+M+
 LxROyb33ZkLfej7wg55fzEQJRQEul3d/d2GvrTplrCtK7q3qpiXC9oSYrDWOlRhXRPkKF31CqTr
 DHA8xjjzi2nfc5xqqSE3WXf54zFm2O563r8seZohDyJxuzSkMe38GU38kECWt4ouE8o9zZ1amg3
 Xdshk5pYn6Gmi5Pv+dUkgC9XmnV+fDNDnMaDC1JqUALyH0v7nt6a8BlfPc8IL1722I67y46M1a9
 jo0rX5X7BZ8XvE9tIzsV9y3k5iBxhTXrpkpX/M7RbWF9txDhe+LdxpA4PIV++Gyz9Wnzk/IaUEO
 EaW/dca+0vqtjinWjLxjDtfDzTKIZQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_05,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511070023

On Fri, Nov 07, 2025 at 09:58:09AM +0900, MyungJoo Ham wrote:
> >Sender: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> 
> >Date: 2025-10-31 03:26 (GMT+9)
> >Title: [PATCH RESEND v2] devfreq: move governor.h to a public header location
> >
> >Some device drivers (and out-of-tree modules) might want to define
> >device-specific device governors. Rather than restricting all of them to
> >be a part of drivers/devfreq/ (which is not possible for out-of-tree
> >drivers anyway) move governor.h to include/linux/devfreq-governor.h and
> >update all drivers to use it.
> >
> >The devfreq_cpu_data is only used internally, by the passive governor,
> >so it is moved to the driver source rather than being a part of the
> >public interface.
> 
> Hi!
> 
> Could you please direct me to the governors or drivers needing this?
> (Qualcomm drivers?)

This has been prompted by the Qualcomm KGSL driver:

- https://github.com/qualcomm-linux/kgsl
- https://github.com/qualcomm-linux/kgsl/issues/11

But I think this issue is not limited to the KGSL driver. Other
out-of-tree modules might also implement device-specific governors.

-- 
With best wishes
Dmitry

