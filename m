Return-Path: <linux-kernel+bounces-769502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A9AB26F82
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 21:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEC026258DF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 19:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717A523D7CB;
	Thu, 14 Aug 2025 19:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4lxg67f"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F9123BF9F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 19:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755198585; cv=none; b=C76eYJhusy2drQ4X4HZuKdiNJONerpJFwkB/0k597fYQWfPYngUn71fyOtnCxf8aoUrvB8+AcrRc1mLH+yv9MJC4PGgzysxjpi1xemfWRDZ0PXxeFcqmG9YEK8aDdQIaR/QfEj5lHFmSe328EXdCj+X90Z8xLhfEtizRT0zhbs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755198585; c=relaxed/simple;
	bh=9vjba/mrt50wb2uoF0SJyRNQncK2P36FFetzGdlbA4c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GW4xWkhxDm9q5sAO87mBSsLI7qyU9HNRlJqFUkvrqrtUB/ufjqPjuQLbVKF8ZK+Jpy91GXu8CC0ap2Xa1Fu2BRW+w84MAMz7VRsC0c/t+HIQdEMm3/p/DoDXrS2Gs0VYiEhbf1vguRjPkvx24cNtdgzXo3F+UtviqP7nYiEyH6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4lxg67f; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-323266d74b0so1193935a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 12:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755198583; x=1755803383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+UJlJ9+DjZd2THGL3J+lidGXBes5gAiTYGr+fy//EDg=;
        b=T4lxg67fVaI7Sr97IfmvlZzC1Znb45BAfQ+OgYXf5tNLeeGPWGARuwXgl/FaznM/50
         392yAPZ8bCHGaSiHK++XyrMKCZnVkPtJqs2OBDmALnkexd2wyX5mGvk0LmIrxr44bGfj
         RTFkiCfhZEzgOG0Z4pQUagB07YpnPmJQKn3z5hpa5SAdanR00umdrdMPp5WalwcOfqZK
         2B1vg9dMIvvQJ92kneY6JtV/suLqCftA9gWMKxq5MDLhsms8+y2mwcSarVR9KHcebF2B
         Mi1yd+wgqMjqFVTo0Mxbi6XuAJhNlUFH2C/i/oF1Z13aKizonkj1Aa8hLq4l+Dt/s8nR
         YdoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755198583; x=1755803383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+UJlJ9+DjZd2THGL3J+lidGXBes5gAiTYGr+fy//EDg=;
        b=JzPUNDWXhsxtLzSN8uB5ET7E9SHzOQ1KguGj6ZMbbw5vU0Cgg0/+bHyk8ueMugJ4o2
         BB25a54iI/qju1uGML19973c1PCII3o6IYrwujFsUzNk7sekDypTxc/0GEUKXCmhvNld
         TxTkuRm4N2KroNQWnmFieJuXRJsfeOd09EJYZoa07pNh61q5DZqu0862m6MOIyugspMV
         ItLuXY5R9wnQQeqOCXMNcMYJSiL7LhRDHNNQPHgnNN8Ow2JvuU9Xjvku46NqeU9xHZQ9
         D1Vzg8+aPWGFFwbDzcB5UZkwamvzzVz25vaKvwxaL/JfwFBIFUrEnaG5sMNNICOW6lWj
         eFsw==
X-Forwarded-Encrypted: i=1; AJvYcCXtf8k36oVWKqdLCWjEkv7yNCndbhPY4zFbWzJ3o4YqfAEHtxgodbVzBtISxAxuT/WwNRCwdJdMbFokCDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWHn7UQuxsWFdbcrvNoopaDkpgpPV2yaif6he2dqXtDoLBGhY6
	NkYY+8OyMnz07TCICzwUfAVkdthmKcagNDUFsasVM/4DXc4lVW39/4U+
X-Gm-Gg: ASbGncvfbS5gm+MZXai9P/2N7VQS2YaRZDLAS4fZHb7OPFgpb5Pj3un28XPGBmDdUhR
	4EihV6XYMBjrmt/vZM/NxWGlUGqyZzFIpqgv/6gV0Q2ixM97HSMKLJvmJjOFLs63ihb7gh7ddFp
	WotZ4LvuIiX69Fh9XtuhfVZgxtxHKOTDtiAV8k+w7BfsOgplhd5uKCcWpUIRW6/WQDgztTkgFs3
	2NyIrI13A9uJWULRb/ea8YqdpAseR8lDpYmDOEeHJKvq6t5o6TfSBrakRnUFw06dNjvEbHcUUoh
	FkmfrK0lDOQOn3EQg4bp0JXi4dLZGsAhR5tdlpJnrnAs+Spow78dJZi7fbopB2hnAf4+XKG2Hth
	9Uwyj+iaTCYL0MsIf8U6m+g==
X-Google-Smtp-Source: AGHT+IFFwZv1c1ZK8S3HgX4X3suV9YEHMQS8EnvLEjc+VXrDDUDebFYY3z9RLaiGqd94M4QhyksWTw==
X-Received: by 2002:a17:90b:3c86:b0:321:1df6:97d3 with SMTP id 98e67ed59e1d1-3233d09ce8fmr24505a91.4.1755198583280;
        Thu, 14 Aug 2025 12:09:43 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32330f8329asm2637497a91.3.2025.08.14.12.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 12:09:42 -0700 (PDT)
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
Subject: [PATCH v3 1/2] powerpc: pci-ioda: use bitmap_alloc() in pnv_ioda_pick_m64_pe()
Date: Thu, 14 Aug 2025 15:09:35 -0400
Message-ID: <20250814190936.381346-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814190936.381346-1-yury.norov@gmail.com>
References: <20250814190936.381346-1-yury.norov@gmail.com>
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
index d8ccf2c9b98a..2a4b916205c1 100644
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
+	pe_alloc = bitmap_zalloc(phb->ioda.total_pe_num, GFP_KERNEL);
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


