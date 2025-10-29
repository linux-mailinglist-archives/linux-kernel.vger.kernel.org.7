Return-Path: <linux-kernel+bounces-875322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DD8C18B35
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3A661C875B1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2E73115B5;
	Wed, 29 Oct 2025 07:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zJRfXvsS"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE28D312836
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761722552; cv=none; b=FiQhYpp/4vbYuNM+iUeVj3pBn8+fTYV8YJdwo9IAB6980+3mF/urkXNcRSkvGTZMec/Ee6A082p3wVbkjpQPS2ZKJwZ0DFToUM6qmjMQnELMzowLyMBdQwT1OMfsQnBEJ/udXpeazJGsDoEWntQ4ypcUIw68BTl+xhhcdlgRG1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761722552; c=relaxed/simple;
	bh=j5r+2odxBNbt80HcveVjT5JrM8/hnaZaeBH583rpYes=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WdRbvn3UbzGeTfwcsEgm0cH6gKw+vlGVjZT/JyrykwhFEe1AoozAsFNKV19W04jPGWqX3YO60W+Ht1m2HCjai6eyu3SPTJDreI4gVzhaE/2Re9+JUCQMgjHbIWzmvg104pmUV7XEk2d+n0zQsM5pET3jatxCD3kUEJ/4mMMthEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zJRfXvsS; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C81304E413C1;
	Wed, 29 Oct 2025 07:22:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9624B606E8;
	Wed, 29 Oct 2025 07:22:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B51851031151A;
	Wed, 29 Oct 2025 08:22:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761722546; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=u4h3/ci9xv/fDXcWHRVTbDKRAf2ZDqg3x6d4f6vmEcM=;
	b=zJRfXvsSoLG9MLbS/ylKbO+UF+BakEXogiSfwquwWbKxUZzZptcSP2D5ryi09UcREH2tG4
	E2Nq1OKynHJf25uNoquU62fBxXmo0eXUTHtMf/2NGhAIDNOXz5dTsy/Lr2L+QzGsiIgSIY
	n4AW9DlBvKZVnxIel159tI72m1qVgEyYei5uRyE2m24fhOQpPbns/7QEM4Y+fTmVogBNcw
	tva+m7cQD0JZp9WeQZ+t8pDT/CW1aRsxlMV3dp49nUtY8ynALTq0wpf+fdtJbJiOLXPy2e
	xmbWL8xgH58pco+/ZGucr3LOA9APXuAAsa3MCKuksDdfWouRU21PMsaLR0eemw==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
Date: Wed, 29 Oct 2025 08:22:20 +0100
Subject: [PATCH] of: Update license for MIPS GIC header
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251029-fix_gic_dt_licence-v1-1-af70840c5e61@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAKvAAWkC/x2MQQqAIBAAvyJ7TlAhs74SIbFutRAWGhGEf086D
 szMC5kSU4ZBvJDo5sxHrKAbAbjNcSXJoTIYZVqtjJMLP35l9OHyOyNFJImus0uwoVM9QQ3PRNX
 6p+NUygcwAmAdZAAAAA==
X-Change-ID: 20251028-fix_gic_dt_licence-c876fd6d709e
To: Andrew Bresticker <abrestic@rivosinc.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gregory CLEMENT <gregory.clement@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

According to Documentation/devicetree/bindings/submitting-patches.rst:
"DT binding files should be dual-licensed." The second license should
be a BSD-like license, allowing the use of the binding in projects
other than Linux. Initially, this file was submitted without any
license and was later automatically converted to the default Linux
license. Let’s now update it to follow the preferred license for the
binding.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
Hi Andrew,

I’m assuming you are the same Andrew Bresticker who initially wrote
this file. As the author, would you agree to update the license for
the reasons I outlined in the commit log? If you’re okay with this
change, I believe an Acked-by tag would suffice.

Let me know your thoughts.

Gregory
---
 include/dt-bindings/interrupt-controller/mips-gic.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/dt-bindings/interrupt-controller/mips-gic.h b/include/dt-bindings/interrupt-controller/mips-gic.h
index bd45cee0c3f05..647f22d5f0622 100644
--- a/include/dt-bindings/interrupt-controller/mips-gic.h
+++ b/include/dt-bindings/interrupt-controller/mips-gic.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
 #ifndef _DT_BINDINGS_INTERRUPT_CONTROLLER_MIPS_GIC_H
 #define _DT_BINDINGS_INTERRUPT_CONTROLLER_MIPS_GIC_H
 

---
base-commit: dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa
change-id: 20251028-fix_gic_dt_licence-c876fd6d709e

Best regards,
-- 
Grégory CLEMENT, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


