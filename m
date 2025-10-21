Return-Path: <linux-kernel+bounces-862945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A38BF6994
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69C38485491
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B525D336EC5;
	Tue, 21 Oct 2025 12:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JcH6OVLf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ED4334C26
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051584; cv=none; b=fSAIgkCAZmwdoebjX6vJwy0Yqvl/FhHcldjitarIu0pNh3fEHZHXQPVo8toV8YC7wk3DJIaDtfnETVZ4lBUOCBoBzBqKsqtC+AyYP/3o9041ojz8OTCirM9IuoLZxdEK8YojvvRQD0lbGQqhCRYYSUQsByROMuWq/5SCDY+XwWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051584; c=relaxed/simple;
	bh=ZX1IzZQQgreBcTlZHB/kVI28Gz8nSRy+pF223nJsGSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+FD6GIHWlrkTb/U7rczc5W1Tq/WudUm0joXW5DLRc98y8q26jLpPyXbfWx2QR3++HIFPgldgtX2P0RxTLl7MlOEBmtHcWLnRT2d324otuF3+dr212jmgpf+t7XWSHyeX0LZUbrKogFup1F1KnVAfp+0sd6qFQEhHq+G05L1ouc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JcH6OVLf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761051581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cInpBRrRn5ydv+Sa63F4MdgmnDVvTCru+7wR3lsxUS4=;
	b=JcH6OVLft+9j/hEazCH2GPV6OVITuPKaLYaEd3dDMvzPFLzfeSOvOH1JQUYHWC//PqwSwY
	EYnoWDj0CAMk+Z4u3w0GBFfefWrn5E2mWTCUU8FjtwmkJlPFFjcFa+ruLWB5URNznCH5zy
	jbcNUSNDbu7ehog5fWrI/3fnBvLEcOI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-APHFe9a6OyCYBzkiT--BQw-1; Tue, 21 Oct 2025 08:59:40 -0400
X-MC-Unique: APHFe9a6OyCYBzkiT--BQw-1
X-Mimecast-MFC-AGG-ID: APHFe9a6OyCYBzkiT--BQw_1761051579
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-471144baa7eso23776575e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 05:59:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761051579; x=1761656379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cInpBRrRn5ydv+Sa63F4MdgmnDVvTCru+7wR3lsxUS4=;
        b=FvqgQ74q2onnQQknr/6fNZZBjQIuaai7pe5Gr8YBYMAL9yXhgmf9R48dw9dyNxf9b6
         0V8YubKCylccDL/RTi73j+Nsds/8BmacWUtJFiyxxN+j9jOvyyFFIhoVJ0hw4hhhMFci
         kDaVS2Ee9tqAMjyDu5vktWwPSizGGEp5jy5QSsILju8IXKPo9U0PkyaOmxeVkK9WId/+
         QHKROX6gWUa7Sg6X40qVI3+ZiED31KRy7S3b028xJXaiMFJdr0BUl+w7L2nHXBofWzAy
         5sZ2/YA33VNzXeB8m+eQfuMd9UUcCo/EcfurNhp0KB3WMgB10J3b31mj5bpPVprBIfqI
         VMFQ==
X-Gm-Message-State: AOJu0Yx6jXENFPTg+y6sRGCR7pPmkdBvw7kc246zuiuQaa7zAwouPaav
	3kamcPDcOncQ3ug6ajUu577QgmEu9ASETITCWW6uMcvrYRRmlEJMX9JkZdC0jr1j0fKXIin1AcH
	fR7UKvIKzhan0cXs56FbnR8mp4eXDWThmoaiUbX1FZYjancDCGd4SBDEheKewGXYA53rRtpJTUY
	8BE9nH1BhclgDOYL5otwBUzaswwVNrkMwpppbSJKXa8I2kkA==
