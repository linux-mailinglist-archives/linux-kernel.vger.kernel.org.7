Return-Path: <linux-kernel+bounces-792444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EB8B3C3F8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 22:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51E421CC3498
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 20:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165D23469EC;
	Fri, 29 Aug 2025 20:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VnVNRN6J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7228919D07A
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 20:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756501164; cv=none; b=fUpgqHwN4atiGGRgFaWoLU4gG2mDOkgKeuTtVv+fUhE3WfouHmNB49jm73+gZACwywo1yY70x90Qij13io3DIvdMpRd2X6G+o5uXFei+7ALnNTBlSsQtdmRBY09nHM/IlEPiTZSCZD8MgGoaoLMCkLm8Tcp8gjS5otWSYB+FUo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756501164; c=relaxed/simple;
	bh=4yAB5+iH1wu7vzT5iuigIaMJ9iCe5nytQhQW3O1t6CI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V1A4swckLhoUwrsXK8JDU3q33z3h9z5sCxQSHmPlnviOHF8UPgZ5LAprxdrCObXyfmMWpHloxowFRtodyyDO4f+CbORKRU/D5MfeTwCmeFc+tafiAKxcYOQymeiicxjUsaHXVCH4ee8DEJgZl6rR/U/8rqLBSq5G4C+MXxXmeB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VnVNRN6J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ADC2C4CEF0;
	Fri, 29 Aug 2025 20:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756501163;
	bh=4yAB5+iH1wu7vzT5iuigIaMJ9iCe5nytQhQW3O1t6CI=;
	h=From:To:Cc:Subject:Date:From;
	b=VnVNRN6JmmAk7rtiH1vI+frIZu0L650PrYPra6onVZ+YZFSSNDFTthJXBLqMRugL1
	 OX6wz8eqf2txs3o0moFepA4bQ2MX4Lwk4T690EqAW6KdpqM/r4mJW9FigDHLR+z2RP
	 0RbLfg+wia1qCoy/2DdrlFQrof2Vka/yCxslKH5L2tvn2bgooplauDXq6qjcI+d6ZJ
	 awvl2wDyCfCHLoIxcOXEWibrjaIXABiO7LfLSTw5CIyV4RADu9PRvIaoWrMO/RYrr9
	 fDfBaLvtlx6OoW09Yr/Lkc+4erthivuWkK9NzTrqE21hZw2RZa7eSsr6NVXSGn/kZr
	 zTRz8f7auLYCw==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Saravana Kannan <saravanak@google.com>
Subject: [PATCH] driver core: get_dev_from_fwnode(): document potential race
Date: Fri, 29 Aug 2025 22:58:57 +0200
Message-ID: <20250829205911.33142-1-dakr@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 9a4681a485ee ("driver core: Export get_dev_from_fwnode()") made
get_dev_from_fwnode() publicly available, but didn't document the
guarantees a caller must uphold:

get_dev_from_fwnode() obtains a reference count from the device pointer
stored in a struct fwnode_handle. While having its own reference count,
struct fwnode_handle does not keep a reference count of the device it
has a pointer to.

Consequently, a caller must guarantee that it is impossible that the
last device reference is dropped and the device is released concurrently
while calling get_dev_from_fwnode(), otherwise this is a potential UAF
and hence a bug.

Thus, document this potential race condition for get_dev_from_fwnode().

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Saravana Kannan <saravanak@google.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
Another note on this:

It seems that (outside of drivers/base/core.c) this is only used by

  - of_genpd_add_provider_simple()
  - of_genpd_add_provider_onecell()

At a first glance, I can't see any caller of those two functions that is not
eventually coming from probe(), i.e. a context where we already have a valid
device pointer.

So, it seems to me that it would have been the much safer choice to make the two
functions above take a struct device * as argument directly, instead of making
get_dev_from_fwnode() publicly available, just to recover a device reference
count from a struct fwnode_handle.
---
 drivers/base/core.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index d22d6b23e758..cd806be435cd 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -5278,6 +5278,25 @@ void device_set_node(struct device *dev, struct fwnode_handle *fwnode)
 }
 EXPORT_SYMBOL_GPL(device_set_node);
 
+/**
+ * get_dev_from_fwnode - Obtain a reference count of the struct device the
+ * struct fwnode_handle is associated with.
+ * @fwnode: The pointer to the struct fwnode_handle to obtain the struct device
+ * reference count of.
+ *
+ * This function obtains a reference count of the device the device pointer
+ * embedded in the struct fwnode_handle points to.
+ *
+ * Note that the struct device pointer embedded in struct fwnode_handle does
+ * *not* have a reference count of the struct device itself.
+ *
+ * Hence, it is a UAF (and thus a bug) to call this function if the caller can't
+ * guarantee that the last reference count of the corresponding struct device is
+ * not dropped concurrently.
+ *
+ * This is possible since struct fwnode_handle has its own reference count and
+ * hence can out-live the struct device it is associated with.
+ */
 struct device *get_dev_from_fwnode(struct fwnode_handle *fwnode)
 {
 	return get_device((fwnode)->dev);

base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
-- 
2.51.0


