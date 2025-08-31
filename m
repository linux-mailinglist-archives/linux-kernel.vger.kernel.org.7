Return-Path: <linux-kernel+bounces-793303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDAFB3D1AE
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 11:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34E2D4418DE
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 09:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E7125B2FE;
	Sun, 31 Aug 2025 09:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="WhzME8M2"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058E9258EC2
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 09:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756633187; cv=none; b=KRHLAsVlnrX+12rrIC2Hwt5ArQgpTcXyaCB/82jQ7R2/hUdbu3vQbypTDC8JlwMp+xNFZlUJZePOz9P2HvbcKMMqDv1TGjyYjAaKCkBCA/w7ytVm9cU4H1m5V47BvqZnUR+XMoC0PNSJx3impoayCrwH4qSH82omCCEaXtEA820=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756633187; c=relaxed/simple;
	bh=Kq9jl4vepq88dsyIU2VEKpbj+G4VTiDnEL+OOcpmbxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OnEhpp8xcfIbY+kMBe56rkxvP/j29HRRP6zT6EUk7VWOpoyMxvhQepoCz5P9phO0FHZh0jm4GTjZJIYCu8Hd1HVwwtV9rAQI9fqH1oEbXjGPe3bVR5SD7Sa0vD2cbXx7FHiPLzMbOYXLgMA68WU+zEbfC45fwRYNg5AK6jz/pHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=WhzME8M2; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b040df389easo124548766b.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 02:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756633184; x=1757237984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbQrHBJ8z81uwew1vi+7yRgIBMEBSVZY4WcnSS+Eg3g=;
        b=WhzME8M2paghbiLrxQgP1LEj4GIoxS9zJw9YYw5VaNx4uuXwpDpLzXalMD7vyO1a0O
         vMOCaxSEebi8wBzP4bTg/8NVZG45s2+zWRw5VxtTRxEhQCzV5fK3EvWRj0eRfJumWQm3
         dTLd7GxMYK5QDSOV3TupReoJGEEl8oYQ/HLsbFDwaFwpfdx4EpVjZfeXZe/M4h0AkZbh
         pXFVriqL484z3/FbSIAvUbwstFDpxzbNafjjg85DrVfGBEvSYUyAP933soKAMqeGWxxg
         Z0JlXcNurjzpdGrRei9y35E61aD9Gj+C1tcCo6tC7Zcg5yp9Pm7+4o+dbdqRzkCIicyL
         araw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756633184; x=1757237984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EbQrHBJ8z81uwew1vi+7yRgIBMEBSVZY4WcnSS+Eg3g=;
        b=HwWkFxNc5qrJbdrqipj/pVL4nUuk3Ze2/Os6iyoYLPxfRSPHhhc/ZLHQnbGJugOwA7
         nLxYO6XDlJmIztlZqlo6Avjj+1D66UhbZukLkXRkotpPxVvPWvfUkMusUerNT4BLgS3G
         nm1+U1il871hekkwMmZasOCISfou6aDqoejLRWlIsVLCam6diC77EcoxFSqjRFeMaV1S
         j9nU2+Bok2x863zeAgJIu9M94VfMez7Fk238L9lMvjj/LmhKyNhm+cCzk1i8trwJM6qS
         3llV5M9OArVRXlMg06Y8v6wtSqtK+HtosUEeVeQUzzzhsL5deuJgQ+MAdS/JagwVXBTb
         k2Hw==
X-Forwarded-Encrypted: i=1; AJvYcCV+Z2zPsM1VMURxMAMTIgD+nGkncOT/CFU2/CNiXQ1+JehDPnJE8f8IDf9uVxyPyFeC/0BxP1FpJoVb0WE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx1IwhxMXWwiETp37YsOM55ctNpV18rktCPyqYMibA7rxrQloP
	YfLk0a7PnDsZMJs5njkjWcSE7drnzMwG/5fNaCo5pT3Hl6qjdFGnY1yoLCw1zOzovRs=
X-Gm-Gg: ASbGncuy69UR003DaE6zWlejAMY9AZ5MtRxtLCfOYRlurOsweSMR/S9SdtgyvfK9xyb
	qvpl6vrtH+2qOI1ogiOc6Pt0lVME+Sx7c4LsF5mxq1D8ODmYQxNE/Eq1+CtyXYuyUk03nLs6ZIK
	ODgOcFQ5KsUcJk8o8eEI134wac8eN2AXjm1Nwn3p8+lMW3eyhwRFd9lNj316q+QXxVqMROZv8VW
	oXX17hMaIG4z6mVofttLLGzfY0a28AtLAEOLIZyKtun7yFkwRWDDMFwe+iv7iqEpKdlzp4ccTOS
	yedwdi1JJ+X9lvxiSxqeM0R7+BFDtWE8ZfbTSc1L7GkrrlBNktobsOFyb0afbMqw3jtFkVMulWk
	FHqHR07Z1yVG9GOUytT6HutarCFDcaVlZn1LOI3u9FR4dHpuTFce1n0uVLo1PyY/MiuorrE6OyC
	lvV/+dfZdmFZ13yvgLzOJrc70uveOiPnkw
X-Google-Smtp-Source: AGHT+IFxQDWLhxFg2jVKkWwDC8C9a2hu8u5iRtfwJyK9WMd0nF5snRkYBzKz4RD+jCsXIVYHRgz3VA==
X-Received: by 2002:a17:907:ec16:b0:afe:c2e7:3705 with SMTP id a640c23a62f3a-b01d8c74961mr360813566b.22.1756633184278;
        Sun, 31 Aug 2025 02:39:44 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcbd8656sm597512566b.56.2025.08.31.02.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 02:39:43 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	willy@infradead.org,
	hughd@google.com,
	mhocko@suse.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	vishal.moola@gmail.com
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 09/12] include/mm_types.h: add `const` to several pointer parameters
Date: Sun, 31 Aug 2025 11:39:15 +0200
Message-ID: <20250831093918.2815332-10-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250831093918.2815332-1-max.kellermann@ionos.com>
References: <20250831093918.2815332-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For improved const-correctness.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/mm_types.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index d934a3a5b443..46e27ee14bcf 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -632,7 +632,7 @@ static inline void ptdesc_pmd_pts_dec(struct ptdesc *ptdesc)
 	atomic_dec(&ptdesc->pt_share_count);
 }
 
-static inline int ptdesc_pmd_pts_count(struct ptdesc *ptdesc)
+static inline int ptdesc_pmd_pts_count(const struct ptdesc *const ptdesc)
 {
 	return atomic_read(&ptdesc->pt_share_count);
 }
@@ -660,7 +660,7 @@ static inline void set_page_private(struct page *page, unsigned long private)
 	page->private = private;
 }
 
-static inline void *folio_get_private(struct folio *folio)
+static inline void *folio_get_private(const struct folio *const folio)
 {
 	return folio->private;
 }
-- 
2.47.2


