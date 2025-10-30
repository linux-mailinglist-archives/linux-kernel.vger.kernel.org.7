Return-Path: <linux-kernel+bounces-878090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D169DC1FC18
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6A50425E1D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2143563CB;
	Thu, 30 Oct 2025 11:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAJwvwqU"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B6B342CBB
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761822706; cv=none; b=gUdQO+mnfarfqlKR/Xs2Fq1767x3t0m2fnUY5WHCIeDA3z8z9K4dNw6ez2dMUP+49K5/fUl8u+vCJFaG4hGp60Ko5xlxedeVDFRZdQOukFs4Kl8iVvUwKvf6LOGl+FcEro1LmJABKSH2emek6CH4FtT2/iDYwd6p1diSVgophyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761822706; c=relaxed/simple;
	bh=RmUR81Vp+1u3hIuZWAFJx55ZbSzWgS/AvpxG9kE/93k=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgKIp9+IvIyHtuVapyRt14K+JVy3yOCMaPNzgWuIQpe6gixHCvofEEILAY1h2zGgfHuSVdtQgxy6/TYFIAH6813QcB9LTLMJmyt3PoUsccxKfQEwt9nRp1v+29g9yx1y2zCpkE9HmKW/bAf4t92f661rqbSAFFFjspa9AOpbREk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAJwvwqU; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47109187c32so4977955e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 04:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761822703; x=1762427503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f0yQfjJh3fnP4ZqkUoVVr4XyZOI4wGNOEVBXCVxV97Q=;
        b=QAJwvwqUnYRoTyfxcGAdOFy65vlKoGrDd6UiwTELdGIVSnQN4YMlI+lbpthUhACL/i
         TXgVJWYrHIuJdLXI+TPGDLCnPUOD6F3PQ7YWWyQn28d2rRKI25aQnF9uODpvbkKlMhWG
         NqwwTpU/3Y1JzB+u+sk9Dc6iHGWgVGwLTwovHIAq7FCu7Wv9yT4r0g4oNbE1AuHs+cfD
         d7QcWaFwAOZSyRH0Uar+wjUkN4mnsm9I0jQe//2NFjMg8QU2b5po883KIU8SLqhSoB6M
         SvfBBQO4UX8LUHw7E8mLc3ouYzxjFngCxJuF7EDCeJC9Zdi6X8IUR3PMOa2r6+T2glpi
         XsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761822703; x=1762427503;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0yQfjJh3fnP4ZqkUoVVr4XyZOI4wGNOEVBXCVxV97Q=;
        b=clyl0CjQbCkBm7+TF73a7/pagKFMCy7DpfQPee+u1BTsYIMt/hAz+7/XiU6At87zMr
         xUIygXgyz1K7CzNAaGJAxHH7aH73ja3zt6m5kXB+hGMjOvwoRhguQ7QGwmNaQtPZWaTj
         ooQKiaqGa3fAbef2IFc+rtJ1ZneC5NR1KoIalCmhmZx71my9+pJZmWZF7IBCabiL6O8r
         /GoquoPREnDTAdbvWO7aSp1KpMlLywZCCEPawyMa20t07oGYgSezRXO21L2gRuzaYKGz
         w1ZcIfBL1oBw9VMeVHuNaGohVRSAakNGhirrEPjYET0zPTiVgs8qiCFfIB+4Kvrf3XY1
         Obew==
X-Forwarded-Encrypted: i=1; AJvYcCWyvz4Nblj5r693ifTow9eyIC0V1wG6sSR7dwB9PU2Rzhn/1hbrgbWcg0o+11PXcKXvU9kuE7pXAG/8QQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWJr+LwgsNfPRLItbyCYaDKoGw6gGhaezNvAD2W3tVogW3ba03
	hNSXUViE3rYgNHbpyTDOwQ5sksD4FHzq9tjcPk79nhRsp4HtN3ZymYgU
