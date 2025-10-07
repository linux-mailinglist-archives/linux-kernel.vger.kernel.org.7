Return-Path: <linux-kernel+bounces-843730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FB3BC018C
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 05:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A23DC189A400
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 03:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA79220F29;
	Tue,  7 Oct 2025 03:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Co96UKJO"
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE0921B8F7
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 03:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759807875; cv=none; b=Xb8Skyxa886vpCkNqT7vP8GB5MdxDn5HlU4aptww97IQw18099cwAABJYS/6PmZHKg4Hwmod56hiljLRGT0b5PH85aCYBw2tRE6vIDTpoAlh09vNNNBVw2hl0LBy/emV6V9OJBylJx/iIOdH2bMh8LKgGNY7WiM9rXxqPZ3zuwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759807875; c=relaxed/simple;
	bh=hXIL+PGMExM2O36pRQKCAP7Iwodxl63KTYS1axPZkVc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OAN44j6HAg7Sn7rtpBKMBUPWp1JREQWw5eaACxsNPxLRnqigUTNGZ/0crGqoaU0n0e5bRfqlgRPLMZzGXL7LFM1BK8ouJTgFZo3RZeuJoN9SkOAbrwv+wf5LYiU/QpcPjVyrozgwLbTnG9bDvdcCdLAuyi3jqd6AWmD1x3v1oV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Co96UKJO; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-551b9d94603so2084723e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 20:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759807872; x=1760412672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7z64stFRl040LRM1yj9RgVROnladG4B1zFYyNLh4mpw=;
        b=Co96UKJOs/lXYzPcofkU0LI9M0SCJ2pozA7yEb7maXn//ZwO3mq4yiKKUFHfXvtmTa
         AvWpWbQIHXhwTAB3z0RIlJwHVrmk/uO7DRB63FbfZeXIKhMOHrTNb9LuKoWH+mfvLib/
         Su0/d3YQ+C/ZIAjwpOUU3kR8bwH+TsEBXrltPxzfvuL372xlHsysKEuAnPWsKFkPQuJU
         Ply/2T/8LozOQjOXBeaC+u0BsdGEavLj8/Km/WFyfILCzcmxiiu3X6Z/c5AqewjV+HvR
         nS2YBMeJ9gw46WHHWL3UDlColw79UE5ZKGsfn8DmeEoD9gXInF+1MrJCtTMIUJ9BGNC1
         fjzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759807872; x=1760412672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7z64stFRl040LRM1yj9RgVROnladG4B1zFYyNLh4mpw=;
        b=qPrIwmspU7DqzzGI8ezfKzSNefqzY27LVVRIfiO0+aPUqhOf3LyD0ZejNJ3nmDVZsm
         tC9bpWQK43xDeZ7PO/d+z32/2mFNAX4BR/cizdWox/g4S92Omzz1Rap+MyhD2LDTwLpS
         2LiqZkO5sQeJui2ayMQSJt7cgAmPAQJiSNqoKb2+NWV83TYRsJSmkol4v9/ZdT1SmypZ
         CXDYE7o/dWyuIY0lLpdNGSkMEmv8NQKVB1rmVIDdLZSXxTr4Y1ffy4UbR9kjt0WgOjtI
         /vxgihrv0axsyoGt/N8OgU8BpdgyqZ3DrJTX1Bb/5OwIWZEAH4yLHWGxOS4d/eSr+nD1
         MdnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEA3LYWmXBtX80bN9Fb+K11V4hykEMtbcnjYvprqdTYAYIXBvgyJin+pXD/QZEfGGNfFi3sXNNq2ZEAw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFCXowE4KLbkWFxTTGzkU+FWWsEdYIkhedZch0foWpUuAFNgYi
	57nXy1GRLwSq5SkglAXLjZIyrZttKoC2vSKo186LZiEhMIgtl8V4ON+THZPfF5ZEFEM=
