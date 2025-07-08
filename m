Return-Path: <linux-kernel+bounces-721205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DB0AFC614
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C763B178F21
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8C02BEFE9;
	Tue,  8 Jul 2025 08:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhqvOMHJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCD0218845
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 08:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751964457; cv=none; b=WoCeAxZEBljVBOZ1BJWoeI+Sv3m/h27LThCWUyNA2tyVRbl7LJspRULEdCg+antXS0pDjTBe4lztEgjgMwqibWrxr+J8UjEfM0lbJoQ5KcwRCmqZyKgsqa1MwlKYd9Yd4RTr8KqnnVrC2FkzQRRhNXZjSk/9kq/unvYn/OC1/gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751964457; c=relaxed/simple;
	bh=LwYPdB6tpFEF7U/dDZX29kg2rE9voIzb637HHx+AfzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=romrII7r7L0R6AVZlHnpyIZxV7Ai80/Zcl2IPEjlmNxf5Suc/KEk9+NYfe/HCmIkAbzot1P6RfAR+IKwXgyzLPXWSCx3QCqkdp9Dn/aTtZ+EYCgzNGvGhGz4lo4cPwHjAG7AvLzDfxmpIrcDdly9v8yK70GsxZylyz5HYbrmOCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qhqvOMHJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B20AC4CEED;
	Tue,  8 Jul 2025 08:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751964457;
	bh=LwYPdB6tpFEF7U/dDZX29kg2rE9voIzb637HHx+AfzI=;
	h=From:To:Cc:Subject:Date:From;
	b=qhqvOMHJEq/GMJJE36iWFZF1FWAq2AhVJ5VX0L8KfNtm3ScdixzPoLvcyYoFE4qbK
	 d/6G/RlXITeS3ADfUGF5BS0YFbBj5SNcF+swbe/kMfbXqzzBaxXVFDBajSem6gk1S3
	 fxEWrOJIFxd4WDQn4f8w3uGNr5iljsXXktCjA1pH1fNblceM/E82ITZTsf3AmYuCK2
	 rslzh+Jf1sz9D6iH2kl2nnrhX+Tc2FEePujCT4sGD5jZIIwsS7YDWcZRdZfzCNJmLR
	 bwIK23GPKDCwIaHal/lueqZw9hzVXV88ipX6F51nMoE5LHSXIh9kZy3BWGE1nGket4
	 FqIEZABqa+ksw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uZ3z6-000000003wt-0HKc;
	Tue, 08 Jul 2025 10:47:28 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH] driver core: auxiliary bus: fix OF node leak
Date: Tue,  8 Jul 2025 10:46:54 +0200
Message-ID: <20250708084654.15145-1-johan@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the OF node reference taken when creating an auxiliary
device using auxiliary_device_create() when the device is later
released.

Fixes: eaa0d30216c1 ("driver core: auxiliary bus: add device creation helpers")
Cc: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/base/auxiliary.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
index dba7c8e13a53..6bdefebf3609 100644
--- a/drivers/base/auxiliary.c
+++ b/drivers/base/auxiliary.c
@@ -399,6 +399,7 @@ static void auxiliary_device_release(struct device *dev)
 {
 	struct auxiliary_device *auxdev = to_auxiliary_dev(dev);
 
+	of_node_put(dev->of_node);
 	kfree(auxdev);
 }
 
@@ -435,6 +436,7 @@ struct auxiliary_device *auxiliary_device_create(struct device *dev,
 
 	ret = auxiliary_device_init(auxdev);
 	if (ret) {
+		of_node_put(auxdev->dev.of_node);
 		kfree(auxdev);
 		return NULL;
 	}
-- 
2.49.0


