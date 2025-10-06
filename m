Return-Path: <linux-kernel+bounces-842797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DE4BBDA1E
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 12:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6D5B534A391
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 10:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14CB2222C8;
	Mon,  6 Oct 2025 10:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NAtN7DHy"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2E5221FD0
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 10:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759745417; cv=none; b=jyTV2Yjh0u6fPtJF9pcp2moqvQDrPnLzwKPUpQbbKGdMrloAXO5VobgWaVee+GNvjssAaBE3zI+ATwVdUa07T3PStLWXPg3uCUsBfqy04sxL5eN5reqcSm/8dG8Tw0QTQSPE06I4jKLa5Q3hn50HmagyLghnBIo6WTF6GZ9MgXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759745417; c=relaxed/simple;
	bh=U2IfsPJIglZbNLha2D9xYquVHVAKAm7qePp4wABBM4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p6iy7P9oFIhLIDxvrvf+8cl5H78BR8zEiC0XOpy3Ycj+D3briEeHDMD1Gm3IGK/6C/+l+V8rPh1YsrZSn6d/JJt0fV+qK85NjqD3/XaiIq4ZTjBQaZmTlaJCNnZgnFvnUEvkVslWLlPRXmch7cfpFnCiYhzaeF0xOvOrEgR1/8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NAtN7DHy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 595NM3Yt027568
	for <linux-kernel@vger.kernel.org>; Mon, 6 Oct 2025 10:10:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YQ9JTnhy7/VFugNTC6R+z9mSCDzzqwGBYOtYIqduWzQ=; b=NAtN7DHyq3ZwfClP
	4BcHB4FvWVWkddyQhEj1JSJQ1NI4EV/Xg5kV44rS7aNrWzfVxun8QvSl3tATi84o
	nTeNbr4AXqu7YGel83kYMryezB3tUzENWb7p7o9Z1KRJ8LbE1UDKMI+5U4iFYLtz
	nm5OELZyVYoQDuHh23ao29jFFhX048LzURZ6GEnuW/U2c0hiDL+KkIGqVhCed+aH
	5Wuq20ccJqcby2ltn4U1YLD+j6tLYWjngzqxXZpCKHvIM2J5g8KCGfzHvL/YT17H
	WWDVY/oKXA4cbVVNTGzEa0Sy8FC5xCZk/ClEUyGyEnE7sruPkDqgEyZWBoZAbyKO
	vEWGmA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jut1kg8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 10:10:14 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4d6c3d10716so9054961cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 03:10:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759745410; x=1760350210;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YQ9JTnhy7/VFugNTC6R+z9mSCDzzqwGBYOtYIqduWzQ=;
        b=TIeSa36waYQLp4XDc+WxRVZoexKqJ1wWd6x3vzhCGmNbFynOXuEVFpNETeTc023Lig
         BvkzQsAdZByrTQ0eTHk7mC+MWEyqf+3pA4CPtdlXfP9djhdU14E3sgrf+wPUgUyjiMPX
         /NrX0eFnJk2ACWgjklEldlTMX/+5k6WXxTsmgq6Ry+ypXYen1fbHOdGL6cV+d5cVfw+f
         +GEkB4s+PKgBrPbZ1Aica9ZsG91GxX14g3C/Ivxu45x5hYbY3Ks/u+xrklkeclh1/Zu7
         GJS10ysC6bVxHf+weRqtkkaX+cE+7EtcttvyWBk0Fxyr4abZxEiV5a0KHSJaT6mQY01w
         atcA==
X-Forwarded-Encrypted: i=1; AJvYcCWW4n3VezH6O/PiFqHOgzLDimX/ghXukqjwUhr+xN3/HU3Cdn6nm1Iejk2dF+7Ya7QyiyT1KRMWbqx9MDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvA6v8hd3W01awdGGTR2Ycs74gxmHajTOdpM9IKnmcaDk9uGtx
	Xsd9hA1H6sw4Rmbb03WzGKseuyyi6wsgoQ0c0DK3udcwaHMfcPmjwi9HDylZlWqZ3dK/itJfaYL
	HE1I/sqsRITEFdxOTsnKspDom90FyDG9qrvYMXSLngzbI/pGa1B5r4iSV7z7I+Bh+NqY=
X-Gm-Gg: ASbGncuRmEeGFBwFrQX2YiJeetU5SWmjxiLG0ZShaWbEaOXUspUlrLZkck4I4gYwZp/
	5zbgsV8MF8BbCcKWO4GEShkZZZp5IFIsE27wtzzizMbBhGXgXlFuZRl200t4Sf0gh0tvlX88KJV
	mUzfCQuud+qgEujj0BLl/YjlfYaLvZ2vOgTAP5cSdoGJEGQkHPjO027P3Ge62WulWp+7ms7gUug
	yK5kcWJM98aPJRIKxTXEyXUbtTaZHU3cqovEIjoLFudxCf6a9edF4yZxMquJCLIWUR4p12K/TuB
	hRRms8ixLyfwDqEi4gvCxiG/qEE9dgRcrEpKxq56Z3gwvpKbih6xibRw5FsspCZVTgRQYNRSQe5
	32rDmO5GSYh8/ktbyjUMXiO5L54M=
