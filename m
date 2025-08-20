Return-Path: <linux-kernel+bounces-778600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9CBB2E7C7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 23:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AAC31CC200A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 21:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1B733472F;
	Wed, 20 Aug 2025 21:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKdj3UTR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8699E24677C;
	Wed, 20 Aug 2025 21:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755727125; cv=none; b=uYqmhpaqNOAa9K9ys+QrkCmNX2fdOyAedZEcezLBcC+IRh2geLASGSW49l31MQ9hKMXsGd2nSUCDJh1uQQ5P+VsZt2wJ/oF/EDmUWYDKfasmYKmEyIh6wVocrR2kdhYl/CHfCWq8QRSKaPWkWEKx58b9a8Tl7SP66490yvrXrFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755727125; c=relaxed/simple;
	bh=BWCN+arTsW28B+WK1cfvN4ijd4eox2d2e4EsnPw7MFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPiwY5f7dNlJMH1zOhi0pli3UHmk+hzdipEdYCU8t5Dv/0drraNNJNH2vB1dKpPXdIXfDUO2fWGFY4qZXMRUTFkHkHR1EQUf812rv6g3flozYRAMdjoOsuFnp5NaLEK1jZGP2UpZtXjZKVkvzMO/sQGOxy0ZPgLSywqoVjmQgbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKdj3UTR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D591EC4CEE7;
	Wed, 20 Aug 2025 21:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755727125;
	bh=BWCN+arTsW28B+WK1cfvN4ijd4eox2d2e4EsnPw7MFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IKdj3UTR3m5FxxRMpGC18rmUS1Sq3wCQzCZxHXkZTa+EJaMA1gn1STH3YHR96QEju
	 xX4+HD8ZJEj/LT4lR4CtLO0c324sgWpuLtRkb/poQwjqxiIoGD+7io5AW9E0nKmYfe
	 VVyQM0xxcEgdH+5WAjEWPHbF3vlM+x6RLm5maXPvtgpjwK6vniXddJCu/QBKGZJ6Qq
	 A5K6UT2uYcxGfBZEksWu45W4p1EOZGL6YnxgCh1NOwQIHe2YXW/woHFRjvMg92heW0
	 3PjRcpd4yvF/I4vzqFRE1fvZkXgd1ZGrxc44BAqxqidzxg7h/ZFrBz+SFfg5nBmP7V
	 VNsrrkYAYp8zg==
Date: Wed, 20 Aug 2025 16:58:43 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	conor+dt@kernel.org, peter.ujfalusi@gmail.com, krzk+dt@kernel.org,
	lee@kernel.org, shuah@kernel.org
Subject: Re: [PATCH v5] mfd: dt-bindings: ti,twl6040: convert to DT schema
Message-ID: <175572712295.1429558.12540417914156224115.robh@kernel.org>
References: <20250817215234.50904-1-jihed.chaibi.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250817215234.50904-1-jihed.chaibi.dev@gmail.com>


On Sun, 17 Aug 2025 23:52:34 +0200, Jihed Chaibi wrote:
> Convert the legacy TXT binding for the TWL6040 MFD to the modern YAML
> DT schema format. This adds formal validation and improves documentation
> for the TWL6040/TWL6041 audio codec, which provides audio, vibra, and GPO
> functionality on OMAP4+ platforms.
> 
> Key changes:
> 
>  - Dropped usage of the 'twl6040,audpwron-gpio' property from the schema
>    as it is not used by the driver.
>  - Retained 'clocks' and 'clock-names' as flexible (1-2 items) to match
>    the original binding's "and/or" phrasing, which allows clk32k, mclk,
>    or both.
>  - Updated node name to 'audio-codec@4b' to follow generic naming
>    conventions per the Device Tree specification.
>  - Replaced raw interrupt values with standard defines for clarity.
> 
> Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
> 
> ---
> Changes in v5:
>  - Add missing changelogs
> 
> Changes in v4:
>  - Retained 'clocks' and 'clock-names' as flexible (1-2 items) to match
>    the original binding's "and/or" phrasing, which sould allow either
>    clk32k, mclk, or both.
>  - Updated node name to 'audio-codec@4b' to follow generic naming
>    conventions per the Device Tree specification.
>  - Replaced raw interrupt values with standard defines for clarity.
>  - Added clock properties to the example.
> 
> Changes in v3:
>  - Drop usage of The unused 'twl6040,audpwron-gpio' property from the
>    schema as it is not used by the driver.
>  - This patch was originally part of a larger series but has been
>    sent separately per maintainer feedback.
>    v2 (origial patch series) link:
>    https://lore.kernel.org/all/20250814132129.138943-3-jihed.chaibi.dev@gmail.com
> 
> Changes in v2:
>  - Renamed twl6040,audpwron-gpio to ti,audpwron-gpio for consistency
>    with TI naming, this fixes the dt_binding_check vendor name  error.
>  - Minor description clarifications for improved readability.
> 
> Changes in v1:
>  - Initial conversion of twl6040.txt to YAML format.
>  - v1 link :
>    https://lore.kernel.org/all/20250811224739.53869-3-jihed.chaibi.dev@gmail.com/
> ---
>  .../devicetree/bindings/mfd/ti,twl6040.yaml   | 154 ++++++++++++++++++
>  .../devicetree/bindings/mfd/twl6040.txt       |  67 --------
>  2 files changed, 154 insertions(+), 67 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti,twl6040.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/twl6040.txt
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


