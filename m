Return-Path: <linux-kernel+bounces-895703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 864D0C4EB77
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6F5B14F9493
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E221135B124;
	Tue, 11 Nov 2025 15:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m3Js7F6M";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AejMw3fP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEAA35A959
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762873562; cv=none; b=gHEaSK8oYZ1iUb2s14Xsa2z9r+x0wO42AOvYulFhDHj1lQPo8+KmcJGCb+T3QNWYmO3vbJSlOpSPZT32htws+LxTtj9wr4swHc68gFSlO+tsguOkx4358nuQ80DQYEGpzCWezs7WHW0iK+ExmkeavKzNGj2k9TTmj9lNpF9cXyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762873562; c=relaxed/simple;
	bh=cFy0eFg9xDDoKIoAJXk7rXcmERhFHYornb1ZkaEXq3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GW4+P8sSoSmDpgelJk275TGEJHlwcaYru/GRc8y9MiU6bHNq5p3v/KVKXfNl+y6Eja1DjQMJ1psE2c0ryWia7J/B6G4QnytptAbVz+Ivu0e9CzkA/m9DlB6VZmjYe1DpBJksZZLRA5m2UwnWNk/zyMVIqqs0Z7Lja0HX0fn9CJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m3Js7F6M; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AejMw3fP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABBGNk82117576
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:05:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=buvjHKf1PuojEb0LL8OChGCz
	Fc+8Z+ETH0y8puXDv2E=; b=m3Js7F6MX4JTJ5p181DnQgJ5Cvhn/zG7DsTxhAeC
	FxQm212gEw/Vsy8Pq0sEJekPimwf/841aal6eZeoKSX4cusDkYdwXMcYWJRPwIVJ
	fi8nLd4KI7P2FA87Z+rdseDJen79CyFBYdVuzie7LlReZBnnXWPpnVjPYTaiHi9i
	Zz3DCmEus7wv7r2AcpwHnazjYhPhqdcQ3Nwsf19z/yh+EeW89KY1x+gSRrEfOrrs
	7G6wv4eqh4FxDnyLCgxjoBr774OethJDdoqt7w1ESKSud4RUqRGAIYiL+if5U7bS
	fa6IS/HEWNLtKaPM7zMbNSN3ZobFxRZiBaMGXOXMZsD1gw==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abpy8jt3k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:05:59 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-5d4123439bfso9107054137.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762873558; x=1763478358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=buvjHKf1PuojEb0LL8OChGCzFc+8Z+ETH0y8puXDv2E=;
        b=AejMw3fPP4st2mxLvRxeJKF669vGIPYk/ifDgDlqD3vP4je+I6uPw54N01VMUEM/d/
         bbJ2RGNhwKk8jzFcz0bsZhjq8Ka3ed/knd8ZFlQVwudpzq3EGwj5QhrZ+wwtTXLa5oj9
         t2af0nKlf4ZfsAfNVJkL9cSHEQ1j5mx2JvfxwtNRPzW8cBonOEICBLH9uVEMb/zldRV/
         FnHvGyoSd3/z9QA1nuPF8EM2uro38SJQyjHSOD8/Pyhd4IRCM9gw2YUBvuyNxM7gvtdj
         +Qbq/KZFjliTlJbi/Ufz/9vDXkkDUPs30q5GAzYtfzBcmETFP4gzK22Mo+WCbG1E2qGX
         w4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762873558; x=1763478358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=buvjHKf1PuojEb0LL8OChGCzFc+8Z+ETH0y8puXDv2E=;
        b=UWwttQL1/0T+5dKv5qurujBeTnbEVWZZxLCvzMcxPYbKsxHVMaMJRpu/3ZlI9aWe8U
         GBSy9n4cuylNauKgMP4cWw6CqkYvBGdEI39yuq3EOoiIdzTezkCl5+gtUqodVZEyhWxu
         OZbZd6pn62IGE8o/h5oitGSIczjXRPXXbpNodAcAPCTYmUKU3WQt05sllZkSWpZLuC76
         831iGH/UU9TxcdC03Nsbdr1MTyK4kY6MYshqmDNNj5p3AiiF276PxLmSEzvgZ27iOnRD
         FUUgByjxnHvpp1VGsg7eC5dU3/oA72ZuGYTWde/0+Fc2EkanbbQjDS0yJI6MeGUGvUS0
         reJw==
X-Forwarded-Encrypted: i=1; AJvYcCWLsdqbdKHLGlF6f0jcr+5fGywSYPX/dWiy/zh5rh/ptt/xCLaHm2jFwQI2NYYwZ9x61Ht1U8ZLlIh7ffs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHgrejWjWiE/ZCiAyzZhL41pwTpWodY2ZGQRRIw9eaXQ1un4HF
	ZHOlVi5UgHDe935PXNXkmEDli/Unuvof2w6USSwnJn5cwGTFtC2lBs/qsrBj/Nd8BL5Zv9sk0yD
	FRAMX45miET7oJrZX2lTzCasyoopfQ9rzmAw9/zLRziyzTqW9hATGQMme0GihWTQ7JuU=
