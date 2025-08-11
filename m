Return-Path: <linux-kernel+bounces-763273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1995AB21299
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3893188A0FE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B874B2C21C5;
	Mon, 11 Aug 2025 16:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8CromvX"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C213929BDB9
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 16:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754931099; cv=none; b=gcXKtqmgQxomK/XPlnYOf2pI0ZIsljTxcV67jS69Rk5ZVRMIVvynzEi949cxBrb2KdWHSozu5+FvvPCs2/LGs0dWFE/9zslTrm/n3CARdYU5pf4ya693QXTjkNS+eDU5yce/ltzMsJR2E5LWOteCaadCwPQkFueDVL9EWFSXIgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754931099; c=relaxed/simple;
	bh=pZ1YEM+fTKhwuKz7ombDLOpoW/klWGD6VizkuuMGbQ0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ipWJ9lnKbQH/3HF5iEmbIHS4JWEQFLtxp8i4NcOyu492NuEOz5giSisjh79t0ccWbkW9ifgLG+VLDoz6madnSCRAfY+cDBhuQ9lBDn7qHpPOLYKUgGtu2r24+QjC00rMmMG2C6Et778yEp76Z2ERbiOWt9Ix1iay2H8b6NVE3SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8CromvX; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-23c8f179e1bso56730295ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754931097; x=1755535897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V59vbtFhyjRpFQ5fJVEOadJDZUONYR/hv3IrR/WcujM=;
        b=e8CromvXX6a5voQTfIxN7VLqzOec9aPI8N8QhtkzACSygG5T1uZc1gOvhjDCfwqnwr
         WdoxvfvhkSJu8VGzgqloGRSwAXb77KQYoiqyqv7Y5pvm0IgLXpcdeRvDcgS43VDLLZ7F
         Vs/6Qr8/qDk/Iyb7n0jmAK/tpQX2jX/a7gOLiPe2RYUksaw7yDToqVY5l35lUoi8e5aa
         a3cYKKIZGWQS1FjJ4FzG12AEloJnEQ2Vosa5SQ2iATMrOsTs/gXZ0V3XnHOs3ljaJB4H
         dp5z96+2HHcPpkeES2e2BwQoUqsGocR2s/hoU6nc3x6eiSIUHx5GDstfqFGtlgMfxql+
         ud2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754931097; x=1755535897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V59vbtFhyjRpFQ5fJVEOadJDZUONYR/hv3IrR/WcujM=;
        b=FPlcUzOguWC7m2nNtTFtCkfM+1gLxfg19bd5U0B5SD562vZGb6ezv5K3B5EzXoArTw
         x/3hBUfQuE4I67id+XaN6cqGMupMrFLJcrr09hn0SWS0HrWGTBEB6aeOCEd5ALeBAgfD
         q04XkisLrZyH7+J5ZMZ3KVdGM5OZk9oKFnWpot33fkhuiPxx8cmQvqbbrfJlzVnRmqp5
         t+IX5NudCfMyEdp6fCGCa75fNUvViNgZb7fB0LRvM1z7t4Or6iq7+5AyU48l5DC/RqHZ
         hT9fu03G8UwdX/fiv5uXzmCLGlsmjYXWbfj8MP/Nm46x32R9YPPFo31cItWWgA2eJrQ6
         RCBw==
X-Forwarded-Encrypted: i=1; AJvYcCV6FYcl/1oIQwa/s/uvm9F9YVCk9lzk8UGD48tyqTYlirf4l03foO8RJahWrqTBfNNHmH5OTsPtEOfx2m0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbH7DMiImszN8JcfTbvaDcnbOfMylJyvykl0aZvY7lHLsrdQOZ
	6p5fXAKI9T52Nbrpy9BsDQcSCtFKM5BRDcMJfUMK6RUyxd0lXUEecoNF
