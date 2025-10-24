Return-Path: <linux-kernel+bounces-868498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 332D2C055CF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB253403B53
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5B630ACE8;
	Fri, 24 Oct 2025 09:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QguF7XEk"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93754305059
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761298111; cv=none; b=JL40C2sJ55/pUWHS5txNX59JgqRZ/UjB9up/1h/5DzTw1lHbos+HgLUZu8Pt9h1cAqt9cRBNZus7ZpgFgvZem9maF2TyMu6yJzRYothpRzbleL5IaHxUYOUAQpcPzH3HFxCv8QFuDAzHvmx6byDYi4o+7SHNm5t368DizII3GIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761298111; c=relaxed/simple;
	bh=TFs+uVk9VsisYkzT24JB2Gdh5pdgQe8tuorJAcqAzXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bG0kiuBhk+IMIV1bQiLyzD1u0fMQexK+Z0+Dijp7orRjeDxdxObYy3uDb+6RmF30PArKPGQyVMFn7qwI4n0drbwWQJyuo8LDm0FcOFCoAgNFTWWy5YBmnWnDWd62ARX952ASWfZqeTFJIYQe2Rx8IFFC0doNWeuTkkC/HGvKVVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QguF7XEk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3FZim021586
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:28:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=zGkcT0F5HdfRvmdgOmrFrIfL
	DkdtJXkgEZhfMIxuKyA=; b=QguF7XEkUeOh2E3pknh1RhOE8KhIQT1c2uP+IQ0G
	zX/1juHpOOEgEAb2n5P9kAUK8s7h/r/ztfyqrAjbkoZDG/QlE2jUapvWcUZ7+01k
	IpUUGvjz7ZBKuL/vEafSBXLPqVZcft/UJlDHrY8ogrgd3k31WJtotb9RXel5w+Nt
	0crZWgRXZMURhLZDg0xZO/c80EjdibmbPGGwqO2U6xm/OYF+YCV7jsFsFGDsE0y1
	Sd5iNhe+3glckfGyogGvxX912c1IsECwYnzbfIdVZ5jeiv5/5N9uZFl1zWzeRAQi
	OCxz2WyWH1NVxvk9mdU6hMl5AP8n8YOg7e4YzonE6ynTCQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v1w8bgne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:28:28 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e89f4a502cso51179421cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761298108; x=1761902908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGkcT0F5HdfRvmdgOmrFrIfLDkdtJXkgEZhfMIxuKyA=;
        b=fHcVQG3AAd2q/P6WbkMPSZoFOGWjCrRog+l1SlFKSn2je/DtJ3i86dZrNxCZKAe2vc
         xxeIWK1dU7kPUzaCb8/9J8KdXWmH1dZH4KZK0t6/cAD6GryIK17X5Pm0bbYhN1raZios
         0DA2Of/D6giYwojfPH1rLTDfe6lg2G1LzFr4OAemTgq4ACI3M52SUZBjfyVo8Lp+xEfN
         wh3g/r+wvigWp39/+QOHI7ga8T/sP0zTymrb7+eOYspXrp72/7GyiHq1x413awlHkGXI
         dnA08xYFSYzYqQ/8gOtX3mK+YvZabf3auOmM4LPua5IgR6INgSwb1FZ9hRspvod0JgCj
         VwAw==
X-Forwarded-Encrypted: i=1; AJvYcCVkX/0GU7QJ1omfIZFDfSG1yH/Ede1JMTqiuEO7QYKZk9XVUd/NMKeNKjBMl9l+B/SyG3Cltxao7rxoLu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXLCVKsrVLXirIVDNheekYH4Z9zBCyHGeQ35Vli8GSmLCoKM9l
	BCNktk2MuRyaC46D6YiQHJukwFsgF4OYwpeH6wjtRjbippjA6gypN+Z19UIOY7Aq/xbGEZpFZMu
	h2I3u0IlI91dghcp013XcPTQQdyizHajSJpZYa+2avBA/7YBdYUL9quJXHUG56z52nmI=
X-Gm-Gg: ASbGncuR6fmdeDNNTGDID+h9GRJBHVkxwMqtL30ac6ZTBGaYk6a8yYQAUYdaThioeTP
	/nP1pwWKVm6Ff3K9gOKc0rbvdNhJDPihw0FwawGrW75XGPYU/e1isBwKgx2E14GQ7Di58VTvqmE
	1/pbCjEqFGfsgvbtWuZtV9OP9zVjIXRA39OegMlwZX582WoXdyF+JUdkuRM5+NHpdJXFx7JcAC0
	T+uObvwtO3pyzOkCFf/AGwXpMK62SEBBHjoPrXZqmxkSAJkd8ewu2nlXHZVgAAxr356pgUEOA7t
	VjTyynUj1fn8KjfNzSPVuCS0gZf2nwWxvxbXhXstVLd/rSyH4dYIRdhY65BLAy3U+MMp7eZ3toU
	F/Hoq5NXL5B3W/LEPbhVqIuRYHMqHfXGepIPK1oL3X3vHyK901Ok1rwRaiT+hY+zLg7h6QQcfXu
	Y9q8+GQ/7u8cs8
X-Received: by 2002:ac8:5881:0:b0:4e7:28c4:6492 with SMTP id d75a77b69052e-4e89d2e9159mr345062021cf.35.1761298107579;
        Fri, 24 Oct 2025 02:28:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGg7yl9p+wm1YmrVjaFh115CT4BHZ4Az1ybfHc7KF6ROWYFgbMv01hIcBHSAkMse1hgWxSIKg==
