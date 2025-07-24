Return-Path: <linux-kernel+bounces-744488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE4FB10D82
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C67E53B5F1C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A577B2E175D;
	Thu, 24 Jul 2025 14:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K0z4WueD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5472E040A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753367097; cv=none; b=LgINY3UVDe6xWtZXnkv3I5FMPbBKsV5vc/n4MB9K/hfckSpxWVKEB5RSxa7sxuYBN5GAooAz33SuWpZN2QklqmGnpTj41Yhn3pmTtK0y3Gn11ugtGvb2D0sRYQS/OTZWrHyjmT+2B80lnXSOnPZOyw8CShCz9Fxo3D6VeQhgw2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753367097; c=relaxed/simple;
	bh=yMnNEljPS2VbnBAe7RDRoMrtiMmabtrdw1ZABRBlKGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3sFP11MUK2ZFmiuXdHhHK+TSRY6PQWE2qfj63VnsbCeO9+L05tHflFfY/tQdg9265+o/EDVA4kS9BvV/TiPvaqpR6ef7fnPNVHp0l60fJ8nMGmWrjTuXm/Sycl8SRVe2Yi1bdx6o1YPYwLCm3MvsjOeDWKlkIxXYhxIKxlV1rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K0z4WueD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9UbLO022010
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:24:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=PXQaN2D5/hB531+P97VDWMow
	svbj/zQKvLqKvH8lf7o=; b=K0z4WueD55xwjKU3Se6ihbq/2VCf3zfLo/B7fdSh
	1j+8LH2ycDmyqho6cCtX6qVdGT5m0yRzXD/rNay5RzD3Pd8rxgtfxnVnMdIIGiXB
	uxzB8AnxkzvmqrT/TA+pcDVEzwXolofDxs00ccr5mBKEGw835rbVga89a9YLHUu/
	MD/KsVXTWTRaDk9JsPEnXxHah8TBiG4Nfw5eEgl8dVQKlS2L//1b3/DNSiDc+PrF
	/m3u/2wrsLQ/XhqeA/a/CJ7usS1LqQieYQB05SD5L6iqQ0IwDQvbl1PI88qvBJXH
	u/VpcUbhl48QPg89KA1wwpz8GM3PP7vUGEsWA7PSzqvsfQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48044drt0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:24:52 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-4f5ccb416bdso235014137.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 07:24:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753367092; x=1753971892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXQaN2D5/hB531+P97VDWMowsvbj/zQKvLqKvH8lf7o=;
        b=uUUqzIM8nO4sKsCu8Z0TvBULa9iYVVH3r9xey9o6tuXa5xoYvUojJ5EPKPw/tw6wNR
         V3iM3xnCWYmJyPfwvwy8qfASOxvmr72CzCCKnV6ZVx1AXFalMJvR+lKBA2O9WnTBgF2I
         suc7Th6es2Xrk0h1MsvYQNidTgp1qihgU2HwdOpHCNYDk7qSswr1QEQk0bSK7n8a5F2M
         nyUlbVmSI+zx+88HqQTTQq63EKdCHxekGM9uTyltDiLya5vQz/xqJjydRmaL1BoCr937
         KJ501MH4ihfum7nJudvGmjt/0Jjd+5G5Geb9lQ0iiCAaydSW4b3ngvWoXOtFHqmDFM1B
         4F3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQU84yfWH2TZ0fylgx+6BsVi99+tZQ/S5HR0O0l8Fr5pRvVj4xouHTSWothhy+gNmvsS4piTtbanaUSg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxolwlUZpo047+kHOdBPUmqs5YM5jOP2rbNSg3hVu+vmo8VAfs8
	CUV+3Qd/0bQtH0CLlcupTugnlwEGStYCYorsNTXqFeL/56QR0GABkl9iStqxKxSjeLLgPJ02e8J
	RKiqA5+CR7ri8g9u2b8DZsIGp0mnTkAKEZWMlYJeh5DuoEoM/907ucTwIyVsvjI4n+i0=
