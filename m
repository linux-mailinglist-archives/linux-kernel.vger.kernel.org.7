Return-Path: <linux-kernel+bounces-856114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82332BE31DF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 214663B882B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E1C31A813;
	Thu, 16 Oct 2025 11:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="j4eBj8ec"
Received: from mx-relay28-hz2.antispameurope.com (mx-relay28-hz2.antispameurope.com [94.100.136.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A190430F930
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 11:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.136.228
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760614747; cv=pass; b=XChaSyI1rsrULT2E+xOukZJCb23i0/ykgOBy8Pw6mKh+jVhV4CfVHSPT2817baTUBJ4mJZJJFwa0lHlh/JHM73S7wN1jgZ/nAjni1o0jkKkn9/NTamyANbRZlpiNDlEJTHQZTm+sc+3QZwTuRkWPLfhGsRoCjsOKTP2BXQpmDmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760614747; c=relaxed/simple;
	bh=GlmFA1e3xgMj4OhgcxyrgU5ao2+BLBIMEKfNxeDhUDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WMZIiN9HmNQEtzpjglVhXOyunihatszqrOz195LK94qjarTr8IIPild8Q4dTuUS8Q/IAbkwfpiUwSdIPcbBdju5wNbNg/nzZp1dLhOkhCK2a019ZyC9Yjt+RRIZJe9AIiN/RTo8oE6WaZyJ+VTf2O/wL90TvILjjGRs+rKUrsho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=j4eBj8ec; arc=pass smtp.client-ip=94.100.136.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate28-hz2.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out04-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=CFRIIs060aUTE/XtgbE3U9aNP00cbQnhfyqtNtGSsHY=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1760614687;
 b=YbfVyLc1nd07tcS+6p8VajcYDWN0hQ+m3qJm5iQAAp2TTOEt7X74bJvfo35Mum6uBFIB/CTW
 OLsmAimbi9wlqXHwbKBxTX1XPCIgwKRhIERliUL1Ah1luKi8xQea+yhi/3E/w3BTiyiCs7G3B8o
 RyCsEGUaIEnuf4k0Lbo8v/s9OIHP6w77rW1/cFeoumin/BUxFH1zXEQRPZ2zQ14q73iEzqWhIpC
 4EnBB1a3clmdqCTInKOrgYPtconZzEnz3htgC2s2hgGHCUrPPP3Bi7SMVY/2ow8Bk/vLCwTAfTs
 9Ve4EMIcZlveorCEo0D47E6SE5WYsSk7QADtbi95hRguw==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1760614687;
 b=WMtIgxABhhnF8oeTrpE4wXf19fQQPxwTYMcE7W6gu6ootL5+KCAThZf2waP7MyKcPZ91yTFN
 +4zwAR85HxW8KtBa4PqS+8CaM8sGgJY1ksfbXHD3KZjEEmdxAJAKanuPzdOOTW6QwlKFN/NCJn4
 09XBi7w7kW7WXg0TWkA0FF6+Fp65z/1U4ESNC4FXOn2nHc0uJyJaoWoEsiEh6OLJ5Pdv8ONuDhq
 r8GMbT4a8eJM760MoCBMw7li738wk/tOn9OtsEQOHr9LHOl87WMnqBvK5EKBsy9vdybm4L1If6J
 V/TA2gYi+55dUsQbCsXbBLSlZb6DkJdYvhlbffBTTPzlw==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay28-hz2.antispameurope.com;
 Thu, 16 Oct 2025 13:38:06 +0200
Received: from schifferm-ubuntu.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: matthias.schiffer@ew.tq-group.com)
	by hmail-p-smtp01-out04-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 3F3EC220BA0;
	Thu, 16 Oct 2025 13:37:50 +0200 (CEST)
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH] serial: imx: allow CRTSCTS with RTS/CTS GPIOs
Date: Thu, 16 Oct 2025 13:37:30 +0200
Message-ID: <20251016113730.245341-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-cloud-security-sender:matthias.schiffer@ew.tq-group.com
X-cloud-security-recipient:linux-kernel@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: matthias.schiffer@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay28-hz2.antispameurope.com with 4cnQtQ6zX8z1QNSK
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:a7531a3aefe8095ad0ffc3e1e5a543aa
X-cloud-security:scantime:2.247
DKIM-Signature: a=rsa-sha256;
 bh=CFRIIs060aUTE/XtgbE3U9aNP00cbQnhfyqtNtGSsHY=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1760614686; v=1;
 b=j4eBj8ec5cbq3DBsirbQSyzDueV8vy5yg/WMBZyjnhCZTFOXJCxlWUeleBwnkmv1clSMZcjn
 KII+PnBxlCK/q5wnRZuABJV1i7CWqAguXBQ2Zw6MQ/DooTjzmulNpLkauQO+8TMnSh3TVN0Eykn
 80/4GGeGeycvZ966m/tHZjwt5j/rD81cD6V4+etC0L9ftL3MGOoFUT7hZpLx+rNfc5CP+rUfrXy
 lgaHD169rH+XiJZziFauxcNkklOIiEIqcI/z1kzsqFZD9+tBYt795bY+3PRwAFPJTA4ckDVZJZW
 mNq6OLC/o47YvKjC4dmyQtCf4imxUop0cwnY/8rNX0TZg==

The CTS GPIO is only evaluated when the CRTSCTS termios flag is enabled;
it should be possible to enable the flag when only GPIO and no hardware-
controlled RTS/CTS are available. UCR2_IRTS is kept enabled in this case,
so the hardware CTS is ignored.

Fixes: 58362d5be352 ("serial: imx: implement handshaking using gpios with the mctrl_gpio helper")
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/tty/serial/imx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 500dfc009d03e..4a54a689a0603 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1117,8 +1117,8 @@ static void imx_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 			ucr2 |= UCR2_CTS;
 			/*
 			 * UCR2_IRTS is unset if and only if the port is
-			 * configured for CRTSCTS, so we use inverted UCR2_IRTS
-			 * to get the state to restore to.
+			 * configured for hardware-controlled CRTSCTS, so we use
+			 * inverted UCR2_IRTS to get the state to restore to.
 			 */
 			if (!(ucr2 & UCR2_IRTS))
 				ucr2 |= UCR2_CTSC;
@@ -1780,7 +1780,7 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 	if ((termios->c_cflag & CSIZE) == CS8)
 		ucr2 |= UCR2_WS;
 
-	if (!sport->have_rtscts)
+	if (!sport->have_rtscts && !sport->have_rtsgpio)
 		termios->c_cflag &= ~CRTSCTS;
 
 	if (port->rs485.flags & SER_RS485_ENABLED) {
@@ -1794,7 +1794,7 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 		else
 			imx_uart_rts_inactive(sport, &ucr2);
 
-	} else if (termios->c_cflag & CRTSCTS) {
+	} else if ((termios->c_cflag & CRTSCTS) && sport->have_rtscts) {
 		/*
 		 * Only let receiver control RTS output if we were not requested
 		 * to have RTS inactive (which then should take precedence).
@@ -1803,7 +1803,7 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 			ucr2 |= UCR2_CTSC;
 	}
 
-	if (termios->c_cflag & CRTSCTS)
+	if ((termios->c_cflag & CRTSCTS) && sport->have_rtscts)
 		ucr2 &= ~UCR2_IRTS;
 	if (termios->c_cflag & CSTOPB)
 		ucr2 |= UCR2_STPB;
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


