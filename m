Return-Path: <linux-kernel+bounces-739007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB1FB0C087
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 11:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 841A0167E36
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 09:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F99728DB4C;
	Mon, 21 Jul 2025 09:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grimler.se header.i=@grimler.se header.b="iTk7bZKH"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D4528D8E1
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 09:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753091037; cv=none; b=L0xRKtRHdVt2B/02A9DSnh16RpvzkErVDbtDGEQNpkk22J3yJWSX9frc3NewghG4AqpSBkhSC46l3F8ZP+7xX+p5QNj7ZhmGjxbhBq161ve0HSQWamUmdAMHGg9mhgiS8NqJf0/iIVtwXg2/NXd7ABszrnVjs0AkfEG4EX462+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753091037; c=relaxed/simple;
	bh=Y69S0QjDeCf4mUz6joj+vvgruIKvaIp7+afSLDu1cjM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CoSHuY/5J7SltNT6St6ETTrebfuklT9QU6qtVKpMcUoeCGos4qiwNtDkUHWpZ6K7MHMx1Tto6tKJ1iXg0nM/4C5I+zqOxufwhGwv1hiAb0zRgAs6FXJbkZEzV5WXLQpmTGQHmf5WQa1KlqZA0RVFerpuTy/qsooWZmLPN0d5HxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=grimler.se; spf=pass smtp.mailfrom=grimler.se; dkim=pass (1024-bit key) header.d=grimler.se header.i=@grimler.se header.b=iTk7bZKH; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=grimler.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grimler.se
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
	t=1753091022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r80v8covK6AhEksxolDOt41b6/srvYj410fMrmanbjI=;
	b=iTk7bZKH1RqvRKEKjzLK44hT62aCqcRQkLoXllPVY74JazzsjOtexdLy6dbp+kyZ0UGr+B
	fp8zq8re2bM5lKeFxmUzfi5+SGlm9BJU+VMOMJzMiuLA+Wgero9u0zq5J6QlcElMK64NWk
	85ySkYsYL3wu4yDqq+sS8f7o/q+3dNA=
From: Henrik Grimler <henrik@grimler.se>
Subject: [PATCH 0/3] drm/bridge: sii9234: use extcon to detect cable
 attachment
Date: Mon, 21 Jul 2025 11:43:16 +0200
Message-Id: <20250721-exynos4-sii9234-driver-v1-0-2e47ed02f677@grimler.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALQLfmgC/x3MQQqDQAxA0atI1g004wxar1JcqEltNqMkIBaZu
 3dw+Rb/X+BiKg5Dc4HJoa5brqBHA8t3yqugcjWEZ2gpUI9y/vLmEV31FdqIbHqIIffUcZwTESe
 o8W7y0fMev8dS/nKG4+ZoAAAA
X-Change-ID: 20231218-exynos4-sii9234-driver-d817d4b511d5
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maciej Purski <m.purski@samsung.com>
Cc: dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, replicant@osuosl.org, 
 linux-kernel@vger.kernel.org, Henrik Grimler <henrik@grimler.se>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1298; i=henrik@grimler.se;
 h=from:subject:message-id; bh=Y69S0QjDeCf4mUz6joj+vvgruIKvaIp7+afSLDu1cjM=;
 b=owEBbQGS/pANAwAKAbAHbkkLcWFrAcsmYgBofgvCGCSAYlLZncGWN4N0PuUhlO7sEX2dkJSTz
 tGeXf4KqoqJATMEAAEKAB0WIQQsfymul4kfZBmp4s2wB25JC3FhawUCaH4LwgAKCRCwB25JC3Fh
 a6IYB/9C50diuxKr+lHMuKv+h8Ixx/p46MBRIugrQLb4A9+6smjMOi7bbDGAzz5yO9mCXnqrxuJ
 w+wmlTgrq0sfOOOV0Y3b9E+1xWMVPS9AsWAB0LsJIcLFKWcyDS3dkXmrAaCD9V+fwqFyIgJJ8wB
 HZygmCMK3/WzfSnRxbpxStz3khP4DjbN7ICEmEIWYET+gG1bKNAKkC4lZOlaChJ5yTaoKaJUKdE
 Y9aOHkC+qdxrOr9WLhFUHUm3DjwgUQl2Nnlk+boKy0goqF8+da1sgUu4DfI2DsGit1c52d5cvz8
 eAnHG84RDKloiSxDLCv7vvpRTxoxGRTF2UnFI6fQIZRJwlk4
X-Developer-Key: i=henrik@grimler.se; a=openpgp;
 fpr=2C7F29AE97891F6419A9E2CDB0076E490B71616B
X-Migadu-Flow: FLOW_OUT

Hi,

This series fixes so HDMI through the sii9234 MHL chip works when
cable is hotplugged, by making the MHL chip use extcon cable detection
functions. Patch 3, that actually implements the extcon parts, is heavily
inspired by commit 688838442147 ("drm/bridge/sii8620: use micro-USB
cable detection logic to detect MHL") by Maciej Purski.

Before these changes, HDMI only worked if cable was plugged in before
booting. If no cable was connected, then wlr-randr still showed HDMI
as connected, with 0x0 px, which confused at least some UIs (phosh)
and caused problems:
https://gitlab.gnome.org/World/Phosh/phosh/-/issues/828

Tested on exynos4412-i9305.

Best regards,
Henrik Grimler

Signed-off-by: Henrik Grimler <henrik@grimler.se>
---
Henrik Grimler (3):
      drm/bridge: sii9234: fix some typos in comments and messages
      drm/bridge: sii9234: use dev_err_probe where applicable
      drm/bridge: sii9234: use extcon cable detection logic to detect MHL

 drivers/gpu/drm/bridge/sii9234.c | 121 ++++++++++++++++++++++++++++++++-------
 1 file changed, 100 insertions(+), 21 deletions(-)
---
base-commit: ca2a6abdaee43808034cdb218428d2ed85fd3db8
change-id: 20231218-exynos4-sii9234-driver-d817d4b511d5

Best regards,
-- 
Henrik Grimler <henrik@grimler.se>


