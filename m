Return-Path: <linux-kernel+bounces-880282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A233CC2556B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 523E14E42CD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24ACB3431F0;
	Fri, 31 Oct 2025 13:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTQsfIJ9"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299B22BF017
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 13:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761918471; cv=none; b=btJ68O6ZwZxZl3uwSMTinrBj5ooXYOOhG6NYcUeJ5zlxgBQbZ8ICXfEGSCZ7UShGMODNi8Y9o92pXVHl6xoKclu8GpT5P7352okM/1rZ4hLnOC/09TMXuR+m8Z1B17XgeUIZdnERloynP8LbH1n35R1QjxLy1bP3B+dWDhGHNww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761918471; c=relaxed/simple;
	bh=lv9Fkug8UarBKmWSdJNWbQ+qkbQQqSj5ooPZo0eIpzo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=akiCFzGH13zIFJ2ZWa22vqsMuSEpqOrrMZqDe7LNgDofdPs5DBcjXxBXZlJysonvfVCvxa/WP9ob4EV/EGTa+UA8uudYE0cDlwXnPyp7n7Zuxzignv3oVIJwOZ4UNQPhRoSbNBHot98/NwHfDlBmU6cECwL9RcDmhFFOPACtsIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bTQsfIJ9; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b6ceb3b68feso1857593a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 06:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761918469; x=1762523269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vTLpp1CXptXP5Avq6h7xCmd4Mk+qUexmMRpLJiy3rE8=;
        b=bTQsfIJ9+d7GQrGN1IGGHbjXoNXGiAeuaw+1nBBG9baw2t8q8kLHPct07b/KkaFY5D
         4Y9ivtVJ9Ne9M5PuNaJmS75d9A+jkycVWRwkwDmvEl5kwU42PHUkjYg6oC2fIn+fsGMJ
         0y3HmROpy4ny7ktIK0dY+n3dvKn8XgBaOdzAEjzLMipgg8ANwIxhx343HEce/lbmHzdK
         uc0Kyc5OA8sIx4CGMh8wqYax2kHEL5WqsETQDbW3wRWPvAz+oGxJrOuKBfj5WaAvhppF
         2Pfw4lL470SMittOq6zMInGc/LScVK3lGUs7zBwTL3IdfG1kShfTOaPAocp9UEd6Fw+u
         fNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761918469; x=1762523269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vTLpp1CXptXP5Avq6h7xCmd4Mk+qUexmMRpLJiy3rE8=;
        b=V3bLEsDxmGDPQ+NoH8g0JAwEStrPTprY02AESRKBWwirmXRh+46D/0aqkCktLJgbFZ
         7+r1nukxuVxo4xAtHwMsucpotgsZCc+JysXuE8Kh/bOcPC6qvstDZ5ZaCDpnK9BnLQWc
         ITocbsAZLBAKNaxqOLuL2Sz+RFGaG8hMdJr//pTOAgNb5ZGtGG7C2AzvJHsVWwagtAZx
         RA5QC5nBGyN56Abd6FAl2AYM2A0TKDcVjSh8ytUaN2HkWQPD3lMwHB8MqA9FdC4WMMDK
         hnHM6eDMfGy9x62+WFQ2Xi1YhU256bJ/4B+9ai05FwbbdklZ3K8uDisIqGqvs2+usLSk
         g6qg==
X-Forwarded-Encrypted: i=1; AJvYcCUmp+VPZiN2p+51UK+HJmlPEWrBlZv9b1edx+GWA1hYk8TjsMDvBLfWj5GfKCbgWR3FN5zSvnbouNSjz9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKFlc5ce8VMFIv5HyTHc9YWU+BFB3VJqDVHX8mRwuY49Pr888M
	JLdx6t4QrYB86Vypcel/dPOZaxILzUaTcTWvI4dIEg/khKXUJeaiWu0=
X-Gm-Gg: ASbGncsDxL/maj3x9dCE9NqSe6+rBfkRxG0Z/iPSGeWJiYQ8cAWcfl2wqVzbezKIqCa
	MgCd62t+pWEmEyJgH76mH20C9G1QNAtsHGWP+LU6ZuAIeLuETRife/IAo6xtoZJ+8PH8nVLJ2hT
	nzRuSiL3wKd8ccSIJC6ogha8kXfRWQgRy21ICwvARGg542rabdSK6ZA3fz7MiHq9ppDGeQ47/jn
	OabizsMrwT8wB5LOpKfsIDT98q+sRjTrng+jLRh1+TQxScjZEdptTSb4JEuNMMfePJawIdTfI/u
	MmxQ+77DT2rOdP6gZqEiBF8gLz1vb14ASrRjM/P5ufb4c89qHBMaaIwl8mmda+9wYZ9LANMI+FH
	lomrWpngMKjAH/FXPFsMSTUA43ygwBruhAfNdgYaP7zKC4NAiyVl2h3PdqqS7jPv/hbuds9CNoy
	2DkRQedWIn9EDDThplcag=
X-Google-Smtp-Source: AGHT+IFVleGd6d3qrffkbGaQm6oVAD7m7ue1Q8ELzAj6WTVMPmkx761XB58Q9EV/1aJXIUifd9ioFQ==
X-Received: by 2002:a17:902:e54c:b0:282:2c52:508e with SMTP id d9443c01a7336-29517c194fcmr54681425ad.8.1761918469347;
        Fri, 31 Oct 2025 06:47:49 -0700 (PDT)
Received: from VSPRIME.. ([2401:4900:52f2:3b59:ca2f:95c0:7c6b:6e6a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952689e942sm24650595ad.25.2025.10.31.06.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 06:47:48 -0700 (PDT)
From: vsshingne <vaibhavshingne66@gmail.com>
To: skhan@linuxfoundation.org
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vsshingne <vaibhavshingne66@gmail.com>
Subject: [PATCH] usb: core: prevent double URB enqueue causing list corruption
Date: Fri, 31 Oct 2025 19:17:39 +0530
Message-ID: <20251031134739.222555-1-vaibhavshingne66@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prevents the same URB from being enqueued twice on the same endpoint,
which could lead to list corruption detected by list_debug.c.

This was observed in syzbot reports where URBs were re-submitted
before completion, triggering 'list_add double add' errors.

Adding a check to return -EEXIST if the URB is already on a queue
prevents this corruption.

Signed-off-by: vsshingne <vaibhavshingne66@gmail.com>
---
 drivers/usb/core/hcd.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 87fcb78c34a8..66861f372daf 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -1758,16 +1758,15 @@ void usb_hcd_giveback_urb(struct usb_hcd *hcd, struct urb *urb, int status)
 		pr_warn("usb: URB already linked to bh->head, skipping duplicate addition\n");
 		return;
 	}
-	
 	list_add_tail(&urb->urb_list, &bh->head);
 	running = bh->running;
 	spin_unlock(&bh->lock);
 
 	if (!running) {
-        	if (bh->high_prio)
-                	queue_work(system_bh_highpri_wq, &bh->bh);
-        	else
-        	        queue_work(system_bh_wq, &bh->bh);
+		if (bh->high_prio)
+			queue_work(system_bh_highpri_wq, &bh->bh);
+		else
+			queue_work(system_bh_wq, &bh->bh);
 	}
 }
 EXPORT_SYMBOL_GPL(usb_hcd_giveback_urb);
-- 
2.48.1


