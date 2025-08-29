Return-Path: <linux-kernel+bounces-791432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CED78B3B6B6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 11:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BE61A05545
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 09:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBA22EA483;
	Fri, 29 Aug 2025 09:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBN6Le+Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2252F363F
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 09:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756458333; cv=none; b=A926uVY/BH2m9ImbTJe8krc2PS4y1V8tuJIJnYu3ozXJGzIGSH2GJi9jzgAorPIcuGxeSNqdqW+XK7mG4Rp+Pmxjg+qntJasDZPEMRIrjBQ92b6H4ats0Eeh9Q/UHUc1xnc4s0p/zf3baAKdxCQUldHotpOoUzuk2ve5Rv9DgOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756458333; c=relaxed/simple;
	bh=b+WF2J+qrsGcj8cAU4xgyNrWdpj0Vz5yotbWDF7MJQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ujml6itP029YwR2yQoJN05hVxBBEuJxUHUVOF73o5apokgfncInyYrSQcvs2xGIAs7AetDixGW37mk8QTVhSfNQ89/fg5K8SiNgpSFhT3tz2fDZzCWbd1fC1r4fRL6zmCl1CdNs/5+RaRocyEuwq+SO03wwGNMHNJa44l2dVaeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBN6Le+Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E453C4CEF0;
	Fri, 29 Aug 2025 09:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756458333;
	bh=b+WF2J+qrsGcj8cAU4xgyNrWdpj0Vz5yotbWDF7MJQg=;
	h=From:To:Cc:Subject:Date:From;
	b=fBN6Le+Yb27NYeFRI19Y7gZGNyEtfoOuSZzaNR2cmjGTnaKutu/HJD8nCm6/GsVUa
	 rR9O3eUga4N7eRJfjlBsLuCtqQ5MPN6bj/ITh73AWYxeK4yWWJR49rN6uERc2APZ9q
	 3dfWYSY77GOtTqsw/+vR2DftiEpoNrAXzAZbtwtKOyCcFtbbbLag7k94imaopEsLkw
	 wIcc/EBMeC2wL/F+XH9Ykp7KC0qknZ4Ax3Od18tnE026uz5++x46UJ2s00DmulsTCh
	 5N3xLbdo6D76GPqs/MWUlH6FdoO8no2n4FeIA7A2apktDSKw/Sq91EKztrmZW6Xr9q
	 BU7wZddFlmYSw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1urv2x-000000005WD-04un;
	Fri, 29 Aug 2025 11:05:23 +0200
From: Johan Hovold <johan@kernel.org>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ma Ke <make24@iscas.ac.cn>,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/2] drm/mediatek: fix potential OF node use-after-free
Date: Fri, 29 Aug 2025 11:03:43 +0200
Message-ID: <20250829090345.21075-1-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A recent change (included in the drm pull request for 6.17-rc4) fixed a
device reference leak but also introduced a potential OF node
use-after-free.

This series fixes the new OF node reference imbalance and drops the
unnecessary gotos introduced by the broken fix, effectively reverting
that change in favour of the minimal fix I had previously posted here:

	https://lore.kernel.org/lkml/20250722092722.425-1-johan@kernel.org/

These should go into 6.17 which (soon) has the broken fix, which was
also marked for stable backport.

Johan


Johan Hovold (2):
  drm/mediatek: fix potential OF node use-after-free
  drm/mediatek: clean up driver data initialisation

 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

-- 
2.49.1


