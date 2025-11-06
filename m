Return-Path: <linux-kernel+bounces-888966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2956FC3C659
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B4154F92A3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CFF358D16;
	Thu,  6 Nov 2025 16:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OeCEa+aD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B9E358D04;
	Thu,  6 Nov 2025 16:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445516; cv=none; b=nQzVVPi6zdyHEXWxyBr3EHgJHQiTnMa+Z4aAjFx2MI8vKWmRyh4dok9ZGzEIKqPBYVOZrM1+AOL8p/TtxARXp6QkLpTntAGGiZkTi4u44mjEqfTmdftPzHv3/NmZUNjy32hyYdXVOnRKUPlaumpsZfJwBUfPxe1PY8Mj9bnjx48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445516; c=relaxed/simple;
	bh=Wp6NdwsggFSpzb+dFMYQ9X2r0whMaKdMwlJTTWgTI0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnqWHWJLYSrL6V8p3vmuSdQ4g69X/xvPodWLJGrPV7lPeg60F66t8qDl9mytsXLgN+2DuSau7JtBoC457QM/Yvz6F2ucklDE3zL2CAbQkhHETfC939uDMd8tlLA+7mG1EUhTA2XtW6hr/p0YcXRYPmOL0mGnto6hv9Dg5mrXHP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OeCEa+aD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D44C4CEF7;
	Thu,  6 Nov 2025 16:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762445515;
	bh=Wp6NdwsggFSpzb+dFMYQ9X2r0whMaKdMwlJTTWgTI0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OeCEa+aDlWQ5u1cQUfOXi+ERK0SJ33/+W5IPmwxfaVVar2Q74v178OcPqMXqVExMU
	 IHd6DTxKFMKcitwkI917TFx3tvCTjrW/52zos5eyychIJfljT841HirV5O3ONbWL2a
	 8V/UXUkDYvJG8KYOHNYbir7F1TILDu7/B7T/kyr8ZFzQxxjnqIqgbd0fnifQ2IMYDy
	 zl4LDBFHt4ImPFKl0HUvtk/HAkRAmeigzyqxzVV6Vxxik/kmqxXcZGNZxusw5P+m5T
	 AoVopRgLYb4OpkTxH3cQZRjinOKgbsdQp4X9cSv07CQP8CRx4SRYIZSiTq5W1Sl1uM
	 2RbeXbAYy0OXQ==
Date: Thu, 6 Nov 2025 16:11:49 +0000
From: Lee Jones <lee@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mediatek@lists.infradead.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, matthias.bgg@gmail.com, lgirdwood@gmail.com,
	broonie@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com, wenst@chromium.org,
	igor.belwon@mentallysanemainliners.org
Subject: Re: [PATCH v11 0/9] Add support MT6316/6363/MT6373 PMICs regulators
 and MFD
Message-ID: <20251106161149.GU8064@google.com>
References: <20251027110527.21002-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251027110527.21002-1-angelogioacchino.delregno@collabora.com>

On Mon, 27 Oct 2025, AngeloGioacchino Del Regno wrote:

> Changes in v11:
>  - Removed unnecessary #address-cells in all mt6316 bindings
> 
> Changes in v10:
>  - Added "struct" prefix to structs kerneldoc
>  - Renamed struct mtk_spmi_pmic_pdata to mtk_spmi_pmic_variant
>  - Added "REG_" to MT6363/73 mfd register definitions to disambiguate
>  - Expanded MTK_SPMI_PMIC_IRQ_GROUP macro parameter names as suggested
>  - Some rewording of comments as suggested, addition of more comments
>  - Refactored IRQ domain handling due to deprecation of function
>    irq_domain_add_tree() to use the new irq_domain_create_tree()
>  - Fixed to use generic_handle_domain_irq_safe() to avoid races
>  - Added support for two interrupt cells in translation
>  - Removed .irq_lock() and .irq_unlock() in favor of lockdep classes
>  - Added support for handling PMICs without IRQ Group register for
>    upcoming MT6685 implementation

The MFD part looks okay.

Let me know when you have all the Acks and the set is ready to be merged.

-- 
Lee Jones [李琼斯]

