Return-Path: <linux-kernel+bounces-881861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1B2C29165
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 16:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DCE68346EDD
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 15:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F0E2309B2;
	Sun,  2 Nov 2025 15:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEPRP3Tp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C54CA930;
	Sun,  2 Nov 2025 15:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762099051; cv=none; b=RjOViH03mZHk+2HXAF+UBGOamoNpklMm//YJX9Yl6GNSwdX++1K8qg2wiA4IOpwhF5rbwucM2tMXif/iGaX0O/RPmk2xxRTteyVGknvVcl0tkWjFw9VTkkCS3WwCpC/Bw+s4vmoxCo3jh6ORRYIZo0UUGw6m0IN+YPCYqq+2VLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762099051; c=relaxed/simple;
	bh=EU7EOUKW2UD7yGw95HbiRqLMQJ39AgWO60fDnALC1tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hzxuv7q+LAMfwmw6P2Q4h6dHWf0biLV460wDRodLIVxGkjTFksNF9pqrWikf6f50YqU5KTvxrVF0gGJzzTHQxp3MhKE/hGssDGqrF5uq5J51U56kbMAQnOQ3veXrOROfsZqMroFRnpRKz2pZa+srX/H9enPVsikNSTn4gCwBZk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEPRP3Tp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70ECCC4CEF7;
	Sun,  2 Nov 2025 15:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762099051;
	bh=EU7EOUKW2UD7yGw95HbiRqLMQJ39AgWO60fDnALC1tg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NEPRP3TpeewKbLsAnT4QwPwbODGvtZZt0C6CX9IjihTBZeXPQKU+IudSJMs19ipA/
	 wpS1pttvYXSx0CvjiFqeJo2L4L4CaWXE7UWpFOEaJsCTaCIMeCtgYF5flRA+Bgy4mR
	 UNMRNLaOopEycnUdzT5Ya/M+TndYmgfPKY3viJacgWPYvrmPNjX4/MJeBbWlNV745P
	 Z/TPtQYCrcxW1M3qA2GcnpqscuvtQgU5ZsXGI6Y9FOf/uU5BhY+qTjZIfcDZ3OPwFn
	 ZlL/wHo9Kt6zz2dvKRbndD59xNwPPNEj8BZPG/wAshSHyzE3iGioqMMC4WXNmtcQEO
	 sB28s6s+gmaTw==
Date: Sun, 2 Nov 2025 16:57:28 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: victor.duicu@microchip.com
Cc: linux@roeck-us.net, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, corbet@lwn.net, marius.cristea@microchip.com, 
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 0/2] add support in hwmon for MCP998X
Message-ID: <20251102-calm-fractal-labrador-cde4f0@kuoka>
References: <20251031155831.42763-1-victor.duicu@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251031155831.42763-1-victor.duicu@microchip.com>

On Fri, Oct 31, 2025 at 05:58:29PM +0200, victor.duicu@microchip.com wrote:
> From: Victor Duicu <victor.duicu@microchip.com>
> 
> Add support in hwmon for Microchip MCP998X/33 and MCP998XD/33D
> Multichannel Automotive Temperature Monitor Family.
> 
> The chips in the family have different numbers of external channels,
> ranging from 1 (MCP9982) to 4 channels (MCP9985).
> Reading diodes in anti-parallel connection is supported by MCP9984/85/33
> and MCP9984D/85D/33D. Dedicated hardware shutdown circuitry is present
> only in MCP998XD and MCP9933D.
> 
> The driver was tested on MCP9984 and MCP9985.
> The driver supports reading temperature channels and setting
> the update interval.
> 
> Differences related to previous patch:
> v1:
> - initial version for review.

Huh? That's v1. What are you comparing?


>   This is a continuation of the IIO driver:
>   https://lore.kernel.org/all/20250930133131.13797-1-victor.duicu@microchip.com/

So v7?

Best regards,
Krzysztof


