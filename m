Return-Path: <linux-kernel+bounces-791025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 634A5B3B141
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 04:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 846A7161678
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 02:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF56E220F38;
	Fri, 29 Aug 2025 02:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sboCMoPh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457EC12DDA1;
	Fri, 29 Aug 2025 02:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756436168; cv=none; b=ZqUKpm9QKjlZmBxz3aJ9UUiAgPqZDw7RGhVmQ5oc7QDd6Wf3qLed4WI2c7RcEaygTOIJb+YAvnPSIhZa8GQvYiUaRCl0tUh5iLYmczI/mBGchb1Sp6gaPUILGVyCYqA0JzvB6JboWf2xDEnKA3HEX7gs8Wd4GZAbyr4eHYKL3Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756436168; c=relaxed/simple;
	bh=1OlmWF/efJBsrmU8E3ikAwN539XMM1ZnxmoDQaXFvlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DD7osNPL4S219EylMobug77UvtQLqmDuVAqc+In8yveNu/dPYWy6F8HTG2F5Q8zevm/xvq6nTrmfufpOC1ZT6QOsd+0xIsNAnZt+tNFRH8EbgQh61Riy9QLLEQq+Gqta3cj57uo44LcA8sPnn3+uXXqLlomNCJM6PEh5GjIkffM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sboCMoPh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4F0C4CEEB;
	Fri, 29 Aug 2025 02:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756436167;
	bh=1OlmWF/efJBsrmU8E3ikAwN539XMM1ZnxmoDQaXFvlk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sboCMoPhfYLDk0qmPH1RlSFasQFAbmwalRsQNXfFwaIs8TC8VJXA8m2tyGC+8BLlA
	 iW8Ivy3/57AXzHCuJzbBoucQ8l1GhnoDTLOnWDxOx/MM4CKQARfwJzNe2dV6ywBjzz
	 G4RuJnhtgRZ2U50jFWyr66IsSnFMPJVdZpvRsBELdDaplV25xtc5Z7cFxktBm94788
	 wBbPCpKfFFoYBXUU65BCZGHDfb8bbOg/rxHHg/FaIvcW/s+xCqjUf55iYYSCJV7cG8
	 zzUTATtVfFk47jqV/NxkRAeXZe9joqnl3cYdfxAkHqap1v7j5pk3J2JimUVmlyJ137
	 62kbIgMA3BnYA==
Date: Thu, 28 Aug 2025 19:55:04 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Pet Weng <pet.weng@ite.com.tw>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hermes Wu <hermes.Wu@ite.com.tw>,
	Kenneth Hung <kenneth.Hung@ite.com.tw>,
	Pin-yen Lin <treapking@google.com>
Subject: Re: [PATCH v2 2/3] drm/bridge: Add ITE IT61620 MIPI DSI to HDMI
 bridge driver
Message-ID: <20250829025504.GA1341@sol>
References: <20250828-it61620-0714-v2-0-586f5934d5f8@ite.com.tw>
 <20250828-it61620-0714-v2-2-586f5934d5f8@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828-it61620-0714-v2-2-586f5934d5f8@ite.com.tw>

On Thu, Aug 28, 2025 at 12:01:19PM +0800, Pet Weng wrote:
> +config DRM_ITE_IT61620
> +	tristate "ITE IT61620 DSI/HDMI bridge"
> +	depends on OF
> +	select DRM_DISPLAY_CONNECTOR
> +	select DRM_DISPLAY_HDMI_HELPER
> +	select DRM_DISPLAY_HDCP_HELPER
> +	select DRM_DISPLAY_HELPER
> +	select DRM_MIPI_DSI
> +	select DRM_KMS_HELPER
> +	select DRM_HDMI_HELPER
> +	select CRYPTO
> +	select CRYPTO_HASH

It needs to be CRYPTO_LIB_SHA1, instead of CRYPTO and CRYPTO_HASH.

- Eric

