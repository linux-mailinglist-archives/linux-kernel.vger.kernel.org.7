Return-Path: <linux-kernel+bounces-761972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F96B20097
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B0493BE333
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A322D9ED5;
	Mon, 11 Aug 2025 07:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSY1sC2R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2E2376;
	Mon, 11 Aug 2025 07:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754898388; cv=none; b=Abir42a+FF6coXmFGzrUDTfC5wpihsLjYtgsKZOCHTMzCLRF2hWd0crzI9J0dG2psWCzeycqh96986+EmzgYOjYQO1dMasNOjILsRgINbAcZAnX6/9DrDufr9ZLaG/NT9v6Ile8qKi19idUAvkGYHGWE2Uizihd4gObk3em11aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754898388; c=relaxed/simple;
	bh=QQPaSNb/HKk3j3aIXJpmUMSyIrO9nwwQuHAa8nLGpm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDanryu2ALLht7ik87+30RqmZQ0XmIKn887jlVtYD6T3IGkD2STtXSLaGADM6q0hqc9FYU0OIpeM5jU7QPBZTWK7t24eqewO9jkF66BVuVtI5E+paeQoJQpcNLwtQUKp3l/v7yg0ct6PMTI1jiAMcyzsytgC/1bS+Y/pPvXB8qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSY1sC2R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC68EC4CEED;
	Mon, 11 Aug 2025 07:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754898388;
	bh=QQPaSNb/HKk3j3aIXJpmUMSyIrO9nwwQuHAa8nLGpm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hSY1sC2RNKLkJIVkD7JqSsw4b85cUWRESPSZ3u2KKOgV32JUpz9AQewWZlu+gDOWV
	 zz6Ki2U0hA0oin4k9q16DyClPs8rJxvTjWaV1ExSAfE1TQPMy90z+uiyV/xD7R1mlu
	 4GcJJApXaKKWw756alyPBhzRkwVMyTyvIn9zLuIiD2ooMLukPx8JtBNLFUr63aOiEd
	 fqLzLmN+dnPvdjgowWsEA8rJB+i8qReueqRI4Egw6T3n5ZiIZOJxk6ePk3vXHp2B+j
	 lzqUa1Ezvvf+9JYN6beMs9O9ONI/gTd2jvK+6HDjBjnXKRimm0CmfSr428/n26hVv7
	 0mKKx15BPL7dA==
Date: Mon, 11 Aug 2025 09:46:25 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Mahdi Khosravi <mmk1776@gmail.com>
Cc: devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] ASoC: dt-bindings: realtek,alc5623: convert to DT
 schema
Message-ID: <20250811-skinny-sunfish-of-opposition-bc876a@kuoka>
References: <20250809080824.68845-1-mmk1776@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250809080824.68845-1-mmk1776@gmail.com>

On Sat, Aug 09, 2025 at 11:08:24AM +0300, Mahdi Khosravi wrote:
> Convert alc5623 audio codec binding to DT schema.

...

> +
> +properties:
> +  compatible:
> +    enum:
> +      - realtek,alc5621

This was not in the original binding. Any changes should be explained in
the commit msg.

> +      - realtek,alc5622

Why adding this? Where is it used?

> +      - realtek,alc5623
> +

Best regards,
Krzysztof


