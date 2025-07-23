Return-Path: <linux-kernel+bounces-742083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3011CB0ECEB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DC1C175DE6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 08:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E4B279DB3;
	Wed, 23 Jul 2025 08:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6Zn7yIZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78E7277016;
	Wed, 23 Jul 2025 08:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753258516; cv=none; b=HKvLFJ+TdtDxaa4YV1EErr4DkY2ojMiusqHy/fettmAzIG0B50bLWiK3NtCKiWbixxgxko03mtgdz8CP7TbAsy3zGqo/RKcr3pCG3zQNtpc9LPw1i2ZmjlnoufAeMFJSwOogO7CNSKnEq92EQ4gj3czGVVANC0mNplIRm1cW2tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753258516; c=relaxed/simple;
	bh=eiSeklGXTHNclYYVVOQI8EShKXdV+LksKQOEcVg5v+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVEHCEKl0joRKpwLxwPk1F8rXrydZJ2eYfm7vsZ6GSAa4QcGXV7UgWkw0kMCGupcLT6nXD7YlrLPlxGmqWHJdCVT5+LpBCDrqVZX7c59dRKX6DFAVUJIirqrVz8DNpFojNbz638k2vIZ03B1UJRZtx3HF11VQKUcaDC0yAzFq7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6Zn7yIZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA6CEC4CEE7;
	Wed, 23 Jul 2025 08:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753258515;
	bh=eiSeklGXTHNclYYVVOQI8EShKXdV+LksKQOEcVg5v+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i6Zn7yIZs/V8rT/TV1qly7sPAgTI4oeD4vCse/IUYII6mdfRnTdnMiK2ac8SCngrp
	 E6P1kvB8KBToFobjj5a3IJt4d9GIqrIyoA4EsS/9SsgwH82oOCdmQ/E8H4CQn0BCb1
	 NjnYdu0BZGL++jD9ciwQcewr/7CTRVCThweq1Okg+RFs2v/Nvur2bA+xWvmmpFrz8o
	 t1Ob9T8u8jVJefuajdX2QGQVnlw5Tln0hhZnrIsUAyEdz9WRvXFnsa5PMvURgeJgNZ
	 9lZGnDxS9TPYwKS9fMntWNTlZ54gT0wD0Rx57GLHp6M09gn0XhQ2HOpFQjD3CxYMT/
	 vo/LxXcu56/6w==
Date: Wed, 23 Jul 2025 10:15:12 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: soc: samsung: usi: allow 64-bit
 address space
Message-ID: <20250723-hypnotic-malkoha-of-trust-9efdb6@kuoka>
References: <20250722121037.443385-1-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250722121037.443385-1-ivo.ivanov.ivanov1@gmail.com>

On Tue, Jul 22, 2025 at 03:10:36PM +0300, Ivaylo Ivanov wrote:
> Some device trees, like the exynos2200 one, configure the root node
> with #address-cells and #size-cells set to 2. However, the usi binding
> expects 32 bit address space only. Allow these determining properties to

So if USI expects 32 bit, then why do we allow 64?

Switching this to 2 means you use 64-bit addressing for children and
allowing DMA for >32 bit. This should be the true reason - what is the
address space and DMA range for children?

Best regards,
Krzysztof


