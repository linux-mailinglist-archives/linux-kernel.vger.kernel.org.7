Return-Path: <linux-kernel+bounces-859102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DB4BECC8D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 11:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 331FA6249D2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 09:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94772EB862;
	Sat, 18 Oct 2025 09:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIUpQKZ+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E918A287258
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 09:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760779815; cv=none; b=E0qRFMCtBLNOhlgfH5VgQO/NDU6i72ILVLrCPtJq8F0uRhutn4TW72crFoU21TyJTK/vGS481gSz6hPID3GcqKCxTmsayLqsEncLyk5pqzu7XgP6UbI6m4XSBFjHY2TlmeZ8sEctrV/w/aevG7GIB782SrP17dX2XOvPJ7F2As0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760779815; c=relaxed/simple;
	bh=J3OM+/ebcqzP+G29UcHV2tXMIh+anZiIJ2e8hqXFf+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lNipdn+PLsr32iQCFORav+8Mq2OG2NvN0iGSES5Q/+p1cHyAl7zKuXp+vSzc3qt/Ea5BH9nymU5dlXz1NEm8P/XHjLbROVOIhIzBGYLkmRLFM6IiiaPBOYROFkuT0+9CUOLisiCqwwF3asVSqChBIGcFgiIF/Kq9eenHu1NcmTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIUpQKZ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC55C113D0;
	Sat, 18 Oct 2025 09:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760779814;
	bh=J3OM+/ebcqzP+G29UcHV2tXMIh+anZiIJ2e8hqXFf+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fIUpQKZ+gVg+pxmJGHGMNRmdb8PTrjQiMT7LfgM+OkY8IqJ5s57YwkFZfWomtaIAy
	 8Xw1h2oO33T+3ULNBPey1q0d60cjIptT6Tw9P4U+Ng70r3sBLr1XRk6bOwNUuhobva
	 JVGvyPBm+iSHqxC/OELlFAg6CPVsbXiFI8vsPVTTHJGjA+kwu3rf1mB7LH/1aSVF6z
	 RRYnGnIbPuhxyhOIg7KQjnNDZC23PLBt8UA6dBMU20T0+35sD9CuOgGhjiVIHQy05k
	 SNhNj7fyFQjnqPgSYsBdhNEPp7eydEWk2AfhxT7dt/WIWMWWWuUvbXs2NFvxZJ83Gw
	 LP1JKJ/dcpang==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Brendan Jackman <jackmanb@google.com>,
	David Hildenbrand <david@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/3] mm, vc_screen: move __free() handler that frees a page to a common header
Date: Sat, 18 Oct 2025 12:30:00 +0300
Message-ID: <20251018093002.3660549-2-rppt@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251018093002.3660549-1-rppt@kernel.org>
References: <20251018093002.3660549-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

vc_screen defines __free() handler that frees a page using free_page().
Move that definition to include/linux/gfp.h next to free_page() and
rename it from free_page_ptr to free_page.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/tty/vt/vc_screen.c | 6 ++----
 include/linux/gfp.h        | 2 ++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index c814644ef4ee..d2029f029de6 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -53,8 +53,6 @@
 #define HEADER_SIZE	4u
 #define CON_BUF_SIZE (IS_ENABLED(CONFIG_BASE_SMALL) ? 256 : PAGE_SIZE)
 
-DEFINE_FREE(free_page_ptr, void *, if (_T) free_page((unsigned long)_T));
-
 /*
  * Our minor space:
  *
@@ -371,7 +369,7 @@ vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 	loff_t pos;
 	bool viewed, attr, uni_mode;
 
-	char *con_buf __free(free_page_ptr) = (char *)__get_free_page(GFP_KERNEL);
+	char *con_buf __free(free_page) = (char *)__get_free_page(GFP_KERNEL);
 	if (!con_buf)
 		return -ENOMEM;
 
@@ -596,7 +594,7 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 	if (use_unicode(inode))
 		return -EOPNOTSUPP;
 
-	char *con_buf __free(free_page_ptr) = (char *)__get_free_page(GFP_KERNEL);
+	char *con_buf __free(free_page) = (char *)__get_free_page(GFP_KERNEL);
 	if (!con_buf)
 		return -ENOMEM;
 
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index f46b066c7661..ee3f27046667 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -385,6 +385,8 @@ extern void free_pages(unsigned long addr, unsigned int order);
 #define __free_page(page) __free_pages((page), 0)
 #define free_page(addr) free_pages((addr), 0)
 
+DEFINE_FREE(free_page, unsigned long, if (!IS_ERR_OR_NULL(_T)) free_page(_T));
+
 void page_alloc_init_cpuhp(void);
 bool decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp);
 void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp);
-- 
2.50.1


