Return-Path: <linux-kernel+bounces-837469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 397F6BAC624
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED51A1C75CD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BDD258ED6;
	Tue, 30 Sep 2025 10:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRtqJTjY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D82354918
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759226458; cv=none; b=lrUOwVpNkoYzp/BwGHmbH/svueA3eoGP6kqyGdHu9CiNuMA9BdQe+L5OH4jVcINYuZ4AKSZgx6UfLPoMfD8jS8epZLqIoVnO4+C86vxMOXdekBYHXcJ1/umfNqOGHY2/HWdHOBqyPcToicSXhyMw+MOh1NyhdUubvHBbL0TacxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759226458; c=relaxed/simple;
	bh=XAMMYSM23s4Sr91qvcwkHuDHPtXh8HsK9x4B/pBQNpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=koD2qbqgJhNVyowbTP3GEQE6jRlKZ6Ayzq/hvreeRVm9B3FM/jOR/B2Lkzvv7gmnNSZJ2HXPFWcjkU9J957p3GmWhxIRk/RANTvdU6rcBkYv2U5OGaYuSdt9oFAXUZi6v2/7kJmOgca61fhqMywS6sjUyjRoFyFPF4qfxF7j3Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRtqJTjY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D3FC4CEF7;
	Tue, 30 Sep 2025 10:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759226458;
	bh=XAMMYSM23s4Sr91qvcwkHuDHPtXh8HsK9x4B/pBQNpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gRtqJTjYABiPmKSJb+M9LybHdvqyKz4VWsHjkwkgDyndzvHWnHMm2QEq86bnzlv23
	 Wu8/TNhfVNdVpMX5RuCpNbx74c/0xY9GeixDoK1wqDdGcfTB5oRmd9u75g2FzA39Ln
	 4XprkrtMzmaRv3gVrDyN6vGqBCdkWxz4ies5b05mEH/vv8GeoFvzyOT2Eihi8F/ocf
	 BaKHXiM8HMM5Oia0DrD4ZJVhHqWIxKgAWz3IzJUSUERpFIZl+jRHll+cf/mUhhbKmO
	 653nyeZnc1TAv5SpX8HxoKt/pGweQFZ2NJfaOga8d1pdjuzkqX8DzIurpQT0+eunIy
	 AjsYEaWkBPX8A==
From: Maxime Ripard <mripard@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jyri Sarha <jyri.sarha@iki.fi>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maxime Ripard <mripard@kernel.org>
Cc: Devarsh Thakkar <devarsht@ti.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 11/29] drm/crtc: Drop no_vblank bit field
Date: Tue, 30 Sep 2025 12:00:46 +0200
Message-ID: <175922644628.1134117.18066652502091926762.b4-ty@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902-drm-state-readout-v1-11-14ad5315da3f@kernel.org>
References: <20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org> <20250902-drm-state-readout-v1-11-14ad5315da3f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 02 Sep 2025 10:32:39 +0200, Maxime Ripard wrote:
> The no_vblank field in drm_crtc_state is defined as a bit-field with a
> single bit.
> 
> This will create a syntax issue with the macros we'll introduce next,
> and most other booleans but the *_changed ones in drm_crtc_state do not
> use a bit field anyway.
> 
> [...]

Applied to misc/kernel.git (drm-misc-next).

Thanks!
Maxime

