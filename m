Return-Path: <linux-kernel+bounces-839254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A51FBB12F2
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 17:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F74F162A18
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 15:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AED41459FA;
	Wed,  1 Oct 2025 15:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrzW+CXI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF40E27F16C;
	Wed,  1 Oct 2025 15:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759334027; cv=none; b=cufXLqtMEBSgqHuZpyjBpgIQ/us7nCqwaxL+hnAGUrYVtb5y0yBI7QthFtlYt/oXL+vZLpiWaC6+n5WTGRYT5LmFOHxNY0wKW3N8tdZqgroDzQDqoGHmDpYOtdE0u9bSuGK4nlIn9Jm00HcqZcqgo+77xaiRo8XrMF2zcOXjfQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759334027; c=relaxed/simple;
	bh=jWXIj+XQH9k2rgZC0jazDofhOuOkjdLHKY7Gs7wBT/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQ52FYcKESpSR5lQ5DldbcTW729HA/R0bLTy0YMA6gXyBAYgfRvYX02dcH6LEacmFVQ8QAoDw1dWigdIlYv0peC2/zRqVXu1SsUgfVztsIsqEyTMRDkRguQV+49PIT1NfofUzHeMTg4QvXUoKC5DH4dI9NXlGS00pgs/MRfRO1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrzW+CXI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51AD2C4CEF5;
	Wed,  1 Oct 2025 15:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759334026;
	bh=jWXIj+XQH9k2rgZC0jazDofhOuOkjdLHKY7Gs7wBT/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TrzW+CXIWwbeoLSHb0D68yTZm+49nG0+/giNoRu8VZ6yS0KxEgGU+delOR0dbRxEe
	 IQknSZeIOek17i4D7cs8YDPO7sUsTxtJD5+vIXDgbm/fMK1Cpdl4JJ9Zo0J2I9UQVd
	 H1TUK4T69ulJ8R2VFXtobzcY9OnEw+u95pU9WzQVip1f/55ZcsJZ9ayVmdPSTlFEr4
	 fcC0+w2TXcTY862q2+zieIDlUMpoENEfeB+dS9fqSUi/fgOrHnCEm0hBTXEAFLga5+
	 FDe3B0MzyLq2U9bI31Xf99E6JiCRuMIEUba43kO6VkKe0gK0bgIML+mdvJj6JdJJWL
	 LnljY/N8OWHxw==
Date: Wed, 1 Oct 2025 10:53:45 -0500
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mediatek@lists.infradead.org, lee@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, matthias.bgg@gmail.com, lgirdwood@gmail.com,
	broonie@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com, wenst@chromium.org,
	igor.belwon@mentallysanemainliners.org
Subject: Re: [PATCH v6 7/9] dt-bindings: iio: adc: mt6359: Allow reg for SPMI
 PMICs AuxADC
Message-ID: <20251001155345.GD1833526-robh@kernel.org>
References: <20251001111316.31828-1-angelogioacchino.delregno@collabora.com>
 <20251001111316.31828-8-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001111316.31828-8-angelogioacchino.delregno@collabora.com>

On Wed, Oct 01, 2025 at 01:13:14PM +0200, AngeloGioacchino Del Regno wrote:
> When one or multiple Auxiliary ADC IPs are embedded in a SPMI PMIC
> it is reachable at a specific address.
> 
> Allow specifying the `reg` property and make it a required one for
> MediaTek MT6363/6373 PMICs as those communicate over SPMI and also
> disallow it for the others (as it wouldn't be applicable).
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../iio/adc/mediatek,mt6359-auxadc.yaml         | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

