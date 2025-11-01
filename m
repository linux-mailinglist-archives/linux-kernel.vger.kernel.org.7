Return-Path: <linux-kernel+bounces-881348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 72522C280D8
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 15:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B9DAB4E5C61
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 14:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD5C2F690A;
	Sat,  1 Nov 2025 14:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="gN7eycO8"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4A82F6562
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 14:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762007024; cv=none; b=W6l+H/bbLH6mWPaBBSpCA2dXdcK5ggNT2LCN2Wp0EUw6w8/KfSVrW8w8IxZVy37aCwKbNwMYJNi7fZSng2AFoVsSuvk2acCewlIoZlwXt9zNABVAcQDLzbOlW8vfiLWeSzesVx0o3E8a1oMQwaiip3FCzFyL40zSsy+pAhI9gCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762007024; c=relaxed/simple;
	bh=yHqwthdjQR9NASx0Os0y7RkZY+CTnqkZiedG/ZfbJsM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q+dg7/Rk7Sh2C3qfImyVHRU8rv9PMst1Oj6DhxfSppMezyIlnT9kslYpQk1qnpC6LvCT0XHls41pKPf6KFUM5ODZGh0/5A8M/9bQ79W/WRl7aN/8kv2pR6Z/z/NGpEk6CmPom32aXZYgosOYoPdmQ0nyNr6HfqDug0l5rQ5Xwhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=gN7eycO8; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-93515cb8c2bso1362286241.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 07:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762007021; x=1762611821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=57rygU5OjDWbT5PCPIwncZxw1NBlZuRuRnZzBsppy54=;
        b=gN7eycO8W9hBtFwgbXMYmbIgawUgpGrbpoYURAUEQVZxFMrLP3ZULVAMwA7Tiw2n+q
         JU+NG6nxEUVIXRvxGHETXXpimzRta9F449hquKKDghUSwY+LzjG4Xl0wPSUyBbklSCa+
         hTa3YF2PA7nry36oNU3ZIt6WdDLaq15lguMUQfZGlstObc7CjRcPXPancdnK/v4wBy7V
         47X/8tL6dlU4lx0tWCx+DlFlj46Z+dA2fPtxBIkTnVrp6/qxY+XqG6bAViRPFIca9TPD
         nVo6F2YhIlUMbdWyl73lwoXZlMCosADB5wGnpf8RtzipK+9SAAKD+z0agucSl8q+RTyh
         xNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762007021; x=1762611821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57rygU5OjDWbT5PCPIwncZxw1NBlZuRuRnZzBsppy54=;
        b=klkeQ0MiwykC+2KeX+9niSPjP6tYmSetMn1pohTV7JaZ5LqVcrnv2SZoHB8bXUD79u
         mCnSfMfRLi5wXm4oDGbplB1z8FDWV2mCmjN4D/IGYlBiShSy75Ea/O5/fPcwISRwbRsf
         oQSx6QHU8m/lv1zqBdH6TyFm/t89vLXkh/JFC3vrikdxLWptdW+OfY9avJu3zVJ2MpQD
         7MNXhcEwwglYEkhEgYXfa+LS696qYHKTmMg6ThoAvTriIYi22fRfljnw/zxCTXdYnLe/
         fOuXEtmA+M0egPib9wDPLlboezglH3CCMfgi82dnNfWLrxEURg9qp6N9/30AcreFaToL
         Wbcg==
X-Forwarded-Encrypted: i=1; AJvYcCUVZ5RmJ8dgDdfyiEL3CfuZhOYx9P4xqwbrMxqhFoiyA19l+bU94mWHVU+D+OxKQeDhgw+Ih6XtXbwTy2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTugOhnrrBDr19tjt/DrfqmHze7CnKLXhCh8HlgSKPHrY/YxbV
	ueci/6/ZtbeuXb4ccFuY3l4mWkUdWnhAQBWkQ3QUkl945K5iBOybztC4+2ADjUFkFA4=
