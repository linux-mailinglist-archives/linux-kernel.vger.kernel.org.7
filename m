Return-Path: <linux-kernel+bounces-837470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD239BAC627
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D58848261E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1EA2F6599;
	Tue, 30 Sep 2025 10:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHynn5kC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797022F6586
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759226461; cv=none; b=iUgEhL14fMiqHJBwVz4RyJS5YQF4LJaYMvG1JHsgomkvPm2CMb5YbTQYxUsoqMLLPfT7DeBgdcWN2gF3Keik985EE6aDo+Cg0p87BIVNFbpkQhzYfvdHKF0uEAKM5pjRJUAZnrkvnb47TQ/8Xg9Rxmur2UxJYTMUI8G2dwOzYqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759226461; c=relaxed/simple;
	bh=GOUfO1dCK/iE0xHQiO3vE+fUV6cDrDXNClGxmyxUo+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WL/dxIFs/LxCbLz9fYkpk2umDbJzCeO/31jIp8Zg6fmeBR9wSm7UWpTj0KY6wzvBnP3+wKyycjJSn6phdYMeWKZ7prktVZHTFRXD1sznDtG+Z6/cu/pR/k11r8IQ466drytlkMZqaTqpDtD3c+ljF47g7jkbuYoSQ/stzC+Sb0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHynn5kC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0039C4CEF7;
	Tue, 30 Sep 2025 10:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759226461;
	bh=GOUfO1dCK/iE0xHQiO3vE+fUV6cDrDXNClGxmyxUo+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mHynn5kC8oPoDpnKl2NtNj5hx+l+haQFcISW+FjaTCjuuTNLa/2JnH4t5I+IdrmBE
	 bvKTQGkoI6tFMwcKyxxU4XPLlwYO8z3/ogt3SUr9i1PscmwWnpKMaJVqks7Rtnx9Ua
	 PcrDWEiLHfFPvM/S0gpXN3Mt6rZj5GRskomFr60z/YZcyaagk5jVkn+ww8xF/RerSa
	 1JAo3KUG3tXAl9H/1ZsVG1t9nWdPpgX50eUrMHI4Ywt2zoHFsWnk4WqLq+au8iqEKt
	 Qnh/tMMAfZ32+zAR3822CUDQssLxGOnj81rEDj66OazICkbO4ZsfZLmu/EfhjPYJlk
	 KGYjmzLZ8gQXw==
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
Subject: Re: (subset) [PATCH 18/29] drm/tidss: Convert to drm logging
Date: Tue, 30 Sep 2025 12:00:47 +0200
Message-ID: <175922644628.1134117.4851349246950865623.b4-ty@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902-drm-state-readout-v1-18-14ad5315da3f@kernel.org>
References: <20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org> <20250902-drm-state-readout-v1-18-14ad5315da3f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 02 Sep 2025 10:32:46 +0200, Maxime Ripard wrote:
> DRM drivers should prefer the drm logging functions to the dev logging
> ones when possible. Let's convert the existing dev_* logs to their drm
> counterparts.
> 
> 

Applied to misc/kernel.git (drm-misc-next).

Thanks!
Maxime

