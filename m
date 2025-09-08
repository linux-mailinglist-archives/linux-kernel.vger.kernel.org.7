Return-Path: <linux-kernel+bounces-805608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84644B48AF4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D129D7A8FAC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DED2FB99C;
	Mon,  8 Sep 2025 11:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CT2hoKac"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC2E227563;
	Mon,  8 Sep 2025 11:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757329345; cv=none; b=CncMXtIr5fd9uXQovV/mfL4J7g18u8pbzPXgQ7yMFbL9c7wx4Ttt2bWRE9X1RMG8UWuUaMC75TACn4dW9D5WWmBqQ9FIKpA5FzDg3N6PQiVepBZ6sxgFDDu7Qjr6KH4No8m78GbBeiBWHlQBac4tEvdlx3OP6U1qabUoiC+yOTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757329345; c=relaxed/simple;
	bh=i9yuQOU/9957txHSKRCgZ5j1FjyAVo01DWZM9lanS3o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oOCFulysxxJaCpulWLA8TMwbnS3auBlorNxW5A2mmVD9i26NX7LrwZgewIf216T8UzktdbsaqFpl/sUApDD+8GEKC+vB6WlmoLfMvisvx180Wgffqmd3iOh/GVqx9gt8M+3H/BOHVUZjmc1NEyXEPkxSjd8qL8y2ooSzfdESP/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CT2hoKac; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-337f6cdaf2cso31824011fa.2;
        Mon, 08 Sep 2025 04:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757329341; x=1757934141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vkWqQJdHOrwt5s3nvgza9OETHh5M83DOQgTMwG1MKco=;
        b=CT2hoKacsFzZwlY8CybpKn/Ojd9Zc5oxTL4b5906GErCa4uXDxxOEFl5NV4rNlPNkM
         j/HW1ZfqIJtfYTqJ9ASpJnEnMltlzFuKMhQ0kHdYyjXE44+/rznVtmiOxlRgJVAPmuNQ
         WiLKC/NBH0UqGDj6TiMCznmOZIeWwz9J6lWROilOVG4D7KOoBKtBcJorXi5ezk24K9kn
         F+s98CZumpbRUwI8qoj0ZJMir0bx4MWyTqcM9XfulSNJxFYSRuMjtqGKXN4FNHCylCIr
         GbrVgY9ZNjXZH3CfSTAtn1omOk08p/I229LSSwtqSWy7JeNbwhS/Rjf2bIrU4Ih3Xqss
         E6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757329341; x=1757934141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vkWqQJdHOrwt5s3nvgza9OETHh5M83DOQgTMwG1MKco=;
        b=O687jIVcPkm6PjIwtxHY3khLOle0fYIeat6omNqrAYf2ie7IHpoI6mdTGMN1oKcQmU
         pXsmggpPSayu375DOT150rfisqBPUGW07396INE+oSIpbnozhJcs3cltC/9f2O1oXaUf
         2ZxOriz5fsLoKV8ONpZXBM4TE8suUT0FpDNBH+1OCp8S92c9uFkDWycNb8X6wnVmR5Rp
         v1KHh8Hsp1PQmQX/1UH5MpGQFIKmUhySia2O6/IaTHTChLPPNhbXqyWW7tsQZQbbkLG9
         Qwe2OlAiCrcX1dcCJjTjNEABoap++nSVScnMz08DhpIA92nK3a+VKFhSjjoNL8oRDe5w
         hu7g==
X-Forwarded-Encrypted: i=1; AJvYcCVvqSvkyN5jDQ8AqPP6qiNRYBEMqgZr4lZHgs8MGti2Vb91wYpC8hx1bGWpobvvzSaJaa8vsIRCBOJulfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG1riKUsEnAgN+8uWUgiIMBK+nADe9ljCISmfdimM/nTuXWK2c
	l+e4a1Dhde2wg6hskmfcZO13L96Kh6lWCtk/bqsLYYVt1S5dE2yS5ke7
X-Gm-Gg: ASbGncu6WXs5zNpGnDIXL/LPy+csPA3vV3266PpHusRx2GSfw6jphDV84aAM08XG4dS
	h14qrNQSqRZzbFkap/ZzQMILwiqlLhH/s8WKAGvnggUafjJk+xaN8DipVQgSJq6AAnvdJISJn7F
	JDQ7Ryr1oB+nHv6imiqgOBa0OtsbIqsvtDMrMdaWBKDIJ4fjqAPg0PUim7pMC9WyPYwWtXfEdag
	FcBNJO33XULwnuH5gFvUxPpRu5O3vizEUFachuN1SOHPGyB4YOsbKdENsd1GfJBb61YAt+oJAhJ
	6MAMGlYJawWpglwZTAOtM7ExFfpjwnonYPsgjvenUoicAzb7a/9cVT89V46PUJSWpfLebqn/MaZ
	rMCUD0B7VN6f2S3UBTgGIzG69QdZ/4ixuzeU=
X-Google-Smtp-Source: AGHT+IGEZfBmvORu+nkstGfAJYimLicUfhYUOyfwY44T7t1LR++OkholxZMNaH0B7mpp6r50TJUZrw==
X-Received: by 2002:a2e:a36c:0:b0:336:d679:ba47 with SMTP id 38308e7fff4ca-33b51b18e59mr14377371fa.12.1757329340707;
        Mon, 08 Sep 2025 04:02:20 -0700 (PDT)
