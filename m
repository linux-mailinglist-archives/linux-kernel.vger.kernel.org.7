Return-Path: <linux-kernel+bounces-863934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21782BF98BC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 02:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4EF8561EB4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 00:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B35320C029;
	Wed, 22 Oct 2025 00:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="cjgtpnfJ"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21F81F181F
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 00:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761094648; cv=none; b=lyMzp/NkN1J9QbrmTAh3WmLDfhLjGBhpBKug7igWPrZQap50d6VBcRRFhwjWJrE9bX8eiHh0RS5tGB8RYDAiRb6qEttFUpDXfLtDAr2pANvz/EFqNmGE9e5XQCxm5c7/LXAkI1sqDOWKQHrk9yeTPbXyo+G7OOgKRzXVV6f2Kos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761094648; c=relaxed/simple;
	bh=NGuveJk2P3XFlSgQ+moH+HF3wVf2P/A5UKylVtCRxfA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IpSJGf0AX/kxiFPl5hoxS2lltaZ8HPpasRQkVUf/X3zApZIUzt3z+iJeWoe6gqL8/IRtvoxiYk4vsmonxKiUIHX+yyznURp+sJvzhyHzBcpwmSUAAJXCQT20b6oavdZP9sKv+DlsrTq+WyLjhSBw+KcVcgJpWf6YjhDVkv2pTVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=cjgtpnfJ; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4e89e689ec7so3607271cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761094646; x=1761699446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mUTWKaAwDcLFEMDYOAPCNVz4GAFYSZN3Yq9aKSos2/I=;
        b=cjgtpnfJRQRa0bR+LN65GdHPNb2c+9dUntXfHLpWv+8cyIyvM8XpICbmsqZxj5NesR
         XD7Za7ot4g2AEsZdBEI6CtZuizwnk4hK5vtXgndS1uR7qfWQBfquLyfCY6zaq8CaBoRb
         J3kgAsRRE8rsk7QnEZ58P1seDxEXGRCAPTIyT12Xnity67H7/Ywxn36v9MygPQ3bIFy9
         a3pCB2suUME9/DBJDOaGJhtF3hW2NNl5cH2D7DXYGk2UOoekDN95jl57wpNIPDFZJQWm
         w/Vj8BgdezUFJTNd1hcf5RnPa/O1Q+IQysNpBn4dPzLdFLFWT6E6WvY/mo7xQLaInvXL
         VAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761094646; x=1761699446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mUTWKaAwDcLFEMDYOAPCNVz4GAFYSZN3Yq9aKSos2/I=;
        b=IpvN/Ci640cRQ1QwZPCYcQDMLCAD6kVsOll3bZKHweVI0cvLPtKumY1QtsMH3XBKL+
         qlarIgGjFUuGY2/LjqSk0e3P4btROUe2KLKY6v63oE9y7XuQ5IQVBXuU5f/Jm08J/2Mi
         EXTo2LCAn/q7q5RzK2ev6PkiSXInRUZC6HN314tU5IDRfSl2RyQT3CZ88eqU/oxI6duW
         U9KyfAi2c+ZbOVe5ekqlpaXk7niSoplLBO7b/Uews2kJpXwcv7ySUHGY5pL9px5WuEN/
         oZDCaHhmhz7t1bbxMc1DDOt9uETgqTV8HQgY219uY1s0cGQzpE6hZjSBYPoZPJmPmOwF
         MhZg==
X-Forwarded-Encrypted: i=1; AJvYcCWVFQa2arQISVP26Uzr6LWnsNQWnisdJUinQf1aw5KkJ6OkrAhUanzDimJ63BlMsFzgnAUMOFTh46xbBIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1lWjPnVse6xCVqsAOnaPVETcOBawEDh2NY7GFJvz0BdM6L/L9
	cnqJuz//BU6JiHGIXxStwIcLB9NR+L18HdXCTRMRxnlP1vH+oIz6TtHNxWgRZcyFAMQ=
X-Gm-Gg: ASbGncuw0PipZARWTeSFIvD5bicQVjmNjiESnoweuUDjLWEq2RiUPLT3mNECN8nPnU6
	R0Dxn/dbrvMK+MhEVYfWTLnkRzuKkj0ZRBCdUyDNPFkLDO7wszk4rvE7JQaAqdGdba+qhoBGMK0
	Aoi/crXKTeSbjefW6tTOojraPR/gDzWAfEH523Z/IF+k5YciKyQSB+ODRLU0S+g9NoiWuaFeQ6r
	IyxYj+61Gp0J4NrA/26t5Yy3Yq013YBaU/UyjerePi+Zllc0xiJvWabmg41Ox1ipgzEkA+c/WVg
	1eB5DtMkqKS+ce10TeM8h0gR/hTA7KAV3I1Qserc/o6PFUFs+9v639vU1WUC8bmpanWk96G1SdV
	bn9DEjxKtQ8PhNkaIVhVJB2Qmwv0OwVQav5+KLitQFnOeVaNgWZCCAAGp0u76nXNXBJQQy3h0L7
	DuX7pEiN07+7mrQNDBAAAJxd9htEA/P1Jm+iPyC22escyTqxHLtNeb17mvAU8tSlFEkLDORh25U
	M014hP6BQ4Wmu5IwN+uSQ==
X-Google-Smtp-Source: AGHT+IHQH5S7ZkBo/f+yTi+bMGIOL+QuMwmJCvKKYbXx1vIv8VH/9TwZ606gNIBVjYEELqz69qTPIg==
X-Received: by 2002:a05:622a:110:b0:4e4:6b32:697a with SMTP id d75a77b69052e-4e8b6e0b299mr139105201cf.29.1761094645817;
        Tue, 21 Oct 2025 17:57:25 -0700 (PDT)
Received: from soleen.us-east4-b.c.cloudtop-prod-us-east.internal (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8aaf3432dsm84169501cf.2.2025.10.21.17.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 17:57:25 -0700 (PDT)
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
Subject: [PATCHv7 5/7] kho: don't unpreserve memory during abort
Date: Tue, 21 Oct 2025 20:57:17 -0400
Message-ID: <20251022005719.3670224-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.915.g61a8936c21-goog
In-Reply-To: <20251022005719.3670224-1-pasha.tatashin@soleen.com>
References: <20251022005719.3670224-1-pasha.tatashin@soleen.com>
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
index 8412897385ad..89a3fa89db0a 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -1103,31 +1103,12 @@ EXPORT_SYMBOL_GPL(kho_restore_vmalloc);
 
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
2.51.0.915.g61a8936c21-goog


