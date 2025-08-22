Return-Path: <linux-kernel+bounces-781420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9EFB31241
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BB30AC4368
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 08:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EBC2EF657;
	Fri, 22 Aug 2025 08:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X2q9+Zzr"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A812EC55A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 08:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755852388; cv=none; b=emjvyX5WQaN0lMeZmwW2wOD+7nhb8sBcv7Lh0zNxfKWZMe2UpKRyjJsVYd4z7JnsQ6qGnpMJLdzbb8Rbh2ZAtwG4b+M7lM0yL/GZeUx465plQ3ssiOWYR3qSWxHtz1Qyby4rp1yTaPd+hw7gy8lPmJ5ojE95fITnWAt6M+kJCAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755852388; c=relaxed/simple;
	bh=xiUcf6KQXL1mohvs6pLqMELi1Jr0lbQNCWaPe0Z3AFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZx/v75i6dXSf8T7jbv/e/sI6b+CsJbILibWOpmXgasNlN7ccSemB0UNU8FAmGcRKDVSqa2yb9qfb393WZpv821/jsZUq2VHfPEJIqC2XiiS7x8LsRmBnrR7SwseHBKTjGQTiC6crfD9T++2rnlbvD/5om+b8sqbkbqV0XOAS7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X2q9+Zzr; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b9d41c1149so1167826f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 01:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755852385; x=1756457185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mKtzIyoCQlt7nDEX7AlctUdLR7BX98MJphMunffjSU4=;
        b=X2q9+ZzrFrnfR8u/Wp5LiNd9NcK/eLRnihwfJ8tnc35/ksIUVni2E01MoUSO2fXKtL
         J+iSnLX9QV6+0hvwX8hNYICj+uhUnkmXdbpKnmM3AVXD26E6bx0MezMgCIYe291pOF5n
         TgRQOfa7IYimAP+X10L7mShkO9Qu+vPUiOaHLweFwb6tjq2nhn5TvWJoa6l4eRWXWXQa
         sNSRSlItMSzuI6tymj9g1x28wwIpundE53wGEZuhkcKQD1AIGPArA3GO4vXrvXFmqOuI
         f9+cszGmKfYc0mdJw2ETKjYIzMeo83kn07YGxGRW6oCYaIH7y7I+hssLS2tAf3eCnk8r
         KAeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755852385; x=1756457185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKtzIyoCQlt7nDEX7AlctUdLR7BX98MJphMunffjSU4=;
        b=tfzuKkmPLzEOKFZZjmE2RyNAuxsoRu8gtoBmqaH9TqY6G7ilyjgby4PZ1MiZmAfJRY
         KSaXku/EpduFc1b/XHiCNlws6eiXpsrcPm16sQP8alVG4KGjAYFH2WvLX0Gd5gWH+KJu
         t1CeFmZJ33wXaEUoGLP0dOpu2wyx1FhTFbv6MjdJDL4yvJ1JzPBRlFZ1Nwl+iP2yMH95
         BSo8wCEL0XOFHlnCu3PeQVkT3Lem8ZyZIyHZC9rxmvxMw6arcCasKDv+30aC5EyrO2uk
         xTfh8CvvmECwQrCOq2FCv+vrcNRT3HKbDlKtovsZPOP9NZjpY2i4+SFiKDS1ijN5/3Jh
         3l1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXPie4jRXIq8pazJM6zO0UA0QYkxSZA2AIz3yG+lUioqd23QNWhvnBy2BY7eem+U2t0tE02eyJEoCJrP2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUux8hATWbPTn87zJ/RzUkzJBB8WQM8hME4cW9z+VtYWki8RqU
	j8DK6ZBIDuXw+3wQ103trkZ74EfnlM4zK+GTC7uhUTjUUUc3EFCXOSmCX1khAEOn1CM=
X-Gm-Gg: ASbGncu9P16yBXi+p1Z5/O83VBIFvMDZ6UZWm8r5Vt3q5mF+rKLt3pO/hbCwezD+9fM
	4OIdy3BI/sFBLn5Qhb0tajeBDGwyOTBNboCEwISBtERb+mw+pHwJU6K1iYj6g4qdLa7pKAKKs72
	IOg7CZ0Q90d537kcLBbbRcXKHpq1XchT/DcUz/q73TRhsZJGf9jpmtykyBFepLZZ2PNfsyldHwq
	fkQaZDjoxNVka95ZM6rwFpLc5QPuoxCTMIMdXtluInh9QWus1SRTtRlSDc9GDVdPNFVp6CcTTbB
	SAUtms6PkmyXCCPRRn81cKZfckQ09rWrP1er5jkD5QQMxR8mvDNIZRfs2en59Ea/WS+o/Ff7tBg
	HSotq6FT6EtHAP686qIafCZWYhFUFGAoZlus7xKMiFv+l
