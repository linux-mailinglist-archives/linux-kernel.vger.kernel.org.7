Return-Path: <linux-kernel+bounces-767439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1074CB2543A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 22:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90F481C84607
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D47311C3D;
	Wed, 13 Aug 2025 20:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GoyJcAh/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E855230E843;
	Wed, 13 Aug 2025 20:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755115546; cv=none; b=VHFfLSosVHKa+feJYGH5Py1uNHu2AF0yl7nt/cKlciK+YTd6eu3vrH2gl5pNv+Rq2C6r8B1NXimJOyrlELn6hNOa2MgOXCF4fbUaxy7xzPWrqXucUa2I3xBZdGE5lzPv1v0BmzxG2KO7X8P79KYQgocB4zQhYcx6OmLgRrbHfmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755115546; c=relaxed/simple;
	bh=N0xi8nYgm663/xQ2wfrZjB2ENBpA9WDnFgva3oeVG5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AHbzqWtsa6DtvgxPvi1qHisGRq0X7cp094odwRkEQkxa99BHIDekEsAUf6yN+ukKp/gvZC8co/7/pCM+NWu21XuCd3oUGTbd/lZu0NRc01Xcm411r8rZMN/QYpoPdtu553twjbvzG7egk5FXNOldX6GyuFw6sGM7sNceaGgm8Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GoyJcAh/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E816C4CEEF;
	Wed, 13 Aug 2025 20:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755115545;
	bh=N0xi8nYgm663/xQ2wfrZjB2ENBpA9WDnFgva3oeVG5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GoyJcAh/ek2y48mu/TJ1Hus27wtTTpw77luWIJrVhT/AWfgP5dOJoiJgxT1T9fi9o
	 orKkdRCEtESM+RZI5sf+E1ISn3vbCnkrQuKFxt4Is+meGIDCk237sAMlcd1yZONqmd
	 i4ehkzNfQYlMaUoxOInYGdfMWDEDViDb7sQTYm3l8IeV2prvV3u0MJJqSZ7Y02ppEF
	 TCIbjJpBouUPdjEGULUaeewS1jMUhBvQbU4/Zu6GkArp+Rs6ZoVfkDeYZ6rh1+x4hX
	 5xEIFCI0+hGN3+kNXzaSAVVayGFHmKVA1T6Ip40LKvTQfs4HIQqESIrkVaB14flLsN
	 mP31zZWcvHZVQ==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 6/9] Documentation: Fix networking typos
Date: Wed, 13 Aug 2025 15:05:02 -0500
Message-ID: <20250813200526.290420-7-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250813200526.290420-1-helgaas@kernel.org>
References: <20250813200526.290420-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Fix typos.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/networking/can.rst                                | 2 +-
 .../device_drivers/ethernet/ti/am65_nuss_cpsw_switchdev.rst     | 2 +-
 .../networking/device_drivers/ethernet/ti/cpsw_switchdev.rst    | 2 +-
 Documentation/networking/rds.rst                                | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
index bc1b585355f7..680dc7451493 100644
--- a/Documentation/networking/can.rst
+++ b/Documentation/networking/can.rst
@@ -539,7 +539,7 @@ CAN Filter Usage Optimisation
 The CAN filters are processed in per-device filter lists at CAN frame
 reception time. To reduce the number of checks that need to be performed
 while walking through the filter lists the CAN core provides an optimized
-filter handling when the filter subscription focusses on a single CAN ID.
+filter handling when the filter subscription focuses on a single CAN ID.
 
 For the possible 2048 SFF CAN identifiers the identifier is used as an index
 to access the corresponding subscription list without any further checks.
diff --git a/Documentation/networking/device_drivers/ethernet/ti/am65_nuss_cpsw_switchdev.rst b/Documentation/networking/device_drivers/ethernet/ti/am65_nuss_cpsw_switchdev.rst
index 25fd9aa284e2..f0424597aac1 100644
--- a/Documentation/networking/device_drivers/ethernet/ti/am65_nuss_cpsw_switchdev.rst
+++ b/Documentation/networking/device_drivers/ethernet/ti/am65_nuss_cpsw_switchdev.rst
@@ -42,7 +42,7 @@ Port's netdev devices have to be in UP before joining to the bridge to avoid
 overwriting of bridge configuration as CPSW switch driver completely reloads its
 configuration when first port changes its state to UP.
 
-When the both interfaces joined the bridge - CPSW switch driver will enable
+When both interfaces have joined the bridge - CPSW switch driver will enable
 marking packets with offload_fwd_mark flag.
 
 All configuration is implemented via switchdev API.
diff --git a/Documentation/networking/device_drivers/ethernet/ti/cpsw_switchdev.rst b/Documentation/networking/device_drivers/ethernet/ti/cpsw_switchdev.rst
index 464dce938ed1..2f3c43a32bfc 100644
--- a/Documentation/networking/device_drivers/ethernet/ti/cpsw_switchdev.rst
+++ b/Documentation/networking/device_drivers/ethernet/ti/cpsw_switchdev.rst
@@ -92,7 +92,7 @@ Port's netdev devices have to be in UP before joining to the bridge to avoid
 overwriting of bridge configuration as CPSW switch driver copletly reloads its
 configuration when first Port changes its state to UP.
 
-When the both interfaces joined the bridge - CPSW switch driver will enable
+When both interfaces have joined the bridge - CPSW switch driver will enable
 marking packets with offload_fwd_mark flag unless "ale_bypass=0"
 
 All configuration is implemented via switchdev API.
diff --git a/Documentation/networking/rds.rst b/Documentation/networking/rds.rst
index 41b0a6182fe4..4261146e9d92 100644
--- a/Documentation/networking/rds.rst
+++ b/Documentation/networking/rds.rst
@@ -339,7 +339,7 @@ The send path
   rds_sendmsg()
     - struct rds_message built from incoming data
     - CMSGs parsed (e.g. RDMA ops)
-    - transport connection alloced and connected if not already
+    - transport connection allocated and connected if not already
     - rds_message placed on send queue
     - send worker awoken
 
-- 
2.43.0


