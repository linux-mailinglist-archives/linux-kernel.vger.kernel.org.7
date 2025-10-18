Return-Path: <linux-kernel+bounces-859319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59374BED4AB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 19:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 689C65E6F32
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 17:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BA225785F;
	Sat, 18 Oct 2025 17:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="cIuEA7cj"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA88425B1C7
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 17:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760807887; cv=none; b=eOP3MowUGwZcyNVuTnhB+Epeaee5NZE7HsXVm15/3nommjM0wJZm095barkdne1p6Bry0vt84Zgt1MeKGKbKh4BeS+n7Vg1xP67lFBnr6vey8kL8i0v/78FRMyepgmvxwZXruHOXlgAaDo95zxXA/U7iE+SdDAsPnp8pHy3nHZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760807887; c=relaxed/simple;
	bh=C9Ra1j+hNcxx2B5cYdmhSumT/vB9fFQNVijx1jxEqF0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QnBrGLtXvfDH4VVro6/q0Q8bR15yCrNQRIMNYqjwDDLV0DK8S0bWqQy5cNrB0h5Px3B+/QxOXnMPhJvSWFeHcWhnugswIIU48Csta8ccChSx0ytqXh/Ye7Np11b72ikR2GgplhlKaLO2oUVd3czboeqZWOYGYPbVxcZD6e1vdI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=cIuEA7cj; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-87d8fa51993so13140686d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 10:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760807885; x=1761412685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MeSkThIp0BgOUgzAnruASuFbTYnRMFC8HwaL1xWtkt0=;
        b=cIuEA7cjKePY6w50215cBWsvRroZwjvzGJUyQIcJIDLMfSIUZhCCCCoatlfjEr9keA
         nVfhfbBxkx2EgIarigcZsPY2ZEROyiu+1zBwHCZ8LkCo3QGCT3sizv1Nz6HezPjFMexX
         upjeCg9/skrvGzMla+RfW6q1u3EsVmaqpZeLU9lt8jJzmVsQOdmtV5H1uUHCcaqj1HGs
         IBFLnKtSZN7HI9LDWzaFjzRfM70n4AlzurCNEJYeWqH27mScG6h6FKXiOIiTBCMluGE+
         BR9zq5lAOrOyuFuaQFR3UV2EtEKwTZpDq8fQ1mcYEHJ0b3Zt6yQHQ2EyvT6AeJ7s6bja
         MV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760807885; x=1761412685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MeSkThIp0BgOUgzAnruASuFbTYnRMFC8HwaL1xWtkt0=;
        b=KRs+zZJVV6xp67+6IcquTAJYCokKzqQ8gvI1d7CDlCeRmCGnz/y8L+5y2yk2xH3AWg
         CL6BS016aaEEf/niBXrSCYr4PkAL437CIgYLewS1wZZn7dP/mBwTA60YR3m1FXtp8wZ4
         zE7taa2q/3mGrRfsufXazvplweZBRe/TVLzEcSzyuf0AmnYtDDry+JBOFdByX9vmEsGL
         ejLL41C0g1Ymy2+YXaVKYREWIjb17l8ExyDrcAv1qtj3nB2Vg4H+TBKcCln3h8GxEhIw
         u6UkDYbWYC5pOqqk4oFb/1TIrHYVhMzZCZoXLtkGVIZCo+QP/oPlCV34CDmKSq+1YWZ+
         5tyg==
X-Forwarded-Encrypted: i=1; AJvYcCVd/vU4mLb1jAYvBXFss5/HXJzRN1SNYeNeQh2MEbgJyc3JWfzO9KLlaDKiBiZwn9ZL+heXHqs2eXAgeGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YypwlVZs2VhhWcd2i3b6qrTJEsxtHrEKU75ZADleqDtn7fjhE0C
	vAkDBPh+WOhjz8+bJyWlVvct+2aKf3lxk2YAoWZVJQXVTW9hK1DOneFtSqiCHRGzbJs=
X-Gm-Gg: ASbGncvr0PKNfBCHsqgy8sgkO/DC3ASnXBy6+duHWNe6FhH1epQsOr+/zY19DZezYro
	yjYTZ+kp9hYkMTjcq1G2AZxziQTDb9LcinJEh9vrY7cm4QkJIS9xMMv3d6v6LIqGm1CulI6o+sq
	Qt1BZXPYaI4uTcXOH/LUzwG7CPVhmKqVC8yvqYWjx5q/ZTDNLXZCgTrJx4SN6jlvtE6MvnYtPN0
	6Ckmmzdia6XuFZyy0FtAD7mIrmE41LFiZCOxrlU2dmV5WeYuFMrNqgblpgA30EDyJCmq1wc1o02
	vSQjZvEgn5Li5RJfeX3eOLMvPhWYM2Yr+A2c5GLSJ042L7AMGCnA/SDhsBJm1aaooyf+GnP+dRj
	9Fua+UffMRbO1tRo5+k8PAqhSi0RpYO6hN1KY9jt8iYgugKwF3g3F3ckGKFGZYOr0NOFHAcSKmq
	g49SIGAKmhvm8XL8ZpZmiPBh+zZNzNSQTl/9MYWuQ0NXVHdqGutw/58Kx0ul8cBiF956O+9Npae
	xM3YF7sPTjZ31tvV4x5yg==
X-Google-Smtp-Source: AGHT+IFdBNVKA7wbdhBQt+CIgKi8/22s9Ed+9OmPWE+pFu/N1e12A5/0MkyaV4HSpQyJ88+n0QIffQ==
X-Received: by 2002:a05:6214:319a:b0:87c:20b5:6685 with SMTP id 6a1803df08f44-87c20b56795mr116436546d6.55.1760807884708;
        Sat, 18 Oct 2025 10:18:04 -0700 (PDT)
Received: from soleen.us-east4-b.c.cloudtop-prod-us-east.internal (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d02d8e909sm18478116d6.62.2025.10.18.10.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 10:18:04 -0700 (PDT)
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
	jasonmiu@google.com,
	dmatlack@google.com,
	skhawaja@google.com
Subject: [PATCH v6 05/10] kho: don't unpreserve memory during abort
Date: Sat, 18 Oct 2025 13:17:51 -0400
Message-ID: <20251018171756.1724191-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.915.g61a8936c21-goog
In-Reply-To: <20251018171756.1724191-1-pasha.tatashin@soleen.com>
References: <20251018171756.1724191-1-pasha.tatashin@soleen.com>
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
index 78acaa218c12..89a8f839346b 100644
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
2.51.0.915.g61a8936c21-goog


