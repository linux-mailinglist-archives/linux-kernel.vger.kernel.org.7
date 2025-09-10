Return-Path: <linux-kernel+bounces-809727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2FEB5113B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56519161065
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C73F30F812;
	Wed, 10 Sep 2025 08:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxXVQbjd"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D035C275AFB;
	Wed, 10 Sep 2025 08:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757492933; cv=none; b=Q3sKCuJXtlr9SbYWMIM0526sCveFwQDJ3q2QbM3MTkyaiUNFZ3WYOWbCxyM9wfBOcvFxZBGAQ6mVt6PKOvvrOKXNH123PnA0/f2xb/71OyWQy16uwUTsWG+zj3BEdDZhAYdu+cIBPqp5rSzFVa88722GE/ngJcGc4moDol7iT/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757492933; c=relaxed/simple;
	bh=q/1ZE3PXAs88kpq1OOMpxNmoZPuIeIOeXhOw8k6yfmU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=YOaz1wQm0K9FmZ7PbdF3NB4ZbWhePtNxN/sj0nTctCSy8XMT5Vc7vzfx5LUYgkeyLASL/JBc+zH5GshhVqDFVg0MTjNsLc33NUj4nO8Y8SgU6JNG7NiWxK2S8gxkLmMVTTulStArRqZZmtFZBQX+ZEpKksCHjm6dTENgNPGPin0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XxXVQbjd; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-33c9ca16a64so32036591fa.3;
        Wed, 10 Sep 2025 01:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757492929; x=1758097729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Il1eL+RQOm+itMiKRM51rKcZfVj/Pae94v1C9COD6Mc=;
        b=XxXVQbjd7XK3SelKROjbbJFTXtRobGVFPtkN2mpJqnDDE7qXGXbY4vBnw5f8SiX+Sc
         cidUKFraXCBJWkYlWuyzByW5bXnpPPR3O9GZieyLvxhIbzXNKGtBYWIwzNT+5JfsbEll
         DiT6y/G442ijX2FoeBfss0oq0LOpCerX9r6GBdkYnOUvdIP8lasC1b+Itn/XC8XtKO/G
         ZFO5eggR1BTS8gZT362uyMiOJVmCvLrhNB0B+UDbZ65rOWrfTxdFbSd4yGfHHoDu2pkC
         QP4srT8Y8/cWojtaKW/BHqFhyt1dGAWyooHmZJhqgcc6NxC0swmSFQSG/gLZzCiT9IMi
         nrKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757492929; x=1758097729;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Il1eL+RQOm+itMiKRM51rKcZfVj/Pae94v1C9COD6Mc=;
        b=cZDTSvBuNApdTMOLTnEwym2ic4c2lWTo8ukljkkc9rklWQM++Pju0jOQ4RoMXpmh5U
         n9u4ZOeXxGflHSbXKuZblt7aBkhKWHW26IUUVYtTA/6R4Ydp6Td5fCeAl7RFNbv3IQoi
         aUiHlIArTZt/odKoRvuElxhtlEiIh+q8v7BPgx1vXo0HnRXe+NHZy+pMYlLhpRhbSEm+
         rN2/a8w9IwdbK9BTrvEJFoPachZvhcdINQsJvbj5eWH7xB9NnNQs1O/q6fsdX1CfB/QS
         hF+5oLSfMDm44LpQ60pZL9yANYI5R8ltlEGjiWYY/uyUIjqFYAEP08MhhIHhncCa8i5W
         0fJQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8drDUMJ9oG9pxbzTWn5Rx2Z+7S7uJBcSTR4aR8gRoxi3TklzWzi1VLLJ5iCgov+liCW5J3a9EJOz4@vger.kernel.org, AJvYcCXlbAu8nNLyJzqUTcaQy9Rp0HwJwlh/bAhzBqwm660f8tFhlwp0v+iAaL7SW9YpsghfZHhohDSxTPpx34o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2/Z7tO2sP9JOs8fb7xEQBVdGTBYRsJur6iHec6oZwmXB94Xmc
	VPELxugI/PRWWeKZEDFu4SQmumwC6SRsQ69D7ac5GL3TE3elc8ILU9eN
