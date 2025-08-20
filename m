Return-Path: <linux-kernel+bounces-777131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC124B2D5B7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA8F51782F4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 08:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0ED2D8DA4;
	Wed, 20 Aug 2025 08:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knRq30y8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C783D286D55;
	Wed, 20 Aug 2025 08:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755677410; cv=none; b=NuoVi4zdqRm4qczdjIpnnDaFbuj01rAaJE42Iw2/fwrmuHStfWv4BnlbdrlBP6KSSX3v2IaLPpQVtNR5RMdVijsQ9MQlk5mwlOU/p8pMHCXcpF6CraFcPzLb1YAk956LWnqYIBIFYWYR3Qviw8GUCwL+K7zJeGVgOv7FPd2z52A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755677410; c=relaxed/simple;
	bh=rMAGOw8W70aPMqJ4oYe4yG8AyBcRn52d6Z3l0h2p0l8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/EMKWF4dLZg2XXzMRvLCCdWC2okvGH6ypaRbAufOvr+67KvVKTjwj2Xcbud4STSh9QRtarPQKehOTbDgcPZZ6fns2P7/ty3/zxKMBYYiA0vV/fQ3XdY9Iz1/2fPFj6bsHIiRbWSJ74+Zilk6GAHVT7l1akardZOpY6iNJ2MyHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knRq30y8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E55C4CEEB;
	Wed, 20 Aug 2025 08:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755677410;
	bh=rMAGOw8W70aPMqJ4oYe4yG8AyBcRn52d6Z3l0h2p0l8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=knRq30y8schxAtCBl9yankxHIXIaBa1fsZbg8BApQ/N2jeFgA0l3frjaQ0q3rljNl
	 HUgGU6Kz5FvpfsnjI305F6BxCN3uGWJ1QqTJn9hcCD8OaZWKA/3Na5gZsWBNeehKRS
	 MzsJQF9oq5j10wd0q80of9TchxMV4f2ohN2O2goKP1jIgWKtHQYjXzBJPJgZFCG88s
	 9hkw+cfcbIXzJ3lnfrYp8g0tpFHVo0E4Z3R2RrtDMmGF/LbvVeqDSoKZWPqilJDZ1S
	 EwJ4wuqBNbriuM4io1/zDVm3bhWLKkr7wXg3h0yQsdrnNrUakRFB/lLxS6TQMY9Frf
	 Yqt2cVeaXOmRg==
Date: Wed, 20 Aug 2025 10:10:08 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chuan Liu <chuan.liu@amlogic.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] soc: amlogic: clk-measure: Remove the msr_data
 from clk-measure
Message-ID: <20250820-amber-gecko-of-economy-cce4b4@kuoka>
References: <20250815-add-more-socs-to-support-clk_measure-v1-0-59f04ba67457@amlogic.com>
 <20250815-add-more-socs-to-support-clk_measure-v1-2-59f04ba67457@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250815-add-more-socs-to-support-clk_measure-v1-2-59f04ba67457@amlogic.com>

On Fri, Aug 15, 2025 at 04:37:28PM +0800, Chuan Liu wrote:
>  static const struct of_device_id meson_msr_match_table[] = {
>  	{
>  		.compatible = "amlogic,meson-gx-clk-measure",
> -		.data = &clk_msr_gx_data,

NAK, actual ABI break.

>  	},
>  	{
>  		.compatible = "amlogic,meson8-clk-measure",
> -		.data = &clk_msr_m8_data,
>  	},

