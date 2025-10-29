Return-Path: <linux-kernel+bounces-876068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7403CC1A8E0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7E87585D7D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF3D3358A9;
	Wed, 29 Oct 2025 12:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CG+TiDH9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1833328E8;
	Wed, 29 Oct 2025 12:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761742474; cv=none; b=sMYFy6Pe70xZIrboF0Ni8bDxzN7n6H8D9haok0JLezX4znKGHGYIrezVjy1d3RJAGGQHraw6qF0NZZ9K/NRB+AVxA58PLgtC+Os+PaXAaY9KfIPInLnwk0xC2xDjL7/yzQo05ipDg74yC8FoKepzVqKheCcjD8tV8svNQd7KZKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761742474; c=relaxed/simple;
	bh=ERdenaaSnCayj1jM0xEoP/ksydq7NeKvn4duQyaIA68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ceccZUrRaCvpoYVnnO4guT+Vi62uBWR9IQRCa3bOYP3MlwuG6V/AVefUMeYQEEGoOOPIahZXgt8WoE8IPYCL/k1Kwu8fzx1TfZjaaGaRc2NBvvNtUva4sKhii+GroVuwTDzD8oM6NemeNx4xC868gCacygDYHfkIZg1d/Hu1mP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CG+TiDH9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC22C4CEF7;
	Wed, 29 Oct 2025 12:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761742473;
	bh=ERdenaaSnCayj1jM0xEoP/ksydq7NeKvn4duQyaIA68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CG+TiDH9vGrRy+dyYgFaDqCLfCHqvH7YbbEpGB4Wyf1sfqV7Z72xZvLHkffLd2uin
	 yRkW4y9wr6dcsSz2IXD+UhbcdQYbVmigc/lSyttE636E4xmsd81+TFdGtLgy18uNMq
	 3P040ruFcjLA6waCPh/yOKM0ZKFgs/Bz5LteAXdIri9sarOU/pJVjqCNnCQS+8Qt7F
	 8i3EaA0SU9esvTY3db6xHPuFGt4bS6T4/3N5Gg0ueJt6mQHvGgDUopWLmYvl8uwNRs
	 Jcmg7njFZziQ00suGgN+EUSg84LwN3EMwaMfaDhoDK2ItrTLVNCkCbwJ58CoQogmoh
	 v4h1uUFM1gJjw==
Date: Wed, 29 Oct 2025 12:54:25 +0000
From: Drew Fustini <fustini@kernel.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>,
	Han Gao <rabenda.cn@gmail.com>, Han Gao <gaohan@iscas.ac.cn>
Subject: Re: [PATCH v3 3/5] reset: th1520: Prepare for supporting multiple
 controllers
Message-ID: <aQIOgbUf2IHoWCf2@gen8>
References: <20251014131032.49616-1-ziyao@disroot.org>
 <20251014131032.49616-4-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014131032.49616-4-ziyao@disroot.org>

On Tue, Oct 14, 2025 at 01:10:30PM +0000, Yao Zi wrote:
> TH1520 SoC is divided into several subsystems, shipping distinct reset
> controllers with similar control logic. Let's make reset signal mapping
> a data structure specific to one compatible to prepare for introduction
> of more reset controllers in the future.
> 
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  drivers/reset/reset-th1520.c | 42 +++++++++++++++++++++++++-----------
>  1 file changed, 30 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/reset/reset-th1520.c b/drivers/reset/reset-th1520.c
> index 14d964a9c6b6..2b65a95ed021 100644
> --- a/drivers/reset/reset-th1520.c
> +++ b/drivers/reset/reset-th1520.c
[snip]
> @@ -138,22 +147,31 @@ static int th1520_reset_probe(struct platform_device *pdev)
>  	if (IS_ERR(priv->map))
>  		return PTR_ERR(priv->map);
>  
> -	/* Initialize GPU resets to asserted state */
> -	ret = regmap_update_bits(priv->map, TH1520_GPU_RST_CFG,
> -				 TH1520_GPU_RST_CFG_MASK, 0);
> -	if (ret)
> -		return ret;
> +	if (of_device_is_compatible(dev->of_node, "thead,th1520-reset")) {

Is there a reason that there is a now a conditional check for the
compatible here?

Thanks,
Drew

