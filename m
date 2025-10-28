Return-Path: <linux-kernel+bounces-874262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 922CDC15E91
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D352C400019
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E4233EAF3;
	Tue, 28 Oct 2025 16:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e+TvbsPX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IrIRZbrz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1715D331A46
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761669399; cv=none; b=a+asoPXUpCKV43vFESML87V0HtekLvv/Z1NV1aIYMAvxSoJHK4/h8VqJ2o+ta17wr3STCnjSPlK3oAxCtgKIRyNpTSfw2ogxdylU638ssLpO+8h/R4CfRP0bvCxUqKOsLPFJwORDP54H3hKM3pEpCOt9G8Rz+ZHbZNLhbCdXGFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761669399; c=relaxed/simple;
	bh=R+kXUmWjWTHEBOQb+HjDtLqQJ+wEDFTkf+k25VZZb+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EENhFxsIQyOO3HTVlAeYU7OZoEOJ78izGjnrDA1q/fdyAuldSFb0LKO1cfz6Sq+aYoFCj1Mfedbh2I0hNwJbcv/DEORveUK7j1lcBbc7gkufBdWg8rY/Xg5Qfqrv2YCGWGF23Mm3MsWCiOlyhMypFiix2iWKgilZO9ZW95Z0cFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e+TvbsPX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IrIRZbrz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SEo2N11888268
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:36:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IDy4RuHcBK/trnOXa9pH22wBSBIjqvvm5qYWgqrwY2I=; b=e+TvbsPXKIRsOvoK
	RdMMunjunk1nyEmmK+THzt7/rXnU4P3GRo2vgUImhK5tUpoNw1xglDEWS9K5PeUc
	/LIg55la+ak+5ObLLDITrXE3BkEieJIermNlhCCTyv73LN1ByqM4Mh7mvQ8FuRVI
	TjXG59mD6jNmVLab+Se8lGgfWtEcPZf5piBzW7vMEe+ssHPxOUTxzJ1ZKgY9CRnq
	Rc2IdXpIrWIO1fm8cMGPmzCO8c/hDt7adZoA9J32dmi9BGAqoO/Be8vka06zl2fV
	gDSgBOTE9HSlTzWYJPiIZhD0FZYJn00T+CNAFSfb0c5+dXgt82nKW6VzDVldD7Tz
	b7kDtA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2njrtc6a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:36:37 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-290da17197eso99410275ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761669396; x=1762274196; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IDy4RuHcBK/trnOXa9pH22wBSBIjqvvm5qYWgqrwY2I=;
        b=IrIRZbrzW5xP3OgrZWqghQA0gtmUcoY81CYJUY04Kpe+KLUZoMoApMo5iLo4Qssa2p
         K26c8gwWlsG3VUk771GZVV2wfnI9g2O58Hka02KgE9KFxfyFeTWyiHnUTwGZJt3IFqTG
         vGHBSrDI+EmmWBafCtwU7B9ukYLpJ9WhVouYTOhBZlAQclBzSoHqyONBbR3++vxXFCWF
         MjMO4GMRrD4wHWjcDRjmyW0C+8qlxBDXWImiHdBHFRgzowZ08LOciOHNpwzwT6Z+5D1z
         TowzCHeCnOyQgoLE53lQgXHPQJT/o9D9jaMvKIPAVE8KxoH7cfjQAavFctYVBXQPgy5E
         OJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761669396; x=1762274196;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IDy4RuHcBK/trnOXa9pH22wBSBIjqvvm5qYWgqrwY2I=;
        b=lJ0UzU7bcH/DIomUKUnV0lLVOq9CzhK2L1EHiHK9gio95oOD6q6wVWTmxjl5ZJ+BMo
         Y38SYvUpggqpGvECetBAS9EAe42gakX2kPymc+NGQvXsaNsnsMXOGtTMC19xT45XWPtV
         7+4bVSFA2l9vdqaA/f1HfslAApTlSG9CwGzeOMZEOi9OjoGNomlJ8SQkY6VROlMPc/o9
         5BAmSCi/uVLqwZkEjpGRGLCU/x46Vqund9t2tFQ+N0ntoRntct4zbLJjQDd8uhuMqOnm
         0YGwO8H84ZaVLw67XPXAWqy/T9x+rN3oPDGDtEBN10dtcNZdS8tRiwkwRyOu72Ksn63j
         hq/g==
