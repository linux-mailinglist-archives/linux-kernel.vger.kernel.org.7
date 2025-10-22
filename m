Return-Path: <linux-kernel+bounces-865357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EA605BFCDFF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B54C3508713
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C90634F27C;
	Wed, 22 Oct 2025 15:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwwlT5D+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866A434D4F3;
	Wed, 22 Oct 2025 15:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761146814; cv=none; b=nh5x1zTiMiXTvmw+V4Gf/im6ue+/K9J4RxJzTnivltzv4J8FK6hzlP3Lg9Cte42l0r9hGd8U+kmbwQzOdypyxgO53LzNdT6ECnhJywaKMj1W1LxuiuQN1RlV/dkMYDpEsPwAbPV/n7iEC7XsUXIEPpyS8RQq/LB9WIn2m+zvFqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761146814; c=relaxed/simple;
	bh=q7VD6JwdCTUvOEdwC95Y74/EVANR7Cjb3M1GyXBWDxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=McfkxlynAlvEbvN27Okyok8H0Z3JqBfEG7XabGR53DCztq4j7+FN++nJ9/LCZV11BB85flm5/I+IZnb6PUVqEEHflqSZwBzJHpmh6+Kqk5FmoQuqOj9KD9SrP5pgSRzNM8cRdLmNn83Ux7t3VwHGwCjfjJFc1Zw6Kwqe0lvN1YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwwlT5D+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3DAC116D0;
	Wed, 22 Oct 2025 15:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761146813;
	bh=q7VD6JwdCTUvOEdwC95Y74/EVANR7Cjb3M1GyXBWDxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hwwlT5D+N0IblKrqOeFYshfS0g5KDjWIUUtSSYG/k5sn1YxlFvQPMTD/r24X6mxf5
	 fa5h7UP0NV3WlDvpLiY9Wn90RQs7MFSwF28FYHq6Q7JXmxE9LqYRtlj17txQeurxzH
	 SO09Piu+3DUpxuOSsg976XkdNAq6peRUzjBa4zW6vYY9C5UrugbtB/gFS7S+5HckaA
	 5isq1vB6TgS8jaJFpSNCa/Olttz9tFjt5WuYLqRC84dqCMZ7c7ywQxLf9YlhtyQZ4r
	 DWPbCMFXWehsW9wGXLX55Cfl72SFmCYhzuh7GfJqcpWkEuDh5JSdzd31Y5ZU15uGJq
	 I6m57jxSNWJ6A==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vBajr-000000006JJ-3Sjt;
	Wed, 22 Oct 2025 17:26:59 +0200
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] USB: serial: belkin_sa: clean up tiocmset()
Date: Wed, 22 Oct 2025 17:26:35 +0200
Message-ID: <20251022152640.24212-4-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251022152640.24212-1-johan@kernel.org>
References: <20251022152640.24212-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up the tiocmset() implementation by dropping the dtr and rts flags
to make the logic a little easier to follow.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/belkin_sa.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/serial/belkin_sa.c b/drivers/usb/serial/belkin_sa.c
index aa6b4c4ad5ec..5c41c1c82c3f 100644
--- a/drivers/usb/serial/belkin_sa.c
+++ b/drivers/usb/serial/belkin_sa.c
@@ -436,33 +436,23 @@ static int belkin_sa_tiocmset(struct tty_struct *tty,
 	unsigned long control_state;
 	unsigned long flags;
 	int retval = 0;
-	int rts = 0;
-	int dtr = 0;
 
 	spin_lock_irqsave(&priv->lock, flags);
 	control_state = priv->control_state;
 
-	if (set & TIOCM_RTS) {
+	if (set & TIOCM_RTS)
 		control_state |= TIOCM_RTS;
-		rts = 1;
-	}
-	if (set & TIOCM_DTR) {
+	if (set & TIOCM_DTR)
 		control_state |= TIOCM_DTR;
-		dtr = 1;
-	}
-	if (clear & TIOCM_RTS) {
+	if (clear & TIOCM_RTS)
 		control_state &= ~TIOCM_RTS;
-		rts = 1;
-	}
-	if (clear & TIOCM_DTR) {
+	if (clear & TIOCM_DTR)
 		control_state &= ~TIOCM_DTR;
-		dtr = 1;
-	}
 
 	priv->control_state = control_state;
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-	if (rts) {
+	if ((set | clear) & TIOCM_RTS) {
 		retval = BSA_USB_CMD(BELKIN_SA_SET_RTS_REQUEST,
 					!!(control_state & TIOCM_RTS));
 		if (retval < 0) {
@@ -471,7 +461,7 @@ static int belkin_sa_tiocmset(struct tty_struct *tty,
 		}
 	}
 
-	if (dtr) {
+	if ((set | clear) & TIOCM_DTR) {
 		retval = BSA_USB_CMD(BELKIN_SA_SET_DTR_REQUEST,
 					!!(control_state & TIOCM_DTR));
 		if (retval < 0) {
-- 
2.49.1


