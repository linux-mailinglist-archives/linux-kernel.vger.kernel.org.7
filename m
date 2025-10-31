Return-Path: <linux-kernel+bounces-880339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60365C258B7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D287464FA2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B612126738B;
	Fri, 31 Oct 2025 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gvs9D7Wi"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6246C264FB5
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761920359; cv=none; b=j7tGP+1mU7r7zv9fMKzSmNnxwkjntAL2TiiDAf+HH9RCaStkqi7/XN650QgCjO0ag4SSB+XqlPz2GGIXLspkO8rArBKOBhX67gob3qQnoTJMLEn7Mf/2L++9H5AzV5sPuvi8EjYpIk5usi2EyPXMvFci0sdtZXGhNw7tQqAyNHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761920359; c=relaxed/simple;
	bh=iGjNEcgSl7MepN7bm0rUsoKrnV07Xn8Pykv00LshL7I=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tY8r/v+12G1GtnL/Q9t/o2Dg60xDbyhgXNtXGanJEZc21cXUOIEvo0RaNXlOhGQb1mJY1A3L6ImCevWocnJQsNxNPbhVZCq0fMaiIKUo/5rmGQEwC5kqnhM1Sz72HxwOMZ0eAeuu8t5g3guGPuO340+SCgZre2rR9DdiIuI1gYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gvs9D7Wi; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-471191ac79dso25633775e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761920356; x=1762525156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jUnrqbgsEEeKUxRlK+hEtgof0sdFkQGSEV+8c+8Tuqg=;
        b=Gvs9D7Wif27p25uh5x6+0M/GUXkHG83rISjk5XoM6Oo3Wbt+9mNotovP9l2LvqoJoQ
         NpSgGlR6maj6HqmQuPhiI0wJEhjmC2tomLKGAOUr95++kxhzln//lrQPDw1myqJYOj/S
         aOoi7nSpNqe2JnBw2rkPCiSY/AzGRzGrlG0uQJnv1fqjQ1HMtj36fM7vxhjXKhEyPawE
         vH0oat5s33htF33eStVd0rWiz2f+XDPEqz9lb9oh2CwQlmNmDUV4wTsQRxfnm/98Tjj1
         If0ZfRPFlw42nwFydDTJYaVxB2AkRJlhYOV/ldsWcJIDojBCm2qwER+EVEDN9jOYSCGU
         QIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761920356; x=1762525156;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUnrqbgsEEeKUxRlK+hEtgof0sdFkQGSEV+8c+8Tuqg=;
        b=GRsP+MsO70cmlqGchUiR7o4m+owknS57afIOfK3zrCPUPX1kPxKiwvII0AO6mRMRnd
         dcFMClqM/BFY6e+4gnPsBK5BDJGVz6YHolDuT1RIZz9h51pgicI0fKKGxBYPyxoNrEvG
         dVRQm7tQZeIsd2+XpTQhYNBJfiKMN2f6NVbIt38h148W8Py91Rab1kDC+3Jr1pfUweaW
         12r2ReLzvAJ+Z2jKAUOXAZ3yPY377Fg48usH+CnQtlCeu5W8X5/VkbRcpb/r/xEgtDU2
         5B4gCyxuHonmCM4yI1l7Aat5XvbP2KjqlNr6s2+8jKD3PAc/o1/DVNCFsYGkYLO3/Y4+
         d/Ew==
X-Forwarded-Encrypted: i=1; AJvYcCVnzafxCT3Ngr1Bp7WS0Mq3/DR1fg+MbvZozqMbxHM2konhkd/Zz8eiIrFDOpIyuElCkVoaK8tkZ/PXeFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAmUQOoe16lQIVIjoQZeLOxMBQLdbTIhHdbwR/AOyD1Ag/b/+y
	JN9Wb1m1eEt6UD5WUkJZNk4HOCdonWbItUQPZmiibSb5KxDEK1ttDOAF
