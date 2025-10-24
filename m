Return-Path: <linux-kernel+bounces-869529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F568C08128
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 22:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 778224E23F7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811D12F5488;
	Fri, 24 Oct 2025 20:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAsCUngq"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735A71F03C5
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 20:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761337989; cv=none; b=c07jrRpRW/W/AVQc4Qp2/yJUlodEVqujMArQMGUhUwhMUrHFenawhg9jHTr0nK3RgiUXIKRwdDq4k2B08YXKReWLFAftdcRTtDP61X8dDkCwwRPZpb2Q65Y+AgGbiaCqT6K/c5cvOoN5V5vW/O7FbsGR64dJ2R6EC9hNb1XjNCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761337989; c=relaxed/simple;
	bh=M+QKMmvV0bNnfc2WljclJUjnbTezHccdmqdJwxLZIfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JCHIeQfnlGxFtWF8ZwbYW1m9Jj/uDc5YI+V4OSglR67j+XOQmMctIA3dq3Cis4I6qZ6mHFxF3SmiyBu6f8V1WeRI5So30I6+R1aYiJI78PHpxEygefcaU8nfHWILWDauqWaFQ9smSzv8PaexMo2Zk7Ao8DfQ5rt/q4UyaIb6fuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HAsCUngq; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-78af743c232so2464238b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 13:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761337988; x=1761942788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HT9OXi9xpvGg82iMjJaDP+584hWboOuM7qgkAJ2wEJk=;
        b=HAsCUngq1+2wqwOhEpb7i2uwxRXo7L6kksGq5I6GBCsj/tUibnDcD/xknvrxxq3VYX
         eVZRey7DzyBJLakLRYLTpVTFBFBGqPvS63w2OyYf8lmKA9rms4OJK3LZYQ2Vq/1HFmRV
         6lPCahJMScheSTNpg8unrH/lefTW2w3zrj+Y/U137FM+DGMoZc6r1+6bwA2v8FfDSpkp
         w4yQs1JOKI2tA9xiGZnKtgg5Irg1VBT7Ms8P9uGr0sMjxo7x6N2lG6GXs31W2xyKpykz
         VyGJJ5Du1i+4m/r+wPo19s4jyQnRM3oyJpmu6c52X+GhT1B9m6Zusn1Q7dqwQv+vVQhe
         L01Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761337988; x=1761942788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HT9OXi9xpvGg82iMjJaDP+584hWboOuM7qgkAJ2wEJk=;
        b=MaKh2iLmtvZk1EOjOCP2RXcJ+l+Xm7a4oC5tgoFXaQy/IidqTMwvGEFo5heSUU/bYJ
         E0rEpObFgIbzgUKFLeaap6K/EvkbfJ671mC52aP7Va5i5pDHTg24zp2tTxPAaRvXsoV4
         i1EBx8ipUTD9dmlY801F4l9vIfYSk303JVQXCL+h10c+bDHJkax6ngMVqtDGfT6gPvkI
         /ISjRbhGjOLF10C+q79qVRMxDLSEFy7E/vyPeuPm7EzsjPxommM3w+wgPgvThj1Yn6lA
         IqH6GfvH2XnioUrLnPXt+VSUMB/hmsWbRdFdsH/5uDFcJ7p8U/9B3/84dsB0VpwsPFik
         0VAQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8SVlHe7Srq/E/kj9YMn1eh2KhCa4y8FqbvLPxm3kNmunl+vtTrmfzHQ+GPLmRqAR5m87rcRFpYaUQ/og=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu0eVF793R7XXVlO1oqX1mmklxxYViBB8SFsGp1LSIw8dIp9Ox
	nRk9g1hTXTIqr6mTSf8HxrBRA1uUJHkOpwXfI5kXZxfCGAFtQri2WlBS
X-Gm-Gg: ASbGncvt/tHui0fHYIxa43hPmjeBLVbtc3Hta7Lm9zTUcrML7Zvt4f5tfXIArCNZmNm
	EEB1uKJdogeWYVqUejzO2vfmJdkd6dO0i4EeT6OrMYa52MazV5qNES8HYmZ6dp5p9Yv6TabubXC
	gRAZL9LPV+vXr3IGlfUzh3YcFix27kiW3RZ9xWKOT0reS9Tggktvz/CGSPXuF6q0+3lAH72yMm1
	PkSaIlsbYYnzBVkARPjlAEFsOBYvA9qTwgETxtlM3jY1SUYtxPlUhzRXU951IOhMPuDnCsYb8vS
	cRY20PxNXmeWYJecdKvzvJCBaOVMmqZ1Jll55gSnQ5GfEiRHhhw59R5lKFe3lR3hlyQG2mzKk07
	ITUWKzHiwAN9591xwg/xLfUjHE4MXDTxJzbaG8kirvpnxtNXDkjwu+bLv/Tj4XHDalD22apm0Ws
	xl+KY83J3WR+aoPgRyZ4NJKgT7dBoXktuEugIFnbfGLU8OzDJ+KuuzVNxjS46PkSfZ1Q==
