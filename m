Return-Path: <linux-kernel+bounces-863199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E09A2BF738D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 934DC3A8B45
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BDD34217B;
	Tue, 21 Oct 2025 15:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iDqdnBm2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1859342164
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 15:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058858; cv=none; b=kduCsx3hcxihoTIFCGgCfZ1FOMH2rPGpsCGDw6KYHg+aNoEBvHU6ADy5GsmY/ehXx1XuNdEPV9eSXyLT0XTtsnWKypykDc3c7V2wfgInVtchCelcc9kxcYj76YuzIiFS6BbWj+9xTnJ591NevKqZ0ziQugzE58cfOSfRKPfn7T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058858; c=relaxed/simple;
	bh=bQcdfA2mrt7mpXYEYdKFgafDPjdfDxx4+RaAhMIH5Tk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZAV16wsxBnbUqB7p9H5NCiuaaGyJEiJIvA8Dz9b1WiG0k+eDGL9qetJ5f4vWAIbLu8H9EN+2D+aSb8qZN//Qit0i69UcElZSWgBlqCsF8/1kGoGqbXDYY+Vfakcfi+2Ii8TQnM0Ae25mcVZWTkgpOP+oPhXPJwz8IaEbHyxv4gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iDqdnBm2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761058855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XDLrgg+nqjJKw4aq9VppMtv44pG2L3C4aYFxjxK1b9A=;
	b=iDqdnBm2XrAqQd/9z9fY0eRNHISpIZhamE09/Wq3alFjr3v97pYM6xfr4fIfxF/xcSc0z5
	DMpEz6lwRhXKNaKuIaYgcM/kwA58RQ6T68bEumzRGKx9JKwHluCqOdA36O6lngrV46UH6C
	6lX17K/ZN8ynSOWpm6SvDGknemsMxQw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-jhl1VpW2M16CaS2dQ5FaXA-1; Tue, 21 Oct 2025 11:00:52 -0400
X-MC-Unique: jhl1VpW2M16CaS2dQ5FaXA-1
X-Mimecast-MFC-AGG-ID: jhl1VpW2M16CaS2dQ5FaXA_1761058850
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-471148ad64aso23744165e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761058850; x=1761663650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XDLrgg+nqjJKw4aq9VppMtv44pG2L3C4aYFxjxK1b9A=;
        b=Q0KmBYdcC6/XG/k7o9w3f0/h7TJIPxlB3ZE8RjzMbuBBjr7UGxUQWqRSaXhKMLOHJG
         J3B9hPDjRidK6SXBbICxJD+8mGg44CBWG4OOLG3LFfIjJEGCwpGW7yH1UInqb+EDsKCF
         u3T0dM1ACrAa41nbIPo5EjNWWWXqAWFrpzsIzRjznGOwm7v+/qqx5htxmVmLT0thYjTP
         0/4xitkRAAJ/sPxlUkf3RChqippmpWSO4N/vFqXeDwg996k+pIFtBI1/bsyVrZrYwYuN
         v6c9ZNr8DSpMhIBnNLdQrjhsevbSUwCrDz6pHlcWmXOYK4ylvqjUZ9+62L9yIbSdN/ej
         APfg==
X-Gm-Message-State: AOJu0Yy84RLuugZTChcj4EHNECpz0cwfUdfaYBkEjhiEXxVZur2RXAw9
	7cgHi67C4SVVtLGOX/62/IUGnXEUVcHg0Kr909kHpyK8eauNGwNOBH18MYhvARh0pumXVdSAqRe
	Fnxm+swOi86nzXh2McDjIiVy6OIlUunEU44eaaWG6EWj2fM+gGPztEnFlzsFj+2/efFixMgPzDy
	sSaINC76q3jFjKCsaAks0VIJm1UuULS/cLugqMDxBluK+/+A==
X-Gm-Gg: ASbGncvF/RP6DucnQPfyrlFVRIAywyCk/BB9GmtS0AzJqJGW5FHFQ7aJP3IhSCU0IwK
	+i6geOkxuEmPWSAukNPJH38B63ATCVa2Bg905/nIa/c6KI7lWjDgKhvR2SKDjQITy9V+or/h/FY
	h4D+kBCFYhqFFnmrfVS6wnX5Q9agywKCBOLhntq26B2/P1Jd6s6sDMydDv13JFcAf6KgH1LxSST
	K8oZTAipHsvQEv3A2KagPFMUpSLdNMgYHN2IdFmRfqi0/IsYiFOsmTc9/d47YDCxDgQoZ3k1i+I
	BLVB1ufBoMdO7vMc2GPgA22y73ecAC47664GNgsQKHbOLR9+HjBadErxKajNHPyVnWPH0H26pEj
	CJhISlwJxaaFDf6bUsj2U44409tD2Z9ebW8DDIMJXjowUiiaqcL/7RS4pjue1
X-Received: by 2002:a05:600c:3f10:b0:46e:59f8:8546 with SMTP id 5b1f17b1804b1-471178afb7amr120260315e9.17.1761058850287;
        Tue, 21 Oct 2025 08:00:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDk/chsWh4lmzSq81oi5QgoA5chh2GWI8u8p0fIiNZPQgGrNl16RwScdXvWvZ/Onc3FnooFg==
X-Received: by 2002:a05:600c:3f10:b0:46e:59f8:8546 with SMTP id 5b1f17b1804b1-471178afb7amr120259635e9.17.1761058849707;
        Tue, 21 Oct 2025 08:00:49 -0700 (PDT)
Received: from localhost (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-471553f8a3asm233676345e9.16.2025.10.21.08.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 08:00:49 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 20/23] mm/kconfig: make BALLOON_COMPACTION depend on MIGRATION
Date: Tue, 21 Oct 2025 17:00:37 +0200
Message-ID: <20251021150040.498160-4-david@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021150040.498160-1-david@redhat.com>
References: <20251021125929.377194-1-david@redhat.com>
 <20251021150040.498160-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migration support for balloon memory depends on MIGRATION not
COMPACTION. Compaction is simply another user of page migration.

The last dependency on compaction.c was effectively removed with
commit 3d388584d599 ("mm: convert "movable" flag in page->mapping to a
page flag"). Ever since, everything for handling movable_ops page
migration resides in core migration code.

So let's change the dependency and adjust the description +
help text.

We'll rename BALLOON_COMPACTION separately next.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/Kconfig | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index e47321051d765..3aff4d05a2d8c 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -599,17 +599,14 @@ config MEMORY_BALLOON
 #
 # support for memory balloon compaction
 config BALLOON_COMPACTION
-	bool "Allow for balloon memory compaction/migration"
+	bool "Allow for balloon memory migration"
 	default y
-	depends on COMPACTION && MEMORY_BALLOON
-	help
-	  Memory fragmentation introduced by ballooning might reduce
-	  significantly the number of 2MB contiguous memory blocks that can be
-	  used within a guest, thus imposing performance penalties associated
-	  with the reduced number of transparent huge pages that could be used
-	  by the guest workload. Allowing the compaction & migration for memory
-	  pages enlisted as being part of memory balloon devices avoids the
-	  scenario aforementioned and helps improving memory defragmentation.
+	depends on MIGRATION && MEMORY_BALLOON
+	help
+	  Allow for migration of pages inflated in a memory balloon such that
+	  they can be allocated from memory areas only available for movable
+	  allocations (e.g., ZONE_MOVABLE, CMA) and such that they can get
+	  migrated for memory defragmentation purposes by memory compaction.
 
 #
 # support for memory compaction
-- 
2.51.0