X-Forwarded-Encrypted: i=1; AJvYcCW4xFpxxmpZeNVC1/Wn5qQvRiGwRG9ar/FWIgzqpIv15yUE6MAgY1OSJrKa5LOKmbAm5bi3kmfs9ttxBz8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqg6TCGYa7bYw2Renx/W3mfkorbcDuyWRJCyMTHFpjgtWMce06
	BiHWsz2Ifxab8R8P641l/tXQMW/qTnmNi5j8dyHib1z5aDwSw2L5WEZXtNNlyS8mRTZGHggyGlf
	x+saUhZCDQjGVHXe9bzcShgk/Itf+gO7yYawZdLoKr7wRBDvs2Z5Z66xvXJJMFxJ/61s=
X-Gm-Gg: ASbGncuDmzgnuGoyAzsGXRdPuBJkQe/N+G9Onjc531ScpCLSN+4VvMKHT8HPRm7+T7B
	yMp99wP6e0OLE9RLx/sPRI0RJv+yFxQZbR8WmJx1AHO/WeNYhfi6k2XjfLFWah4SObgzFv/N5jc
	TI8mtjrY+37zVtvEMWdJSg8zTTJruyM2tRZl7zs3wXL6gyPKmYu4cKxuUiFbvbaDtXpwdVt38V5
	/VoUGJ1qXC3G0Zx+EQmvuOaYpMUO44/nKIcpooMnjmaCaJTX5gr9aUR7+hvR3lOAXoyEyDaIwAg
	Sn/GhDLqvVdAZ01l63MFKgvbF9TUrsOjlKgdoaj2A6+aaI++6qObE9zfs+XjGIS7xU3NyrdjzNY
	/7U6cb/CiPbldedHAzF89FaHkdQJC++rc
X-Received: by 2002:a17:903:18a:b0:290:c94b:8381 with SMTP id d9443c01a7336-294cb35ee8dmr53022665ad.7.1761669396249;
        Tue, 28 Oct 2025 09:36:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFj7rkOx2SsV5XGl9//9NqaBw06fgF+m0ijFKwzmMNh7Gb5Vs0Bz9JOF8R0r+XLduxQT6z9xg==
X-Received: by 2002:a17:903:18a:b0:290:c94b:8381 with SMTP id d9443c01a7336-294cb35ee8dmr53022165ad.7.1761669395585;
        Tue, 28 Oct 2025 09:36:35 -0700 (PDT)
Received: from hu-pkondeti-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed739b81sm12694276a91.6.2025.10.28.09.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 09:36:35 -0700 (PDT)
Date: Tue, 28 Oct 2025 22:06:29 +0530
From: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] watchdog: Add driver for Gunyah Watchdog
Message-ID: <6535f199-901e-478d-9eae-d7977e328048@quicinc.com>
References: <20251028-gunyah_watchdog-v3-1-e6d1ea438b1d@oss.qualcomm.com>
 <25f7ff09-08ea-4969-9184-9fd01b097558@kernel.org>
 <76479593-c47b-41a7-8349-5d7c1403f7c0@oss.qualcomm.com>
 <73955d58-544c-4299-a099-bfd9e5912a40@kernel.org>
 <636a1f99-acd4-4904-8fae-f159646cc1a0@kernel.org>
 <f4d80be9-986f-4d37-9c25-725eff7bb653@quicinc.com>
 <321f5289-64c0-48f1-91b5-c45e82396ca9@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <321f5289-64c0-48f1-91b5-c45e82396ca9@linaro.org>
X-Authority-Analysis: v=2.4 cv=dqvWylg4 c=1 sm=1 tr=0 ts=6900f115 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=8nJEP1OIZ-IA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=m0pS8v8U8c8UNkmDbbEA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: psC6tmph0o3wZW2VOxaPRYi_1mKPCBa9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE0MCBTYWx0ZWRfX9uVZVLvwHVQj
 SWbabs0NRWpsinMW4fxF+6PHCGsBa2niP4DNCk1lccOXVEWcjvXL8JMqGzW9ZEzlBpSdQbWydCI
 06xNFmy3TNFScrFDszr6XaYmMTzf7RvSyeFHHgyKv2voSN88NmJMywv7/BIZp4F6KJDqsgAWpbQ
 VpUsOIPs72ZQkVrXOgBTOpk0XL01EhOMDJIQGQ215UDY667rRku7htliMyimuEjlxYhrrOOh8rb
 jMnEq/4Gnx6V32BBMhLGQ8lZGmzkeYKC/LJp8sovTFvjPVJZs4PdDkjGXC8UHtQN7ldGHObL76V
 6K45QUmSOsqDAw4pCqaizYXfQK9FNkBpDoFZoX/0ypOJlskZbQQTIItFlOxq2c/ZhTpZxqW8JGu
 U7TuB1bE8+8t+jcX7KZLB1CtYJI9Kw==
