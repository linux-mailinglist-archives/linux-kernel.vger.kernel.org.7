Return-Path: <linux-kernel+bounces-879675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC9DC23B4D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B1E618851A9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C534A2ECE83;
	Fri, 31 Oct 2025 08:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSeokfBR"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EF4272E56
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761897996; cv=none; b=NTbHZ+gL1IU3Y2YcTp7t2Ksqep82JLQ02rCKIGpNnQHWeOHGM+K2v08VGA/dJ3Ykr6knLj4Do8BJDoCAHnpRxD82SKkjZ+XzVHmk5RBuGAkSYaFVKTv8mhWvz26aLxG/UZw7VPh3HGMt7r8Onm1yAGMGfhThOOGo1iZklRp8DrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761897996; c=relaxed/simple;
	bh=UuG3+VCNBbYpzeZ0dxVY03iZi2WsaJI6aqGWnRdi9IE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oGqlMPzGCYDp8ERpp4VYaMd30sKkE1UAymWz0sdBkv3kQuql6h6WVCP/iVo6UkUpaAnUqjVxCjq8IcXK1wldavLX0IozEeHkKEq393ooYoL8UROMWIey1Bz0gQnGfrTVuVvRCc3VRvq0HY/9/9YPAFkuMn8JYtcIMFNIdPVv2/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSeokfBR; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-294cc96d187so25965705ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 01:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761897994; x=1762502794; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IeLVIXwO7uVSd7Eb1bLuSghidWP97pKx/canepqCQWw=;
        b=JSeokfBRlIMWj/RpxFcvjxr57uMSSwrTLjLA0eHhFYG9AsMJ31TIY42sqmY8/pAJkU
         DdvyKqlP3KAkE9Sjin8DeB1zkdX8mfI2xRHKzqyiwEXHPbduwDXDe8KGTCMxF0KWEttm
         Jpg1GKwXzaFPc/SYFSYUwlCDkUbCdOpWKSF4i+0M54FeD3PKn8p7g06rI5ZjDvefZb3p
         xWMG5LzarPZDHsSFyhK9aItYiEKIyIAtTxQRei/SnkXgvR12qSz2tbQrWFn+uX50nB9j
         dgmLSX4sYHYSK9R6rKeffKHStEXdYQoyJt4HeHPzZDH/dElrBymzcEWZViwJEBQp7g0Z
         z5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761897994; x=1762502794;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IeLVIXwO7uVSd7Eb1bLuSghidWP97pKx/canepqCQWw=;
        b=VWBCBMcwhu+6K/yM2R9IOOftrX9m2tH1UU8GXuO2oqkqW58lpKbG9jLrQJZIWid1Ux
         mLZQi6J6Rgjt62DzMWYsEY0Dmdu2Vc/C1XZRzKJHhaac/1G11Iy+c40gZ29caxD/so4M
         rZMXU53z4j3RQOlQRSkLbPXlBoyxK44nc0iq3rtIkDkiTOKHJi3GB9TcEsUi4MG38S5D
         fdeK3G/E2fvo8ivR5iFoZNngXJttuWg5mZl/gHmvvMME/elhsC69iqwcyeOrUFGsbx8n
         W31R6SUXjwkmjVM8bFotUiq0C3bQXMG7FxwtLfIZ32J2bNvIvlvPr7XuoyiBNuivYVT2
         Gh8g==
X-Forwarded-Encrypted: i=1; AJvYcCWjSIh0Q6rFrBiXKew1P/W3B714v7qPPqoUs+8namLWuAwjrJvGO64PczIKch6JXT33WrVVtlNSWm1LeOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoyRiOZI/TgnGzIzmvnTkaLHbnbXqfTzQfLZ0t2orCkBRwHfUS
	digTaAkwdgN0PT2IP4o+OsP1mXVJ59wyFiz3/dTVaHQPHK7RAUoOoIoF
X-Gm-Gg: ASbGncvd7JyTZ1hMREhvMYQ/Wlg15uzOSQyMWCN7XfI+ySDmu42ZiYETsLQ0ZCmtGD0
	+ZepTVEhRuFBwqDUgB5lsLhNUe6RM6l9DEapwBBrlBQIkxt7TalbNbM0Lz6eLzCYz4V7K1bflI6
	PQQPHxWu+a40dwpPHd1Pwlj+BbZQqB//Ler2CPOc2vXCMhLtXDVcxPMxs3LjWVWsJwer2W1YN78
	Wtg5RP/yhkCIGVKO7jZCKggRAd4GAph7tWK+5Vq3S3KFqAC+2KA+sYubyC7c/otkA5h1tqisjE8
	Fe91VM/e2MEDtRbOPY0AtfazxrvHXTSuH+AZ7kpni+nTTL8H1CWKAMTCNHQvf5V1oreJHxCrwTB
	1lfObJK9lOEiDxZhQUCIlpGH4tTirF32rEmZq7z5fbo7Vw0vi0kyGqbpMACyc1FhmteFqKpbYPE
	9oKEffvk6al/8u6W08ICEg4I/zl42amzyy5l/5omkr7OPAFXGiIchpcw5k27AsHjw=
