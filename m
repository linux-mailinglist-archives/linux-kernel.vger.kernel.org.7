Return-Path: <linux-kernel+bounces-780558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72945B3042A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 22:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FED716BABE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0732F362A;
	Thu, 21 Aug 2025 20:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SnpsrlZn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1202D7DD1
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 20:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806852; cv=none; b=iyU3EP3QolChRLf4l4QaJUoxaHEXDNAtEfGFOgYD5/nqsotoAE+/KbpR+3iTbrBIdcwlJ2UaB2lSNtpJChBJnY0LYEcCUhe6dvrynlHFUNgOdWwort27rs2+QEhUhL4RkAiW0sd9WPMHMUM4aBliCuQ84JtTDY69nQmKDH4hhwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806852; c=relaxed/simple;
	bh=s79Oeg502W4xdw3NRVnr9AKhHVyvkgzn8FY1ksnzdKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T3T/UcEWysTvbBzR4o8VClU7V/QL/Cjubm6KmCEevIdEBdgc9o+qEsvLuHvpjt5hUa2YJ5wwIXxuZak4aU6hTwmbtgo7iU1XO/LCvquEGg9nvFp40CWv19hqJTFrHquIktMlRDG8yAj1Xznu5WHXzVMcHSbJBGHaibCu+xlymnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SnpsrlZn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A9Znt0atqEjtEUkbTSfKRsvBJ9rEcbnqI7Kn1XkJSrA=;
	b=SnpsrlZnCr7yPr+yQE8LfuUz+2vDG6lLH3Xny9FDUfVZrO4sltcf69/70Knd3TTLcwOvG/
	FEGkLYB11/LkSWEDiP+FFWGTaFA/OE1wYi+1/dD2q6GfeChypC4oun8Ho6uMpmG8/E+hMs
	VbXi9mPrN2A6lPttujgXBk3iZj8aRUE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-_2rLgeUlNW6jISX6w1QpRQ-1; Thu, 21 Aug 2025 16:07:28 -0400
X-MC-Unique: _2rLgeUlNW6jISX6w1QpRQ-1
X-Mimecast-MFC-AGG-ID: _2rLgeUlNW6jISX6w1QpRQ_1755806847
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45a1b0b2b5cso10135975e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:07:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806847; x=1756411647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A9Znt0atqEjtEUkbTSfKRsvBJ9rEcbnqI7Kn1XkJSrA=;
        b=kbug88BOwN9pperRrL36z0tSms4CwUuYolYAxvKHZlKyFkaZEStbxX6BqQP1djm+gB
         ZK2arQOoPVnSGuQx5Jq6xpd902Qm6b6frEdlj5Ul9NBySyjxxwwMKtI7B9TO4nvTAup7
         cBFNZd1rap7LsZJrY1b1KpdcoMx5LscVbX5O2+6dZlCoZWQKOASbJyTEl4JqXzom/oXG
         YS7LpHC/5DkUyPh/WLbKo62+Ix668xtvfqMLhvUyPONO38SSESseS1EzMoUylqkMr6eZ
         OKzYOn25S8G5HgRnwXY6nEPdvQ6fNm6eE2zPWI6fwB4pYD4Q850pZGSNc/mmF8LBomgB
         BQIA==
X-Gm-Message-State: AOJu0YzZV5Jld/+RDzHJXNk8Zuhyq4b6qBtchj8nuNACywEOZLwWHyNN
	hJYVO8FIjOoSabs/LanX2WsiCLxedkR8iVMAqEe4WC7/8OB9Vc89WZptPwTiHChswkYWr7dMeKG
	i7rs6UCzGFhPHaGv3+tw0629WGQU7XRuH/G1X3Qwol1Zc1srMn8bjBAVt8y6VB17geKzJrHOaeo
	fAaj5JT8ZAgkt58FqVA1cNQUdjP2gz9CVix7vTq3DCWPn1VvMd
X-Gm-Gg: ASbGncukwR1LK11eKhYdfpEDIBtdPFOwgTMmmWSTHp3jOid9FvjzufQKNghczbcVx6w
	uLHrLIi7UFZQAjA8CD51L7qrC4BW2/S4o+xIjpPy06Ki6QU2FJDRWFaVfQEvZcZ+VzHz53Ko6tH
	rtb/MeEoRi5M1up9Zo/0hncxQoiZAcXEbDCFKixRTgPxf1bZ7IS413N4f5cPYr4a/f2jLyO6dD+
	hExrvVHbv2sKN6k4WQsBcRjDsvyznDoYDZCSBi5Mtaws5yAASd2maW8hAKnNmCWdIK6vpATQ3Qq
	IKJcSuPrEzcbDihNvZ92tggECIyFnz8Hv48pyDyISRjgB3T1YPFFPnYI6LXVPuPFleb1NiZQhuZ
	/L8XlID9g2p6iPdWBVt+KDQ==
X-Received: by 2002:a05:600c:3552:b0:459:dde3:1a33 with SMTP id 5b1f17b1804b1-45b517d26d4mr2922455e9.26.1755806847302;
        Thu, 21 Aug 2025 13:07:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUeapMM5JkcwJNJXC+LM6ICHu4lGUEF2ir46AAuHXhYXAFzTcPIdec/q/lplZD/isU7mGEgg==
X-Received: by 2002:a05:600c:3552:b0:459:dde3:1a33 with SMTP id 5b1f17b1804b1-45b517d26d4mr2921795e9.26.1755806846742;
        Thu, 21 Aug 2025 13:07:26 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b50d62991sm9535385e9.0.2025.08.21.13.07.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:26 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
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
Subject: [PATCH RFC 07/35] mm/memremap: reject unreasonable folio/compound page sizes in memremap_pages()
Date: Thu, 21 Aug 2025 22:06:33 +0200
Message-ID: <20250821200701.1329277-8-david@redhat.com>
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

Let's reject unreasonable folio sizes early, where we can still fail.
We'll add sanity checks to prepare_compound_head/prepare_compound_page
next.

Is there a way to configure a system such that unreasonable folio sizes
would be possible? It would already be rather questionable.

If so, we'd probably want to bail out earlier, where we can avoid a
WARN and just report a proper error message that indicates where
something went wrong such that we messed up.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memremap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/memremap.c b/mm/memremap.c
index b0ce0d8254bd8..a2d4bb88f64b6 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -275,6 +275,9 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
 
 	if (WARN_ONCE(!nr_range, "nr_range must be specified\n"))
 		return ERR_PTR(-EINVAL);
+	if (WARN_ONCE(pgmap->vmemmap_shift > MAX_FOLIO_ORDER,
+		      "requested folio size unsupported\n"))
+		return ERR_PTR(-EINVAL);
 
 	switch (pgmap->type) {
 	case MEMORY_DEVICE_PRIVATE:
-- 
2.50.1


