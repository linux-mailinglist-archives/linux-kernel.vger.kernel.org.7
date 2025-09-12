Return-Path: <linux-kernel+bounces-813479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAA4B54609
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECCB8AA69EB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9C925D1FC;
	Fri, 12 Sep 2025 08:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="mDwsbaUW"
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C45E25FA1D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757667260; cv=none; b=V+rkxZf7ciGPrySiS+/B9+Iy3m68HSKeGY5xSdKQQPLVeRj92usE8wgxbiIybVIkcUTc1Vd79hMT2Ayv2R3mzOKSlR7Ez3FNUFuo46NKL28wmc/QMUvVJdkRB1af6zqBFeAYvghAjjzztghXOqgKCyX0iPXulLKVkLZyuzp0wN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757667260; c=relaxed/simple;
	bh=yUhtLjkGj/wMebLJvOtshEiTqkJ/AlqFRp4g9VlVFy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQk763obvW+Ad9s+USsI+v1VLtDfn4V4fpG5NQ470yEl5Pf288eCssWcft1DCqw88gCb63qnrlXgxVBNuVF6In6gDsdDmpVsGwaE4lCRVvD9q59QrwrsE8EaAG04JTDBlUJ1TWF4+rJLXIAVpceq+GohBT46jb3zBonM1A4aPsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=mDwsbaUW; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 7AE2B240104
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:54:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1757667256; bh=W67eMTfc1EUhyH5LMz7dYtNTmFg2IWl15wR2G9kYiv4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:From;
	b=mDwsbaUWHe/RDDjADVRMP4OXGJDNTox56VF6PFcoLhN5OOhahJ59N33xPa5kWNMDQ
	 3sMBLUwqRzAwkcyq/CS3QMksvetZRCVnmkC5ziQ8eFc7atx5oEAVx7fcwQEG23NnTi
	 hk/ziwG3AG/VU6P1wsZATv43kFJhH9XLW8W50khbs9btXAPF+IxQC5QYBuSoLETW+O
	 LF+zLCxXDBykFCEaSBfDWtnIPbNAAsqaQK54HKw+wIsH7EZOuwsQL+EtkN2xtfqx5Z
	 9mSNo0vO4itnsttAp59mIlxvrBqaEnmfO4S6X7q8g07dhEQNCI1651W0svN/4A6cPT
	 qBhO14tTfPuDA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4cNSsL4ymLz6v12;
	Fri, 12 Sep 2025 10:54:14 +0200 (CEST)
Date: Fri, 12 Sep 2025 08:54:15 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: j.ne@posteo.net
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: allwinner: h313: Add Amediatech X96Q
Message-ID: <aMPftsaf4x61-bGY@probook>
References: <20250912-x96q-v1-0-8471daaf39db@posteo.net>
 <20250912-x96q-v1-2-8471daaf39db@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250912-x96q-v1-2-8471daaf39db@posteo.net>

On Fri, Sep 12, 2025 at 01:52:10AM +0200, J. Neuschäfer via B4 Relay wrote:
> From: "J. Neuschäfer" <j.ne@posteo.net>
> 
> The X96Q is a set-top box with an H313 SoC, AXP305 PMIC, 1 or 2 GiB RAM,
> 8 or 16 GiB eMMC flash, 2x USB A, Micro-SD, HDMI, Ethernet, audio/video
> output, and infrared input.
> 
>   https://x96mini.com/products/x96q-tv-box-android-10-set-top-box
[...]
> +&gpu {
> +	mali-supply = <&reg_dcdcc>;
> +	status = "okay";
> +};

Note for v2: The GPU gets stuck in probe deferral, and I forgot to
investigate why.

