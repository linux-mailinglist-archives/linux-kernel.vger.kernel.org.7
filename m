Return-Path: <linux-kernel+bounces-859589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F7ABEE095
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 10:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3984B4E5E2A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 08:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FDC22541C;
	Sun, 19 Oct 2025 08:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="BXIvwF2E"
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA811096F
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 08:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760861979; cv=none; b=F2LL7xgyhQd2TuJLWq8rMAlqJzASnjorWO6CoKFrOo0UP7/HjZ8ZXWLKDBSdAqi31Ifi8GGvoYttuc5zBIE6mHnV+Br2VlFuMS86ii1DghIpsYGH1C1y5AR9pjW5J2oKThBU3UDqFDRmQkGJ0b1XRIrIoaY2ejL2G6m4zOAdmCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760861979; c=relaxed/simple;
	bh=lT4aDQLpPjd5u1zcxUN5qwsRj7lOl9sAvVUoAZ1cm6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=REpH0q+ePQE6TztSU/m4sv6A2sLX+WlRuv1bgIb7BJi1gJTPZ2KDAwOTpkSSVXFv0EVmLUtAI8ImG4TQUeKEtKRdT5JlRHIa1y5MimjWBRxvMk8kROPkmm49p4sj1Eub0UST73vTi+3g08vbPIuMt88XbQamI3TcZYwz6NaGsXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=BXIvwF2E; arc=none smtp.client-ip=80.12.242.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id AOcTvac6JaVsXAOcTvxxSU; Sun, 19 Oct 2025 10:18:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1760861907;
	bh=4yZSqEWYj35UkXAaMOoJP24t/2SmsnoWwfpgr7ACf48=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=BXIvwF2EcJz0qdS+ASu9nQ7mJS4tyxNw0GB2tjeTBf7wWslbvRY2A4K3oSlHX5BVf
	 U2QyU7WSwWTQ9tUbacBg8ooPik06I32RGgN1z2/4SOqFmcKv35WMe1lB0acoamy0BV
	 3myHBFsKUgaM3JFYh000ftSmXSVdVuJyZUr9ijuZlUUrK6uTh6LucTAuSmBLRXy9Dr
	 WKdQ1ekdFoK0K04zWbXIyQ+3jpEcN/H1CDvrepaRqpmsZtlvwYDfXaClNxRxHsnbXN
	 EaoP1vTnybn4n9gfC1jYBvlic4yQT4HeQ4/Np8LGBOOeZ0Ffmvf6LI8isKU18bO52j
	 6hm3guA1BjL+w==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 19 Oct 2025 10:18:27 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] x86/ioapic: Slightly simplify mp_irqdomain_alloc()
Date: Sun, 19 Oct 2025 10:18:20 +0200
Message-ID: <cb3a4968538637aac3a5ae4f5ecc4f5eb43376ea.1760861877.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The return value of irq_find_mapping() is only tested, not used for
anything else.
So, this call can but replaced by a slightly simpler irq_resolve_mapping().

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
For the records and if interested with number, on x86_64, built with
allmodconfig, this also saves some byte-codes.

Before:
======
   text	   data	    bss	    dec	    hex	filename
  82142	  38633	  18048	 138823	  21e47	arch/x86/kernel/apic/io_apic.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  81932	  38633	  18048	 138613	  21d75	arch/x86/kernel/apic/io_apic.o
---
 arch/x86/kernel/apic/io_apic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 5ba2feb2c04c..1e0442e867b1 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2864,7 +2864,7 @@ int mp_irqdomain_alloc(struct irq_domain *domain, unsigned int virq,
 
 	ioapic = mp_irqdomain_ioapic_idx(domain);
 	pin = info->ioapic.pin;
-	if (irq_find_mapping(domain, (irq_hw_number_t)pin) > 0)
+	if (irq_resolve_mapping(domain, (irq_hw_number_t)pin))
 		return -EEXIST;
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
-- 
2.51.0