X-Gm-Gg: ASbGncvgv0S+iBhUkeb6/S9P7Vfm2d/+puSGSxU60NXR2ZyxCkYtT1R2tV6LPGybYeV
	mEejytdw76oeSqGoBqLS0YJ3e1FVao0L+YqlfuXBotnzju+/4MxvzHD981QrkDAvwZaTuzxQUCm
	vsVs/qkv7+7zwmYEwwmQcMqASQVasfjD1zVJyDnlY6EvfjEDeuaer+JkS/PlsYagYD8a0L8qkbm
	hQNGPAv4xu8FGr1Ixvx2AXQeG2DR7R71Fr53/NvsOcYftIQlfIsVYxhQB1x5jFR/SQC0iz9FIQD
	WE3as+Df8BZpdWvwmqKAGP87Dcq//TxLbH1A5r5OUiKtodnccqA/bW33fiyPFZcgMEu+l4cTo42
	xE+XFeAQ78LgoETpgz/sAI4RDumieaJ+b69e9cmdod/XKQUcd74hmef3xDhToDWTqnwywWQI8jY
	VSRwMXh7bkmDg4MAoV99HAxS6KdQ28
X-Google-Smtp-Source: AGHT+IHE5UpyXRgf2wW/MhlT/KO5g75XTHgiswzIr/CP1ChliZ7xkOs9eo0r7gde+zfRghiWxu3xQQ==
X-Received: by 2002:a05:600c:820f:b0:477:a58:2d6b with SMTP id 5b1f17b1804b1-47730802d3amr36677275e9.7.1761920355393;
        Fri, 31 Oct 2025 07:19:15 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c3243c6sm301615e9.11.2025.10.31.07.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 07:19:15 -0700 (PDT)
Message-ID: <6904c563.050a0220.a13ee.0212@mx.google.com>
X-Google-Original-Message-ID: <aQTFYFixlQSHRWo3@Ansuel-XPS.>
Date: Fri, 31 Oct 2025 15:19:12 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ilia Lin <ilia.lin@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Raag Jadav <raag.jadav@intel.com>,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] cpufreq: qcom-nvmem: add compatible fallback for
 ipq806x for no SMEM
References: <20251031130835.7953-1-ansuelsmth@gmail.com>
 <20251031130835.7953-4-ansuelsmth@gmail.com>
 <aQS5FpuOWk1bWnQd@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQS5FpuOWk1bWnQd@smile.fi.intel.com>

On Fri, Oct 31, 2025 at 03:26:46PM +0200, Andy Shevchenko wrote:
> On Fri, Oct 31, 2025 at 02:08:34PM +0100, Christian Marangi wrote:
> > On some IPQ806x SoC SMEM might be not initialized by SBL. This is the
> > case for some Google devices (the OnHub family) that can't make use of
> > SMEM to detect the SoC ID.
> > 
> > To handle these specific case, check if the SMEM is not initialized (by
> > checking if the qcom_smem_get_soc_id returns -ENODEV) and fallback to
> > OF machine compatible checking to identify the SoC variant.
> > 
> > Notice that the checking order is important as the machine compatible
> > are normally defined with the specific one following the generic SoC
> > (for example compatible = "qcom,ipq8065", "qcom,ipq8064").
> 
> ...
> 
> > +		if (of_machine_is_compatible("qcom,ipq8062"))
> > +			msm_id = QCOM_ID_IPQ8062;
> > +		else if (of_machine_is_compatible("qcom,ipq8065") ||
> > +			 of_machine_is_compatible("qcom,ipq8069"))
> > +			msm_id = QCOM_ID_IPQ8065;
> > +		else if (of_machine_is_compatible("qcom,ipq8064") ||
> > +			 of_machine_is_compatible("qcom,ipq8066") ||
> > +			 of_machine_is_compatible("qcom,ipq8068"))
> > +			msm_id = QCOM_ID_IPQ8064;
> 
> A nit-pick (in case you need a new version of the series): I would expect
> the conditionals be sorted by assigned value.
> 
> 		if (of_machine_is_compatible("qcom,ipq8062"))
> 			msm_id = QCOM_ID_IPQ8062;
> 		else if (of_machine_is_compatible("qcom,ipq8064") ||
> 			 of_machine_is_compatible("qcom,ipq8066") ||
> 			 of_machine_is_compatible("qcom,ipq8068"))
> 			msm_id = QCOM_ID_IPQ8064;
> 		else if (of_machine_is_compatible("qcom,ipq8065") ||
> 			 of_machine_is_compatible("qcom,ipq8069"))
> 			msm_id = QCOM_ID_IPQ8065;
>

Hi as said in the commit, parsing 65/69 before 64 is needed as we might
have compatible like

"qcom,ipq8065","qcom,ipq8064" so we might incorrectly parse msm_id
ipq8064.

> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

-- 
	Ansuel

