Return-Path: <linux-kernel+bounces-850242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C3EBD2552
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5477D1884D4B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537602FDC5F;
	Mon, 13 Oct 2025 09:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TzRKij5x"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB532FDC37
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760348388; cv=none; b=Nc8a988kPYKjf6huatLX2FghFIiTJ0bucPVguJX9d7xhBdqHTCBEkCMmnH/iLrcuInHX5aG+tf9EVEILzvNgljWf4YE1AfG99JzJiC47NWLvxyvhk+mQ2RQJm+KhCxwjzjYxGTDPhwL3PbdH6gD0dcUGaf7W3VVc/g/rdi3Ul64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760348388; c=relaxed/simple;
	bh=q62qPK2IJ3ohVM5LL7rI6hahFz9XXHlcjnl3rDVnSTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cw/xPpCZBtuzH9wuWD0QUi9UaxfYTBJ4yI71ev/nywP6y5EJlfuwU4Jyg0QKB4L7V9jTi+FVgEotTpWQjhcc10Q3CHgGbBQgH4CjNUKZX5sakhj/CHR5Ais1qwrdLxjtJJBRcC+LNk4MDDcjcwzDLbSiRpUgnQMfSaCqs2FGPFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TzRKij5x; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D2n5ZE000691
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:39:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ki9AQgeDXinhOnoOYGE+AX4oW0J7Rlumps/zQJrNlB4=; b=TzRKij5xeqn+/NlA
	nekBdq1Q7d0MtPY721CSvhlSbUBNCsvRqeVXsYhh2Zfo92aBIyphy0KikGMIrL79
	iyJk8QdkZqsOJaaesucDhuIkqf+gcr23TbZJL9Mz+iWG10IfTMaTcCsFxMHSorqY
	waAOjxpufMQP/fTnZiMYcwbh+EKP7UvcHXi9DjZ/0ldm7EKBMhPywNL7D+ZAmuFz
	JtnC7JGd3NRXcHdFIzJ96e9qcQaxZv4+CZwasPWjSs9g4EtrMjlYX3/zLb3iqOCj
	Cuu6D/uaCRrjMVlRgU//trSm+yvRTctbBABIcDFKOebxryPKt8kElidMzCLiQH+c
	FCG1kg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfd8v435-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:39:46 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-81d800259e3so121518456d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 02:39:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760348385; x=1760953185;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ki9AQgeDXinhOnoOYGE+AX4oW0J7Rlumps/zQJrNlB4=;
        b=aAQC3gecP6pz8ymLpYm1RuQgEpcLMXfojxY6KadimhaWzdjMuIzvjZa1iVzXvew2Xa
         7g1p1bf/ofHJka+7ltxUP3/678aD7MmYs4EMMwSWfqXo5gSzsgX3WyJtJlXkx5dvinaX
         OysW2i0RudY2CGGCOQhOVjr5cMOmIQh9c4eJ+l1H3IBm2jmQZ+WeB2A63nUMqjmMgJfY
         jSoKmREkMZ/+1R2TDt/0EqZeQjzQchyMyFW9JP+XHG3+do3GrGFqVjyoKk7X8HBpoI6a
         KPd8DDerOmx5m49702HolL1VJFcg1NgNEfl/x88t+bA3GTskmVlHJ8UnvzANVGG+hUai
         HuXg==
X-Forwarded-Encrypted: i=1; AJvYcCXMppZLVmlVEYwbgd0aTNakaS0xp3xH9bHWd3Ib5ZfAmLJcZxV6AjudOSzXsqtTT7uDzTyp1UuIhjBz87Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZBMcgiLEr+z2BFnsTseyPjPwGaX4HatytHfSWqbHRk7fmNnVv
	6ouG23P0C1T6E7hvzGEXlIftqoZrWcklRM/W6+K8zlwz+xUrNEhS1mgmUS44xeufi9072nimhmM
	vCOCrE8u+AoVDHNb3SrYsq6GBeBQCdT64EnfwrTAQ+Y6P9V4fo4CFl/R+PELvBdM4O8Q=
X-Gm-Gg: ASbGncsFGZYHWxghuGqqHh3//Lic0Hlw2S+nHMYnf+YbEEnlaBg04Sp1ydLAD4sOQrm
	a4f7h3GGB80Q64H1wGTve85hSznmS2nVn0KaLdgM6fuQA4vQNLq6hPrDZq66v7y2tQtWNHw2irA
	X5mbWHKWEr18Hci3EBPhlG0Xsrt5tnjDrXbrFAn2emcGI7mA7D51NS3BFhffH6sTYtK6zSjI6Ho
	wtOxF212C4QZhjg1/rv9vmsbcm3Vp+Hq/R4Fl/Lgg8UQNXLnt1EapPXr1FzJhTmZW2QwZ0x/nCM
	DqDJP5EEgLDzlK5oaTtHV0zEXt4eti+iKrm1k2QtrO21L1APgFlvd98yJbirzo6H3zdmCSS/MHL
	WnbSAERJ6D1NqW1Had9YTfLkwp22MfsUVWs7tcc7e/gvkZjJcVGBddgSIXHNIrUYjOM2GV6vI90
	+N+9pDaJ07h1QzHiv6Mw==
X-Received: by 2002:ac8:7d43:0:b0:4cc:1ef6:9c07 with SMTP id d75a77b69052e-4e6f5119a40mr214016091cf.60.1760348384664;
        Mon, 13 Oct 2025 02:39:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4qJbiYUTKZIv9sgbRJV/j0WU8jqQvzg61vG6N3jHMvsEi0Vl1Fk4PGWY1LSWVGJDhtbnwHg==
