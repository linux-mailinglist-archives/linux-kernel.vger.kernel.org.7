Return-Path: <linux-kernel+bounces-812108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A5DB53303
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 706463AA430
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF76B320CDD;
	Thu, 11 Sep 2025 13:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VS3/UwzJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FB931E0E5
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 13:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757595716; cv=none; b=Eqabpzh4TbnneI75Sn6QyRWJwMN6P3/FO7dQJsP0/tDDShnudGWMeZ0K/RqqnhmoJNwYKs9TqsXSTI1WdXugv0BuQ8uC1Xup7JXaGuY/oCm/5t45xTZg8pqdeNo9nWXOfZC0BMH5vlGMrjLWvESSA4Ggm/w/t3JQTOcM3FyHYNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757595716; c=relaxed/simple;
	bh=ifckRixAc4OgM2DCkMz0AVEhS+7S7pIgBQ2AALYiNdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=arArGhtcHFS0XO9aZOh/m073FneeeXNVu3AhLwywqGsgJAzDqECrmkG6AjZv9BpSnN41H1cA+qGuFGGzCE/E4GpvtOLqv0oSr36giB1xVGEJrMWn15PGmBpjVnoIT0vwaEZ4SY3Euxcrzpd4YD36AlEyZpNCFdvlFLHh2xiBPB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VS3/UwzJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BAUJmj002273
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 13:01:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=020/RT6M8DeqQ4FFLCQkWPxS
	sOM8wzuUhGEMVMCrtzI=; b=VS3/UwzJ4nickQEaH5W6omM0qT27Bne6pWdxtKvY
	kva9j9VxgRpFn3uQn34RfmeypiurpoZPuM4p0SkcaDMU4DzvL7o2Drdm1nVzjeiJ
	w88hamHlP+heFznlo51J2bXy/PZllEaiU9ZAo5E6ejCQqbPxw98E3aSjyrgZxshh
	CcYCwNKOktm9ln+zF0vZluDiGFko6m7v/UjLrIKfaodCN68zRCbMZg4uLrTnFo/2
	kfs1sB1z7EERQyIQtEO5OElUl2SfXEnGAY5VH0ZW00ipKDOZS7kppLlHjd80kOHw
	qGDGPXe6Nrx5U8lj+iLF+ghDo9tYIrzCRQBupCRMvTbAng==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490db8qrfm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 13:01:53 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-544a00d501dso800121e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 06:01:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757595712; x=1758200512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=020/RT6M8DeqQ4FFLCQkWPxSsOM8wzuUhGEMVMCrtzI=;
        b=NPIcLiWWpFy5pgb0F4497XSOoyQSzdhthpjjmNIa58sLROznAEbaI7J5ZDpcJZumwx
         AmHXujAPCXOe5ji8qyAYBETlPyNUydCRm+L/T9LfPCQt36hIwRtMjM3bTgh8yUnr3wau
         QD55f4+YDojhNoP2LPtwkMEo4b1kqhDH1+nokYONmjG3bxJmukB+y9e3mNdKXrYcvg1d
         gsLzm2RAE62acNlpsBdsgDRK89BaFlbemnbHfwQrscBNCfP+tuc9mo25uQgqRWswP6i9
         DnRrHtyMKwo8eMSUL85vfa/mjuJUhcrkAqCZXVFBvpdONj6XfiPAqHuLXWv3IL1RlSdL
         2rDg==
X-Forwarded-Encrypted: i=1; AJvYcCX6RekwWoZIQl7C9HlIiIl1ZsMd6HnO6PYAo1mYqKBpo36YNVRNh7MsEv2rhBLJKZzurry5waz0X6XGsG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCrM/Px70xZr9WQlyK72zXVHLwE4RyOmi+Y+zrYSF20tIFwC0d
	8sdmx7A07CM26A/eOc4ArR7+ody0CZuw/AXlwxmtd4XDSYO20JrjuCYHa+vFVgoCYiivPG9iP29
	+/s3Y0I9MH5DMT4Ax7GwlaKghLxyIGZFx62fYOL2YUaDwQFnwecDMr8tPNsd5Zztl5xA=
