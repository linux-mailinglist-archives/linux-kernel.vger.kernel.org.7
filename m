Return-Path: <linux-kernel+bounces-837471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A94BAC633
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44752188B1BA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE4E2F5333;
	Tue, 30 Sep 2025 10:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ee+fgcGg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F0E2F39D7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759226465; cv=none; b=sPM1EC0wclh3VyA3LYpYjYUJRjVhKoXCHQzWZhEzewKgWn7E5HrbDS3dosV3y+1YGDi8wZaJNL4XqE4Fm2VTy0ixuZyXr1aCxcsP93bbcWrdAZWXhyGzydL6lyAjjnhtg/TrR71RCvLk/5gGgcMqN2/JkGTaV1MMMeJuvtPTStA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759226465; c=relaxed/simple;
	bh=ISIrSqaNDbfd3r0u3Hqm2C5e4s07Bqky03AjaymtYuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B+5wbvH12vZhzRBbHl9O6yKDazF0sC+z+i5GoRp5Ec0YeH9SQCVSa7a5jdF0i5UqobKTnB6Dcj7sCnaYS343lTVggWL8bz+r4LNWzayAaA5Ft7kBR4kKg1N/1Jf/dCXKk/3NBdmL6QqreXbQ1AHZ3mDif+90DDwlo5saP3Yw/oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ee+fgcGg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC6BC4CEF0;
	Tue, 30 Sep 2025 10:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759226464;
	bh=ISIrSqaNDbfd3r0u3Hqm2C5e4s07Bqky03AjaymtYuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ee+fgcGgzhxJYAPi5iv/fe/sRQX4f8vuof9s4V9o6U2urEMRhN4/kJVpvKOournsw
	 VPbnNfQ8mHNJVarxGzHP3aFEf9ROIONFn+9FLgMRfUHxoARluaskP0pUpOKeLLvh0K
	 DpjKjBd7kkUEUdlZf4k3RzjbhLSx4Xvg9+ftu3CA9o+B3hyxHgxbCSMPuBmb7EzFM4
	 dbywbmuTYDIOcaxBXNN7JL2SlgyPm1HZR1kIMoufyQDR1dXLvMp3Z38ZRpJnxk+QwY
	 Q4nrbnMrkXpVRRL/y9wvTwL+zzoE4NfCtNQ0v4cYiGAbYoOnHWjrL2cIU0mKKVGjKq
	 Fgg/sLDu+oB3w==
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
Subject: Re: (subset) [PATCH 19/29] drm/tidss: Remove ftrace-like logs
Date: Tue, 30 Sep 2025 12:00:48 +0200
Message-ID: <175922644628.1134117.18223999280547569910.b4-ty@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902-drm-state-readout-v1-19-14ad5315da3f@kernel.org>
References: <20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org> <20250902-drm-state-readout-v1-19-14ad5315da3f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 02 Sep 2025 10:32:47 +0200, Maxime Ripard wrote:
> These logs don't really log any information and create checkpatch
> warnings. Remove them.
> 
> 

Applied to misc/kernel.git (drm-misc-next).

Thanks!
Maxime

