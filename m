Return-Path: <linux-kernel+bounces-735473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC51AB08FCE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ED0E560977
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D242F7D0B;
	Thu, 17 Jul 2025 14:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZdRsHXdn"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9782F2F7D06
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752763729; cv=none; b=SzP3/0vjsDEBbDfJHQtokkvJb+eASGEvkWYxVNEQ5xoHcrF/xQ2f7ZLa5OeKHkvRPyUOObpM5bSriCvHhUbDNL8/ZIaKts0WUCSxcCNbL5CEpS3UMFPPNqi5hnHx7y45zZy8ldL1MfV1RAgym7vquBJ4ZvdCr2VhuWvdQM/z/A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752763729; c=relaxed/simple;
	bh=ldkUDsWevUUrBgtiC0hxtuONfzCw4mF+Y3RShzs3xlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxjmxWsnELrOin12cqUcAZkS45WQ1u22ykRuhEg0BjCisYG0ylgij56oPnHosEdkOdXfjcmfS6e/aSz+tRRkaYcomnLUNkKSxiXfMynkyBs0+l74XauX7pqt0rfn/TFOygJOrB5nBKX/IA8awO68CxyXgZrXQBT/gj7ZNzhEVJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZdRsHXdn; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-311bd8ce7e4so968712a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 07:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752763727; x=1753368527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AJ7IJB52s/jxggmQRLZiB7BTzZN6vUYP9vPaGdcZBU4=;
        b=ZdRsHXdnpC/N7S4TKrVMl239qD0Eqe184eATML5npWxTW9YUaL67gxdQFzV61/AKzZ
         40wIDMADfD+BUFEA2TKuo0UpaEYEPjGOBRm6HR7kCCtH0XVa8VaC77vFJu70VkUEsSZ6
         eFee2mEpoKXcxGOsrtBbg2pGu9b/uPjkoNv9zhH8oeyn3Gzge+mSC0d6Q5pEeALZTKgh
         ORkaZi+XE7rHtVbNaBq33bt8k/bEJa3Ek86+r+Xt9cWbUZm7VvZC6eTiDJIdEP2iLfk9
         GNjaVo5aTpR4B7nlod8+HsY0AOe8OLmPz2IHuksHk/R1CBE+pk4Y+lIf1pbc+H/jIOrD
         BE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752763727; x=1753368527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJ7IJB52s/jxggmQRLZiB7BTzZN6vUYP9vPaGdcZBU4=;
        b=DDLHBnUuo8cSfyLYU9qmBZN0/xF2xtvNCE+95AGxbh6SNynhvEzeVjHKLyzexOT6KM
         yi2nal/dkkAb7ulPJqdEpfPVL/6xLqijxN1dJb+Ka2ghlMHHPwNzyuQq99t7U7VEUWKc
         Wyp6afx8wPXD4R1wR9hmwTQdBij8IvaMmxkVGbBeV5dR07iBk9h+Sx8gBEfR/nrDhplB
         mJBY5kUJ0fvpFHC/56EetWtsbpa+iufe+rfspEDluBk9tEhignGwYBbuiqiN8Iw/D3cd
         VnYeEDGfe2I/u23wZFP31+SW3pTjCasEeiOax5lgEu4kOy/82Q36rUsVgJo49BO4ddgU
         UdyQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+Madi0ONFY8G3h+Paibs8xMydXTj6zlBQDr2BIDPbZxXFR/rEDlbgAptLRR61zMc1AKu/VAIxVab45n4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuD+1HmPJqsl1Qv1TIV4bEwmMc8IdNJsUlVE1IWW0ug6oz3sbx
	758drWc62+djuL/Xlyc/P+bVevc1yIKF4CT7+Y/McFFnF1LidZbjWJHu+EkN9m1Fvco=
X-Gm-Gg: ASbGncuPVjbV5ewhFdjDlipboJ3dArreSlnmVbeTklB7JbT8wHGqKsf0qf6MsAQCZEM
	OfL/mWLghpKZGp/FVy9C9+KHw/xivhS1gXE+xHzheEiwGUmuEcOTy2VftDllLVSGW7/7NEuKK/B
	jM1+vd9mis53M1w693fyxVU65QIEgv4k9ber5nTrwUTMGReZuaBOPPQz3z1oPRKwA2EpTLdG1/v
	3aSDixVWalAv2q1+Ir9DP+k8Kj7KcB7aNEFb0//hmcOB0eRrwYgn8qIwgKChX0UfPBOw2v5giYS
	yuLtoXf7BdxXt8X7FL7FJUYogFlR7ya3uKHWCU3qQZJE0BfOwQrQAFitCTKQJGIcdQGtmtUU4sp
	/BUe+nfw+q2DumRS5N1Hsp8B1
X-Google-Smtp-Source: AGHT+IHN4pdN+q1y537irHaqdVIJwMrH6auGVoGM+UN248YAGpQVjPDa0P891RmdfAyjRaEDEvnJPg==
X-Received: by 2002:a17:90b:3d05:b0:311:c1ec:7cfd with SMTP id 98e67ed59e1d1-31c9e76bb39mr9637297a91.26.1752763726789;
        Thu, 17 Jul 2025 07:48:46 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:e0c8:a1e8:3882:b37])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f1e684csm3578940a91.12.2025.07.17.07.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:48:46 -0700 (PDT)
Date: Thu, 17 Jul 2025 08:48:43 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: "Rob Herring (Arm)" <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Frank Li <frank.li@nxp.com>, Bjorn Andersson <andersson@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Iuliana Prodan <iuliana.prodan@nxp.com>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH v4 0/5] remoteproc: imx_rproc: Support i.MX95
Message-ID: <aHkNS51jgV5ulsNB@p14s>
References: <20250710-imx95-rproc-1-v4-0-a7123e857dfb@nxp.com>
 <175224423523.783161.17907302929832941912.robh@kernel.org>
 <PAXPR04MB845959EF2767C96794EAE6DD8854A@PAXPR04MB8459.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB845959EF2767C96794EAE6DD8854A@PAXPR04MB8459.eurprd04.prod.outlook.com>

On Mon, Jul 14, 2025 at 11:52:05AM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH v4 0/5] remoteproc: imx_rproc: Support i.MX95
> > 
> [...] 
> > New warnings running 'make CHECK_DTBS=y for
> > arch/arm64/boot/dts/freescale/' for 20250710-imx95-rproc-1-v4-0-
> > a7123e857dfb@nxp.com:
> > 
> > arch/arm64/boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dtb:
> > scmi (arm,scmi): Unevaluated properties are not allowed
> > ('protocol@80', 'protocol@81', 'protocol@82', 'protocol@84' were
> > unexpected)
> 
> Same as replied in v3.
> This is because [1] is still not picked, not because of my patchset.

I won't move on this patchset until this is resolved.

> 
> [1]https://lore.kernel.org/imx/20250513-whimsical-almond-quoll-e3ad5b@sudeepholla/
> 
> Thanks,
> Peng.

