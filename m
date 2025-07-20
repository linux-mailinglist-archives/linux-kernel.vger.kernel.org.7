Return-Path: <linux-kernel+bounces-738005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E98F5B0B30E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 03:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 640083B92F2
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 01:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90402AE7E;
	Sun, 20 Jul 2025 01:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4rCtDtc"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D2D72616
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 01:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752973558; cv=none; b=KhjGc7+4m9JSeUYmGKfFVaCfK9Nh5RepfTfhqucnVG90cfl5xuUY552QtTYe06zrZ0jurdXIw2jrm4bxFrb02uLAciYOH/nC3OFjLGgls5YV3UXx9b8bEpq4KcgTcxAzmT/H0qveBWsv+GvedmpPe6rwOGgE9vRB+M9nE6uhnSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752973558; c=relaxed/simple;
	bh=pOnFUeeeYOHQSRHS96lKUNGMW3ufK8H2FroLCFuWao0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=f5W/tjW0GkAld7fnkf2ChfBpIwfrO5WWX/VCiQUtLTylaIfWEPysFE8U2NORUs7NjgXRyJuC3PPpP3+kfXVb3sPBz0LEEpDDR2U3KvYM+STy444vhbd38kqHAzjzRESX9zACNiI6/P1NxxbIjAQ7W/BCoHDXdNQwEoBaSAfTyu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4rCtDtc; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e8bd3fbd9f7so2849613276.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 18:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752973555; x=1753578355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mQmf+c5bZ9rMmpqmhX1dMY+jiaKOV1/OjtVkovYw+zM=;
        b=F4rCtDtcN4ROLJXNNN2GwFXIromt9+lXHwq3ipizt2A0rjxpY7WYjNKISrqySLxXRH
         0SAHbk20xaH3uC/5YpUfoGmOn4qh22QjjibLJrOrMSX27/szZ+5iulkVnQGFOdZwXsCK
         RNravEGppP4U1GKqvovd1A7WtqUxMMhBQ87ufkW00Abm/EPTVDbSI8fNemI74EGd+VNg
         7z/qyzY32E+KIn1zh8gCurfqlDh0sRB5G5+dhgZmQW55ugcGbS5T22dDjNr00HA7ILHF
         IZfg4RGgTIhcZrhpIMYzz1/zg1XohAwjaj259X4Y2Wc3EnNa9mqVzmr2f/13sHCntQMW
         +mVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752973555; x=1753578355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mQmf+c5bZ9rMmpqmhX1dMY+jiaKOV1/OjtVkovYw+zM=;
        b=EwVV48t78QLd0jdlSwh0mgeNAMXyRyyqkjS9GBli2nY6qorHUUJtUYpxXwcQlMYaG6
         nMs5ks5JSB+tKrjI49RFLUJamKT7kdV54mfPenPmb7Uho+2vZykuqiTSJhWMpOv6rGqd
         KPuRHLX+SqeFa+OuPNkI3z+Oh4fgJCcaCInTmdiBsD11eR+ch3Cv3txEFwNw4vPf3Zr0
         MDOQOdonIzbPm18sfI/zLpI/ioHDpWYH9Th4jNgTg7W4VxiKv1hd1AXV0yCLEng1oLaX
         jKAwvmY0FFbiNFQaXWPw1Oufgd0suZUzVhrz1Ckp+OFvv6QzkAtUEqlPRqvfBCT00aaB
         Tlsw==
X-Forwarded-Encrypted: i=1; AJvYcCVDUfBLKpgcFgEefJ85hVimLHG0ONCMaVKHS5jrdIYxGuZcdGXeJlztiYLpjB3I8N5Ihm19dtwfUqlKOrA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/U1kyYy8vwmW/tVQqfM6/v2g2V9cbEvC6Acgienb5+aH4P2U4
	NuHWOHVJi8puWKdAOjF30CjSzwTKxYGSq3p50vTzAw64//Ns64RW15Kt
X-Gm-Gg: ASbGncu9qL1c7mozRJ+qCzdJNiiEOxw3MkkxQSaRMx3GnLdFTvII7s1cQwiVybS/ELh
	hZab2O737tEvfzGK6ue7PT0YsZ4B9iyW2MReFbQQbpqum/M0gLIgKCC7Tb3m+OtYvTa1zNIBJ9Y
	bpC+3sy1d0kEH2mDMMQ2kzlBjGVPAAquPsJZ+byDfcHwR2ouzm0aLilRObxdZfuG7eCKX6W02uB
	oY47iE8Up7hFGLEmHTx1gVQazbpe+uSkbkfg35DEj5e67slLYBaheLk13mLtbRINjEO4FS1u30e
	BVuZPNroC5bz57veKt7MhDPxA4MRjd00Ax6T9LQ1w1QGVyNRhxaKza53AS8NSMB9LtdsStxjLgZ
	bXqpx/k4Y0yv/Q7mUCFZr4P60QZSNeoni2jYAGp2/RIEUDXEnMo9wLZKRKQ==
X-Google-Smtp-Source: AGHT+IGu+G5AiJkiYySFy9R0/aF0YP+PLBPO+QptaRa6ym2gOBhSNYj4CwHNuN/M/zM8S9U7NAIPMA==
X-Received: by 2002:a05:6902:c09:b0:e81:7e60:c158 with SMTP id 3f1490d57ef6-e8bc261fe8fmr17241942276.24.1752973555357;
        Sat, 19 Jul 2025 18:05:55 -0700 (PDT)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8d7ce4a667sm1495227276.37.2025.07.19.18.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 18:05:54 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Frederic Barrat <fbarrat@linux.ibm.com>,
	Andrew Donnellan <ajd@linux.ibm.com>,
	Yury Norov <yury.norov@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: pci-ioda: Optimize pnv_ioda_pick_m64_pe()
Date: Sat, 19 Jul 2025 21:05:50 -0400
Message-ID: <20250720010552.427903-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bitmap_empty() in pnv_ioda_pick_m64_pe() is O(N) and useless, because
the following find_next_bit() does the same work.

Drop it, and while there replace a while() loop with the dedicated
for_each_set_bit().

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index d8ccf2c9b98a..c7a421ead992 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -313,24 +313,16 @@ static struct pnv_ioda_pe *pnv_ioda_pick_m64_pe(struct pci_bus *bus, bool all)
 	/* Figure out reserved PE numbers by the PE */
 	pnv_ioda_reserve_m64_pe(bus, pe_alloc, all);
 
-	/*
-	 * the current bus might not own M64 window and that's all
-	 * contributed by its child buses. For the case, we needn't
-	 * pick M64 dependent PE#.
-	 */
-	if (bitmap_empty(pe_alloc, phb->ioda.total_pe_num)) {
-		kfree(pe_alloc);
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