X-Gm-Gg: ASbGncsntrmw2Ohc+wJTCeXQLOr4ee2vH0c8lXbY14+M0I6+CjQsS/c2UHHBE7Orb+h
	psOVs4D+5ag7QLx5Fv8Imgfp6prPP0hUUvoG2TIJYsT7sYZH9MsbpK98dGLrnlZvTLIOgO2ONxC
	WTzw60RgKL2GLT8nUx1bHgUAocPE0Lleze7Q6vd6qmbT1jyoIprgUsLEu3tBLfAD4R2pRg8LSTM
	fCPqsoX0aJRyRAuqlGNPZYPp93UKw55oPvi/9yKONEI+GMwJrATd8Z7mbsOwtb/NCyi3wAcTPUF
	bvR4LVSYYhe4wE4Z3BXJ5TGpCZ4yfVDaY8P14ayOie+BYGsEv8q8YxOKxcpEXfDt6fk4jFKiIAX
	Le6sDjhClHOuPj03iNujljM0imbjAQ+JaLU0gEZ2w3duZU4GC+CEI
X-Received: by 2002:a05:6122:d02:b0:545:d9d2:a832 with SMTP id 71dfb90a1353d-5472aeed8f7mr6418838e0c.7.1757595701520;
        Thu, 11 Sep 2025 06:01:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfU5T4Be/8d1NB+n++SlGmSCbRAol8EPaMIXQXmGdUJfhc5omkFmwE++S+Snmx64VOIIOiNQ==
X-Received: by 2002:a05:6122:d02:b0:545:d9d2:a832 with SMTP id 71dfb90a1353d-5472aeed8f7mr6417135e0c.7.1757595692924;
        Thu, 11 Sep 2025 06:01:32 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e65a32f66sm398785e87.138.2025.09.11.06.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 06:01:31 -0700 (PDT)
Date: Thu, 11 Sep 2025 16:01:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] dt-bindings: display: msm: Document the Glymur
 DiplayPort controller
Message-ID: <mgbv5zoptfox664jswi3imvibrd7d2teazeuied37dw3ooiex5@lli2bsap7d3x>
References: <20250911-glymur-display-v1-0-d391a343292e@linaro.org>
 <20250911-glymur-display-v1-3-d391a343292e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911-glymur-display-v1-3-d391a343292e@linaro.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzMSBTYWx0ZWRfX9r3HMywTo0Kt
 +DXnsd0xXsnYcDP/rKATZ8i5iARn3B2WGCQXPf0bakEHKTlwjRxL5GQQqlLQ/TsMFNP0As7e7vA
 WQNXFH/PY97f4IEKwFmf/WBoWF2dyfoY3yYZ8ySzQHmgK7QYBc0ZMKjg14yIzv9JrCoOnARvLQx
 /q0tQzcyZWgZM+izefC1C/YIWZsggN/J0gtp+sS09g4FY1bI7KX/oec85cZnKZC0Si2OnCwaQFl
 YhTNnV828F/94bmL6wMfEFI4j7wNcQmzxeG4dIcqwqbUt9JUUjsHyVhxlNhnwurM2ID7dr46BvJ
 KsT+1jroCubeLEFc7XDzvYGJ/9kNSFxnuGEgHc2ZlBF0lVI2P4hxYZo2LI1M9j8tIi5acAL568p
 yGmfMJBK
X-Proofpoint-ORIG-GUID: -muvEn-Daon0wFc2nx5C8iXQ5kMQ7WMz
X-Proofpoint-GUID: -muvEn-Daon0wFc2nx5C8iXQ5kMQ7WMz
X-Authority-Analysis: v=2.4 cv=VIDdn8PX c=1 sm=1 tr=0 ts=68c2c841 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=yi07AWGtMeMy8SJ1qNsA:9 a=CjuIK1q_8ugA:10
 a=XD7yVLdPMpWraOa8Un9W:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060031

On Thu, Sep 11, 2025 at 03:28:50PM +0300, Abel Vesa wrote:
> Document the DisplayPort controller found in the Qualcomm Glymur SoC.
> There are 4 controllers and their base addresses and layouts differ,
> therefore being incompatible with all previous platforms.

... and it's a new core revision.

BTW: any additional clocks or regions for DP?

> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

-- 
With best wishes
Dmitry

