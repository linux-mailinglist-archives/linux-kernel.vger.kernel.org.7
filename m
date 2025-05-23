Return-Path: <linux-kernel+bounces-660395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3E2AC1D4D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 08:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1A659E72F6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 06:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF771624C2;
	Fri, 23 May 2025 06:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrir/6+8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C572C19F11B;
	Fri, 23 May 2025 06:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747983170; cv=none; b=uSkb+flCmNq2DnI3VdRYfDXpIryLXmnAmwRhIdudm7yJ0wB6R8KHal6Da70tEzFaWkKcWjO8VVo/ZvgUOHFcNCliOnynoXUPgggoFVFv+pxITbn0AnWbkCn5ICUt1qg30Qwk9+Rmd1vnmFLtuVjSskF/20gNXmOH1DGXVAkiOz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747983170; c=relaxed/simple;
	bh=yjdusRw/mQ+OvFRsPDdhHDYcUtZZwOGJNfweGzc5ugI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bEyFWlapy2hNxn9SwU1nvsAU5yZvqpKfY/einbPo4DSEAO30D8U5mmByGpLcjfhyO4rTFWYFUTnqQ7M6ivOr0sZOO4HYMpPtRPI5ig0FsLZpcmUgM9G3OpTEDcXJRtM+NrvfQ/6t7Zt1FTREbYhJmNcNSrCatDjUGluzhyedeVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrir/6+8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65DEC4CEE9;
	Fri, 23 May 2025 06:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747983170;
	bh=yjdusRw/mQ+OvFRsPDdhHDYcUtZZwOGJNfweGzc5ugI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nrir/6+8D7EYpsnlImEmKR6hzBVOA2sJqym2GDy62cdM1taZQ1BxBQyvQ3fHjt/z4
	 bj7TFxmHHiHqnZldwlzzfwPwKcZZTg6jaO5LD6ROmgUzIouBeFPQal84EqGe4TnSXJ
	 gT0n0v967jaY7batRDFsRVk/fdQP9qdV1Gk2qNXd865pYWsVbCRqJBoHh1PXopIh2k
	 HJY93myTSGcFk6zfhmkd36WcvCQOw4BPwtyXvWeUS90ilyMZlPlJLENwMIcol3LVX1
	 9bQW0xiEB0Fjxukli7lMKe24YG+RrDzkuQadzHViIFaEhX87evR4fOCs0lBjFU6tnZ
	 oUFQD5PrZTd+Q==
Date: Fri, 23 May 2025 08:52:47 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Martijn de Gouw <martijn.de.gouw@prodrive-technologies.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Robin Gong <yibin.gong@nxp.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: regulator: add pca9450: Add
 regulator-allowed-modes
Message-ID: <20250523-thoughtful-flamingo-of-luck-891cfe@kuoka>
References: <20250522192325.1099680-1-martijn.de.gouw@prodrive-technologies.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250522192325.1099680-1-martijn.de.gouw@prodrive-technologies.com>

On Thu, May 22, 2025 at 09:23:22PM GMT, Martijn de Gouw wrote:
>  
> +          regulator-allowed-modes:
> +            description: |
> +              Buck regulator operating modes allowed. Valid values below.
> +              Users should use the macros from dt-bindings/regulator/nxp,pca9450-regulator.h
> +                0 (PCA9450_BUCK_MODE_AUTO): Auto PFM/PWM mode
> +                1 (PCA9450_BUCK_MODE_FORCE_PWM): Forced PWM mode
> +            items:
> +              enum: [ 0, 1 ]
> +
>          unevaluatedProperties: false
>  
>      additionalProperties: false
> @@ -143,6 +152,7 @@ allOf:
>  examples:
>    - |
>      #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/regulator/nxp,pca9450-regulator.h>

There is no such file.

Best regards,
Krzysztof


