Return-Path: <linux-kernel+bounces-728738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64688B02C64
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 20:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E27B33B44FB
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 18:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C0928D8DA;
	Sat, 12 Jul 2025 18:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t9ZzFPbR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D582128CF5C
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 18:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752344383; cv=none; b=XvvHCX4lxB9mmp1LwpfYQox+auR6JHkiFE09/mop/yud5EYFP+hiasin14daHJTb16mfOjOPV5/47TZ1nmDpyxXhFQ+MHkO3AUaA9uRv8p/UOB6G3/hSJfduw6sWIiFHXSjcWGfTv1ZCDQStgc8tLba6Aw73ywtXbTjwq7DkMx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752344383; c=relaxed/simple;
	bh=PA3Te3h3oJGm9mSeNYhYzpLTwOa/R9HfF1v0vT5Itko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MqSjG0Nh+fru009FO1Z5xpLV8NZMCbtyAHBOxQWSuSWASz22ZH1RvaONBhhyE1il0SRyA2zS078OuqB4rjhYnq0n/FSKQ6clk+TTVeX0iSEEKRfGOasfS6SIjvbGSOQXDC1154W5eKFAY5B34/AJxfJLcEKLuSIFVFHJVtzpQB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t9ZzFPbR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E4EAC4CEF1;
	Sat, 12 Jul 2025 18:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752344383;
	bh=PA3Te3h3oJGm9mSeNYhYzpLTwOa/R9HfF1v0vT5Itko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t9ZzFPbRp7HyYF1PIhwWTmvK5Pn4eW6kp+Nu1/UedaolFKYyeA522a/e0zS8JPHhG
	 jdEHMdrtkdy/wv0zQe5eYeiCioUBUPTTLQcn0dfAs68UdJCQcpVNnlBghnhG0d/Ksw
	 fyhZ7jv0M9hUao98lLWOwWisicMNMDZo/I+rqBgkX+33Uxs+01avAObnsZh2ZWVt0e
	 KVP/77+umytUJsaJqIcQpQymIkF1z0RIZs0gmCfx5iuEQSxITcY4kHyLjy+Evx9Vf6
	 Ig92rNgGnvaRcEHxmIXqeC0n5WlVgjWfjbe0MdRFA2d4v2Ob7qP/oOSZCYQ9AoaiZ2
	 7XbEXTsEX7tBQ==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 3/8] nvmem: core: Fix typos in comments and MODULE_AUTHOR strings
Date: Sat, 12 Jul 2025 19:18:59 +0100
Message-ID: <20250712181905.6738-4-srini@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250712181905.6738-1-srini@kernel.org>
References: <20250712181905.6738-1-srini@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alok Tiwari <alok.a.tiwari@oracle.com>

This patch fixes minor typo issues for nvmem-core.c:
 Corrects "form" to "from" in multiple function descriptions.
 Fixes missing closing angle brackets in MODULE_AUTHOR entries.

These changes improve readability and formatting consistency.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
---
 drivers/nvmem/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index fd2a9698d1c9..880572ba515a 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1263,7 +1263,7 @@ void nvmem_device_put(struct nvmem_device *nvmem)
 EXPORT_SYMBOL_GPL(nvmem_device_put);
 
 /**
- * devm_nvmem_device_get() - Get nvmem device of device form a given id
+ * devm_nvmem_device_get() - Get nvmem device of device from a given id
  *
  * @dev: Device that requests the nvmem device.
  * @id: name id for the requested nvmem device.
@@ -1491,7 +1491,7 @@ EXPORT_SYMBOL_GPL(of_nvmem_cell_get);
 #endif
 
 /**
- * nvmem_cell_get() - Get nvmem cell of device form a given cell name
+ * nvmem_cell_get() - Get nvmem cell of device from a given cell name
  *
  * @dev: Device that requests the nvmem cell.
  * @id: nvmem cell name to get (this corresponds with the name from the
@@ -1526,7 +1526,7 @@ static void devm_nvmem_cell_release(struct device *dev, void *res)
 }
 
 /**
- * devm_nvmem_cell_get() - Get nvmem cell of device form a given id
+ * devm_nvmem_cell_get() - Get nvmem cell of device from a given id
  *
  * @dev: Device that requests the nvmem cell.
  * @id: nvmem cell name id to get.
@@ -2194,6 +2194,6 @@ static void __exit nvmem_exit(void)
 subsys_initcall(nvmem_init);
 module_exit(nvmem_exit);
 
-MODULE_AUTHOR("Srinivas Kandagatla <srinivas.kandagatla@linaro.org");
-MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com");
+MODULE_AUTHOR("Srinivas Kandagatla <srinivas.kandagatla@linaro.org>");
+MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com>");
 MODULE_DESCRIPTION("nvmem Driver Core");
-- 
2.43.0


