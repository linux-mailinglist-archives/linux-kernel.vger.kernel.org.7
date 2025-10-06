Return-Path: <linux-kernel+bounces-842738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB30BBD6E5
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 11:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 272624E8D4B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 09:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2768B266584;
	Mon,  6 Oct 2025 09:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bs0KoP7E"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066B5264F81
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 09:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759742683; cv=none; b=T2/yJFuVxTqPTXmFgdHl35hKgtoj0Qy3aZzfSbtwvr3sB7NWCjIk/Sd3eWfOSUR2eqMTIFWKOW1JD0lA3eiYUy27TipRoQvfpmL+GvZzeUaPQ+T2/q1sBl4xLDhPVzUK0aTv8e743tmBWeTbaOL9YsfZgelEa5yR5/zTiW6uEco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759742683; c=relaxed/simple;
	bh=O0X2ZfnMKmoIXo7tD5JH0yqo05yq+8eSnXNsYS1076Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lnJcMJhZc3YVXBmvYkDDFJ/PhWyxb9BXStqMMnaiYawFNg297uW6mFnsAqvv7wXvy8aXGnW/lIKerf32Smbv2yDdmaV9DIFnFD8aYOGE5eeel1XPqfHq5wqvR/SegDzhHs6Ycn/oRCKkfHevvuBTJf8yvktk1s9kE+bYaIoYblc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bs0KoP7E; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5960sqap017754
	for <linux-kernel@vger.kernel.org>; Mon, 6 Oct 2025 09:24:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7K60QlJ82w8jj8i5uoLYN3GzdWOEyO3RBRWLo+2B9Oo=; b=bs0KoP7E4K2DZNRx
	c80iuQ/mm/ori1OuEZ5GuVEAym6B5UN+EQuyacoX5uROpeqXpCBFywcg3K/kknI6
	wOtqPLjNhmCoRphtuvAXQSe2OUsoZRQKif/xM8lfEEFtcaZHgMc5CMW7hq9aW90T
	R6ATtYgEjtRkbOJI7KaD/8K8U8GdIOxonMLySv8yqIvOzdis1lVWsHMq8Z1FDEkK
	WpucnlZlA7lmiScLUSROhosWOIjP3rvPvxTCzkIUEmX+JoAHlyPZCk09gVqvpwOS
	QKhylzGrgeH1PsUfec9YxCopUxWCsTXwTBUbgYb7cDeoyBmrslQFjrCifcC+j0kA
	82X2/w==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jtk6uhd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 09:24:40 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-7abea94d621so10553296d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 02:24:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759742680; x=1760347480;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7K60QlJ82w8jj8i5uoLYN3GzdWOEyO3RBRWLo+2B9Oo=;
        b=S1cQsKdGOF7NIH5sJf4/gCf+3Qee+MTAHAH4H9pLzB/59zKI2aHN8C49E0/qO5QnHO
         oNT58QTJ1wHq9PsiV9nGOPoj7pTNPzwmO9Brb5b6TkJswVjJYs7Z9sM2HvaKv9Eh8rXB
         ZsgoVqK0WN26yROO4BNkW/Nmpnvpp73jP7nLEFMee0gTMK8SwJv+v3ibe4QyQHiz2JL1
         VUXRvtj1cWxScKTtxRsi3OjSFb002j5CKZVtzthGDg1cvo/yOaLFLM+Cw9ZaH2mD77BD
         TSTUTdEF4ee5AL1g1Zz6djPSB7wUn75JVAvpC+duluaFAHuzGPQkTljAzflGitixwBHL
         Ezqg==
X-Forwarded-Encrypted: i=1; AJvYcCWWdwCJw9LTytRHYWT7tVneVV8qWeae8TNLrk3B+MkGOHZyAD4giRObn8KpRVCFFLOrbWI7tCUEIL+xdk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRE5yNGGgt6hTz8KFmE+bmFy7Hi4dImgk7llQdyErgBrt0bg9F
	g7RHPL6CymeiXTslZxSc0O97TG0Zc5r4jQJ9pZL9tYQmzDzntfPUExShSS4vtqUbN3G/uAb31xj
	JbMdElCH9pirMJAThX8/MZEwf2gsPuitusz0O1HYBzBnuNasOchlCY4ntcf2nSgjvLNk=
X-Gm-Gg: ASbGncuf2NO2PmVl3XV67LQkguYosfITEcsnkx/IXp/zqjGt8qoI5V9BSHXAV4gB9M4
	8vWcrRbZalJ4jeUgSrwnGLfGgIycT+LLO4dvMDVfvuboPsxyjYKoWDzkF8DLDlzStaAfHRVaQzu
	fIlGIbF2RODW0BIwxt5V83VM3Apft0vCVrjwzerjCEYuXO4LIzh3josni/vqcmGosFje337ZhDA
	/FK0Sch5FJ27hjtAmkUItJPQ0UfVHnVJ7KD3yfp8VDoL3UKDnBCXZGelAI79DrjIrWXqsuU0+Tk
	WmEr6Er3I89KD2IObrOQO90iLkIA3BrdCYb9Cvy1PWCtK6DyN2Ebg8Z230WJDi30w2YbKdIAw3E
	+WlIneH6fliyIGo2UNnFqMKF0VhM=
