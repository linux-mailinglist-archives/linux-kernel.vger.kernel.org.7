Return-Path: <linux-kernel+bounces-828828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0304B95915
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D6424A4087
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE274321430;
	Tue, 23 Sep 2025 11:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="n08H3Hf5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m0x/vk62"
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B39321F32
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758625647; cv=none; b=dwjpiXIneeSYsXXzSyzQEEIJY/JuANItMIzTzi0q+IpFAUxvhrK9Kq7UwJsqX0ncKGEYdvCgpZZzBBX1eDEkwTBVG1RALJqYxcCAhlzYAD0u0eH+U9JEceXROEx/DNh+JquDgrDZPaeNctLcG3j1vuI0tziboxkuNS7LlN1wZSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758625647; c=relaxed/simple;
	bh=YdfniaI8JtjbmRmFL2P1+yzqvWlKFWQCM5NeBuYYjgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f/YKl7wYEKeX+EXqgvQdwRYhmUW4bJsE9tHTzKHGe5d34zXALEqHmaIKWPsscGP2IEv+8+eYLraxhG2iqxkVyEwMG+gw8CCHOm1T5DIiyxrmtLwNjsxXYXSZRG8I2z8Xok+7auQAG9IRBpr4TKox/Mb6axkHYSBb/CztbYq3CwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=n08H3Hf5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m0x/vk62; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 41FBE14000C0;
	Tue, 23 Sep 2025 07:07:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 23 Sep 2025 07:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1758625645; x=
	1758712045; bh=l+30FsNxlli8PpC3TpepLFbX1IePGlSZR2KUwpff5IU=; b=n
	08H3Hf5JxGLXF135U68VKyoIWFff/JQy9D0ZE/ZEhu7CPWR7n0aLuH0zQHbraFYC
	nbboBiz7yoPXe4ZJED9Qrjc//StA3KjySXkw1OWrz2QuL8h9T0PuEZc/m+yE8IN6
	r/t0Plzb56QewOKNfsXFPmTnl4uLXUjWEgXGb+BpP/Vqd2R9S5o/SiMV+wxf9h3F
	5lPGzkfd2CaSdaNdcYSdZeQIwt4iriXAcUv1Kaizd1iRb7TdUII5ZgI+/nBVTtm2
	VnO3iFTDylkOsbDcqkKaUcRV9qxqLkKssxM5ZtCfbOJ6TGT0RJ5NpvevUkWl9q3e
	qrduLtDqjogm48X6CMOig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758625645; x=1758712045; bh=l
	+30FsNxlli8PpC3TpepLFbX1IePGlSZR2KUwpff5IU=; b=m0x/vk62Pnle6U75M
	ta4YLB6sTiAwci7bsRD/ozX8OCX/XwOrDvUBr1ezdC/8F5HpUkaiw2JapAdbII6k
	8s83X+kI9Xa9nbeqUv4kxskTh+Am2cN6XiYe/O0h6UxIYfAcUHXlzaQcmGj3ci0n
	7ASQ76H4xEm3imy2E/o7KSCqbqOhSOEEoCmQyt81xak5G0sJ9GlIAI4EEmDkJ30R
	Xq12nB/Xw6SILiKbnrxlxabfOXtGx2ktJ5UCOJz99F77/SL7JDNtz/f3iT7YLfsC
	uBaj2tj4ohy3cPgdNAO+ULuSKGXE1yVyS2Iyt8QYNRLmdDiKsj/94pmv/SvYKevo
	J/sRA==
X-ME-Sender: <xms:bH_SaFz4dlYPdRaPtw4tPaQnqDTB6dgW5f9FkkxZLp6jrKm-QRukCw>
    <xme:bH_SaBMm37n59yFZRgGB3ERAOdjKRDtW5hSjWE225CYLSDQb1eSgJ1XZ7iGFabu4V
    _IocKR37Jy2LHOnN2fc61R0JicdoKhcLiJ3nVaqiTKuyVvv8TdqjrQ>
