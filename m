Return-Path: <linux-kernel+bounces-738529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E58BB0B9AB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 02:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D04F178032
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 00:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4265148827;
	Mon, 21 Jul 2025 00:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hacktheplanet.fi header.i=@hacktheplanet.fi header.b="uRC9ACyA";
	dkim=pass (2048-bit key) header.d=hacktheplanet.fi header.i=@hacktheplanet.fi header.b="fJKBMeER"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F2F43AB7
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 00:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753059588; cv=none; b=PT1jf3pMoC+oCgMFHUUR2p1vAZqOhUjp0mU8kcB/82nmMv1F9a/YEs/peVvXwVLY73J3Y3mRU0PHBP6K64d6vIycYjGyDMzUs21DQH9SkCDX4uBCIrgq4QpMUxfAAb1bCJl+YYqOAPEXOTCBQWSlj3T8x9ZXROtxVSzGPLTRJMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753059588; c=relaxed/simple;
	bh=lufO/SfGrebt1Uvbo8PEo5A3P1gKInv82B1zFvN3hUo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pWNeI4lxUlNBoOMB1LWWhfXOeRAd4qXCLdz3mzhl47/f7xp+CKeKf2m8q/fsd5Mv3dZGGTYL9dB8uxbKu6LLZMcCYWNPIeaeFd+1D7od20h5RdGV+4DQzCaucmjCAFWLcKlKIB/n6jNQfgmcS6mDZozmWPvP2aPjPZEkABwNXtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hacktheplanet.fi; spf=pass smtp.mailfrom=hacktheplanet.fi; dkim=pass (2048-bit key) header.d=hacktheplanet.fi header.i=@hacktheplanet.fi header.b=uRC9ACyA; dkim=pass (2048-bit key) header.d=hacktheplanet.fi header.i=@hacktheplanet.fi header.b=fJKBMeER; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hacktheplanet.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hacktheplanet.fi
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=gibson; bh=lufO/SfGrebt1
	Uvbo8PEo5A3P1gKInv82B1zFvN3hUo=; h=subject:cc:to:from:date;
	d=hacktheplanet.fi; b=uRC9ACyAEhafmE4EN5ocUEoH4WADgLMkktPTudXKK3zuAatS
	m3m++bZ718wNzXXJ3kZQVx4wyCprjiHquLB1NJJCB42gIRIKCw/SD/LCWDrMCK7+/B8cLQ
	n02qwSMeoBOtPjDUMHKlZX98JIlwP+4aHKMquOO6HZ1tlDjj4KbHhtaJmeDzwIq7qBdJC9
	vgNojPA+4u3XxYpKo9usAJPS2fsvVaHDtpD1FHlAG6PE03T1DkH+TzrBSjvlWl/xdNAh14
	L6uZsV/gWzjSQ4DRQkkCjr7RCcqyIlUnTuQwAhPJEt5qLGMASPdGiKx/gvuwHz1APgJBcY
	MpMDuyHmXqd6Fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hacktheplanet.fi;
	s=key1; t=1753059583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=//RALJ2DG6eoPJ8kGoGEizkYKrZ/iIm2f0PKjGpS5XM=;
	b=fJKBMeERTYdiWXnm6lLcp0iNaf+qL7mgXRqsi0b5iQdyRDzjnLX3x5ONU6ymnyShoYEe7q
	/sb5x676LLe08M0Za0yROcqC/4VJGRwTdceUGfOdHA0cibJB1LqARvLukQ+zpZILjKmoKY
	JhH83xpSq5sMu6RsvnaUvzWkBFgqTQDxTHOH0IneHSy6rxMeqj6+M/thUDn26D8+1w+YRh
	whKGq00PBRcenrF2dUyETfhSN0RuYxAR3pcsBJUJ8NKLmTJJYo4McuwCj1X0T3GI5at0zK
	wdxZzN/WkIcphMFE0sdi+dOhlWToFmSJh/5Gxx/4u11pbBoAZ2Uoyhw7EB1sHg==
Date: Mon, 21 Jul 2025 09:59:40 +0900
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lauri Tirkkonen <lauri@hacktheplanet.fi>
To: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Mario Limonciello <superm1@kernel.org>,
	amd-gfx@lists.freedesktop.org, Wayne Lin <wayne.lin@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [REGRESSION] [PATCH v2] drm/amd/display: fix initial backlight
 brightness calculation
Message-ID: <aH2Q_HJvxKbW74vU@hacktheplanet.fi>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

DIV_ROUND_CLOSEST(x, 100) returns either 0 or 1 if 0<x<=100, so the
division needs to be performed after the multiplication and not the
other way around, to properly scale the value.

Fixes: 8b5f3a229a70 ("drm/amd/display: Fix default DC and AC levels")
Signed-off-by: Lauri Tirkkonen <lauri@hacktheplanet.fi>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f58fa5da7fe5..8a5b5dfad1ab 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4941,9 +4941,9 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 	caps = &dm->backlight_caps[aconnector->bl_idx];
 	if (get_brightness_range(caps, &min, &max)) {
 		if (power_supply_is_system_supplied() > 0)
-			props.brightness = (max - min) * DIV_ROUND_CLOSEST(caps->ac_level, 100);
+			props.brightness = DIV_ROUND_CLOSEST((max - min) * caps->ac_level, 100);
 		else
-			props.brightness = (max - min) * DIV_ROUND_CLOSEST(caps->dc_level, 100);
+			props.brightness = DIV_ROUND_CLOSEST((max - min) * caps->dc_level, 100);
 		/* min is zero, so max needs to be adjusted */
 		props.max_brightness = max - min;
 		drm_dbg(drm, "Backlight caps: min: %d, max: %d, ac %d, dc %d\n", min, max,
-- 
2.50.1

-- 
Lauri Tirkkonen | lotheac @ IRCnet

