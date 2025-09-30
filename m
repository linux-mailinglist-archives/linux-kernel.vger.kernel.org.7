Return-Path: <linux-kernel+bounces-837830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2242FBAD585
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 401801941EC5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BE5304BC7;
	Tue, 30 Sep 2025 14:55:06 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57611E9B1C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 14:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759244105; cv=none; b=twTSKozudo9S/ZWMhphvvV739HbqtOa0p33vKJy0/Z+BHUwMTADQbtHzVu9qzW1TIbDN9ye8skl0fyr4B+2523egZylmmOfUZDHdR6UGyShrmneLKCGQHIC0ObY58FX4LKayzxVKUk99HlUQvzR0qmaJPnGq4KliXsc8uPgub3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759244105; c=relaxed/simple;
	bh=v8o95971Rco+Io39m1wDeVB30uhLToI9aRK3W8fHJyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YS8UctQpiXIflYH8aysOwPWkVBlOO04erJ1GusfonFndjbptV2I354xcVhmBE6eRJc4X5dvkfgSUeje4oH9PV2hxotUeh+Ss5ixv5UXIEQmbC4+bYeMt1I6QMZbhQHqW7qO3Th8mplw1LMuHdpRTRgVqNzLLsntzQUSUoWsorEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C47C113D0;
	Tue, 30 Sep 2025 14:55:04 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Jens Wiklander <jens.wiklander@linaro.org>,
	Sumit Garg <sumit.garg@kernel.org>
Cc: op-tee@lists.trustedfirmware.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] MAINTAINERS: Mark the OP-TEE mailing list moderated
Date: Tue, 30 Sep 2025 16:55:01 +0200
Message-ID: <cc9862625abc5b923c5e7c5de20c6f7c797771d6.1759243993.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After sending a patch to op-tee@lists.trustedfirmware.org, I got the
typical response for a moderated list:

    Your mail to 'op-tee@lists.trustedfirmware.org' with the subject

	[...]

    Is being held until the list moderator can review it for approval.

    The message is being held because:

	The message is not from a list member

    Either the message will get posted to the list, or you will receive
    notification of the moderator's decision.

Mark this mailing list moderated in MAINTAINERS.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fc755a50fb150498..5aa2e501231f2aa6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19115,14 +19115,14 @@ F:	drivers/net/phy/ncn*
 
 OP-TEE DRIVER
 M:	Jens Wiklander <jens.wiklander@linaro.org>
-L:	op-tee@lists.trustedfirmware.org
+L:	op-tee@lists.trustedfirmware.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-optee-devices
 F:	drivers/tee/optee/
 
 OP-TEE RANDOM NUMBER GENERATOR (RNG) DRIVER
 M:	Sumit Garg <sumit.garg@kernel.org>
-L:	op-tee@lists.trustedfirmware.org
+L:	op-tee@lists.trustedfirmware.org (moderated for non-subscribers)
 S:	Maintained
 F:	drivers/char/hw_random/optee-rng.c
 
@@ -25116,7 +25116,7 @@ F:	include/media/i2c/tw9910.h
 TEE SUBSYSTEM
 M:	Jens Wiklander <jens.wiklander@linaro.org>
 R:	Sumit Garg <sumit.garg@kernel.org>
-L:	op-tee@lists.trustedfirmware.org
+L:	op-tee@lists.trustedfirmware.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-class-tee
 F:	Documentation/driver-api/tee.rst
-- 
2.43.0


