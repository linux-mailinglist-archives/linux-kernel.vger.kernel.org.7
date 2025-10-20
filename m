Return-Path: <linux-kernel+bounces-860587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB62BF0764
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD58C3B45FA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCD72EC0BB;
	Mon, 20 Oct 2025 10:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWPbP5qP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553772F6577;
	Mon, 20 Oct 2025 10:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760955125; cv=none; b=L19hahBOicl5SwWyuy3jJOYeHNvhaPgQQeWqP0P9xK/qBNvgIYs7oH9c2DXmzX3wPv3dkP7D6pWJsyNMRxIVJNEH5JAufkWhCWCrPGoBlxuATN1/aBHgQciTwwMBYohrupjSVnJY/QbSopZXzEFIpHSpQh/XvvYXFrFrMyGqaCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760955125; c=relaxed/simple;
	bh=SaTOvceqM8NvJ3wL1NKNHMEjldwn57jBpMR1nZADBMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkBYaKHUFPE2j65MLyop2szQkRG4cI0gOVIdjMTCMTWVK8aZxrtJZSkB/GBYKXTM2dnC9C4dDS1GSD/58QcEDuZKa5ucvyeK6wCgm+7Est0p6GCnUxkdzzlCzUad9UZegtSAeNF00nkDpAzeRYz3/1eHD6b0jfoJ0i8/vixOG4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWPbP5qP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325CDC116B1;
	Mon, 20 Oct 2025 10:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760955124;
	bh=SaTOvceqM8NvJ3wL1NKNHMEjldwn57jBpMR1nZADBMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XWPbP5qPhaGq0uQt7WwwZfJGgCmNuIhktt0MA3boZ1EC0AvrkxifU7J9xSOuiOp7A
	 glevkmSFHtMzg6DHuf85LpHwwH2WZ2+ToJ0VVYE8Vh1kDQ2LF0jF0K0sG+jHYagcCi
	 XscZcvZx4sPj+pEHS1RlCtK1d4WMrBgA/JwAtBsuhkneGU6zLiwUCDsmFEVfNEweRU
	 GjBUa2E8O85yXT8MQMbAqJAcL+T9g94ieuqpV5vO4+XoMGJWHXSJ/1PxgJ8j+E/6Hv
	 r1fUNdbjPDuJuI2yZJlP8oc/ut/YBZdgENZIYyqLp3rJtY7pr5IRnkVMp5Qh3PyxVM
	 cAwBQZ4MH+KPA==
Date: Mon, 20 Oct 2025 12:12:02 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Joan-Na-adi <joan.na.devcode@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Joan Na <joan.na@analog.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: regulator: Add MAX77675 binding
 header
Message-ID: <20251020-cream-hippo-of-purring-0f4619@kuoka>
References: <20251014053142.15835-1-joan.na@analog.com>
 <20251014053142.15835-2-joan.na@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251014053142.15835-2-joan.na@analog.com>

On Tue, Oct 14, 2025 at 02:31:40PM +0900, Joan-Na-adi wrote:
> diff --git a/include/dt-bindings/regulator/maxim,max77675-regulator.h b/include/dt-bindings/regulator/maxim,max77675-regulator.h
> new file mode 100644
> index 000000000000..b3b52d1668c2
> --- /dev/null
> +++ b/include/dt-bindings/regulator/maxim,max77675-regulator.h
> @@ -0,0 +1,52 @@
> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD 2-Clause */

Wrong text, it looks, please run checkpatch.

Best regards,
Krzysztof


