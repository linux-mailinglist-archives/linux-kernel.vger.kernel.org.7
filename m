Return-Path: <linux-kernel+bounces-790368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FDEB3A621
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A4F317A3F9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 16:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FF132A3C8;
	Thu, 28 Aug 2025 16:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c4pMTDT/"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3A0322533
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 16:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756398080; cv=none; b=IltbOOGlZ+JF0xtoktCEm+rxRB/xn33fjQAWsnxYktZCgA4dZBNzaPdEaLgMwCnxwe02Prb+rmf4s2DE5HIozPdMqk+NoZKcjXrL8qtmWwZhuXqDF5SIO9sXcfZvUMdUGdhr3CTCxn7ROwQCOG9CaNYnY6b8yzxDvhzp1i3lkMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756398080; c=relaxed/simple;
	bh=qaScglVdLkmBjdsY7s6rKxKcwdhmSMloq1688MUvmAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BgQNL7k7vYc6sjq+JlXgQTFl22CsnOAFWPxhni+bZxKwE7ESBI9zmFLdOokHzAfUN2Lg25/9hEIr12WeJvVbjaFzd/lM3f7tH60IFFSXpYOsccWq8TaFupJVVOzWNzjwi1IFbIrv0UqeZ9GBCQM+JL7sy/vT7TNWMq+1uQYrtek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c4pMTDT/; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756398074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=f70fYPGkkJTsgVx7HK1J427mMW4St4qFeIp7z2HZ/Qc=;
	b=c4pMTDT/ZxVl1oFrsnaKMrZLJ6cMlqG6U5WbhZkod6cBK9m3UD6PdQuho3W9gtJ8enHrqh
	wBdIpsmKcmbhSXyppmELEYSOL5xO9IqsMgR+NcDs9FUFUQhyTjFSt3gqeQgpSguEFLxpPn
	t5DcdPvEUtR+CmO7mpXS+oMA0duz2hM=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Peter Rosin <peda@axentia.se>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Kees Cook <kees@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] mux: Realign struct mux_chip to save 8 bytes
Date: Thu, 28 Aug 2025 18:21:01 +0200
Message-ID: <20250828162105.4299-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Reduce mux_chip's struct size by 8 bytes by realigning its members.

pahole output before:

  /* size: 752, cachelines: 12, members: 5 */
  /* sum members: 744, holes: 2, sum holes: 8 */
  /* member types with bit paddings: 1, total: 1 bit */
  /* paddings: 1, sum paddings: 3 */
  /* last cacheline: 48 bytes */

and after:

  /* size: 744, cachelines: 12, members: 5 */
  /* member types with bit paddings: 1, total: 1 bit */
  /* paddings: 1, sum paddings: 3 */
  /* last cacheline: 40 bytes */

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 include/linux/mux/driver.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/mux/driver.h b/include/linux/mux/driver.h
index e58e59354e23..8e912399cf3b 100644
--- a/include/linux/mux/driver.h
+++ b/include/linux/mux/driver.h
@@ -56,16 +56,15 @@ struct mux_control {
 /**
  * struct mux_chip -	Represents a chip holding mux controllers.
  * @controllers:	Number of mux controllers handled by the chip.
- * @dev:		Device structure.
  * @id:			Used to identify the device internally.
+ * @dev:		Device structure.
  * @ops:		Mux controller operations.
  * @mux:		Array of mux controllers that are handled.
  */
 struct mux_chip {
 	unsigned int controllers;
-	struct device dev;
 	int id;
-
+	struct device dev;
 	const struct mux_control_ops *ops;
 	struct mux_control mux[] __counted_by(controllers);
 };
-- 
2.50.1


