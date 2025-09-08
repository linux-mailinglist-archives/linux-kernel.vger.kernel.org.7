Return-Path: <linux-kernel+bounces-805485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9D8B4893C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A96D01899B9E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389E82ECE95;
	Mon,  8 Sep 2025 09:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BXiHg55P"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB231A5BBE
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 09:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325436; cv=none; b=nNacBnnQM/A3C0yiLGPvsR9E3/ZACa32pY9a1A5AAXr+ivS+DZYd8fOn3GbqDLsBpEpKRh8YYCtUnP30hvwz1wKA4OmIGio9V6MbKVG/3IOvbFtx/upjpNUqzVL3SgzxblW6lPQCJ6njtYbiRMCLNQMs9H+mfMB42A9sWfn245A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325436; c=relaxed/simple;
	bh=ykDwW2zeFPOxeLSt8zP2A70oe7r13xxaM+2jTS0GedI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+NISsw8RReJuaKpF7WFkZzO4nYUmvK4SixSSC2H5wSfgCHXb78kArqZTKPFDPqLMNKIKZ6KWlFz1L1UucLHiQrD+ZsJZ1J98e0gHgEU+8FdlKA0Ue0O0KGV5Ueu+K2fBZ/qgVSh3wlUxYPK8VU2/8RIreL7TqcEAfemP/th5hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BXiHg55P; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b0415e03e25so584198266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 02:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757325433; x=1757930233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=haIepL/P0jz30Rbxjb0+O92cxvQz/NbDyzEigt7PcCU=;
        b=BXiHg55PXsd7pKl2UP/uL6qEdKOPNWomPgRlOWdq2sS0g9aXM2fTiSn0EVHCrFIjuT
         TKX9YtprnB4Zi1G7REEYpu+RoJMlguPrKiWZb0E2zUHQR3mwEpLOsglb4Fu9slNugeba
         nIH6SZJ/1aiw8pM1ZDda6ofh5RrFs1mFXsk+AdNnisyllcnx2uDngEwDQYnvsdL5AoJ8
         iSuNnVpnSSRqjnJZDo0mfPuEAOAjB6xXKuxB6oQ7WifUVnvD4ZOLH0gDpERWr1Z4uPqm
         2Bg84/j9cidiKwf/Rzk5yOUTbKt6HR4bh6oeT6Y87OoVaRR6Tin4bCS5Hbl+iYHyLTq4
         tYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757325433; x=1757930233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haIepL/P0jz30Rbxjb0+O92cxvQz/NbDyzEigt7PcCU=;
        b=H+FdUXqxTM7mimFA1eAdZwmC9SF7ZubMRyF49dCYE5E2hVqSAUj5pFkunmpf6/hyLZ
         MlzI4S3w+MJWLpSBvF15Hndkdmw8+qdjeB9mjmrOxzkbMfwqAWR1Hf1tKf5jH2uLNnIP
         MsArMyhVFqah6RkTMw2awZT9GZgalLSOIZRXOoUlu+Z644V/xkrhz698qVQVfOUKxl15
         ESmNliffOzqgwvQYrVImZKglJ/Tqsz53Sn+ApDhdN7oE1XkE+dh9m+08UPRiKoIU7w4E
         6EXmIhUvfaldJAE6zpghjHo2jl2VvZWtAAxGcOdkm2Yq7kMPeFl9T+ls03w9ZXnTnibC
         yboA==
X-Forwarded-Encrypted: i=1; AJvYcCV97lmwSPg95yBFVoNQ+9yE/Zx2k0lX3M4+7pS1JZ6b09f94F/TKhw1u4YKIeJHgyunexwD6WVQMzqi6VA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBagl/iBmFpALco91FfMrCyR++lYj3gJ9wc1b551ebkolXrLAj
	A4Xh7xeSbkVDys/MOmOGmNpIAFssqMfjINfXiRidFuJyAT1kDGBEVlvBcor3Q/5pVzE=
X-Gm-Gg: ASbGncuNntSTDS7zPpALJsNVkgjrLTtaCJuQxhB7UUz7t86DoHLp3N0hsmpRV+KYY2x
	97hmLwYXm/6Tu6zrjQNphHrbZmHh4V2zYwcu+8aAW06N8y+R2nmyIenkJQI/BKPQ1wtl8uGgdH4
	sCOG28QzBzpTKDiAtXqXfHddsu6MHltee4R1MjNWD5RP4aKKNj+qls/4BeILrBQV/24W94DEoJl
	FjBjbTxE61I84E/ytiZoafIad5YLtlZFBN+huhYQ3HfwVbfY2jUbD+MFOz1xlkfYrsiC8I0kGQK
	wl9UXE1NXDw4HAWwMzdX+5jQlUh8mSwvqctu+z38vlPxT9u9uDd05LWlO/N2TUtDmVU6MXhl1M2
	D6IKSC61Oj/7lRvIOXvpUO43hAuF7n86S
