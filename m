Return-Path: <linux-kernel+bounces-744045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4521AB10754
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F30E1CC1ED2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE5D25DB1D;
	Thu, 24 Jul 2025 10:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjwqsnFD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD4225DB12
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 10:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753351425; cv=none; b=HPXHH0tZuwlrXb7EoYlok6AKmermGcZOvsPMbkdBThKrbOURQZlARyfsuhIe0q5B+EPu68z5AQ6yYGiFEea18VmqyrFokGbcXoNUkDQKgG68kHrllmq5W4nliRH+EnwtEK5T9NuVxdD1iMlHYUzOmLRfIV8Kx8bKNuc4GXo8UrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753351425; c=relaxed/simple;
	bh=20uopEcddKtOz2si11V0GlpOFH798R4/RoR91R0ERDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUSQ4t1lk+R4UjAdqARNSHHT3k1x9u3CwkNTwOdizczT39GbkI4cjH++YQLa7zu4Burnt5c1zK7Vx3+yO1sQX1/rDN0wUyvvG0IIiV1I23qFWxt+iNfChDiz/DmB5eSYHGcwQeD+Vd6h1X1I8r+u1TSluKOmp/SQSeYPJmjLgNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjwqsnFD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F70C4CEED;
	Thu, 24 Jul 2025 10:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753351424;
	bh=20uopEcddKtOz2si11V0GlpOFH798R4/RoR91R0ERDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TjwqsnFDaHw/giRbw6Vl10tXHvW49hp6s8+GLLwMHBGdg8o7Kbk6L0VQcl9W9XUC1
	 caNB2jJE75tRr4BZSIgSG5ircpDkmlVCpN2HGfBe1q9qxakFoJjdddD9I2i56fwS12
	 zig9eFZAYrgoVg2aXfQp9L9yv2jtaxwKUmpDMrnBbMNcckR3SZJ5R7nOgyXy3k2QJj
	 CQ5X9ZF6GUwG9hN0yigjBHCdgppO/n9gCYWOEezQln+jxtlssk9Qq7mLaMMelXfGy4
	 smqo9aZZtGDYngZ3OfRPaneCyBcI9Z3TOjTVKshhcfEAplO+hk8e+Vvu8NvYtku3OM
	 1t/Q9I2CxZuPw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1uesnb-000000006u3-1nU1;
	Thu, 24 Jul 2025 12:03:39 +0200
Date: Thu, 24 Jul 2025 12:03:39 +0200
From: Johan Hovold <johan@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Douglas Anderson <dianders@chromium.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/bridge: fix OF node leak
Message-ID: <aIIE-zomDEuBb6eZ@hovoldconsulting.com>
References: <20250708085124.15445-1-johan@kernel.org>
 <20250708085124.15445-2-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708085124.15445-2-johan@kernel.org>

On Tue, Jul 08, 2025 at 10:51:23AM +0200, Johan Hovold wrote:
> Make sure to drop the OF node reference taken when creating the aux
> bridge device when the device is later released.
> 
> Fixes: 6914968a0b52 ("drm/bridge: properly refcount DT nodes in aux bridge drivers")
> Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---

Any chance we can get this one into 6.17-rc1?

Johan

