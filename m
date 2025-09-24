Return-Path: <linux-kernel+bounces-830993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D16B9B178
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0CAE1B20A7F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D68C319866;
	Wed, 24 Sep 2025 17:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="poMllSFx"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EA63191DE
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758735655; cv=none; b=U44CmBPYM8o+nBoPuiVNEkb+nOnf2apcbsGS5gTCzdSW2Ek9ZhJpOVZNCirlvKL0lXxFlaIWcVl/w0yXs8bSsgH2X/bUGGDSxF5nGIOYhB1zPkDiAa6sNurtuVhzP5OueIaEPgPFVLvCl7Zz/lcZAoLZjmKikFzv1CoG805njx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758735655; c=relaxed/simple;
	bh=btwVs2lkH3+lO/q3eRs1iKgfY8wLUfRUKs+5/L3izBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H+/pqXOBDCSH/3zT/5/gA75AqLU/iwsIHznAGYmwFKe1VRW9Xea/3RBaMaYrV6h/GwxwO+LCogB7gNxUDvB2o4wY3UobzN7efdNmStnreHkV2qp1vH2SUAOu2TnK9wCcpzsVQU3nR2HoHLnGmkQgf4q+aM8qwoxZwKGrKwSuHNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=poMllSFx; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=WORvJmTYWvO70O+J4Bbi/mV+ttGZbGHrOxbkkudcayo=; b=poMllSFxyWwaxbRMnhIhvy/7gG
	Vv3kHUhfitXWX5+DCa587KuKpCGAEpvpIp0CidIGTkAPcc9ItXF0YLCIpn8/x4Bhv4m5aLfUdUFRv
	wcJT0kUPPM44BFEAVH18kJo3yMQMybzx0FpN7ETzRq5H/+p9V68me1CkULYvLi/zoUjsHfH9uVTUh
	Y/qu33VahXawv0QuQ6O4a5WSyOLCjckL/B0+MpF5u7oV1gFX8ZlgofNnDiGgzCZ1aj3HOp5+7XFhI
	KbZVf8SFjgdOSSkrN9mtcgSqCUD1DKlSotbEd6ohIRtHoWxq7gMy87EPIhxJ2SN+zqGlHsBTwCHUz
	Iyr2YFmg==;
Received: from [179.159.118.139] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1v1TTx-00Gz9Z-Dh; Wed, 24 Sep 2025 19:40:46 +0200
From: Mauricio Faria de Oliveira <mfo@igalia.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: Oscar Salvador <osalvador@suse.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com
Subject: [PATCH 3/3] mm/page_owner: update Documentation with 'print_handle' and 'print_stack'
Date: Wed, 24 Sep 2025 14:40:23 -0300
Message-ID: <20250924174023.261125-4-mfo@igalia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250924174023.261125-1-mfo@igalia.com>
References: <20250924174023.261125-1-mfo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe and provide examples for 'print_handle' and 'print_stack'.

Signed-off-by: Mauricio Faria de Oliveira <mfo@igalia.com>
---
 Documentation/mm/page_owner.rst | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/mm/page_owner.rst b/Documentation/mm/page_owner.rst
index 3a45a20fc05a..fac14ff2e4a5 100644
--- a/Documentation/mm/page_owner.rst
+++ b/Documentation/mm/page_owner.rst
@@ -27,7 +27,10 @@ enabled. Other usages are more than welcome.
 It can also be used to show all the stacks and their current number of
 allocated base pages, which gives us a quick overview of where the memory
 is going without the need to screen through all the pages and match the
-allocation and free operation.
+allocation and free operation. It's also possible to show only a numeric
+identifier of all the stacks (without stack traces) and their number of
+allocated base pages (faster to read and parse, eg, for monitoring) that
+can be matched with stacks later (options print_handle and print_stack).
 
 page owner is disabled by default. So, if you'd like to use it, you need
 to add "page_owner=on" to your boot cmdline. If the kernel is built
@@ -95,6 +98,7 @@ Usage
 	...
 	...
 	echo 7000 > /sys/kernel/debug/page_owner_stacks/count_threshold
+	echo 1 > /sys/kernel/debug/page_owner_stacks/print_handle
 	cat /sys/kernel/debug/page_owner_stacks/show_stacks> stacks_7000.txt
 	cat stacks_7000.txt
 	 post_alloc_hook+0x177/0x1a0
@@ -113,6 +117,15 @@ Usage
 	 __do_sys_finit_module+0x381/0x730
 	 do_syscall_64+0x8d/0x150
 	 entry_SYSCALL_64_after_hwframe+0x62/0x6a
+	handle: 42
+	nr_base_pages: 20824
+	...
+
+	echo 1 > /sys/kernel/debug/page_owner_stacks/print_handle
+	echo 0 > /sys/kernel/debug/page_owner_stacks/print_stack
+	cat /sys/kernel/debug/page_owner_stacks/show_stacks > handles_7000.txt
+	cat handles_7000.txt
+	handle: 42
 	nr_base_pages: 20824
 	...
 
-- 
2.48.1


