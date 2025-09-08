Return-Path: <linux-kernel+bounces-805352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B03C8B48770
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4EA27ADB7A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C7F2EC548;
	Mon,  8 Sep 2025 08:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FP0eevmp"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B232EBBBC
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 08:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757321218; cv=none; b=ZUJ9K3TUZvZN2sjYGi9wyxoCoob0BJUMiCguL9ajZ1aNv6O3bDFFmyuSeY0PqBnG6zI3s8dPVHyX+UqwrdFwVCqPi6qBhtv2D7xbUtvrkW948bzU6JkwAFYFgNnBXdz88htU7fO0x36Gy+saqHkbVkYmoQcam+Kw7bsYvvY+dcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757321218; c=relaxed/simple;
	bh=Bj4f5uRY244iHB4rE4uWa8vhW6auxFTmI1aaD09pYy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELnAa/Tz7wyXDM38fJiVYmF4463AFnNdAfcvvTRxXQxGeO26HmHAzBmJKtdVlObav0IqMB92238Kf4gbpqh1Eh/QbY9qkJCKP1Kp9MNcPph50/D9qGhSSNC8vgYFXAbpofQOh+lPTyj4YNXIrYPHmafjzwsfkaewb+1T1HXLY9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FP0eevmp; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-61a8c134533so451200a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 01:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757321214; x=1757926014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IUopr+FL50FcSWn7mytwl0gX5Rr+3JnwzdeTq9mrxQQ=;
        b=FP0eevmpxMLL1QI9kUun0x+ZnATStLbZKIMV5RmbfA//BUKxCN46WaFPfXJklhEvWH
         d3OqiuCPiFkCD/SmqFx1DUzBTxeSfsFhKIN7nBGjD5NiUKWgKuRT4MsLHQmjc0vtsmyE
         iLbiIEeD3KiSfZmfCUOoE9RtkLVscQGxaG67yuRECdZrJYmeFn1o9VebwCRnaXhjFvMk
         gHTNuzXFeFVhBoXHGYxDOI+U3ko3LRy2XWtJbsHZALcS5sWHX2MWtEEVLprBBt9F+MAJ
         VfI1AjRxlIKZvrjhOgD8CO3gY2VGw7QMQ19oZRDnpe9G0yTMf2tsKWS65QarocXYULXR
         /WxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757321214; x=1757926014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUopr+FL50FcSWn7mytwl0gX5Rr+3JnwzdeTq9mrxQQ=;
        b=cu8bqlnLbC5tv2WyPu2DdcgYgW33g0rqVN+HkTPKve9BrL3re56x4mcXrbguDK1QWm
         jfpVL1omjNLBYEVdAh+dBLAEDgSX3rhwa5gIzyozfgoTkTKHWW/Uc9vGDiTC/Ppz3MIy
         4ilsUngTuz5IHIkMBMNv87s5Cf8+HQGrlYQy94aP8/Tpz5uT/D8fWENQ4wSTMJMyC93l
         aqJ53umiLEptBcoRbh53ElkIhjt+R+XeKqq6dsDqhqK/DEXO1Aez+nb/xQhn2npVq8nw
         mnUJrFQPXibzPZwRamEQ13ObhgeIKLbd97LY1/PVgavCTAtvRgvQW9KOaZPBp9rgAL02
         Qujg==
X-Forwarded-Encrypted: i=1; AJvYcCV4d3sWItYzF875zVFTaferuQhPws5XOLE2GlYHDMFt9UGagFPglExcwpkSM446IYQSRKNJhBukTGLpVDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkZG3Brosqn6M7WMP+T5W9GfFHFZZfX7dMYY13nYcTyDKx9IVr
	9b7ZGadYxa2J44ZCQ++Uv/D4GlgaokgUregDR4She4uGQgEAS52Sm1OwWLjDPy4x8mw=
