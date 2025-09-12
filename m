Return-Path: <linux-kernel+bounces-813878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DD2B54C15
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5E611CC1F80
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110C430506F;
	Fri, 12 Sep 2025 11:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sOLFe6yr"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EDE305047
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678072; cv=none; b=gBqs8JCOliBtglNvFAT1jJJNM2KUu2mSkSgpOR02yKQHyJssjCb5se6Um59sMqX7Ad+vMQmHX50xiIyA7yuGBkXpXKgxwVLAHo4Zd5PZVfzNN0JLnZdVejeGrtmiicjoN16REsIFaOvU2x3kaNpsoychAmHMA5lBHL2YGqplFBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678072; c=relaxed/simple;
	bh=8dgmXcEXo5nsJzSSoA3jVdxEsyn6/n1s9RzyN/4VNOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJX9IuhkCf27ZI/69VIS4a/YotDOue4Q6AuqGpwSLbikwBKmtGlvLutSNsXzL7hJC5YDrXSqEd6qiwcNAJC6SMDga04PoLDMAcOXcNBH9hCtiAa61ol4Zc69xPNnSaAEbqYuerpXAe34JI7Vitgx4Oa+RErnLSiMK0uuYCHz+1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sOLFe6yr; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3e7622483beso972079f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757678069; x=1758282869; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YKMe+P5Fr/vS0uG6/IhnGfpfCTdnh1yfTxc2uPgb+IY=;
        b=sOLFe6yrJegUFi/E1thfflAhGqdGSASQdg5Vtp1Pueew9X+Oyu+rCc8QOsubSTv0Z3
         tbljMU4JtiuSdxNCDnOwT+K/dK0pacMXAkJyuh2UkzlZiurZzgiAUBLvT5hKCU9Q60iJ
         9bmTM4gR8c1Qme2rI6WXDiZjqW245+LqnzFEqH5rSw1fZF27euX2Q1O0kNhTV8jGqOnv
         oP01yLp2/pGVSSA2tw1PfBJlTHKhShLx5ZDl1GRO6TTWxkqPXEk1J8prXCaiTjI/AHF6
         YbhwyufGzFNKbGVX3wJ7wOXVCx3rwMQTpXTshMXhhN6pDqJr+3xM0c5CIlkBEYrTMjiY
         8Ieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757678069; x=1758282869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKMe+P5Fr/vS0uG6/IhnGfpfCTdnh1yfTxc2uPgb+IY=;
        b=g9ys5/+rzieALALXmp/nHciyGZq7Qg5p5exEjTy0NZ5gM8vkMHlXFOu7JJsQC3/6YC
         Z+XQRqj88CCd/v10md6ure6LxzGvY3rL9a2tG9Qqi/fJq8OmtWnYO+3ahBfXfmpGXhGP
         hzfU2tVv0lnXqo4LscpdxufF3a/nw5oCSI9sOWx5jTiJ4wwMY/k3vOcVDkBr7hnRaw91
         YiEAuGn/o5/VIN4XAXmzU0P/ZUNjCYPP1hmCDgJHhqJtDigEeGgXgA3JpFz3TKJkwE7L
         B9mi786ah+0+qiRyvZTFuVnIaOTPWQwZMWeGm0o4okVrpJNgWU6hn8JOChkhhXs0JX6v
         5lOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOf80X4+At/CKh60tSvl+/z1TqgJW5SB8ifml27eMf1F5otuEaQtEbUcG59Wc6V49bbia/FYZvqQx3g9o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+DttOT9rG5sULy6GQw3IRNbg+uPxHLfuNrgJUzhxi2gv5P09e
	yrZMTv4VhdfOUSvINi/UnJlEdSTRmlUCY8jAiFJA/klpjBKDhPpdaxcbzje6vXuDu/M=
