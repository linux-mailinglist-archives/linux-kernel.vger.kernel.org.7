Return-Path: <linux-kernel+bounces-812239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C52AB534DD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21E4F17BAC3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3203375CB;
	Thu, 11 Sep 2025 14:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5MOa2Qs"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882CD335BD5
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599692; cv=none; b=WH9o0EPESFPHko1NiVAlbiqj66m/dzr2CkHYuQ0Bib1XDVZv1s5wq3rLJsMFugNoqKCosYF1chvusqR6Er9as+mkVJpyM0eEGnjsbFzZQcaxQhPfx8yhx/AGvdw8mgWPlEGLXGQVa7V86jDg/y+Hw95xwH14S0I8p75cFanD0tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599692; c=relaxed/simple;
	bh=pKu0Q8EAbJVpObckDdIWXKemnFhtud6mTHguuPAlr0s=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KCS3++yjXeI9w7Hb7+tqtBUpXZaDgg963klM4Ju1RL4QczOw21P0uZZ0XEU+BnDFxM5Zyq01vdgdonSOXnVxPhziFX4djtlcFkJV4W5Wqr4hkdB/dKV/AocraQ0vK+eWgZDUc90L/USWqp/dxoKf7fD1de4eWZu/A0kT1cQRYYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5MOa2Qs; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-336c79c89daso7020271fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 07:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757599689; x=1758204489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lEYUaPTCXF1ndt/XouQ2I+RYB0uoybg2MOgcw/ffwQg=;
        b=F5MOa2QsAuluMrCeVIY7bzf1UMKAQstxLtRYQujOdKXTeiiJpCfzvN01wdcJj7mCI/
         RyfayfbYQFb9GeSiZD+X44H1WtXDLVBQxdiq4U/CtGhfzHU0Jk999EjfEj1SNql6GQM9
         zEftXsqihQsR0P/LnOCA0TSltpjWyVM3Cobw4W91ZmUIHCmPgrWVBFTOziMr7YbkZVRd
         q0jiVOVrnZ1ZO4v5/wA5+ImVUL5UOsKVDiF4jmMa8chevrdUZoecrDZ61EB7ycWNd8nI
         ltcfbTVLp/DzcSPrGRF7Sv0rVkk7sWqx4etkD+gg7mMV1aiZECVogntJGc2FZayXFN6y
         Sd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757599689; x=1758204489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lEYUaPTCXF1ndt/XouQ2I+RYB0uoybg2MOgcw/ffwQg=;
        b=JDWHmiIIVTQQiTfF3P/f2KTb6+Dh+xHcsld9OTP8UsZDxfskiRwFU3RjpxrvsTdmYf
         IfbpTN5UG4n7uBZcTPSFzMhZoYCttOsHqeL7TdWCEWk5lTrTWSThYX2gD2qlPlGtb0Aw
         r0jUhvZAyficpli31vzyIOcevAoRkxt5dZgIbyc++FJLzwLXA7c8zViIAfZFWOQxDVKa
         epZIbEQMaq2419avcw+qgayKKxHbqd12D13Xi6RQfRDHRSntZKBSHgPrF5gfB8S9mxF+
         dRHrMeSTuuQtqkmdHawKMzHEadB2BlaLWskCaL62xX4F8Tu7blkd0TWwfEXfvVBuvPzi
         TR7g==
X-Forwarded-Encrypted: i=1; AJvYcCWx0BJ9SzMK81x7oekm2FryrDiQ4W/fHkBqfMw14vx6dYW+E5PcFwg0H5WRiJ2MVVtPytQiNHeZ2g8B9k0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5eEJA/V3sIh9QYrnWQxdaFnR8G7uGw4C520pt3Ei9HZ+yVC+M
	1F2+zNXnxL+zYVHvD6mRlj+y9xvuzilHo8S8HBLwkwISUGbq2GNF5TwR
X-Gm-Gg: ASbGncsTd+/6CsXm1CQiURK8398ut4pcSU4GTIw8amjWFR9+hiSTWktbTEgkH9jME1j
	AD9jjYPtnloumamS9SmszUI5wLTMBtGWYdlJ6zTc+agAzhh9YUJ8Ovlrwzb/giVjSziSD4NgXQU
	y7tE0DdkBydsxtghsIEIJRIC5l2rYE1QnVsx7M2HbmmBhuvOqfUzh24ZSOCix70f8i1SUYePd/+
	IeenHpDtfHZxoPJ1J4aeK8GpKkXR8r/N1DAbWiVLEbpF7XPjEp1uJ5KxcKxdB5ZfHd5TzBegDZQ
	qoXmF7vVhXbO4j9SwE8za37jkSS/mP/qdCGpLnKOK2mw8CBQlJEDsiGANyBi/wCK57lodAxPomo
	n82i40eg8lNqa4C/Q+wSO35O/l+E5GCcoqIj71jB6b6tzUA==
