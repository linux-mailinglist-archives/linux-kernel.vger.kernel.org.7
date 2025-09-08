Return-Path: <linux-kernel+bounces-805344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14708B4875E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39C617B155D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672472E8DEB;
	Mon,  8 Sep 2025 08:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DeoQeGoC"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D587081E
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 08:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757320624; cv=none; b=Wm6C8VNR/UXNmBkrUmFvYS7hAb+jM1ZhXgUmhejaEdqfNNj1SnzLIHwdBBk7z2ZzRXgsNczjXkgQ03cV1qzNXar64SN/EHrHuvXw2MjHKFejbOYt6rbLb733jWnebouHSQX9jxOOcxb+bgve6N/gAgpRO6sXK9hXNpQ7G1eg4g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757320624; c=relaxed/simple;
	bh=NXnb+PUluiL2AhSnB1IAsaQbX54JUl7zDPq2/38XIo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxrzz8iR2c5ZZvOW6SvPtpoL47/cst+80wIcPiDisaYI2IMHCA9KsL3kH+HuPK/rxZszJyz2gNrPic1Dvfh5lcJZx0UbNXMRfz4aULBRsWnblZgA9lDFTQZQDP194d0vnF07dZfY6j2WogsXuWOXUWMcD7xwEQ+MUTls2OotwIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DeoQeGoC; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b046f6fb230so682265766b.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 01:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757320621; x=1757925421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1XH0JCQWRm8WTHxpKfgo5DMbnz5sypzW+t0+NXBLukE=;
        b=DeoQeGoCkIZbJ0qFP6yaMOh4YHZegb30G1mfgxHCThNf6a1zwkgsnKo+QtEAX888Cb
         7+QBxpGT9VhSAE7M2sXITAG4ZGPBy/AgktBhIwk710XdFPRJ6iytOLWsS1p6a0t3bvLQ
         LQKTL3icelHKaP5LaVbc9A55AvbmIa9LbcGZNggtoJdmi2ppPqnOEa9VQT4dIKeu9yOO
         oVMV8BigZvZshWaAXUuYEjzTNLoXGeXCDfhTbChbfVQAFa2xlKXGR00Mkxzox+ncvlBp
         RtzoBdqBNHc+yLrzm+4X7e6qQTo9nxPt6/1ARMRQHGiHsCMXzeqPo0pKjVnBf8SdS26f
         +3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757320621; x=1757925421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1XH0JCQWRm8WTHxpKfgo5DMbnz5sypzW+t0+NXBLukE=;
        b=OS4zXOkd12lRbS2EElI9CmFyAfoOhQfvC4O8MMffSMAmoaJBFAbVgm5Ed4RON0zm9z
         uDpxRO7D96QHQoDQLnehBSgE6qic5X18Iw0WIdxiQ6YyA0JIrhtlAaUjHSSohyUum0at
         CT9oN09w2qvQ5q9mbZzhZu9H+b78Y/u3Xn3wCD1LugBynCnq7RFCTF/E2akzpIFOox1u
         k5szg2yb1mzpbKOMvc57ncmqf62dl70bGqmo8c6nl+tbaEKWuEhcU0SBshBEPuDwjJ9E
         Vq9D1HNnUs6K0yZZgyHP3T3WwkG4rOoLUBwut4ervExEcoXfTrPnaSJGsqV9TtxsNJ7D
         KyLw==
X-Forwarded-Encrypted: i=1; AJvYcCUpqnCfX9x7OLIacK8swVruS1JWyrIa/OAXoff1AIybRivAczxGqOXyGZw1k36nKFpA7hr9ev/YCE157Y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzHbPlP+QP4DXMBm77uWApSDNdJIeThYYwPP64OzaL6CQ57PS7
	7T9Y70w8u45GVyT2BbtwnZ+F/N3zAjkNuJ2BQwM2I1Sjydb3cBCojEfd1Vv9BuV55FY=
X-Gm-Gg: ASbGncsBanLE3AmR9DO5IYys+Pi7mrLHrEuuiYpZ9qh5Rb8AtmBfkxSe7HsBRFAfhMh
	eRgEU54d3cwCbmyquwwj7R2SL3xE7JWK4LLPJu49sOCIGbuaHZGM1F86kslArzyZJB36bRSO8g4
	mfg1JQHzNnNxYE8MWofbzMUhrWAwR3Q3Cl5LUS/7olqhjLk5tzvFqwrzcEg/OkpKijblVilcBuC
	/e5OpgzNGbF9f07UnhImTgktWtJse7g6bQWw98ylhiTWLykov2BCdpOPltEXtpXG+fikqBGGPOV
	DQsg6Z224Qxk+OMamry/dyV+RzrjJwoAxSUH7eJzqdAUVD6BLu5xfNrXqMT4WeF9DioNY4S5oTC
	rvNDqPBmnDLdgy147h6TqGCQa1E+oKiWs
X-Google-Smtp-Source: AGHT+IECPDhPNh/BGrjoNwZ3MFMyy/CdulLWdnO4Gww80R4odqdHGExKH03tYQgvNoDXudzRKyAP2w==
X-Received: by 2002:a17:907:9691:b0:afe:ed05:2e68 with SMTP id a640c23a62f3a-b04930ac043mr1180321166b.11.1757320620463;
        Mon, 08 Sep 2025 01:37:00 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:30:1f60:42e1:1e1b:d240])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc52ae40sm21501622a12.44.2025.09.08.01.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 01:37:00 -0700 (PDT)
Date: Mon, 8 Sep 2025 10:36:55 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 4/5] i2c: qcom-cci: Add OPP table support and enforce
 FAST_PLUS requirements
Message-ID: <aL6Vp-3er71AJPJd@linaro.org>
References: <20250904-topic-cci_updates-v1-0-d38559692703@oss.qualcomm.com>
 <20250904-topic-cci_updates-v1-4-d38559692703@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904-topic-cci_updates-v1-4-d38559692703@oss.qualcomm.com>

On Thu, Sep 04, 2025 at 04:31:23PM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> The CCI clock has voltage requirements, which need to be described
> through an OPP table.
> 
> The 1 MHz FAST_PLUS mode requires the CCI core clock runs at 37,5 MHz
> (which is a value common across all SoCs), since it's not possible to
> reach the required timings with the default 19.2 MHz rate.
> 
> Address both issues by introducing an OPP table and using it to vote
> for the faster rate.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Using an OPP table for a single static rate that remains the same over
the whole lifetime of the driver feels like overkill to me. Couldn't you
just put the "required-opps" directly into the device node so that it is
automatically applied when the device goes in/out of runtime suspend?

And since you need to make DT additions anyway, couldn't you just use
"assigned-clock-rates" to avoid the need for a driver patch entirely? We
use that for e.g. USB clocks as well.

Thanks,
Stephan

