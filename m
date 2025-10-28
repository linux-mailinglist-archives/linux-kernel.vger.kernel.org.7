Return-Path: <linux-kernel+bounces-874427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2234C1654D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFAE73BA28D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9741B34D90D;
	Tue, 28 Oct 2025 17:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="nl+Mvvq8"
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0FB34CFDD;
	Tue, 28 Oct 2025 17:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673808; cv=none; b=rxdcI5vNEb/i86LSWVFGSMsv/09qfc/K9dD1uHxfa3TE+DD2m6sPy4oEJWjf1NMzuyCkGMQbQyfGRM3wAWolnHH9YiKNMBuVC8xUIGAWu2tTElBdo3WRthV7xCQpr56lhpGXCMjj2uXG7TXrsQvV6GabxXcshQ57ZJwd7kTg2No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673808; c=relaxed/simple;
	bh=Y3w8kELAvXzYGUbygh4nWKvLngrAuAnHIZ5+FeB7oYA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QmTCcUS0IwOoJ7+Bfr3xVq1ULK9TipqpLYRODQZmlExxkxto0li1VCbR7XpMWgvARfLxCTChOREfijsOWU+5/J488VyB9ebD+pFhIfR4BFJP8n9y3q0r9eBlIWYgAGmTNww6Z0ZwbPnb0uahlHkfu4M/F+GsPU/n+I48oO8Uh18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=nl+Mvvq8; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 117A39B03D;
	Tue, 28 Oct 2025 17:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1761673796;
	bh=7TAeOGTyPvQPOj1dnWWA9h27m0pwmAjfFVTIH6M/D2U=;
	h=Date:From:To:Cc:Subject;
	b=nl+Mvvq8qNDSjHEeETFy2KaoRXk8qfM044sEJxCrthmzG1VLoWely/8lApfQKP1gD
	 cEJbd4POjzCvrxMwfNilXK66F3634JASfYzXwG1VqJiq+4jRVveGjQZ5XTAwF16NuU
	 4dVNttwQJ70x4HmJ/myIKUg/f4rFvI/eaf63UAes=
Date: Tue, 28 Oct 2025 17:49:50 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>, Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Hugh Dickins <hughd@google.com>
Cc: Kiryl Shutsemau <kas@kernel.org>, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2] mm: shmem/tmpfs hugepage defaults config choice
Message-ID: <aQECPpjd-fU_TC79@shell.ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Allow to override defaults for shemem and tmpfs at config time. This is
consistent with how transparent hugepages can be configured.

Same results can be achieved with the existing
'transparent_hugepage_shmem' and 'transparent_hugepage_tmpfs' settings
in the kernel command line, but it is more convenient to define basic
settings at config time instead of changing kernel command line later.

Defaults for shmem and tmpfs were not changed. They are remained the
same as before: 'never' for both cases. Options 'deny' and 'force' are
omitted intentionally since these are special values and supposed to be
used for emergencies or testing and are not expected to be permanent
ones.