X-ME-Received: <xmr:bH_SaFfknfb8BTkXX0ceQYSgcYipC5LOsUsjZM6vfsziPptdkbAqJcF5fu4Mkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefmihhrhihlucfu
    hhhuthhsvghmrghuuceokhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvqeenucggtf
    frrghtthgvrhhnpeegveehtdfgvdfhudegffeuuddvgeevjefhveevgefhvdevieevteei
    vdehjefhjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgdpnhgspghrtghpthhtohepudek
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouh
    hnuggrthhiohhnrdhorhhgpdhrtghpthhtohepuggrvhhiugesrhgvughhrghtrdgtohhm
    pdhrtghpthhtohephhhughhhugesghhoohhglhgvrdgtohhmpdhrtghpthhtohepfihilh
    hlhiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlohhrvghniihordhsthho
    rghkvghssehorhgrtghlvgdrtghomhdprhgtphhtthhopehlihgrmhdrhhhofihlvghtth
    esohhrrggtlhgvrdgtohhmpdhrtghpthhtohepvhgsrggskhgrsehsuhhsvgdrtgiipdhr
    tghpthhtoheprhhpphhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhrvghnsg
    esghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:bH_SaN47OvHksZD_Kr7Pabf3FWsXGi2-DrF9g7034zctM2q6003W8Q>
    <xmx:bH_SaFKk_MieIapstRh_06R1tikVH2l-619-v1HG_pHJrPxGxNZ4Gw>
    <xmx:bH_SaJ4-9MPmlnAdk-c_mxqjRqV0eunF3KAxa7uiqVL4e6itHND_Dg>
    <xmx:bH_SaMa8h-cBPSf3J5R71SuOORCN6H-V0oeYxCJlFhf8oDVqAwxNDQ>
    <xmx:bX_SaI2RNAITEVL56sb0MWHotUOqzykoIwJCx43rop5hK6stwtjRuW-7>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 07:07:24 -0400 (EDT)
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kiryl Shutsemau <kas@kernel.org>
Subject: [PATCHv3 4/6] mm/fault: Try to map the entire file folio in finish_fault()
Date: Tue, 23 Sep 2025 12:07:09 +0100
Message-ID: <20250923110711.690639-5-kirill@shutemov.name>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250923110711.690639-1-kirill@shutemov.name>
References: <20250923110711.690639-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kiryl Shutsemau <kas@kernel.org>

The finish_fault() function uses per-page fault for file folios. This
only occurs for file folios smaller than PMD_SIZE.

The comment suggests that this approach prevents RSS inflation.
However, it only prevents RSS accounting. The folio is still mapped to
the process, and the fact that it is mapped by a single PTE does not
affect memory pressure. Additionally, the kernel's ability to map
large folios as PMD if they are large enough does not support this
argument.

When possible, map large folios in one shot. This reduces the number of
minor page faults and allows for TLB coalescing.

Mapping large folios at once will allow the rmap code to mlock it on
add, as it will recognize that it is fully mapped and mlocking is safe.

Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/memory.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 0ba4f6b71847..812a7d9f6531 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5386,13 +5386,8 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 
 	nr_pages = folio_nr_pages(folio);
 
-	/*
-	 * Using per-page fault to maintain the uffd semantics, and same
-	 * approach also applies to non shmem/tmpfs faults to avoid
-	 * inflating the RSS of the process.
-	 */
-	if (!vma_is_shmem(vma) || unlikely(userfaultfd_armed(vma)) ||
-	    unlikely(needs_fallback)) {
+	/* Using per-page fault to maintain the uffd semantics */
+	if (unlikely(userfaultfd_armed(vma)) || unlikely(needs_fallback)) {
 		nr_pages = 1;
 	} else if (nr_pages > 1) {
 		pgoff_t idx = folio_page_idx(folio, page);
-- 
2.50.1