X-Google-Smtp-Source: AGHT+IGhFLRMuVYsJyg0Hk0qGxv9T+7d4+7cAQ0FGbKkkh0amDTMd2Acnw8xiF99bDeg05kFkWf4ow==
X-Received: by 2002:a17:902:b70f:b0:294:e8a0:382b with SMTP id d9443c01a7336-2951a4f767dmr25011125ad.54.1761897993644;
        Fri, 31 Oct 2025 01:06:33 -0700 (PDT)
Received: from DESKTOP-RD0GVCL.localdomain (124-218-195-161.cm.dynamic.apol.com.tw. [124.218.195.161])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952699c9fbsm14113245ad.82.2025.10.31.01.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 01:06:33 -0700 (PDT)
From: LiangCheng Wang <zaq14760@gmail.com>
Date: Fri, 31 Oct 2025 16:06:30 +0800
Subject: [PATCH] drm/tiny: pixpaper: Prevent inlining of send helpers to
 reduce stack usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-fix_202510270858-v1-1-6b111d475ce2@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAVuBGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA2ND3bTMingIx8jcwMLUQtco1cTMxDjJwMDUxFQJqK2gKBWoBmxkdGx
 tLQBOGmBZYgAAAA==
X-Change-ID: 20251031-fix_202510270858-2e4643b00545
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, kernel test robot <lkp@intel.com>, 
 LiangCheng Wang <zaq14760@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761897992; l=2818;
 i=zaq14760@gmail.com; h=from:subject:message-id;
 bh=UuG3+VCNBbYpzeZ0dxVY03iZi2WsaJI6aqGWnRdi9IE=;
 b=mK5+SYBvGWn62MR/m+GdIu/nNPFIfMwQ2E2Ch9x0cFaUiEx+6Qf7V8YKLzV6lC9dvp44QfwL4
 MS+Nsbaq2KSA97KntzVW89WCREuwcThUpa6N6adNPMod4GcASuBpKkk
X-Developer-Key: i=zaq14760@gmail.com; a=ed25519;
 pk=/x4391DbJ19fFQI7t33HWt3lsHfYPl2I2ax8C+Vxr+M=

Clang reports that pixpaper_panel_hw_init() exceeds the 8 KB stack
frame limit:

    drivers/gpu/drm/tiny/pixpaper.c:579:12: warning:
      stack frame size (20024) exceeds limit (8192)
      in 'pixpaper_panel_hw_init'

This warning occurs because the compiler aggressively inlines
pixpaper_send_cmd() and pixpaper_send_data() into
pixpaper_panel_hw_init(), which inflates the estimated stack usage.

Mark these two helper functions as 'noinline' to prevent inlining.
This significantly reduces the reported stack usage without changing
runtime behavior.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202510270858.1GzE6iQg-lkp@intel.com/
Fixes: c9e70639f591 ("drm: tiny: Add support for Mayqueen Pixpaper e-ink panel")
Signed-off-by: LiangCheng Wang <zaq14760@gmail.com>
---
When building with Clang and frame size warnings enabled
(-Wframe-larger-than=8192), the compiler reports that
pixpaper_panel_hw_init() consumes over 20 KB of stack space:

    drivers/gpu/drm/tiny/pixpaper.c:579:12: warning:
      stack frame size (20024) exceeds limit (8192)
      in 'pixpaper_panel_hw_init'

This happens because Clang aggressively inlines
pixpaper_send_cmd() and pixpaper_send_data() into
pixpaper_panel_hw_init(), causing the calculated stack usage
to balloon far beyond the warning threshold.

The fix is straightforward: mark these two helper functions as
'noinline' to prevent inlining. This reduces the reported stack
usage to within normal limits without changing runtime behavior.
---
 drivers/gpu/drm/tiny/pixpaper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tiny/pixpaper.c b/drivers/gpu/drm/tiny/pixpaper.c
index 32598fb2fee7fcdea3ea0696c2bf54404fcffa2e..70e3239adfd0f86f92551991872486380489fb9b 100644
--- a/drivers/gpu/drm/tiny/pixpaper.c
+++ b/drivers/gpu/drm/tiny/pixpaper.c
@@ -536,7 +536,7 @@ static void pixpaper_spi_sync(struct spi_device *spi, struct spi_message *msg,
 		err->errno_code = ret;
 }
 
-static void pixpaper_send_cmd(struct pixpaper_panel *panel, u8 cmd,
+static noinline void pixpaper_send_cmd(struct pixpaper_panel *panel, u8 cmd,
 			      struct pixpaper_error_ctx *err)
 {
 	if (err->errno_code)
@@ -556,7 +556,7 @@ static void pixpaper_send_cmd(struct pixpaper_panel *panel, u8 cmd,
 	pixpaper_spi_sync(panel->spi, &msg, err);
 }
 
-static void pixpaper_send_data(struct pixpaper_panel *panel, u8 data,
+static noinline void pixpaper_send_data(struct pixpaper_panel *panel, u8 data,
 			       struct pixpaper_error_ctx *err)
 {
 	if (err->errno_code)

---
base-commit: d127176862a93c4b3216bda533d2bee170af5e71
change-id: 20251031-fix_202510270858-2e4643b00545

Best regards,
-- 
LiangCheng Wang <zaq14760@gmail.com>


