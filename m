Return-Path: <linux-kernel+bounces-837472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7185BAC636
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CED151891CC3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C272F83CD;
	Tue, 30 Sep 2025 10:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9T4fjwX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDEF2F7AB4
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759226468; cv=none; b=W9YI6elkL1Y2PhOpVYoKrZBQRiRfonTCgb55FTlQLce9J3JQMcNFV6jQboFuNFGnnW2HHetND/OWZV6wEU8L1MYR8jkr9vx84cjib61jnLEwE9orKuVtg0hOXTgA4ISUtloUzkSRNflK9g4H768dI3Zof/CgokzQWBLM1iqmZZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759226468; c=relaxed/simple;
	bh=JPrT6KDCEnTENM59moZKSHIWKhaq+FH1wUwgHQEpfmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t+94Yp98xP9qhzj4jqnlamlnjDtlIVDe+f+nC0TgSLIzrOvrQcmxJJeRsUxd6uwmHyMpbxMsXcUWYB/x3aKkajGjCY65v3nChnvyh1Q9NJ7lK+XpSOjPCK5BCtLpE3W1AyFV2uYg2eQAR2VF5xKHrzMdlE5N/20CIi1OtudKXTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p9T4fjwX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2219C4CEF7;
	Tue, 30 Sep 2025 10:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759226467;
	bh=JPrT6KDCEnTENM59moZKSHIWKhaq+FH1wUwgHQEpfmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p9T4fjwXz0TPf5TpCFHj9E7v/Uo/A6jHmQQVxSyJwfJ31CR2aFKVhVOiYNUjNSQlo
	 fNwkR2fa7S9oUg0Q1iX3+MVplPDLLPLUVTmDNtFUeu8sNjk3KL8KXZ4LwdfQ5KPzTd
	 uJsFQhkP9m8vKu0ff357J+o0BTKjXbzO5arPktgrMhd+D0+OJOjj2TsutlG+rw5gaC
	 B6fAaEWXNv0tTIVQEkeuX5dHDMx0B70j8r+TmE/GkNV8SX/f5w0Rzo6ffUntoChb5c
	 wlFbVdRNA7aFVuWDnF9wp6QfooFp7unqFl4Y12KvVLQpZ7rf3KRg/A0+JXHLppSsHE
	 iXsqvLodvZ+aQ==
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
Subject: Re: (subset) [PATCH 20/29] drm/tidss: crtc: Change variable name
Date: Tue, 30 Sep 2025 12:00:49 +0200
Message-ID: <175922644629.1134117.17213082084432830487.b4-ty@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902-drm-state-readout-v1-20-14ad5315da3f@kernel.org>
References: <20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org> <20250902-drm-state-readout-v1-20-14ad5315da3f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 02 Sep 2025 10:32:48 +0200, Maxime Ripard wrote:
> The tidss_crtc_reset() function stores a pointer to struct
> tidss_crtc_state in a variable called tcrtc, while it uses tcrtc as a
> pointer to struct tidss_crtc in the rest of the driver.
> 
> This is confusing, so let's change the variable name.
> 
> 
> [...]

Applied to misc/kernel.git (drm-misc-next).

Thanks!
Maxime

