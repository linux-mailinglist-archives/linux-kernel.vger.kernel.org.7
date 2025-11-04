Return-Path: <linux-kernel+bounces-884522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4031FC30574
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 10:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 87BEC4ED344
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 09:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0FD31280D;
	Tue,  4 Nov 2025 09:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3XSkXR4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21732609DC;
	Tue,  4 Nov 2025 09:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762249706; cv=none; b=nU49ncf/P5ve6/u21z3obsNg9OeGQe0GzwUXeuVZGIobYZJgeUzsv1VVkPrHOuFl2lcoPWXKKNKGaGsYiwMc9/+x+OXT1YsZkB6eAKpLYhOwy49p30DLtOT8pqBYs1T5dbqaVkj02uxiKKUJvwFWhC45YZXEa9hBJY9MB4GEzoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762249706; c=relaxed/simple;
	bh=rNXMP1/Hko+o4OWzwDhh+mj82xmLeVK3HHnr4LfDfSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgVPT1muqAF8NF6TVov0xuy9PITJKqYr/eNCG5kjHhvPEyjYUbAhM5mS8K0Kqdglfyq08YvxQrhm2T4WmaSdBsDfP/G7Z4OXBRKco2tBVYupZ8tjbWaXuV6CaMs2dK60Nc6HAEV/htmNOQJbHJn7kLRl8yXVFg67byVjLZeqOl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3XSkXR4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D70B6C116D0;
	Tue,  4 Nov 2025 09:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762249705;
	bh=rNXMP1/Hko+o4OWzwDhh+mj82xmLeVK3HHnr4LfDfSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d3XSkXR4WOkSdOCwNMOj39t8EgXefMv15pKUK9QiThOz3fcduKReXhQOQEWTHuvXK
	 wwme7DVa/wp1SFiEDQPJ22NAlxDpCt3Hk0rBv2HykxTv7RIykvm+4+/nSgmKoU9aFe
	 XmXO/ykRfq0RRB+YZqhOi9U2Sv5OARoPPDS8NHyezZuyMsFkouUcFcBa1wPD+zUQOh
	 0Y4IhIJigONxyatzN/NnlucYgQoipDX98tcr2kE5K70LgKFlcWUrvayWDvJuD9esvj
	 UJULvfQW/WIDQReQr+8t6EXgIw0GD8gIA/36bvjW0Gh/jB0MGkI4JBYTLUT2WCgOT9
	 10yCX+dlDTiIw==
Date: Tue, 4 Nov 2025 10:48:22 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Cc: Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mahesh Rao <mahesh.rao@altera.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>, Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: firmware: svc: Add IOMMU support for
 Agilex5
Message-ID: <20251104-bipedal-sheep-of-advertising-08450c@kuoka>
References: <cover.1762135710.git.khairul.anuar.romli@altera.com>
 <ca75b88a64412274d415e17d4aef6dd018ac7167.1762135710.git.khairul.anuar.romli@altera.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ca75b88a64412274d415e17d4aef6dd018ac7167.1762135710.git.khairul.anuar.romli@altera.com>

On Tue, Nov 04, 2025 at 07:39:27AM +0800, Khairul Anuar Romli wrote:
> In Agilex5, the TBU (Translation Buffer Unit) can now operate in non-secure
> mode, enabling Linux to utilize it through the IOMMU framework. This allows
> improved memory management capabilities in non-secure environments. With
> Agilex5 lifting this restriction, we are now extending the device tree
> bindings to support IOMMU for the Agilex5 SVC.
> 
> Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
> Reviewed-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
> Reviewed-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>

Two reviews but...

>  
> -required:
> -  - compatible
> -  - method
> -  - memory-region
> +allOf:
> +  - required:
> +      - compatible
> +      - method
> +      - memory-region

... none told you this is not the correct syntax / style?

Were these reviews really happening? What exactly was reviewed here?

Best regards,
Krzysztof


