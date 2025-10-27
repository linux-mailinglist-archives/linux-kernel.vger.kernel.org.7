Return-Path: <linux-kernel+bounces-871835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F75C0E7AD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B7EE42685E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E68E31062D;
	Mon, 27 Oct 2025 14:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="nH2Z6ve1"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B7130FC05;
	Mon, 27 Oct 2025 14:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575421; cv=none; b=JLfJsyJxfXdD0TjaJT+kGr3iuRraZZIPLbADS4Cfi9A1x0CVy4hd6Rgnr4xz6t6U3+ozX9YOnjth0NUoQ0yQrUVy1REgrjrWV9Kqaug0173GbpEFUqLyAnx4X0S14yPgilXvP7Bl+TM6ycxJc5TW01ECuOimdHfOgz6SF/skhe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575421; c=relaxed/simple;
	bh=cv0776wE6L6vPhc8LktMi48w4rk9xW8uMbBJVEPfQCQ=;
	h=From:To:Cc:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Subject; b=nutLAAjRjMuV8isSM1AUR8eMRBsmNxuWzj/H1lbzC8dv2fxG0zLwDQ4kHkLFCNoT3ggvIkdWen47orRMcaA03asnK09EZr1ZSdlgFtkd78R4KWhevUcwGeB+eYEVvdSB5rpub+59wK8AfigpLfTM4P+DZJlq5U/ajXHPAxiLdpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=nH2Z6ve1; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=U/M8bxS4SkUhlYmSY5BG8d9wjlgzoA0ZdMqi7Yz59NU=; b=nH2Z6ve18T6LXsebkCXKjGzXBc
	Fi81ta6lae3ef2lqWt2ojBDkV6nLRTGasZjBDBiL0o2Szvuj7RHR7ARQBrcIE8Vds2qCoUmOws31i
	vp65lFmVAACyQwiPJZShH5Hla5jRSuG/gN2PAeyajt6ne72h3PdWQYWKVFyXsnXSU1hc=;
