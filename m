Return-Path: <linux-kernel+bounces-724012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85212AFED89
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D65427A6DBB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4F32E6D3D;
	Wed,  9 Jul 2025 15:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuhKeeoX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FE822331C;
	Wed,  9 Jul 2025 15:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752074308; cv=none; b=n3RML72CDp1GLcRIBPFuVMqmH/wHNzaMV0SMunR7yjNpc+FhAd96PzkauuLg65P03yqk9lQd1b64QvI5xOooda1pR7JTduL/0HVSc3bZllnuqEft24c7st1yK0H3IHkUhnwEd/DAzOLw1O7eBpuqfeewa1o/Ny2M6gzie+B6tes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752074308; c=relaxed/simple;
	bh=gGuuInKGMQue51Ki2BloF6R/YiXNCDgwOJsaz7pPPds=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aScuMQFvAQrthxmW6IWiIpusxxVFhqvx/cq0K7Dn72J3t9GPYvkuA0DWbepzbE4UXvXVUgqj6XthKUKaSN2VrCGIGsrIWMQWwkc7EzlzP2zpBB39vxnmk/u00QegOK7yTf9FHW2y/jv3clyP/SYj6IjJOnBBWXtST1YZjN32nrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuhKeeoX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD484C4CEEF;
	Wed,  9 Jul 2025 15:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752074308;
	bh=gGuuInKGMQue51Ki2BloF6R/YiXNCDgwOJsaz7pPPds=;
	h=From:To:Cc:Subject:Date:From;
	b=cuhKeeoXYuIhlRH9+VZSgRvybnw8efFLBJYPRtQrYVAa5r5MNNSMowS84DVDfq61I
	 u/BajLSOW+qbTQwcVIMPsROEY9L9T3QRzEXEbcAWKmDt/YXv3OraxHAW6zvQYu2hCq
	 WORC5iLknlj/dPnwsB8aPvHthOVz6TXIJcad893hkYqzXvGg8OkfQLZwG59B+FACOR
	 eP2zwgPL/dTyLC5NmXRTQzTTdn2ZR7kzvh5D1VpSG9n7rAMv3bK6maCA2V5TCP1YSE
	 SHw2tqTK+iUhiLSf6ELSnoedZ8K7oIBKWXjCXGb/6wa2xRrUTM7ao/01irxY9N3hFM
	 aLOzqVmrVifBg==
From: Arnd Bergmann <arnd@kernel.org>
To: "David E. Box" <david.e.box@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86/intel/pmt: fix format string warnings
Date: Wed,  9 Jul 2025 17:18:17 +0200
Message-Id: <20250709151822.1268757-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The %ld format string is for 'long'. size_t is the same length
but requires the use of '%zd' to avoid this portability warning:

drivers/platform/x86/intel/pmt/discovery.c: In function 'pmt_feature_get_feature_table':
drivers/platform/x86/intel/pmt/discovery.c:427:35: error: format '%ld' expects argument of type 'long int', but argument 2 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
  427 |         if (WARN(size > res_size, "Bad table size %ld > %pa", size, &res_size))

Similarly, passing a string pointer as a format string means
that gcc is unable and warns when -Wformat-security is enabled:

drivers/platform/x86/intel/pmt/discovery.c: In function 'pmt_features_discovery':
drivers/platform/x86/intel/pmt/discovery.c:505:36: error: format not a string literal and no format arguments [-Werror=format-security]
  505 |                                    pmt_feature_names[feature->id]);
      |                                    ^~~~~~~~~~~~~~~~~

Fix both trivial format string warnings in the obvious way.

Fixes: d9a078809356 ("platform/x86/intel/pmt: Add PMT Discovery driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/platform/x86/intel/pmt/discovery.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/pmt/discovery.c b/drivers/platform/x86/intel/pmt/discovery.c
index e72d43b675b4..763ed2a51523 100644
--- a/drivers/platform/x86/intel/pmt/discovery.c
+++ b/drivers/platform/x86/intel/pmt/discovery.c
@@ -424,7 +424,7 @@ pmt_feature_get_feature_table(struct pmt_features_priv *priv,
 	size = sizeof(*header) + FEAT_ATTR_SIZE(header->attr_size) +
 	       PMT_GUID_SIZE(header->num_guids);
 	res_size = resource_size(&res);
-	if (WARN(size > res_size, "Bad table size %ld > %pa", size, &res_size))
+	if (WARN(size > res_size, "Bad table size %zd > %pa", size, &res_size))
 		return -EINVAL;
 
 	/* Get the feature attributes, including capability fields */
@@ -502,7 +502,7 @@ static int pmt_features_discovery(struct pmt_features_priv *priv,
 	}
 
 	ret = kobject_init_and_add(&feature->kobj, ktype, &priv->dev->kobj,
-				   pmt_feature_names[feature->id]);
+				   "%s", pmt_feature_names[feature->id]);
 	if (ret)
 		return ret;
 
-- 
2.39.5


