Return-Path: <linux-kernel+bounces-809154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C364B5094C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 01:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 821A9681BD2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 23:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F122882B6;
	Tue,  9 Sep 2025 23:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CXpLEtH9"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC7C28B7DE
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 23:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757460862; cv=none; b=hgyJcjADOP5YQkF8ErvgKGWDH92LHUGhq06+smP98bGat0ySmi1U/UbSGaJfQQjhO12+MzHDKXyNj20n0vOdMfqG1VdvWwVa68KffPwnW4zrmI25TcHKoywN7XjaYSOYCuTdb6kQzuK00BeyxP9XRhyErGs9uJIofIkMXAsCDBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757460862; c=relaxed/simple;
	bh=paM9mBGyRaI8AAQ1YFJDdCA9Ntl8aRb2Pn6q4fv7/iI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h0KL/2C+0tyCcQ5qP1qEEnGPqNxnxQQgiiZCD3y9T9QrL5LTIAANU9GT3R3IP759BkEb6afn7D4g205UtEQ7qO+hqG3ApkwS5V/YDayFIDAMqn98//ALWrwxFuB/LdauYb7GcLKSN6VXXrlzPd0aSzgu7q6AiOYgxvf18ZhX3rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CXpLEtH9; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-77429fb6ce4so3977036b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 16:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757460860; x=1758065660; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9D+kUp+8/PWIFjKllG6CENhJfl0f54OgddsYmF4lYnY=;
        b=CXpLEtH91peSjvKDBvW+CuOhHDDyNuZvWhrppc9+VIB6IKtVcTjJfXPb7Qr4Xeg+87
         BnDXh9SI4iiJC7uoMaBA9/ou9FfqzBvMf67aK5EAVM71cI3vkc1JsiSdKlPxa6jHQhoW
         84Ujo+TLm1gjWQjGZNRT5BANuN4V+72NuP0d8RiCsDKXt68E5HDxPDI+RI5FfpkGXcq5
         AMBtUd4iIrZ5HQJyTTeF7jG0NnQ4K+EuE12COR1Pbj1t8ihsA/qrpboh220EVgO3MzfF
         2ues9Ay482g9J+vPxPnpaZxdmVcC/+9X2dxlQQgb8wV2rjZY6ruOxrUBMdbYUWZZGY32
         VeGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757460860; x=1758065660;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9D+kUp+8/PWIFjKllG6CENhJfl0f54OgddsYmF4lYnY=;
        b=sYVmVSBThMRj8BWPwkb0/w+lx2GcbmusRJ3Yl81CBNXDiQrWLZRzW36JTyK58UaDdM
         T9kPHmIp6pXdtCPpvSCoZ7A317Pl7tQWQcJZxckKjPAq1DPj9NDDgqA7Um62+Tf0ePEx
         hC8NnLYHD4XiSqjzZ5rhgZ/l5iIsrUS15bREDBEUfhj9X7iTPBlqX5h14QOsHk3IZku9
         UzCdjzz6BdPV3TLs3bHg5uTB+fq1M7Hgks09z7mGrRScYXnMUZBw4UytWoJBastyGwo1
         o2xAuHg2rqRjNIEOmzdmWkFapTdQrsdu8QvRiHPV/uJCTGyKw0OWBlUpPxBpT2QR7piQ
         Jnqw==
X-Forwarded-Encrypted: i=1; AJvYcCWIl94VSNDkBscEG9vaAPj0fGOdfLCB+LTx0EE+sMf7X2CKHts+BOcoFJdvoGq3qch68VAkzCF92ux5ezM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqPF5zI9XceXnFvSvn4Gr5tB37oH4WvZOBS39XU3jaKNh6z9+D
	JszFN4Cd3VQbrkzDVRNnbNjvLLYBf+L6Kcvk74onC3YBkJwqTXfSv8resPXzNFOuCY/BrVZ9MXi
	hb5JnWQ==
X-Google-Smtp-Source: AGHT+IH21M6CEVT6I4cbVbLFhLsLvsvyph9LaEsNMJBlcaaK/bkq0Ym1zULWMNoZDsLFG63V/okgQHCwDiw=
X-Received: from pfbcj20.prod.google.com ([2002:a05:6a00:2994:b0:772:701:dfa4])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:14c2:b0:772:80d3:b684
 with SMTP id d2e1a72fcca58-7742de925bemr16942717b3a.22.1757460859886; Tue, 09
 Sep 2025 16:34:19 -0700 (PDT)
Date: Tue,  9 Sep 2025 16:34:09 -0700
In-Reply-To: <20250909233409.1013367-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250909233409.1013367-1-surenb@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250909233409.1013367-4-surenb@google.com>
Subject: [PATCH 3/3] alloc_tag: avoid warnings when freeing non-compound
 "tail" pages
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, vbabka@suse.cz, mhocko@suse.com, 
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, 
	usamaarif642@gmail.com, shakeel.butt@linux.dev, 00107082@163.com, 
	pasha.tatashin@soleen.com, souravpanda@google.com, surenb@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When freeing "tail" pages of a non-compount high-order page, we properly
subtract the allocation tag counters, however later when these pages are
released, alloc_tag_sub() will issue warnings because tags for these pages
are NULL.
This issue was originally anticipated by Vlastimil in his review [1] and
then recently reported by David.
Prevent warnings by marking the tags empty.

[1] https://lore.kernel.org/all/6db0f0c8-81cb-4d04-9560-ba73d63db4b8@suse.cz/

Suggested-by: David Wang <00107082@163.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/page_alloc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1760346bbd24..d21a411e807e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5240,9 +5240,16 @@ static void ___free_pages(struct page *page, unsigned int order,
 		__free_frozen_pages(page, order, fpi_flags);
 	else if (!head) {
 		pgalloc_tag_sub_pages(tag, (1 << order) - 1);
-		while (order-- > 0)
+		while (order-- > 0) {
+			/*
+			 * The "tail" pages of this non-compound high-order
+			 * page will have no code tags, so to avoid warnings
+			 * mark them as empty.
+			 */
+			clear_page_tag_ref(page + (1 << order));
 			__free_frozen_pages(page + (1 << order), order,
 					    fpi_flags);
+		}
 	}
 }
 
-- 
2.51.0.384.g4c02a37b29-goog


