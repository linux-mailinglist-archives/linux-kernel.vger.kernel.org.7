Return-Path: <linux-kernel+bounces-837474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7769FBAC642
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96B7718845CF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AE72F7AB4;
	Tue, 30 Sep 2025 10:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2PeqyEI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C412F90DC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759226473; cv=none; b=jzo0uI+Ct/c1Sn4UrJFZIBoFK6w9YglxDeXnYdpm/tUUfPfz482EM76ACeaPYuMpPzl+0PoPOiPyYc7j7LYKwqb2HpjiMXHcsoGuRp/wrUyesY8H7paGJwvaByLMs+Im1M8IBdfLHq3to7RCHDF0D5Zy4nAlsiz/mYpYvUczK30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759226473; c=relaxed/simple;
	bh=iE2mWhWpgyfdhRuac9l6SJdLnf87YLnaaVLWoINpmsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p5VRtS6nEUuN25q2FG887JZv/eaIpw1y9g+WQvF4uKIOEWl395kq5ruyTM5B/M4FEPXPmRPBLThcA3sg0f2RcFWstC3pk16KDGbwVNa+PT/18G9POnRg23bcs249PmvF/InpuRl1wW8QhRDeMDuIp2e/QXyI2tRQEr2y7X1vVmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2PeqyEI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB080C4CEF7;
	Tue, 30 Sep 2025 10:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759226473;
	bh=iE2mWhWpgyfdhRuac9l6SJdLnf87YLnaaVLWoINpmsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u2PeqyEIEn/RL+ZKEIeA4zVMUVCsYx6OoYULh7tAqpkOu/mtxRbUiZts8vE7Trnbf
	 F9giSkCK13o9kSKSRF0vvY5ybUi9qGUgcSzN6odhEy1sgzntPoPVqcQmDX6p/xtWqs
	 2CTPgtdIq3181IFkY4sgVj5VDtJDSeYDT1+piVwGS2DzPhK4wLO4u4VwvBDhp6PtSq
	 GXyekemMBEvyeJEC1JDrLQE5/tI0UpDfVEG82PUBlwLH0pYRJfSaE5tJVoxxFin1SQ
	 SZ8bqEtwljALdCuI507fkwVp/gObKoardw6QrHiMgpL/4Y68Qh3CCh1ojJtz6l748p
	 6mA78Er5cjd4A==
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
Subject: Re: (subset) [PATCH 22/29] drm/tidss: crtc: Cleanup reset implementation
Date: Tue, 30 Sep 2025 12:00:51 +0200
Message-ID: <175922644629.1134117.326733890416317223.b4-ty@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902-drm-state-readout-v1-22-14ad5315da3f@kernel.org>
References: <20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org> <20250902-drm-state-readout-v1-22-14ad5315da3f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 02 Sep 2025 10:32:50 +0200, Maxime Ripard wrote:
> The tidss_crtc_reset() function will (rightfully) destroy any
> pre-existing state.
> 
> However, the tidss CRTC driver has its own CRTC state structure that
> subclasses drm_crtc_state, and yet will destroy the previous state
> by calling __drm_atomic_helper_crtc_destroy_state() and kfree() on its
> drm_crtc_state pointer.
> 
> [...]

Applied to misc/kernel.git (drm-misc-next).

Thanks!
Maxime

