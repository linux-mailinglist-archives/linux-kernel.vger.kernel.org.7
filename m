Return-Path: <linux-kernel+bounces-892065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2E3C44440
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 18:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 17C4E4EB3AA
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 17:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483BF3064AB;
	Sun,  9 Nov 2025 17:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJFFWXYT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7B93054CC;
	Sun,  9 Nov 2025 17:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762708626; cv=none; b=k+2lO/RppB6VNBlS9h0MiiILALFx39zFzsMGVixbA9AbxWBEo5+9VG4z7AVmWFFQ+gKtzG+2DgZv8kDu8ftr7b4Y31mKfNsxjmDc+Z5ff/xA70STKfoF6iD/RJXE0r8ORul70+PSG7sXgoUrVRYIHjGfm9vMoO/lUFFc14DLkCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762708626; c=relaxed/simple;
	bh=R+aGVCQ0i2lAkDRADliBSpecycRmFRWpm8BtWeh6TP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=npQa8E0RWRr/TaCbwtWfojq6aSooyoSarasRc2IiS+gDxzgHhfrhQrkH4bHOTUJvQCsbeYyV8/Fp4jSpT5WJ894HM66gJdOfBRaYIaP1PS8NGp4487U0DYYW1OnPuLaz/PGfWE8XJlYOmq83rCUh/q5GrL2nL8dIv5C6hEOsFg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJFFWXYT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9286C19421;
	Sun,  9 Nov 2025 17:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762708626;
	bh=R+aGVCQ0i2lAkDRADliBSpecycRmFRWpm8BtWeh6TP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CJFFWXYT6CpeXX7vBKlfTJqUg9yzeRHVQNOxsqfAzPDc2avlpQ6tenxzliBnTyh04
	 wdhuUIQCzC8dFswXaVoLHabuqAxgHoe8tNy1a2SEBkL6eL3N2FtxBIN/sPuCOUAAB9
	 CYBmkVf5KnAR1MFAdaQxUd7Qp7Cfj9rmL/J1nN8iYZcoW7/pIPoHb8F8RHQvFqv0r5
	 M0F4xRsTDeBgm/6L+cbo0K+nnG5m1LGHG1+g4fzOkMmE4ESr2cqXCM5oayvMeJYDhy
	 kYjXuykSPyS9oSpr6RdURpUB04TC0puK5wD7x8izuYFLkIA+RZ7FWXJR1EI+Fsbg9O
	 wBh6dD4fHz8Tg==
Date: Sun, 9 Nov 2025 18:17:03 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Baojun Xu <baojun.xu@ti.com>
Cc: broonie@kernel.org, tiwai@suse.de, andriy.shevchenko@linux.intel.com, 
	13916275206@139.com, shenghao-ding@ti.com, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lgirdwood@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, k-yi@ti.com, henry.lo@ti.com, 
	robinchen@ti.com, jesse-ji@ti.com, will-wang@ti.com, jim.shil@goertek.com, 
	toastcheng@google.com, chinkaiting@google.com
Subject: Re: [PATCH v1 2/2] ASoC: dt-bindings: ti,tas2781: Add
 TAS2568/5806M/5806MD/5830 support
Message-ID: <20251109-heavenly-observant-quetzal-b1bead@kuoka>
References: <20251108110759.2409-1-baojun.xu@ti.com>
 <20251108110759.2409-2-baojun.xu@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251108110759.2409-2-baojun.xu@ti.com>

On Sat, Nov 08, 2025 at 07:07:59PM +0800, Baojun Xu wrote:
> TAS5806M, TAS5806MD and TAS5830 is in same family with TAS58XX.
> TAS2568 is in family with TAS257X.
> 
> Signed-off-by: Baojun Xu <baojun.xu@ti.com>
> ---
>  .../devicetree/bindings/sound/ti,tas2781.yaml | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>

Please organize the patch documenting compatible (DT bindings) before their user.
See also: https://elixir.bootlin.com/linux/v6.14-rc6/source/Documentation/devicetree/bindings/submitting-patches.rst#L46

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


