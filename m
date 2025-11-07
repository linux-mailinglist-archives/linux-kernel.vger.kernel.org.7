Return-Path: <linux-kernel+bounces-890150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FC1C3F560
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 11:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB7304EDAE9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 10:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42852DECC6;
	Fri,  7 Nov 2025 10:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hci9UXQa"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A44296BB6
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 10:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762510125; cv=none; b=Dd5sXa4Su5ft1SRQeujis3v+/Q6NqCJAm8r091MjrR5gUNlf7BNQHWyhW9gT6z2o5dY+nH0av8Yx+13+z0rqCJOBu/yashWTwbRbZrpK+yImy5g88Q4xE+ro1qJg81uu9H/bhP7btrnIcnlSNVziBFWvhZHzWYxThlDTMZfOt4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762510125; c=relaxed/simple;
	bh=7Y2CqIaQTvHSqDioWx6fdpKSnjpXozl6yC8+SNHwrNg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=DFvA8Pp7FQKESY1Tqdwshful0W6ORBKE0luWPykTfyCdcYRMFIKluk2ljuDscLGpbJKWzq4Zo03ZyHm7z/V9nmk6KgChH7iPcmdcdkFvPT8ZpvtZ/n5RyX1pnF5VR2p8FYQbN9E3Bl9+gQB1MTIlKkrX7hjuki/jk5DBqlY4h4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hci9UXQa; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-640f627d01dso1055048a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 02:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762510122; x=1763114922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l/T5ZL5ZUM3ZTHx5g9Obu8aj3FYGAeWtndV+CEH9cdc=;
        b=hci9UXQaeNde6vLbFbjpIJeV9DLY3h6m7LiZ0r49cA2vRkWyZjTLGk95sWrgLUZvko
         arx5QDDFrYvumcUK9YBQ0/UwGXDOEa5azo1mHqi6KrDD9pDS7TxyloHx6I3wKrRPZi+S
         hVkB8AT400sgnfbaZLoCGO8Qf4p0fDjwSJfXXwEBo1k9aipxveI4CQQERkYc0c9LKjJF
         WJLODmBnKhzCgRZUXfjx8LsVUlBkZAtElIue+/U8A15gWFZMAiLJtCNwO+XmLCg1rXIz
         QeXzPuXdB+mUyPZf418VSUgM19hUSo6IlkzRmd6Q+pKSMt92FbFHdq0+xmjt+n/8cnWe
         2COg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762510122; x=1763114922;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/T5ZL5ZUM3ZTHx5g9Obu8aj3FYGAeWtndV+CEH9cdc=;
        b=w8y9I2FLT07RjqwthqVla9PAhNC7Lq517Q2wRNsmHLyobzn2NK9ab4IC7lPxxqXeGn
         K14a5wpKXuEaJR52KtY6HYSI/wCu4fsIqFzmB1chk5pZwHc3bL9CQeQBEqdSxyJM4CoF
         aMRV0T2+EFsBh9nrL9Q9F1h7mDyLqCYkAOUC5PJ0IbO1wzz9RmcRyKmNyIM+HzTQikw3
         PVvQYCEXHLp+opin90o2L8s+/2DnZqfx4KPr55NP08NC6c66e0rWiTn6JzuBrPl1RQzQ
         88h/W/ojWm1FfUDGzEZNP2hxZVSen9DlP3JP4lHb938A44tQ0YUvxQA08StEJaDRzmnj
         cW0g==
X-Forwarded-Encrypted: i=1; AJvYcCWCmltNpPbqeNTeG0HtOovNspPQFgBAqc6MiYOvJm2amKLD5CWj/uQWRrKW/9KkU3bopvbLIK5WG+Iwr5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTIIzJ4r30gmPdT5Oj7fu040iQztAmHmaKd/F3Rn7+7tBbNI/R
	73IqRbV2jd7ZGzulcr2TGfv6V1MOeTAfcqk8bjdBNZaPwDAnlyIf4/Lv
X-Gm-Gg: ASbGncvfJtlYCjmr5w84bPxUH1Ug8q7sBRTgkIhfmF/55b1elfgDbTRacJjh0YWQbwH
	WoKVAA9AOH8GvxCgNga8fSPQ7wDtMJoklTywGKuQs8+55kQwY5ZBusXvRmDZ48l6VwXm1Cm1zHX
	8LujPPYbIs0Y7vBpDbWL8ey7irc4tgUFU7Dn5ObWjlpc0Zjn8u32nh6zXzge/TJpmhdFWbziZyP
	a8dLChCOaUHYJUlQZvVP3M10yK+KtFdTqLrd/wUO0QDX1KSVAwQ85MurIXtFKhEIMdsLWXHXFPR
	Qk01KB/zp1NPbkbQgIqR0OFfu6ZDC/NWuL1+/hhidJAgYbQX25GdzhJYp6qN4loD9UVnrA0VnEs
	PJbNP6t5iKjLaMvXGOed2JEKYmgU8exkxdBX63wTYluhrU/IWb4koUnu3p1FRAae0xNx3Ti3T3t
	IhPjP/MUeBD5wGyg==
X-Google-Smtp-Source: AGHT+IFUbBUcCK13yeA0k8qhq4r3gnoVR9oHPMnyYIO0T9X3b3cXg8FejWBAQz57kfQRPAuIhT9Bbw==
X-Received: by 2002:a17:907:987:b0:b70:30c8:c35 with SMTP id a640c23a62f3a-b72c0dab9bemr224682466b.62.1762510122350;
        Fri, 07 Nov 2025 02:08:42 -0800 (PST)
