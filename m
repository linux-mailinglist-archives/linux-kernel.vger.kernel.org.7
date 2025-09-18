Return-Path: <linux-kernel+bounces-822078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D42EB82F9E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07589467240
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 05:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533422BEC3A;
	Thu, 18 Sep 2025 05:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNYBjxTw"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD172848BB
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758172611; cv=none; b=IHSYsZn+N/B4prTbwGNAnXZ9eiccSZ03WMywxoTcGvw24jUWn8hiyjVfPbBSU8uCsKZgjPaKF3mAnk6qC287uKaOZ10IkOVzgg+cyhDTgpUG7okdo8NHrj1rEjo94ImIPPAgKURe/mFBKB4QiKH7kXjnxaiNh7prCrW23csSZMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758172611; c=relaxed/simple;
	bh=A+kgl3pP41bBhorqPw1acgSIN74xjFREHN1mNj1smKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hFhmtjm7FeIUQSh839A9idjiXLJkIUSMMK3aQUGPAbfKuXh/UN4fjFwavegefdvrv+aRqhtVIBgrey9XFXPQoicVJcNeK9Or2ZhYAg4k+7CkEucwyv4ZsT6hXgQdI8Dw5WdljXVGMppx+Weut8rAybYe+Us9ujq+mmrfip7G7Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNYBjxTw; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-32b863ed6b6so430341a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 22:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758172610; x=1758777410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sL9evNGVpzgjwGis6FRx6Ny95Jmdu1Zd+5bgNtHIJLs=;
        b=HNYBjxTwkT7g2pejceFpxCzKWIOR7X2n6SfZ0oz8n8T67NKKLRXD6G3fgK6Frcewq7
         gsdVdYhVC3czM1lTPazTKhp8uQtKhE+I0burEBTLmtksIWItQ+Y/T4nAqokPia2U3YzG
         7mvOafYgwOhXK2QvRYo7GZdM3bHUR/7+s1be7NGZWA00YoBzWSH/xcP5QBe+sTNuse/c
         sMZ+ud6F2Js+Atp+oLfADxbKQO55b/SABgi3+QZxSF9T4wpg0URNQ6Yq9RHA4eBjVyzQ
         D6Y8pAlwea0ZQT8KvrjjkXfE/dMKgjXSxk+fD3LeUVQHPivTKyKaxo0YCwWSOxfW7pat
         ruXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758172610; x=1758777410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sL9evNGVpzgjwGis6FRx6Ny95Jmdu1Zd+5bgNtHIJLs=;
        b=O3sxLFcvw9tASvOOITPFPZFIQu3rGgtl88ArHpre4aTlkHReoMV1qrAUxdtsXUDz3/
         0MCkYVBflRQcXBP9GC+IifYos7LVfRe/cxHLjJEUQNjDuLbqONCsJRaiWYUIUw51t4E8
         R3I1pK72YQgh64KZvlFLh3UI3b2nfO3hwBJIb4i08SqM6vPWQXiC8v68Px7EW/ugXTbH
         Aeq0RJVV0P7cmr/TBhx10XIliuhZkB2How7hs/pcG+gogVpSMmhHULeUq/xl+ijDjZCm
         AKnE+zArNxBsOqRO9b49SBSwApKSLgKd2YGroVDI/fxpZQ8oOniMya6mui6wt8fcVgwA
         sFlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGR0nnxB2J0NLz7QvZ59V2Hkq9YJrcJchdHTcCZVOK8rJ2c8yq+nwz0Ft0VDBrn709yNsHdI+5iokEQqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLSDx48w7PT1Sc0A+CGRHoHFj1iwq7PryUh1539ajvbKdp0kNm
	m+cQWpYtwlOFG/1lidE8hTxMpDLRKLHR9TCLxa+pTlrRpSGEdW/TtR1L
X-Gm-Gg: ASbGnctaRtrjv1Ri/v1lL7rK2v1BFFvIBrcRU5wK/KV8fV+2XSBw78ty++O007a5C5b
	Yyu1lRr4F5IBsxTHz29KhsAEQLF6zCOmR+7vAwlTbiQErgj7PCLAh4CaGN4KthvjY1A7HTv3Q7x
	smj6itQ3gVfXP77OfmrqasR9ph6iAc+gZ/2KKoBZjAzNBWQ8+FVQFC2ITVHZ9HkXD91zS6HXRm9
	0vInDsKALwtsaiAC+ZAhiAUyHTpCCPZ9uG1xxdEcRZzlcmG8+ZYs5WGoCO2gBvZ+3dvi61XpgGW
	IRHBv6KSNWx+CLli1FTjj0EmiOS67gAxdrh4DQN4N5GMDScu9wWwqXm23SupM55lC2zJ/CLTiS9
	SDzUi4RIIFD+etXfKf6rhxRt1GqnsBBMhrSbPX8Uvdb1sXnci2Y9/rJPHfCqkeviL4ThD4zDq4Y
	mjKiBnVH6Mq5E=
X-Google-Smtp-Source: AGHT+IFwiCIUby5Al7WTn2I/DIUnBMJmg3jISswUhPnLRV817OVMwAQnC20DwIBS9SCeb7OC9m1+7w==
X-Received: by 2002:a17:90b:4c12:b0:32b:7d2f:2ee7 with SMTP id 98e67ed59e1d1-32ee3ebecf9mr5669955a91.13.1758172609515;
        Wed, 17 Sep 2025 22:16:49 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3306064edb8sm1208854a91.7.2025.09.17.22.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 22:16:48 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 82C191061EF7; Thu, 18 Sep 2025 14:16:47 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v11 11/14] um: nommu: a work around for MMU dependency to PCI driver
Date: Thu, 18 Sep 2025 14:16:04 +0900
Message-ID: <3cdc0df9917b2acdd718dc2587ae1bddb9258b06.1758171893.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758171893.git.thehajime@gmail.com>
References: <cover.1758171893.git.thehajime@gmail.com>
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


