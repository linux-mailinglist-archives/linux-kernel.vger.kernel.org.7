Return-Path: <linux-kernel+bounces-677165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECE2AD1701
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jun 2025 04:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F4C43A4512
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jun 2025 02:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734A0246332;
	Mon,  9 Jun 2025 02:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQEaFec+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B8D2AF03
	for <linux-kernel@vger.kernel.org>; Mon,  9 Jun 2025 02:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749437180; cv=none; b=IhMcHTuQpDoRMVnlzt2M4Yew4kuYHBchc8ooYUzWyGSzaIY+pxaR/QTyv67HqSPSZB1OqtIp4y5FOqtcET5QcYYxTD4LiWenwZeRnqARPkerLyMEvON9PiBeE65CABSNYWSJQ68k+Wzb8mJj2D3cc4Lkq/2fzevfSKeN+i69YXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749437180; c=relaxed/simple;
	bh=mgPPxq0xFIxesCtf+81IXP/MI2Sn8+NP076GSuZran8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rt3pIjAsI3ZzlYGOjX0zLbmox9r22VGvSDaNcPaRQvhPuqEA4l1CJoET/Hh07Add4bAxvTIoeXGclUSZDu+i4Wm9Xzuwq/86ADyTFBRWltkxMdDUu+dEewZeagVbUwiHB09x/m4CwodHIzuNTJg91cKPLAIbiHLE5Dvj/fBQFMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQEaFec+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65537C4CEEE;
	Mon,  9 Jun 2025 02:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749437180;
	bh=mgPPxq0xFIxesCtf+81IXP/MI2Sn8+NP076GSuZran8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gQEaFec+N1jPlVmfYeaohGED8gearN3kkRQ0d7RfgJKWPv6tq2Lw6157yVD0pnpRE
	 +7X4juI2DxyJT1u3bYJTRP7eia7PFmRCt0YJHYv09go1mM4AeCAgCD6KMkEG5LcSxG
	 q88CJ/UpGIUl0+PdN4o/S8AYOQdaf5vRMwi0g48W0EeTqF42OWKheALhLj5u3YPQwp
	 9nzqqkXsuNKx/yY5bqUoOaF2Xa4e0gM/k9m4HAE+GCktUGZag5gP6lZhzofwfZOQ8x
	 jGHxZIkOqJqLvrA4K5/fYZdi9AiLmue/qFBX6L6xvQOjZ3prJzVIWJRX4QiQn3/7c9
	 EWnSGBMtdTKEg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56041C61CE7;
	Mon,  9 Jun 2025 02:46:20 +0000 (UTC)
From: Vincent Mailhol via B4 Relay <devnull+mailhol.vincent.wanadoo.fr@kernel.org>
Date: Mon, 09 Jun 2025 11:45:45 +0900
Subject: [PATCH v2 1/3] bits: split the definition of the asm and non-asm
 GENMASK*()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-consolidate-genmask-v2-1-b8cce8107e49@wanadoo.fr>
References: <20250609-consolidate-genmask-v2-0-b8cce8107e49@wanadoo.fr>
In-Reply-To: <20250609-consolidate-genmask-v2-0-b8cce8107e49@wanadoo.fr>
To: Yury Norov <yury.norov@gmail.com>, 
 Lucas De Marchi <lucas.demarchi@intel.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Andi Shyti <andi.shyti@linux.intel.com>, 
 David Laight <David.Laight@ACULAB.COM>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, 
 linux-arm-kernel@lists.infradead.org, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2513;
 i=mailhol.vincent@wanadoo.fr; h=from:subject:message-id;
 bh=NGmVIjUdr4EqhMM+SBmR2hmkqZdqTn/7wRr5kfWNHjg=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBluXp/EePd+n5ykclwseDKrxavSpKbzAQe3SHzdyK7pt
 mTHFOuijlIWBjEuBlkxRZZl5ZzcCh2F3mGH/lrCzGFlAhnCwMUpABPJ+8Hwv2LJqWSLZOb785dw
 HVqxIEjw0MvPB5wPCOvOn+NlNtVk0kVGhtOvLnuwcH2s+KI0P/yUVsvRO1Eal6dFO6Uz3BA6eW7
 /Ei4A
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
X-Endpoint-Received: by B4 Relay for mailhol.vincent@wanadoo.fr/default
 with auth_id=291
X-Original-From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Reply-To: mailhol.vincent@wanadoo.fr

From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

In an upcoming change, the non-asm GENMASK*() will all be unified to
depend on GENMASK_TYPE() which indirectly depend on sizeof(), something
not available in asm.

Instead of adding further complexity to GENMASK_TYPE() to make it work
for both asm and non asm, just split the definition of the two variants.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
Changelog:

  v1 -> v2:

    - No changes

This patch previously belonged to this series:

  bits: Fixed-type GENMASK_U*() and BIT_U*()
  Link: https://lore.kernel.org/r/20250308-fixed-type-genmasks-v6-0-f59315e73c29@wanadoo.fr

Below changelog contains the history from the previous series.

Changelog:

  v6 (previous series) -> v1 (new series):

    - Do not rephrase the comment saying that BUILD_BUG_ON() is not
      available in asm code. Leave it as it is.

    - Add Lucas reviewed-by tag.

  v5 -> v6:

    - Restore the comment saying that BUILD_BUG_ON() is not available in asm
      code.

  v4 -> v5:

    - Use tab indentations instead of single space to separate the
      macro name from its body.

  v3 -> v4:

    - New patch in the series
---
 include/linux/bits.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/bits.h b/include/linux/bits.h
index 7ad0562191153471dac729b0020cdb1c9d3049fc..13dbc8adc70ee0a624b509cb6cb9f807459e0899 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -35,6 +35,11 @@
 
 #define GENMASK_INPUT_CHECK(h, l) BUILD_BUG_ON_ZERO(const_true((l) > (h)))
 
+#define GENMASK(h, l) \
+	(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
+#define GENMASK_ULL(h, l) \
+	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
+
 /*
  * Generate a mask for the specified type @t. Additional checks are made to
  * guarantee the value returned fits in that type, relying on
@@ -79,15 +84,11 @@
  * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
  * disable the input check if that is the case.
  */
-#define GENMASK_INPUT_CHECK(h, l) 0
+#define GENMASK(h, l)		__GENMASK(h, l)
+#define GENMASK_ULL(h, l)	__GENMASK_ULL(h, l)
 
 #endif /* !defined(__ASSEMBLY__) */
 
-#define GENMASK(h, l) \
-	(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
-#define GENMASK_ULL(h, l) \
-	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
-
 #if !defined(__ASSEMBLY__)
 /*
  * Missing asm support

-- 
2.49.0