X-Google-Smtp-Source: AGHT+IGM1Dfat1jFWLD+mla/ZVzpPBcGl/Gp9rm91qQtIDrO11XCxDElasjpjla05zS4qVgbiHDugg==
X-Received: by 2002:a05:6a00:92aa:b0:79a:fd01:dfa9 with SMTP id d2e1a72fcca58-7a286765c70mr4265309b3a.6.1761337987653;
        Fri, 24 Oct 2025 13:33:07 -0700 (PDT)
Received: from prakrititz-UB.. ([2a09:bac5:3c3b:a82::10c:5b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41402e570sm113125b3a.15.2025.10.24.13.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 13:33:07 -0700 (PDT)
From: Nirbhay Sharma <nirbhay.lkd@gmail.com>
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Nirbhay Sharma <nirbhay.lkd@gmail.com>
Subject: [PATCH] firewire: init_ohci1394_dma: add missing function parameter documentation
Date: Sat, 25 Oct 2025 02:02:19 +0530
Message-ID: <20251024203219.101990-2-nirbhay.lkd@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing kernel-doc parameter descriptions for five functions
in init_ohci1394_dma.c to fix documentation warnings when building
with W=1.

This patch addresses the following warnings:
- init_ohci1394_wait_for_busresets: missing @ohci description
- init_ohci1394_enable_physical_dma: missing @ohci description
- init_ohci1394_reset_and_init_dma: missing @ohci description
- init_ohci1394_controller: missing @num, @slot, @func descriptions
- setup_ohci1394_dma: missing @opt description

Tested with GCC 13.2.0 and W=1 flag. All documentation warnings
for these functions have been resolved.

Signed-off-by: Nirbhay Sharma <nirbhay.lkd@gmail.com>
---
 drivers/firewire/init_ohci1394_dma.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/firewire/init_ohci1394_dma.c b/drivers/firewire/init_ohci1394_dma.c
index 48b879e9e831..121f0c2f6401 100644
--- a/drivers/firewire/init_ohci1394_dma.c
+++ b/drivers/firewire/init_ohci1394_dma.c
@@ -167,6 +167,7 @@ static inline void __init init_ohci1394_initialize(struct ohci *ohci)
 
 /**
  * init_ohci1394_wait_for_busresets - wait until bus resets are completed
+ * @ohci: Pointer to the OHCI-1394 controller structure
  *
  * OHCI1394 initialization itself and any device going on- or offline
  * and any cable issue cause a IEEE1394 bus reset. The OHCI1394 spec
@@ -189,6 +190,8 @@ static inline void __init init_ohci1394_wait_for_busresets(struct ohci *ohci)
 
 /**
  * init_ohci1394_enable_physical_dma - Enable physical DMA for remote debugging
+ * @ohci: Pointer to the OHCI-1394 controller structure
+ *
  * This enables remote DMA access over IEEE1394 from every host for the low
  * 4GB of address space. DMA accesses above 4GB are not available currently.
  */
@@ -201,6 +204,8 @@ static inline void __init init_ohci1394_enable_physical_dma(struct ohci *ohci)
 
 /**
  * init_ohci1394_reset_and_init_dma - init controller and enable DMA
+ * @ohci: Pointer to the OHCI-1394 controller structure
+ *
  * This initializes the given controller and enables physical DMA engine in it.
  */
 static inline void __init init_ohci1394_reset_and_init_dma(struct ohci *ohci)
@@ -230,6 +235,10 @@ static inline void __init init_ohci1394_reset_and_init_dma(struct ohci *ohci)
 
 /**
  * init_ohci1394_controller - Map the registers of the controller and init DMA
+ * @num: PCI bus number
+ * @slot: PCI device number
+ * @func: PCI function number
+ *
  * This maps the registers of the specified controller and initializes it
  */
 static inline void __init init_ohci1394_controller(int num, int slot, int func)
@@ -284,6 +293,7 @@ void __init init_ohci1394_dma_on_all_controllers(void)
 
 /**
  * setup_ohci1394_dma - enables early OHCI1394 DMA initialization
+ * @opt: Kernel command line parameter string
  */
 static int __init setup_ohci1394_dma(char *opt)
 {
-- 
2.48.1


