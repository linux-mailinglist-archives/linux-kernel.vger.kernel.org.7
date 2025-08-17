Return-Path: <linux-kernel+bounces-772357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B912B291B2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 07:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 911457B4B5B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 05:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914A41F1534;
	Sun, 17 Aug 2025 05:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCEJfNW6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0C113B58A
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 05:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755409935; cv=none; b=n+9n6R894viGz463bQ6RtQcBUbleuyxKcgdC4cvMww47C42jHldtN0EFns4Nn/bgZT6xqcF2hpNhcH4LvNK2CRCtdmwXnkaaBv5Ll+aJZDd2RHoZEiBOjjCkG9JoFu69IRT/hlZedvFsy5zbpb6T8H4sBhTxdwnz7J2AqH9Ejhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755409935; c=relaxed/simple;
	bh=QcgnRcdrgZ46bj93pLgyVcvWAJGPLerUK+s0G3YsVXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gqGA+ssme8WlsRDMusIWe59YmEMherCeCOt599e7c4W00331QpoBIaVa0v/eJb2hDSyp/7JlAiqPnuLZ0wa4qETbxOyt0Os1noBRd/jhPiHG9QaZiis8svbouvR8sXmLlYeUju3t8gVyFCWOSXhWMS+hv59RtxvEasPeyNN+RaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCEJfNW6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 074CFC4CEEB;
	Sun, 17 Aug 2025 05:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755409935;
	bh=QcgnRcdrgZ46bj93pLgyVcvWAJGPLerUK+s0G3YsVXU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TCEJfNW6Q1lMjsAPUPVkDOVMyTkwwalYlen51FX+pOIGHBRHMXdW3FkFzu7jQTj+v
	 PjUPNJhL8k+NMMxEUtq6bnocMT5W2FvyTUSK2+ht48J5iBrVtMuu8s839lcjUNqiDC
	 FkfsOzoHnivIJWRQKpuCPlzfrNJXmZi21jADVHTbwMgIXHoEm0iKymqNqCdYermM8v
	 ifQVkgESnNAb+5Kzr8LDnAhrWxIWcCk83MTSbF1GpFXSwN1d3TcBuQGl8AnbDyPemi
	 wORz5eI/1YPM42LRp+xnepQZkmIBhbFP50KIlzLVYs7giYH3LtKcRBV9/wTOWleZTN
	 Tldl8AxdQgjTw==
Message-ID: <a5cbd3d4-b8ba-4e1f-8ae1-b0e79fedfd47@kernel.org>
Date: Sun, 17 Aug 2025 07:52:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] nvmem: s32g-ocotp: Add driver for S32G OCOTP
To: Ciprian Costea <dan.carpenter@linaro.org>,
 Srinivas Kandagatla <srini@kernel.org>
Cc: linaro-s32@linaro.org, NXP S32 Linux Team <s32@nxp.com>,
 linux-kernel@vger.kernel.org
References: <cover.1755341000.git.dan.carpenter@linaro.org>
 <7e1f16bf09e77afef4cc5fa609a6c3ad820bb14c.1755341000.git.dan.carpenter@linaro.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <7e1f16bf09e77afef4cc5fa609a6c3ad820bb14c.1755341000.git.dan.carpenter@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/08/2025 12:47, Ciprian Costea wrote:
> Provide access to the On Chip One-Time Programmable Controller (OCOTP)
> pages on the NXP S32G platform.
> 
> Signed-off-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
> Co-developed-by: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
> Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>

Incomplete chain, missing SoBs. You cannot add someone's Co-developed-by
if they do not sign the patch.

> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/nvmem/Kconfig            |  10 ++
>  drivers/nvmem/Makefile           |   2 +
>  drivers/nvmem/s32g-ocotp-nvmem.c | 171 +++++++++++++++++++++++++++++++
>  3 files changed, 183 insertions(+)
>  create mode 100644 drivers/nvmem/s32g-ocotp-nvmem.c
> 
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig




> +
> +static int s32g_ocotp_probe(struct platform_device *pdev)
> +{
> +	const struct of_device_id *of_matched_dt_id;
> +	struct s32g_ocotp_priv *s32g_data;
> +	struct device *dev = &pdev->dev;
> +	struct nvmem_device *nvmem;
> +	struct resource *res;
> +
> +	of_matched_dt_id = of_match_device(ocotp_of_match, dev);
> +	if (!of_matched_dt_id) {

This is useless check, drop everything around of_matched_dt_id.

> +		dev_err(dev, "Unable to find driver data.\n");
> +		return -ENODEV;
> +	}
> +
> +	s32g_data = devm_kzalloc(dev, sizeof(*s32g_data), GFP_KERNEL);
> +	if (!s32g_data)
> +		return -ENOMEM;
> +
> +	s32g_data->fuse = of_device_get_match_data(dev);
> +	if (!s32g_data->fuse) {
> +		dev_err(dev, "Cannot find platform device data.\n");

This is impossible condition, so no need for error message.

> +		return -ENODEV;

And here probably -EINVAL, because if it was probed, the device is there.

> +	}
Best regards,
Krzysztof

