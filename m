Return-Path: <linux-kernel+bounces-747570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E712B13556
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FBD2178E16
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 07:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39E1222568;
	Mon, 28 Jul 2025 07:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rEwDnFgx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5370E21B9D2
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 07:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753686453; cv=none; b=ubcQ8o2u31Trxxpn6O61jI+knc2HoBZ36FpwSGQes5Lnq5C2SQLWGwjH/rX7sY/ueIYWFJt9CWrcZsD0nfFL3HR8D/KnYAz8vHEptfPs6WgyzrodwI+/BPq3ABy+GUJZAKEtMb+GeUMiXQ66kpe/+IZ6JyD0EkYDjIGo4fct8Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753686453; c=relaxed/simple;
	bh=f+s/bpIbY4gzizGXmBm3AznK50+1fyDPQGHp/04YzZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g8UOiSIBmNZ7iaqLz5N7/XNI/QQjSy+RoShUA1La7zzUOjKhDa2HpluNBaeT6VlOSP62J51VPzorZSYrAwoKxTSgp4dsEE2JQ5ZBhOpOQRmHucb0i3cX/yVRGwd3C5fMyrv9YtdK4YLgEDYw6X2U0vuqQrvvdY+TTDmZJQGJDIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rEwDnFgx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFFBAC4CEE7;
	Mon, 28 Jul 2025 07:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753686452;
	bh=f+s/bpIbY4gzizGXmBm3AznK50+1fyDPQGHp/04YzZQ=;
	h=From:To:Cc:Subject:Date:From;
	b=rEwDnFgxNRNm32zHTx7ktArVXLzKYXyBx2C5mQW+pZVj62QnraAWfRSNpMhxtoBEg
	 eDg2f+i7kadg/967juOBVN2GN0z+MpB9I96cczg8RLs2MPuOLgoAuV0d6IaTnYA6lh
	 D93ElnPiU3bwuMWord0C5pZSedIHBfdz5K2gs5dib1k6FCzxprH50bp7C27CtbfARS
	 w334BK5poYhcOkXE4ce7viW/u1FFOfgkex7kva3XgAyfztzzgQMNh7nNbKeADkhUIU
	 aqAxArRDnVXyzwyqOCRVzaY8W4U2l0+DpRlhKbIGZv2YyUqj2MgZsBiioirnzTS9+8
	 CwFLAbaww/YHQ==
From: Michael Walle <mwalle@kernel.org>
To: Srinivas Kandagatla <srini@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH] nvmem: layouts: fix automatic module loading
Date: Mon, 28 Jul 2025 09:07:26 +0200
Message-Id: <20250728070726.292579-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To support loading of a layout module automatically the MODALIAS
variable in the uevent is needed. Add it.

Fixes: fc29fd821d9a ("nvmem: core: Rework layouts to become regular devices")
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
I'm still not sure if the sysfs modalias file is required or not. It
seems to work without it. I could't find any documentation about it.
---
 drivers/nvmem/layouts.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/nvmem/layouts.c b/drivers/nvmem/layouts.c
index 65d39e19f6ec..f381ce1e84bd 100644
--- a/drivers/nvmem/layouts.c
+++ b/drivers/nvmem/layouts.c
@@ -45,11 +45,24 @@ static void nvmem_layout_bus_remove(struct device *dev)
 	return drv->remove(layout);
 }
 
+static int nvmem_layout_bus_uevent(const struct device *dev,
+				   struct kobj_uevent_env *env)
+{
+	int ret;
+
+	ret = of_device_uevent_modalias(dev, env);
+	if (ret != ENODEV)
+		return ret;
+
+	return 0;
+}
+
 static const struct bus_type nvmem_layout_bus_type = {
 	.name		= "nvmem-layout",
 	.match		= nvmem_layout_bus_match,
 	.probe		= nvmem_layout_bus_probe,
 	.remove		= nvmem_layout_bus_remove,
+	.uevent		= nvmem_layout_bus_uevent,
 };
 
 int __nvmem_layout_driver_register(struct nvmem_layout_driver *drv,
-- 
2.39.5


