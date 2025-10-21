Return-Path: <linux-kernel+bounces-863645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 27244BF8B13
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 22:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF310502AFF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46654274B30;
	Tue, 21 Oct 2025 20:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ssn.edu.in header.i=@ssn.edu.in header.b="VY4ouE8g"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6B71BFE00
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 20:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761077839; cv=none; b=CyldJhQhOAIim/dVjbx1RPqVC2BF/uO5y8hp7SzPB7hAMdJCZR28NfJd3TF0sJ0cgkVCbyZp06G3fXjOQ092wK3tJ2OQMI83mLW8kdDa7tY7sU7N/6hs8lYXXrsj9lih96q3S12P/ulxX6ndzEOzIfhCGKWe2DQyNeDKB9msdDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761077839; c=relaxed/simple;
	bh=3s9Hg8jMoBX9CiCTXq1M6Thci0WpmJxF38Djz8L/WlI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iO2x99n67O68SM5dbNd5RT/rpxL5f5cJAwgK2+HBDvun/88a5y1TytLLNpKuHli4e36yfzAXNBf95vmwd3dG+zAIITmJ9U40Y0hp+5ynYlruahC/nyBf00Tkxibd9AXo38ft1RTMjA+PA3dQ6zYCx5ibAWtpBOVKJ5GVaWVz9OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ssn.edu.in; spf=pass smtp.mailfrom=ssn.edu.in; dkim=pass (1024-bit key) header.d=ssn.edu.in header.i=@ssn.edu.in header.b=VY4ouE8g; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ssn.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssn.edu.in
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-27d4d6b7ab5so79530815ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ssn.edu.in; s=ssn; t=1761077831; x=1761682631; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fboqJCjCw6RVWXir/DI4EBNfbHyerzjrKQ29FGZhy8U=;
        b=VY4ouE8g6lRoGEcdfzSFyRucVnLYvEa3o1mMkK9RlCxpeIuXOVIrzP2zo2YO7Foy7B
         aLQpln3ucruxIjOhnNkBigAtHsN77nQ8QyyIfF+ShiJfSnHMoMZjZXeboKcZzzodhiwD
         mHkqKZqczv+RIXdScqbxGJrHmT3IJIdEMgjIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761077831; x=1761682631;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fboqJCjCw6RVWXir/DI4EBNfbHyerzjrKQ29FGZhy8U=;
        b=TKpOGG5j8SDXnk4huFSg7nfO3gRcip7MI5sJeegR74tZuGHuq6S5WVwrUg+bYnkjt3
         Ew3RPaHviD49VvFSavpB9cjNWNTn6I2JBd4/B66W4XlufoAbAdr9lyBsqtt8ipSnoovI
         CpiK2ZvbpELVyYqAdywvodcd0c+DWOh4sl6OOrZxPvqCWUdVkhgFogtwZqtZ/2p0BT7x
         D87d077tkOLdd5+GcO2N/TCJJrzBr3G/2DiUNUtMvhd5hRotH18a2UmNrQtKQhvXkRiX
         WN7iSbyuKS2PGOJAVuv7aGx+tJZEMTOTGDVQjDjN+Gfu5UYy47ZAZjcsvqSiPPm+rLLd
         Jipg==
X-Gm-Message-State: AOJu0YxGtG5XSLEhJakLlYDjAN5+wuXF0Fc5ihGfmC1ym1F04MGWYMAh
	8Epzi2arEG1fwP5NimWXBGVi2JUTSHyPQvL5+/tebrzsInPhhcKAAsJ6RaVkSKArnEr2vEpFaDX
	swtxqUUDinZWrIRgniXMX28sucqWhkmtKqbTTig3aHfjYmEY59f20dL6Hog01iT9xUpKonxPx+b
	qmlQ==
X-Gm-Gg: ASbGncsz/WKaIbByzDZCKFlbTGNGigD+t8FI8LSO17gt4eWpmT6OHGfdwgqAbXGBcWY
	5ztkmVcre2jOdFyYKRpva6rhdJPY2BHJMRzPkCMT5nmnCSdsRCAh9jLnwmdLfUCy+bcfktQS7/c
	14CdtMn3RO55RlZgreApqLIZ5bn4qV6jyT2fgz+4TOEODkVlARr9nbWensf9u8HSzcHTImQPcpc
	4U/h8kHMIOTLcFbIxLFzYuC6gMFQogdz6m2+E/1tPWwVrZob6B9MlMGOvRsHJFiFDWKEItlthtr
	7zidrYyXUOBrTlQz5XoKYlsb7O96p9XBFDGO98IY8Z1BIS88i1QYhOAjud0i8Mn6p4qqO50lpNP
	4+c9vmIz7+oWWvkhs8fa519mDvlKc2EIWzhPFE/YlTQjEHRb0rgZMcca4btswygnuqMewk9ImTy
	7FKN+3qsqv6yL+Zm/099fkc/Q8Ctyc0q/Mu0M9BNfqodVx9RfcmdC26aSsxvt5hhyLCAlS+MeSI
	i2O9VhIEFEcdUs=
X-Google-Smtp-Source: AGHT+IEUy/ejndszEfjZ3DhOlo0RzlR6VaDcA1yz8MEsmxWgkx1tI42kbduExxRtzT6d7bynvLJJAw==
X-Received: by 2002:a17:902:f681:b0:290:d0fb:55c0 with SMTP id d9443c01a7336-290d0fb5971mr217778985ad.43.1761077831617;
        Tue, 21 Oct 2025 13:17:11 -0700 (PDT)
Received: from biancaa-HP-Pavilion-Laptop-15-eg2xxx.. ([2406:7400:1c3:33f3:d5f3:33d1:a1e0:46bc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fdd10sm117171835ad.83.2025.10.21.13.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 13:17:11 -0700 (PDT)
From: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
To: linux-kernel@vger.kernel.org
Cc: awalls@md.metrocast.net,
	mchehab@kernel.org,
	linux-media@vger.kernel.org,
	Biancaa Ramesh <biancaa2210329@ssn.edu.in>
Subject: [PATCH] kernel memory safety check in a block
Date: Wed, 22 Oct 2025 01:47:04 +0530
Message-ID: <20251021201704.178535-1-biancaa2210329@ssn.edu.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"

Signed-off-by: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
[PATCH] media: cx18: fix potential double free in cx18_stream_alloc

The function cx18_stream_alloc() may free buf->buf and buf multiple times
if dma_mapping_error() occurs. This patch:

- Adds checks before kfree() to avoid double free
- Sets pointers to NULL after free to make accidental double free less likely
- Improves overall memory safety and robustness in error paths
---
 drivers/media/pci/cx18/cx18-queue.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/media/pci/cx18/cx18-queue.c b/drivers/media/pci/cx18/cx18-queue.c
index eeb5513b1d52..025ba4e6e4be 100644
--- a/drivers/media/pci/cx18/cx18-queue.c
+++ b/drivers/media/pci/cx18/cx18-queue.c
@@ -383,9 +383,16 @@ int cx18_stream_alloc(struct cx18_stream *s)
 						 buf->buf, s->buf_size,
 						 s->dma);
 		if (dma_mapping_error(&s->cx->pci_dev->dev, buf->dma_handle)) {
-			kfree(buf->buf);
+			if (buf) {
+        		if (buf->buf){
+            	kfree(buf->buf);
+				buf->buf =NULL;
+				}
+        		kfree(buf);
+				buf=NULL;
+    		}
 			kfree(mdl);
-			kfree(buf);
+			//makes accidental double free less possible
 			break;
 		}
 
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