X-Gm-Gg: ASbGncuc+AeJ9JTryFN02o9CitdjgJpv6g99xOLJYft7Y0u7UVH536wSpviJonm7K1W
	k4U8eNw6yiHDxqISEruM8Z/7OnlKknOrp2VfZaG3Nd9LRw3b7QmdQOg8HQ3bpaHSrCGdPPLjOZR
	etGB+3qx8wCQPXrlMkTSaL3cHAAtvXRgDz5Jp3pGuUnN7dF3Sx4G9nDCy5cCUJ1800K7y728vrX
	KPhV87RNrKrYweVI1vG+j4MEPlrc9mu7eI+g2Q7XFufvOYgs+J04KKYy7DTr1XMHfbgQctj9cFx
	op3svwL9txQIlmOSQkbgV2bHeT+F4ks29PwzLly+z86z2OdjzqeYAi3b81OGwzqCA29TVBUJoOU
	oQ/Vd8y5I/dUuhElhiLB/P1gET7DQvZ0PZgY0/Ffu9tDhrNMsAkfea3cl3RwrOVuM1F97F5Crq8
	kagiDr5YeXacHrosdZYwoC2uEjIOZI
X-Google-Smtp-Source: AGHT+IHxhf8stS61kYSKITBJZM63qOEpp0Q9HeczTOxUA5TPtzWHnwZWNRGkjWICXEC9IRZOfnm8Dw==
X-Received: by 2002:a05:600c:19d3:b0:471:c72:c807 with SMTP id 5b1f17b1804b1-47726005eaemr24937345e9.22.1761822702490;
        Thu, 30 Oct 2025 04:11:42 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47728999a4bsm33080805e9.2.2025.10.30.04.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 04:11:42 -0700 (PDT)
Message-ID: <690347ee.050a0220.21ee29.8092@mx.google.com>
X-Google-Original-Message-ID: <aQNH7Lkzq5D-fsHs@Ansuel-XPS.>
Date: Thu, 30 Oct 2025 12:11:40 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Ilia Lin <ilia.lin@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Raag Jadav <raag.jadav@intel.com>, Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] cpufreq: qcom-nvmem: add compatible fallback for
 ipq806x for no SMEM
References: <20251029133323.24565-1-ansuelsmth@gmail.com>
 <20251029133323.24565-3-ansuelsmth@gmail.com>
 <9343108b-7796-4783-afb1-afe758f78414@oss.qualcomm.com>
 <69033de7.050a0220.34ea6.780b@mx.google.com>
 <c9801322-2184-4f04-9459-960580ecf6a7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9801322-2184-4f04-9459-960580ecf6a7@oss.qualcomm.com>

On Thu, Oct 30, 2025 at 11:54:41AM +0100, Konrad Dybcio wrote:
> On 10/30/25 11:28 AM, Christian Marangi wrote:
> > On Thu, Oct 30, 2025 at 09:56:24AM +0100, Konrad Dybcio wrote:
> >> On 10/29/25 2:33 PM, Christian Marangi wrote:
> >>> On some IPQ806x SoC SMEM might be not initialized by SBL. This is the
> >>> case for some Google devices (the OnHub family) that can't make use of
> >>> SMEM to detect the SoC ID.
> >>
> >> Oh this is (the unpleasant kind of ) interesting.. Is there any sort
> >> of uboot/kernel tree for these machines available?
> >>
> > 
> > There is some sort of source but quite confusing. From the info they use
> > coreboot and chromeos.
> > 
> > Looking at the source they comment everything related to SMEM
> > (confirming the fact that they actually don't init it)
> > 
> > [1] https://chromium.googlesource.com/chromiumos/platform/depthcharge/+/refs/heads/firmware-storm-6315.B/src/board/storm
> > [2] https://chromium.googlesource.com/chromiumos/third_party/coreboot/+/firmware-storm-6315.B
> 
> Hmm odd..
> 
> The patch itself looks mostly good, although you e.g. assign
> qcom,ipq8069 -> QCOM_ID_IPQ8065 even though QCOM_ID_IPQ8069 exists
> 
> This doesn't cause any difference in behavior within this driver but
> looks slightly funky
>

Well yes I did to simplify the logic.

> Should we perhaps do this patching in smem.c instead, in case other
> drivers try to retrieve the ID in the future?
> 

Well we would hide the fact that SMEM is not available. SMEM gives
precise info while this operates on some kind of fallback measure. If
someone wrongly sets the compatible and use the most generic one
(qcom,ipq8064) then we would parse the wrong ID.

Also looking at the user of those API it's really just cpufreq and apss
for ipq60xx so maybe not worth? (we would also have to add additional
logic to fallback only for some specific SoC)

-- 
	Ansuel

