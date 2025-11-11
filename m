Return-Path: <linux-kernel+bounces-895065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA10C4CC86
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCDCF189A160
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FA52FC030;
	Tue, 11 Nov 2025 09:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OvU9fWSG"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD682FBE0E
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762854855; cv=none; b=LPMDYVJxe28eRw/V7iCNGZI/KVUEvB3+bvrSY5Vcb9F9hf8L2rP8t6EPN+71TDXh67Ii0bzN6aDb3NcOBuj6NS5czLIjt595VSXyR7xJYhi9sus5oPMIv432k7H7+RfyEdwVeB7NFedrsAymEYJjzwiSQdpWkGpi3j6Bm3NaTm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762854855; c=relaxed/simple;
	bh=NmRrZd84HeJfVx5ulbp94fMcHAZINk/9ovlAxd4Q0nI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DsnUUGlbp+qJhd86t9tuTSz+p1ss/uyCy68cR7jqsuVD33YOaPR540LWNCbvVH/j1lnPUP1aGoRZjtDoh/l9hIdqmfumWcJYrHje0uVVdr/Sofz8Zipn+XlyjLitn6k5zQSn16PFfYnNo6OdqgSfdnbx+W1fe70tECs8r485Rhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OvU9fWSG; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4775ae77516so46714035e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 01:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762854852; x=1763459652; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1RcLpKAgVroVokPJ6qJZ8mFHk6ZFFVxhlD+S4Jv219I=;
        b=OvU9fWSGPM2xDQ8BNPYyQ4X8z/zuENPNx5/sJJv6aEIk+lQL+DEiTQj03RPS559a7H
         AqgY4dyY8GqdWZea6SvOQApjo6wwgoXqTouqB87E8ZdyI0ZfDXi2E+YMj1G8CpQEuAvr
         QIjBRpBfAQrCqEaLKY22ypGGoKLkkkXYaxppE7RW9uSqt1Rqu50iAzCFq84TSW+M9ifO
         +XKMDKVUfVKJRVKxSNM7Ydmc/MSOh2zR1o09OYfRPIZPYMpVci/SVlf7a72NSFri2bMc
         ydS3eirwYKAZZ77fiSj5a+n0qaYb6KvgYqKSPwrneMkpc5+aAQ2KqdonBsXZm2MRBHXT
         k97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762854852; x=1763459652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1RcLpKAgVroVokPJ6qJZ8mFHk6ZFFVxhlD+S4Jv219I=;
        b=K0KKc+kHj7H9mZCy4N4ja47UwQLb6doskRJku+DzZ2K6iKVexqSx4bMtP1kE2nNdGC
         p0HWnpLEt+gfWUoyWcU2PP3b5kdSyCLbMbFvOpgp+aKmqnVynJ/q5e7ysZq6+053zqtF
         vKf0JdREJ1Dab0nbjSsygmMzpu8CdvD1kiLH3qU4R6FuJScL1hFGqqkSenbFtuOBkofg
         TN7TUX0yx/9mN0DaeyRnbupmkf9rHSmQ2dVIxa3HLKO8TxYD9ONrBXpQmDxmDvWpt7et
         WB1+mv8/kTKOpRYnL/U7JEwRzD7SoQJCZgST1XklC4x59lqJH91Fe5FljpcLl7QKbxbb
         pDiA==
X-Forwarded-Encrypted: i=1; AJvYcCVxaI9EsaWVOKJpGq3W4DPc+vypdrgwWhdfd8UoVoWmgInHw11+ZCfgYGYUIsx/Ttzf8ECJf/iLcrjmlMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlpJdeHf9O8k//3492E44ZFs6L9va9DkeXFVtOquG7Fb8FmqMn
	AL779Z/vQ7cqNl63TiBxkVZVIl93LTCuohQrciLvWhubnT+sNkBFdQ4lx5UOcwATGaI=