X-Gm-Gg: ASbGnctJyiliZWwyeg13nwRMQek43NpiN9d3GMSS84RlNBKeqP4B4kdG/hNrcQEOdJA
	Q6iJFbUl5s85aQnes+z16zZZeGckSumJ2c7QEnYZDRt9wdZl1gKRhFJ89pkUAuuSmV53T4852mZ
	/9NSt8Ri7RJlTT/k7NO32n2TSDr4p/VumbEeH5daWHQyqQPo2AY3BsFCLAgWRh4KaZwSmOSj+tz
	hovUYXjQlnlJr9LbMR7dbhcKL2NzRzs3rHQYF1gf7xrJomYLYXqcXjqsziLpUIZkCIsqYSr8duI
	v7IcEDW9GYqLtTg2YkqIQTaGVmhsEJs4zFifnIe/QCVO/V1C9sTvtkUjz9AcSI4gLa3lFqStImv
	2INr10rfDyYsuiIMoUQdoCvplPWW/Ga76d3r66kmCNOlifC8IsEiO6gCBwBsnuMZEt7eVastoa4
	M6QjrmRNLeMIX5UyHDL2XFTRpp4xflrYCHxxd3qeafjxGBzQOBSPGXL8IS9mtN
X-Google-Smtp-Source: AGHT+IFHTA9MFhIfCaO4quOEqPC9MjBBViuMWnhpeFtjZfr2lHvftLMFFMHCzKtyyjM8DjV8X9i0hw==
X-Received: by 2002:a05:6122:90c:b0:554:e4ba:4408 with SMTP id 71dfb90a1353d-5593e006778mr2627356e0c.0.1762007021390;
        Sat, 01 Nov 2025 07:23:41 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-559449647e0sm1776242e0c.3.2025.11.01.07.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 07:23:40 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	brauner@kernel.org,
	corbet@lwn.net,
	graf@amazon.com,
	jgg@ziepe.ca,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	masahiroy@kernel.org,
	ojeda@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	rdunlap@infradead.org,
	rppt@kernel.org,
	tj@kernel.org,
	yanjun.zhu@linux.dev
Subject: [PATCH v9 5/9] test_kho: Unpreserve memory in case of error
Date: Sat,  1 Nov 2025 10:23:21 -0400
Message-ID: <20251101142325.1326536-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
In-Reply-To: <20251101142325.1326536-1-pasha.tatashin@soleen.com>
References: <20251101142325.1326536-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If there is an error half way through KHO memory preservation, we should
rollback and unpreserve everything that is partially preserved.

Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 lib/test_kho.c | 103 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 73 insertions(+), 30 deletions(-)

diff --git a/lib/test_kho.c b/lib/test_kho.c
index 9f7cfa6ac855..025ea251a186 100644
--- a/lib/test_kho.c
+++ b/lib/test_kho.c
@@ -33,17 +33,28 @@ struct kho_test_state {
 	unsigned int nr_folios;
 	struct folio **folios;
 	phys_addr_t *folios_info;
+	struct kho_vmalloc folios_info_phys;
+	int nr_folios_preserved;
 	struct folio *fdt;
 	__wsum csum;
 };
 
 static struct kho_test_state kho_test_state;
 