X-Gm-Gg: ASbGnct6ZzLelmWhWTX3muOhG+waewWKPLw5K35iAqOg6VMrizLpYeHPsajw/1DOpiX
	6dOjdrQ9getaXzQCdbFn4LaBAan2Zztbvf+oM99oVpcyxwdDvTovyNqT0nJM42MhQ8xu39a4hvg
	bzRtI37EjdEaUbJxSfgxwn2NVeWhAqojPFUWBBcNy8u7eE1yJ8TQI8+fWKzAbj2GgNVps3JDhOP
	aVi3nrmNb6Euz279IHo0ycV5d1qVo6u+2S1vHU07BQIJc08xwrorNGbGCzzoqZ3H6p5jcTdN/aZ
	jpZ1cqmAhsem8fKDj0ngdxqaxjVmGbCJBAWJcPwpJu51x5N3GoQTWMqjYDnt6vbSJpYkRI9S6vf
	2jpvB1Y1t9q0xv80BgU/lf3JtS+9NATr8OMdGRQ/3PyIxlxzmPKkr
X-Received: by 2002:a05:6102:1612:b0:4e9:8f71:bd6e with SMTP id ada2fe7eead31-4fa14d0678amr3840754137.0.1753367091802;
        Thu, 24 Jul 2025 07:24:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7ps+tMO3iXJTK79wunyZUIPEL7/LqtanKTlXWlbJ0rKzxmD03n3TemWcd8PsIKF5pqv7aDg==
X-Received: by 2002:a05:6102:1612:b0:4e9:8f71:bd6e with SMTP id ada2fe7eead31-4fa14d0678amr3840727137.0.1753367091417;
        Thu, 24 Jul 2025 07:24:51 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b53b22b21sm382703e87.19.2025.07.24.07.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 07:24:50 -0700 (PDT)
Date: Thu, 24 Jul 2025 17:24:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: srinivas.kandagatla@oss.qualcomm.com, srini@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slimbus: qcom: remove unused qcom controller driver
Message-ID: <mwhxikivaxtz5px5e7jkqtuuk2iz457fy5drsnaj32j4o5qqk6@hwkcjso4jpsp>
References: <20250724132808.101351-1-srinivas.kandagatla@oss.qualcomm.com>
 <276b7977-45d9-4b37-a4f5-1c65802ac267@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <276b7977-45d9-4b37-a4f5-1c65802ac267@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=BJ6zrEQG c=1 sm=1 tr=0 ts=68824234 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=Q3_JIj6pLLKXvGcXXDoA:9 a=CjuIK1q_8ugA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-GUID: u3fZVX_9_Iik1Na5yVG4gQTyloX8sOL3
X-Proofpoint-ORIG-GUID: u3fZVX_9_Iik1Na5yVG4gQTyloX8sOL3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDEwOSBTYWx0ZWRfX5BR15WQ3ZsYc
 QI7XkzpQTqj1QwRJCgWQsszInYDPGb/Bl5Klj9jQMd9Wn/2Nk/be/GakapwEG7Y9Qa2V+t6gb8E
 2KXoL+NavxI2+agy/npTCwwwKWfWLlOmPuArroxXaZqkT2LY1JVox3F3dODYwOUydDPlZXdlhAD
 Rl7QlLiE44hPHy5ZJNDknGmf43Ib3sKcMf0HCjfLPvTJy+rU4WDgK8StANc14dfmX+wWVFFqBRW
 6DVCZ17mIU9qANAKnDgRkrOXpWFN/IClCdSt/1dd/H7jQgv6Ktx9nhyBTtbeVP6TsyKc3LETfF9
 fiHh2jpjTUQ8DNbD2dvczqcAZSOPKfECmtIQQYV5+GD+vpU2ZIHKaubOJwu8elTdR3u2CyKo68J
 4YWBJPwIxcrelV7OLKcaxhA6c7Lp5byMm2GR9+hKz2nPq2x29dg6t4LqaOL/EkvVQQc+YQG0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 mlxlogscore=822 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507240109

On Thu, Jul 24, 2025 at 03:31:50PM +0200, Konrad Dybcio wrote:
> On 7/24/25 3:28 PM, srinivas.kandagatla@oss.qualcomm.com wrote:
> > From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> > 
> > Qcom Slimbus controller driver is totally unused and dead code, there is
> > no point in keeping this driver in the kernel without users.
> > 
> > This patch removes the driver along with device tree bindings.
> > 
> > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> > ---
> 
> I *thiiink* this is apq806x code, with 8974 adopting the new hw.
> 
> +Dmitry, does you computer history museum require this driver?

I never had time to try enabling audio on IFC6410 nor Nexus 7. But if
the driver would be actually useable there, I'd prefer to keep it.

-- 
With best wishes
Dmitry

