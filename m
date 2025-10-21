Return-Path: <linux-kernel+bounces-863567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 261D9BF82E5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 21:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 641B8356CE7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9C3346E7A;
	Tue, 21 Oct 2025 19:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ssn.edu.in header.i=@ssn.edu.in header.b="WFg8b8Tj"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766E034A3A3
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 19:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761073241; cv=none; b=dLX5jxrUbCA7UdLlf8ABzMZvKDxipexdvCwvkIoTLzLCg9eikAQI/hyaqrhmdkBkI8QljKQE0aNrVOsnZ+LyXPXg5m0jn3Az+npM/4b9j57mOm+zRykieMyF/peQAO6SwIf53GadgwbeHQd4l8TiDk/Cy0ErV/fYldu3G6dS9lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761073241; c=relaxed/simple;
	bh=SVw5VajVisOLqc5P0MjYSlOIrjy+n7zn5M5S9V6muaw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AVF9eN2h5uRbrd0vFFdz62Txq4tEsZipFSWIh5CVFMZeoxA9NxN86XCJyHpb5dpfL/+GSKup/6vjnyFcyBm+oQc/RVHvZ8aWu3RAiYYkYpzUwqmmhspFSsE/pRaCfhBYzlEZ28MpoUDdtk4JQrTDYrYo3x1QdB8phpxswB+0tmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ssn.edu.in; spf=pass smtp.mailfrom=ssn.edu.in; dkim=pass (1024-bit key) header.d=ssn.edu.in header.i=@ssn.edu.in header.b=WFg8b8Tj; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ssn.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssn.edu.in
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b6a225b7e9eso4254369a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ssn.edu.in; s=ssn; t=1761073228; x=1761678028; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aQuePNcODnSleaf7SYTFYNuoiADvPoXlHCV+ySNuzT0=;
        b=WFg8b8TjHahrybAyxRcxp3wkm8wfS7xl2UGf+OYqnRwPYdZSh+8QeOlTrqJTzqTw/z
         egsQZIkhqOttuUZLP93UnwKNN6sKeWOWAoO2sEJ7130gUY3zPsTmusJj68utq/F/zA0O
         YNE8aftiDGfXYavVuEfN5UzjRdjQ7kLW8CjN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761073228; x=1761678028;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aQuePNcODnSleaf7SYTFYNuoiADvPoXlHCV+ySNuzT0=;
        b=C2IjlgDIGEJdmw5nPR+hySO1usvjvMVtrjWI7+sTEaiyTjaLazXflVwXlfiY3QAnee
         Qx961Zpf/RA7/4nmbpRZXB4f+UnFMaqP2uYYwqIeCB6XV+YIvP64fxgJnZec9X0fJQzM
         aLw83Q2rojMsi+h8V6kglbKEtFt8Hg2MnSjP5Gy41+1BbK10Wshlg/NEf8yVile0ep8l
         Y2wZS8/d+M1oFrD3WweJXT0anT75ZPO1P4EvGSBUSLMQUfzUFUbo/Jw+B6b0rAoc1Ct6
         kdq9d1qxnw0W/2vNTRywFYrl2eW3IYH2EW8YWiEM4O51LcAV+dkOe/5E+OmC7C89yxMH
         Rv6w==
X-Forwarded-Encrypted: i=1; AJvYcCV4FkFMD0MTrmYm+ba0nqOp9ckMcvjTSWacgW3yyAQkIKTbIT0Cd80/ADAxj4On0LJp8kxt5SVLXwSxtpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzUQF50hzFVzwkEfjTwH3wVwHFHo+WWmDvClPhAkd5NgeNI+jv
	8OExyk8CIAu5VyPK6Z2B4h30aZb1Xwtq/eJrp9SnQdp7O8jlqYvpnsSbLze7s1NhcJ0F5T8mOiX
	ql+RniGsiakNrin8GpAWiXwEh0kJrU0mdGBd8ntNELDwEIsBtRyUgSTAS+8pGxVzbB1D+t0aAQm
	oDtQ==
X-Gm-Gg: ASbGncvm0XyRQnDMt5gphjeS4c38/hpE2HqbJgLGzL2r5B2fd/WdgR6GU6/HmEjSrbf
	qCpDEPR8vX0B/WvK4DNlLjUxy9nDXgrKizs6BpIe0VaXIGTYEW3nymAdd3eDvsSeaVOwwzyXk88
	bdFeYJWRn7gxZyIb0c9AjB/30QPoJWvSn/LVaPxlKKRLjakeiPx/vcOv4E0PpngyFqRUyhxt0nq
	CmGwrsW0Q+FMO2Jq5bi0ir5LWJxuChkW85hEdk2GQEpn4ItJTvSfX2VheI/k8VYd2EgyHOvfNZ6
	0EfA55KEDVub35QvVkLKnT2gpOyJb+K+xlxK1e6Ap2NZCoqqMizQOlffs4WDHJlf5ZKJj6TWlxF
	gAfw4Y54zF4He8m8g5x2PlaB6u3FhfFLC75DlWXNbxG7WSadUZyRyb4YFtdSnhj9Zjm8N6OCUjT
	K2GuE55IXFOQmrAlxhIHsHN30tO+iSxTX79pC0qnC54oCfrPpyWwgpaCtqS69jU02gL4epdSse9
	rpc