Received: from foxbook (bfd52.neoplus.adsl.tpnet.pl. [83.28.41.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf9be184sm199997866b.56.2025.11.07.02.08.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 07 Nov 2025 02:08:41 -0800 (PST)
Date: Fri, 7 Nov 2025 11:08:37 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: xhci: Don't unchain link TRBs on quirky HCs
Message-ID: <20251107110837.7b7d686b.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Some old HCs ignore transfer ring link TRBs whose chain bit is unset.
This breaks endpoint operation and sometimes makes it execute other
ring's TDs, which may corrupt their buffers or cause unwanted device
action. We avoid this by chaining all link TRBs on affected rings.

Fix an omission which allows them to be unchained by cancelling TDs.

The patch was tested by reproducing this condition on an isochronous
endpoint (non-power-of-two TDs are sometimes split not to cross 64K)
and printing link TRBs in trb_to_noop() on good and buggy HCs.

Actual hardware malfunction is rare since it requires Missed Service
Error shortly before the unchained link TRB, at least on NEC and AMD.
I have never seen it after commit bb0ba4cb1065 ("usb: xhci: Apply the
link chain quirk on NEC isoc endpoints"), but it's Russian roulette
and I can't test all affected hosts and workloads. Fairly often MSEs
happen after cancellation because the endpoint was stopped.

Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
---
 drivers/usb/host/xhci-ring.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index a9e468ea19c5..fc0043ca85a4 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -128,11 +128,11 @@ static void inc_td_cnt(struct urb *urb)
 	urb_priv->num_tds_done++;
 }
 
-static void trb_to_noop(union xhci_trb *trb, u32 noop_type)
+static void trb_to_noop(union xhci_trb *trb, u32 noop_type, bool unchain_links)
 {
 	if (trb_is_link(trb)) {
-		/* unchain chained link TRBs */
-		trb->link.control &= cpu_to_le32(~TRB_CHAIN);
+		if (unchain_links)
+			trb->link.control &= cpu_to_le32(~TRB_CHAIN);
 	} else {
 		trb->generic.field[0] = 0;
 		trb->generic.field[1] = 0;
@@ -465,7 +465,7 @@ static void xhci_handle_stopped_cmd_ring(struct xhci_hcd *xhci,
 		xhci_dbg(xhci, "Turn aborted command %p to no-op\n",
 			 i_cmd->command_trb);
 
-		trb_to_noop(i_cmd->command_trb, TRB_CMD_NOOP);
+		trb_to_noop(i_cmd->command_trb, TRB_CMD_NOOP, false);
 
 		/*
 		 * caller waiting for completion is called when command
@@ -797,13 +797,18 @@ static int xhci_move_dequeue_past_td(struct xhci_hcd *xhci,
  * (The last TRB actually points to the ring enqueue pointer, which is not part
  * of this TD.)  This is used to remove partially enqueued isoc TDs from a ring.
  */
-static void td_to_noop(struct xhci_td *td, bool flip_cycle)
+static void td_to_noop(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
+			struct xhci_td *td, bool flip_cycle)
 {
+	bool unchain_links;
 	struct xhci_segment *seg	= td->start_seg;
 	union xhci_trb *trb		= td->start_trb;
 
+	/* link TRBs should now be unchained, but some old HCs expect otherwise */
+	unchain_links = !xhci_link_chain_quirk(xhci, ep->ring ? ep->ring->type : TYPE_STREAM);
+
 	while (1) {
-		trb_to_noop(trb, TRB_TR_NOOP);
+		trb_to_noop(trb, TRB_TR_NOOP, unchain_links);
 
 		/* flip cycle if asked to */
 		if (flip_cycle && trb != td->start_trb && trb != td->end_trb)
@@ -1091,16 +1096,16 @@ static int xhci_invalidate_cancelled_tds(struct xhci_virt_ep *ep)
 						  "Found multiple active URBs %p and %p in stream %u?\n",
 						  td->urb, cached_td->urb,
 						  td->urb->stream_id);
-					td_to_noop(cached_td, false);
+					td_to_noop(xhci, ep, cached_td, false);
 					cached_td->cancel_status = TD_CLEARED;
 				}
-				td_to_noop(td, false);
+				td_to_noop(xhci, ep, td, false);
 				td->cancel_status = TD_CLEARING_CACHE;
 				cached_td = td;
 				break;
 			}
 		} else {
-			td_to_noop(td, false);
+			td_to_noop(xhci, ep, td, false);
 			td->cancel_status = TD_CLEARED;
 		}
 	}
@@ -1125,7 +1130,7 @@ static int xhci_invalidate_cancelled_tds(struct xhci_virt_ep *ep)
 				continue;
 			xhci_warn(xhci, "Failed to clear cancelled cached URB %p, mark clear anyway\n",
 				  td->urb);
-			td_to_noop(td, false);
+			td_to_noop(xhci, ep, td, false);
 			td->cancel_status = TD_CLEARED;
 		}
 	}
@@ -4273,7 +4278,7 @@ static int xhci_queue_isoc_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 	 */
 	urb_priv->td[0].end_trb = ep_ring->enqueue;
 	/* Every TRB except the first & last will have its cycle bit flipped. */
-	td_to_noop(&urb_priv->td[0], true);
+	td_to_noop(xhci, xep, &urb_priv->td[0], true);
 
 	/* Reset the ring enqueue back to the first TRB and its cycle bit. */
 	ep_ring->enqueue = urb_priv->td[0].start_trb;
-- 
2.48.1