Received: from foxbook (bhd197.neoplus.adsl.tpnet.pl. [83.28.93.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f508a29asm31962441fa.51.2025.09.08.04.02.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 Sep 2025 04:02:20 -0700 (PDT)
Date: Mon, 8 Sep 2025 13:02:17 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] usb: xhci: Queue URB_ZERO_PACKET as one TD
Message-ID: <20250908130217.3896fd48.michal.pecio@gmail.com>
In-Reply-To: <20250908130128.7ed81912.michal.pecio@gmail.com>
References: <20250908130128.7ed81912.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

This feature was implemented with zero consideration of how the event
handler will deal with halting multi-TD URBs. Sadly, it doesn't expect
such things at all. The only other multi-TD URBs which can halt are
control, but they are represented as one xhci_td and produce one event,
so either the whole URB succeeds, or it is wholly thrown out.

With URB_ZERO_PACKET, the handler is aware of two distinct TDs and if
the initial data transfer TD halts, it tries the zero packet TD next.
Only when that also halts or completes is the URB given back, and with
status and actual_length determined solely by the latter TD.

Fixing the event handler is possible: cancel all TDs of a halted URB
and ensure it will be given back with correct status regardless of how
and when are the individual TDs given back.

Or we can eliminate the problem using the control URB's trick, namely:

1. no longer allocate two xhci_td for those URBs
2. count the zero packet TD as part of the data transfer TD
3. clear IOC on the data transfer TD when a zero packet TD follows it

On success, we get one event on the zero packet TD and give back the
URB normally, confident that the whole transfer worked out.

On errors or Stopped events, usual partial transfer calculations yield
actual transfer size, including cases of events on the zero packet TD.
The whole URB is cancelled at once and given back with correct status.

The latter approach seems advantageous for a few reasons:
* It doesn't require the event handler to deal with an obscure and
  evidently poorly tested corner case.
* We have no real need for the data transfer completion event and it
  only wastes CPU cycles. Same situation in control URBs, so it seems
  unlikely that we will ever want to convert them to multi-TD model.
* Event handling code evolves a lot, while URB_ZERO_PACKET does not.
  This patch can be easily backported to stable kernels.

Issue found by code review, but reproduced and tested. Few drivers use
this flag, but we can patch any (e.g. usbserial) to set it needlessly.
Then it's a matter of sending wMaxPacketSize bytes while the USB link
is broken, for example interrupted D- line of a full speed device.

Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
---
 drivers/usb/host/xhci-ring.c | 23 +++++++++++++----------
 drivers/usb/host/xhci.c      |  5 -----
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index a879c569c2f2..9a963db11167 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -3664,6 +3664,14 @@ int xhci_queue_bulk_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 		addr = (u64) urb->transfer_dma;
 		block_len = full_len;
 	}
+	/* Deal with URB_ZERO_PACKET - need one more td/trb */
+	if (urb->transfer_flags & URB_ZERO_PACKET &&
+	    usb_endpoint_is_bulk_out(&urb->ep->desc) &&
+	    urb->transfer_buffer_length > 0 &&
+	    !(urb->transfer_buffer_length % usb_endpoint_maxp(&urb->ep->desc))) {
+		need_zero_pkt = true;
+		num_trbs++;
+	}
 	ret = prepare_transfer(xhci, xhci->devs[slot_id],
 			ep_index, urb->stream_id,
 			num_trbs, urb, 0, mem_flags);
@@ -3672,10 +3680,6 @@ int xhci_queue_bulk_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 
 	urb_priv = urb->hcpriv;
 
-	/* Deal with URB_ZERO_PACKET - need one more td/trb */
-	if (urb->transfer_flags & URB_ZERO_PACKET && urb_priv->num_tds > 1)
-		need_zero_pkt = true;
-
 	td = &urb_priv->td[0];
 
 	/*
@@ -3724,7 +3728,9 @@ int xhci_queue_bulk_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 		}
 		if (enqd_len + trb_buff_len >= full_len) {
 			field &= ~TRB_CHAIN;
-			field |= TRB_IOC;
+			/* zero packet TRB isn't chained, but it steals our IOC */
+			if (!need_zero_pkt)
+				field |= TRB_IOC;
 			more_trbs_coming = false;
 			td->end_trb = ring->enqueue;
 			td->end_seg = ring->enq_seg;
@@ -3772,11 +3778,8 @@ int xhci_queue_bulk_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 	}
 
 	if (need_zero_pkt) {
-		ret = prepare_transfer(xhci, xhci->devs[slot_id],
-				       ep_index, urb->stream_id,
-				       1, urb, 1, mem_flags);
-		urb_priv->td[1].end_trb = ring->enqueue;
-		urb_priv->td[1].end_seg = ring->enq_seg;
+		td->end_trb = ring->enqueue;
+		td->end_seg = ring->enq_seg;
 		field = TRB_TYPE(TRB_NORMAL) | ring->cycle_state | TRB_IOC;
 		queue_trb(xhci, ring, 0, 0, 0, TRB_INTR_TARGET(0), field);
 	}
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index d0662f9a0c2e..75d73d2add1a 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1626,11 +1626,6 @@ static int xhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 
 	if (usb_endpoint_xfer_isoc(&urb->ep->desc))
 		num_tds = urb->number_of_packets;
-	else if (usb_endpoint_is_bulk_out(&urb->ep->desc) &&
-	    urb->transfer_buffer_length > 0 &&
-	    urb->transfer_flags & URB_ZERO_PACKET &&
-	    !(urb->transfer_buffer_length % usb_endpoint_maxp(&urb->ep->desc)))
-		num_tds = 2;
 	else
 		num_tds = 1;
 
-- 
2.48.1

