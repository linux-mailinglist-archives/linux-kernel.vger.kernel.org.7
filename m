Return-Path: <linux-kernel+bounces-862950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 502E9BF69CA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D07B188143F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A79338919;
	Tue, 21 Oct 2025 12:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kgyr6H+b"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC836338586
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051598; cv=none; b=UIXDqGFMnf9OwzeX2UeNDQXgik7QJL0p15b0wDYABk/crQJyH82HCoO3ekQ+HSnPCq28EOT5awSnFJZs1BxygL0SOzyymPzB1uHKVMwwQfqCiW5B9u1pFH8VKZmDC5EYfqc7/TbFdiSD3WisZtlx9eTYP61SLUZWmAIVQr3OY1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051598; c=relaxed/simple;
	bh=u7008y8MgBH/UJlpJQuW7nnTnLv1WM7skWUdVur6z2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RmSjpju+MsqAKiJyyJN5LUbcATk9SU+2z/1BkloaKKptmGOkqqUperzRE8/ryixFJiY7VRtnhshrviqOzlyqOI21CAsC3avKI1fQVhFNT5juSbqekI3ol2iHFe0ialy0UVZoA2P+myt9EURQdgcut4OVbwFw/TeQyh26HqfwmP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kgyr6H+b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761051596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pex3TSD4VopdNGhgViIupu2qOIUkRM48nNF7NdH4ZpQ=;
	b=Kgyr6H+bMUNVG3Nv7OMg0cWCMXNWEXSUyX1OH1zG0rHG1r5Wl2sNd8obAe15yYuVwGDw6U
	AaOSb1dVckJMIgqM4VjljDvCGgBaZqxBXzOgYMz7arSeVPIhqfmKJqGxJyC/BGdU1Soknz
	KTAXjCGzAtitHkFPDw7AOMrpN49p2Kg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-wrD3SB6VMzeKSJCCRvhwSA-1; Tue, 21 Oct 2025 08:59:54 -0400
X-MC-Unique: wrD3SB6VMzeKSJCCRvhwSA-1
X-Mimecast-MFC-AGG-ID: wrD3SB6VMzeKSJCCRvhwSA_1761051593
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-471144baa6bso32647655e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 05:59:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761051593; x=1761656393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pex3TSD4VopdNGhgViIupu2qOIUkRM48nNF7NdH4ZpQ=;
        b=XfeDqGHxLXDXZg5lXaAgze5c1AEQjmlqoJZUTLby3MjfzshAbLYx2a8cLJkoGj5Q+V
         WbeigQbE5wp+BrpsMiTvlgzfJF/eM/vVnS+O1QyRrbrRRj4T5EpjsJodscfD4AFl61VO
         QZRuwxe2gU50vacXkYzk+tgHq2XQOd4j2hbXHmi/6HllUMmn83J1j9OjuuvWLKV27Tvk
         6XynVBx0nRRr6gIagwZkUBeF/TaJghpj+Oh6dDL58eADy0/nh0Q3uPZLkPABx0Npy8tI
         WJoDwR7OIE0flxLE01Kcs8c3LMwdHpDC5h7AIbjUTw3FMf7WS/EDNHNYTmCshXStEBsz
         TtqA==
X-Gm-Message-State: AOJu0YwGDsu3Obe5JSyjIQxC2H7MmmVpHloTVdhPrGY/XoYljFPCwQxs
	kSSnM15/2N+QQ+rYzyGcxWteeRbbWNs5+6wxM48SLzBhOrMKHELsqA1nF7M/30V8eqYQLFnJIYk
	AYAzDz6adgCDHUJf5qCp/BSUAGaYR69mhgpFajXtwS1sjAkPkGTMkZvLfEX3kZpuTbfYk14dkB8
	yKYBVvZ5Z7PmaC7ZvVRWveZdR0xGWE9LamtjKoTf+X/kvDuA==
X-Gm-Gg: ASbGncvxoubeRIGBxpcxub8+qTXHW85nA4PMcggmP4WPIB9JXsRZNIyCIHbNdfa9Jxt
	ockza3nFTS7o7VcxG5BttSec8qSLIN3Bx545mYLpFaKCWfAzHIWhL74snPKgvw+J2FbUcw+mvui
	JPlrfltpIKB2iWkgq1AE5Sj8CgUMuQkEiYHlXotluUKXhCxyVw5Rp2aCKj2UZES1oCFL19HV2rY
	mQVOcl+2QZYIn8F5QMZ5AKXarQ6aDqMnELOJE4OX47iGvxMp6wpxqxAK2gCvxjZ+hQRH11G+R7s
	sjySllltkjbEYZlff9uFlBaeSDg7dTGMK/r2CIKEL/7pBR5dQhH9bPicidb4rjsOBUd8lKWQqc0
	+04+KiohXumBRGKrSJ//qWsjhGmOsnQZgXX6dznSES4ttOESmvGT7kosnZVCW
X-Received: by 2002:a05:600c:3581:b0:45d:d5df:ab2d with SMTP id 5b1f17b1804b1-4711790bf23mr118756045e9.26.1761051592866;
        Tue, 21 Oct 2025 05:59:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEA4wZ2YHHfGwBY+P4joTOmyMCpMPrDXxQSxjIfhLQThHNmEp/4Y/9hLtnfofL7CHt5koNYrw==
X-Received: by 2002:a05:600c:3581:b0:45d:d5df:ab2d with SMTP id 5b1f17b1804b1-4711790bf23mr118755415e9.26.1761051592292;
        Tue, 21 Oct 2025 05:59:52 -0700 (PDT)
Received: from localhost (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427f00ce178sm20202274f8f.46.2025.10.21.05.59.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 05:59:51 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
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
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v1 09/23] mm/balloon_compaction: make balloon_mops static
Date: Tue, 21 Oct 2025 14:59:14 +0200
Message-ID: <20251021125929.377194-10-david@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021125929.377194-1-david@redhat.com>
References: <20251021125929.377194-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no need to expose this anymore, so let's just make it static.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/balloon_compaction.h | 1 -
 mm/balloon_compaction.c            | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index ad594af6ed100..7db66c2c86cdc 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -78,7 +78,6 @@ static inline void balloon_devinfo_init(struct balloon_dev_info *balloon)
 }
 
 #ifdef CONFIG_BALLOON_COMPACTION
-extern const struct movable_operations balloon_mops;
 /*
  * balloon_page_device - get the b_dev_info descriptor for the balloon device
  *			 that enqueues the given page.
diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index 28ef0cb6b3bbc..c44e0b62203cc 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -286,7 +286,7 @@ static int balloon_page_migrate(struct page *newpage, struct page *page,
 	return 0;
 }
 
-const struct movable_operations balloon_mops = {
+static const struct movable_operations balloon_mops = {
 	.migrate_page = balloon_page_migrate,
 	.isolate_page = balloon_page_isolate,
 	.putback_page = balloon_page_putback,
-- 
2.51.0