X-Gm-Gg: ASbGncuZF3T/5OhM9YbtfQ3Mx0/ki/w+oFa0ufMZIWLQx4holI/Q+j+XDr3iC9Gv7en
	ZtqgU+wk6j6eFyb+LtkaNGRwAvkvSwhvKPChBha8P5u9fnOsblmcRZ/fs9g9P5YSsG30Jpxv3AE
	pE7yEK6k1gxAjC2LPc8v1DXmdmTGSH6uCoWROgf3AvoKFjUlndK826I+Q2U+C/Dudy7glbaf7wF
	lqe2KnLA6Gc7BFBLDzg5G3DKo5fb8fVWa1toC2BXGwxTnnmVvMJQfptMGVlqsWj7Pq2YY2MVtPf
	yjl0e47A8GJu8a0v80glHo97reJFUtBKOZfBkhr+TrXfE/BS7kLzKCChpsEcP9gjQEBKbl9u6tM
	+A9fKwBC1LgZuIoPZv+j8m+CZQ4tbGf+diodkjSrxLcSRVUa7+5X22TNRjkVbyf52EBMQCTzeP8
	04/r4aJPrx3d80F8/2LJUrby7gpnaDxkQN3Q==
X-Google-Smtp-Source: AGHT+IFL9npt8OanU5c12NGRVwnOxSJ1VHU8qFzZB0+lZ0yamOH0/N3ycPmTghVrBE6IWk6zyD+evw==
X-Received: by 2002:a05:600c:4512:b0:477:c37:2ea7 with SMTP id 5b1f17b1804b1-4777327cb82mr105157595e9.21.1762854852310;
        Tue, 11 Nov 2025 01:54:12 -0800 (PST)
Received: from linaro.org ([2a02:2454:ff23:4430:b142:7c48:bde4:7b24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4776bccd35asm242845145e9.1.2025.11.11.01.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 01:54:11 -0800 (PST)
Date: Tue, 11 Nov 2025 10:54:06 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Georg Gottleuber <ggo@tuxedocomputers.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ettore Chimenti <ettore.chimenti@linaro.org>,
	Srinivas Kandagatla <srini@kernel.org>, stefan.schmidt@linaro.org,
	wse@tuxedocomputers.com, cs@tuxedo.de
Subject: Re: [PATCH v2 6/7] arm64: dts: qcom: Add device tree for TUXEDO
 Elite 14 Gen1
Message-ID: <aRMHvhf77BgRvuAp@linaro.org>
References: <20251105154107.148187-1-ggo@tuxedocomputers.com>
 <20251105154107.148187-7-ggo@tuxedocomputers.com>
 <aRHre28Nbyv6ShbU@linaro.org>
 <r76wptwknylaxlkwmdkd4pinrzufnjiujrutj2q32lgt75x7ti@zibmax5uhwp5>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <r76wptwknylaxlkwmdkd4pinrzufnjiujrutj2q32lgt75x7ti@zibmax5uhwp5>

On Mon, Nov 10, 2025 at 10:11:12PM -0600, Bjorn Andersson wrote:
> On Mon, Nov 10, 2025 at 02:41:15PM +0100, Stephan Gerhold wrote:
> > On Wed, Nov 05, 2025 at 04:41:06PM +0100, Georg Gottleuber wrote:
> > > diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> [..]
> > > +x1e80100-tuxedo-elite-14-gen1-el2-dtbs	:=  x1e80100-tuxedo-elite-14-gen1.dtb x1-el2.dtbo
> > > +dtb-$(CONFIG_ARCH_QCOM)	+= x1e80100-tuxedo-elite-14-gen1.dtb
> > 
> > Please also add x1e80100-tuxedo-elite-14-gen1-el2.dtb here (similar to
> > the other lines), so that the EL2/KVM-specific DTB is automatically
> > built and included in the installed DTBs.
> > 
> 
> Please confirm that this works before adding it.
> 

Yes, I tested it on the TUXEDO laptop a few weeks ago and it works fine.

In general, I don't think we need to ask everyone submitting new X1E DTs
to test the -el2.dtb separately - the hardware/firmware situation is
similar enough on all the laptops that chances are very high that it
will just work. There are not much device-specific aspects involved.

Thanks,
Stephan

