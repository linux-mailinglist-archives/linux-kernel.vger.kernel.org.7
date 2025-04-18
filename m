Return-Path: <linux-kernel+bounces-610837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9349CA9399F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 17:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9954464F44
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 15:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D1121322E;
	Fri, 18 Apr 2025 15:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="rJzEsqIn"
Received: from sonic308-55.consmr.mail.gq1.yahoo.com (sonic308-55.consmr.mail.gq1.yahoo.com [98.137.68.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C44211278
	for <linux-kernel@vger.kernel.org>; Fri, 18 Apr 2025 15:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.68.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744990109; cv=none; b=IBxLxciPdGwdxNTiELiJzvWNfYJm/34kTIx1Xv4BK+AyWr0Loe7D3DkhFYI09MF7FpQO+0AEA17OeF0B/Uc8xr0xpcecVvAGxNnHq0hFqr6G2mcIY8D+YZ9hiU9HHS9cDTwDyMFTAPbcTvUJmIpVsKi/o3pqPNB4VPqNvhxyamY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744990109; c=relaxed/simple;
	bh=xOdu2gi8L6DYGYuLQPtrq+ir8L1ZoeFhePuMunbTn+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cm9OgeH1oekfNVxu1GDvTfjc43iFIEJgrTi0BRWmnTqUfDC4QiJQW56LwJu+hL+3ZuYBePEQ7fugoAP9UmtL3KA31qv/dJuhKD7in+nZVbP6KvLu/7aLUwFS+K62FOLp/krLxceI5MVfDkbX5JLq1hLAJ+wmmZZq2zS3unUwjEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com; spf=pass smtp.mailfrom=aol.com; dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b=rJzEsqIn; arc=none smtp.client-ip=98.137.68.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aol.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1744990107; bh=kB+h5yP3IPBkJvaAFUAFuyiqySzIbHuteHH3qZOlXl8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=rJzEsqInC1RDsxj+G270jVBsMBhWKxdw4ooK5amM+Bf+84aCjBnRVnM3tFZuPZVPh2/g7ve3u97Dq4dSODdOEOH1Lo6EUhV/UVo8ghSRfYQDnml4uO1mWFGuqfS3Ea386hej0UEc0raWwGHcx+0aN+8j4ehSn6gcISugeGrkqkcPnfRgdVsFMXLXIM3+KQv2En6hzZoH2WzFLLVzYpmrhdN/jofBuHBIEJcYjTYEnmGl4b8km/94FErvF/OWDWeqp++Q0OzJFdUry9E3lO3Guqb17r1xr1q7xATASc+3qC7CP6Ug/oih3RY4XBg9ujQbk4Rl2W7NXFMEDYmO+8rVSw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1744990107; bh=avsB6DeRRN5e4dF7qJdg86POIxnErrXo1w/slz28sug=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=o3DJ1ZZwLwroqdM5Z4hSHVS7hL6rYBNDP4lYtce/+Woi52ODeiquB+W9htlGDbe+JBgxcKXRL3IhAkHQV0B4BRmHdhEk9xkHmTns7gpywoRUjDN8sHp6LhvL/uQlgL3rxjI1HNoWUQH34aYA8jBVAoy4pEczoH0OD21oD0nEznD2y/QtMrrIGrdugHt47yN3G4+gbRnPjWDCT3dms2C2N26GU+klO59vxCmZxTmMDndEkbr9i8fwJuVYetMSoye74h7mjhacj+xMjSP6uByhadqutLN0R0zjdOutJzKH4dEXS+TZIFLbocLS/5VmWm/zxaPCiZLmdNIQbaeDDZgm7A==
X-YMail-OSG: iFmeQr8VM1mK_jNd.0.YHVw17zxxRzQSTY7SP1AgC95pD2cm4xCrWmnp5SEeUvU
 3cMYSZZ_hz1dUPEiP3o7UifiYq.lVv6rHJsScsTR2ubLm8uT5FKpPDW8tW9PD45APwRRLMOQNFac
 KsXnGz49X12lwJL4_lGGDQLbCMasL36JcqWo37W9O1UUsRZlN2pcuvMiPiVhJm4p.0a8C0BjezKg
 wLpGH3zm.ntvSrpFXf5jW0MWQAoZtKcUx2HdoFoxGKzAyJv5NGNCwOlVlx6uVN6x6Z7UTU0AkRwj
 tbkH0QzPyrGFPO2uCz9OuWTZKoW1Uio6nLU_tISN2ct_p93EYalMt3EztL0jWx3O0YWQ2bUXT7Fg
 nDiUYJ7HxBI8x3hOX6wDdoIzVQmRizXZh6LcpTORteK9Wxv1aAMfpKhL_uhDLSdPiuDUomv7vIYV
 3npGshp_jWNCil_HM1PIdZ2WoLrJ.SkqZ6ufoHPOmiISuLwQbW36Qmo3DkRNJhfosOhNSUUb7KNK
 tN_wAcM54RRkICYyXjOB2rilJgCBjPCLyRlOltWDBHmdMW7Clm.Z_WbxgwlEWapicLi_NzK7pRos
 Vijp5ndAhi6XtHCBL7IZPxPsipRv.GHmNUF9emJCaq97E_dJvw_UfaRTyDdP7PmpSzZsHUi_UKt9
 dBHfivjz.1nfT3zcDIXnkRsfVNvJRSNiK7c7AEFp536mKAmlcGDAgh_aJwHKrtsejZ0_jfVN4PiN
 BkZm2brGZ82B6EJf2hlugkBz.ypPSoNpy8baOjL0oNGqJWw9VdbuaGpan_RvVPbsaBnY.mMD8siq
 YRZIPqxKV2uMmlK1PsWumNUZHakSX48PNKjFs794Qo5196KSep0dWU6dPA5zlxKK3bXHWsysOycT
 nwvsgQjDwrZkxA3Tc6LQ_mda9P6xsRGFf_tPBZCWXUMEF9gTbFkNhCNnXFHxB8TLR.zMYDg7zo_.
 k549VfLHGVSR3FXhLnDBfNgHq.hNCzgyzsi6cqjH38a_Lwqf0xd_zpwCplCuM9L.sVUPV811jJNk
 M5eKwjbseFmnwsQ53TIPBqUUIhj9yCwoZMsbj6wpCmhKJbIZanaDyjHNZNTkBGelVtHN9Qj7rMx_
 iV2L2QsThAEupDxhCc5tBV6_ZGThTDFE4PBsHRw.XmgIqvZGnd3XBSVJIgMkjHzNF1sdMftRAkEW
 jLCtz2phbZTmr2GujdYIDghKFuNFfKrZfZ9btHG.2Nr0kD2ZCjjSIzmDCdaZg6YxyeOv7F3domNF
 bBOLuUxVehnS67I5uCqnDUzU9K8uxWaqrr5gqH6Ww8BUFmg1BtdIrCJkB3IIRqwYdHkq_7Ks9OEA
 fMIoTk5GIL7H84bRZJbEaffBHvyoItYnrTaxRxt7o8OWNjKLWWvxZb2kFiR.dpSuQJ6ujpB8ZeU4
 QHkO5Lr2UlkyZdbBvaRVA4T.sdtkm3TlbId8VXcJePMXu6zOiovfmrrQqfPdjHE.8wVO3DgxhO.r
 6Nyb6LmmzhEO9h7aOvLKV0UMZ_uUutgLjjNFl91H2Sc7X5mVdHPdpYdX2KPScPiwbCSqjwbsNXAd
 gUWwTrVVHQ0JISWMDu0HzGAj2HAivGfL4VBNIXFj1F_.rj7y86m8BdeeT7lHE5T0O7SbabIZrXWl
 RuBuBXF01RM92mwlL7XV7iASsb.VN6tJUcErfMc5Tq2YVN8xzQ6eiekthBQHJkV8CKC88IaKKg2c
 x2mFxgy2EfYIDdKXaaHdY5waRX.Ip_FLU7HhjbJQLUSNeQQktgwjTDFxFoU0VB_4U3IC74UXvsOW
 H3jfWJjAQrWrIwd2JKmeJDVB7pfEzhkUQT2GnpxSr_1pRtErQRmPzLiAYzIvSKPkqsmHvDXhbsZU
 dHHlk1H0kcoqolEcj_sp811A8Fb2TPHqMb7YlPM_S3g1OwLzdHkOEA..LIYa4LuZGGsJREC_Qu94
 LxkgZRKgtp97XlaiIiXPqMYnddR686q2ZRnTz1GGdKX3vDr7XZ0q9M1fouTJCfN1NXjNuSoB_11A
 HGkO6zex8A9NQUxazvlL._Eoa2X8V096cJbZfBZeENFQzSWkQ4z_cNp3pRnlKD7mcWPIff1rEhmR
 kksRD7.gFGIGHdk.M0EGkAQfHhBXPrXvQL3fULmNphnN4hT4pe4BY_.nBaR9jJZLfloq8LvbONCG
 8WHUaMCJNEajvirlqN_tXe3o6iyBOTVSDbUnoXuHWyZ1nLbUUF.hNQ4DbgMnfkvS1M3dZ8SaGXmD
 8v.xKVoknx5LGB5UOQfzqqD80.7fdlHmpcdRfQg_ML3F4sPT3Jn2LXM.7vWQ4Bxz_Sa41kuT3fto
 2g4VxQg--
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: 9b098b5c-327d-4449-9d38-6829aed84013
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.gq1.yahoo.com with HTTP; Fri, 18 Apr 2025 15:28:27 +0000
Received: by hermes--production-ir2-858bd4ff7b-rjtcv (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8d9c4354726140fe64c22851ae4eda49;
          Fri, 18 Apr 2025 15:18:15 +0000 (UTC)
From: Ruben Wauters <rubenru09@aol.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Cc: Ruben Wauters <rubenru09@aol.com>,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] staging: sm750fb: remove ddk750_dvi
Date: Fri, 18 Apr 2025 16:17:48 +0100
Message-ID: <20250418151755.42624-3-rubenru09@aol.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250418151755.42624-1-rubenru09@aol.com>
References: <20250418151755.42624-1-rubenru09@aol.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This file and the code present was unused in the whole
driver, therefore this patch removes the file and unused
reference to the header.

Signed-off-by: Ruben Wauters <rubenru09@aol.com>
---
 drivers/staging/sm750fb/Makefile         |  3 +-
 drivers/staging/sm750fb/ddk750_display.c |  1 -
 drivers/staging/sm750fb/ddk750_dvi.c     | 45 -------------------
 drivers/staging/sm750fb/ddk750_dvi.h     | 57 ------------------------
 4 files changed, 1 insertion(+), 105 deletions(-)
 delete mode 100644 drivers/staging/sm750fb/ddk750_dvi.c
 delete mode 100644 drivers/staging/sm750fb/ddk750_dvi.h

diff --git a/drivers/staging/sm750fb/Makefile b/drivers/staging/sm750fb/Makefile
index 1926376664ca..b3cb973e2672 100644
--- a/drivers/staging/sm750fb/Makefile
+++ b/drivers/staging/sm750fb/Makefile
@@ -3,5 +3,4 @@ obj-$(CONFIG_FB_SM750)	+= sm750fb.o
 
 sm750fb-objs		:= sm750.o sm750_hw.o sm750_accel.o sm750_cursor.o \
 			   ddk750_chip.o ddk750_power.o ddk750_mode.o \
-			   ddk750_display.o ddk750_swi2c.o ddk750_dvi.o  \
-			   ddk750_hwi2c.o
+			   ddk750_display.o ddk750_swi2c.o ddk750_hwi2c.o 
diff --git a/drivers/staging/sm750fb/ddk750_display.c b/drivers/staging/sm750fb/ddk750_display.c
index 172624ff98b0..4e390541a507 100644
--- a/drivers/staging/sm750fb/ddk750_display.c
+++ b/drivers/staging/sm750fb/ddk750_display.c
@@ -3,7 +3,6 @@
 #include "ddk750_chip.h"
 #include "ddk750_display.h"
 #include "ddk750_power.h"
-#include "ddk750_dvi.h"
 
 static void set_display_control(int ctrl, int disp_state)
 {
diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
deleted file mode 100644
index 9842c4e4cdf8..000000000000
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ /dev/null
@@ -1,45 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#define USE_DVICHIP
-#ifdef USE_DVICHIP
-#include "ddk750_chip.h"
-#include "ddk750_reg.h"
-#include "ddk750_dvi.h"
-
-/*
- * This global variable contains all the supported driver and its corresponding
- * function API. Please set the function pointer to NULL whenever the function
- * is not supported.
- */
-
-static struct dvi_ctrl_device dcft_supported_dvi_controller[] = { };
-
-int dvi_init(unsigned char edge_select,
-	     unsigned char bus_select,
-	     unsigned char dual_edge_clk_select,
-	     unsigned char hsync_enable,
-	     unsigned char vsync_enable,
-	     unsigned char deskew_enable,
-	     unsigned char deskew_setting,
-	     unsigned char continuous_sync_enable,
-	     unsigned char pll_filter_enable,
-	     unsigned char pll_filter_value)
-{
-	struct dvi_ctrl_device *current_dvi_ctrl;
-
-	current_dvi_ctrl = dcft_supported_dvi_controller;
-	if (current_dvi_ctrl->init) {
-		return current_dvi_ctrl->init(edge_select,
-					      bus_select,
-					      dual_edge_clk_select,
-					      hsync_enable,
-					      vsync_enable,
-					      deskew_enable,
-					      deskew_setting,
-					      continuous_sync_enable,
-					      pll_filter_enable,
-					      pll_filter_value);
-	}
-	return -1; /* error */
-}
-
-#endif
diff --git a/drivers/staging/sm750fb/ddk750_dvi.h b/drivers/staging/sm750fb/ddk750_dvi.h
deleted file mode 100644
index c2518b73bdbd..000000000000
--- a/drivers/staging/sm750fb/ddk750_dvi.h
+++ /dev/null
@@ -1,57 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef DDK750_DVI_H__
-#define DDK750_DVI_H__
-
-/* dvi chip stuffs structros */
-
-typedef long (*PFN_DVICTRL_INIT)(unsigned char edge_select,
-				 unsigned char bus_select,
-				 unsigned char dual_edge_clk_select,
-				 unsigned char hsync_enable,
-				 unsigned char vsync_enable,
-				 unsigned char deskew_enable,
-				 unsigned char deskew_setting,
-				 unsigned char continuous_sync_enable,
-				 unsigned char pll_filter_enable,
-				 unsigned char pll_filter_value);
-
-typedef void (*PFN_DVICTRL_RESETCHIP)(void);
-typedef char* (*PFN_DVICTRL_GETCHIPSTRING)(void);
-typedef unsigned short (*PFN_DVICTRL_GETVENDORID)(void);
-typedef unsigned short (*PFN_DVICTRL_GETDEVICEID)(void);
-typedef void (*PFN_DVICTRL_SETPOWER)(unsigned char power_up);
-typedef void (*PFN_DVICTRL_HOTPLUGDETECTION)(unsigned char enable_hot_plug);
-typedef unsigned char (*PFN_DVICTRL_ISCONNECTED)(void);
-typedef unsigned char (*PFN_DVICTRL_CHECKINTERRUPT)(void);
-typedef void (*PFN_DVICTRL_CLEARINTERRUPT)(void);
-
-/* Structure to hold all the function pointer to the DVI Controller. */
-struct dvi_ctrl_device {
-	PFN_DVICTRL_INIT		init;
-	PFN_DVICTRL_RESETCHIP		reset_chip;
-	PFN_DVICTRL_GETCHIPSTRING	get_chip_string;
-	PFN_DVICTRL_GETVENDORID		get_vendor_id;
-	PFN_DVICTRL_GETDEVICEID		get_device_id;
-	PFN_DVICTRL_SETPOWER		set_power;
-	PFN_DVICTRL_HOTPLUGDETECTION	enable_hot_plug_detection;
-	PFN_DVICTRL_ISCONNECTED		is_connected;
-	PFN_DVICTRL_CHECKINTERRUPT	check_interrupt;
-	PFN_DVICTRL_CLEARINTERRUPT	clear_interrupt;
-};
-
-#define DVI_CTRL_SII164
-
-/* dvi functions prototype */
-int dvi_init(unsigned char edge_select,
-	     unsigned char bus_select,
-	     unsigned char dual_edge_clk_select,
-	     unsigned char hsync_enable,
-	     unsigned char vsync_enable,
-	     unsigned char deskew_enable,
-	     unsigned char deskew_setting,
-	     unsigned char continuous_sync_enable,
-	     unsigned char pll_filter_enable,
-	     unsigned char pll_filter_value);
-
-#endif
-
-- 
2.48.1