X-Gm-Gg: ASbGnctfYDLGUOA/pG88vuqnr1LmE+DWY0IpB89gbb190LpLpofkNITSu+u7+1WCyPP
	B+sYOdEBFpsd3PDHdM2YWSAWYQ/aYYXzS2z59QLuvd0VkeeWWqN+3Tt9KxFX6iWjTWJ6pj0vH+J
	ZAJfLnBpmPLr1JGq9KMdBYj2EYQWZSd1HVx9s08QLKmOMd2Avtrj2ND8CbELv9V10jhlllnFV9Y
	aayqQnnNYIo0Je/MHE8b8usEffUZFq2n6bHQA8sdKuV46/ntbHQLSiMA3nJ+0PviVhQVG7RuNJw
	slnU9hxjQz9BLc7vnix9AKAO/fcy1tx8TwFKIzcUF9sIOBpysTnjgTb1nCjxMcVwqH6QcQwQjSv
	eDjeYqOtjlmnmWKzOT1OYKZ/Lvjt03XcVSnIY8yMQDqdznRXHF4a7sQ==
X-Google-Smtp-Source: AGHT+IGJq4/stKcb5/47RwYSY/9mKYvHfYIb+Y8TD1SuUTdb5c9q3HcwFqg/ndym+yPEqRaT8vxf8Q==
X-Received: by 2002:a05:6402:52cb:b0:61a:967f:55f9 with SMTP id 4fb4d7f45d1cf-6237b972390mr6163555a12.10.1757321213876;
        Mon, 08 Sep 2025 01:46:53 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:30:1f60:42e1:1e1b:d240])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62343271613sm5201516a12.23.2025.09.08.01.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 01:46:53 -0700 (PDT)
Date: Mon, 8 Sep 2025 10:46:49 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH 4/5] i2c: qcom-cci: Add OPP table support and enforce
 FAST_PLUS requirements
Message-ID: <aL6X-RiCyPVbHlYN@linaro.org>
References: <20250904-topic-cci_updates-v1-0-d38559692703@oss.qualcomm.com>
 <20250904-topic-cci_updates-v1-4-d38559692703@oss.qualcomm.com>
 <aL6Vp-3er71AJPJd@linaro.org>
 <f508bf92-a513-467a-a946-17c41e1d72d1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f508bf92-a513-467a-a946-17c41e1d72d1@oss.qualcomm.com>

On Mon, Sep 08, 2025 at 10:43:50AM +0200, Konrad Dybcio wrote:
> On 9/8/25 10:36 AM, Stephan Gerhold wrote:
> > On Thu, Sep 04, 2025 at 04:31:23PM +0200, Konrad Dybcio wrote:
> >> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> >>
> >> The CCI clock has voltage requirements, which need to be described
> >> through an OPP table.
> >>
> >> The 1 MHz FAST_PLUS mode requires the CCI core clock runs at 37,5 MHz
> >> (which is a value common across all SoCs), since it's not possible to
> >> reach the required timings with the default 19.2 MHz rate.
> >>
> >> Address both issues by introducing an OPP table and using it to vote
> >> for the faster rate.
> >>
> >> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > 
> > Using an OPP table for a single static rate that remains the same over
> > the whole lifetime of the driver feels like overkill to me. Couldn't you
> > just put the "required-opps" directly into the device node so that it is
> > automatically applied when the device goes in/out of runtime suspend?
> > 
> > And since you need to make DT additions anyway, couldn't you just use
> > "assigned-clock-rates" to avoid the need for a driver patch entirely? We
> > use that for e.g. USB clocks as well.
> 
> This is futureproofing, in case someone invents FastMode++ with a higher
> dvfs requirement or for when the driver adds presets for a 19.2 MHz CCI
> clock which would (marginally) decrease power consumption
> 

If 19.2 MHz CCI clock is feasible and has lower voltage requirements,
then I would expect a separate entry for 19.2 MHz in the OPP table of
PATCH 5/5? The DT is unrelated to what functionality you implement in
the driver, and that would make the OPP table look less useless. :-)

Thanks,
Stephan

