Return-Path: <linux-kernel+bounces-807258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7204B4A22F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A9D51882EEC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 06:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610823019CE;
	Tue,  9 Sep 2025 06:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4q9qLO3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5F21FDA92
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 06:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757399177; cv=none; b=kjgeQ9vxh412LqKqW5OKu/EamqS9yWvo1rd9hsAROdY7OJ1LVD6LTS0j45gdiQC36wIb6muK5ZBMIgtLe6uJCcXE/u6lGiT4KScA7TYXm+eKn/cWYLN0ztrvLloybpGJQatq0Ryk07NW9U4BoibJwwStQ6PwISH1jGcmxM6cW1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757399177; c=relaxed/simple;
	bh=YbWIp1etHAL++R3wubMIbRxn6cnxljb60DrA25TQIDc=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=Ve/10PMXzXBzE9DvNQGOwdS8dn+DPYe/XgvgIdl1E+5FKTJMIMmeDhPXpW1irxZ9V5aXSl9GvDt5RJXcEcQFLueNF4h+gPzXLkp1LRcDqca9p2BIKM2cEwfvyTO+Dm2BNxSRrm23OEfsewgOWJ4eNIsG1lHydNMnFqZo0chVnFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4q9qLO3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC86C4CEF4;
	Tue,  9 Sep 2025 06:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757399177;
	bh=YbWIp1etHAL++R3wubMIbRxn6cnxljb60DrA25TQIDc=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=r4q9qLO31+rP6suBIU22lSvAgG0X1922JQYw0cn6Grt7BYx4yOFfyvdMzwyWjoX5t
	 gqSsp4O/qw/2FPyPGBgCm1giFGvWydAlt/4IrX2SnzEGDIW7mLJURqnWLN1LACDDzY
	 YsoXlOnz/NwBQNhaVBbjF6i6cfyQ6Z1leN7cS6bz/2dHDEuxFXQj4tEGr8iJPZfWaf
	 s/9pCvXKssRrDQm1GXkbykOgFRsFFz6BJ8wPejWQz1Whil6ymH/RE2NARGVbR7T8ps
	 7wHcRsgJ7hIHgmy672ujl6VtKMgjcYeHfDTZS8m3wEiJKpobJFsiox4w4mJut0ikes
	 zJiUY87zlpC7w==
Message-ID: <7b1a1a8848e7b0e3a596335715b2fb0e@kernel.org>
Date: Tue, 09 Sep 2025 06:26:14 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] drm/bridge: write full Audio InfoFrame
In-Reply-To: <20250903-adv7511-audio-infoframe-v1-2-05b24459b9a4@oss.qualcomm.com>
References: <20250903-adv7511-audio-infoframe-v1-2-05b24459b9a4@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Andrzej
 Hajda" <andrzej.hajda@intel.com>, "David Airlie" <airlied@gmail.com>, "Jernej
 Skrabec" <jernej.skrabec@gmail.com>, "Jonas Karlman" <jonas@kwiboo.se>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime
 Ripard" <mripard@kernel.org>, "Neil Armstrong" <neil.armstrong@linaro.org>, "Robert
 Foss" <rfoss@kernel.org>, "Simona Vetter" <simona@ffwll.ch>, "Thomas
 Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Wed, 3 Sep 2025 19:21:29 +0300, Dmitry Baryshkov wrote:
> Instead of writing the first byte of the infoframe (and hoping that the
> rest is default / zeroes), hook Audio InfoFrame support into the
> write_infoframe / clear_infoframes callbacks and use
> drm_atomic_helper_connector_hdmi_update_audio_infoframe() to write the
> frame.
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

