Return-Path: <linux-kernel+bounces-742483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD07B0F237
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 14:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B07BAA1852
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9882E5B19;
	Wed, 23 Jul 2025 12:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0oRYKzX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB27210F4A
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 12:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753273689; cv=none; b=NreFdE8dn1tbnEn8aW5btNdCq+7erjb7ihfkqfoYhA+QtVcUBlIMlSDD8c1hdFb1N8+Ejv1NhQJH6gvIwvjUZL8BcqQDfrG/g6cjlEfQ32v0vqGUk6l2uzAh56PHI2iZR5fk+6Jfk/Qakt00LnOJEtKJipBVqEXv1U9ydJtggn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753273689; c=relaxed/simple;
	bh=AU+ZIa1G6D9rjfQjIunyEIntuf2L1dafuWtnlP0A0Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjiEhXzUgUktGSEsrvi4nH/leB/KA2dkO6dafo79Ym1xGwh/8DCR9uxhzi6ZfdqFO/nHV7AbLjyFrFPIMIC9X1e6fQP17rgBvhE30zS+6qvB2WqLoHa/4usAXkv10JgiVxhIgZhgZ9Hj8miK3NeLOvLAng55nawEhJpe/NdPSfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0oRYKzX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C9FC4CEE7;
	Wed, 23 Jul 2025 12:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753273688;
	bh=AU+ZIa1G6D9rjfQjIunyEIntuf2L1dafuWtnlP0A0Pc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n0oRYKzXdwPTrCEm2QRJLSnz9cuRDx/l0eBkDKDbxwoZNNrDW4AluzB+hvEtQBUNL
	 ak3lp+UelHKS+uCQ9HN6NpPvaIb/nMVT8LHrw4HHejvu9A4ncAYEaBeIUML6zvDxJs
	 +o5/FbTVAZMiaL3zoeTufZhN4EjozDAD9sVEcMHEWhk7/p8rw7WOvuwnm7hD829n3x
	 xxmgwjVsfExCyBCdAsR7GzjesrLC98Iqt/EXKORQTxSvk9ouIhtHl1jimjYrc3gtlq
	 gXYNf30B6pRllQQqJkD5rqDX3LWZj5rWP5Vr0Y6sMaWmUJck3gvXnzhTGXhW692twC
	 hMO91kswwrrAQ==
Date: Wed, 23 Jul 2025 17:58:05 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Jyri Sarha <jyri.sarha@iki.fi>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jayesh Choudhary <j-choudhary@ti.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	Francesco Dolcini <francesco@dolcini.it>,
	Aradhya Bhatia <aradhya.bhatia@linux.dev>,
	Devarsh Thakkar <devarsht@ti.com>,
	Parth Pancholi <parth.pancholi@toradex.com>
Subject: Re: [PATCH v4 05/17] phy: cdns-dphy: Remove leftover code
Message-ID: <aIDVVRS0bcdjs5q_@vaman>
References: <20250618-cdns-dsi-impro-v4-0-862c841dbe02@ideasonboard.com>
 <20250618-cdns-dsi-impro-v4-5-862c841dbe02@ideasonboard.com>
 <aF3YgKoaLniqs1XC@vaman>
 <cd59d7b0-6b31-4cbd-93e8-df713a9210f6@ideasonboard.com>
 <b3af4b52-03e0-4e41-9666-a9af267f57b0@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3af4b52-03e0-4e41-9666-a9af267f57b0@ideasonboard.com>

On 23-07-25, 11:49, Tomi Valkeinen wrote:
> Hi Vinod,
> 
> (I accidentally sent my mail only to you. List added here).
> 
> On 23/07/2025 10:36, Tomi Valkeinen wrote:
> > Hi Vinod,
> > 
> > On 27/06/2025 02:32, Vinod Koul wrote:
> >> On 18-06-25, 12:59, Tomi Valkeinen wrote:
> >>> The code in cdns-dphy has probably been part of a DSI driver in the
> >>> past. Remove DSI defines and variables which are not used or do not
> >>> actually do anything. Also rename cdns_dsi_get_dphy_pll_cfg() to
> >>> cdns_dphy_get_pll_cfg(), i.e. drop the "dsi", as it's not relevant here.
> >>
> >> Acked-by: Vinod Koul <vkoul@kernel.org>
> >>
> > 
> > Are you fine merging the two cdns-dphy patches (this and 4/17) via drm
> > tree? I think that's the easiest way to merge this.
> > 
> > I could also drop the 5/17 patch from the series, as it's just a
> > cleanup, and it could be merged at some later point via phy tree.
> 
> Actually, I take that back. Devarsh also has some cdns-dphy patches,
> which depend on my patches. It could get messy.
> 
> There's no compile-time dependency, and my DRM series doesn't depend on
> the dphy changes even at runtime. I think it's best if I drop the dphy
> changes from my series and send them separately.

Okay sounds good to me.. Easier to handle that way

-- 
~Vinod

