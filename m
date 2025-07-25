Return-Path: <linux-kernel+bounces-745597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5C9B11C09
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49017AC373C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E56E2E764A;
	Fri, 25 Jul 2025 10:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="Rr5HcFe2";
	dkim=pass (2048-bit key) header.d=vates.tech header.i=teddy.astie@vates.tech header.b="ReCti/5g"
Received: from mail145-22.atl61.mandrillapp.com (mail145-22.atl61.mandrillapp.com [198.2.145.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2C72E7165
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.2.145.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753438339; cv=none; b=d06u27zzctJHZAjxVQcTf4e5kg4mQ+Q4+nqIz/45812aWRMzIviv9zisY9AivK5kah16+pXlEa+0RYnxoOIHode4iMeKzMNHO4lL+faEXXHYzK9ElDOJEE3IJx8W/+qu6tEnFg7OOpvbqrUIy8qVgDrHREMXIVhAxOjXLtqpDCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753438339; c=relaxed/simple;
	bh=ASiHYT0VxWKUUBkSsjdGiNkNMqlvOj06EtSjjePvEVw=;
	h=From:Subject:To:Cc:Message-Id:Date:MIME-Version:Content-Type; b=bITf6scI90cxfo27IPWa+E41zEvXQkSaqmitiRQSm8OJn/dzD2N9bIIpQFq0y3qbY031zSun1ivbVvLx0KHe6BdvGJT7ZLX0kJdA8DJrFpxqqPmHrw9eohyz8wxiiShyMGWYhECkNoafhaO9voayTa/Ykf/QJsPMdaE9wg6ImBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vates.tech; spf=pass smtp.mailfrom=bounce.vates.tech; dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b=Rr5HcFe2; dkim=pass (2048-bit key) header.d=vates.tech header.i=teddy.astie@vates.tech header.b=ReCti/5g; arc=none smtp.client-ip=198.2.145.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vates.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.vates.tech
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
	s=mte1; t=1753438336; x=1753708336;
	bh=Z1ZCnsGTR1Ea2435ekGtOF0CiJZ1KkP59g7PY4QteBc=;
	h=From:Subject:To:Cc:Message-Id:Feedback-ID:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:CC:Date:Subject:From;
	b=Rr5HcFe2vKEnitxYNmlIZlXXvzgs/e2vMS4RqFUJ+90yKFHOD/J4b3iXA1cv4zNft
	 eNy5im5onB9JARx8vyj+/yFztGtG4jqS5/S8QfpJi4OLhFJVQd6rbSzmjKt85N3iDQ
	 xziTiEHG4KAl1vmxo3qAuTfwTNWYnxsHxk+weGa7bd6A1DutWoDEMhZU83LtGqs0i6
	 giV9Fguk0n/zH1woSiWjoQS6ixBZehdzUj5jK3fH5jkDaa6gvU4GUR5IUhC/idP38/
	 prKhiOPmV1KUkk3RnAXosb/WsybsabnIeV6r236JenJxb3bkh06MLiTpIxOsLklKZ9
	 +aeyTWB30XB6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
	t=1753438336; x=1753698836; i=teddy.astie@vates.tech;
	bh=Z1ZCnsGTR1Ea2435ekGtOF0CiJZ1KkP59g7PY4QteBc=;
	h=From:Subject:To:Cc:Message-Id:Feedback-ID:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:CC:Date:Subject:From;
	b=ReCti/5gC7dMmVIazTZPGMfSSWAl13hOqkfHIRGIMCo03kNr95wvGNXwZRHhHcczs
	 U+s+BntdZQHyeafJdB9xJds8kTzqq3Q0cMfn42ur3swIF/d2Ti305VNR946uFYwTdE
	 ADO0y/8tcqNCrELFFjU6ESZEMMk9SF6gmXyjhj4XJIu0jlMwblahT7fIWGscq4gDxz
	 cgZXQ/NOnxstsXMrSPMIg+kGIclb4atSihMpzFSadugdi5DxJyXCHrz/GxKvGJFtba
	 y37DsfT1FmyljwaKYkc6CERqhO6upawl5U7zatzq8QIerPkvHMfixbHSCFXuA69Vgm
	 lRolVfKhoGTVA==
Received: from pmta06.mandrill.prod.atl01.rsglab.com (localhost [127.0.0.1])
	by mail145-22.atl61.mandrillapp.com (Mailchimp) with ESMTP id 4bpNw00MwczFCWhBR
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:12:16 +0000 (GMT)
From: "Teddy Astie" <teddy.astie@vates.tech>
Subject: =?utf-8?Q?[PATCH]=20xen:=20Rename=20xenmem=5Freservation=5Fincrease=20to=20xenmem=5Fpopulate=5Fphysmap?=
Received: from [37.26.189.201] by mandrillapp.com id 4b8a8e3d3184408ebf8c7fb8c161f52f; Fri, 25 Jul 2025 10:12:16 +0000
X-Mailer: git-send-email 2.50.1
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1753438334492
To: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc: "Teddy Astie" <teddy.astie@vates.tech>, "Juergen Gross" <jgross@suse.com>, "Stefano Stabellini" <sstabellini@kernel.org>, "Oleksandr Tyshchenko" <oleksandr_tyshchenko@epam.com>
Message-Id: <d3bdb968d720db655314fd7d7c7c4bc181395cee.1753438001.git.teddy.astie@vates.tech>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,=20including=20all=20headers,=20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.4b8a8e3d3184408ebf8c7fb8c161f52f?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20250725:md
Date: Fri, 25 Jul 2025 10:12:16 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

xenmem_reservation_increase currently calls XENMEM_populate_physmap.
Rename the function to avoid confusion with XENMEM_increase_reservation.

Signed-off-by: Teddy Astie <teddy.astie@vates.tech>
---
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
---
 drivers/xen/balloon.c         | 2 +-
 drivers/xen/grant-table.c     | 2 +-
 drivers/xen/mem-reservation.c | 4 ++--
 include/xen/mem-reservation.h | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index 2de37dcd7556..ac52dfd03be4 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -407,7 +407,7 @@ static enum bp_state increase_reservation(unsigned long nr_pages)
 		page = balloon_next_page(page);
 	}
 
-	rc = xenmem_reservation_increase(nr_pages, frame_list);
+	rc = xenmem_populate_physmap(nr_pages, frame_list);
 	if (rc <= 0)
 		return BP_EAGAIN;
 
diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
index 04a6b470b15d..e1a5041b4b8a 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -1125,7 +1125,7 @@ int gnttab_dma_free_pages(struct gnttab_dma_alloc_args *args)
 	for (i = 0; i < args->nr_pages; i++)
 		args->frames[i] = page_to_xen_pfn(args->pages[i]);
 
-	ret = xenmem_reservation_increase(args->nr_pages, args->frames);
+	ret = xenmem_populate_physmap(args->nr_pages, args->frames);
 	if (ret != args->nr_pages) {
 		pr_debug("Failed to increase reservation for DMA buffer\n");
 		ret = -EFAULT;
diff --git a/drivers/xen/mem-reservation.c b/drivers/xen/mem-reservation.c
index 24648836e0d4..332eab71e977 100644
--- a/drivers/xen/mem-reservation.c
+++ b/drivers/xen/mem-reservation.c
@@ -83,7 +83,7 @@ EXPORT_SYMBOL_GPL(__xenmem_reservation_va_mapping_reset);
 #endif /* CONFIG_XEN_HAVE_PVMMU */
 
 /* @frames is an array of PFNs */
-int xenmem_reservation_increase(int count, xen_pfn_t *frames)
+int xenmem_populate_physmap(int count, xen_pfn_t *frames)
 {
 	struct xen_memory_reservation reservation = {
 		.address_bits = 0,
@@ -96,7 +96,7 @@ int xenmem_reservation_increase(int count, xen_pfn_t *frames)
 	reservation.nr_extents = count;
 	return HYPERVISOR_memory_op(XENMEM_populate_physmap, &reservation);
 }
-EXPORT_SYMBOL_GPL(xenmem_reservation_increase);
+EXPORT_SYMBOL_GPL(xenmem_populate_physmap);
 
 /* @frames is an array of GFNs */
 int xenmem_reservation_decrease(int count, xen_pfn_t *frames)
diff --git a/include/xen/mem-reservation.h b/include/xen/mem-reservation.h
index a2ab516fcd2c..e2b78a517cd1 100644
--- a/include/xen/mem-reservation.h
+++ b/include/xen/mem-reservation.h
@@ -53,7 +53,7 @@ static inline void xenmem_reservation_va_mapping_reset(unsigned long count,
 #endif
 }
 
-int xenmem_reservation_increase(int count, xen_pfn_t *frames);
+int xenmem_populate_physmap(int count, xen_pfn_t *frames);
 
 int xenmem_reservation_decrease(int count, xen_pfn_t *frames);
 
-- 
2.50.1



Teddy Astie | Vates XCP-ng Developer

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech


