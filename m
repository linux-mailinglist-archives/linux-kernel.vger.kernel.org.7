Return-Path: <linux-kernel+bounces-622263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1643A9E508
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 00:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C59E7A9BAD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Apr 2025 22:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405FC1FE457;
	Sun, 27 Apr 2025 22:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="TwxtJISQ"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B142746A
	for <linux-kernel@vger.kernel.org>; Sun, 27 Apr 2025 22:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745793634; cv=none; b=HtbX0oo6I322avi9De5TU/gsg0qS3Xlk4pnw+sMfFD8H5Xdu8Ngk8B/XOoWS8vH4tOiJdyanMaVz92WE0bBwzhiPb40FKZh1n4rNAG3BTGmfBH9W4WwXn+y/yvthRlfPr3dwmwH3AqBum2MckJTGgmp7R/eUnUMEnLZgY5fIFAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745793634; c=relaxed/simple;
	bh=i6OK7Re3CRM5SayhshWLFwhHgqtAKryNgoELL3NRCUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E6zPOCkzswKs/CprVM4Busj92mpQLTaZ/15DpdJNxq1n4YoNSSo+WIapcIHTX9osMSmHEEsQN8t6LuhMtkEDusK/KqIVmeM+1fQv7+UDwmFw1uc+zyyTsyNh3axddHaiVfp1rTlg2m58WV0MJFGIe6l2zh4LcMz2IvdZqU5GKrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=TwxtJISQ; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=VQnIlzGUn6l8ALlra2xl+HE5Uetoiq4WE/Wz6WSagY8=; b=TwxtJISQyTIPFYDP
	JPTvP281pJJb0YsngfEPEZ4q+lLJ/Q8fSdj4Sv0UWDBQ0Z1HQ4dwy6pOak/DWE5VEdDC16s4PKivO
	cKS/6Mp3Y27oskDBMxusqK0XRfd3G+aS7+uHhheh3oZlR/W7Os8qMowNKlsgN0JkMd0+4Ddj4309R
	aDAv2FE5+s+MdIrpUkzvH5QI+skdQWT+nheflHAQEj2mk5C7brzcINCg1yp+xb70YtwzsDQAadbxi
	HncNa5F+ov8koyPt/PfvB11QlupEdJ72/V3qCR0ZgD5W+YjcxPHM1uxCif+EAr+oV1LJNyhimnvkm
	ss0M+J2rXqqu21YF2w==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1u9Aff-0001Oz-0F;
	Sun, 27 Apr 2025 22:40:23 +0000
From: linux@treblig.org
To: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	laforge@gnumonks.org
Cc: tzafrir@cohens.org.il,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] misc: echo: Remove
Date: Sun, 27 Apr 2025 23:40:22 +0100
Message-ID: <20250427224022.113678-1-linux@treblig.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'echo' is a software echo canceller for telco use, however
it's not used in the kernel at all.

Remove it.

It was moved from staging in 2014 by
commit Fixes: 6e2055a9e56e ("staging: echo: move to drivers/misc/")

Some discussion on lkml:
  https://lore.kernel.org/all/Z7tZhYET41DAoHVf@gallifrey/
with Arnd and Harald, led to the 'dahdi' package which is part of
Asterisk:

  https://gitea.osmocom.org/retronetworking/dahdi-linux

which can build with the 'echo' module, but is normally configured
with out it.
Dahdi is large, old, only lightly maintained and with a big API, so
there's no hope now of ever merging it into the main kernel tree.

Debian do package Dahdi, and in their package they actually include
a copy of the 'echo' module rather than using the kernel from the
upstream kernel.  So even in the few cases where it is packaged
and built, the kernel copy isn't used.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/misc/Kconfig       |   1 -
 drivers/misc/Makefile      |   1 -
 drivers/misc/echo/Kconfig  |   9 -
 drivers/misc/echo/Makefile |   2 -
 drivers/misc/echo/echo.c   | 589 -------------------------------------
 drivers/misc/echo/echo.h   | 175 -----------
 drivers/misc/echo/fir.h    | 154 ----------
 drivers/misc/echo/oslec.h  |  81 -----
 8 files changed, 1012 deletions(-)
 delete mode 100644 drivers/misc/echo/Kconfig
 delete mode 100644 drivers/misc/echo/Makefile
 delete mode 100644 drivers/misc/echo/echo.c
 delete mode 100644 drivers/misc/echo/echo.h
 delete mode 100644 drivers/misc/echo/fir.h
 delete mode 100644 drivers/misc/echo/oslec.h

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 6b37d61150ee..052ab185f876 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -640,7 +640,6 @@ source "drivers/misc/altera-stapl/Kconfig"
 source "drivers/misc/mei/Kconfig"
 source "drivers/misc/vmw_vmci/Kconfig"
 source "drivers/misc/genwqe/Kconfig"
-source "drivers/misc/echo/Kconfig"
 source "drivers/misc/ocxl/Kconfig"
 source "drivers/misc/bcm-vk/Kconfig"
 source "drivers/misc/cardreader/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index d6c917229c45..0b601e6404e1 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -49,7 +49,6 @@ obj-$(CONFIG_LATTICE_ECP3_CONFIG)	+= lattice-ecp3-config.o
 obj-$(CONFIG_SRAM)		+= sram.o
 obj-$(CONFIG_SRAM_EXEC)		+= sram-exec.o
 obj-$(CONFIG_GENWQE)		+= genwqe/
