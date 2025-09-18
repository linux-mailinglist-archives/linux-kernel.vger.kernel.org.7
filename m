Return-Path: <linux-kernel+bounces-822240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE13AB835E6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69CC24A58C9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8E82F1FED;
	Thu, 18 Sep 2025 07:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gm8nOtMV"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD9D2F1FFA
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758181172; cv=none; b=Bm4Mdfn168s6NmYQQAeMj7b+bgRt1KQWrrL218fTTe5EOYcrLzVX241qCh9TDBqOWmeI6F/WXoCew2d2Ca4GOvNfG2o7S5PXBJkJDqqqMCK9q8pRxdw9vqSQd3uj4pmCfgRzMiPdE5s+lcmU5ZfUe8m8kGHrukoFr7jdqY6/SSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758181172; c=relaxed/simple;
	bh=A+kgl3pP41bBhorqPw1acgSIN74xjFREHN1mNj1smKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aUhFds3UtGo11E6FJJ5xyLWRlbWIHLclXtFKzgifh7ihhGT27FcdGEc1kwPlZJ3RZp4zrW61rvpHNPf1mSEsRTmNApQ6zNBjt2ilxgNfisfADtdPI3QTlR+hXvo8vVL8E5UhxpNS2PxiU+i4f00gDYRJ7qhJtsYrHJ7PIm5mKwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gm8nOtMV; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-77d94c6562fso218251b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 00:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758181170; x=1758785970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sL9evNGVpzgjwGis6FRx6Ny95Jmdu1Zd+5bgNtHIJLs=;
        b=Gm8nOtMVt09KdFLvoae9nC37MIhqcWKh0yytZ++f5qmodsy3CHQAA9/bmBkY8scNzH
         0t9hjqF9pobKERAIqCqu24aAwVfTCKnPpw9OibOU0KzQcnL+6vr5i01pbyr/cx4mej2R
         rX47Qn/gEh4AoPRXsbTzD0YcAkztmnyyxjwz9jUtsjQdv+FEl6DsaVaROXWuYT474Pem
         xagWmbxaSef++bKiRFYcVC+tDIFNB6j+bO68Fdlz2Sfs7nVQVPriaeQj9P6GE8eO47mE
         HLA3hoeTmKmwjWsnOctnCCxTWEoDZmiaBDgL335pJwpAuFTwWrjE7d7ZahOOifht9E0b
         XuzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758181170; x=1758785970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sL9evNGVpzgjwGis6FRx6Ny95Jmdu1Zd+5bgNtHIJLs=;
        b=TkZYXWlkJBWJg5b2fbTy34pUxvSVze69ow11p12vuXEPjIXp96/e1zi9DkY/Ywcina
         1N0Djf5VVZCThdQMCwAdl8q6UIHV4bhaWyqTReypvrE3tHuq+iUcRKJgCDvkh7Ivf1h8
         iDK1I8pzHeoNMsgfnxLEHBT6UuwCk3tBXXpB22qL52n/l7ZzLGogBn4CWMohRLeePDWb
         yU1ly6kAM8W7laLAd9jaqnb1kYRQxmezcW+qiQ5JPyjFUuctNUrn8ouE1QXRLlqgKyRP
         0p32RmLJ5D5ShldHP87zgO+N1zdKu+f/tenQyJCU2Bqpd9W3NhvZJPwBU0rzLhtp5U88
         UDhw==
X-Forwarded-Encrypted: i=1; AJvYcCU6/+rUM/csT1aG4b5/wyYa5igz5M/ZliyEFz4DADibF4qoppaPyJT9kYmcOAAzR8DOrmHqwySHCH5CQqM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1w2jjpwhOro3YOvQBKRH5Y7B9d6dZfG8hHYexyHub7gjF9Fwa
	XBRJChTlXTS2k6BpfwPE5r8Y2cL94+GaShtOCHuIejUeIEv43IZnvWS/
X-Gm-Gg: ASbGncvL2wXvC9PLSn3g0AF+TTyeUOVVEoPWS1KycB7sHY8S+cGZlW+ENdHtZLfvK00
	Wd+oHGrhirBCvCXb298/hHQhFCPH3tcW1seQdBsSsWHlZoS9LOkBEnWv/csJ8R103XByLT1Ft6m
	tMcq/pa7ZyDNvEL9Uuj/nQIsx7WQ9fLrNrVfj4OUPlELoG25Gzj3tUCfVuHcnDIKHQUaz68Be3s
	2fdCXFge7WDLZKmvb7fDmUhY5iIcgBLJMSpO84MIHERP5GwBzORY8kf4r1pFkn9wl9oAZ/jxQHC
	dfsn9TCdmcMMsp1egUt6TBbKYJZHRozSBgOHLhrCWXlfFDHZ6Y7eoj++4L+oSunVsvMis8xzd3r
	ZG9AHjckk3M/JB+X0UQPXOJg4r5if7oI3KLHRVaOPJXmx/hrXLLAddtweNsdmj41eYPUneHf3tP
	vtyyx33CV8uZg=
X-Google-Smtp-Source: AGHT+IE17eaOXHncHS5hiCqILLrCGf7cFJ1Ycoy+fQzqYB1HpBN8eNLK/gt5jkFvDElEVaTnnLbYOA==
X-Received: by 2002:a05:6a00:84c:b0:771:fd01:9784 with SMTP id d2e1a72fcca58-77bf96606dcmr5439800b3a.29.1758181170538;
        Thu, 18 Sep 2025 00:39:30 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfbb79c2esm1503006b3a.2.2025.09.18.00.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 00:39:29 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 0372D106210E; Thu, 18 Sep 2025 16:39:28 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v11 10/13] um: nommu: a work around for MMU dependency to PCI driver
Date: Thu, 18 Sep 2025 16:39:05 +0900
Message-ID: <4a9dde10c586883d20a8201ca7d76e6d7d52eaf4.1758181109.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758181109.git.thehajime@gmail.com>
References: <cover.1758181109.git.thehajime@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit 8fe743b5eba0 ("PCI: Add CONFIG_MMU dependency") restricts the
PCI base driver to depend on MMU.  While nommu UML _can_ implement PCI
drivers over PCI devices (e.g., virtio-pci), the current nommu UML
doesn't implement it.

But without PCI drivers kunit complains as config for kunit
(arch_uml.config) defines the dependency to PCI drivers.

This commit fixes the issue of this compile failures when building PCI
drivers with nommu UML.  In particular, the fix is to undefine the
constant PCI_IOBASE to be able to bypass pci_unmap_iospace() call.

When we will support PCI drivers for nommu UML, we will refactor this
code.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/um/include/asm/dma.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/um/include/asm/dma.h b/arch/um/include/asm/dma.h
index fdc53642c718..643d74555671 100644
--- a/arch/um/include/asm/dma.h
+++ b/arch/um/include/asm/dma.h
@@ -4,6 +4,19 @@
 
 #include <asm/io.h>
 
+/**
+ * now the PCI core driver depends on CONFIG_MMU in linus tree, nommu
+ * UML cannot build with PCI but without PCI kunit doesn't build due
+ * to the dependency to the CONFIG_VIRTIO_UML.
+ *
+ * This is a workaround to silence build failures on kunit, which is
+ * valid until nommu UML supports PCI drivers (e.g., virtio-pci) in a
+ * future.
+ */
+#ifndef CONFIG_MMU
+#undef PCI_IOBASE
+#endif
+
 extern unsigned long uml_physmem;
 
 #define MAX_DMA_ADDRESS (uml_physmem)
-- 
2.43.0