X-Received: by 2002:a05:6214:2309:b0:784:4f84:22f9 with SMTP id 6a1803df08f44-879dc8cad86mr107666216d6.7.1759742679790;
        Mon, 06 Oct 2025 02:24:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHp/ysV59MYtgw2kvE1S9hkzkaZeuT8sanAw6VLuCHYzQ6S4o6+kY7M3XEpDaiVC+6tvUGVqQ==
X-Received: by 2002:a05:6214:2309:b0:784:4f84:22f9 with SMTP id 6a1803df08f44-879dc8cad86mr107665946d6.7.1759742679281;
        Mon, 06 Oct 2025 02:24:39 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6397c9355c3sm3510239a12.0.2025.10.06.02.24.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 02:24:38 -0700 (PDT)
Message-ID: <e36572bf-4fb4-425e-8d10-c5efa5af97f3@oss.qualcomm.com>
Date: Mon, 6 Oct 2025 11:24:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/panel: Add Novatek NT36532 panel driver
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Junjie Cao <caojunjie650@gmail.com>
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
 <20251001135914.13754-4-caojunjie650@gmail.com>
 <lfdhib6a7ct36nmj3of2setjft7ydrf6sfgtx7qued7qd56nhc@2xol3grm5re7>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <lfdhib6a7ct36nmj3of2setjft7ydrf6sfgtx7qued7qd56nhc@2xol3grm5re7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxNyBTYWx0ZWRfX9rpC+sNwCXS+
 9RElNhFzOrMHuN15zci6/YiFm8hr4+5qyHOiFfGMFPuxogz+diZRYSDplBqF9MVcgXseeX20BLr
 pqdxbDS7nLaLVhk4ZZ+DssxhdEDK505YB5PBprGGFn7J6rZTkujsQc7y4isO3x7AMULoFXqLj4Z
 ufq50I+4KxiVIVcOmE1eW76blE0n8hv5wyvc4fjhD9yUT+01MNZ8yp1SlTnk9UNx8SBBrB5dAuL
 wBk1FVQwLPpPJTr5F/7OxjILQ/+2pVDYRfQ/1GkeKcrs4rw6ZZp5VBUiBf+oCyqJtjzo7pYmCet
 KraRhpOnePboHpPT0x0cJADThCiU92Gfn7uBGkvSm/JzuNZ+afNTS+y6lnkbHvZUZZBw9E7CbHU
 FlUwg8HKaNUXYfC3Bg+YLDK68MxGkA==
X-Authority-Analysis: v=2.4 cv=do3Wylg4 c=1 sm=1 tr=0 ts=68e38ad8 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=pGLkceISAAAA:8 a=oCkFgi9b2cravLXa5egA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: 1Iwb4LXD3qVxjZL53q7yIzSY6Q7ppSr6
X-Proofpoint-ORIG-GUID: 1Iwb4LXD3qVxjZL53q7yIzSY6Q7ppSr6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_03,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040017

On 10/2/25 4:04 AM, Dmitry Baryshkov wrote:
> On Wed, Oct 01, 2025 at 09:59:14PM +0800, Junjie Cao wrote:
>> Add a driver for panels using the Novatek NT36532 Display Driver IC,
>> including support for the CSOT PPC100HB1-1, found in the OnePlus Pad 2
>> tablets.
>>
>> Signed-off-by: Junjie Cao <caojunjie650@gmail.com>
>> ---
>>  MAINTAINERS                                   |   7 +
>>  drivers/gpu/drm/panel/Kconfig                 |  10 +
>>  drivers/gpu/drm/panel/Makefile                |   1 +
>>  drivers/gpu/drm/panel/panel-novatek-nt36532.c | 437 ++++++++++++++++++
>>  4 files changed, 455 insertions(+)
>>  create mode 100644 drivers/gpu/drm/panel/panel-novatek-nt36532.c
>>
>> +
>> +static const struct panel_info csot_panel_info = {
>> +	.width_mm = 250,
>> +	.height_mm = 177,
>> +	.lanes = 4,
>> +	.format = MIPI_DSI_FMT_RGB888,
>> +	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_CLOCK_NON_CONTINUOUS |
>> +		      MIPI_DSI_MODE_LPM,
>> +	.display_mode = csot_display_mode,
>> +	.dsc_slice_per_pkt = 2,
> 
> As this is not a part of the standard, what if the DSI host doesn't
> support this feature?

Shouldn't the core gracefully throw something like an -EINVAL?

Konrad

