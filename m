Return-Path: <linux-kernel+bounces-832332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C24D0B9EF79
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42D8738612F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078292FB98F;
	Thu, 25 Sep 2025 11:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="du25BLER"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660602FB977
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758800621; cv=none; b=iKstdXuUYJYPpmSRAG1pZNR+4LEHEhpoeFypZqbSM/kG2dzKSiELOFj2bNwTgtc133noCnITN1388NeSFcTM0nswS1HgVLRu5riB8ZsGp7iENDC+xwbViyfQjbhq3Km7l2uZzUb7SbJyNug3VCn/Stfb0YmXVe0ug2xTEulNcwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758800621; c=relaxed/simple;
	bh=rI80DpxkWyb1bMaRJKV8fhqT6n/fBQe0+fpkvi0ft2o=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=tu+b/2Md5mrahP1oyTwbA5ZN4WvpwmYMTnPUKo2NIq5SjTDMC5YJiscI3Zpa6uW8+eIwydxYjuiB+yL/r2Wz9SjJR3+ZOiLBBY7DASDwNKjjf66e/uFjQj9UgsunSBgmDnW2N0E6Myvg0mP7jvNXLnuzWOUiHuEKtTRYzSm6dVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=du25BLER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025D5C4CEF0;
	Thu, 25 Sep 2025 11:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758800620;
	bh=rI80DpxkWyb1bMaRJKV8fhqT6n/fBQe0+fpkvi0ft2o=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=du25BLERyCM9aMdMj4ZvxrGoyUw5up4bfho38wQ+RxCbIJGvl9z6Zr/6dpzXbkq5b
	 w1QYLiqEO/Wq7h8ueH6tXsKU7E3L1CoOztVW84qJ/U0GzboYGMHPxZvyNqmdDbtISA
	 Qe2bnqnjaXg/6911BWc82kmJPNv1pFz9Xkb0askPeMCaZzKZZDYQVgDt+D7V/LuDjr
	 mIz4Oi4vwzzvDExJBa5igmgT9SyGm/ulFKD8B3JEJbttageONrdk8TPO4w/GqvoFC+
	 M83HL+xeK0JJ3GUwhYEgmrIMZmaI6qzBlXpBXtJHVduCbXm7LkSUc3GFQshDOis7YX
	 ed0R/ujLqYtig==
Message-ID: <b679b36f2291be5b03e2717282ec71c8@kernel.org>
Date: Thu, 25 Sep 2025 11:43:36 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH] drm/bridge: refcount last_bridge in
 drm_atomic_bridge_chain_select_bus_fmts()
In-Reply-To: <20250924-b4-drm-bridge-alloc-getput-drm_atomic_bridge_chain_select_bus_fmts-v1-1-f8c2efdb783f@bootlin.com>
References: <20250924-b4-drm-bridge-alloc-getput-drm_atomic_bridge_chain_select_bus_fmts-v1-1-f8c2efdb783f@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Andrzej
 Hajda" <andrzej.hajda@intel.com>, "David Airlie" <airlied@gmail.com>, "Hui
 Pu" <Hui.Pu@gehealthcare.com>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Jonas
 Karlman" <jonas@kwiboo.se>, "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>, "Neil
 Armstrong" <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>, "Simona
 Vetter" <simona@ffwll.ch>, "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Thomas
 Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Wed, 24 Sep 2025 17:11:01 +0200, Luca Ceresoli wrote:
> Get a reference for the last_bridge when it is obtained and release it
> using a cleanup action.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

