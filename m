Return-Path: <linux-kernel+bounces-880290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB59C255A7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BA4B934503E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373F53396E4;
	Fri, 31 Oct 2025 13:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bls88kcD"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C34241679
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 13:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761918644; cv=none; b=qhQiOqpLnL75QkFgoa0tr9eHCI6Q3cOK50u0eZmuFbGweON1wy/zmNWS0rLPOHSWbVC07q557fqVeADK7Z4wfz2xoyfynp6PRLcGFIh5/SL3vYv2Qd6MsXW5A0C6NFE0AWT2VJr3fpto3W352wkSPONOlCZg0fveMcsew52W98w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761918644; c=relaxed/simple;
	bh=atwhmgVb77nhq+0LeDZj6Ml03uLgO6sIm+vbC28Qui4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R458f5MLEr9friYBMyET7SX6gWXXOPMPIyQmjW68u/39quVY3PwWIuNSE7NoY94+1W4VDcPkNd/snrZK2xQQ4pchZmjOJSzXiZTdVxun0ILpaQNbbhLPuOU7AYATBX8XiiiNHo5N9FFlqLnspaGge6hukKMzdA5y/bsTTGNCQHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bls88kcD; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-78af3fe5b17so2268434b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 06:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761918642; x=1762523442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fq99QZ8qEySnepXaN0MvrLAkz3i0KFCQh2dSWAfgdsw=;
        b=bls88kcDOF7uB3lhIV5zw33jUxbEMJg4I7EGPsfJKd87o/GxSDEd+FpyacWH06RWFe
         ponCYelbnc4PC9GoCFHq1wvSbQO7zUT1S9DNa9lOmLcI/0po/Dog9AEBgLxfycjpDwSL
         rFmOj5yI1DF77A0GY8kS8OFT8VDUQb220Wchi/PkP4nR1XF3L7B9oc5XDLq9oN/P/6NW
         SIitVjCtexkud7eyWq6cV0dDNzfULgZYlc6IkLsfIk1x301glfAHKROLXolkQ/hL1MPi
         y5hlbkfveVe5nTwHDTdgxgi206SJ8z73jNH/QtnghC8Rmn4tQj/mtspKh48lXuoQr4pj
         WSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761918642; x=1762523442;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fq99QZ8qEySnepXaN0MvrLAkz3i0KFCQh2dSWAfgdsw=;
        b=xK5ODuw6CumMi/CzspIhNaQMGR9qV42G/36VEnhN8SMwMOqIJ5CUsKi7fL/f3dwzl4
         D8aQdBQKcxzQ+iP7elO8FEwpQq5f7Yu+p81x2Ye94VadwbZYKe5WFiqlVuK+2TGlqsOO
         wu7B/tnVdbTgExEALl6pg+lv+LE9Mu8WMKFRl5mjwspaT8S9LVFYDSKMO+/XZKD+NI9r
         rOCATVELSWWOXtKVNK9CtnpvScQKye+gOa8vl+yZxOl3VXrhNIm8hGXGtJJ9fsYP4ZdS
         Mpv36twvTsCYXjUMEli0RwsfkSJCJulD/tSrVcvEsv0gtGq8GhlRa4JBl4gO0milQ2dr
         GMFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXp7cO2mc2R8UhCHyaq8CkgmsDJXKi2IEJNwX1IIP6K3jxkCgolUfm/P0VGwlzr/zKTjlelzRhY+aqw13g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPGcI3WFFJL0nfG2NoGRZXRiXExknFB1YtJtw3WX6+6FzresZ2
	7BBZZi0yTwqmdoCVVcsSUKdkozcdD9r+2DpE9vkMn9m9FRJ9pVvd6I3pig+dTfY=
X-Gm-Gg: ASbGnct1WdMzTyokmLa2Veevs+07zfyOA69aVl8sDcKXFrXGxBkoZoXCxfBuTNitqa9
	uB/ik375psbaKhzQjBkvIBx8kJD4Qm69v3HVwajBTFSnFCKwMuaAFo24cfvv1Z12Sip7XJ7L1b4
	OYRkr3Cg8T3OVQvNQml60so9LZ6qgHbpnpEXlWaQ6Z68HXE3c0dz1o2wPZIY9jcFC+OyCgpSg4U
	X70HakslAhUD6F/9NOhOtKJ4kmyPZo1wT4an6j9oZP8KCZXVOPDvOqS+VPg5Yq0FvBrKb6k7ofK
	caukS6xJZ5+34DACi0FHLrC4DoyyuoviWExd+Qs/VDJqJy5AQbTfLbBnbuyDKgupWc6mJSkpiWP
	1MyRr8sX7lEa/8ECpnLyIzNjxejpAwQRqTkP2BnnYp6U/rOiich8jYDfG2387xH2A0SlmEs1Pi6
	XqpdUZQyVcSYBTHRvJzWeZ072Cv1/Kfw==
X-Google-Smtp-Source: AGHT+IF7JYD2XOTJtQkstN5oP4uEEb+BywbjvfTsn5BYoz4+8+8KXQRgxqgGm9Jv8J28dx+z4JnHzw==
X-Received: by 2002:a05:6a21:33a0:b0:342:3702:97b2 with SMTP id adf61e73a8af0-348cc6ed97cmr5567276637.49.1761918642388;
        Fri, 31 Oct 2025 06:50:42 -0700 (PDT)
Received: from VSPRIME.. ([2401:4900:52f2:3b59:ca2f:95c0:7c6b:6e6a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d8e70e6csm2337308b3a.26.2025.10.31.06.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 06:50:41 -0700 (PDT)
From: vsshingne <vaibhavshingne66@gmail.com>
To: skhan@linuxfoundation.org
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vsshingne <vaibhavshingne66@gmail.com>
Subject: [PATCH] usb: core: prevent double URB enqueue causing list corruption
Date: Fri, 31 Oct 2025 19:20:32 +0530
Message-ID: <20251031135032.222938-1-vaibhavshingne66@gmail.com>
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

Adding a check to return if the URB is already on a queue
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


