Return-Path: <linux-kernel+bounces-735498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5445CB09028
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9912D164544
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C442F85E6;
	Thu, 17 Jul 2025 15:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XAZm5JNC"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C962F85CA
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 15:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752764758; cv=none; b=Az+x9uwGuch1YtQy2CrJacLkrcP/9Kc+29Kmg91eNDxcaNvVRbO3On6OFfbtpRVJW0I4+U1nwaT6FpytmT5geTkJ1PEMTNBV7+c6CL32LV2r4NbVoFzCMOggUxIabkag8qMbPLdJYmEEtbW5TmltW3G99fPmhwbWb4Kj8zjNpbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752764758; c=relaxed/simple;
	bh=PiEt0WUNVAcC4VA3CIqOQac/Mlmo+xQ0LJdAMNjG2IU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFbLPsylo2UB0/ieQ20S9sYLSkuNtnaQHXK1oOVS9vD5LwrVnHTqzutvgSrIuP+Twg9V7yQr2YxwR3js7O2ebE8HwzVEEhGfwqXY3AR4M+OBE8ibJ7WLsiUUeKo8IGab4k/bBzPXF8F8pS/XK8pXFPysxRDd8hxKREl5JQ0sJaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XAZm5JNC; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b350704f506so988148a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 08:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752764756; x=1753369556; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GRGgDk68DjbbOF0Mf8ErVPDVdO2Wa0CpF/l7W27oV/0=;
        b=XAZm5JNCkjaylNKvw1zY5QP20dChYhcHVwGDmIQinnsp3OfOd3PE7ZPYgYt++XmdNd
         VVAzmgstf6OI5SyxgGYMAJHHrCNaFpGLzADz1Z/QwwOsz33l3wv/mTPSM80Cw39LMmQK
         Oosz8m7DLeQ09mlXE3LH2Ooh6sFzMb7EbZ9V6vDy1rXVpgQzs1wMy25BQBAqie4ltZ9v
         dug6n+xzCcjGWhUKkoJi4GyLHdOOb0gN3p9Ak4j0ZEBL8zc29dIxGs2tbo3YCE71R2IX
         SMXqHm8qHFzGJRBP9SXrQlj5ZzMa1nK5MrRUiVeEt03WLZD2aXfuO1Rhd2TdoCZ2CmRS
         OGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752764756; x=1753369556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRGgDk68DjbbOF0Mf8ErVPDVdO2Wa0CpF/l7W27oV/0=;
        b=QJwtugF+ep+Anfm+D0CTFdDZlfrAu0Nzk3pDRMweGwcg0WiDTxGUY42n4H6VD8/Jdj
         /TXQJkHjrReGPXXtjQWPiZjcOleIwLZ+HfhoCmYSm8nEjYPcxb4Lts6FQVi98p65qOxJ
         fBBJ94SY81pBHgxhM73QDhE76fCAabi+hPsFHN6Ov4XjpQkjLyu9Icy1EuqHvs/e5tsS
         fqru5OCLn/Ic0xoN1s/T8LSj9APy/ngHQPlJVaqWkvTJi5LHD7c+zZn7cPjkWQtfJIis
         mGxtcgSAC+12yqVnZ3W3QIMaubEf0XbICoVdOSNqM69U3918i65bXazfzXbQZVLcfgmw
         DkZA==
X-Forwarded-Encrypted: i=1; AJvYcCU7PEPDJT5WBidjIAewx1i+de/PUIy3IgXg2M4L1OXfXvkNMqPRNQa3lW4W1CRM/YxzZgAuaXHdq2FX3Zs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq4qFy4zjlAcOkyrOjO//0gs98Plzefsyg9mVq6NV/sYr/5xlQ
	tCuiumk50bDDbM6pmErRf0oCO36Et3bmh+R3FbpJdMPgzNra9prUdO46CUdk3LYCjOc=
X-Gm-Gg: ASbGncsesIUI6SAXlOqqG52OVl07Pz2rL4esXRr2E0ajGwp6jj6PPv5hNBEhloUG7Z4
	PJVSsafHmw2Ic1/W5Yo9sxZvfDMMzkPDE/Tt7YgH1CD7jfp2SdCPk+b1CU6j0qFF32lQtmC1pPH
	/QEnx2fs4ArzCuke2YyHorBenvFSNFk4JIYfbAOIwvtW1ToFseA2M/74u6evcUhz9YqOC8/oTej
	Df/v6s6LSm/qnQRX46XX/IKicyYZdtex4MCcATlY9Tw28ViUt/WNVmcssOsN+h5MBxwcyjhR8aW
	cQMuidYNdUDB/RxhIwscvttW92Epr3SNxlyy1Yf6sLdJZ39Q6ZyENn1hpLhRX3Ou+b6aw+vaBAF
	YMYVdDiCDduMAFXThwGmWDRU=
X-Google-Smtp-Source: AGHT+IHlh4bBfrPfyZ+HtoQSqJqUSTaWT2KGepkcnD7iDpNKpIyWaajI2q3Ei5DglAzRDFNmmwxtvg==
X-Received: by 2002:a17:90b:2804:b0:312:dbcd:b93d with SMTP id 98e67ed59e1d1-31cc045a7b9mr187971a91.14.1752764755374;
        Thu, 17 Jul 2025 08:05:55 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f2874f9sm3475334a91.24.2025.07.17.08.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 08:05:54 -0700 (PDT)
Date: Thu, 17 Jul 2025 20:35:52 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: st: spear: Use generic "ethernet" as node name
Message-ID: <20250717150552.6kj6xqksc2xxpxli@vireshk-i7>
References: <20250717142245.92492-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717142245.92492-2-krzysztof.kozlowski@linaro.org>

On 17-07-25, 16:22, Krzysztof Kozlowski wrote:
> Common name for Ethernet controllers is "ethernet", not "eth", also
> recommended by Devicetree specification in "Generic Names
> Recommendation".  Verified lack of impact using dtx_diff.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm/boot/dts/st/spear1310-evb.dts | 2 +-
>  arch/arm/boot/dts/st/spear1310.dtsi    | 8 ++++----
>  arch/arm/boot/dts/st/spear1340-evb.dts | 2 +-
>  arch/arm/boot/dts/st/spear13xx.dtsi    | 2 +-
>  arch/arm/boot/dts/st/spear300-evb.dts  | 2 +-
>  arch/arm/boot/dts/st/spear310-evb.dts  | 2 +-
>  arch/arm/boot/dts/st/spear320-evb.dts  | 2 +-
>  arch/arm/boot/dts/st/spear3xx.dtsi     | 2 +-
>  8 files changed, 11 insertions(+), 11 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