X-Gm-Gg: ASbGncuyrWdv7wlV3RKxVry0lmI85a/IpsrZ3mTCnjWo+WjhGo0IBCallLrfoBgzyDB
	AMLcaT4H5szueQ2YQhcNjzJiBsR/RpAxx3Yo5Dbm0Zu7vT8hKl1BnNLdylGpu+XpaJko+BeY26+
	1tHKSy9DVUuK0ZqOGbpvzNPLRKSMb5gUTZ6uwpdExv14hCnslXoWUVtQkvy75Cu+8dGol0WtQV1
	5+rQlvCIRudicyK9snyXWnIunXnjXndLagrm5lyviQdMAlhOEgzyXP2gcBHVyWuHkqVnNCIyLm8
	dGK0c80n6gQuDuDC9g9hiMg53plTDS/DiZovmPGeWf7cN4nYzSEvNpiVqPO5FGl/yOn5k4iyx8E
	d6/AbiefWvUPUdOTO779pAfi8O3ANrhde
X-Google-Smtp-Source: AGHT+IHZe3QhjYeZXRc81ioWKEpY39bxTqa5DxavkXwYBbtVB2Q2U+jSa501cmQkL7HE6ZiRiepFww==
X-Received: by 2002:a05:6000:2c07:b0:3e2:e079:ab32 with SMTP id ffacd0b85a97d-3e76579abc9mr2041088f8f.7.1757678068685;
        Fri, 12 Sep 2025 04:54:28 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:30:e708:677f:913a:8288])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd27dsm6186965f8f.41.2025.09.12.04.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 04:54:28 -0700 (PDT)
Date: Fri, 12 Sep 2025 13:54:24 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 0/4] arm64: dts: qcom: x1e80100: Add IRIS video codec
Message-ID: <aMQJ8Nb7TZNmD1Vq@linaro.org>
References: <rPv92n3EVkoRrO1v7nlw_tPMn-nHUhpYhQP_FjmQsESL752mly20FWQqPHLs8JHGC4mklm9wfPABc5kd-x4LYg==@protonmail.internalid>
 <20250911-x1e-iris-dt-v1-0-63caf0fd202c@linaro.org>
 <980b7247-e8a5-40bd-ba20-c9c72c8a397a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <980b7247-e8a5-40bd-ba20-c9c72c8a397a@linaro.org>

On Fri, Sep 12, 2025 at 11:24:21AM +0100, Bryan O'Donoghue wrote:
> On 11/09/2025 19:38, Stephan Gerhold wrote:
> > Add the necessary definitions to enable the IRIS video codec for
> > accelerated video decoding on the X1E CRD and Lenovo ThinkPad T14s. The
> > additions are largely copied as-is from sm8550.dtsi with some minor changes
> > necessary for X1E.
> > 
> > The PAS interface used to boot the IRIS firmware is not functional in EL2.
> > The code to start it without using PAS exists already in the Venus driver,
> > but was not ported over to IRIS yet. Discussions how to model the
> > video-firmware IOMMU are still ongoing, so disable IRIS in x1-el2.dtso for
> > now to avoid regressions when running in EL2.
> > 
> > Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> > ---
> > Stephan Gerhold (4):
> >        arm64: dts: qcom: x1e80100: Add IRIS video codec
> >        arm64: dts: qcom: x1-el2: Disable IRIS for now
> >        arm64: dts: qcom: x1e80100-crd: Enable IRIS video codec
> >        arm64: dts: qcom: x1e78100-lenovo-thinkpad-t14s: Enable IRIS
> > 
> >   arch/arm64/boot/dts/qcom/x1-el2.dtso               |  5 ++
> >   .../dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi    |  5 ++
> >   arch/arm64/boot/dts/qcom/x1e80100-crd.dts          |  4 +
> >   arch/arm64/boot/dts/qcom/x1e80100.dtsi             | 87 ++++++++++++++++++++++
> >   4 files changed, 101 insertions(+)
> > ---
> > base-commit: 8f21d9da46702c4d6951ba60ca8a05f42870fe8f
> > change-id: 20250909-x1e-iris-dt-eb0494a130ca
> > 
> > Best regards,
> > --
> > Stephan Gerhold <stephan.gerhold@linaro.org>
> > 
> > 
> 
> Could you please include the Dell Thena variants in v2 ?
> 

I didn't include that because the firmware-name setup isn't as
straightforward for that as for the T14s. I think all the Thena variants
have existing "firmware-name"s for ADSP though, so I can try to make a
patch that adopts the existing prefix for all the laptops that make use
of x1-dell-thena.dtsi. Or even better would be if you can send me a
tested patch to include. :-)

Thanks,
Stephan

