Return-Path: <linux-kernel+bounces-863196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5318BF73B7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8654619C299B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722FD341AA4;
	Tue, 21 Oct 2025 15:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JGgaacBF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5E6341655
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 15:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058850; cv=none; b=Ug1PhCNlWPSOhiixt+VNjGpv+7viYBFsQe+9+2K7/KXmT1KvpUHu16WbaTX+VOJEueojPxZ1iW78+cog/bpNjxNR/WFvAcqxgkARAXZ7on/GtvZplGbPDsXf/c+8VyvAzfl5slQsKtboEv1+wxTTvWPpYWRK+tashJ4tjyQLPq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058850; c=relaxed/simple;
	bh=L7kBVIaKloL9qtKYYhf9Gn1Ws+54U3dYXmIRPOFuXCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aNr0ZbBNzLWw97ZfikJgIFbKtKJGCplEqQIyXdk1IzO8Llk/6K2Sw2b+12I7fw9az45afXFZfxq2d29slbhqK5yNjueKnqCzH6TjtAcMSaXXVfoRuXa9X3uu8F53FFUlzNPMlP6sxjX5mdkb+34y152Vj9qZqekzWzb5rlIr4mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JGgaacBF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761058848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ky9IQ4YAsBLfeIwBY21tvLCKpQrC6NzvR2EdWfDbaQg=;
	b=JGgaacBFKnJ6m/FOK27YKEeczl/yDCCZEfZSu7HBVhQwwWE/v2D7cFr069C7ynaJ/PSNH0
	gSTitES2vRPJ3YTqcw6GJB1WF3g0AaU795WM3Q/as5Qnhf2h/B2inbY7/9jIQ4hOZ1D8O1
	+QKpjdDNzBnxQuSu4bGSk+Ore8xglk8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-PWnioEc3NB65NwLtQGL6fA-1; Tue, 21 Oct 2025 11:00:47 -0400
X-MC-Unique: PWnioEc3NB65NwLtQGL6fA-1
X-Mimecast-MFC-AGG-ID: PWnioEc3NB65NwLtQGL6fA_1761058846
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47111dc7c5dso30354795e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761058846; x=1761663646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ky9IQ4YAsBLfeIwBY21tvLCKpQrC6NzvR2EdWfDbaQg=;
        b=IbhxN9RuScOAyAqWTAGcp6te2tdNZsn9331UNPhZj0AwKFxJmjDXiDIoHkZcK7AXqu
         DZMX5yfFXA62ilkTTpoprBN92DWnVnnFdYTLKEyXaXwD1BZMIOBkTKxrr10et3a1eO2O
         RMumYSx/ZdVSicdP4ImN74VzqUVfdpNttaOVIx1wZGMJmgiD9dpXVNuwW8GxGGPyyF8X
         LpjWXXPXcwxmrniVqYo1GTQF2NGI5C8AG1RmNOdH8tINUwEO8oacT/vLvKSRoVDXX3tJ
         uuZxHrhBgZ/Z/BSsdkaCAPR4tA++1kO7zNSIL3XiQUCTPp8gc0GyPUL6/cJR7d5FqHNV
         X6fQ==
X-Gm-Message-State: AOJu0YxzpSgAK6jFbIwgpgAhKiAzIotEE/tjM2ySwtO+qyji/WSZ594f
	Vuko35zUL3drr7apWy0y54xemGX60OFqyLKzUOtnZUtQgUBch1W0X1LSTfJTGioEjqVrUajyEp0
	Cp4hCDBO/YBC50vT9AG5e3IrgChXe3MieuLW17SAkS+SKCUDGOJsfLdL0R5okYQ3vIZb3rSKXo1
	cvIoNofFfIft/WQEtj5/qpWQGnjt59f4tq+HKudH8RVTN39A==
X-Gm-Gg: ASbGncuYnvCdfZY8lkcfEozq/PWaQ+TeL1ithF9KQO35gKEjLVPmNMRKSR7xLDYgC6T
	/VYNSIkxsyoVzB1ddJrXbtwAo0huTZMWYtwMdpccmrsfGS+h49+yvmmTDA56oNmhq6FwfA8viD2
	Odtr+5cx5Pt2HXiod01sShzVAZtiV1VwLsYNLk0dlYp/n1N1vgCCzJtAXmAcNbcgUNwDiT0sXuG
	LgjThlMCEJxgEipWLl1bxn8tLH1bMUuNB44930oHDvJp+UN9IU4n9XtPVlSDRHAcjWNo5bG0QVd
	u0zj9GJQmAbUrJpmfPD8O1xzB9BvmPb1JVU39Uq1XYeCQdhFRbAbiO4+sy6chLi8t5zoOOBysUc
	/3CFaIdqiW+DL/A1xyy8k7pJ1EFcSmwOhpqC6NeLOXM5e8geqxZw1fEy+vF4o
X-Received: by 2002:a05:600c:4856:b0:46e:6a3f:6c6 with SMTP id 5b1f17b1804b1-475c3ea4513mr292485e9.6.1761058845827;
        Tue, 21 Oct 2025 08:00:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcCb5n53mP5PF5MfJ9HO5RP4uaN8pdS2o1XXt/OVHNFMEn6HOLQj1RdbKKLXflQ72jgla+hg==
X-Received: by 2002:a05:600c:4856:b0:46e:6a3f:6c6 with SMTP id 5b1f17b1804b1-475c3ea4513mr292005e9.6.1761058845283;
        Tue, 21 Oct 2025 08:00:45 -0700 (PDT)
Received: from localhost (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47152959b55sm204336915e9.6.2025.10.21.08.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 08:00:44 -0700 (PDT)
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
Subject: [PATCH v1 18/23] mm/vmscan: drop inclusion of balloon_compaction.h
Date: Tue, 21 Oct 2025 17:00:35 +0200
Message-ID: <20251021150040.498160-2-david@redhat.com>
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

Before commit b1123ea6d3b3 ("mm: balloon: use general non-lru movable page
feature"), the include was required because of isolated_balloon_page().

It's no longer required, so let's remove it.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/vmscan.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index c922bad2b8fd4..b96448b562823 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -63,7 +63,6 @@
 #include <asm/div64.h>
 
 #include <linux/swapops.h>
-#include <linux/balloon_compaction.h>
 #include <linux/sched/sysctl.h>
 
 #include "internal.h"
-- 
2.51.0