-static int kho_test_save_data(struct kho_test_state *state, void *fdt)
+static void kho_test_unpreserve_data(struct kho_test_state *state)
+{
+	for (int i = 0; i < state->nr_folios_preserved; i++)
+		kho_unpreserve_folio(state->folios[i]);
+
+	kho_unpreserve_vmalloc(&state->folios_info_phys);
+	vfree(state->folios_info);
+}
+
+static int kho_test_preserve_data(struct kho_test_state *state)
 {
-	phys_addr_t *folios_info __free(kvfree) = NULL;
 	struct kho_vmalloc folios_info_phys;
-	int err = 0;
+	phys_addr_t *folios_info;
+	int err;
 
 	folios_info = vmalloc_array(state->nr_folios, sizeof(*folios_info));
 	if (!folios_info)
@@ -51,64 +62,98 @@ static int kho_test_save_data(struct kho_test_state *state, void *fdt)
 
 	err = kho_preserve_vmalloc(folios_info, &folios_info_phys);
 	if (err)
-		return err;
+		goto err_free_info;
+
+	state->folios_info_phys = folios_info_phys;
+	state->folios_info = folios_info;
 
 	for (int i = 0; i < state->nr_folios; i++) {
 		struct folio *folio = state->folios[i];
 		unsigned int order = folio_order(folio);
 
 		folios_info[i] = virt_to_phys(folio_address(folio)) | order;
-
 		err = kho_preserve_folio(folio);
 		if (err)
-			break;
+			goto err_unpreserve;
+		state->nr_folios_preserved++;
 	}
 
+	return 0;
+
+err_unpreserve:
+	/*
+	 * kho_test_unpreserve_data frees folio_info, bail out immediately to
+	 * avoid double free
+	 */
+	kho_test_unpreserve_data(state);
+	return err;
+
+err_free_info:
+	vfree(folios_info);
+	return err;
+}
+
+static int kho_test_prepare_fdt(struct kho_test_state *state, ssize_t fdt_size)
+{
+	const char compatible[] = KHO_TEST_COMPAT;
+	unsigned int magic = KHO_TEST_MAGIC;
+	void *fdt = folio_address(state->fdt);
+	int err;
+
+	err = fdt_create(fdt, fdt_size);
+	err |= fdt_finish_reservemap(fdt);
+	err |= fdt_begin_node(fdt, "");
+	err |= fdt_property(fdt, "compatible", compatible, sizeof(compatible));
+	err |= fdt_property(fdt, "magic", &magic, sizeof(magic));
+
 	err |= fdt_begin_node(fdt, "data");
 	err |= fdt_property(fdt, "nr_folios", &state->nr_folios,
 			    sizeof(state->nr_folios));
-	err |= fdt_property(fdt, "folios_info", &folios_info_phys,
-			    sizeof(folios_info_phys));
+	err |= fdt_property(fdt, "folios_info", &state->folios_info_phys,
+			    sizeof(state->folios_info_phys));
 	err |= fdt_property(fdt, "csum", &state->csum, sizeof(state->csum));
 	err |= fdt_end_node(fdt);
 
-	if (!err)
-		state->folios_info = no_free_ptr(folios_info);
+	err |= fdt_end_node(fdt);
+	err |= fdt_finish(fdt);
 
 	return err;
 }
 
-static int kho_test_prepare_fdt(struct kho_test_state *state)
+static int kho_test_preserve(struct kho_test_state *state)
 {
-	const char compatible[] = KHO_TEST_COMPAT;
-	unsigned int magic = KHO_TEST_MAGIC;
 	ssize_t fdt_size;
-	int err = 0;
-	void *fdt;
+	int err;
 
 	fdt_size = state->nr_folios * sizeof(phys_addr_t) + PAGE_SIZE;
 	state->fdt = folio_alloc(GFP_KERNEL, get_order(fdt_size));
 	if (!state->fdt)
 		return -ENOMEM;
 
-	fdt = folio_address(state->fdt);
-
-	err |= kho_preserve_folio(state->fdt);
-	err |= fdt_create(fdt, fdt_size);
-	err |= fdt_finish_reservemap(fdt);
+	err = kho_preserve_folio(state->fdt);
+	if (err)
+		goto err_free_fdt;
 
-	err |= fdt_begin_node(fdt, "");
-	err |= fdt_property(fdt, "compatible", compatible, sizeof(compatible));
-	err |= fdt_property(fdt, "magic", &magic, sizeof(magic));
-	err |= kho_test_save_data(state, fdt);
-	err |= fdt_end_node(fdt);
+	err = kho_test_preserve_data(state);
+	if (err)
+		goto err_unpreserve_fdt;
 
-	err |= fdt_finish(fdt);
+	err = kho_test_prepare_fdt(state, fdt_size);
+	if (err)
+		goto err_unpreserve_data;
 
 	err = kho_add_subtree(KHO_TEST_FDT, folio_address(state->fdt));
 	if (err)
-		folio_put(state->fdt);
+		goto err_unpreserve_data;
 
+	return 0;
+
+err_unpreserve_data:
+	kho_test_unpreserve_data(state);
+err_unpreserve_fdt:
+	kho_unpreserve_folio(state->fdt);
+err_free_fdt:
+	folio_put(state->fdt);
 	return err;
 }
 
@@ -174,14 +219,12 @@ static int kho_test_save(void)
 	if (err)
 		goto err_free_folios;
 
-	err = kho_test_prepare_fdt(state);
+	err = kho_test_preserve(state);
 	if (err)
 		goto err_free_folios;
 
 	return 0;
 
-err_free_fdt:
-	folio_put(state->fdt);
 err_free_folios:
 	kvfree(folios);
 	return err;
-- 
2.51.1.930.gacf6e81ea2-goog