X-Google-Smtp-Source: AGHT+IFYq6V5J5rXx5QgUvWRFIgmg8psdjbRgWhuE+b5PuhIMU45skzaKalA52LZGkVjQ1Apw2J66A==
X-Received: by 2002:a17:906:d554:b0:b04:48c5:340 with SMTP id a640c23a62f3a-b04b13cd56amr710023166b.9.1757325432564;
        Mon, 08 Sep 2025 02:57:12 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:30:1f60:42e1:1e1b:d240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b042523ee7bsm1959154266b.109.2025.09.08.02.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 02:57:12 -0700 (PDT)
Date: Mon, 8 Sep 2025 11:57:07 +0200
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
Message-ID: <aL6nZdJCKmnWcswB@linaro.org>
References: <20250904-topic-cci_updates-v1-0-d38559692703@oss.qualcomm.com>
 <20250904-topic-cci_updates-v1-4-d38559692703@oss.qualcomm.com>
 <aL6Vp-3er71AJPJd@linaro.org>
 <f508bf92-a513-467a-a946-17c41e1d72d1@oss.qualcomm.com>
 <aL6X-RiCyPVbHlYN@linaro.org>
 <5178a6b1-1b5a-40d9-af40-68ee13975509@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5178a6b1-1b5a-40d9-af40-68ee13975509@oss.qualcomm.com>

On Mon, Sep 08, 2025 at 11:49:52AM +0200, Konrad Dybcio wrote:
> On 9/8/25 10:46 AM, Stephan Gerhold wrote:
> > On Mon, Sep 08, 2025 at 10:43:50AM +0200, Konrad Dybcio wrote:
> >> On 9/8/25 10:36 AM, Stephan Gerhold wrote:
> >>> On Thu, Sep 04, 2025 at 04:31:23PM +0200, Konrad Dybcio wrote:
> >>>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> >>>>
> >>>> The CCI clock has voltage requirements, which need to be described
> >>>> through an OPP table.
> >>>>
> >>>> The 1 MHz FAST_PLUS mode requires the CCI core clock runs at 37,5 MHz
> >>>> (which is a value common across all SoCs), since it's not possible to
> >>>> reach the required timings with the default 19.2 MHz rate.
> >>>>
> >>>> Address both issues by introducing an OPP table and using it to vote
> >>>> for the faster rate.
> >>>>
> >>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> >>>
> >>> Using an OPP table for a single static rate that remains the same over
> >>> the whole lifetime of the driver feels like overkill to me. Couldn't you
> >>> just put the "required-opps" directly into the device node so that it is
> >>> automatically applied when the device goes in/out of runtime suspend?
> >>>
> >>> And since you need to make DT additions anyway, couldn't you just use
> >>> "assigned-clock-rates" to avoid the need for a driver patch entirely? We
> >>> use that for e.g. USB clocks as well.
> >>
> >> This is futureproofing, in case someone invents FastMode++ with a higher
> >> dvfs requirement or for when the driver adds presets for a 19.2 MHz CCI
> >> clock which would (marginally) decrease power consumption
> >>
> > 
> > If 19.2 MHz CCI clock is feasible and has lower voltage requirements,
> > then I would expect a separate entry for 19.2 MHz in the OPP table of
> > PATCH 5/5? The DT is unrelated to what functionality you implement in
> > the driver, and that would make the OPP table look less useless. :-)
> 
> The frequency plan for 8280 does not recommend any rate != 37.5 MHz
> 
> For x1e80100 however, the lovsvs_d1 corner is recommended to be 30
> (yes, thirty) MHz, sourced from CAM_PLL8 for $reasons
> 

The 37.5 MHz rate still exists on X1E I presume, or are you saying we
need more changes to support those odd 30 MHz?

Personally, I'm not fully convinced there is ever going to be a use case
of someone using a "non-standard" frequency. Even if "FastMode++" is
invented most devices will probably want to use it. And the voltage
requirements we're currently talking about here like "low svs" during
camera use cases are kind of negligible compared to others too.

But I'm fine with either solution, just wanted to mention it. :D

Thanks,
Stephan