X-Gm-Gg: ASbGncvi1ffjIYAGSgbcGQwn51tJSJVvznxpYRKDxQa2NDmIo0Xog7wC0BBjRycfkMP
	tq964/alnLcA0Hh1+wonu2yYr5cFhLWX1UOTNf7l4HZvYsHmNQx94bAbRM3a2w1t7zHZ9knOfgA
	uRymHgK3CI+8p22p78pHu0zXeIrTCC6sy8MOx5r7r3le5HB2mO320nGi8HnrV8ug7x+4AU+QuNM
	LXesxxuMMrKlzWLa8FbfIKmuFpcqGsf+usXiUkvsGZ/lAacgMdThD95kqzegyV5joVfRQLIg23O
	cbuERSqXgZeDcFyeMxG7fu1mxC5b0Y33Ch2oeofbseoyGNHquhmgM2wVDOBkxJtK3RVQ18UY+rn
	Ony/jH5KkQK6kSZeLkWiEC+BVdmVkldS/dxqKyTfNWfYg29mdTan1Wjgt5v5e/wUQdlmhhhoVZt
	3kVCSrIYakXV8Q
X-Received: by 2002:a05:6102:3049:b0:5db:f031:84c4 with SMTP id ada2fe7eead31-5ddc475a644mr4906838137.28.1762873558374;
        Tue, 11 Nov 2025 07:05:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBi5EEv+B0IsCeVwFzn6W4s25mfl4zEj5ZMKHk6DJoUZfUdNO357NnBjPHCLbXMVUYW8rT4w==
X-Received: by 2002:a05:6102:3049:b0:5db:f031:84c4 with SMTP id ada2fe7eead31-5ddc475a644mr4906761137.28.1762873557845;
        Tue, 11 Nov 2025 07:05:57 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944faba465sm4795599e87.98.2025.11.11.07.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 07:05:57 -0800 (PST)
Date: Tue, 11 Nov 2025 17:05:55 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>
Cc: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v5 1/2] firmware: qcom: scm: Register gunyah watchdog
 device
Message-ID: <nkh73mo4h5kj2lrz7paop7fn3ow2itxl5vh43muw6n5dxgmco3@tgvbmdxhbiqo>
References: <20251107-gunyah_watchdog-v5-0-4c6e3fb6eb17@oss.qualcomm.com>
 <20251107-gunyah_watchdog-v5-1-4c6e3fb6eb17@oss.qualcomm.com>
 <hbxtbaoavlsw7pbmg3cfkbyx4nacjfiikckhqgpvlggbh6hu5b@jyporqecfzni>
 <263d1390-eff5-4846-b2c2-31f96fc3248e@quicinc.com>
 <3794bb0e-5e2c-4d5e-8d81-d302fa36677c@quicinc.com>
 <56aqammkwte3tcdzni2unufjp4t4yaqazzdkigrwqsxp3ghcqe@ppe2pjwg3hrl>
 <60583236-692f-4605-9f56-f7dadb46558d@kernel.org>
 <zbwcg5pkdspkcnvaitac6y5iko346qyuzuipqhkoedcaqm2dpa@zmszuwhm5q7z>
 <6bebcf6c-9328-4cd6-b77c-a147338d607a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bebcf6c-9328-4cd6-b77c-a147338d607a@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: WX3mArXgfNP_aS_69JQfSPQchKYrmPXh
X-Authority-Analysis: v=2.4 cv=AYW83nXG c=1 sm=1 tr=0 ts=691350d7 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VuFkkUr2qAWs9GA4iUwA:9 a=CjuIK1q_8ugA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDEyMSBTYWx0ZWRfX3m9YjVBGOTGS
 RESa16avJbpPqneFS6rPEi2bm6YSo1ZQoJHYKIlIrU8IzBv5QRSkKg8cVeidyNP8n9DOFSRbIQ2
 dt5Afa6ujXjA6Q42xawIByUOf1EC3r6x024+b9rS42U48O9rh0A6BZ+fIS9Z7pWRQYB9NN5qTc2
 QR84EN/p+n3Vs5LLAesUeAQlm1vToyeUNj9z9z57OwRtdF88i9/9qPpvErybciMct+kpwM/gtcz
 2hAEVKRvPZXMVIZC5hOl/IyQD43gFIy2DShF3PRH5b3ec5PR5q0UjO4ZBwObtkdtknyl7HWR6Kd
 pjrBenLUsH13N/ELBL5S3d2gvdLBvUyGleI5M4Qwu1MUKS3WWiD9/xzRR2P3/405CVFyBtK6/ot
 w7M0q7dIwcjOONJTC31TaDXy6p9twg==
