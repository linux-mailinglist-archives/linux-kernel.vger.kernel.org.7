Return-Path: <linux-kernel+bounces-749671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C08B15155
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F12697A1CC5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93A2226D16;
	Tue, 29 Jul 2025 16:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xt4z40PF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB9A42056;
	Tue, 29 Jul 2025 16:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753806695; cv=none; b=m66A/ZbscCd1I+3llyOcYOcMEX8QDM1qOyLnw26X0/mBcX00mK7MXpUi2j79EzcqdZVLVjdyUZ/8NgscmKRmoenQMDZbVPnKf41eY7cJQpwV1nuA7+3pGOf44OjyJkwdjWFfNTIxAO5NhI9IYcztD3cSp+lnFD8TqMGRIwcy3DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753806695; c=relaxed/simple;
	bh=sPWerXoTnJdupEJFgfzlBFo08Ou/toO0osnBkMyj3F8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obsLTyO+qP1CjIlVpDQBSzfflulpJcRIjTpDl8SVhTEEwHkVyPpZZcxqX2YAsyWhOs18U6RcvZ7iLd/Uoq2eyNogxUWbLtef32pYH7W2wga6XQLiWTMb9lStBJq42OOgGHIokkhrgkOANYD0T1JZwU5a0AMpw6ANRUFH4ROxYrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xt4z40PF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76977C4CEF4;
	Tue, 29 Jul 2025 16:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753806693;
	bh=sPWerXoTnJdupEJFgfzlBFo08Ou/toO0osnBkMyj3F8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xt4z40PFrTNRm+gchkzSFN8IZ7lR97MmgUmhmW7xTh+MJkUc9okSXr9V5mM4Mw2i4
	 7xketuGtMIVNB85UWt6kb4nKjtJGf/mf5a/0SF8E5QqCk4jWVsby/FjJ0W4If9YWSw
	 n3UQTfIab46FGLkOee3bgXACTsvM3uFdjuTJmKwt8azfPGnQ5u3/oo64BG0175yQjU
	 MKj++96I31z25cIz+ITK6gTWF8osNPZ1SGjzNaR+FGqBWhoLRWOEqo9Qs1jZOk+W/a
	 7NFkAYgEBUzlgqe6Bh7Sa7wA1Co9bMX2SK0n8RIFVkpGjymWU4b2feO4sAQlPqee6S
	 6iexWo6KdPe/A==
Date: Tue, 29 Jul 2025 11:31:32 -0500
From: Rob Herring <robh@kernel.org>
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Cc: Yannick Fertre <yannick.fertre@foss.st.com>,
	Philippe Cornu <philippe.cornu@foss.st.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Christophe Roullier <christophe.roullier@foss.st.com>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/12] dt-bindings: display: st,stm32mp25-lvds: add
 access-controllers property
Message-ID: <20250729163132.GA507560-robh@kernel.org>
References: <20250725-drm-misc-next-v1-0-a59848e62cf9@foss.st.com>
 <20250725-drm-misc-next-v1-3-a59848e62cf9@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725-drm-misc-next-v1-3-a59848e62cf9@foss.st.com>

On Fri, Jul 25, 2025 at 12:03:55PM +0200, Raphael Gallais-Pou wrote:
> access-controllers is an optional property that allows a peripheral to
> refer to one or more domain access controller(s).
> 
> This property is added when the peripheral is under the STM32 firewall
> controller.  It allows an accurate representation of the hardware, where
> the peripheral is connected to a firewall bus.  The firewall can then
> check the peripheral accesses before allowing its device to probe.
> 
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> ---
>  Documentation/devicetree/bindings/display/st,stm32mp25-lvds.yaml | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Rob Herring (Arm) <robh@kernel.org>

