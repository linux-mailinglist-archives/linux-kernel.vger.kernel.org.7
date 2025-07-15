Return-Path: <linux-kernel+bounces-731302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAFCB0526D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7751216D604
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BDB26D4D7;
	Tue, 15 Jul 2025 07:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WF2ns62b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7965B1A23BB
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752563396; cv=none; b=GNDHeqkMxY+2gBZVGrXIDgzzGvhDOYHPyIPc/J464VuBUyE0NNC7Lr3A3jftfcYOO4R7VPOnH6M5JEgexJQEi1uPi+F1lHVHfyrFko2BnKaRqU77NQXZpCs8dfCKC659G2VD+2EYTMQasOfZlYOR248I8EjsVCpyeBSqd1NJzb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752563396; c=relaxed/simple;
	bh=Nvzui/TM7VJRjAiGp/4YnsBIzg9V4PsOmMn93z6Xg6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AzZosOgmqQLbmsFyRDTnaZewEm8Ps8LBRgpF6joMqZyZCeL6Rrf01zpCdW6sUOtTU6/VKkMC0sLj35n7db8/yaAFciZyrZxsAogfG/xqo7OOrrmVNDITtW82ZuRibYCiSWdgMarWAq6IXPKnvUwSr+NiHxQEW66u9rYfmanR8y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WF2ns62b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09BC7C4CEE3;
	Tue, 15 Jul 2025 07:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752563396;
	bh=Nvzui/TM7VJRjAiGp/4YnsBIzg9V4PsOmMn93z6Xg6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WF2ns62bfzZeUmtFVTPHni6K9cHhWJhx4h4uUDXySVVtcDOrqLYNUKL/jH4LEj3Re
	 Pzu/zosASsN0QPtUSs9UwhTXq3ZIsjt3HhEtaQF9SAt+OaUitHq9GPHWzVIzIn2hB2
	 Z7Ms9zZo1FyuRJyfUdjIIYIZHXS0exUPz2extkM8HF4sFA3/C1c9UEZ5JeE4auuGOE
	 fc+Sje2t6jjPriDMGQW5dnQckAUrDs3L+wUU90khEGBtHHnpNVUr8hi53xhyHld/PB
	 LU0N20L7M9aH7PgCvspTs/TaqVpLgyGsEkNYXIzhh6AbVjl0NWtq3Uk9rlm5s6q3wE
	 cSGEVo0swFZRA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1ubZnT-000000007aQ-0aGV;
	Tue, 15 Jul 2025 09:09:51 +0200
Date: Tue, 15 Jul 2025 09:09:51 +0200
From: Johan Hovold <johan@kernel.org>
To: Doug Anderson <dianders@chromium.org>
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
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/bridge: ti-sn65dsi86: fix OF node leak
Message-ID: <aHX-vyOnb-gZmsi1@hovoldconsulting.com>
References: <20250708085124.15445-1-johan@kernel.org>
 <20250708085124.15445-3-johan@kernel.org>
 <CAD=FV=V1LN2Q2C9P9Ed3V+Uar_T2Sp--ssnf8H29R-N2Qz3uEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=V1LN2Q2C9P9Ed3V+Uar_T2Sp--ssnf8H29R-N2Qz3uEA@mail.gmail.com>

On Mon, Jul 14, 2025 at 11:46:12AM -0700, Doug Anderson wrote:
> On Tue, Jul 8, 2025 at 1:52 AM Johan Hovold <johan@kernel.org> wrote:

> > Make sure to drop the OF node reference taken when creating the bridge
> > device when the device is later released.
> >
> > Fixes: a1e3667a9835 ("drm/bridge: ti-sn65dsi86: Promote the AUX channel to its own sub-dev")
> > Cc: Douglas Anderson <dianders@chromium.org>
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---
> >  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> The patch doesn't apply to drm-misc-next, which has commit
> 6526b02e1020 ("drm/bridge: ti-sn65dsi86: use the auxiliary device").
> Seems like you need to resubmit as a patch to the new
> auxiliary_device_create() function?

I've already sent a fix for the generic implementation here:

	https://lore.kernel.org/lkml/20250708084654.15145-1-johan@kernel.org/

> Do you feel that this is urgent
> enough that we need a separate patch for stable?

No, we should be good then as I assume this bridge is typically
registered at boot and never deregistered (that's also why I left out
the stable tag).

Johan

