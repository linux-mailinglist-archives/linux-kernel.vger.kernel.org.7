Return-Path: <linux-kernel+bounces-769503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D010B26F84
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 21:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 044E01CE0B0C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 19:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7743723BF9F;
	Thu, 14 Aug 2025 19:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nctA3LNH"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA3B23D7D9
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 19:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755198588; cv=none; b=K5iEWLB1upzB+YPqiznr8E3kcu1SDAWj4Dh9q0gJPejZb26U6codmH/1KJR33G1JPe75cgIbQe79MY/TU08k4D9ul5qyO5f/cnZLhLLtk0+W/90xAqT9rzRzQ4AIGHZaQHF8Lo9KEjwIR7J23Wz4ONxWFwZW53S7FuTq4nIqKN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755198588; c=relaxed/simple;
	bh=cn8UvPsPJD/j/9nIZcPS6rcqmeIlHdPR+kakUIbdYLI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lVWeo+0E+/x2U+panLEqE2UQ9djsQ3fLSswGSq+rQT8/HAVE37JxwPF2DD04D1U9X/C3TyfJnSjKZhyJfgSAkAJJ+0Fl8NS/VD6Jjsw+K2HBN7ZPfWC9dfqqVh+xIsYqVmJgs/10TP9ZNzNCHrp3q/6c4g2dodKRvr3ROnYh9DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nctA3LNH; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e2e89e89fso1770529b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 12:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755198586; x=1755803386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IF8qj3lRR6EFkcmgoXgDdUEvoMakOzSl+hSokVwaKUI=;
        b=nctA3LNHtxKxc1torIE6n+BuhpiXsecc4+rnik6Ldu1Ced5wWz30xAe7wN0dryZwG4
         v9gakz5G+9BLa470AEspTQa+6eNeaqG/XszHZzpluj2rBmlbDTcIDNxroFshg3QSh9Cv
         XFgt9kZ4WA66CvRda6UicHnRpYBhJYU8MNZ555s9ArqwY7tfTST4+UXp4QkXo/MOLS5O
         9wZabiFTY6qkqryeQHVZXjAygfsdkstBiwC8/JUwuHhYyXGXw/H2zJxc3nZIr7HfPUzS
         i1V8BB8CrGcrsEYI52iBBVowPHb1W7YEjRUIDxKQiN56ogx1I+wQUhbxcN3jDW6mWA4M
         j0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755198586; x=1755803386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IF8qj3lRR6EFkcmgoXgDdUEvoMakOzSl+hSokVwaKUI=;
        b=PqGRpuNSllKmQhNS28rk/IuSf/dLdAgoeGo/oHwOoxlqMPmPyUyrxX/7Oa9GKlivPe
         fwZPpCnbJaupEs/5aGGMhKKGoEiP9BkmoaU3+0WpNelvVA9WYThhqM1AIUqig1itIFlD
         +v8R4OJTLM3meAxF6DoI38U1fZaxwN+5T5JXc7/mZj+K63dThRxNVxZchxCy5PlDvxoI
         qfQ7LvMOW2onRt4DanRXQkz9NXxpTeHBVhyywh3nhBkoADou8rXs5FYJV0L2MD+1ZbEt
         ZF0unCupYXWJLRhmojmAr34CEp5h9VoAwF4ViXgXs+T8Til08wFZnV7JQVgariOd7Arz
         VCpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVl4imbO5RnQgnFUrRWZ1kH7d8NLG8OfCrIXWZ9anqh4jbd38fbDHhBI/wHIyHf5zlH7SRtuQliKyZ+X28=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrQVsp07pBphEBbJhKEv+MZ7wQ6RfQiJyw6/MuRsGJck4oyhVo
	Mcg737QuW9ELW8b3ZDaCMixy/fGznyL1voDTKttGLhoXsNPP6vsJZRoB
X-Gm-Gg: ASbGncvNfG6nNAYVHeec7/nfC6ImYknO08Vf65IDsfoWEDe8ADrAkvC+KFT/WM2j9es
	KMmO5zhrK/8UUCKhPVP4WaP4BOcgncZDVuShgKdh6UBK86PgdiekqCDlbGUWjGhgDh2ya3W66Du
	1JIINp3YhjDUQEvFsakvo3aL9IeUYHgaW7VbpoQnpOf3XRQlK/djDxPlCTi1Duj7YvDhC3RVAdU
	e6s6lwpKNVnj+L5g2mWjqJShXnQM8z7gap1s2iO6yjpw9Onuv/dDk5eKVsnUhtxHBl/OfY0coQj
	yk2kURn4JYB4fif+Kkwl/7OjXkPxde/bjBjgYApIZFaq1ueA7WMxqwHKGRFICZ4oYj34ULP9VeV
	xmwgX+h2enrRp3B4S/pawTA==
X-Google-Smtp-Source: AGHT+IHO9E6Ju6YUC/4W76OL34pJ6YJlwPdxgruOXLM17Ydpcq6OMMHw8A2vXRvcEHPm1CQnzcq1PQ==
X-Received: by 2002:a05:6a20:5491:b0:240:104c:8e14 with SMTP id adf61e73a8af0-240bd285526mr7187108637.38.1755198586198;
        Thu, 14 Aug 2025 12:09:46 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfd8ebbsm35345257b3a.102.2025.08.14.12.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 12:09:45 -0700 (PDT)
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
Subject: [PATCH v3 2/2] powerpc: pci-ioda: Optimize pnv_ioda_pick_m64_pe()
Date: Thu, 14 Aug 2025 15:09:36 -0400
Message-ID: <20250814190936.381346-3-yury.norov@gmail.com>
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

bitmap_empty() in pnv_ioda_pick_m64_pe() is O(N) and useless because
the following find_next_bit() does the same work.

Drop it, and while there replace a while() loop with the dedicated
for_each_set_bit().

Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>
Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 2a4b916205c1..23b1db3f15a9 100644
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