X-Gm-Gg: ASbGncu+z1z5OlRNEXOoqTteAdt4szpH8ZRqy9uKApn7lx3CsvxFKRPzeDfDOBD4V5H
	b7dkbVdrHDqt/ov5RXmvYxT6TZvoN0jhz4M15pZZ7Hf2gU4o8dklixYj6Cqa8qxBipznrZit7PY
	0sL+STnBgg3xxP2RR7Y6KnZ+nEbJ8U5ZDtpXEidhDnPkhdBX8xeBt9tILd/Z4sayDEyjaOcYKLT
	A5/EPwsmb2cxnkRjGeUEOPY7a3lYM1h6OwqP4EZ2v+7UR3zGMm59ptNXkjyXxwMDDRR5yquIKeU
	w+rwL8oVIP870vX+GGtTL0gNDvQflZ9nO8rR9P54fIDaey/7U36iwFxU+/bNUSsn0ZKUX1g28WV
	xCMkw0jEU4NKOHyr8EKkueVLdH3uf+Ni0Hy3zQrUmGfOiWMmWzTkJHwdwxg135f6MbyXd8U9D5j
	qGHeo39UF/HcjgBKADYp2jsdLceROJtDE=
X-Google-Smtp-Source: AGHT+IE4EXqWZRhl2HTUQHS0IRjtbgPekpf92eZABSKl8jPdM7uErllIFBlkrwrXfARb9nmkBXCE5Q==
X-Received: by 2002:a05:6122:20a5:b0:54b:bea6:a226 with SMTP id 71dfb90a1353d-5524ea29092mr4456170e0c.11.1759807872536;
        Mon, 06 Oct 2025 20:31:12 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-552ea335f07sm2446030e0c.15.2025.10.06.20.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 20:31:11 -0700 (PDT)
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
	tj@kernel.org
Subject: [PATCH v5 5/7] kho: don't unpreserve memory during abort
Date: Tue,  7 Oct 2025 03:30:58 +0000
Message-ID: <20251007033100.836886-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
In-Reply-To: <20251007033100.836886-1-pasha.tatashin@soleen.com>
References: <20251007033100.836886-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KHO allows clients to preserve memory regions at any point before the
KHO state is finalized. The finalization process itself involves KHO
performing its own actions, such as serializing the overall
preserved memory map.

If this finalization process is aborted, the current implementation
destroys KHO's internal memory tracking structures
(`kho_out.ser.track.orders`). This behavior effectively unpreserves
all memory from KHO's perspective, regardless of whether those
preservations were made by clients before the finalization attempt
or by KHO itself during finalization.

This premature unpreservation is incorrect. An abort of the
finalization process should only undo actions taken by KHO as part of
that specific finalization attempt. Individual memory regions
preserved by clients prior to finalization should remain preserved,
as their lifecycle is managed by the clients themselves. These
clients might still need to call kho_unpreserve_folio() or
kho_unpreserve_phys() based on their own logic, even after a KHO
finalization attempt is aborted.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/kexec_handover.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 77fd7dd991d2..902c30feae09 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -1083,31 +1083,12 @@ EXPORT_SYMBOL_GPL(kho_restore_vmalloc);
 
 static int __kho_abort(void)
 {
-	int err = 0;
-	unsigned long order;
-	struct kho_mem_phys *physxa;
-
-	xa_for_each(&kho_out.track.orders, order, physxa) {
-		struct kho_mem_phys_bits *bits;
-		unsigned long phys;
-
-		xa_for_each(&physxa->phys_bits, phys, bits)
-			kfree(bits);
-
-		xa_destroy(&physxa->phys_bits);
-		kfree(physxa);
-	}
-	xa_destroy(&kho_out.track.orders);
-
 	if (kho_out.preserved_mem_map) {
 		kho_mem_ser_free(kho_out.preserved_mem_map);
 		kho_out.preserved_mem_map = NULL;
 	}
 
-	if (err)
-		pr_err("Failed to abort KHO finalization: %d\n", err);
-
-	return err;
+	return 0;
 }
 
 int kho_abort(void)
-- 
2.51.0.618.g983fd99d29-goog