X-Google-Smtp-Source: AGHT+IEsclJmGdDVznTzN7OSbg0+qrHzDCwPUEaGD05vLXZ57+MhrejHOVS3jbp8VxpzYb4WstvJlA==
X-Received: by 2002:a05:6000:2f82:b0:3b8:f358:28b0 with SMTP id ffacd0b85a97d-3c5daff6b0cmr1574167f8f.25.1755852384692;
        Fri, 22 Aug 2025 01:46:24 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef30:63f:a353:7a5a:5beb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c5510a646asm3893162f8f.15.2025.08.22.01.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 01:46:24 -0700 (PDT)
Date: Fri, 22 Aug 2025 10:46:20 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Vikash Garodia <quic_vgarodia@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-media@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v2 11/11] media: iris: Enable Secure PAS support with
 IOMMU managed by Linux
Message-ID: <aKguXNGneBWqSMUe@linaro.org>
References: <20250819165447.4149674-1-mukesh.ojha@oss.qualcomm.com>
 <20250819165447.4149674-12-mukesh.ojha@oss.qualcomm.com>
 <aKWLZwYVPJBABhRI@linaro.org>
 <20250820115659.kkngraove46wemxv@hu-mojha-hyd.qualcomm.com>
 <aKXQAoXZyR6SRPAA@linaro.org>
 <f25b6cb4-666d-e3e1-0540-b2d7fad86407@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f25b6cb4-666d-e3e1-0540-b2d7fad86407@quicinc.com>

On Fri, Aug 22, 2025 at 09:56:49AM +0530, Vikash Garodia wrote:
> On 8/20/2025 7:09 PM, Stephan Gerhold wrote:
> >>>> +int iris_fw_init(struct iris_core *core)
> >>>> +{
> >>>> +	struct platform_device_info info;
> >>>> +	struct iommu_domain *iommu_dom;
> >>>> +	struct platform_device *pdev;
> >>>> +	struct device_node *np;
> >>>> +	int ret;
> >>>> +
> >>>> +	np = of_get_child_by_name(core->dev->of_node, "video-firmware");
> >>>> +	if (!np)
> >>>> +		return 0;
> >>> You need a dt-bindings change for this as well. This is documented only
> >>> for Venus.
> >> You are right, wanted to send device tree and binding support separately.
> >> But if required, will add with the series in the next version.
> >>
> > You can send device tree changes separately, but dt-binding changes
> > always need to come before the driver changes.
> 
> Do you mean to update the examples section[1] with the firmware subnode,
> something similar to venus schema[2] ?
> 

Sorry, I missed the fact that the "video-firmware" subnode is already
documented for iris as well through qcom,venus-common.yaml (which is
included for qcom,sm8550-iris). I don't think it's strictly required to
add every possibility to the examples of the schema, since we'll also
have the actual DTBs later to test this part of the schema.

I would recommend to extend the description of the "video-firmware" node
in qcom,venus-common.yaml a bit. You do use the reset functionality of
TrustZone, so the description there doesn't fit for your use case.

I think we will also have to figure out how to handle the old
"ChromeOS"/"non_tz" use case (that resets Iris directly with the
registers) vs the EL2 PAS use case (that resets Iris in TZ but still
handles IOMMU from Linux). Simply checking for the presence of the
"video-firmware" node is not enough, because that doesn't tell us if the
PAS support is present in TZ.

I have been experimenting with a similar patch that copies the "non_tz"
code paths from Venus into Iris. We need this to upstream the Iris DT
patch for X1E without regressing the community-contributed x1-el2.dtso,
which doesn't have functional PAS when running in EL2.

Perhaps we could check for __qcom_scm_is_call_available() with the new
QCOM_SCM_PIL_PAS_GET_RSCTABLE to choose between invoking reset via PAS
or directly with the registers. I don't have a device with the new
firmware to verify if that works.

I'll try to send out my patch soon, so you can better see the context.

Thanks,
Stephan