Received: from [70.80.174.168] (port=45472 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1vDOEj-0007wg-A6; Mon, 27 Oct 2025 10:30:17 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Mon, 27 Oct 2025 10:29:55 -0400
Message-Id: <20251027142957.1032073-14-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251027142957.1032073-1-hugo@hugovil.com>
References: <20251027142957.1032073-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
Subject: [PATCH v3 13/14] serial: sc16is7xx: reformat comments to improve readability
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Fold some multi-line comments into a single line, taking advantage of the
new 100 line length limit to improve readability and to have uniform style
across driver.

Add missing 's' to SC16IS7XX_MCR_TCRTLR_BIT registers comments.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 121 +++++++++++----------------------
 1 file changed, 39 insertions(+), 82 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 3faf821b8b89d..4898b4235d0da 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -50,18 +50,10 @@
 #define SC16IS7XX_SPR_REG		(0x07) /* Scratch Pad */
 #define SC16IS7XX_TXLVL_REG		(0x08) /* TX FIFO level */
 #define SC16IS7XX_RXLVL_REG		(0x09) /* RX FIFO level */
-#define SC16IS7XX_IODIR_REG		(0x0a) /* I/O Direction
-						* - only on 75x/76x
-						*/
-#define SC16IS7XX_IOSTATE_REG		(0x0b) /* I/O State
-						* - only on 75x/76x
-						*/
-#define SC16IS7XX_IOINTENA_REG		(0x0c) /* I/O Interrupt Enable
-						* - only on 75x/76x
-						*/
-#define SC16IS7XX_IOCONTROL_REG		(0x0e) /* I/O Control
-						* - only on 75x/76x
-						*/
+#define SC16IS7XX_IODIR_REG		(0x0a) /* I/O Direction - only on 75x/76x */
+#define SC16IS7XX_IOSTATE_REG		(0x0b) /* I/O State - only on 75x/76x */
+#define SC16IS7XX_IOINTENA_REG		(0x0c) /* I/O Interrupt Enable - only on 75x/76x */
+#define SC16IS7XX_IOCONTROL_REG		(0x0e) /* I/O Control - only on 75x/76x */
 #define SC16IS7XX_EFCR_REG		(0x0f) /* Extra Features Control */
 
 /* TCR/TLR Register set: Only if ((MCR[2] == 1) && (EFR[4] == 1)) */
@@ -81,12 +73,9 @@
 
 /* IER register bits */
 #define SC16IS7XX_IER_RDI_BIT		BIT(0)   /* Enable RX data interrupt */
-#define SC16IS7XX_IER_THRI_BIT		BIT(1)   /* Enable TX holding register
-						  * interrupt */
-#define SC16IS7XX_IER_RLSI_BIT		BIT(2)   /* Enable RX line status
-						  * interrupt */
-#define SC16IS7XX_IER_MSI_BIT		BIT(3)   /* Enable Modem status
-						  * interrupt */
+#define SC16IS7XX_IER_THRI_BIT		BIT(1)   /* Enable TX holding register interrupt */
+#define SC16IS7XX_IER_RLSI_BIT		BIT(2)   /* Enable RX line status interrupt */
+#define SC16IS7XX_IER_MSI_BIT		BIT(3)   /* Enable Modem status interrupt */
 
 /* IER register bits - write only if (EFR[4] == 1) */
 #define SC16IS7XX_IER_SLEEP_BIT		BIT(4)   /* Enable Sleep mode */
@@ -119,9 +108,8 @@
 							 * - only on 75x/76x
 							 */
 #define SC16IS7XX_IIR_XOFFI_SRC		0x10		/* Received Xoff */
-#define SC16IS7XX_IIR_CTSRTS_SRC	0x20		/* nCTS,nRTS change of state
-							 * from active (LOW)
-							 * to inactive (HIGH)
+#define SC16IS7XX_IIR_CTSRTS_SRC	0x20		/* nCTS,nRTS change of state from active
+							 * (LOW) to inactive (HIGH)
 							 */
 /* LCR register bits */
 #define SC16IS7XX_LCR_LENGTH0_BIT	BIT(0)   /* Word length bit 0 */
@@ -137,8 +125,7 @@
 						  *
 						  * STOP length bit table:
 						  * 0 -> 1 stop bit
-						  * 1 -> 1-1.5 stop bits if
-						  *      word length is 5,
+						  * 1 -> 1-1.5 stop bits if word length is 5,
 						  *      2 stop bits otherwise
 						  */
 #define SC16IS7XX_LCR_PARITY_BIT	BIT(3)   /* Parity bit enable */
@@ -150,31 +137,22 @@
 #define SC16IS7XX_LCR_WORD_LEN_6	(0x01)
 #define SC16IS7XX_LCR_WORD_LEN_7	(0x02)
 #define SC16IS7XX_LCR_WORD_LEN_8	(0x03)
-#define SC16IS7XX_LCR_REG_SET_SPECIAL	SC16IS7XX_LCR_DLAB_BIT /* Special
-								* reg set
-								*/
-#define SC16IS7XX_LCR_REG_SET_ENHANCED	0xBF                   /* Enhanced
-								* reg set
-								*/
+#define SC16IS7XX_LCR_REG_SET_SPECIAL	SC16IS7XX_LCR_DLAB_BIT /* Special reg set */
+#define SC16IS7XX_LCR_REG_SET_ENHANCED	0xBF                   /* Enhanced reg set */
 
 /* MCR register bits */
-#define SC16IS7XX_MCR_DTR_BIT		BIT(0)   /* DTR complement
-						  * - only on 75x/76x
-						  */
+#define SC16IS7XX_MCR_DTR_BIT		BIT(0)   /* DTR complement - only on 75x/76x */
 #define SC16IS7XX_MCR_RTS_BIT		BIT(1)   /* RTS complement */
-#define SC16IS7XX_MCR_TCRTLR_BIT	BIT(2)   /* TCR/TLR register enable */
+#define SC16IS7XX_MCR_TCRTLR_BIT	BIT(2)   /* TCR/TLR registers enable */
 #define SC16IS7XX_MCR_LOOP_BIT		BIT(4)   /* Enable loopback test mode */
 #define SC16IS7XX_MCR_XONANY_BIT	BIT(5)   /* Enable Xon Any
-						  * - write enabled
-						  * if (EFR[4] == 1)
+						  * - write enabled if (EFR[4] == 1)
 						  */
 #define SC16IS7XX_MCR_IRDA_BIT		BIT(6)   /* Enable IrDA mode
-						  * - write enabled
-						  * if (EFR[4] == 1)
+						  * - write enabled if (EFR[4] == 1)
 						  */
 #define SC16IS7XX_MCR_CLKSEL_BIT	BIT(7)   /* Divide clock by 4
-						  * - write enabled
-						  * if (EFR[4] == 1)
+						  * - write enabled if (EFR[4] == 1)
 						  */
 
 /* LSR register bits */
@@ -195,28 +173,19 @@
 
 /* MSR register bits */
 #define SC16IS7XX_MSR_DCTS_BIT		BIT(0)   /* Delta CTS Clear To Send */
-#define SC16IS7XX_MSR_DDSR_BIT		BIT(1)   /* Delta DSR Data Set Ready
-						  * or (IO4)
+#define SC16IS7XX_MSR_DDSR_BIT		BIT(1)   /* Delta DSR Data Set Ready or (IO4)
 						  * - only on 75x/76x
 						  */
-#define SC16IS7XX_MSR_DRI_BIT		BIT(2)   /* Delta RI Ring Indicator
-						  * or (IO7)
+#define SC16IS7XX_MSR_DRI_BIT		BIT(2)   /* Delta RI Ring Indicator or (IO7)
 						  * - only on 75x/76x
 						  */
-#define SC16IS7XX_MSR_DCD_BIT		BIT(3)   /* Delta CD Carrier Detect
-						  * or (IO6)
+#define SC16IS7XX_MSR_DCD_BIT		BIT(3)   /* Delta CD Carrier Detect or (IO6)
 						  * - only on 75x/76x
 						  */
 #define SC16IS7XX_MSR_CTS_BIT		BIT(4)   /* CTS */
-#define SC16IS7XX_MSR_DSR_BIT		BIT(5)   /* DSR (IO4)
-						  * - only on 75x/76x
-						  */
-#define SC16IS7XX_MSR_RI_BIT		BIT(6)   /* RI (IO7)
-						  * - only on 75x/76x
-						  */
-#define SC16IS7XX_MSR_CD_BIT		BIT(7)   /* CD (IO6)
-						  * - only on 75x/76x
-						  */
+#define SC16IS7XX_MSR_DSR_BIT		BIT(5)   /* DSR (IO4) - only on 75x/76x */
+#define SC16IS7XX_MSR_RI_BIT		BIT(6)   /* RI (IO7) - only on 75x/76x */
+#define SC16IS7XX_MSR_CD_BIT		BIT(7)   /* CD (IO6) - only on 75x/76x */
 
 /*
  * TCR register bits
@@ -255,54 +224,42 @@
 #define SC16IS7XX_IOCONTROL_SRESET_BIT	BIT(3)   /* Software Reset */
 
 /* EFCR register bits */
-#define SC16IS7XX_EFCR_9BIT_MODE_BIT	BIT(0)   /* Enable 9-bit or Multidrop
-						  * mode (RS485) */
+#define SC16IS7XX_EFCR_9BIT_MODE_BIT	BIT(0)   /* Enable 9-bit or Multidrop mode (RS485) */
 #define SC16IS7XX_EFCR_RXDISABLE_BIT	BIT(1)   /* Disable receiver */
 #define SC16IS7XX_EFCR_TXDISABLE_BIT	BIT(2)   /* Disable transmitter */
 #define SC16IS7XX_EFCR_AUTO_RS485_BIT	BIT(4)   /* Auto RS485 RTS direction */
 #define SC16IS7XX_EFCR_RTS_INVERT_BIT	BIT(5)   /* RTS output inversion */
 #define SC16IS7XX_EFCR_IRDA_MODE_BIT	BIT(7)   /* IrDA mode
-						  * 0 = rate upto 115.2 kbit/s
-						  *   - Only 75x/76x
-						  * 1 = rate upto 1.152 Mbit/s
-						  *   - Only 76x
+						  * 0 = rate up to 115.2 kbit/s - Only 75x/76x
+						  * 1 = rate up to 1.152 Mbit/s - Only 76x
 						  */
 
 /* EFR register bits */
 #define SC16IS7XX_EFR_AUTORTS_BIT	BIT(6)   /* Auto RTS flow ctrl enable */
 #define SC16IS7XX_EFR_AUTOCTS_BIT	BIT(7)   /* Auto CTS flow ctrl enable */
 #define SC16IS7XX_EFR_XOFF2_DETECT_BIT	BIT(5)   /* Enable Xoff2 detection */
-#define SC16IS7XX_EFR_ENABLE_BIT	BIT(4)   /* Enable enhanced functions
-						  * and writing to IER[7:4],
-						  * FCR[5:4], MCR[7:5]
+#define SC16IS7XX_EFR_ENABLE_BIT	BIT(4)   /* Enable enhanced functions and writing to
+						  * IER[7:4], FCR[5:4], MCR[7:5]
 						  */
 #define SC16IS7XX_EFR_SWFLOW3_BIT	BIT(3)
 #define SC16IS7XX_EFR_SWFLOW2_BIT	BIT(2)
 						 /*
 						  * SWFLOW bits 3 & 2 table:
-						  * 00 -> no transmitter flow
-						  *       control
-						  * 01 -> transmitter generates
-						  *       XON2 and XOFF2
-						  * 10 -> transmitter generates
-						  *       XON1 and XOFF1
-						  * 11 -> transmitter generates
-						  *       XON1, XON2, XOFF1 and
-						  *       XOFF2
+						  * 00 -> no transmitter flow control
+						  * 01 -> transmitter generates XON2 and XOFF2
+						  * 10 -> transmitter generates XON1 and XOFF1
+						  * 11 -> transmitter generates XON1, XON2,
+						  *       XOFF1 and XOFF2
 						  */
 #define SC16IS7XX_EFR_SWFLOW1_BIT	BIT(1)
 #define SC16IS7XX_EFR_SWFLOW0_BIT	BIT(0)
 						 /*
 						  * SWFLOW bits 1 & 0 table:
-						  * 00 -> no received flow
-						  *       control
-						  * 01 -> receiver compares
-						  *       XON2 and XOFF2
-						  * 10 -> receiver compares
-						  *       XON1 and XOFF1
-						  * 11 -> receiver compares
-						  *       XON1, XON2, XOFF1 and
-						  *       XOFF2
+						  * 00 -> no received flow control
+						  * 01 -> receiver compares XON2 and XOFF2
+						  * 10 -> receiver compares XON1 and XOFF1
+						  * 11 -> receiver compares XON1, XON2,
+						  *       XOFF1 and XOFF2
 						  */
 #define SC16IS7XX_EFR_FLOWCTRL_BITS	(SC16IS7XX_EFR_AUTORTS_BIT | \
 					SC16IS7XX_EFR_AUTOCTS_BIT | \
@@ -1152,7 +1109,7 @@ static int sc16is7xx_startup(struct uart_port *port)
 
 	sc16is7xx_power(port, 1);
 
-	/* Reset FIFOs*/
+	/* Reset FIFOs */
 	val = SC16IS7XX_FCR_RXRESET_BIT | SC16IS7XX_FCR_TXRESET_BIT;
 	sc16is7xx_port_write(port, SC16IS7XX_FCR_REG, val);
 	udelay(5);
-- 
2.39.5


