Return-Path: <linux-kernel+bounces-846984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E823BC9962
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 16:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD0BF4FD5F2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 14:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5B52EB5A4;
	Thu,  9 Oct 2025 14:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="Zu7NsgKd"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ABB2EA473;
	Thu,  9 Oct 2025 14:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760020946; cv=pass; b=QMZ3ioA6MLPtah108pTehgjxwlGlse/c1OAPKyAbOcm8hohRvF4SeB32Qwsm2vwgNYzVm3tUhnYOlaTfT9a5uqN35QVRvKsPUjUH6CT8ClYUFJq7lv7+7OOBoEwkcHtzxb9QuZljph2a2nfHArol6Erbngf4PQ6K7LP1s60sumo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760020946; c=relaxed/simple;
	bh=2ZPCrRQzr/WLaAtqfLLyYq+La/hKy6NPnyBey0bBUow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PNIUVEzb25k6TlwkMOzwwD+6MOMJzniTRnJlzzePS4swhlttjUuaf9+dNb4XR32p43uU5JG7GaTez9Pz61rZyIAgoCFIXQ38ppwDTq2Hvs/8v7KX195ux6OzraZ7vMiRki+R2ga8UBFUQju3XUPOQEyOPLjK6NhDZJCvsOKYPSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=Zu7NsgKd; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1760020924; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=irSQG0MDZZPSVmNszNVc4x2fdPYiC40AT9QHZ83zaj4qMPeFD6MxJi4AAWz2JZ337d4b8BWnUCjKHMAS75hMvTnfO6lpgnqOyRR3JBiVEzcmz08ZW8C5zG/Fe+gmxVxDStKoWUkDYkaJDCyrSSVJq4lSKuW3s+7SQaId6As6COE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760020924; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gOEj4/IpkenMiJt4N1/HqskQ9zMM3bzJT70kiGJjHEk=; 
	b=mTHIHyP81fqGs5jvcTVrPZLGflyxGXYfF26wZq+V+r4slLbuoVSIZ5CNsByICkXuWFlu3ZgCjXzcPruNn2OERyFUK95i36tUlSHKRV2BBvbGKJxjg9thwsSfHIMtgs4C0DYpscA5Q2dOwwoxgHIcWUOqrqa4H71hzJOAQcg1ybM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760020924;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=gOEj4/IpkenMiJt4N1/HqskQ9zMM3bzJT70kiGJjHEk=;
	b=Zu7NsgKdA7XApLRezertLoTOav8hgPArFe5XUdBuQ1VJU7ZsPmCE2TSeKi//AWDx
	uvnn1T0ptw/AV30mCKX9f9/A0jbNbml5h66LpxbAsJGvZMJch8qub3NuOPMnRL35nqB
	GW6Wsory/O41llwSplB8R79gdae3GXsHx0OyQYdg=
Received: by mx.zohomail.com with SMTPS id 1760020921792909.7002470660792;
	Thu, 9 Oct 2025 07:42:01 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 lgirdwood@gmail.com, broonie@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel@collabora.com, wenst@chromium.org,
 igor.belwon@mentallysanemainliners.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject:
 Re: [PATCH v8 4/9] regulator: Add support for MediaTek MT6363 SPMI PMIC
 Regulators
Date: Thu, 09 Oct 2025 16:41:56 +0200
Message-ID: <5635636.31r3eYUQgx@workhorse>
In-Reply-To: <20251003091158.26748-5-angelogioacchino.delregno@collabora.com>
References:
 <20251003091158.26748-1-angelogioacchino.delregno@collabora.com>
 <20251003091158.26748-5-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Friday, 3 October 2025 11:11:53 Central European Summer Time AngeloGioacchino Del Regno wrote:
> Add a driver for the regulators found on the MT6363 PMIC, fully
> controlled by SPMI interface.
> This PMIC regulates voltage with an input range of 2.6-5.0V, and
> features 10 buck converters and 26 LDOs.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/regulator/Kconfig                  |  10 +
>  drivers/regulator/Makefile                 |   1 +
>  drivers/regulator/mt6363-regulator.c       | 935 +++++++++++++++++++++
>  include/linux/regulator/mt6363-regulator.h | 330 ++++++++
>  4 files changed, 1276 insertions(+)
>  create mode 100644 drivers/regulator/mt6363-regulator.c
>  create mode 100644 include/linux/regulator/mt6363-regulator.h
> 
> [...]
> diff --git a/drivers/regulator/mt6363-regulator.c b/drivers/regulator/mt6363-regulator.c
> new file mode 100644
> index 000000000000..812775072eb5
> --- /dev/null
> +++ b/drivers/regulator/mt6363-regulator.c
> [...]
> +
> +static int mt6363_regulator_set_mode(struct regulator_dev *rdev,
> +				     unsigned int mode)
> +{
> +	struct mt6363_regulator_info *info = rdev_get_drvdata(rdev);
> +	struct regmap *regmap = rdev->regmap;
> +	int cur_mode, ret;
> +
> +	if (!info->modeset_reg && mode == REGULATOR_MODE_FAST)
> +		return -EOPNOTSUPP;
> +
> +	switch (mode) {
> +	case REGULATOR_MODE_FAST:
> +		ret = mt6363_buck_unlock(regmap, true);
> +		if (ret)
> +			break;
> +
> +		ret = regmap_set_bits(regmap, info->modeset_reg, info->modeset_mask);
> +
> +		mt6363_buck_unlock(regmap, false);
> +		break;
> +	case REGULATOR_MODE_NORMAL:
> +		cur_mode = mt6363_regulator_get_mode(rdev);
> +		if (cur_mode < 0) {
> +			ret = cur_mode;
> +			break;
> +		}
> +
> +		if (cur_mode == REGULATOR_MODE_FAST) {
> +			ret = mt6363_buck_unlock(regmap, true);
> +			if (ret)
> +				break;
> +
> +			ret = regmap_clear_bits(regmap, info->modeset_reg, info->modeset_mask);
> +
> +			mt6363_buck_unlock(regmap, false);
> +			break;
> +		} else if (cur_mode == REGULATOR_MODE_IDLE) {
> +			ret = regmap_clear_bits(regmap, info->lp_mode_reg, info->lp_mode_mask);
> +			if (ret == 0)
> +				usleep_range(100, 200);
> +		} else {
> +			ret = 0;

Just initialise ret to 0 at the start of the function scope when
you declare it. You've already missed an uninitialised use once,
and playing these branch games is just asking for more trouble
in the future. There's no micro-optimisation you're doing here,
clang produces the same assembly for both zero initialised and
the else branch version you're doing here.

> +		}
> +		break;
> +	case REGULATOR_MODE_IDLE:
> +		ret = regmap_set_bits(regmap, info->lp_mode_reg, info->lp_mode_mask);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +	if (ret) {
> +		dev_err(&rdev->dev, "Failed to set mode %u: %d\n", mode, ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> [...]

Kind regards,
Nicolas Frattaroli



