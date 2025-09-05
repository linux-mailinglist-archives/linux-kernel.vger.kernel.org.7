Return-Path: <linux-kernel+bounces-801891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36557B44B3C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 03:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D2C1488242
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 01:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1D01EB5F8;
	Fri,  5 Sep 2025 01:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHJR+MO7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8AC72625
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 01:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757035596; cv=none; b=QoSLbUK3XgRrCvO9avBJWTc4Dxl+uGnDqhQ2LUSZ9xd92QWGWu3LKdMb3S2cwqhxGO2aCvXD6BV9rlDrJ1as2ea72Fz3XWB9NUJCmylu4YsX6MT6zzmhPZEF/BxRA2aYrHqRYtWwSG5ZZhG3Fd803hKGpG6xBwg+BcoEZGtv1uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757035596; c=relaxed/simple;
	bh=Q7tJcuXKBC904lYzUKjtoyrfpAV6c97cosqGwoHHcXI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=szKsbOXy3ZdxvtVe66nO3lBUKR2rIhnBiNO7/2sF/yFiuv9AEn9E9PVqnzjtQUeraXRKd2K52/MKgGto2IkNTPaoXND4JcNEUz2YTzWPc5YO7KnJljQnhfDmQUjCjW9daPaOK8u4AMXWseQIUXfHcQP7DMVlbP/p4z9wV8g3cKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHJR+MO7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B26C4CEF0;
	Fri,  5 Sep 2025 01:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757035596;
	bh=Q7tJcuXKBC904lYzUKjtoyrfpAV6c97cosqGwoHHcXI=;
	h=From:Date:Subject:To:Cc:From;
	b=eHJR+MO7N1xSxuUWExeM1hWMtxBSFKJXPQrZhp9qYE9pJ2Fqe6DwNA5P78zsExH36
	 IzMNwU0QGgWGUsDglK7rXZhBAw7yzHdbHxIY1bqPhFwuAfLBzOi8IgoS35zx+pZBKG
	 1jnQ1BOnPhyWHfTdVdCCM7T2Km3ubdOmHkxEHw7NkWTkCjXo0yrg/cKahDU+Xf18m1
	 lfL0k6vkBjHp5/2jrwHXLGLrWQ0Nn1Lq0zR3TUATbgFxF+i7Ncs5/CDuPAbynL5mSJ
	 C/7Wgk2ge+8FJ06rAqwpCaWWcpCKMlLTVuJAXqW+sJrJoJc6FtUxfprSlljxhiqKRb
	 b28uj3lRFoKOQ==
From: Nathan Chancellor <nathan@kernel.org>
Date: Thu, 04 Sep 2025 18:26:12 -0700
Subject: [PATCH] mfd: tps6594: Explicitly include bitfield.h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-mfd-tps6594-core-fix-bitfield-h-v1-1-5d0f00cfe58f@kernel.org>
X-B4-Tracking: v=1; b=H4sIADM8umgC/x2NWwqAIBAAryL73YKZFXWV6KN0rYUeohJBdPekz
 4Fh5oFIgSlCLx4IdHHk88hQFgLMOh0LIdvMoKSqZSc17s5i8rGpO43mDISOb5w5OabN4oqtnhR
 VtqmUM5ArPlA2/sMwvu8HS/rFDHEAAAA=
X-Change-ID: 20250904-mfd-tps6594-core-fix-bitfield-h-74a2e3d632fc
To: Lee Jones <lee@kernel.org>, Job Sava <jsava@criticallink.com>, 
 Michael Walle <mwalle@kernel.org>
Cc: linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1424; i=nathan@kernel.org;
 h=from:subject:message-id; bh=Q7tJcuXKBC904lYzUKjtoyrfpAV6c97cosqGwoHHcXI=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDBm7bLxsJhsVcl+0E/6Ze03+tVLUkWYv7htKwtyXOIsff
 gszkH3cUcrCIMbFICumyFL9WPW4oeGcs4w3Tk2CmcPKBDKEgYtTACbCM5vhrzAHj86uOaqFM92e
 ahvdF9fTeiYtf2yuqtOdWxliIi+K3zEynPXX9ZtlFFsvfmXLj+qp2qx3XkbdSbz1/3CG0I+fW87
 wMAAA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

After a recent change that started using FIELD_GET() in tps6594-core.c,
there is an error when bitfield.h is not implicitly included, such as
when building allmodconfig for ARCH=hexagon:

  drivers/mfd/tps6594-core.c:767:7: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    767 |                 if (FIELD_GET(TPS65224_MASK_EN_PB_VSENSE_CONFIG, pwr_on) == TPS65224_EN_SEL_PB ||
        |                     ^

Explicitly include bitfield.h to resolve the errors.

Fixes: d766ca01c208 ("mfd: tps6594: Add power button functionality")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
It looks like this should go into ib-mfd-input-6.18.
---
 drivers/mfd/tps6594-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/tps6594-core.c b/drivers/mfd/tps6594-core.c
index 7127af7142f5..8b26c4127472 100644
--- a/drivers/mfd/tps6594-core.c
+++ b/drivers/mfd/tps6594-core.c
@@ -10,6 +10,7 @@
  * Copyright (C) 2023 BayLibre Incorporated - https://www.baylibre.com/
  */
 
+#include <linux/bitfield.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>

---
base-commit: a4eb677652a5da4d8e7271c0c0c8719c39f10e36
change-id: 20250904-mfd-tps6594-core-fix-bitfield-h-74a2e3d632fc

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>


