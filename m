Return-Path: <linux-kernel+bounces-749672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E17B15159
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A04E3A3A4E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D19822759C;
	Tue, 29 Jul 2025 16:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p26GeTUq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991851487C3;
	Tue, 29 Jul 2025 16:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753806703; cv=none; b=pTVeJE8JICLmMiW3FivTVypxrcYkNFb9WA+5IzXgLgcaQ/YYPb0ujq6Cunz9gAvYoFJZTY5mDD2rmVBoHgkTaeNv0XSOs+VjK1wnZ/0K9pX7RqLMovTB777ABImAU48IMfhg/IUwxS6cnUBGXxKYqBhCuCS/kQHN2h0YDyyYKyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753806703; c=relaxed/simple;
	bh=1dkxZGkmuXVhfESsKgV+CRMmTLpxdc9oKXATIi9vcIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rw4uxqNRp/TVb9NLFWGhDxul5fUadfl37Piaz9DjbdCeCZogTrLzEcpS9TodPxQ+P5spPVHYZNGu6AfAsL51dCp0XZLDqqVcKslSiuraaqV74MEk4gCCXPdGHKunUbYIqkXhasEUI8FU514hbMNzJJeM7a6rWev17INJqSk1Yhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p26GeTUq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE32C4CEF5;
	Tue, 29 Jul 2025 16:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753806703;
	bh=1dkxZGkmuXVhfESsKgV+CRMmTLpxdc9oKXATIi9vcIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p26GeTUqOA1PeWl1t8jitMJV6dUSclnyI8FTib78TlJdGSUqKco9fXR0TqdNL//2N
	 1O4Jm8HPbyFdVhL5AvaUkL1Ovv0tI9tgZdxku4C4b6rLOYLNzVYnn3wMku55diK4/J
	 cibZ0RSpKIy14kxmVDjBwj3bVQEVH+TXEmErN6mGswnMkGkH986dsBZbR/NC1a9JcR
	 DCvLbCm03u4ykOdru21TAcXgzYpZuJZwGQ/2ZYNXCz09gFWbBs3/I6t92v3BZInM6o
	 zhvpOgFZqSDqEHa4CCwTnHrEMd3Riy3zsnd4mHmVlgntTzqcyIx85jW6F5A61z8y5o
	 8YfDKRtqeVBOw==
Date: Tue, 29 Jul 2025 11:31:42 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Cc: Simona Vetter <simona@ffwll.ch>, Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	Yannick Fertre <yannick.fertre@foss.st.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-arm-kernel@lists.infradead.org,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Will Deacon <will@kernel.org>,
	Philippe Cornu <philippe.cornu@foss.st.com>,
	Christophe Roullier <christophe.roullier@foss.st.com>,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 04/12] dt-bindings: display: st,stm32mp25-lvds: add
 power-domains property
Message-ID: <175380670133.511931.13043391606503114133.robh@kernel.org>
References: <20250725-drm-misc-next-v1-0-a59848e62cf9@foss.st.com>
 <20250725-drm-misc-next-v1-4-a59848e62cf9@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725-drm-misc-next-v1-4-a59848e62cf9@foss.st.com>


On Fri, 25 Jul 2025 12:03:56 +0200, Raphael Gallais-Pou wrote:
> STM32 LVDS peripheral may be in a power domain.  Allow an optional
> single 'power-domains' entry for STM32 LVDS devices.
> 
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> ---
>  Documentation/devicetree/bindings/display/st,stm32mp25-lvds.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


