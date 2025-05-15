Return-Path: <linux-kernel+bounces-649929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5A0AB8AD3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 17:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A580F1BC5324
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 15:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813FF21CC5A;
	Thu, 15 May 2025 15:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXlvOBAi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E323F21CA18
	for <linux-kernel@vger.kernel.org>; Thu, 15 May 2025 15:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747323319; cv=none; b=pxi1jd6YDrT/n/A0lGVuvgzMvlpSuV96bSKVjAjzYafQtAFLMPvDn2YPvqmK6QGuu09QyeYalcwNjRP9HPBQbtgmcT8GoY/XP7Iq64I45pso4Iqv/WIk88IywQ9L22rNssdUYYmJmyKTLkbPRxCDHj2vYQzqQwUd73u0NsvfzrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747323319; c=relaxed/simple;
	bh=yIaYdnGb7FH8ol9fW1bB3l/X9nzS/lpn74RtpMpyRJE=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=S+kOt3VsoQRARJgUeJwsuaLkYAig/l18RpZmcHSeyfBnh1z66KJJBoeEnokDt8ueDf9TV3sFcjXlFTL8BaMjB6ZQ9QO2Iv/Sphx4rvJRbSHyOdkihhCxoy+aF4AzBOILIYIlvkZujBSbj5He57wXD0XinCDGruTLv+tm5/isYEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXlvOBAi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4523C4CEEB;
	Thu, 15 May 2025 15:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747323318;
	bh=yIaYdnGb7FH8ol9fW1bB3l/X9nzS/lpn74RtpMpyRJE=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=VXlvOBAiNA4eHrsJ56/TwfpgR2HV7028rjPhztE3H3UWXoFAeoCHsUA3oRcm9BJWY
	 tH2Xo5z2VbDUD6FBMxOCnE+rQx6L+etAzFc7ju7ZYy8tnHNW9U/706D6c+W/aQXhLP
	 SejnmY9kpz3134sldcC/QJRXHVaruFXswXsEYZcgp7JOU+OirARa4OhCbAVdJhJK/x
	 aKeLzmwHxN2MBDMyRrr/5zkI40eT4n9l1QPSqus8WuxjJUuHfH+hxEPKH4SJEI9cnY
	 lxWB7DVoJ5ju5y8U5MRVGi8e89rU9guWBDAkBxTleeK+l3MTF5DRKTRmOFdGekZJCu
	 On/ZXHvuiCOuQ==
Message-ID: <b31473af5e37f9bccb3d6348ba63276c@kernel.org>
Date: Thu, 15 May 2025 15:35:14 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH v4 09/23] drm/tests: hdmi: Replace open coded EDID setup
In-Reply-To: <20250425-hdmi-conn-yuv-v4-9-5e55e2aaa3fa@collabora.com>
References: <20250425-hdmi-conn-yuv-v4-9-5e55e2aaa3fa@collabora.com>
Cc: dri-devel@lists.freedesktop.org, kernel@collabora.com, linux-kernel@vger.kernel.org, "Dave
 Stevenson" <dave.stevenson@raspberrypi.com>, "David Airlie" <airlied@gmail.com>, "Dmitry
 Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>, "Dmitry Baryshkov" <lumag@kernel.org>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>, "Simona
 Vetter" <simona@ffwll.ch>, "Thomas Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Fri, 25 Apr 2025 13:27:00 +0300, Cristian Ciocaltea wrote:
> Make use of the recently introduced macros to reduce boilerplate code
> around EDID setup. This also helps dropping the redundant calls to
> set_connector_edid().
> 
> No functional changes intended.
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

