Return-Path: <linux-kernel+bounces-778429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A09ECB2E590
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 21:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C6E47B0BC6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 19:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0316928369D;
	Wed, 20 Aug 2025 19:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AH/sifnl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528EF280A2C;
	Wed, 20 Aug 2025 19:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755718151; cv=none; b=QMLsf5qjdHtcKl2twcAZ//qwQcqpM4vuBlhu0QRhxq8Hl9DgdMyRJAvc0RoT0hQ+ZzAVjaJzOEotxsuvNcV5scugzvW4V/GMo9nHgkQ5q52tpcJ3DmOhXINE7yPNlXu6+3Ep2+uL/v29x7LCsMuI1czifwifo7E7kul10j19Fuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755718151; c=relaxed/simple;
	bh=wut8/fLZnzNAdA+Gi3yrbs+OMoYmlgDOvwOEQ7cYvts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q30m3PATFqijhNbAFzv7F3Ilvycc9bQ4c0Lctty08k7dB1QQr7xqI8V+c6156GGZ7D4uu9gn5TcU1+Z/tpVFTVpmzaCaZlbEdvNhr4HAfhsGU8ybUG25PwVW4FO83AkKG/yt+p0Yd2fPPnFjMBPVwRWncVm+pM06mdbxkWPGdCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AH/sifnl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C7EC4CEE7;
	Wed, 20 Aug 2025 19:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755718149;
	bh=wut8/fLZnzNAdA+Gi3yrbs+OMoYmlgDOvwOEQ7cYvts=;
	h=From:To:Cc:Subject:Date:From;
	b=AH/sifnlg4XPhK+BxHKv9S3XD3dXus89E2wjZTfjeqUbz2wV9j4CjgW1T19QGeQqX
	 nvsSjp6DkkDR7fizQEryyfgJyTrMGbXNH4f0C1diPvpkMbINMG7i2jqFVyfKTecSpa
	 T1AAckJ+vBgrndWLSGeCVBa81O41a0NihV6d48lSO+eLBMlMkc3w+/mMrL3PT+FlRc
	 jnoW8f7pDe2sd1SeV0c+WpapzPJLAwWl8g5IuW/Q5sNknMDGk99pdFZII4dHue8FcO
	 EMSxsHKnSsFU4KL5yzkxexcAocE2QBNnWSutn0FS/PYcAessl9vUj6ghvNiWb1hlmY
	 Af7+cus9XJ+QQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Patrice CHOTARD <patrice.chotard@foss.st.com>,
	Saravana Kannan <saravanak@google.com>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Daniel Baluta <daniel.baluta@nxp.com>
Cc: Iuliana Prodan <iuliana.prodan@nxp.com>,
	Daniel Baluta <daniel.baluta@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] of: reserved_mem: Add missing IORESOURCE_MEM flag on resources
Date: Wed, 20 Aug 2025 14:28:04 -0500
Message-ID: <20250820192805.565568-1-robh@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit f4fcfdda2fd8 ('of: reserved_mem: Add functions to parse
"memory-region"') failed to set IORESOURCE_MEM flag on the resources.
The result is functions such as devm_ioremap_resource_wc() will fail.
Add the missing flag.

Fixes: f4fcfdda2fd8 ('of: reserved_mem: Add functions to parse "memory-region"')
Reported-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Reported-by: Daniel Baluta <daniel.baluta@gmail.com>
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/of/of_reserved_mem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 77016c0cc296..d3b7c4ae429c 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -771,6 +771,7 @@ int of_reserved_mem_region_to_resource(const struct device_node *np,
 		return -EINVAL;
 
 	resource_set_range(res, rmem->base, rmem->size);
+	res->flags = IORESOURCE_MEM;
 	res->name = rmem->name;
 	return 0;
 }
-- 
2.50.1