X-Received: by 2002:ac8:7d43:0:b0:4cc:1ef6:9c07 with SMTP id d75a77b69052e-4e6f5119a40mr214015911cf.60.1760348384172;
        Mon, 13 Oct 2025 02:39:44 -0700 (PDT)
Received: from ?IPV6:2001:14bb:c8:f7c7:f006:1de6:d998:8e01? (2001-14bb-c8-f7c7-f006-1de6-d998-8e01.rev.dnainternet.fi. [2001:14bb:c8:f7c7:f006:1de6:d998:8e01])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3762e7f7f7fsm29981001fa.27.2025.10.13.02.39.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 02:39:43 -0700 (PDT)
Message-ID: <9cafccd5-35d4-46c5-aa57-1b0b8ec116e8@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 12:39:41 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/msm/dsi: support DSC configurations with
 slice_per_pkt > 1
To: =?UTF-8?B?5pu55L+K5p2w?= <caojunjie650@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark
 <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Antonino Maniscalco <antomani103@gmail.com>,
        Jonathan Marek <jonathan@marek.ca>, Eugene Lepshy <fekz115@gmail.com>,
        Jun Nie <jun.nie@linaro.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
References: <20251001135914.13754-1-caojunjie650@gmail.com>
 <20251001135914.13754-3-caojunjie650@gmail.com>
 <cwgn24f6tnmytd4omr2tul4e5jjin3ijji3ff3qkumqm2xe3t3@ntayu3m5kai3>
 <CAK6c68jBwykcWZm3ckm3nwab-X9Are4rD-eauE4rXA2+XvuX1w@mail.gmail.com>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <CAK6c68jBwykcWZm3ckm3nwab-X9Are4rD-eauE4rXA2+XvuX1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: p-zI46zAdDQgWjO5ZZGNbJvXkLMb79du
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX5ZqJv0bOyn5Q
 /9pR/u+QK765z905A99Q9h+Lz0q789p/1saXfDe5bltbvJwVWPkVYFH/Y8Ts9EL8N8MCl43sRu8
 qt/80LxWgx2F3jltWGJvwe/IPXuU3nGamAfP0DmQFQ6yslkLfsv9PbOWDDAYP2bd+9529j5tfJT
 uTv35guH9WoZLdr2k3uyL/SDSrytmkfFO6SIhFI3FO0IouVVbgT8SxBswJkRJe0W164ECZP4M8/
 SFJ1KxHEE64z+L89nZoueaDP2b2RbRmz/vTQ+tRhyftP2IRc+qu6FGSLMRp/7JLD2U9YZ6FWyzX
 weTdCZTYLGMj8Csd2X9IwJggXp1KJGS18jQLcr41LfD1mNlRQBGVw9sR86KS2zF0RasE4FnVJ5K
 48hNlcEVXy9vTpoMe1dxJ6SAi3MmGQ==
X-Proofpoint-GUID: p-zI46zAdDQgWjO5ZZGNbJvXkLMb79du
X-Authority-Analysis: v=2.4 cv=PdTyRyhd c=1 sm=1 tr=0 ts=68ecc8e2 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=RAbU-raeAAAA:8
 a=pGLkceISAAAA:8 a=tclqJqCaU1NudMZwD7AA:9 a=lqcHg5cX4UMA:10 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=cvBusfyB2V15izCimMoJ:22
 a=JiizpSU_mAIq9zsZDqn2:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

On 13/10/2025 04:52, 曹俊杰 wrote:
>  >Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com 
> <mailto:dmitry.baryshkov@oss.qualcomm.com>> 于2025年10月2日周四 10:04写道：
>  >On Wed, Oct 01, 2025 at 09:59:13PM +0800, Junjie Cao wrote:
>  >> From: Jun Nie <jun.nie@linaro.org <mailto:jun.nie@linaro.org>>
>  >>
>  >> Some panels support multiple slice to be sent in a single DSC 
> packet. And
>  >> this feature is a must for specific panels, such as JDI LPM026M648C. 
> Add a
>  >> dsc_slice_per_pkt member into struct mipi_dsi_device and support the
>  >> feature in msm mdss driver.
>  >>
>  >> Co-developed-by: Jonathan Marek <jonathan@marek.ca 
> <mailto:jonathan@marek.ca>>
>  >> Signed-off-by: Jonathan Marek <jonathan@marek.ca 
> <mailto:jonathan@marek.ca>>
>  >> Signed-off-by: Jun Nie <jun.nie@linaro.org <mailto:jun.nie@linaro.org>>
>  >> Signed-off-by: Junjie Cao <caojunjie650@gmail.com 
> <mailto:caojunjie650@gmail.com>>
>  >> ---
>  >>  drivers/gpu/drm/msm/dsi/dsi_host.c | 25 ++++++++++---------------
>  >>  include/drm/drm_mipi_dsi.h         |  2 ++
>  >>  2 files changed, 12 insertions(+), 15 deletions(-)
>  >
>  >Please extract the generic part, so that it can be merged through a
>  >generic tree.
>  >
> 
> Sorry, I don't get it.  The generic part, generic tree? Do you mean
> the drm tree? `slice_per_pkt >= 2` is seen on the panels of these
> tablets that are equipped with qcom chips. I don't know if these
> panels are used on other platforms, and if it is necessary to do it
> in drm.

There are two changes here:
- MIPI DSI header change
- msm DSI driver

I've asked to split it to those two commits so that he change for 
drm_mipi_dsi.h is more obvious for reviewers and so that it can be 
merged through a drm-misc tree (or through drm-msm tree provided it gets 
a necessary ack).


-- 
With best wishes
Dmitry

