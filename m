Return-Path: <linux-kernel+bounces-829226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB52B96917
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC354161833
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAC0267714;
	Tue, 23 Sep 2025 15:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B57zID4v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97FB2561AB
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 15:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758641173; cv=none; b=pFExMfNFLzyRcizCCjz78JsSBcrwmvStEsXfYv5YaFj0v8XRELNpJ/CVbIEMup8UN4IfHech6fVReWxGuQ5x1ZHW5lvYnCLgrf311dIfDUiJghpm1n1i9tWgmtS2IsNcIdYBWEs3InG91kPImM2WOocGybELcCK3vIiq6Cn1o9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758641173; c=relaxed/simple;
	bh=A7kQ6dm5aKh3HyJvuod+6ppwPxKHu8JboA2fiUwRno4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jJEYrOc4rr8T/5Zz9XbF6sQZqGoPTMqmS73jYzM2WjajgvEgImO/lO2C7B2dGkiNjPvB8knHbQ4IciGUYgwAsZW3/OLVr21aluJBULd84X46zXeDjrMP+7nG0TenxO8e+jumwE1v1MGNvshvGTpXv8Rvl9pi4IPwG7hwqYt2yYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B57zID4v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FE3C4CEF5;
	Tue, 23 Sep 2025 15:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758641172;
	bh=A7kQ6dm5aKh3HyJvuod+6ppwPxKHu8JboA2fiUwRno4=;
	h=From:To:Cc:Subject:Date:From;
	b=B57zID4v4TFh+gpUwpajXLQgpBXB1iu/d8v3NJAqo/1QvtRn3neNTJjSQmLiQvkso
	 7ySS6DQuUaUPfCvrlx0GubJmS65Xe+tAFXDMRbgwjGSZZAiEsrV3KaBu6L/euIm5GS
	 tZ+HxaIV0VHYO1T3CwYt74J9uTQifWoraZezeBV+OwlUYvOsTni3/BxbrSxOl6mg9C
	 89XNBtbyr4pBeS9Gtgdk/Uv2RyfT4PgSj4xtSpgH+Pk2LL0nMWKV+TszlJokEGtEtG
	 a2Y0OW8rgSD/2AZayiNDt1Zm+PGoODK95ceHq8VL/c3GP4Ku+qCWAwpkZiOVCOPvGT
	 6RXPpvh6nvK6A==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v14u6-000000004mm-0MeD;
	Tue, 23 Sep 2025 17:26:06 +0200
From: Johan Hovold <johan@kernel.org>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/5] drm/mediatek: fix probe resource leaks
Date: Tue, 23 Sep 2025 17:23:35 +0200
Message-ID: <20250923152340.18234-1-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes various probe resource leaks in the mediatek drm
drivers that were found through inspection.

Johan


Johan Hovold (5):
  drm/mediatek: fix probe resource leaks
  drm/mediatek: fix probe memory leak
  drm/mediatek: fix probe device leaks
  drm/mediatek: mtk_hdmi: fix probe device leaks
  drm/mediatek: ovl_adaptor: fix probe device leaks

 drivers/gpu/drm/mediatek/mtk_ddp_comp.c       | 33 ++++++++++++++++---
 drivers/gpu/drm/mediatek/mtk_ddp_comp.h       |  2 +-
 .../gpu/drm/mediatek/mtk_disp_ovl_adaptor.c   | 12 +++++++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        |  4 +--
 drivers/gpu/drm/mediatek/mtk_hdmi.c           | 15 +++++++++
 5 files changed, 58 insertions(+), 8 deletions(-)

-- 
2.49.1


