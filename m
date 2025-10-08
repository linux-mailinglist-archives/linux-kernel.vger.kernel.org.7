Return-Path: <linux-kernel+bounces-845394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C136BC4B7D
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 14:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B21883B6938
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 12:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114672F83AA;
	Wed,  8 Oct 2025 12:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bl4HFcOE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0F82F7AB0;
	Wed,  8 Oct 2025 12:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759925437; cv=none; b=ZyQc9Jku7Fkm+xaVc3WfG+bA4fy5BK1SeaalEfZcv3KYK5iBD9vhUf/hp3/1u293aZUXhN8/jtkUy2tOAMbDwgYrSBzsAAg/t+VX2wE3X4DSw2BcIl0LlyMEJX2wagdq3frpHksDkFb3BY8pc4IHvUG0a7XmrquoBSYuOCkxeFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759925437; c=relaxed/simple;
	bh=cHcn54MZlD9CmMA74ZkRflfKDvMUVrqscxyiMadNXCw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dmYYBfO0uFmlownbR8aDXPwZcz5/VAVNiG9PZfZWv0Gg6KhW1UbSYzpCLlcmX2My7pCofJPnz/Aaq9Wu8c1JTEiw7jn1hdsR92DeiZSeVrKFE+g1jEaLi9UlOwgaqcp1RYT03mCzp8bMPJS1ndHESmJjlZruaZ++b9NFn0FoqD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bl4HFcOE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6630CC4CEF4;
	Wed,  8 Oct 2025 12:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759925436;
	bh=cHcn54MZlD9CmMA74ZkRflfKDvMUVrqscxyiMadNXCw=;
	h=From:To:Cc:Subject:Date:From;
	b=bl4HFcOEZOkTbcUWtQlLMYgTcGlgpf4BQKM62qPEuZGJrgc4TDKddl0vVlifds9GA
	 hlY9he3JgQSq2DYZBfdIy2tPCTsXnU46us+GGopyApDvFalYTSuiLrQAmbsp75oUqr
	 BIsRnPN82YVA4pJScECn3g/eIZsO8uQB16OOIlV0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: rust-for-linux@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] Revert "USB: disable rust bindings from the build for now"
Date: Wed,  8 Oct 2025 14:10:28 +0200
Message-ID: <2025100827-divorcee-steadier-b40b@gregkh>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 65
X-Developer-Signature: v=1; a=openpgp-sha256; l=1946; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=cHcn54MZlD9CmMA74ZkRflfKDvMUVrqscxyiMadNXCw=; b=owGbwMvMwCRo6H6F97bub03G02pJDBnPQjZ7O2oannQoDuZS5WlbVbhiy9e4XcyHFzEs6vxUm 33xcMe3jlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZiI3laGWczfT28R1/N54fbD X0X7d6x45/49ZgwL5tSEieRmn2qZIyGu/SjguOuGuMwzAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

This reverts commit c584a1c7c8a192c13637bc51c7b63a9f15fe6474.

It brings the rust bindings for USB back into the build so that we can
work off of this for future kernel releases.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 rust/bindings/bindings_helper.h | 1 +
 rust/helpers/helpers.c          | 1 +
 rust/kernel/lib.rs              | 2 ++
 samples/rust/Kconfig            | 2 +-
 4 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 04b75d4d01c3..ee2264df562e 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -80,6 +80,7 @@
 #include <linux/slab.h>
 #include <linux/task_work.h>
 #include <linux/tracepoint.h>
+#include <linux/usb.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <linux/xarray.h>
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 551da6c9b506..16049d6e713f 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -56,6 +56,7 @@
 #include "task.c"
 #include "time.c"
 #include "uaccess.c"
+#include "usb.c"
 #include "vmalloc.c"
 #include "wait.c"
 #include "workqueue.c"
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 3dd7bebe7888..9cf4ca0ae7a1 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -138,6 +138,8 @@
 pub mod tracepoint;
 pub mod transmute;
 pub mod types;
+#[cfg(CONFIG_USB = "y")]
+pub mod usb;
 pub mod uaccess;
 pub mod workqueue;
 pub mod xarray;
diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index c376eb899b7a..c1cc787a9add 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -107,7 +107,7 @@ config SAMPLE_RUST_DRIVER_PLATFORM
 
 config SAMPLE_RUST_DRIVER_USB
 	tristate "USB Driver"
-	depends on USB = y && BROKEN
+	depends on USB = y
 	help
 	  This option builds the Rust USB driver sample.
 
-- 
2.51.0


