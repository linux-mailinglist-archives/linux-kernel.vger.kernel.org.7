Return-Path: <linux-kernel+bounces-841928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 201FDBB88C4
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 05:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 944B63472F3
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 03:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0631DE3DF;
	Sat,  4 Oct 2025 03:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwaNt6H2"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4DC2A1AA
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 03:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759547359; cv=none; b=SMsA2BcqlqqPqMuWR33QIqZmY83SKfxV1Hz9wck2qT4ebaUSF066dDTo0/wY8KY00yMBzo3I8Ze9G/VmlpcWxRoeGSRu1QcEu/uKa2DXKw0KsmWclq0hqQ0Yc4/zqxoHgA5TnOE9Kx9bvhrsr/MiuENTiRdTpzSEo4oDPmu530c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759547359; c=relaxed/simple;
	bh=l6Ef44f9+AzpaixRgRAp8RGfj3Zk1wioLQw76MXl1So=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jtkgvLzbkhOmKt6Yi4I6J4Ahgayoo1U8j/pz8cNgjoBgay7qpl13euKm2QmQBYe5ZrlSdl9UeHQ2EI89spuzsJOjoEAeQJGzZ1klg441bcvbgrmxYnZX8sN+cdqJWFWfiSj0euPmre+sSKL8on5D/TpTl7yoEhMcNLOUM6xRLeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WwaNt6H2; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-781206cce18so2594099b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 20:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759547357; x=1760152157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=llyEZQY0mloy3RaEkBiyvFLO4+4gWq62N7isj8QKbEw=;
        b=WwaNt6H2/F/9Aj7vcBh6AQfceOq9RJHY3327eZRF2uYiI+lh5Jez95gMP2+/DIhWIV
         j/OKQm7LnnUVH7TqMbLqrxjSSx22DFgVOtCO7KGToTGpdZrNUosIeFlzrwFKbJ1TxlGX
         a3GdMLt6fHc541MAN1DfpqmGfH8heQIlwT6DDRE8xXNOH4YYMn4NCBMognErkrvwGoPP
         Iz9te5yjvVKFjeeSF9/lVa708f50gbCqh9P/k3qeGFKsyiz8FWkcdX/V9MsW/bNORffu
         fVYrjFhRhNEdBR9tcVxr7IMs9AzqLITcxFRcNIz/wYic134Pa3tFHsTkF0hbsR7z9JaC
         FXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759547357; x=1760152157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=llyEZQY0mloy3RaEkBiyvFLO4+4gWq62N7isj8QKbEw=;
        b=J+0sEDiA2sbKEfmRKSgDOcrZdu8rEyfkGRSIO+3X0U4nSgZbhREjQHhwieg0gwuJdC
         iNXzswESAjUcVAGHK1cw7lh39DsLAT/7tVXvh88lREL27yzx62Sr/jLXvRyPbSpYC9OE
         dj1gZQO8NN/fxnJhldv43WI7eGcGD12FKufyObM9KdLqqtdXc9tYSD1flQbmIdOrAkgr
         nZ68eV47qgqaP4k1CRJcRWLE5aLpUOV7qtyW51d480lXkyYzzx9AkpBDetI/G9w0brv9
         r4Ri7u2E0QEqTeorHYvgqHUQdT57xxE0prGz66p+ZPozHV08qqVQOTy99niIuacJiEj7
         vqTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWDfffY5BA0b5vUGAeNrM6CbhrQSdWEddScTirHb8SIpA4XbSENnoAqrkrQbFf46UdTl87PMlqMRu522Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBwWNDHQnKqDxqrs78O5MKSb6xsL71J3cBJJRQufPWKo9FodRE
	I4TRgyGDZ6x4nRCgLiUuipBnPJ767PvlhB2661PxdeRi9Vecgnovu4Bo
X-Gm-Gg: ASbGncsdrTU2Lo4Y5nz3x88TTg8EGbEU9VZIHiwwME2ssEzKHQtjH2V9+sSC6sICGpm
	2AH8VADR9koEhaJ/gBdo9LZ2TnzsnzHhT8giKkn1KLAKZA5Y2TQl6bNJCB7w0CiUraWlery+JDl
	BhZbl6qtl4xTeufs/E3o67yINBYewCZBe3hZ/im4Cq3b+uLXPIxffUIa8SFGfjVSr3P3mPML8c5
	FzihecDNyTGT4zQPzdziN34rjb2vMlZgkjWSFzhlVzQZm1kXbx5ESxAgrFlNY6muU/l5RMJy74i
	Gh8UvWEMl4wsrAkSqF6db9COzOYLocpT4iXGOmxD3nqmPMbs2aawNhNEe627RFaXQdqlTyLvYKg
	V8wP/mZKva1fplGNQ6MX/Cq3Ompb/X2r4fEq2NZh+KRg32j4+PWRf/ysSQvti2w==
X-Google-Smtp-Source: AGHT+IGn24rRAn3ohvoYNubWucjGX8u0BlqwWrNTlIP1SEBmyKD0H/UK+YAx711lmWxrLLSbDrTeYA==
X-Received: by 2002:a05:6a00:4fd3:b0:77d:c625:f5d3 with SMTP id d2e1a72fcca58-78b021ebcd4mr11645062b3a.1.1759547356824;
        Fri, 03 Oct 2025 20:09:16 -0700 (PDT)
Received: from ryzoh.. ([2804:14c:5fc8:8033:c5aa:36f3:14cd:8995])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-78b0206e809sm6256279b3a.71.2025.10.03.20.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 20:09:16 -0700 (PDT)
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Subject: [PATCH] KVM: use folio_nr_pages() instead of shift operation
Date: Sat,  4 Oct 2025 00:02:10 -0300
Message-Id: <20251004030210.49080-1-pedrodemargomes@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

folio_nr_pages() is a faster helper function to get the number of pages when
NR_PAGES_IN_LARGE_FOLIO is enabled.

Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
---
 virt/kvm/guest_memfd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 7d85cc33c0bb..5fc5475cf826 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -77,9 +77,9 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
 	 * The order will be passed when creating the guest_memfd, and
 	 * checked when creating memslots.
 	 */
-	WARN_ON(!IS_ALIGNED(slot->gmem.pgoff, 1 << folio_order(folio)));
+	WARN_ON(!IS_ALIGNED(slot->gmem.pgoff, folio_nr_pages(folio)));
 	index = gfn - slot->base_gfn + slot->gmem.pgoff;
-	index = ALIGN_DOWN(index, 1 << folio_order(folio));
+	index = ALIGN_DOWN(index, folio_nr_pages(folio));
 	r = __kvm_gmem_prepare_folio(kvm, slot, index, folio);
 	if (!r)
 		kvm_gmem_mark_prepared(folio);
-- 
2.39.5