X-Gm-Gg: ASbGnctyeMxCNW5e3oXSos8lSFIWOx8K7iVwDCF5EMG3/Y1+6BMQyaX9ZILljxJxwmh
	WzsRIby4uwnsQqdAE/F8daDF6SST5DOwDSGDSAS2WR7MGdKp1o5T8eEZFflRgM5Y2aIc9JEMbmg
	Q+OyVcFz3jfbJJYAJv6RqZtlSMDUG3wMHxtrPW3TcEdlndTMzhi5gIh2t8foNKAF9yY9r1UbOZ9
	I6lUPRCV5J08jCXYSidqBIoqQ1EZ+tEaI1UqiyHLY/k/A7diKcx0mPP40rNpV6yRepX7GXyySy9
	GlViV1vW7yQ8R792aRZKiDrfRmvux8rufOdDyZshKEPfKvcVQ3iJMnOPFTAtTOlONa4DfzMuHJp
	ABoJHSsI8Q71vKyTqvhihpFVq4vh6hMgdKJ0=
X-Google-Smtp-Source: AGHT+IFfhNdaWAKQKHo6mTTPYGZiDqlB419AfQvtStJlwa8BybO4/MFstjUvPibjDFoxTMM/k/3GWQ==
X-Received: by 2002:a05:651c:1504:b0:336:c9be:c164 with SMTP id 38308e7fff4ca-33b603f5101mr38187041fa.45.1757492928514;
        Wed, 10 Sep 2025 01:28:48 -0700 (PDT)
Received: from foxbook (bfg216.neoplus.adsl.tpnet.pl. [83.28.44.216])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f5075c85sm40890321fa.50.2025.09.10.01.28.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 10 Sep 2025 01:28:48 -0700 (PDT)
Date: Wed, 10 Sep 2025 10:28:43 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: Niklas Neronin <niklas.neronin@linux.intel.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: xhci: Check for events pointing above DMA space
Message-ID: <20250910102843.61e4a277.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On systems with 32 bit DMA, we could get events pointing above 4G due
bad link TRBs, contexts or commands, or simply HW malfunction.

Catch this when truncating to dma_addr_t, log the anomaly, bail out.
An alternative is to handle untrusted HW-originated DMAs as u64, but
it adds overhead on 32 bit machines for no clear benefit.

In 64 bit DMA builds this check should optimize to nothing and all
errors are handled as usual "event TRB doesn't match pending TRB".

Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
---
 drivers/usb/host/xhci-ring.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index a879c569c2f2..a2100e0a5d0a 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1809,6 +1809,12 @@ static void handle_cmd_completion(struct xhci_hcd *xhci,
 	cmd_dma = le64_to_cpu(event->cmd_trb);
 	cmd_trb = xhci->cmd_ring->dequeue;
 
+	if (sizeof(cmd_dma) < sizeof(u64) && cmd_dma < le64_to_cpu(event->cmd_trb)) {
+		xhci_err(xhci, "slot %d command completion points above DMA space (%#llx)\n",
+				slot_id, le64_to_cpu(event->cmd_trb));
+		return;
+	}
+
 	trace_xhci_handle_command(xhci->cmd_ring, &cmd_trb->generic, cmd_dma);
 
 	cmd_comp_code = GET_COMP_CODE(le32_to_cpu(event->status));
@@ -2673,6 +2679,12 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 	trb_comp_code = GET_COMP_CODE(le32_to_cpu(event->transfer_len));
 	ep_trb_dma = le64_to_cpu(event->buffer);
 
+	if (sizeof(ep_trb_dma) < sizeof(u64) && ep_trb_dma < le64_to_cpu(event->buffer)) {
+		xhci_err(xhci, "slot %d ep %d transfer event points above DMA space\n",
+				slot_id, ep_index);
+		goto err_out;
+	}
+
 	ep = xhci_get_virt_ep(xhci, slot_id, ep_index);
 	if (!ep) {
 		xhci_err(xhci, "ERROR Invalid Transfer event\n");
-- 
2.48.1

