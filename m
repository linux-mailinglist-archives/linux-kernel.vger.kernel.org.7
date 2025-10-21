Return-Path: <linux-kernel+bounces-862951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 55508BF6A09
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0538B502877
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AD8338929;
	Tue, 21 Oct 2025 13:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZeqP5W2Y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB14337BB9
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051600; cv=none; b=TEWDmAmB3lBUB5qVvbYY5iO3+4dRBvbKGAnZgM+odrLFQwEhBteRuDnvawSLrl8271jRPgp+p3BFKHmdMC3z9S1PbamEr1KEP94RrnWCDQ2I74V0W7rJNk5hthqmLIbiBDdd5UdVPC27sC4gtdLd5fzlaonPHJsuHCJujv6pVns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051600; c=relaxed/simple;
	bh=RVpO0/1Rr2WqDw7IdAgDtrk1Tta4kn04Oz5nTYeayzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJElTzX70pUZKAA/w+nNEAq0xAeivLEU3FyWvMwnSJCWcyInJ2bbUBaWBJhHedydoUH++4+J4s89HRfAynCkWYGtaZ18f2llTmh+ng1GWLkvUl3LGmEP12233n0ir5bstGqTdi3yHGqOvVR0Dts8cXoHLgFA5LEB0DG6hjLYXdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZeqP5W2Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761051597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a58UIIapVgV9zdPpt63SgupeCmEgQ8fjnLkqSW0/g7g=;
	b=ZeqP5W2Ybe1TzfDt/dZ+rbzug9YXzMDndJCEgtExNQ3acemanQFMWZvupPKoPeuIl4DO/K
	p/DMpE5ieknROaWPPgXWrW0kElvPkJyNKjMXiSa54bP6IkfZaNPckhtuDPwqv4IE/DJEvn
	H8h4FrdRKO/T5+bnF+l2USfoctKYo4I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-KgEjdSgxNEGmLrNwm4qF9w-1; Tue, 21 Oct 2025 08:59:56 -0400
X-MC-Unique: KgEjdSgxNEGmLrNwm4qF9w-1
X-Mimecast-MFC-AGG-ID: KgEjdSgxNEGmLrNwm4qF9w_1761051595
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4283bf540ceso2237499f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 05:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761051595; x=1761656395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a58UIIapVgV9zdPpt63SgupeCmEgQ8fjnLkqSW0/g7g=;
        b=qV0dZTOTz25NNynW07A8AbmtP5tDgpfFsaOiKUmMOYq9vum/UdytoWMVK4dNG7mLsh
         Jw5X9MUyU3944yt7+z6DFh5KZaBdmYVwY6CS2Sxh0S/Bvz9vq1K7RYHny+viEadp22I1
         gjXYVFPR1ORMgK6ZKS8507clPvXVjmqKIpA7waKaVP76JGtoPnhlRaF2IFZWwCsm469C
         yIe84Upbc7nt6oSgFYSa4s7btSPKxC4N4DaAOXLqzT0J/di2P/s5gbw2G3RIloTiXEgL
         KgIV6W2EoqxGfpOcQVFsE//6GXymNbOICpi4/ItGFRKVXpE8/p6jX+l9/W+zOEBDhWjo
         087g==
X-Gm-Message-State: AOJu0YyzDFQcARwRo8X7gbUWLul9mf35GCwQ/amY4vZRO5ZS8si9pJn5
	kFqcDZIUbTsV5niJIVWFo4ZqyV8YAntpjM4OGCeCq+91EjqGfstoLBZrJwIGzofOZe5ABMWPqqQ
	RS0Rqsv3YuJ9aT4I0QjHYZxytohUmuGspnXTb9hgtl5RgCXQtdw7O5to0/dA7xqMJRPo+EsXjjm
	gy3y4I8Ms+ZA0GUgh+YgoNRzGZQiKNn0RDO87ICkeE+fDnDA==
X-Gm-Gg: ASbGnct8kaZ85DxlP5mKeWKyWUoiPDaoC0JmL/A/1ygvbH+6kslpRC6ljOAFE1O72Ck
	6G2S/2GE24468LTWC2xCVjOrC7vvJJCkttfJerc3hpBCj3dFgtG07DNBAnrMX7y8mx8MAIpH0QY
	a96xi9Qn72UfAJo7vwXfyMKkhTp2qbd2SmsCTbBDypqeW0CSM/KVwvhEmxLekoKjqqkO0S9Xf2m
	9UynU63IIKkK7HN+WF665tRNxWe+tI2apyHIaVFGcsbFzAkgZLqkJu8lRI0ItBz8vNbmC8vQZND
	p4QeWIJlwGfUj9uwlUJ2hScpLfIAYCiNhi+2f1YKeq2V/ZrMchyMxuG0H5L7pKU00UOvjMJnCGI
	QOiK2eSvW69erXlvDMSOCuMqm1jVJEHsfJ8IyIZ9kYEhqbNUWLLD7cVTpHTRw
X-Received: by 2002:a5d:5f48:0:b0:427:2e8:fe5e with SMTP id ffacd0b85a97d-42704d83898mr11742035f8f.13.1761051594966;
        Tue, 21 Oct 2025 05:59:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOL78NSzfD/K3cQTXDnH1hifM9lFea/fB9GzfGevY7RVlJ9OG6SsU/tMvE3AQ+AuHnf7dxjA==
X-Received: by 2002:a5d:5f48:0:b0:427:2e8:fe5e with SMTP id ffacd0b85a97d-42704d83898mr11741985f8f.13.1761051594394;
        Tue, 21 Oct 2025 05:59:54 -0700 (PDT)
Received: from localhost (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427f00ce56csm20023457f8f.50.2025.10.21.05.59.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 05:59:53 -0700 (PDT)
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
Subject: [PATCH v1 10/23] mm/balloon_compaction: drop fs.h include from balloon_compaction.h
Date: Tue, 21 Oct 2025 14:59:15 +0200
Message-ID: <20251021125929.377194-11-david@redhat.com>
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

Ever since commit 68f2736a8583 ("mm: Convert all PageMovable users to
movable_operations") we no longer store an inode in balloon_dev_info,
so we can stop including "fs.h".

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/balloon_compaction.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index 7db66c2c86cdc..1452ea0635245 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -42,7 +42,6 @@
 #include <linux/migrate.h>
 #include <linux/gfp.h>
 #include <linux/err.h>
-#include <linux/fs.h>
 #include <linux/list.h>
 
 /*
-- 
2.51.0


