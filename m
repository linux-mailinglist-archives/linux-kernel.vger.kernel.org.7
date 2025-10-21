Return-Path: <linux-kernel+bounces-863502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F31BF7FF0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6984119A2069
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0E1348449;
	Tue, 21 Oct 2025 17:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ssn.edu.in header.i=@ssn.edu.in header.b="MBmXpQRL"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACD83557F1
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761069443; cv=none; b=Uu9kSIYdNM0c9b2JYz+wqhsxbqfZIzB/icLXnX86PQGEMeJkdIIEeQq0JZ1tpoYAYsTWSCOoFkH1Z30S6TSNgf9TKkt62ei+9g/nlcl1XMrF3MxkHYuQpChURGFW1YnN7M9zQPQBeKmetmWJMH5FdRVEurSzmdhz3ldjlUS2sys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761069443; c=relaxed/simple;
	bh=P6gOTDuxOa/YTaF/r+9WBSdmbFeLRsp1krHSzNxYKmo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NNIEXNxAaLNiTXVfJTR/qlSSWfDNIbRcz+UHxhpsF64qO4+uWZOn6YJIQcBnqvn9+L3YF5a6yPdf4XMnX4+hCyZlm2xiIJ49cAEjWYNXfsI8OYUWQLtU4ylkbE/fryZQ42VyerCB2JrJ7fVq7ohdG0Ng0OnKxZNmA35GMl3zPk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ssn.edu.in; spf=pass smtp.mailfrom=ssn.edu.in; dkim=pass (1024-bit key) header.d=ssn.edu.in header.i=@ssn.edu.in header.b=MBmXpQRL; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ssn.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssn.edu.in
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-339d7c403b6so5554799a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ssn.edu.in; s=ssn; t=1761069438; x=1761674238; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AcFoefsaPjLXkyzo6zOvLiCXIAfemQ8FPLpQYhQcMBA=;
        b=MBmXpQRLNns2IvxwmZLfGH2w+L5Wsi4k3l6qqognnwvIyl1wo8HJMo03TDN8xKLUZg
         +7SEed8RfuddGnHIwwkdQWYitrmENxjGltHHBrib+KgWJCWbeOHmKKPjKkwo6L/kt7yf
         jFi8XGoajMMSQKVvU89F/KP6zBRylo4bEC6VI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761069438; x=1761674238;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AcFoefsaPjLXkyzo6zOvLiCXIAfemQ8FPLpQYhQcMBA=;
        b=YebgMXSPZ9ybnwqDNq8FU/e5mU8vN6At0JjctCztkcvzCOzxQRfPM4hNM38ly9cmkY
         N3q3/xF7DueHVakq3uFJfJEJ45bpwnNzX+EA7HYblFTpHLcO1VYYPKnpPqqH4HFM/IMY
         I87sef0f2pnUn+lE/ugZkz/4vFtaZIUFX6nkLWw8ztr+WeyyV6rjWXfOZR2KQNQnknyI
         tdHgPn7bQvH8lL0XKPV85YTJNB5ffgpWPFGnp6aK3b/xxPi1zN+Py8Vtmjzf7jR5MnRp
         StSOTa9b4aGQ8s5XMx1L4RohdURoUZiFGQiDwgvxND+KpAWMjoe081NrmNapokanN3lZ
         0pGw==
X-Gm-Message-State: AOJu0Yx6PKpFP+uM3fUKc8OfEGP59ZpugyYyR2YpTwpdcuGY+Vlu56Ee
	K5bYX0aPlqPBwxZAmenYPeUod5/Rxxu9xpGMBf8Tbcpspf8NChlod7KLzuHp1V4M5bzzT2SgnCK
	925nrh5onjIQojIoAaV9d6+btsO5WC+N4iD8ufChJ1JX5ytwFBFYpk665JGi7NQ84CPRYCQRIXp
	c=
X-Gm-Gg: ASbGncszaBGG2HXdVz66qZm2dAWEJPPrmBve/x9eUgM1DlsPIHkez+ZHOAT5mWFafvg
	w5gJxcjSlADLyLVuoEWcU/x9YxwIVNwCNQ7C+c6f2plKqV+UBgDvMFoMKXjulrNMcqt7unhbhCr
	eXtOFAdKXSycZBPYbqBGb/vIPBKG4ITi4LkCC3vLQxStdn7E6cQPz9eAmPh1bH8VcPFhtXbJroT
	xmAWCKgSd50ItmrMbFEgTyWZfzQ9j7A4rOidgJ8KMYqbfyDdgn9vU+GARDRb0/RFckNO5II+FkU
	V65Mp38z/8Pfty/b5WM5DzbfX61YzVSgOU4n2a9tiL8zrHvb68oye869OAfM2qfX48tEv7/F4vy
	y9V6HpF0JXyx/T4pbm1+rdIBnO2TH6ABLSiG8RBY76ZyzmQ/2qQVbDL0Acnozb+2xCKure2SUgo
	j6JNQpeI1KLDuF1zqhaKY60jzAdIYquhSh+CSl9jVWAFFwuxDuM7PrCNvtRP/ekFC/1Rn+LLrD/
	+cm7+z+1aivvoM=
X-Google-Smtp-Source: AGHT+IHMeMIqd7HYhWo0R8En4guDZNNRMCYAnayKlf4Yiqw/2uDg3GDyf007UNqITSS1P+6Pah57pw==
X-Received: by 2002:a17:90b:1d44:b0:32b:ca6f:1245 with SMTP id 98e67ed59e1d1-33bcf85b2ebmr21081722a91.5.1761069437830;
        Tue, 21 Oct 2025 10:57:17 -0700 (PDT)
Received: from biancaa-HP-Pavilion-Laptop-15-eg2xxx.. ([2406:7400:1c3:33f3:d5f3:33d1:a1e0:46bc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223dd9e3sm188868a91.6.2025.10.21.10.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 10:57:17 -0700 (PDT)
From: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
To: linux-kernel@vger.kernel.org
Cc: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
Subject: [PATCH] kernel memory safety check in a block
Date: Tue, 21 Oct 2025 23:27:11 +0530
Message-ID: <20251021175711.49252-1-biancaa2210329@ssn.edu.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"

Signed-off-by: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
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