X-Received: by 2002:a05:622a:60e:b0:4d8:8b29:228a with SMTP id d75a77b69052e-4e58cca7939mr46373611cf.3.1759745410316;
        Mon, 06 Oct 2025 03:10:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkIaT5uOBugms5gwERrur4Q5H8ZrUny5IMG2QAlBQl/ctjJPOfhlmFXcEGWS3cXzuKqN18GA==
X-Received: by 2002:a05:622a:60e:b0:4d8:8b29:228a with SMTP id d75a77b69052e-4e58cca7939mr46373061cf.3.1759745409696;
        Mon, 06 Oct 2025 03:10:09 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486a174a6dsm1115628966b.90.2025.10.06.03.10.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 03:10:09 -0700 (PDT)
Message-ID: <53aafa84-6d6a-4963-827e-c1600270662f@oss.qualcomm.com>
Date: Mon, 6 Oct 2025 12:10:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/panel: Add Novatek NT36532 panel driver
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Junjie Cao <caojunjie650@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
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
 <20251001135914.13754-4-caojunjie650@gmail.com>
 <lfdhib6a7ct36nmj3of2setjft7ydrf6sfgtx7qued7qd56nhc@2xol3grm5re7>
 <e36572bf-4fb4-425e-8d10-c5efa5af97f3@oss.qualcomm.com>
 <rxm67cbwkp2qyxdlgqb3fz7fhiskmnhidhjvl4mhqn67iq2x4n@wfueruiiq7kp>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <rxm67cbwkp2qyxdlgqb3fz7fhiskmnhidhjvl4mhqn67iq2x4n@wfueruiiq7kp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 5s6gaJaDsZwGmu1Li6YMHz09qOdpAuzK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyNyBTYWx0ZWRfXz0+jOhrCi3WM
 GIfO1TbTt9tZ3/VvgvqH4uu9riYp8dk1eeuqJVFomZ6cb6i4Bt6AaC6zoDhrT5GNmdjaiZjEpTr
 DPYIQKXpHIlbKOdBb+tSnTq+wuV/LKa3vDE0SifY7lyrF4x6ju9B/l2eNfrB2POvBRZwKd9uv3L
 bGRQxNRA0qWNBwClOzYgjBFlyAMFBQacEWu5cGFrx/dLgt6+Hd0tRazqMwm4tbMJ8wQq6mmjCjz
 tnk8YNp08+phhHcjxFn/N0Zr0t2jfk5BGFseyBNV4leRnBZY4Atz3v5Hzvah/lzy75mChqgEoIn
 TypJmbBW3q4/7M/YCsCGgi6A53SKtj4wV4q61ySDoMPByLIMmyv9NFLYh3wJfEr21tW25MIf9yM
 N+3VM77WiuUbtMDA4L0hQt8QnjTTNQ==
X-Authority-Analysis: v=2.4 cv=Vqcuwu2n c=1 sm=1 tr=0 ts=68e39586 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=pGLkceISAAAA:8 a=0RrB5Ro-Ny3bBzvrWzsA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: 5s6gaJaDsZwGmu1Li6YMHz09qOdpAuzK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_03,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040027

On 10/6/25 12:02 PM, Dmitry Baryshkov wrote:
> On Mon, Oct 06, 2025 at 11:24:35AM +0200, Konrad Dybcio wrote:
>> On 10/2/25 4:04 AM, Dmitry Baryshkov wrote:
>>> On Wed, Oct 01, 2025 at 09:59:14PM +0800, Junjie Cao wrote:
>>>> Add a driver for panels using the Novatek NT36532 Display Driver IC,
>>>> including support for the CSOT PPC100HB1-1, found in the OnePlus Pad 2
>>>> tablets.
>>>>
>>>> Signed-off-by: Junjie Cao <caojunjie650@gmail.com>
>>>> ---
>>>>  MAINTAINERS                                   |   7 +
>>>>  drivers/gpu/drm/panel/Kconfig                 |  10 +
>>>>  drivers/gpu/drm/panel/Makefile                |   1 +
>>>>  drivers/gpu/drm/panel/panel-novatek-nt36532.c | 437 ++++++++++++++++++
>>>>  4 files changed, 455 insertions(+)
>>>>  create mode 100644 drivers/gpu/drm/panel/panel-novatek-nt36532.c
>>>>
>>>> +
>>>> +static const struct panel_info csot_panel_info = {
>>>> +	.width_mm = 250,
>>>> +	.height_mm = 177,
>>>> +	.lanes = 4,
>>>> +	.format = MIPI_DSI_FMT_RGB888,
>>>> +	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_CLOCK_NON_CONTINUOUS |
>>>> +		      MIPI_DSI_MODE_LPM,
>>>> +	.display_mode = csot_display_mode,
>>>> +	.dsc_slice_per_pkt = 2,
>>>
>>> As this is not a part of the standard, what if the DSI host doesn't
>>> support this feature?
>>
>> Shouldn't the core gracefully throw something like an -EINVAL?
> 
> There is no 'core' here. Each DSI DRM host manages DSC on their own.

drm_dsc_helper?

Konrad