X-Google-Smtp-Source: AGHT+IG75MABpH+ZcgXUx1S+VLbZp5FT5BTrTlJyAmSutNQJr5clkFGic3uy19fGN2nmXotPRz4Z5w==
X-Received: by 2002:a05:6512:3096:b0:55f:4db4:ffd0 with SMTP id 2adb3069b0e04-56260e4289amr6695798e87.28.1757599688364;
        Thu, 11 Sep 2025 07:08:08 -0700 (PDT)
Received: from foxbook (bfg216.neoplus.adsl.tpnet.pl. [83.28.44.216])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e6460dfa5sm433083e87.112.2025.09.11.07.08.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 Sep 2025 07:08:08 -0700 (PDT)
Date: Thu, 11 Sep 2025 16:08:04 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] usb: xhci: Deduplicate TD cleanup code
Message-ID: <20250911160804.2584c3ce.michal.pecio@gmail.com>
In-Reply-To: <20250911160632.46245dc4.michal.pecio@gmail.com>
References: <20250911160632.46245dc4.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

One case is almost a copy of xhci_td_cleanup(), the other isn't but it
should - a TD still on this list hasn't had its bounce buffer unmapped
yet or else xhci_td_cleanup() would have removed it from the list.

A side effect is that those TDs will now also be checked for transfer
length mismatch and their giveback will be logged. Should be harmless,
and the logging helped confirm that the patched code executes.

Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
---
 drivers/usb/host/xhci-ring.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 5233ed3e4ed6..34905c8dee25 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -901,6 +901,10 @@ static void xhci_td_cleanup(struct xhci_hcd *xhci, struct xhci_td *td,
 	inc_td_cnt(urb);
 	/* Giveback the urb when all the tds are completed */
 	if (last_td_in_urb(td)) {
+		/* set isoc urb status to 0 just as EHCI, UHCI, and OHCI */
+		if (usb_pipetype(urb->pipe) == PIPE_ISOCHRONOUS && status != -ESHUTDOWN)
+			status = 0;
+
 		if ((urb->actual_length != urb->transfer_buffer_length &&
 		     (urb->transfer_flags & URB_SHORT_NOT_OK)) ||
 		    (status != 0 && !usb_endpoint_xfer_isoc(&urb->ep->desc)))
@@ -908,9 +912,6 @@ static void xhci_td_cleanup(struct xhci_hcd *xhci, struct xhci_td *td,
 				 urb, urb->actual_length,
 				 urb->transfer_buffer_length, status);
 
-		/* set isoc urb status to 0 just as EHCI, UHCI, and OHCI */
-		if (usb_pipetype(urb->pipe) == PIPE_ISOCHRONOUS)
-			status = 0;
 		xhci_giveback_urb_in_irq(xhci, td, status);
 	}
 }
@@ -1304,16 +1305,7 @@ static void xhci_kill_ring_urbs(struct xhci_hcd *xhci, struct xhci_ring *ring)
 	struct xhci_td *tmp;
 
 	list_for_each_entry_safe(cur_td, tmp, &ring->td_list, td_list) {
-		list_del_init(&cur_td->td_list);
-
-		if (!list_empty(&cur_td->cancelled_td_list))
-			list_del_init(&cur_td->cancelled_td_list);
-
-		xhci_unmap_td_bounce_buffer(xhci, ring, cur_td);
-
-		inc_td_cnt(cur_td->urb);
-		if (last_td_in_urb(cur_td))
-			xhci_giveback_urb_in_irq(xhci, cur_td, -ESHUTDOWN);
+		xhci_td_cleanup(xhci, cur_td, ring, -ESHUTDOWN);
 	}
 }
 
@@ -1354,13 +1346,9 @@ static void xhci_kill_endpoint_urbs(struct xhci_hcd *xhci,
 		xhci_kill_ring_urbs(xhci, ring);
 	}
 
-	list_for_each_entry_safe(cur_td, tmp, &ep->cancelled_td_list,
-			cancelled_td_list) {
-		list_del_init(&cur_td->cancelled_td_list);
-		inc_td_cnt(cur_td->urb);
-
-		if (last_td_in_urb(cur_td))
-			xhci_giveback_urb_in_irq(xhci, cur_td, -ESHUTDOWN);
+	list_for_each_entry_safe(cur_td, tmp, &ep->cancelled_td_list, cancelled_td_list) {
+		ring = xhci_urb_to_transfer_ring(xhci, cur_td->urb);
+		xhci_td_cleanup(xhci, cur_td, ring, -ESHUTDOWN);
 	}
 }
 
-- 
2.48.1