X-Proofpoint-GUID: WX3mArXgfNP_aS_69JQfSPQchKYrmPXh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511110121

On Tue, Nov 11, 2025 at 07:30:59PM +0530, Hrishabh Rajput wrote:
> 
> On 11/11/2025 5:52 PM, Dmitry Baryshkov wrote:
> > On Tue, Nov 11, 2025 at 11:41:51AM +0100, Krzysztof Kozlowski wrote:
> > > On 11/11/2025 11:34, Dmitry Baryshkov wrote:
> > > > On Tue, Nov 11, 2025 at 10:51:43AM +0530, Pavan Kondeti wrote:
> > > > > On Mon, Nov 10, 2025 at 09:43:53AM +0530, Pavan Kondeti wrote:
> > > > > > On Sat, Nov 08, 2025 at 07:26:46PM +0200, Dmitry Baryshkov wrote:
> > > > > > > > +static void qcom_scm_gunyah_wdt_free(void *data)
> > > > > > > > +{
> > > > > > > > +	struct platform_device *gunyah_wdt_dev = data;
> > > > > > > > +
> > > > > > > > +	platform_device_unregister(gunyah_wdt_dev);
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static void qcom_scm_gunyah_wdt_init(struct qcom_scm *scm)
> > > > > > > > +{
> > > > > > > > +	struct platform_device *gunyah_wdt_dev;
> > > > > > > > +	struct device_node *np;
> > > > > > > > +	bool of_wdt_available;
> > > > > > > > +	int i;
> > > > > > > > +	uuid_t gunyah_uuid = UUID_INIT(0xc1d58fcd, 0xa453, 0x5fdb, 0x92, 0x65,
> > > > > > > static const?
> > > > > > > 
> > > > > > > > +				       0xce, 0x36, 0x67, 0x3d, 0x5f, 0x14);
> > > > > > > > +	static const char * const of_wdt_compatible[] = {
> > > > > > > > +		"qcom,kpss-wdt",
> > > > > > > > +		"arm,sbsa-gwdt",
> > > > > > > > +	};
> > > > > > > > +
> > > > > > > > +	/* Bail out if we are not running under Gunyah */
> > > > > > > > +	if (!arm_smccc_hypervisor_has_uuid(&gunyah_uuid))
> > > > > > > > +		return;
> > > > > > > This rquires 'select HAVE_ARM_SMCCC_DISCOVERY'
> > > > > > > 
> > > > > > Probably `depends on HAVE_ARM_SMCCC_DISCOVERY` is correct here.
> > > > > > 
> > > > > Dmitry / Bjorn,
> > > > > 
> > > > > We are debating on this internally on how to resolve this dependency
> > > > > 
> > > > > - QCOM_SCM depends on HAVE_ARM_SMCCC_DISCOVERY which means restricting
> > > > >    QCOM_SCM compilation than what it is today.
> > > > > 
> > > > > - Adding #ifdefry around arm_smccc_hypervisor_has_uuid usage in qcom scm driver
> > > > > 
> > > > > - Adding stub for `arm_smccc_hypervisor_has_uuid()` which is not done
> > > > >    for any of the functions defined in drivers/firmware/smccc/smccc.c
> > > > > 
> > > > > We are trending towards the first option above. Please let us know if
> > > > > you think otherwise.
> > > > The same as before: 'select HAVE_ARM_SMCCC_DISCOVERY'.
> > > HAVE_ARM_SMCCC_DISCOVERY has a dependency which is not always selected
> > > (e.g. ARM32), thus selecting it might lead to warnings of unmet
> > > dependencies.
> > Then `if (!IS_ENABLED(CONFIG_HAVE_ARM_SMCCC_DISCOVERY))` might be a good
> > option here (and depend on GICv3 selecting it).
> 
> 
> Thanks a lot Dmitry, wemade the change below and compile tested on various
> architectures (ARM64, ARM32, x86, PowerPC, RISC-V and MIPS) and it was
> success.
> 
> We will include it in our next patch version, if there are no further
> concerns.
> 
> }; /* Bail out if we are not running under Gunyah */ - if
> (!arm_smccc_hypervisor_has_uuid(&gunyah_uuid)) + if
> (!IS_ENABLED(CONFIG_HAVE_ARM_SMCCC_DISCOVERY) || +
> !arm_smccc_hypervisor_has_uuid(&gunyah_uuid)) return; /*

Unreadable. Don't you read what you are sending?

-- 
With best wishes
Dmitry