X-Gm-Gg: ASbGnctgFyeOxatqgzDfdxdD4f7ynkyJiLSe55ZxuCfP73wVeiWgoyOZ4eejUKtw2CI
	I5VMUZUpsMp9wiYd42W9IbQvHi8ovfjm0iMlj7CXT33+X6NLL7UK/dYi4eah2qdQxiN/td8i+Fh
	6/2MI6pb+z1Fj9e2vA8yUTBYrhegs9HrsstWhlhPVKTeSSA11WI9qAFvOgE4gLslN/iQnjGDbGS
	/7ko8NEItcQcPB39pzkivg4Ji6nMePUe9CrulZS+Vr9yF8zSgF+RwrKogm3keOoNqcvjdqApKJ+
	k+deroAKpSv+unjrgsG1OdBJotwQPbsnOrTx+i6w9+70rPbg+h/lzXVirTFn2SLk+m9lhBrhWcL
	AIl9FQ7T4e+/cAZKT6B8PBbNA1LkP9rJ3
X-Google-Smtp-Source: AGHT+IHrlZuWLZF8EU4mdBEryzaojxXSQaEV+/9U9HehfZdfYG3EEBW/xI/YXxLD2sNk9njvPGHeBQ==
X-Received: by 2002:a17:902:fc4e:b0:240:469d:beb0 with SMTP id d9443c01a7336-242c21fc427mr228926965ad.31.1754931096947;
        Mon, 11 Aug 2025 09:51:36 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63ee49c7sm31908373a91.21.2025.08.11.09.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 09:51:36 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Barrat <fbarrat@linux.ibm.com>,
	Andrew Donnellan <ajd@linux.ibm.com>,
	Yury Norov <yury.norov@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] powerpc: pci-ioda: use bitmap_alloc() in pnv_ioda_pick_m64_pe()
Date: Mon, 11 Aug 2025 12:51:27 -0400
Message-ID: <20250811165130.37552-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250811165130.37552-1-yury.norov@gmail.com>
References: <20250811165130.37552-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>

Use the dedicated bitmap_alloc() in pnv_ioda_pick_m64_pe() and drop
some housekeeping code.

Because pe_alloc is local, annotate it with __free() and get rid of
the explicit kfree() calls.

Suggested-by: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index d8ccf2c9b98a..e2b0132fb6a1 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -292,18 +292,16 @@ static void pnv_ioda_reserve_m64_pe(struct pci_bus *bus,
 
 static struct pnv_ioda_pe *pnv_ioda_pick_m64_pe(struct pci_bus *bus, bool all)
 {
+	unsigned long *pe_alloc __free(bitmap) = NULL;
 	struct pnv_phb *phb = pci_bus_to_pnvhb(bus);
 	struct pnv_ioda_pe *master_pe, *pe;
-	unsigned long size, *pe_alloc;
 	int i;
 
 	/* Root bus shouldn't use M64 */
 	if (pci_is_root_bus(bus))
 		return NULL;
 
-	/* Allocate bitmap */
-	size = ALIGN(phb->ioda.total_pe_num / 8, sizeof(unsigned long));
-	pe_alloc = kzalloc(size, GFP_KERNEL);
+	pe_alloc = bitmap_alloc(phb->ioda.total_pe_num, GFP_KERNEL);
 	if (!pe_alloc) {
 		pr_warn("%s: Out of memory !\n",
 			__func__);
@@ -319,7 +317,6 @@ static struct pnv_ioda_pe *pnv_ioda_pick_m64_pe(struct pci_bus *bus, bool all)
 	 * pick M64 dependent PE#.
 	 */
 	if (bitmap_empty(pe_alloc, phb->ioda.total_pe_num)) {
-		kfree(pe_alloc);
 		return NULL;
 	}
 
@@ -345,7 +342,6 @@ static struct pnv_ioda_pe *pnv_ioda_pick_m64_pe(struct pci_bus *bus, bool all)
 		}
 	}
 
-	kfree(pe_alloc);
 	return master_pe;
 }
 
-- 
2.43.0


