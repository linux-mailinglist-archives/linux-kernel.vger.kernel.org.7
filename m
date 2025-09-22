Return-Path: <linux-kernel+bounces-827522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4D1B91F6E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 921614E26F3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6FD2E8E00;
	Mon, 22 Sep 2025 15:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7C4aV1i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7D32E8B63;
	Mon, 22 Sep 2025 15:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758555264; cv=none; b=LbMGqx+oAc/2NgDPYaZLW32jOII8lgJK8B96QEftdSKZo6i/iixA7nNqIpqO/uI6OYDPCK7iQT1sP9RtxlE7K2gZxImHdBIasDiRFcZPelR608O4hKfBiv8dASNQIKOIK4q1/3tOVLmMXj+xtZPK8eklWdGsUKuyPrpNHSZNg+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758555264; c=relaxed/simple;
	bh=9itlys6Q2fbrAdNh/w4FO0oXtKWaWOitPzkM3O1TkJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3q8A270YJmoyxiJ9vnIJq+PKhNDf60cUtSkKAlDqullCUfpm808D3bNlWtBW54F2/NxwtJOfm1MQThegW+Z0EbKOT6wsGXypCAKJjwxv1EWkHvvR2uat6MZUL7HBThoWnKYlGVPd9lR5ZjiYfFbPGEvrxIlOLHC7I7OQ0yIB1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7C4aV1i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72CF7C4CEF0;
	Mon, 22 Sep 2025 15:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758555264;
	bh=9itlys6Q2fbrAdNh/w4FO0oXtKWaWOitPzkM3O1TkJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P7C4aV1ilQcU0OD1Ia/aguV2nTXa3jiaiXuwJx8EbptUTlnJgea/knmGNsZKMwy4t
	 LK94z1VUmbhX0OHIpQiuJ7bR4gOHlqLK55f/yZUDKahe3fbLT/D/Aa4yVs1LoVCHNl
	 4PAcMlho0cB6e++5O3j7SFBgWcy60Srs6Ivv4ftrZvSeetKzxE0xHxGTW+blfyjidx
	 uQD/JA5RcZYA5HxdPvNbsPnnE2pPYikde2xp3w/0oIYdAcES+gcZ1AB0qdsDWrMNJQ
	 pu0Z+WrcgSYR6BDENcY3OFEry0WKKBvxL0mtgtl9TCOQk42/+TzJku+A8SIl2AggIU
	 djMkd/udgRQJw==
Date: Mon, 22 Sep 2025 10:34:22 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-i2c@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH v1] dt-bindings: i2c: exynos5: add
 samsung,exynos8890-hsi2c compatible
Message-ID: <175855526230.4174976.5872907401314936227.robh@kernel.org>
References: <20250914131620.2622667-1-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250914131620.2622667-1-ivo.ivanov.ivanov1@gmail.com>


On Sun, 14 Sep 2025 16:16:20 +0300, Ivaylo Ivanov wrote:
> Add samsung,exynos8890-hsi2c compatible, reusing the 8895 support
> since it's compatible with exynos8890's i2c controllers.
> 
> Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-exynos5.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


