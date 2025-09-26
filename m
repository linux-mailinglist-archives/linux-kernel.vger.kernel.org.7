Return-Path: <linux-kernel+bounces-834606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F81FBA510F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 22:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 578E43B793C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 20:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A94285C95;
	Fri, 26 Sep 2025 20:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kW0QYxg6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F56230270;
	Fri, 26 Sep 2025 20:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758918600; cv=none; b=IGYVG+2Z/B8wg0oO6DMO210Gw3/ZYScq/W0kjXnCiw0f2ZfOLwFU7QbdH2zA/C6iO+6e6Wsg7AzwZXbLv1SXZLfE+emnLJzGz0jMpqWL8WCFakFz0Lr5aZVgJ1NOgMwOYnwbwafZ561ENaPjppu2ALhaB54WpXmNvGRGS1V78+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758918600; c=relaxed/simple;
	bh=4Gq7KvjaCB2WFHjOUePwFbctD4FXh5nNheLbEmsCuc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eA4IwJ4ml+0XkD7y3qp9gNs21dAWWZhpGSoPINgVcKIXQExZU8ngqewRh+OvDIWWs38gffLZBjRNNrg7MK1o3X8WDbMZIqI+x8goegCmExJB16REDNQM4C+8ey93pPM4yqVwdbzhwgPpqbw1gVJYT+Tdcpp72iQaxp3giY3HhWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kW0QYxg6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF811C4CEF4;
	Fri, 26 Sep 2025 20:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758918600;
	bh=4Gq7KvjaCB2WFHjOUePwFbctD4FXh5nNheLbEmsCuc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kW0QYxg6I4w5dsZg2JSo/Xbb6rcY7ewPqlzNVdR56q06BO6p16KmNN2GHNtL9cZFM
	 8EFObXPXlBqe5FBWOstFKaXRcB+NdXvtc2V4ergURRYfHOkR8NR18Kx05UCOzKvpHX
	 sINOHh4P06RXAt7rfye8i9buZfn17rXuNUUaKbM35OQy0JKgPNS1NleOiF74gFRbP9
	 Zm8jSr+BinwyyoWsI/Gkh2ClH4f+JhVULiIJAWnC2RH0y/pngqIjYme9+EfPfAWi60
	 fdUMnxcJdxm+EJMTqvS8Feuu40Yng3iiBud7P1VlVr0W6u4wj0vUUOcygQbunImT61
	 qQ8SEPtZ2AIZQ==
Date: Fri, 26 Sep 2025 15:29:58 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, imx@lists.linux.dev,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>, David Airlie <airlied@gmail.com>,
	linux-kernel@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Peter Senna Tschudin <peter.senna@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Martyn Welch <martyn.welch@collabora.co.uk>,
	Ian Ray <ian.ray@ge.com>, Conor Dooley <conor+dt@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v2 1/1] dt-bindings: display: bridge: convert
 megachips-stdpxxxx-ge-b850v3-fw.txt to yaml
Message-ID: <175891859618.1448277.6748514316682100995.robh@kernel.org>
References: <20250923205549.200670-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923205549.200670-1-Frank.Li@nxp.com>


On Tue, 23 Sep 2025 16:55:48 -0400, Frank Li wrote:
> Convert megachips-stdpxxxx-ge-b850v3-fw.txt to yaml format.
> 
> Additional changes:
> - Only keep one example.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change in v2
> - add description for port@0 and port@1
> - add both ports to required list
> ---
>  .../megachips,stdp2690-ge-b850v3-fw.yaml      | 111 ++++++++++++++++++
>  .../megachips-stdpxxxx-ge-b850v3-fw.txt       |  91 --------------
>  2 files changed, 111 insertions(+), 91 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/megachips,stdp2690-ge-b850v3-fw.yaml
>  delete mode 100644 Documentation/devicetree/bindings/display/bridge/megachips-stdpxxxx-ge-b850v3-fw.txt
> 

Applied, thanks!