X-Gm-Gg: ASbGncshWEJKWrZEDfLNRfmw67KLtNykEDfQnBg+QDn7cjoorXUjN+DirLi+Q4qx/tC
	tuQ6O7/OjdkJJmH46xuNqtaR/yvVPS3Ro3TBOrrkPhMdA08e2EhHypBrRrjfqX9DsJYgdrLAoj1
	MwLzsJYeOtY8QvloBPTk+vwczJwcDA4Z6odZ9TPlz+S9723h50yTghwqzGnggVkba4euM55szin
	Z1mo83pK2pTXurQjd3fsMyx7MbGIY7/sTVA9LCb/vj9bb5nLJKu9eLRC9818/Sf2vRJrz8pV0DA
	aQQc8FZrhrjUDCskM96tm/3NRq6V4SxhPChCssOwCugUdSBDPDHEyIwtwbxXh41pHytSGtnzDx4
	f4bdAe3eP2JWmWAmdYMNwZeGOMosTRMDRp5FEo9pqdeY23dcMIYExGh5J3TSt
X-Received: by 2002:a05:600c:811b:b0:471:13fa:1b84 with SMTP id 5b1f17b1804b1-4711787c803mr122622705e9.12.1761051579077;
        Tue, 21 Oct 2025 05:59:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+zjcAWFH7UfZS6G5yWsBJ4PGUBhvAl9sC1ULzHpIWHcC8Aeot/GO9fktrhO0M9VdZy+aJsA==
X-Received: by 2002:a05:600c:811b:b0:471:13fa:1b84 with SMTP id 5b1f17b1804b1-4711787c803mr122622255e9.12.1761051578618;
        Tue, 21 Oct 2025 05:59:38 -0700 (PDT)
Received: from localhost (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427f009a781sm20658322f8f.30.2025.10.21.05.59.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 05:59:38 -0700 (PDT)
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
Subject: [PATCH v1 03/23] powerpc/pseries/cmm: remove cmm_balloon_compaction_init()
Date: Tue, 21 Oct 2025 14:59:08 +0200
Message-ID: <20251021125929.377194-4-david@redhat.com>
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

Now that there is not a lot of logic left, let's just inline setting up
the migration function.

To avoid #ifdef in the caller we can instead use IS_ENABLED() and make
the compiler happy by only providing the function declaration.

Now that the function is gone, drop the "out_balloon_compaction" label.
Note that before commit 68f2736a8583 ("mm: Convert all PageMovable users
to movable_operations"), now not anymore.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/powerpc/platforms/pseries/cmm.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
index 310dab4bc8679..67c7309c36147 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -548,15 +548,9 @@ static int cmm_migratepage(struct balloon_dev_info *b_dev_info,
 
 	return 0;
 }
-
-static void cmm_balloon_compaction_init(void)
-{
-	b_dev_info.migratepage = cmm_migratepage;
-}
 #else /* CONFIG_BALLOON_COMPACTION */
-static void cmm_balloon_compaction_init(void)
-{
-}
+int cmm_migratepage(struct balloon_dev_info *b_dev_info, struct page *newpage,
+		    struct page *page, enum migrate_mode mode);
 #endif /* CONFIG_BALLOON_COMPACTION */
 
 /**
@@ -573,11 +567,12 @@ static int cmm_init(void)
 		return -EOPNOTSUPP;
 
 	balloon_devinfo_init(&b_dev_info);
-	cmm_balloon_compaction_init();
+	if (IS_ENABLED(CONFIG_BALLOON_COMPACTION))
+		b_dev_info.migratepage = cmm_migratepage;
 
 	rc = register_oom_notifier(&cmm_oom_nb);
 	if (rc < 0)
-		goto out_balloon_compaction;
+		return rc;
 
 	if ((rc = register_reboot_notifier(&cmm_reboot_nb)))
 		goto out_oom_notifier;
@@ -606,7 +601,6 @@ static int cmm_init(void)
 	unregister_reboot_notifier(&cmm_reboot_nb);
 out_oom_notifier:
 	unregister_oom_notifier(&cmm_oom_nb);
-out_balloon_compaction:
 	return rc;
 }
 
-- 
2.51.0


