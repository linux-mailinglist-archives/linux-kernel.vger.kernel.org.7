Return-Path: <linux-kernel+bounces-814775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F072BB5588A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 23:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC59D5C3B78
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 21:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BDA2D2494;
	Fri, 12 Sep 2025 21:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsDfhPZn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BA0280CF1;
	Fri, 12 Sep 2025 21:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757713301; cv=none; b=JtI6JnpGQaSZ/PwyerC4qpzX2FVfT0lgFWegbzZf+19khny7iPcWVaIbB4bbsuJdcqIccWjtvWpYwGJwniZ8UgScruDO052v0c37z4HtX/Dev85GoML1kOVoOCvXFYqsFSXI1nNx+IgeMsXmEydWe/aIo+HVeyCyceSVBYScP7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757713301; c=relaxed/simple;
	bh=jn8KubYTFWVIV1KzELvUeSPo7MjSF/cfBcZIAeSGBsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/7PTuwie/w4bm91sWe+6KmWZa04bNJiO+2LI2AuqoyG0QpxR9L4xXd3FjaVRRiZDJu9z4GdAIrh5uOFFX/2JTuJzShiM85ofdKvyOInZSSNyhundgFybcno/tDUgJ+QckVtjgOXP8wpBV8s+e/96n7h2l2u7gGtui0tBZzbdJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsDfhPZn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1578CC4CEF1;
	Fri, 12 Sep 2025 21:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757713301;
	bh=jn8KubYTFWVIV1KzELvUeSPo7MjSF/cfBcZIAeSGBsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gsDfhPZnKJtanhaeAs4kVe5ENQbRCS0zHwkGnkO6qgTbyQ3zjC/DA7kBuw6W9mlaZ
	 KlvTTW5Lgfc72fn20H7y+nMMWAnOxWV8rhM4o4TN8e/tLrZwVQW6jT4sqKcWjLayIR
	 88A21JxZXsn3V44I408uxW8TntvJEuhtR28gycbOysyoX1wQ99BIKSMXIk1zkArhND
	 IgZQOPnfp2Zvgk8hhNBeJj3FwNI8rP5rjE86G1eB7xMybtcEyUw7BBwBC63dQN8+9v
	 oYVGK9J6k5E4cIAAiQEdmeD21rRr2cj33u8LqAA7xGSC6Rx04/ZQFmW88vj+/jQ8hs
	 MeX+mKtyMqgVQ==
Date: Fri, 12 Sep 2025 16:41:40 -0500
From: Rob Herring <robh@kernel.org>
To: Stefan Binding <sbinding@opensource.cirrus.com>
Cc: Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH v1 1/2] ASoC: dt-bindings: cirrus,cs35l41: Document the
 cirrus,subsystem-id property
Message-ID: <20250912214140.GA1359075-robh@kernel.org>
References: <20250912104612.361125-1-sbinding@opensource.cirrus.com>
 <20250912104612.361125-2-sbinding@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912104612.361125-2-sbinding@opensource.cirrus.com>

On Fri, Sep 12, 2025 at 11:45:37AM +0100, Stefan Binding wrote:
> Add new property: cirrus,subsystem-id
> This new property is used to uniquely identify the system if device
> tree is used, to allow the driver to select the correct firmware and
> tuning for the system.
> 
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
> ---
>  Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml b/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml
> index 14dea1feefc5..a9eb9bd7ad9c 100644
> --- a/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml
> +++ b/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml
> @@ -151,6 +151,12 @@ properties:
>      minimum: 0
>      maximum: 5
>  
> +  cirrus,subsystem-id:
> +    description:
> +      Subsystem ID. If this property is present, it sets the system name,
> +      used to identify the firmware and tuning to load.
> +    type: string

Why not use standard 'firmware-name' to just say exactly what firmware 
to load?

Rob

