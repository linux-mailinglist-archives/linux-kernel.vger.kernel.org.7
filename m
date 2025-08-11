Return-Path: <linux-kernel+bounces-763274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F44B2129F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B67C92A113B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CDB2C21E2;
	Mon, 11 Aug 2025 16:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giBcKOCU"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280CA2C21D2
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 16:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754931102; cv=none; b=hAQj1fGv07cfMwdS5dRJyw5PENwkVL3qxp99McB20BfJLH1fsIlfXCSjXisvK+GVZJSCNGQLlbQaj+2qReSS507/eF6666S+FwSzecFxAScVEHVcrcCodwC3lCl109kWXiWOpDba2YfyoFzY/nAcT9luQ7bUvzZUD2nArwolaSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754931102; c=relaxed/simple;
	bh=e9yKw4eA58BTZKeDv2Jej1x0ccHoLMbCSmGwGW2NjKg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iNphGn9yu02mOVgk35RIFJTxij3yd/8MxdFUcG8+3SsXNRit0mIoJRUinNk1+zvfc7piFTqfsdrwQDsvXnSCmUfw/sXfHKV3rgMDaHQyK/1vV/XEgI1k75eiqTR41NKf4YSwoSzQsz6bmMdCEJZfywwTC7IWX9WGqy59qurOub0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=giBcKOCU; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-31ec651c2a1so3735275a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754931100; x=1755535900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TpaBsV9SP95dUvhDAYzFMq9u9AsNNIRTwXToAnWSLqY=;
        b=giBcKOCUv623QF/8SXFRO0uUs108TR4AOvCOEQo1xeAxIHFKazTXLUrBO+/H8h8Giz
         aFzHvaMIqt40zx70NZTNd8G3wcIcFmTr4ajAA9LgmLLSbIjhORis3nVZhY4EGMCT4/jo
         3UDv4vERY0dybk3ERG31258owHoy9n6UbQS8gznQm+MKdTC12C8nXX4m3si/+IbgoR5q
         wow3LmhS4fpTXDFn3YbceTxejJDbUdGaISKeFpVeIO6rnVOASQo+llRaRoWABjbux/r9
         KPUcCFx5tFcdtTc8QUAeyk3scOhbp67NPpZ38j53UNqHnu6Ed+ZrW7kBdSqiFvDmctRb
         NT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754931100; x=1755535900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TpaBsV9SP95dUvhDAYzFMq9u9AsNNIRTwXToAnWSLqY=;
        b=a2D+bT9Q2yXnWC/KSebhTEqieGpgUIVI9b5wbwj/ZD84qipZFJwWSNL7+iPJZ/MQ3X
         uFDswRdMumqb81PIrIGyRiQqS/z8SPYgOXkgHpjN3ovth5jDSozyBAd0SfZGy3txvzZ0
         CZBi5jaSNKXl4SawINwN640hRmnOL8DqHacnscjq3Yx1SXeC6a98vaUatPXzA1MD1EP0
         s2OSIoXycFiXT7hquQLnsQYDsgMDfzGxhhiKVLMKlylkn9c4KYdSf9m5yDiwmOvxKu7K
         G8laZwQo15UNCorzXbtwzVssr7PrkCkvOC1+LhcmSolshMIRJiNyOFIK/ofOeplZKoCg
         t4GA==
X-Forwarded-Encrypted: i=1; AJvYcCV5RKRu3C9Jpx6kXysDuGZoRajkaYMusc0Tts9vqB7XsJqQiGOGkB4YCN2wMaqDlU2rINatqmD2Ib70Dwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlgeuUHZ1zwI8bh8q78MaHYrzKg8ZQkVsgkAyOS35GcNWKD5jh
	UTc6CHp9qpfVAFM40H99GI0egHx/X3xcG3eK7gPI57H1t+jQJVN21Vw2
