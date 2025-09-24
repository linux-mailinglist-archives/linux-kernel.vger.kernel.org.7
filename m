Return-Path: <linux-kernel+bounces-830232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C910B99203
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C77301657F6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C2D2D7DC6;
	Wed, 24 Sep 2025 09:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bogVNTk/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8728285CBC;
	Wed, 24 Sep 2025 09:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758706101; cv=none; b=jhb+k1jk17yqohyyomiNxzGNsEbLo8B8BQg0gZcevVUkbosiQChaCgB/qRYAwYi9B+bWtVFSPYm93OPnojXhLj85DUsfDaDl12/2Yyl9tP/SESnfySxdjoN9YEIhcJHfadvybnZuVTDxG1nwXmzhfzfpO5GTJLi6eYoN04byBa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758706101; c=relaxed/simple;
	bh=47f3TxVSb5XBlK+7j3tmWOP9WWwsUxqEELtzzZHVOso=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RJzeQE0Epnv7vEXlu5HcBEzTcPkjSJuoIbuE18+rYxq6YKGbv9G8uf/Z0UVsHkIPLYd0EGjN88SlroiDAsOV9b7Ox0bVUGpaRHbpvN4bkwQRsJWlzo0mjo/IpxWQECk7euMquhe4NtLUd8mv4pcX45sa86NsyKLTQ6lArLHb+s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bogVNTk/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581DAC2BCB2;
	Wed, 24 Sep 2025 09:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758706101;
	bh=47f3TxVSb5XBlK+7j3tmWOP9WWwsUxqEELtzzZHVOso=;
	h=From:To:Cc:Subject:Date:From;
	b=bogVNTk/cEiqP2mS+0+T+MLtpf4sOtySUsCQGN38IEf1lojp+iwQxRwHgRo0FJZCp
	 jVLOiFJ9wtUsXxHe8rstJ3ilLZ4J05ywrxFIIXW2ODs/vGELtp3vP/SOgP2TqQt73R
	 Wimu93Xj30m9pYrJU6guLk5DNSn6uQDIu73zXBQrMAMmo6dpyfL5gh69f0nQpiOSKU
	 SiRxWv9Jhz172m0vXKsAccJ6PX2+KbhGzI2K1cBmHTBWpOnHLqaygErEAk13MzqJO2
	 72tJVtrtK9lpTsstnaNk5i3YGky2PJyYG2k8S+S3u/VU/+dYwXUQMI8zE85+mlPz4X
	 AHe2bnxt9MTBQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v1LnK-000000006p0-2BWm;
	Wed, 24 Sep 2025 11:28:15 +0200
From: Johan Hovold <johan@kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	dri-devel@lists.freedesktop.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/4] drm/imx: drop unused module aliases
Date: Wed, 24 Sep 2025 11:26:39 +0200
Message-ID: <20250924092643.26113-1-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When fixing up a device reference leak in the tve drivers I noticed it
had an unused platform alias. This series drops unused aliases from the
imx drm drivers.

Johan


Johan Hovold (4):
  drm/imx/dw-hdmi: drop unused module alias
  drm/imx/ldb: drop unused module alias
  drm/imx/tve: drop unused module alias
  drm/imx/parallel-display: drop unused module alias

 drivers/gpu/drm/imx/ipuv3/dw_hdmi-imx.c      | 1 -
 drivers/gpu/drm/imx/ipuv3/imx-ldb.c          | 1 -
 drivers/gpu/drm/imx/ipuv3/imx-tve.c          | 1 -
 drivers/gpu/drm/imx/ipuv3/parallel-display.c | 1 -
 4 files changed, 4 deletions(-)

-- 
2.49.1


