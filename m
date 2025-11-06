Return-Path: <linux-kernel+bounces-889422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21944C3D820
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 22:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B83E5188C08F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 21:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF61260580;
	Thu,  6 Nov 2025 21:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XKJZAVtM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B56C208AD
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 21:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762464630; cv=none; b=SFeCECAHWH+4jJF8B9i2lm1RZUD/vCWN5t4L6+1ErY8g/t8x17/8qaAUlqGg3VyLRrI5qrfiYFY2msgPeoIwfC8f9/ZMWRUB8OOLTAeGaxFyNhVMiOHu+N7nqKvib33ezr5X+ZR/od0aswgaWCg2WgIX2zHTZliBYrqFTwlbVxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762464630; c=relaxed/simple;
	bh=gXQSaqW18NTCntpvD1CjnWExHP0fGByO6brNawhT13o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kx6Wm8zeFwC7rztCK0PmZ3gxHi6oDkCcHLA9FuLXcDgV4YEIGr8BrRvguhwMhmgV8Tb8MJffmvzAUCYdimGrPtDalpkINJo8ojnRi0PYwWA+wsV5DS1keHyBV0fSp4b5D3srByiB2bI2BpMwBqmnYBtTTMnmVrByQ30Mo0L5R8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XKJZAVtM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762464627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6aaU6mqv/vvlvKAVhD0kXqB0iQKKcZ1RnoZvi1Wj0RE=;
	b=XKJZAVtM8WL3sIzP0FJ0N6Pv2QqY8R3uADlL5/vGJ6mPZ3+9NVxJA9EJfk7cHk3rhxE2Pe
	H0yhveCWUIR0jOYd9rUMZChUi8RDdqqDPKiZcGzm1O0KMEYzIwWNPYcsM/eDuLMJKod+s8
	2h+kk+8LzdUP+Ezz098ySqQ5HS7TQqo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-444-V2B0wT2pOM-hyOkBya2dGQ-1; Thu,
 06 Nov 2025 16:29:23 -0500
X-MC-Unique: V2B0wT2pOM-hyOkBya2dGQ-1
X-Mimecast-MFC-AGG-ID: V2B0wT2pOM-hyOkBya2dGQ_1762464562
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E8EDF1800371;
	Thu,  6 Nov 2025 21:29:21 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.65.101])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CD14D19560A7;
	Thu,  6 Nov 2025 21:29:20 +0000 (UTC)
From: Luiz Capitulino <luizcap@redhat.com>
To: david@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: ryan.roberts@arm.com,
	akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com
Subject: [RFC 05/10] drivers: nvdimm: use pgtable_has_pmd_leaves()
Date: Thu,  6 Nov 2025 16:28:52 -0500
Message-ID: <ebf1b2e8e16e7bca4e2ae9b1f995f314a4697a34.1762464515.git.luizcap@redhat.com>
In-Reply-To: <cover.1762464515.git.luizcap@redhat.com>
References: <cover.1762464515.git.luizcap@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

nd_pfn_supported_alignments() and nd_pfn_supported_alignments() use
has_transparent_hugepage() to check if PMD-sized pages are supported,
use pgtable_has_pmd_leaves() instead.

Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
---
 drivers/nvdimm/pfn_devs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
index 42b172fc5576..989f87f07e0c 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -94,7 +94,7 @@ static unsigned long *nd_pfn_supported_alignments(unsigned long *alignments)
 
 	alignments[0] = PAGE_SIZE;
 
-	if (has_transparent_hugepage()) {
+	if (pgtable_has_pmd_leaves()) {
 		alignments[1] = HPAGE_PMD_SIZE;
 		if (has_transparent_pud_hugepage())
 			alignments[2] = HPAGE_PUD_SIZE;
@@ -109,7 +109,7 @@ static unsigned long *nd_pfn_supported_alignments(unsigned long *alignments)
 static unsigned long nd_pfn_default_alignment(void)
 {
 
-	if (has_transparent_hugepage())
+	if (pgtable_has_pmd_leaves())
 		return HPAGE_PMD_SIZE;
 	return PAGE_SIZE;
 }
-- 
2.51.1


