Return-Path: <linux-kernel+bounces-897710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A96C538A9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D7D2F5851FC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8918433A036;
	Wed, 12 Nov 2025 16:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b="EgOv4nb6"
Received: from smtp1.tecnico.ulisboa.pt (smtp1.tecnico.ulisboa.pt [193.136.128.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F0E33D6C8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.136.128.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963780; cv=none; b=nJ999R1ieacS2fu6Jh6PifV4cHC23roj0G+cr+qykdhIqJP1i4g3ZEKx6wxZDEIH8wdHEGFzmGIM/5LpSTFMlQ8MPX10/V3aJpkvmWiH75iOFF5Ufuri6+0LWqH/J6cHS5meuF4dsv/3etk7enFbZS4a2CYuJfX3mFgEkB19sHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963780; c=relaxed/simple;
	bh=D8vWhtc/F9QEJKA9e2KaxmqNTdESLPKmX/Jcr1cxrNE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XW+5d6/0BxUTzweDh4eSau2OnpSzlsJjFDAZxJCXGa0iWvVPRBtlaJI+iYZCE7HQ385Wy0bNSjBTK3RZjg0byNgrGLHfS9wAxLHIRV09rwuyYgZqaBaZuGw4fziorYZViovN4Mjd3beCZeevxT+y+vKlOzDxx/TrB3Yi25+xth0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt; spf=pass smtp.mailfrom=tecnico.ulisboa.pt; dkim=pass (2048-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b=EgOv4nb6; arc=none smtp.client-ip=193.136.128.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tecnico.ulisboa.pt
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTP id 4707B600025E;
	Wed, 12 Nov 2025 16:00:20 +0000 (WET)
X-Virus-Scanned: by amavis-2.13.0 (20230106) (Debian) at tecnico.ulisboa.pt
Received: from smtp1.tecnico.ulisboa.pt ([127.0.0.1])
 by localhost (smtp1.tecnico.ulisboa.pt [127.0.0.1]) (amavis, port 10025)
 with LMTP id eYELPNU3U0IN; Wed, 12 Nov 2025 16:00:18 +0000 (WET)
Received: from mail1.tecnico.ulisboa.pt (mail1.ist.utl.pt [IPv6:2001:690:2100:1::b3dd:b9ac])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTPS id E06B9600300F;
	Wed, 12 Nov 2025 16:00:17 +0000 (WET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tecnico.ulisboa.pt;
	s=mail2; t=1762963217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qURj0gZ8j5z59gsJivqjzZ8kn4SeoU4gJsa0ae7OBJ4=;
	b=EgOv4nb636LCAgGp+fNT9ODCBGo1od0JXjrwS2T/Wtrdb6JuQXG7z+B0oH2c5tCW8tbcCK
	n0nhcJ27t90qxc3eewuLXVWBKLyiquuCK+CqpfKw+M/c/yGHgeYL/FQloE6AXJP+sI1oHg
	HHoMJTV0lvMurJROZ68Vo2fjLNcVctfzyp/Q4oGtGjE7Ks1BZbWmskiuTEvD6Q5eTMVb4u
	XnuNIWB5SbdBceuSkwhqxTBvL1XvIk7y9xTLtz1yAIcmvge5NlJOsL8EOQxQwCqtjN4QzP
	dreuDMf0uk1AL1WYZ1RHrmKOc1Ary4oT0k1AV+sn90nFkvbKsGx7GiB/f5rJGg==
Received: from [10.3.0.106] (unknown [83.240.156.116])
	(Authenticated sender: ist187313)
	by mail1.tecnico.ulisboa.pt (Postfix) with ESMTPSA id 889413600F9;
	Wed, 12 Nov 2025 16:00:17 +0000 (WET)
From: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
Date: Wed, 12 Nov 2025 16:00:12 +0000
Subject: [PATCH] platform/chrome: sensorhub: Support devices without
 FIFO_INT_ENABLE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-diogo-smaug_ec_sensorhub-v1-1-f71d4e9eb9d4@tecnico.ulisboa.pt>
X-B4-Tracking: v=1; b=H4sIAAuvFGkC/x3MQQqAIBBA0avErBO0clFXiQhzJptFGg5FEN09a
 fkW/z8glJkEhuqBTBcLp1hg6gr85mIgxVgMjW6sMbpTyCkkJbs7w0x+FoqS8nYuqkX0zi4aW9t
 DyY9MK9//epze9wO2/aFyagAAAA==
X-Change-ID: 20251104-diogo-smaug_ec_sensorhub-3ddca5b0d359
To: Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Guenter Roeck <groeck@chromium.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762963217; l=2119;
 i=diogo.ivo@tecnico.ulisboa.pt; s=20240529; h=from:subject:message-id;
 bh=D8vWhtc/F9QEJKA9e2KaxmqNTdESLPKmX/Jcr1cxrNE=;
 b=f5nNIpcEuqwgnJ5FFY3zeTzURoBMobaQGLRDIRLad0PofqIKu4dXriNfoQESXGrlg48Iai4XB
 hegA2gxDOYTC44EOhl69ACs0pMfFhpXJ7GjVrTELK/hHuMPuxaRhUt8
X-Developer-Key: i=diogo.ivo@tecnico.ulisboa.pt; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=

Some devices (such as Smaug) report having MOTION_SENSE_FIFO but do not
support controlling the behaviour of the FIFO interrupt via the
FIFO_INT_ENABLE command and in these cases the interrupt is always
enabled. However, currently the code assumes that if MOTION_SENSE_FIFO
is supported then so is FIFO_INT_ENABLE, and when it tries to enable
the interrupt via this command and an unsupported device reports a
failure it then propagates this into failing the sensors probe.

In order to fix this, since the EC does not provide a way to determine
a priori if there is support for FIFO_INT_ENABLE send this command
unconditionally and carefully interpret the return value -EINVAL as a
device where FIFO_INT_ENABLE is not present and the interrupt is always
enabled.

Signed-off-by: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
---
 drivers/platform/chrome/cros_ec_sensorhub_ring.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_sensorhub_ring.c b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
index 1205219515d6..d487ace7d172 100644
--- a/drivers/platform/chrome/cros_ec_sensorhub_ring.c
+++ b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
@@ -129,6 +129,18 @@ int cros_ec_sensorhub_ring_fifo_enable(struct cros_ec_sensorhub *sensorhub,
 	/* We expect to receive a payload of 4 bytes, ignore. */
 	if (ret > 0)
 		ret = 0;
+	/*
+	 * Some platforms (such as Smaug) don't support the FIFO_INT_ENABLE
+	 * command and the interrupt is always enabled. Since the EC protocol
+	 * does not provide a way to discover if the command is supported a
+	 * priori interpret -EINVAL as not supported and proceed normally.
+	 *
+	 * N.B: there is no danger of -EINVAL meaning any other invalid
+	 * parameter since fifo_int_enable.enable is a bool and can never
+	 * be in an invalid range.
+	 */
+	else if (ret == -EINVAL)
+		ret = 0;
 
 	return ret;
 }

---
base-commit: 50e3a23e86817c295b5a188663c24054ec5932ed
change-id: 20251104-diogo-smaug_ec_sensorhub-3ddca5b0d359

Best regards,
-- 
Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>