Primary motivation for adding config option is to enable policy
enforcement at build time. In large-scale production environments
(Meta's for example), the kernel configuration is often maintained
centrally close to the kernel code itself and owned by the kernel
engineers, while boot parameters are managed independently (e.g.  by
provisioning systems).  In such setups, the kernel build defines the
supported and expected behavior in a single place, but there is no
reliable or uniform control over the kernel command line options.

A build-time default allows kernel integrators to enforce a predictable
hugepage policy for shmem/tmpfs on a base layer, ensuring reproducible
behavior and avoiding configuration drift caused by possible boot-time
differences.

In short, primary benefit is mostly operational: it provides a way to
codify preferred policy in the kernel configuration, which is versioned,
reviewed, and tested as part of the kernel build process, rather than
depending on potentially variable boot parameters.

Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
Changes v2:
- Mentioned Kconfig options in Documentation/admin-guide/mm/transhuge.rst. 
  Didn't list all of them intentionally to avoid duplication and possible 
  content drift in the future.
- Expanded commit message with rationale behind the change. Mentioned Meta
  explicitly.

 Documentation/admin-guide/mm/transhuge.rst |  5 ++
 mm/Kconfig                                 | 91 ++++++++++++++++++++++
 mm/shmem.c                                 | 33 +++++++-
 3 files changed, 127 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 1654211cc6cf..5fbc3d89bb07 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -381,6 +381,11 @@ hugepage allocation policy for the tmpfs mount by using the kernel parameter
 four valid policies for tmpfs (``always``, ``within_size``, ``advise``,
 ``never``). The tmpfs mount default policy is ``never``.
 
+Additionally, Kconfig options are available to set the default hugepage
+policies for shmem (``CONFIG_TRANSPARENT_HUGEPAGE_SHMEM_HUGE_*``) and tmpfs
+(``CONFIG_TRANSPARENT_HUGEPAGE_TMPFS_HUGE_*``) at build time. Refer to the
+Kconfig help for more details.
+
 In the same manner as ``thp_anon`` controls each supported anonymous THP
 size, ``thp_shmem`` controls each supported shmem THP size. ``thp_shmem``
 has the same format as ``thp_anon``, but also supports the policy
diff --git a/mm/Kconfig b/mm/Kconfig
index e47321051d76..5ceea38edbe1 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -853,6 +853,97 @@ choice
 	  enabled at runtime via sysfs.
 endchoice
 
+choice
+	prompt "Shmem hugepage allocation defaults"
+	depends on TRANSPARENT_HUGEPAGE
+	default TRANSPARENT_HUGEPAGE_SHMEM_HUGE_NEVER
+	help
+	  Selects the hugepage allocation policy defaults for
+	  the internal shmem mount.
+
+	  The selection made here can be overridden by using the kernel
+	  command line 'transparent_hugepage_shmem=' option.
+
+	config TRANSPARENT_HUGEPAGE_SHMEM_HUGE_NEVER
+		bool "never"
+	help
+	  Disable hugepage allocation for shmem mount by default. It can
+	  still be enabled with the kernel command line
+	  'transparent_hugepage_shmem=' option or at runtime via sysfs
+	  knob. Note that madvise(MADV_COLLAPSE) can still cause
+	  transparent huge pages to be obtained even if this mode is
+	  specified.
+
+	config TRANSPARENT_HUGEPAGE_SHMEM_HUGE_ALWAYS
+		bool "always"
+	help
+	  Always attempt to allocate hugepage for shmem mount, can
+	  increase the memory footprint of applications without a
+	  guaranteed benefit but it will work automatically for all
+	  applications.
+
+	config TRANSPARENT_HUGEPAGE_SHMEM_HUGE_WITHIN_SIZE
+		bool "within_size"
+	help
+	  Enable hugepage allocation for shmem mount if the allocation
+	  will be fully within the i_size. This configuration also takes
+	  into account any madvise(MADV_HUGEPAGE) hints that may be
+	  provided by the applications.
+
+	config TRANSPARENT_HUGEPAGE_SHMEM_HUGE_ADVISE
+		bool "advise"
+	help
+	  Enable hugepage allocation for the shmem mount exclusively when
+	  applications supply the madvise(MADV_HUGEPAGE) hint.
+	  This ensures that hugepages are used only in response to explicit
+	  requests from applications.
+endchoice
+
+choice
+	prompt "Tmpfs hugepage allocation defaults"
+	depends on TRANSPARENT_HUGEPAGE
+	default TRANSPARENT_HUGEPAGE_TMPFS_HUGE_NEVER
+	help
+	  Selects the hugepage allocation policy defaults for
+	  the tmpfs mount.
+
+	  The selection made here can be overridden by using the kernel
+	  command line 'transparent_hugepage_tmpfs=' option.
+
+	config TRANSPARENT_HUGEPAGE_TMPFS_HUGE_NEVER
+		bool "never"
+	help
+	  Disable hugepage allocation for tmpfs mount by default. It can
+	  still be enabled with the kernel command line
+	  'transparent_hugepage_tmpfs=' option. Note that
+	  madvise(MADV_COLLAPSE) can still cause transparent huge pages
+	  to be obtained even if this mode is specified.
+
+	config TRANSPARENT_HUGEPAGE_TMPFS_HUGE_ALWAYS
+		bool "always"
+	help
+	  Always attempt to allocate hugepage for tmpfs mount, can
+	  increase the memory footprint of applications without a
+	  guaranteed benefit but it will work automatically for all
+	  applications.
+
+	config TRANSPARENT_HUGEPAGE_TMPFS_HUGE_WITHIN_SIZE
+		bool "within_size"
+	help
+	  Enable hugepage allocation for tmpfs mount if the allocation
+	  will be fully within the i_size. This configuration also takes
+	  into account any madvise(MADV_HUGEPAGE) hints that may be
+	  provided by the applications.
+
+	config TRANSPARENT_HUGEPAGE_TMPFS_HUGE_ADVISE
+		bool "advise"
+	help
+	  Enable hugepage allocation for the tmpfs mount exclusively when
+	  applications supply the madvise(MADV_HUGEPAGE) hint.
+	  This ensures that hugepages are used only in response to explicit
+	  requests from applications.
+endchoice
+
 config THP_SWAP
 	def_bool y
 	depends on TRANSPARENT_HUGEPAGE && ARCH_WANTS_THP_SWAP && SWAP && 64BIT
diff --git a/mm/shmem.c b/mm/shmem.c
index eb8161136a7f..a411d7fb6e5a 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -570,8 +570,37 @@ static int shmem_confirm_swap(struct address_space *mapping, pgoff_t index,
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 /* ifdef here to avoid bloating shmem.o when not necessary */
 
-static int shmem_huge __read_mostly = SHMEM_HUGE_NEVER;
-static int tmpfs_huge __read_mostly = SHMEM_HUGE_NEVER;
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE_SHMEM_HUGE_NEVER)
+#define SHMEM_HUGE_DEFAULT SHMEM_HUGE_NEVER
+#elif defined(CONFIG_TRANSPARENT_HUGEPAGE_SHMEM_HUGE_ALWAYS)
+#define SHMEM_HUGE_DEFAULT SHMEM_HUGE_ALWAYS
+#elif defined(CONFIG_TRANSPARENT_HUGEPAGE_SHMEM_HUGE_WITHIN_SIZE)
+#define SHMEM_HUGE_DEFAULT SHMEM_HUGE_WITHIN_SIZE
+#elif defined(CONFIG_TRANSPARENT_HUGEPAGE_SHMEM_HUGE_ADVISE)
+#define SHMEM_HUGE_DEFAULT SHMEM_HUGE_ADVISE
+#else
+#define SHMEM_HUGE_DEFAULT SHMEM_HUGE_NEVER
+#endif
+
+static int shmem_huge __read_mostly = SHMEM_HUGE_DEFAULT;
+
+#undef SHMEM_HUGE_DEFAULT
+
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE_TMPFS_HUGE_NEVER)
+#define TMPFS_HUGE_DEFAULT SHMEM_HUGE_NEVER
+#elif defined(CONFIG_TRANSPARENT_HUGEPAGE_TMPFS_HUGE_ALWAYS)
+#define TMPFS_HUGE_DEFAULT SHMEM_HUGE_ALWAYS
+#elif defined(CONFIG_TRANSPARENT_HUGEPAGE_TMPFS_HUGE_WITHIN_SIZE)
+#define TMPFS_HUGE_DEFAULT SHMEM_HUGE_WITHIN_SIZE
+#elif defined(CONFIG_TRANSPARENT_HUGEPAGE_TMPFS_HUGE_ADVISE)
+#define TMPFS_HUGE_DEFAULT SHMEM_HUGE_ADVISE
+#else
+#define TMPFS_HUGE_DEFAULT SHMEM_HUGE_NEVER
+#endif
+
+static int tmpfs_huge __read_mostly = TMPFS_HUGE_DEFAULT;
+
+#undef TMPFS_HUGE_DEFAULT
 
 static unsigned int shmem_get_orders_within_size(struct inode *inode,
 		unsigned long within_size_orders, pgoff_t index,
-- 
2.47.3