X-Proofpoint-ORIG-GUID: psC6tmph0o3wZW2VOxaPRYi_1mKPCBa9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_06,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510020000
 definitions=main-2510280140

On Tue, Oct 28, 2025 at 05:30:48PM +0100, Neil Armstrong wrote:
> On 10/28/25 13:27, Pavan Kondeti wrote:
> > On Tue, Oct 28, 2025 at 12:07:40PM +0100, Krzysztof Kozlowski wrote:
> > > On 28/10/2025 12:04, Krzysztof Kozlowski wrote:
> > > > On 28/10/2025 11:58, Hrishabh Rajput wrote:
> > > > > 
> > > > > On 10/28/2025 3:10 PM, Krzysztof Kozlowski wrote:
> > > > > > On 28/10/2025 10:35, Hrishabh Rajput via B4 Relay wrote:
> > > > > > > +
> > > > > > > +static int __init gunyah_wdt_init(void)
> > > > > > > +{
> > > > > > > +	struct arm_smccc_res res;
> > > > > > > +	struct device_node *np;
> > > > > > > +	int ret;
> > > > > > > +
> > > > > > > +	/* Check if we're running on a Qualcomm device */
> > > > > > > +	np = of_find_compatible_node(NULL, NULL, "qcom,smem");
> > > > > > I don't think you implemented my feedback. This again is executed on
> > > > > > every platform, e.g. on Samsung, pointlessly.
> > > > > > 
> > > > > > Implement previous feedback.
> > > > > 
> > > > > Do you want us to add platform device from another driver which is
> > > > > probed only on Qualcomm devices (like socinfo from previous discussion)
> > > > > and get rid of the module init function entirely? As keeping anything in
> > > > > the module init will get it executed on all platforms.
> > > > 
> > > > Instead of asking the same can you read previous discussion? What is
> > > > unclear here:
> > > > https://lore.kernel.org/all/3b901f9d-dbfa-4f93-a8d2-3e89bd9783c9@kernel.org/
> > > > ?
> > > > 
> > > > > 
> > > > > 
> > > > > With this patch version, we have tried to reduce the code execution on
> > > > > non-Qualcomm devices (also tried the alternative as mentioned in the
> > > > > cover letter). Adding platform device from another driver as described
> > > > > above would eliminate it entirely, please let us know if you want us to
> > > > > do that.
> > > > 
> > > > Why do I need to repeat the same as last time?
> > > 
> > > 
> > > Now I see that you completely ignored previous discussion and sent THE
> > > SAME approach.
> > 
> > Our intention is not to waste reviewers time at all. It is just a
> > misunderstanding on what your comment is about. Let me elaborate further
> > not to defend our approach here but to get a clarity so that we don't
> > end up in the same situation when v4 is posted.
> > 
> > https://lore.kernel.org/all/b94d8ca3-af58-4a78-9a5a-12e3db0bf75f@kernel.org/
> > 
> > You mentioned here
> > 
> > ```
> > To me socinfo feels even better. That way only, really only qcom devices
> > will execute this SMC.
> > ```
> > 
> > We interpreted this comment as `avoid executing this SMC on non qcom
> > devices`. That is exactly what we have done in the current patch. since
> > `smem` is not present on non qcom devices, we don't make a SMC. In fact
> > we don't even create platform device/driver.
> > 
> > Please help us understand if the better approach is to just register
> > platform driver here and let qcom specific code add the platform device.
> > 
> > Also, please help me understand why would non qcom platform who care
> > about performance load all modules that can be built w/ ARM64. There
> > will be many init calls and platform drivers registerd but they never
> > get probed at all since their platform does not support. I am not
> > defending our aproach, but trying to understand the rationale behind our
> > approach vs alternatives.
> 
> +static int __init gunyah_wdt_init(void)
> 
> will be called on ___all____ arm64 systems which uses the vanilla arm64 defconfig,
> while we could say the first call of "of_find_compatible_node()" would fail on all
> non-qcom platforms this is still unacceptable.
> 

Ok, point taken.

> The solution is to attach the wdt init to something only probed on qcom
> platforms (not the module init, the _probe_ which is mapped to a DT compatible)
> and very generic like socinfo which could accept HYP stuff.
> 
> You could also setup the HYP WDT from the qcom scm driver since the
> communication is smc based.
> 

I think we are trending towards the same approach. Similar to how
`socinfo` platform device is setup by `smem` driver, `gunyah-wdt`
platform device can be added.

Thanks,
Pavan

