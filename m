Return-Path: <linux-kernel+bounces-830991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90769B9B172
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EFA538115A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A344731690A;
	Wed, 24 Sep 2025 17:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="YqWUDH+6"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B268315D4E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758735649; cv=none; b=Sw8bveh5+pxCRYp05b6J76cjnTfM7Y8h+fe5xOa/9wfp3gNVKzJ5USeKpXWugtvURzRNjiaDvCn2+sHeaed1T3oof7Keh6XMu6HkcBtuy6XRFLPF7hlm+OhL6oDmVICMI1DfgncBSDFk0iE1z9GZuFjsUOaXnBvJoJWnhBlxOKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758735649; c=relaxed/simple;
	bh=QTeQ1KfJXQm/k1vh1EdR9VmVaDh2FxG4Z9/deBbkcU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZvchNbbzqj15OFTm6J9mQEg4Ycy+znEHW0CB3CLEiILVY/kb2lFwUzrKhAluMX2OXo+RBZdF0pDloTkOjUkvZeAcqkIkEPEe+4DEUyUDkD6EPGmOT9XvueZ0Z8wPPIM2EaBT3ztxF3n8rAoHIbK20may38OL1pUUj5+hM4xH5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=YqWUDH+6; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=O1svfcZ9VH/76WFGoREwGAwZmvZ0N9/uv3HXzR8Dmmc=; b=YqWUDH+6ic5bSW/v28hNGILXwK
	LNSxd6pkvlKvAdF/hjq5qrL1xcQNrNB8YCgzf80190ncVKsnbGG2TIMwdkP+7fTmy0bwj4CSbbdk0
	+IXi3fa+fIZmDn+lpSVBNSkZ5XEuzlC78L7SJ1vmifc5L3DkLUrGzV4vV1qbzGKAa/UnASUT6CBW8
	OO8K+P8apJ2bbheogtSqWsuZ8ILgrP6jdVppsqUt6H4GRKwNJc1Qu246vCxOW7iPpHKNoIhc/z93W
	UZvueLH4wm+tcup/YfxhcgSW+hyF5kdIRw4Jz2vTbIZ+AmJpFLns2mmuQ9yTJ0G8jRhfMIRyqWgrr
	MqZSqU3Q==;
Received: from [179.159.118.139] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1v1TTn-00Gz9Z-CY; Wed, 24 Sep 2025 19:40:36 +0200
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
Subject: [PATCH 1/3] mm/page_owner: add option 'print_handle' for 'show_stacks'
Date: Wed, 24 Sep 2025 14:40:21 -0300
Message-ID: <20250924174023.261125-2-mfo@igalia.com>
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

For monitoring the memory usage per stack trace, it is more efficient to
use the handle number as unique identifier of a stack trace than to, for
example, read/hash all stack traces to uniquely identify them everytime.

The handle number is a unique identifier for stack traces in stackdepot.

This patch adds the option 'print_handle' to print the handle number of
stack traces in 'show_stacks'.

Testing:

  - Without handles (default):
  # cat /sys/kernel/debug/page_owner_stacks/show_stacks > f1

  - With handles (new option):
  # echo 1 >/sys/kernel/debug/page_owner_stacks/print_handle
  # cat /sys/kernel/debug/page_owner_stacks/show_stacks > f2

  - Same number of lines for 'nr_base_pages' and 'handle':
  # grep -c '^nr_base_pages:' f1
  873
  # grep -c '^handle:' f2
  873

Signed-off-by: Mauricio Faria de Oliveira <mfo@igalia.com>
---
 mm/page_owner.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index c3ca21132c2c..420426749239 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -887,6 +887,7 @@ static void *stack_next(struct seq_file *m, void *v, loff_t *ppos)
 }
 
 static unsigned long page_owner_pages_threshold;
+static bool page_owner_print_handle;
 
 static int stack_print(struct seq_file *m, void *v)
 {
@@ -908,6 +909,8 @@ static int stack_print(struct seq_file *m, void *v)
 
 	for (i = 0; i < nr_entries; i++)
 		seq_printf(m, " %pS\n", (void *)entries[i]);
+	if (page_owner_print_handle)
+		seq_printf(m, "handle: %d\n", stack_record->handle.handle);
 	seq_printf(m, "nr_base_pages: %d\n\n", nr_base_pages);
 
 	return 0;
@@ -968,6 +971,8 @@ static int __init pageowner_init(void)
 			    &page_owner_stack_operations);
 	debugfs_create_file("count_threshold", 0600, dir, NULL,
 			    &proc_page_owner_threshold);
+	debugfs_create_bool("print_handle", 0600, dir,
+			    &page_owner_print_handle);
 
 	return 0;
 }
-- 
2.48.1