X-Received: by 2002:ac8:5881:0:b0:4e7:28c4:6492 with SMTP id d75a77b69052e-4e89d2e9159mr345061771cf.35.1761298107121;
        Fri, 24 Oct 2025 02:28:27 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-592f4aded51sm1489790e87.23.2025.10.24.02.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 02:28:26 -0700 (PDT)
Date: Fri, 24 Oct 2025 12:28:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH 3/6] dt-bindings: display/msm/gmu: Document A612 RGMU
Message-ID: <qcs6y22hozfmb2ipmahfw25m2xti2gr5kjn43c2woiueqe4xmd@ovnrhwibhhe2>
References: <20251017-qcs615-spin-2-v1-0-0baa44f80905@oss.qualcomm.com>
 <20251017-qcs615-spin-2-v1-3-0baa44f80905@oss.qualcomm.com>
 <8f3f4874-2e82-473e-87bd-e3bd58089b90@kernel.org>
 <181af756-09a1-4694-98c4-53cea556e172@oss.qualcomm.com>
 <ff37b635-b3dc-4180-8eae-e798ef6ce55a@kernel.org>
 <f677f8ee-d635-4131-8ee2-8ca6ead43095@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f677f8ee-d635-4131-8ee2-8ca6ead43095@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxNSBTYWx0ZWRfXyR6eBISF6nYv
 b/scmXSwGmL7GCyaJ05WEV6c7nuG6j/6VHBbqPigdsYPk4lpYZymcKwbzck05fzuwJiWaKOY/04
 9fRRlQcdHbHjch/x1pOT9cBtMXC5e56KOoGj7FCjPHLMVGOjCvlV4L7/unjGa99DLXUVfm0A++c
 Xg16EL8fa1rVzoybl9OyOiCtvE6xixMOOgL70bITThodH5Rdqb9qMvv7DqdtDz5Rdyr+f2xNUt3
 HB0oHIFvSZAPzfNcUx3++dthCQ/8gpHp44+Gl+a0FG0DdUMbUwocnj+JIeUJ48ILDlBxhHL9prb
 47UZ8E45/+m0VnhAqVMqNqqdd1sHogv+1xK8kvBR2jn2lE90YMeUUlGMQbP7XPJMsxcxB9U69RQ
 Vo9BXK4HCuyGI7xq8kjnAYrTO8wuDQ==
X-Authority-Analysis: v=2.4 cv=bNUb4f+Z c=1 sm=1 tr=0 ts=68fb46bc cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=QZfYkoQWqmGXo21g0SUA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: JuUGOfPkcwQZOvGan78kNM8DCidevd9a
X-Proofpoint-ORIG-GUID: JuUGOfPkcwQZOvGan78kNM8DCidevd9a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180015

On Fri, Oct 24, 2025 at 04:33:28AM +0530, Akhil P Oommen wrote:
> On 10/22/2025 12:49 AM, Krzysztof Kozlowski wrote:
> > On 21/10/2025 17:51, Akhil P Oommen wrote:
> >> On 10/19/2025 2:43 PM, Krzysztof Kozlowski wrote:
> >>> On 17/10/2025 19:08, Akhil P Oommen wrote:
> >>>> RGMU a.k.a Reduced Graphics Management Unit is a small state machine
> >>>> with the sole purpose of providing IFPC (Inter Frame Power Collapse)
> >>>> support. Compared to GMU, it doesn't manage GPU clock, voltage
> >>>> scaling, bw voting or any other functionalities. All it does is detect
> >>>> an idle GPU and toggle the GDSC switch. As it doesn't access DDR space,
> >>>> it doesn't require iommu.
> >>>>
> >>>> So far, only Adreno 612 GPU has an RGMU core. Document RGMU in the GMU's
> >>>> schema.
> >>>>
> >>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> >>>> ---
> >>>>  .../devicetree/bindings/display/msm/gmu.yaml       | 98 +++++++++++++++++-----
> >>>>  1 file changed, 79 insertions(+), 19 deletions(-)
> >>>>
> >>>> @@ -313,13 +360,26 @@ allOf:
> >>>>            items:
> >>>>              - const: gmu
> >>>>      else:
> >>>> -      required:
> >>>> -        - clocks
> >>>> -        - clock-names
> >>>> -        - interrupts
> >>>> -        - interrupt-names
> >>>> -        - iommus
> >>>> -        - operating-points-v2
> >>>> +      if:
> >>>> +        properties:
> >>>> +          compatible:
> >>>> +            contains:
> >>>> +              const: qcom,adreno-rgmu
> >>>> +      then:
> >>>> +        required:
> >>>> +          - clocks
> >>>> +          - clock-names
> >>>> +          - interrupts
> >>>> +          - interrupt-names
> >>>> +          - operating-points-v2
> >>>> +      else:
> >>>
> >>> No. Don't nest multiple ifs.
> >>
> >> I guess we should split this. I will add a 'required' constraint to the
> >> rgmu constraints above. And apply the below 'required' constraint
> >> specifically to 'qcom,adreno-gmu' instead of the 'else' fallback case.
> >>
> >> Please let me know if you have any suggestion.
> > 
> > Maybe the binding is getting to complicated and RGMU should have its own.
> 
> There is just a single chipset with RGMU and we haven't seen another one
> in the last 8 yrs. So it is very unlikely we will see another one again.
> So I feel it is not worth splitting this file just for RGMU.

I'd second the suggestion to split the RGMU schema. It's not about the
number of platforms supported by the file. It's about the clarity. I
think it would make the file easier to read.

> 
> Let me send another revision and let's take a call after that.

-- 
With best wishes
Dmitry

