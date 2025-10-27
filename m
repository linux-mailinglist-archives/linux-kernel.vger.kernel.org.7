Return-Path: <linux-kernel+bounces-870933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C70FC0C02A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 07:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AB583BCA88
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 06:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34C82C3769;
	Mon, 27 Oct 2025 06:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MpP4Ub6a"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF4429AB15
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761548145; cv=none; b=i0qW/NhOhIIIJ0mlBnYoEfFt2VWxMPjF+Yjgb48RCWUfl27mmA+0UeQmbvjr46Qg0FvaSOZGfMJ8qiFp0hxKSFLZcxQ6uzIYvMga9bPR0R54RBlsILuSahcfKZBoPPY4qR/2C9H+Q9T6oTglw+Os6Z3ULrr4lYHNRMDg+4HMjyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761548145; c=relaxed/simple;
	bh=sc6rtIyDPvdKz05utSWmnYw8kiWLVsRumZ8Ghm3lOm0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cYjhJgMCtfC1RnTWaTfaTSxFoRpFsb1dy80Pp6XQcLtrOKml592aMM5eS9X6cfzl9dWo+/jZTTas7v0sW/JWrBC8c8W9JS3SORle+h71ZuLuhumyPzoTCpsR3W3J5pKkFZzHCFx4Ta+mgEpwG4MyBiklwn8Ug86eA2WKShQULek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jinliangw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MpP4Ub6a; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jinliangw.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33bb3b235ebso9397358a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 23:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761548143; x=1762152943; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sbmwsTdQ6YF5+TZb3ShGWy43B6VqQWTeWva1HX7Oio4=;
        b=MpP4Ub6aKetheGoEr7G6WKizTeEax9uja+BPxdtYJM5TaghrQA+6LrrVEm3qj9aMRe
         +6XBx5mR+HxBSMM0Ala/cnlkEtPt6JaT3AMPPVXsXBw4qQmhchyvjgizrEa4fCyQOsO9
         vK5/Y5SgSicS1Zk4BSTR/3oXUGBrggyIk0D/iNJ1C8gDywUYryHeADx39a1E4GQ3Fcq1
         kFOvhnhnm2G5bwU/r3C6UBEZ44SEP67ZjluSdOBUiquJJtnD9CPyFO19kTmO8K+z9aFX
         XR7TuHQo/aD+s9aphR4LMRzyZ29lPfCi8bZ0nQttdf5dDbHu/Ji1U8PPiYlCqdP0t8fR
         X5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761548143; x=1762152943;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sbmwsTdQ6YF5+TZb3ShGWy43B6VqQWTeWva1HX7Oio4=;
        b=sb/QpRIvwJ7YO+2/+WKMtWP/R/tcaU3ElO8t5TLc97fMroYCZL9a7mkGAeYLGwdxMP
         frH9ajrLec0+xdaeATSBR3V2mtppNZSaj69JlyX1WHL98i423k9g2qhxOCXHvCRYV5rs
         /wkUA6BymndytYGgWGXdvfxGy6kHvaRLU3+WDx5/gHP2atYXJz9mJV1BMT15D08zWG8p
         iCrHh4MaBm4Okp+lkagonXoN83cCAOOyv+YZDiTSGEJqcK0HWZVFCfHzsW2mOeHOMGw0
         vMG7nj3JFvfV0QCw43uYCxNn+dnVq0MUlfXcvqQYRN6rvrJokVZMV/f1ypfD7uCuj4Xh
         FEyg==
X-Forwarded-Encrypted: i=1; AJvYcCWfZiYKtiaQ2hBMffXF7JAd4Ug7v/oG2ngifto+qLx8BXbOZOD1bzFYeSvBaw2NMZZc2gaYvHxOZYOM5p4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtJUNBbUwxj8A07V2Z3NPiZ+MQ2igRIDLuBC6JrjM4R8tb6jUK
	G605n6Jma7NOixv0A45RqDDZxulkJvbus2lwX2kDITb77H4dMmUZtvIMaUmoYK/d35RHyjwDEXw
	5YvN9mJHbTepy2VGV6w==
X-Google-Smtp-Source: AGHT+IF3S5K3EkYdz6G/UGbPSSLcc9B0pRhGypF5xAPkjtHrQnorxl6vqgEVWtjlAM3op7+8s8GLyOPMR1Z5otA=
X-Received: from pjbbf19.prod.google.com ([2002:a17:90b:b13:b0:330:8c66:4984])
 (user=jinliangw job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:17c3:b0:33b:ae39:c297 with SMTP id 98e67ed59e1d1-33fd6502cb7mr13433701a91.16.1761548143005;
 Sun, 26 Oct 2025 23:55:43 -0700 (PDT)
Date: Sun, 26 Oct 2025 23:55:30 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251027065530.2045724-1-jinliangw@google.com>
Subject: [PATCH net v3] net: mctp: Fix tx queue stall
From: Jinliang Wang <jinliangw@google.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>, Matt Johnston <matt@codeconstruct.com.au>, 
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-kernel@vger.kernel.org, Jinliang Wang <jinliangw@google.com>
Content-Type: text/plain; charset="UTF-8"

The tx queue can become permanently stuck in a stopped state due to a
race condition between the URB submission path and its completion
callback.

The URB completion callback can run immediately after usb_submit_urb()
returns, before the submitting function calls netif_stop_queue(). If
this occurs, the queue state management becomes desynchronized, leading
to a stall where the queue is never woken.

Fix this by moving the netif_stop_queue() call to before submitting the
URB. This closes the race window by ensuring the network stack is aware
the queue is stopped before the URB completion can possibly run.

Fixes: 0791c0327a6e ("net: mctp: Add MCTP USB transport driver")
Signed-off-by: Jinliang Wang <jinliangw@google.com>
---
v3:
 - target net tree, add fixes tag

v2:
 - remove duplicate comment in commit message

---
 drivers/net/mctp/mctp-usb.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mctp/mctp-usb.c b/drivers/net/mctp/mctp-usb.c
index 36ccc53b1797..ef860cfc629f 100644
--- a/drivers/net/mctp/mctp-usb.c
+++ b/drivers/net/mctp/mctp-usb.c
@@ -96,11 +96,13 @@ static netdev_tx_t mctp_usb_start_xmit(struct sk_buff *skb,
 			  skb->data, skb->len,
 			  mctp_usb_out_complete, skb);
 
+	/* Stops TX queue first to prevent race condition with URB complete */
+	netif_stop_queue(dev);
 	rc = usb_submit_urb(urb, GFP_ATOMIC);
-	if (rc)
+	if (rc) {
+		netif_wake_queue(dev);
 		goto err_drop;
-	else
-		netif_stop_queue(dev);
+	}
 
 	return NETDEV_TX_OK;
 
-- 
2.51.1.821.gb6fe4d2222-goog