-obj-$(CONFIG_ECHO)		+= echo/
 obj-$(CONFIG_DW_XDATA_PCIE)	+= dw-xdata-pcie.o
 obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
 obj-$(CONFIG_OCXL)		+= ocxl/
diff --git a/drivers/misc/echo/Kconfig b/drivers/misc/echo/Kconfig
deleted file mode 100644
index ce0a37a47fc1..000000000000
--- a/drivers/misc/echo/Kconfig
+++ /dev/null
@@ -1,9 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-config ECHO
-	tristate "Line Echo Canceller support"
-	help
-	  This driver provides line echo cancelling support for mISDN and
-	  Zaptel drivers.
-
-	  To compile this driver as a module, choose M here. The module
-	  will be called echo.
diff --git a/drivers/misc/echo/Makefile b/drivers/misc/echo/Makefile
deleted file mode 100644
index 5b97467ffb7d..000000000000
--- a/drivers/misc/echo/Makefile
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_ECHO) += echo.o
diff --git a/drivers/misc/echo/echo.c b/drivers/misc/echo/echo.c
deleted file mode 100644
index 3c4eaba86576..000000000000
--- a/drivers/misc/echo/echo.c
+++ /dev/null
@@ -1,589 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * SpanDSP - a series of DSP components for telephony
- *
- * echo.c - A line echo canceller.  This code is being developed
- *          against and partially complies with G168.
- *
- * Written by Steve Underwood <steveu@coppice.org>
- *         and David Rowe <david_at_rowetel_dot_com>
- *
- * Copyright (C) 2001, 2003 Steve Underwood, 2007 David Rowe
- *
- * Based on a bit from here, a bit from there, eye of toad, ear of
- * bat, 15 years of failed attempts by David and a few fried brain
- * cells.
- *
- * All rights reserved.
- */
-
-/*! \file */
-
-/* Implementation Notes
-   David Rowe
-   April 2007
-
-   This code started life as Steve's NLMS algorithm with a tap
-   rotation algorithm to handle divergence during double talk.  I
-   added a Geigel Double Talk Detector (DTD) [2] and performed some
-   G168 tests.  However I had trouble meeting the G168 requirements,
-   especially for double talk - there were always cases where my DTD
-   failed, for example where near end speech was under the 6dB
-   threshold required for declaring double talk.
-
-   So I tried a two path algorithm [1], which has so far given better
-   results.  The original tap rotation/Geigel algorithm is available
-   in SVN http://svn.rowetel.com/software/oslec/tags/before_16bit.
-   It's probably possible to make it work if some one wants to put some
-   serious work into it.
-
-   At present no special treatment is provided for tones, which
-   generally cause NLMS algorithms to diverge.  Initial runs of a
-   subset of the G168 tests for tones (e.g ./echo_test 6) show the
-   current algorithm is passing OK, which is kind of surprising.  The
-   full set of tests needs to be performed to confirm this result.
-
-   One other interesting change is that I have managed to get the NLMS
-   code to work with 16 bit coefficients, rather than the original 32
-   bit coefficents.  This reduces the MIPs and storage required.
-   I evaulated the 16 bit port using g168_tests.sh and listening tests
-   on 4 real-world samples.
-
-   I also attempted the implementation of a block based NLMS update
-   [2] but although this passes g168_tests.sh it didn't converge well
-   on the real-world samples.  I have no idea why, perhaps a scaling
-   problem.  The block based code is also available in SVN
-   http://svn.rowetel.com/software/oslec/tags/before_16bit.  If this
-   code can be debugged, it will lead to further reduction in MIPS, as
-   the block update code maps nicely onto DSP instruction sets (it's a
-   dot product) compared to the current sample-by-sample update.
-
-   Steve also has some nice notes on echo cancellers in echo.h
-
-   References:
-
-   [1] Ochiai, Areseki, and Ogihara, "Echo Canceller with Two Echo
-       Path Models", IEEE Transactions on communications, COM-25,
-       No. 6, June
-       1977.
-       https://www.rowetel.com/images/echo/dual_path_paper.pdf
-
-   [2] The classic, very useful paper that tells you how to
-       actually build a real world echo canceller:
-	 Messerschmitt, Hedberg, Cole, Haoui, Winship, "Digital Voice
-	 Echo Canceller with a TMS320020,
-	 https://www.rowetel.com/images/echo/spra129.pdf
-
-   [3] I have written a series of blog posts on this work, here is
-       Part 1: http://www.rowetel.com/blog/?p=18
-
-   [4] The source code http://svn.rowetel.com/software/oslec/
-
-   [5] A nice reference on LMS filters:
-	 https://en.wikipedia.org/wiki/Least_mean_squares_filter
-
-   Credits:
-
-   Thanks to Steve Underwood, Jean-Marc Valin, and Ramakrishnan
-   Muthukrishnan for their suggestions and email discussions.  Thanks
-   also to those people who collected echo samples for me such as
-   Mark, Pawel, and Pavel.
-*/
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/slab.h>
-
-#include "echo.h"
-
-#define MIN_TX_POWER_FOR_ADAPTION	64
-#define MIN_RX_POWER_FOR_ADAPTION	64
-#define DTD_HANGOVER			600	/* 600 samples, or 75ms     */
-#define DC_LOG2BETA			3	/* log2() of DC filter Beta */
-
-/* adapting coeffs using the traditional stochastic descent (N)LMS algorithm */
-
-static inline void lms_adapt_bg(struct oslec_state *ec, int clean, int shift)
-{
-	int i;
-
-	int offset1;
-	int offset2;
-	int factor;
-	int exp;
-
-	if (shift > 0)
-		factor = clean << shift;
-	else
-		factor = clean >> -shift;
-
-	/* Update the FIR taps */
-
-	offset2 = ec->curr_pos;
-	offset1 = ec->taps - offset2;
-
-	for (i = ec->taps - 1; i >= offset1; i--) {
-		exp = (ec->fir_state_bg.history[i - offset1] * factor);
-		ec->fir_taps16[1][i] += (int16_t) ((exp + (1 << 14)) >> 15);
-	}
-	for (; i >= 0; i--) {
-		exp = (ec->fir_state_bg.history[i + offset2] * factor);
-		ec->fir_taps16[1][i] += (int16_t) ((exp + (1 << 14)) >> 15);
-	}
-}
-
-static inline int top_bit(unsigned int bits)
-{
-	if (bits == 0)
-		return -1;
-	else
-		return (int)fls((int32_t) bits) - 1;
-}
-
-struct oslec_state *oslec_create(int len, int adaption_mode)
-{
-	struct oslec_state *ec;
-	int i;
-	const int16_t *history;
-
-	ec = kzalloc(sizeof(*ec), GFP_KERNEL);
-	if (!ec)
-		return NULL;
-
-	ec->taps = len;
-	ec->log2taps = top_bit(len);
-	ec->curr_pos = ec->taps - 1;
-
-	ec->fir_taps16[0] =
-	    kcalloc(ec->taps, sizeof(int16_t), GFP_KERNEL);
-	if (!ec->fir_taps16[0])
-		goto error_oom_0;
-
-	ec->fir_taps16[1] =
-	    kcalloc(ec->taps, sizeof(int16_t), GFP_KERNEL);
-	if (!ec->fir_taps16[1])
-		goto error_oom_1;
-
-	history = fir16_create(&ec->fir_state, ec->fir_taps16[0], ec->taps);
-	if (!history)
-		goto error_state;
-	history = fir16_create(&ec->fir_state_bg, ec->fir_taps16[1], ec->taps);
-	if (!history)
-		goto error_state_bg;
-
-	for (i = 0; i < 5; i++)
-		ec->xvtx[i] = ec->yvtx[i] = ec->xvrx[i] = ec->yvrx[i] = 0;
-
-	ec->cng_level = 1000;
-	oslec_adaption_mode(ec, adaption_mode);
-
-	ec->snapshot = kcalloc(ec->taps, sizeof(int16_t), GFP_KERNEL);
-	if (!ec->snapshot)
-		goto error_snap;
-
-	ec->cond_met = 0;
-	ec->pstates = 0;
-	ec->ltxacc = ec->lrxacc = ec->lcleanacc = ec->lclean_bgacc = 0;
-	ec->ltx = ec->lrx = ec->lclean = ec->lclean_bg = 0;
-	ec->tx_1 = ec->tx_2 = ec->rx_1 = ec->rx_2 = 0;
-	ec->lbgn = ec->lbgn_acc = 0;
-	ec->lbgn_upper = 200;
-	ec->lbgn_upper_acc = ec->lbgn_upper << 13;
-
-	return ec;
-
-error_snap:
-	fir16_free(&ec->fir_state_bg);
-error_state_bg:
-	fir16_free(&ec->fir_state);
-error_state:
-	kfree(ec->fir_taps16[1]);
-error_oom_1:
-	kfree(ec->fir_taps16[0]);
-error_oom_0:
-	kfree(ec);
-	return NULL;
-}
-EXPORT_SYMBOL_GPL(oslec_create);
-
-void oslec_free(struct oslec_state *ec)
-{
-	int i;
-
-	fir16_free(&ec->fir_state);
-	fir16_free(&ec->fir_state_bg);
-	for (i = 0; i < 2; i++)
-		kfree(ec->fir_taps16[i]);
-	kfree(ec->snapshot);
-	kfree(ec);
-}
-EXPORT_SYMBOL_GPL(oslec_free);
-
-void oslec_adaption_mode(struct oslec_state *ec, int adaption_mode)
-{
-	ec->adaption_mode = adaption_mode;
-}
-EXPORT_SYMBOL_GPL(oslec_adaption_mode);
-
-void oslec_flush(struct oslec_state *ec)
-{
-	int i;
-
-	ec->ltxacc = ec->lrxacc = ec->lcleanacc = ec->lclean_bgacc = 0;
-	ec->ltx = ec->lrx = ec->lclean = ec->lclean_bg = 0;
-	ec->tx_1 = ec->tx_2 = ec->rx_1 = ec->rx_2 = 0;
-
-	ec->lbgn = ec->lbgn_acc = 0;
-	ec->lbgn_upper = 200;
-	ec->lbgn_upper_acc = ec->lbgn_upper << 13;
-
-	ec->nonupdate_dwell = 0;
-
-	fir16_flush(&ec->fir_state);
-	fir16_flush(&ec->fir_state_bg);
-	ec->fir_state.curr_pos = ec->taps - 1;
-	ec->fir_state_bg.curr_pos = ec->taps - 1;
-	for (i = 0; i < 2; i++)
-		memset(ec->fir_taps16[i], 0, ec->taps * sizeof(int16_t));
-
-	ec->curr_pos = ec->taps - 1;
-	ec->pstates = 0;
-}
-EXPORT_SYMBOL_GPL(oslec_flush);
-
-void oslec_snapshot(struct oslec_state *ec)
-{
-	memcpy(ec->snapshot, ec->fir_taps16[0], ec->taps * sizeof(int16_t));
-}
-EXPORT_SYMBOL_GPL(oslec_snapshot);
-
-/* Dual Path Echo Canceller */
-
-int16_t oslec_update(struct oslec_state *ec, int16_t tx, int16_t rx)
-{
-	int32_t echo_value;
-	int clean_bg;
-	int tmp;
-	int tmp1;
-
-	/*
-	 * Input scaling was found be required to prevent problems when tx
-	 * starts clipping.  Another possible way to handle this would be the
-	 * filter coefficent scaling.
-	 */
-
-	ec->tx = tx;
-	ec->rx = rx;
-	tx >>= 1;
-	rx >>= 1;
-
-	/*
-	 * Filter DC, 3dB point is 160Hz (I think), note 32 bit precision
-	 * required otherwise values do not track down to 0. Zero at DC, Pole
-	 * at (1-Beta) on real axis.  Some chip sets (like Si labs) don't
-	 * need this, but something like a $10 X100P card does.  Any DC really
-	 * slows down convergence.
-	 *
-	 * Note: removes some low frequency from the signal, this reduces the
-	 * speech quality when listening to samples through headphones but may
-	 * not be obvious through a telephone handset.
-	 *
-	 * Note that the 3dB frequency in radians is approx Beta, e.g. for Beta
-	 * = 2^(-3) = 0.125, 3dB freq is 0.125 rads = 159Hz.
-	 */
-
-	if (ec->adaption_mode & ECHO_CAN_USE_RX_HPF) {
-		tmp = rx << 15;
-
-		/*
-		 * Make sure the gain of the HPF is 1.0. This can still
-		 * saturate a little under impulse conditions, and it might
-		 * roll to 32768 and need clipping on sustained peak level
-		 * signals. However, the scale of such clipping is small, and
-		 * the error due to any saturation should not markedly affect
-		 * the downstream processing.
-		 */
-		tmp -= (tmp >> 4);
-
-		ec->rx_1 += -(ec->rx_1 >> DC_LOG2BETA) + tmp - ec->rx_2;
-
-		/*
-		 * hard limit filter to prevent clipping.  Note that at this
-		 * stage rx should be limited to +/- 16383 due to right shift
-		 * above
-		 */
-		tmp1 = ec->rx_1 >> 15;
-		if (tmp1 > 16383)
-			tmp1 = 16383;
-		if (tmp1 < -16383)
-			tmp1 = -16383;
-		rx = tmp1;
-		ec->rx_2 = tmp;
-	}
-
-	/* Block average of power in the filter states.  Used for
-	   adaption power calculation. */
-
-	{
-		int new, old;
-
-		/* efficient "out with the old and in with the new" algorithm so
-		   we don't have to recalculate over the whole block of
-		   samples. */
-		new = (int)tx * (int)tx;
-		old = (int)ec->fir_state.history[ec->fir_state.curr_pos] *
-		    (int)ec->fir_state.history[ec->fir_state.curr_pos];
-		ec->pstates +=
-		    ((new - old) + (1 << (ec->log2taps - 1))) >> ec->log2taps;
-		if (ec->pstates < 0)
-			ec->pstates = 0;
-	}
-
-	/* Calculate short term average levels using simple single pole IIRs */
-
-	ec->ltxacc += abs(tx) - ec->ltx;
-	ec->ltx = (ec->ltxacc + (1 << 4)) >> 5;
-	ec->lrxacc += abs(rx) - ec->lrx;
-	ec->lrx = (ec->lrxacc + (1 << 4)) >> 5;
-
-	/* Foreground filter */
-
-	ec->fir_state.coeffs = ec->fir_taps16[0];
-	echo_value = fir16(&ec->fir_state, tx);
-	ec->clean = rx - echo_value;
-	ec->lcleanacc += abs(ec->clean) - ec->lclean;
-	ec->lclean = (ec->lcleanacc + (1 << 4)) >> 5;
-
-	/* Background filter */
-
-	echo_value = fir16(&ec->fir_state_bg, tx);
-	clean_bg = rx - echo_value;
-	ec->lclean_bgacc += abs(clean_bg) - ec->lclean_bg;
-	ec->lclean_bg = (ec->lclean_bgacc + (1 << 4)) >> 5;
-
-	/* Background Filter adaption */
-
-	/* Almost always adap bg filter, just simple DT and energy
-	   detection to minimise adaption in cases of strong double talk.
-	   However this is not critical for the dual path algorithm.
-	 */
-	ec->factor = 0;
-	ec->shift = 0;
-	if (!ec->nonupdate_dwell) {
-		int p, logp, shift;
-
-		/* Determine:
-
-		   f = Beta * clean_bg_rx/P ------ (1)
-
-		   where P is the total power in the filter states.
-
-		   The Boffins have shown that if we obey (1) we converge
-		   quickly and avoid instability.
-
-		   The correct factor f must be in Q30, as this is the fixed
-		   point format required by the lms_adapt_bg() function,
-		   therefore the scaled version of (1) is:
-
-		   (2^30) * f  = (2^30) * Beta * clean_bg_rx/P
-		   factor      = (2^30) * Beta * clean_bg_rx/P     ----- (2)
-
-		   We have chosen Beta = 0.25 by experiment, so:
-
-		   factor      = (2^30) * (2^-2) * clean_bg_rx/P
-
-		   (30 - 2 - log2(P))
-		   factor      = clean_bg_rx 2                     ----- (3)
-
-		   To avoid a divide we approximate log2(P) as top_bit(P),
-		   which returns the position of the highest non-zero bit in
-		   P.  This approximation introduces an error as large as a
-		   factor of 2, but the algorithm seems to handle it OK.
-
-		   Come to think of it a divide may not be a big deal on a
-		   modern DSP, so its probably worth checking out the cycles
-		   for a divide versus a top_bit() implementation.
-		 */
-
-		p = MIN_TX_POWER_FOR_ADAPTION + ec->pstates;
-		logp = top_bit(p) + ec->log2taps;
-		shift = 30 - 2 - logp;
-		ec->shift = shift;
-
-		lms_adapt_bg(ec, clean_bg, shift);
-	}
-
-	/* very simple DTD to make sure we dont try and adapt with strong
-	   near end speech */
-
-	ec->adapt = 0;
-	if ((ec->lrx > MIN_RX_POWER_FOR_ADAPTION) && (ec->lrx > ec->ltx))
-		ec->nonupdate_dwell = DTD_HANGOVER;
-	if (ec->nonupdate_dwell)
-		ec->nonupdate_dwell--;
-
-	/* Transfer logic */
-
-	/* These conditions are from the dual path paper [1], I messed with
-	   them a bit to improve performance. */
-
-	if ((ec->adaption_mode & ECHO_CAN_USE_ADAPTION) &&
-	    (ec->nonupdate_dwell == 0) &&
-	    /* (ec->Lclean_bg < 0.875*ec->Lclean) */
-	    (8 * ec->lclean_bg < 7 * ec->lclean) &&
-	    /* (ec->Lclean_bg < 0.125*ec->Ltx) */
-	    (8 * ec->lclean_bg < ec->ltx)) {
-		if (ec->cond_met == 6) {
-			/*
-			 * BG filter has had better results for 6 consecutive
-			 * samples
-			 */
-			ec->adapt = 1;
-			memcpy(ec->fir_taps16[0], ec->fir_taps16[1],
-			       ec->taps * sizeof(int16_t));
-		} else
-			ec->cond_met++;
-	} else
-		ec->cond_met = 0;
-
-	/* Non-Linear Processing */
-
-	ec->clean_nlp = ec->clean;
-	if (ec->adaption_mode & ECHO_CAN_USE_NLP) {
-		/*
-		 * Non-linear processor - a fancy way to say "zap small
-		 * signals, to avoid residual echo due to (uLaw/ALaw)
-		 * non-linearity in the channel.".
-		 */
-
-		if ((16 * ec->lclean < ec->ltx)) {
-			/*
-			 * Our e/c has improved echo by at least 24 dB (each
-			 * factor of 2 is 6dB, so 2*2*2*2=16 is the same as
-			 * 6+6+6+6=24dB)
-			 */
-			if (ec->adaption_mode & ECHO_CAN_USE_CNG) {
-				ec->cng_level = ec->lbgn;
-
-				/*
-				 * Very elementary comfort noise generation.
-				 * Just random numbers rolled off very vaguely
-				 * Hoth-like.  DR: This noise doesn't sound
-				 * quite right to me - I suspect there are some
-				 * overflow issues in the filtering as it's too
-				 * "crackly".
-				 * TODO: debug this, maybe just play noise at
-				 * high level or look at spectrum.
-				 */
-
-				ec->cng_rndnum =
-				    1664525U * ec->cng_rndnum + 1013904223U;
-				ec->cng_filter =
-				    ((ec->cng_rndnum & 0xFFFF) - 32768 +
-				     5 * ec->cng_filter) >> 3;
-				ec->clean_nlp =
-				    (ec->cng_filter * ec->cng_level * 8) >> 14;
-
-			} else if (ec->adaption_mode & ECHO_CAN_USE_CLIP) {
-				/* This sounds much better than CNG */
-				if (ec->clean_nlp > ec->lbgn)
-					ec->clean_nlp = ec->lbgn;
-				if (ec->clean_nlp < -ec->lbgn)
-					ec->clean_nlp = -ec->lbgn;
-			} else {
-				/*
-				 * just mute the residual, doesn't sound very
-				 * good, used mainly in G168 tests
-				 */
-				ec->clean_nlp = 0;
-			}
-		} else {
-			/*
-			 * Background noise estimator.  I tried a few
-			 * algorithms here without much luck.  This very simple
-			 * one seems to work best, we just average the level
-			 * using a slow (1 sec time const) filter if the
-			 * current level is less than a (experimentally
-			 * derived) constant.  This means we dont include high
-			 * level signals like near end speech.  When combined
-			 * with CNG or especially CLIP seems to work OK.
-			 */
-			if (ec->lclean < 40) {
-				ec->lbgn_acc += abs(ec->clean) - ec->lbgn;
-				ec->lbgn = (ec->lbgn_acc + (1 << 11)) >> 12;
-			}
-		}
-	}
-
-	/* Roll around the taps buffer */
-	if (ec->curr_pos <= 0)
-		ec->curr_pos = ec->taps;
-	ec->curr_pos--;
-
-	if (ec->adaption_mode & ECHO_CAN_DISABLE)
-		ec->clean_nlp = rx;
-
-	/* Output scaled back up again to match input scaling */
-
-	return (int16_t) ec->clean_nlp << 1;
-}
-EXPORT_SYMBOL_GPL(oslec_update);
-
-/* This function is separated from the echo canceller is it is usually called
-   as part of the tx process.  See rx HP (DC blocking) filter above, it's
-   the same design.
-
-   Some soft phones send speech signals with a lot of low frequency
-   energy, e.g. down to 20Hz.  This can make the hybrid non-linear
-   which causes the echo canceller to fall over.  This filter can help
-   by removing any low frequency before it gets to the tx port of the
-   hybrid.
-
-   It can also help by removing and DC in the tx signal.  DC is bad
-   for LMS algorithms.
-
-   This is one of the classic DC removal filters, adjusted to provide
-   sufficient bass rolloff to meet the above requirement to protect hybrids
-   from things that upset them. The difference between successive samples
-   produces a lousy HPF, and then a suitably placed pole flattens things out.
-   The final result is a nicely rolled off bass end. The filtering is
-   implemented with extended fractional precision, which noise shapes things,
-   giving very clean DC removal.
-*/
-
-int16_t oslec_hpf_tx(struct oslec_state *ec, int16_t tx)
-{
-	int tmp;
-	int tmp1;
-
-	if (ec->adaption_mode & ECHO_CAN_USE_TX_HPF) {
-		tmp = tx << 15;
-
-		/*
-		 * Make sure the gain of the HPF is 1.0. The first can still
-		 * saturate a little under impulse conditions, and it might
-		 * roll to 32768 and need clipping on sustained peak level
-		 * signals. However, the scale of such clipping is small, and
-		 * the error due to any saturation should not markedly affect
-		 * the downstream processing.
-		 */
-		tmp -= (tmp >> 4);
-
-		ec->tx_1 += -(ec->tx_1 >> DC_LOG2BETA) + tmp - ec->tx_2;
-		tmp1 = ec->tx_1 >> 15;
-		if (tmp1 > 32767)
-			tmp1 = 32767;
-		if (tmp1 < -32767)
-			tmp1 = -32767;
-		tx = tmp1;
-		ec->tx_2 = tmp;
-	}
-
-	return tx;
-}
-EXPORT_SYMBOL_GPL(oslec_hpf_tx);
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("David Rowe");
-MODULE_DESCRIPTION("Open Source Line Echo Canceller");
-MODULE_VERSION("0.3.0");
diff --git a/drivers/misc/echo/echo.h b/drivers/misc/echo/echo.h
deleted file mode 100644
index 56b4b95fd020..000000000000
--- a/drivers/misc/echo/echo.h
+++ /dev/null
@@ -1,175 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * SpanDSP - a series of DSP components for telephony
- *
- * echo.c - A line echo canceller.  This code is being developed
- *          against and partially complies with G168.
- *
- * Written by Steve Underwood <steveu@coppice.org>
- *         and David Rowe <david_at_rowetel_dot_com>
- *
- * Copyright (C) 2001 Steve Underwood and 2007 David Rowe
- *
- * All rights reserved.
- */
-
-#ifndef __ECHO_H
-#define __ECHO_H
-
-/*
-Line echo cancellation for voice
-
-What does it do?
-
-This module aims to provide G.168-2002 compliant echo cancellation, to remove
-electrical echoes (e.g. from 2-4 wire hybrids) from voice calls.
-
-How does it work?
-
-The heart of the echo cancellor is FIR filter. This is adapted to match the
-echo impulse response of the telephone line. It must be long enough to
-adequately cover the duration of that impulse response. The signal transmitted
-to the telephone line is passed through the FIR filter. Once the FIR is
-properly adapted, the resulting output is an estimate of the echo signal
-received from the line. This is subtracted from the received signal. The result
-is an estimate of the signal which originated at the far end of the line, free
-from echos of our own transmitted signal.
-
-The least mean squares (LMS) algorithm is attributed to Widrow and Hoff, and
-was introduced in 1960. It is the commonest form of filter adaption used in
-things like modem line equalisers and line echo cancellers. There it works very
-well.  However, it only works well for signals of constant amplitude. It works
-very poorly for things like speech echo cancellation, where the signal level
-varies widely.  This is quite easy to fix. If the signal level is normalised -
-similar to applying AGC - LMS can work as well for a signal of varying
-amplitude as it does for a modem signal. This normalised least mean squares
-(NLMS) algorithm is the commonest one used for speech echo cancellation. Many
-other algorithms exist - e.g. RLS (essentially the same as Kalman filtering),
-FAP, etc. Some perform significantly better than NLMS.  However, factors such
-as computational complexity and patents favour the use of NLMS.
-
-A simple refinement to NLMS can improve its performance with speech. NLMS tends
-to adapt best to the strongest parts of a signal. If the signal is white noise,
-the NLMS algorithm works very well. However, speech has more low frequency than
-high frequency content. Pre-whitening (i.e. filtering the signal to flatten its
-spectrum) the echo signal improves the adapt rate for speech, and ensures the
-final residual signal is not heavily biased towards high frequencies. A very
-low complexity filter is adequate for this, so pre-whitening adds little to the
-compute requirements of the echo canceller.
-
-An FIR filter adapted using pre-whitened NLMS performs well, provided certain
-conditions are met:
-
-    - The transmitted signal has poor self-correlation.
-    - There is no signal being generated within the environment being
-      cancelled.
-
-The difficulty is that neither of these can be guaranteed.
-
-If the adaption is performed while transmitting noise (or something fairly
-noise like, such as voice) the adaption works very well. If the adaption is
-performed while transmitting something highly correlative (typically narrow
-band energy such as signalling tones or DTMF), the adaption can go seriously
-wrong. The reason is there is only one solution for the adaption on a near
-random signal - the impulse response of the line. For a repetitive signal,
-there are any number of solutions which converge the adaption, and nothing
-guides the adaption to choose the generalised one. Allowing an untrained
-canceller to converge on this kind of narrowband energy probably a good thing,
-since at least it cancels the tones. Allowing a well converged canceller to
-continue converging on such energy is just a way to ruin its generalised
-adaption. A narrowband detector is needed, so adapation can be suspended at
-appropriate times.
-
-The adaption process is based on trying to eliminate the received signal. When
-there is any signal from within the environment being cancelled it may upset
-the adaption process. Similarly, if the signal we are transmitting is small,
-noise may dominate and disturb the adaption process. If we can ensure that the
-adaption is only performed when we are transmitting a significant signal level,
-and the environment is not, things will be OK. Clearly, it is easy to tell when
-we are sending a significant signal. Telling, if the environment is generating
-a significant signal, and doing it with sufficient speed that the adaption will
-not have diverged too much more we stop it, is a little harder.
-
-The key problem in detecting when the environment is sourcing significant
-energy is that we must do this very quickly. Given a reasonably long sample of
-the received signal, there are a number of strategies which may be used to
-assess whether that signal contains a strong far end component. However, by the
-time that assessment is complete the far end signal will have already caused
-major mis-convergence in the adaption process. An assessment algorithm is
-needed which produces a fairly accurate result from a very short burst of far
-end energy.
-
-How do I use it?
-
-The echo cancellor processes both the transmit and receive streams sample by
-sample. The processing function is not declared inline. Unfortunately,
-cancellation requires many operations per sample, so the call overhead is only
-a minor burden.
-*/
-
-#include "fir.h"
-#include "oslec.h"
-
-/*
-    G.168 echo canceller descriptor. This defines the working state for a line
-    echo canceller.
-*/
-struct oslec_state {
-	int16_t tx;
-	int16_t rx;
-	int16_t clean;
-	int16_t clean_nlp;
-
-	int nonupdate_dwell;
-	int curr_pos;
-	int taps;
-	int log2taps;
-	int adaption_mode;
-
-	int cond_met;
-	int32_t pstates;
-	int16_t adapt;
-	int32_t factor;
-	int16_t shift;
-
-	/* Average levels and averaging filter states */
-	int ltxacc;
-	int lrxacc;
-	int lcleanacc;
-	int lclean_bgacc;
-	int ltx;
-	int lrx;
-	int lclean;
-	int lclean_bg;
-	int lbgn;
-	int lbgn_acc;
-	int lbgn_upper;
-	int lbgn_upper_acc;
-
-	/* foreground and background filter states */
-	struct fir16_state_t fir_state;
-	struct fir16_state_t fir_state_bg;
-	int16_t *fir_taps16[2];
-
-	/* DC blocking filter states */
-	int tx_1;
-	int tx_2;
-	int rx_1;
-	int rx_2;
-
-	/* optional High Pass Filter states */
-	int32_t xvtx[5];
-	int32_t yvtx[5];
-	int32_t xvrx[5];
-	int32_t yvrx[5];
-
-	/* Parameters for the optional Hoth noise generator */
-	int cng_level;
-	int cng_rndnum;
-	int cng_filter;
-
-	/* snapshot sample of coeffs used for development */
-	int16_t *snapshot;
-};
-
-#endif /* __ECHO_H */
diff --git a/drivers/misc/echo/fir.h b/drivers/misc/echo/fir.h
deleted file mode 100644
index 4d0821025223..000000000000
--- a/drivers/misc/echo/fir.h
+++ /dev/null
@@ -1,154 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * SpanDSP - a series of DSP components for telephony
- *
- * fir.h - General telephony FIR routines
- *
- * Written by Steve Underwood <steveu@coppice.org>
- *
- * Copyright (C) 2002 Steve Underwood
- *
- * All rights reserved.
- */
-
-#if !defined(_FIR_H_)
-#define _FIR_H_
-
-/*
-   Ideas for improvement:
-
-   1/ Rewrite filter for dual MAC inner loop.  The issue here is handling
-   history sample offsets that are 16 bit aligned - the dual MAC needs
-   32 bit aligmnent.  There are some good examples in libbfdsp.
-
-   2/ Use the hardware circular buffer facility tohalve memory usage.
-
-   3/ Consider using internal memory.
-
-   Using less memory might also improve speed as cache misses will be
-   reduced. A drop in MIPs and memory approaching 50% should be
-   possible.
-
-   The foreground and background filters currenlty use a total of
-   about 10 MIPs/ch as measured with speedtest.c on a 256 TAP echo
-   can.
-*/
-
-/*
- * 16 bit integer FIR descriptor. This defines the working state for a single
- * instance of an FIR filter using 16 bit integer coefficients.
- */
-struct fir16_state_t {
-	int taps;
-	int curr_pos;
-	const int16_t *coeffs;
-	int16_t *history;
-};
-
-/*
- * 32 bit integer FIR descriptor. This defines the working state for a single
- * instance of an FIR filter using 32 bit integer coefficients, and filtering
- * 16 bit integer data.
- */
-struct fir32_state_t {
-	int taps;
-	int curr_pos;
-	const int32_t *coeffs;
-	int16_t *history;
-};
-
-/*
- * Floating point FIR descriptor. This defines the working state for a single
- * instance of an FIR filter using floating point coefficients and data.
- */
-struct fir_float_state_t {
-	int taps;
-	int curr_pos;
-	const float *coeffs;
-	float *history;
-};
-
-static inline const int16_t *fir16_create(struct fir16_state_t *fir,
-					      const int16_t *coeffs, int taps)
-{
-	fir->taps = taps;
-	fir->curr_pos = taps - 1;
-	fir->coeffs = coeffs;
-	fir->history = kcalloc(taps, sizeof(int16_t), GFP_KERNEL);
-	return fir->history;
-}
-
-static inline void fir16_flush(struct fir16_state_t *fir)
-{
-	memset(fir->history, 0, fir->taps * sizeof(int16_t));
-}
-
-static inline void fir16_free(struct fir16_state_t *fir)
-{
-	kfree(fir->history);
-}
-
-static inline int16_t fir16(struct fir16_state_t *fir, int16_t sample)
-{
-	int32_t y;
-	int i;
-	int offset1;
-	int offset2;
-
-	fir->history[fir->curr_pos] = sample;
-
-	offset2 = fir->curr_pos;
-	offset1 = fir->taps - offset2;
-	y = 0;
-	for (i = fir->taps - 1; i >= offset1; i--)
-		y += fir->coeffs[i] * fir->history[i - offset1];
-	for (; i >= 0; i--)
-		y += fir->coeffs[i] * fir->history[i + offset2];
-	if (fir->curr_pos <= 0)
-		fir->curr_pos = fir->taps;
-	fir->curr_pos--;
-	return (int16_t) (y >> 15);
-}
-
-static inline const int16_t *fir32_create(struct fir32_state_t *fir,
-					      const int32_t *coeffs, int taps)
-{
-	fir->taps = taps;
-	fir->curr_pos = taps - 1;
-	fir->coeffs = coeffs;
-	fir->history = kcalloc(taps, sizeof(int16_t), GFP_KERNEL);
-	return fir->history;
-}
-
-static inline void fir32_flush(struct fir32_state_t *fir)
-{
-	memset(fir->history, 0, fir->taps * sizeof(int16_t));
-}
-
-static inline void fir32_free(struct fir32_state_t *fir)
-{
-	kfree(fir->history);
-}
-
-static inline int16_t fir32(struct fir32_state_t *fir, int16_t sample)
-{
-	int i;
-	int32_t y;
-	int offset1;
-	int offset2;
-
-	fir->history[fir->curr_pos] = sample;
-	offset2 = fir->curr_pos;
-	offset1 = fir->taps - offset2;
-	y = 0;
-	for (i = fir->taps - 1; i >= offset1; i--)
-		y += fir->coeffs[i] * fir->history[i - offset1];
-	for (; i >= 0; i--)
-		y += fir->coeffs[i] * fir->history[i + offset2];
-	if (fir->curr_pos <= 0)
-		fir->curr_pos = fir->taps;
-	fir->curr_pos--;
-	return (int16_t) (y >> 15);
-}
-
-#endif
diff --git a/drivers/misc/echo/oslec.h b/drivers/misc/echo/oslec.h
deleted file mode 100644
index f1adac143b90..000000000000
--- a/drivers/misc/echo/oslec.h
+++ /dev/null
@@ -1,81 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- *  OSLEC - A line echo canceller.  This code is being developed
- *          against and partially complies with G168. Using code from SpanDSP
- *
- * Written by Steve Underwood <steveu@coppice.org>
- *         and David Rowe <david_at_rowetel_dot_com>
- *
- * Copyright (C) 2001 Steve Underwood and 2007-2008 David Rowe
- *
- * All rights reserved.
- */
-
-#ifndef __OSLEC_H
-#define __OSLEC_H
-
-/* Mask bits for the adaption mode */
-#define ECHO_CAN_USE_ADAPTION	0x01
-#define ECHO_CAN_USE_NLP	0x02
-#define ECHO_CAN_USE_CNG	0x04
-#define ECHO_CAN_USE_CLIP	0x08
-#define ECHO_CAN_USE_TX_HPF	0x10
-#define ECHO_CAN_USE_RX_HPF	0x20
-#define ECHO_CAN_DISABLE	0x40
-
-/**
- * oslec_state: G.168 echo canceller descriptor.
- *
- * This defines the working state for a line echo canceller.
- */
-struct oslec_state;
-
-/**
- * oslec_create - Create a voice echo canceller context.
- * @len: The length of the canceller, in samples.
- * @return: The new canceller context, or NULL if the canceller could not be
- * created.
- */
-struct oslec_state *oslec_create(int len, int adaption_mode);
-
-/**
- * oslec_free - Free a voice echo canceller context.
- * @ec: The echo canceller context.
- */
-void oslec_free(struct oslec_state *ec);
-
-/**
- * oslec_flush - Flush (reinitialise) a voice echo canceller context.
- * @ec: The echo canceller context.
- */
-void oslec_flush(struct oslec_state *ec);
-
-/**
- * oslec_adaption_mode - set the adaption mode of a voice echo canceller context.
- * @ec The echo canceller context.
- * @adaption_mode: The mode.
- */
-void oslec_adaption_mode(struct oslec_state *ec, int adaption_mode);
-
-void oslec_snapshot(struct oslec_state *ec);
-
-/**
- * oslec_update: Process a sample through a voice echo canceller.
- * @ec: The echo canceller context.
- * @tx: The transmitted audio sample.
- * @rx: The received audio sample.
- *
- * The return value is the clean (echo cancelled) received sample.
- */
-int16_t oslec_update(struct oslec_state *ec, int16_t tx, int16_t rx);
-
-/**
- * oslec_hpf_tx: Process to high pass filter the tx signal.
- * @ec: The echo canceller context.
- * @tx: The transmitted auio sample.
- *
- * The return value is the HP filtered transmit sample, send this to your D/A.
- */
-int16_t oslec_hpf_tx(struct oslec_state *ec, int16_t tx);
-
-#endif /* __OSLEC_H */
-- 
2.49.0