X-Gm-Gg: ASbGncujy16NyAntW2IvpSTrc+GoQls92uw0uM/AiVnX/OvWopUZIqploD52P95PTSm
	iCWtBqgcpmdhCsUpL5UpQtWM2Qyve8uiF4VPtFO9o7j6jwWtT50T2enYsoLPdPgxXZiAizP/4Q7
	NK96pYKU5CqqbWAEEK83GvwY8ZzIFrLYEqeUzSwpv5K2yIZsgXaJzyVVpXGCc+jBOtuA5Uv4liT
	qvtrLMwhGZnyhfBdzZ/uGM+NkjlD8yoCpecwkl288gkwR75HezAjQZpUwb/Zdz0DPf1ectxtoi+
	e0odcx9FI7Odw/kg5xRwAuxDb7gMgZ5bawFtD9e2/KwMa9+e6LtcP0vAMV8mMW8zUUID6Rzo7jC
	SfBp0K1oCr/vIPfhPBlF7DSQs3XswZ8+k
X-Google-Smtp-Source: AGHT+IEnMob+OASgMciN2iOwD3AQExjTZg0txKEu5PZg0AB3URB7DM8uN2lLQYYlMVfKbzDw45a7AA==
X-Received: by 2002:a17:90b:2fc8:b0:321:87fa:e206 with SMTP id 98e67ed59e1d1-32187fae455mr15484709a91.20.1754931100403;
        Mon, 11 Aug 2025 09:51:40 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63da5719sm32201110a91.6.2025.08.11.09.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 09:51:39 -0700 (PDT)
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
Subject: [PATCH v2 2/2] powerpc: pci-ioda: Optimize pnv_ioda_pick_m64_pe()
Date: Mon, 11 Aug 2025 12:51:28 -0400
Message-ID: <20250811165130.37552-3-yury.norov@gmail.com>
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

bitmap_empty() in pnv_ioda_pick_m64_pe() is O(N) and useless because
the following find_next_bit() does the same work.

Drop it, and while there replace a while() loop with the dedicated
for_each_set_bit().

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index e2b0132fb6a1..325197ac19e5 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -295,7 +295,7 @@ static struct pnv_ioda_pe *pnv_ioda_pick_m64_pe(struct pci_bus *bus, bool all)
 	unsigned long *pe_alloc __free(bitmap) = NULL;
 	struct pnv_phb *phb = pci_bus_to_pnvhb(bus);
 	struct pnv_ioda_pe *master_pe, *pe;
-	int i;
+	unsigned int i;
 
 	/* Root bus shouldn't use M64 */
 	if (pci_is_root_bus(bus))
@@ -311,23 +311,16 @@ static struct pnv_ioda_pe *pnv_ioda_pick_m64_pe(struct pci_bus *bus, bool all)
 	/* Figure out reserved PE numbers by the PE */
 	pnv_ioda_reserve_m64_pe(bus, pe_alloc, all);
 
-	/*
-	 * the current bus might not own M64 window and that's all
-	 * contributed by its child buses. For the case, we needn't
-	 * pick M64 dependent PE#.
-	 */
-	if (bitmap_empty(pe_alloc, phb->ioda.total_pe_num)) {
-		return NULL;
-	}
-
 	/*
 	 * Figure out the master PE and put all slave PEs to master
 	 * PE's list to form compound PE.
+	 *
+	 * The current bus might not own M64 window and that's all
+	 * contributed by its child buses. For the case, we needn't
+	 * pick M64 dependent PE#.
 	 */
 	master_pe = NULL;
-	i = -1;
-	while ((i = find_next_bit(pe_alloc, phb->ioda.total_pe_num, i + 1)) <
-		phb->ioda.total_pe_num) {
+	for_each_set_bit(i, pe_alloc, phb->ioda.total_pe_num) {
 		pe = &phb->ioda.pe_array[i];
 
 		phb->ioda.m64_segmap[pe->pe_number] = pe->pe_number;
-- 
2.43.0


