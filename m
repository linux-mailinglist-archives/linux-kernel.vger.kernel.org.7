Return-Path: <linux-kernel+bounces-819490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C77B5A190
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C34E1B284EB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 19:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA892C11E3;
	Tue, 16 Sep 2025 19:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WuRAgW41"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D00D32D5C1
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 19:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758051540; cv=none; b=GIIsusSmpAzmHuIVd6gK6HFEPAxjHOXATgjUYEoo++AxneHfr4PzoJlXjZZ3IHVOHfDtPEOrzqLUnbZeHbIpi6Frtjt97ONdBj2ek4Ubf2itg5kOZaDaXEZQPtEwMHLVJhulQfVm42xL7HBL1gfk70ZzpqkL2P9JJNm2K2PK9KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758051540; c=relaxed/simple;
	bh=Q4kVru8i8IIfSOoE84wSITyzfCl6oFTOK7yBiPxJkJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P33uKOjjD8Y7OJ/Pg9O5i4W8JU2FpZHqFVxMcRMYA3PtmvEOLJ6XGr2764ovD4kXA6+aIG68GzgXa2bo7QboGouzXRNyyrX+bO41/DP+A3IGftgC7JXUeg1fIA62DcuJAVMW3FUTlpO+FjvW+TYcG2D5dj/fmFMDl3M2w0Fwtfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WuRAgW41; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758051537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+7hKGgfCrcGGIhnxPu7A9Ry/ZimHce+9evBu/ut+yg4=;
	b=WuRAgW41Fb1aFdtD8Z4gVYISBDnfhiQpzQQ10ODkAjXJjY/oQK4xBcAsC9Gd67fy7D+t5l
	sU9HXeXJALyx50Z3KtIHR6JQ3DRIiL4+pVP99VZ+IRfnC7i4+R87BOvHvvi22hBH4vsD1q
	i//5kPF2SBTJatyPN5dxE2xiCvEoq2E=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-P4f2Hq3UPwCRNeYxT_NYNg-1; Tue,
 16 Sep 2025 15:38:55 -0400
X-MC-Unique: P4f2Hq3UPwCRNeYxT_NYNg-1
X-Mimecast-MFC-AGG-ID: P4f2Hq3UPwCRNeYxT_NYNg_1758051534
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D3A1A19560AF;
	Tue, 16 Sep 2025 19:38:54 +0000 (UTC)
Received: from lszubowi.mht.redhat.com (unknown [10.17.16.237])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1B40C30001A4;
	Tue, 16 Sep 2025 19:38:53 +0000 (UTC)
From: Lenny Szubowicz <lszubowi@redhat.com>
To: ardb@kernel.org
Cc: linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] efi/x86: Memory protection on EfiGcdMemoryTypeMoreReliable
Date: Tue, 16 Sep 2025 15:38:53 -0400
Message-ID: <20250916193853.410189-1-lszubowi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Check for needed memory protection changes on EFI DXE GCD memory space
descriptors with type EfiGcdMemoryTypeMoreReliable in addition to
EfiGcdMemoryTypeSystemMemory.

This fixes a fault on entry into the decompressed kernel from the
EFI stub that occurs when the memory allocated for the decompressed
kernel is more reliable memory, has NX/XP set, and the kernel needs
to use the EFI DXE protocol to adjust memory protections.

The memory descriptors returned by the DXE protocol
GetMemorySpaceDescriptor() service use a different GCD memory type
to distinguish more reliable memory ranges from their conventional
counterparts. This is in contrast to the EFI memory descriptors
returned by the EFI GetMemoryMap() service which use the
EFI_MEMORY_MORE_RELIABLE memory attributes flag to identify
EFI_CONVENTIONAL_MEMORY type regions that have this additional
property.

Signed-off-by: Lenny Szubowicz <lszubowi@redhat.com>
---
 drivers/firmware/efi/libstub/x86-stub.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index cafc90d4caaf..0f60a12401c2 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -300,7 +300,7 @@ efi_status_t efi_adjust_memory_range_protection(unsigned long start,
 		return EFI_SUCCESS;
 
 	/*
-	 * Don't modify memory region attributes, they are
+	 * Don't modify memory region attributes, if they are
 	 * already suitable, to lower the possibility to
 	 * encounter firmware bugs.
 	 */
@@ -315,11 +315,13 @@ efi_status_t efi_adjust_memory_range_protection(unsigned long start,
 		next = desc.base_address + desc.length;
 
 		/*
-		 * Only system memory is suitable for trampoline/kernel image placement,
-		 * so only this type of memory needs its attributes to be modified.
+		 * Only system memory and more reliable memory are suitable for
+		 * trampoline/kernel image placement. So only those memory types
+		 * may need to have attributes modified.
 		 */
 
-		if (desc.gcd_memory_type != EfiGcdMemoryTypeSystemMemory ||
+		if ((desc.gcd_memory_type != EfiGcdMemoryTypeSystemMemory &&
+		     desc.gcd_memory_type != EfiGcdMemoryTypeMoreReliable) ||
 		    (desc.attributes & (EFI_MEMORY_RO | EFI_MEMORY_XP)) == 0)
 			continue;
 
-- 
2.51.0