X-Google-Smtp-Source: AGHT+IEuvU4rm2C2+oElaDaQ7AiljBoqcSbuyBhJQNtPr4w+UTmbbmdsfk2ZrQR7we4gjves5pSL5A==
X-Received: by 2002:a17:902:f711:b0:27e:eb98:9a13 with SMTP id d9443c01a7336-290c9cbc077mr204352375ad.22.1761073228237;
        Tue, 21 Oct 2025 12:00:28 -0700 (PDT)
Received: from biancaa-HP-Pavilion-Laptop-15-eg2xxx.. ([2406:7400:1c3:33f3:d5f3:33d1:a1e0:46bc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33dfb683d79sm1364524a91.2.2025.10.21.12.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 12:00:27 -0700 (PDT)
From: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
To: linux-media@vger.kernel.org
Cc: awalls@md.metrocast.net,
	mchehab@kernel.org,
	linux-kernel@vger.kernel.org,
	Biancaa Ramesh <biancaa2210329@ssn.edu.in>
Subject: [PATCH] pcmcia/parport_cs: Refactor probe function and improve error logging
Date: Wed, 22 Oct 2025 00:30:21 +0530
Message-ID: <20251021190021.173748-1-biancaa2210329@ssn.edu.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"

- Replaced pr_notice with dev_err for proper kernel error logging.
- Added explicit cleanup of link->priv on failure in probe and config.
- Improved comments and readability in parport_probe() and parport_config().
- Ensured allocation checks are consistent (kzalloc returns checked).
- Minor refactoring for clarity and maintainability.

Signed-off-by: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
---
 drivers/parport/parport_cs.c | 38 +++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/parport/parport_cs.c b/drivers/parport/parport_cs.c
index 8e7e3ac4bb87..c6d3f2ee03f7 100644
--- a/drivers/parport/parport_cs.c
+++ b/drivers/parport/parport_cs.c
@@ -83,19 +83,35 @@ static void parport_cs_release(struct pcmcia_device *);
 static int parport_probe(struct pcmcia_device *link)
 {
     parport_info_t *info;
+    int ret;
 
-    dev_dbg(&link->dev, "parport_attach()\n");
+    dev_dbg(&link->dev, "parport_probe()\n");
 
-    /* Create new parport device */
+    /* Allocate private driver info */
     info = kzalloc(sizeof(*info), GFP_KERNEL);
-    if (!info) return -ENOMEM;
+    if (!info) {
+        dev_err(&link->dev, "failed to allocate parport_info\n");
+        return -ENOMEM;
+    }
+
     link->priv = info;
     info->p_dev = link;
 
+    /* Enable IRQ and auto IO for configuration */
     link->config_flags |= CONF_ENABLE_IRQ | CONF_AUTO_SET_IO;
 
-    return parport_config(link);
-} /* parport_attach */
+    /* Delegate actual configuration to parport_config() */
+    ret = parport_config(link);
+    if (ret) {
+        dev_err(&link->dev, "parport configuration failed\n");
+        kfree(info);
+        link->priv = NULL;
+        return ret;
+    }
+
+    return 0;
+}
+
 
 static void parport_detach(struct pcmcia_device *link)
 {
@@ -141,10 +157,13 @@ static int parport_config(struct pcmcia_device *link)
 			      link->resource[1]->start,
 			      link->irq, PARPORT_DMA_NONE,
 			      &link->dev, IRQF_SHARED);
-    if (p == NULL) {
-	    pr_notice("parport_cs: parport_pc_probe_port() at 0x%3x, irq %u failed\n",
-		      (unsigned int)link->resource[0]->start, link->irq);
-	goto failed;
+    if (!p) {
+        dev_err(&link->dev,
+            "parport_pc_probe_port() failed at 0x%03x, irq %u\n",
+            (unsigned int)link->resource[0]->start, link->irq);
+        goto failed;
+    }   
+
     }
 
     p->modes |= PARPORT_MODE_PCSPP;
@@ -158,6 +177,7 @@ static int parport_config(struct pcmcia_device *link)
 failed:
 	parport_cs_release(link);
 	kfree(link->priv);
+    link->priv = NULL;
 	return -ENODEV;
 } /* parport_config */
 
-- 
2.43.0


-- 
::DISCLAIMER::

---------------------------------------------------------------------
The 
contents of this e-mail and any attachment(s) are confidential and
intended 
for the named recipient(s) only. Views or opinions, if any,
presented in 
this email are solely those of the author and may not
necessarily reflect 
the views or opinions of SSN Institutions (SSN) or its
affiliates. Any form 
of reproduction, dissemination, copying, disclosure,
modification, 
distribution and / or publication of this message without the
prior written 
consent of authorized representative of SSN is strictly
prohibited. If you 
have received this email in error please delete it and
notify the sender 
immediately.
---------------------------------------------------------------------
Header of this mail should have a valid DKIM signature for the domain 
ssn.edu.in <http://www.ssn.edu.in/>

