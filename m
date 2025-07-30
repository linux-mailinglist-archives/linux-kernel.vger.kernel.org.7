Return-Path: <linux-kernel+bounces-751335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36531B167D6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 22:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BF9B5846FE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33566221294;
	Wed, 30 Jul 2025 20:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="slGDFdxd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE2710F1;
	Wed, 30 Jul 2025 20:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753908931; cv=none; b=ULdC9n9LNi4MzxgWVXh39YhCslARlG2fjjh92DeNONpjJvcaLi2ane9rS9ISua9tA+brDjZIsLZ68zL32ZYB4hIaGYSE/PMVwTG7HE3C0U95TnLAxnLeyblZ2T+Ny4NadPMgPn/96DPZIfoO3xMEqlyHZEi/9TSuGsF5OrRWV9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753908931; c=relaxed/simple;
	bh=cnyTzK3feprCwNlOU0zkPyf/P/0P8BcXQw0K55GzOBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LmAIE5TzAKvIo4IbZFLiTiQHEc4HEQLxZ3XW26nXblq7qTmjilwslrS5p6JvixJisz5k1mhJzCykJS1EzfQG9EAuyBAGdtbRxECn1jx12P14PenwiUz0SbPhvMXW2OZRJ0RahFEWhkN5ebDDhv2VHvGi1tPsCHeGhsCc2OjcHOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=slGDFdxd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF61C4CEE3;
	Wed, 30 Jul 2025 20:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753908931;
	bh=cnyTzK3feprCwNlOU0zkPyf/P/0P8BcXQw0K55GzOBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=slGDFdxdi08cRmRyNENFkiSH1AYvRWEkK4vAlxRHLpYoEg3Yh2D6G2S43O/rSu1p/
	 u6bs728jC8qyfx30MGzhpwYtGRhzNY5A2wKFwRwXDQ80gvnqmHhNYXvJT3gK4MGPuE
	 Y23E+nc6AbLuAAcZnSCcGBWvtttw/JspjkFzSuI7JpIuvsBNTgqDh9RLY0hG1DtfUd
	 vpRRfUp8XSrjJtYxDYbnsIzUvuFXGVzszKV2AzjLO4mUaV2RXa+AsAEAZ/WAU07Nn2
	 0G4iw5bfIwXWrV6U8JSm9qPm5Ozo3FRLYq14pfZVOVZv+EvYleMYqJXh2xadDujcyg
	 STNa6kh+335Yg==
Date: Wed, 30 Jul 2025 15:55:30 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: rentao.bupt@gmail.com
Cc: linux-arm-kernel@lists.infradead.org, Joel Stanley <joel@jms.id.au>,
	linux-aspeed@lists.ozlabs.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Andrew Lunn <andrew@lunn.ch>, Tao Ren <taoren@meta.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 09/13] dt-bindings: arm: aspeed: add Facebook
 Fuji-data64 board
Message-ID: <175390892978.1732171.6656964708595304137.robh@kernel.org>
References: <20250728055618.61616-1-rentao.bupt@gmail.com>
 <20250728055618.61616-10-rentao.bupt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728055618.61616-10-rentao.bupt@gmail.com>


On Sun, 27 Jul 2025 22:56:11 -0700, rentao.bupt@gmail.com wrote:
> From: Tao Ren <rentao.bupt@gmail.com>
> 
> Document the new compatibles used on Meta/Facebook Fuji-data64 board.
> 
> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> ---
> Changes in v4:
>   - None.
> Changes in v3:
>   - None (the patch is introduced in v3).
> 
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


