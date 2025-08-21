Return-Path: <linux-kernel+bounces-780553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A140FB303D0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 22:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EA1E1CC4F74
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31ED353374;
	Thu, 21 Aug 2025 20:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HbguPC8t"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A3135082B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 20:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806839; cv=none; b=ewdZvM3+tU72SBAYxFk1XROZGLyJ290CioPCenI2YDmATUpjtolaxTTITHoszfkSeQ04JLjoBai1a24qFET2Cx5ID+pP4/ArNjjQmXvf90UxlBWaOVoIe5exyVU8YvTeqI7BZHmsR4fly7oIRrM9iqViOosmBvNoAHjUFBJItLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806839; c=relaxed/simple;
	bh=3FOM28sJXvbUF2Tn/5jLCVekviR1dLu1+OtM4m//AQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mDovI+cz69sAhD4EauL4umU5F36yrXnt9CfFhyrh4aF6htvg+JQEAegJ8HZmi1mugCcM3GCXXLZkOc6qKQ9qVNJFaJKxif3nHVw2N1WoBaIF7nr7eGcl06ZRC+LTDG93au9HMDuC4NAeIQWAPPniM0R97F1MSPnY1ly46KSB9DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HbguPC8t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7sWLap5u4LkaWlbSo2T/W3JLtp2tuveUv2Z9sucaeo0=;
	b=HbguPC8tqBkg7t9/QOVKN35ZpT6p3DwwnNWto2lsLSPmzEFAH/NWIL/1ftGjfqy6oJgfIm
	vFfgtL3Abduu/oa56uS15OTjsdnVjAj0CciRfKz5zBxWHb5uXFtpZ4foA1Ur45VsAHtVSt
	nkvO04oL4Iu1BYlT+IGC12IVe5fuu8I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-KJkzqbYiOu2IFrKT4zHA0w-1; Thu, 21 Aug 2025 16:07:14 -0400
X-MC-Unique: KJkzqbYiOu2IFrKT4zHA0w-1
X-Mimecast-MFC-AGG-ID: KJkzqbYiOu2IFrKT4zHA0w_1755806834
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a1b0ccb6cso6963445e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:07:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806833; x=1756411633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7sWLap5u4LkaWlbSo2T/W3JLtp2tuveUv2Z9sucaeo0=;
        b=nx5pmfkYHZPCoNDOdbJKI36JG1jRc3YfhCZIY3Df4l8IAnCAiRpdBfFijfuVNmDnP7
         qTa8XhulRk7i8HCTzK/3hLzjIZyRy5OO1+kl7PxtMz+vliCiucwWU/bqHGJImV6tvMJL
         A+IR5VNt0TFCMSyUXDqBYxcJDxFhaIKSi17VUSmpyx1XUQZKktmPQ8wgMOy+rmWyG3ju
         GTzEbWatVxLHSINetIvi5/OJFNmwxmdlgcqVvqHJrjez3abLtTwgjD0U2M9kih5Mg7Pi
         rh2eVghBdBznb9GN65pygNapZWG388V9sciQxVDKcD2jX1goH6/zO1AE7F7nGfitNG+r
         N0Mg==
X-Gm-Message-State: AOJu0Yy8NXEnCIMoVKnO0uKwUTBI1ppK9iou5MnS7X9EvV3ranqFxLX3
	cUhgXBzr5Zh9GnUUOFJuCKJ15v0G7abV1cMSbR1cvjvf7cP0rrwQwkkI4HGc5AbUCPGLwQCFx29
	AKRhmbBbykGTyP42P+i7Fw8GsVCTGNleJhmx916KdaKfAQI6HKQRARk9WKA+BPY4XQTRuIf8jda
	/5BR4oz8UomVT0PkwSUFWN+b2exgXAgvlHM8uxrvGQxTx6sOc7
X-Gm-Gg: ASbGnctQegq+QXSvYtsPLP5A+7Lfl1AwDg8vRqy22S6AenThGYWfUOywqaOzcw2bIYJ
	5/l0XOkuufk2VxLxObIqR+MCkX06BxIyPc7c+Zrln+Ygi2OdBUEx6j5PV8p4mNBZnGfn10JnNG/
	k6w0DB/cygypEuXE5qnRcJQctGckSat3Yu+jkqHNe9F/MiBTWXxM80EMxIx9KqkZtD6HpJMtIIr
	Ry0skmU/rwRXzQlO9LJhBOfk7JenVaCF+3J1SwpNMeUx/ohGiVC2R3yrhLxGDZadIhnuPaRLlYB
	UQJKGn3+3EvGfUOS4dwhmSy3JeFto19yLwDKN4t1+THqXLPgZXXUXj6dv/M9UJP0xfcRZRp2/6j
	rIkavtDXrTba94gC6NF1bNA==
X-Received: by 2002:a05:600c:1d06:b0:455:ed48:144f with SMTP id 5b1f17b1804b1-45b5179669dmr2598715e9.14.1755806833475;
        Thu, 21 Aug 2025 13:07:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSutx6qbatKffMJ28UfT2ZDXFlSv+vNq81oYks3KAGI73zxxTWKo8ClwQ/mmPq6W0wDfVQow==
X-Received: by 2002:a05:600c:1d06:b0:455:ed48:144f with SMTP id 5b1f17b1804b1-45b5179669dmr2597955e9.14.1755806832889;
        Thu, 21 Aug 2025 13:07:12 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c0771c166bsm12916801f8f.33.2025.08.21.13.07.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:11 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Jackman <jackmanb@google.com>,
	Christoph Lameter <cl@gentwo.org>,
	Dennis Zhou <dennis@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	iommu@lists.linux.dev,
	io-uring@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	John Hubbard <jhubbard@nvidia.com>,
	kasan-dev@googlegroups.com,
	kvm@vger.kernel.org,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-arm-kernel@axis.com,
	linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Marco Elver <elver@google.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	netdev@vger.kernel.org,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tejun Heo <tj@kernel.org>,
	virtualization@lists.linux.dev,
	Vlastimil Babka <vbabka@suse.cz>,
	wireguard@lists.zx2c4.com,
	x86@kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH RFC 02/35] arm64: Kconfig: drop superfluous "select SPARSEMEM_VMEMMAP"
Date: Thu, 21 Aug 2025 22:06:28 +0200
Message-ID: <20250821200701.1329277-3-david@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821200701.1329277-1-david@redhat.com>
References: <20250821200701.1329277-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now handled by the core automatically once SPARSEMEM_VMEMMAP_ENABLE
is selected.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/arm64/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e9bbfacc35a64..b1d1f2ff2493b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1570,7 +1570,6 @@ source "kernel/Kconfig.hz"
 config ARCH_SPARSEMEM_ENABLE
 	def_bool y
 	select SPARSEMEM_VMEMMAP_ENABLE
-	select SPARSEMEM_VMEMMAP
 
 config HW_PERF_EVENTS
 	def_bool y
-- 
2.50.1


