Return-Path: <linux-kernel+bounces-873014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45027C12D60
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 05:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCB9158614D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 04:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745DF2882AF;
	Tue, 28 Oct 2025 04:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HmT+tCdw"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93F91E520A
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 04:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761624253; cv=none; b=qPZtXUmfbDIsYfBmJGd0fwl4jiys8yKnC3XzUeOJYG0kIPJHa3wTLaamkHC5MvPZ70qpqpqSgL3Z/yBEpr6I4BiVql/2vMZLN41VLoEls34/Bk4h6FvOYOUWVGIvkmX88olBdt9aBg7Jb2KyBqMYlvoUyr86mPcV0rIxDZZ54A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761624253; c=relaxed/simple;
	bh=L7UoWi/zA2mzKWvF6hAvYL9t1hdn5xIZ89S5Uw0GClg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uq2uN5VNJsoAQ86F36Hr9JpZY8XSFTeF1W67etIFLDOPwhB5M+YpMxOopYcBpv7Mo8tVQrekDe7i2glkkdByVw7zLX4pPO3pOjmdRZNx3QcJeWDwUKt0joRACwaiKDBrQUhguJeQcB84jAvHpHQxEgIctsBZYS8sGy30XTvnYcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HmT+tCdw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=sksr/hQlKxgOhgZ3Qd6cbuBhufklRB//+xlnNUc0nY8=; b=HmT+tCdwL8c+ngAY2XZw7SUHzf
	PzZeVvOMJTlUJ8PQAbukJfZrlihFMBYwUvyYx3xX2DDj7ClN7WJ9MCrcuqu34Zh7RZvBkHIAdGNJH
	Npxzwv4+V5fxmdeh8gDgb8YoOm0oDfeh5BflvPV8yXkSq59bw6BQeUBMYoc+qsx/CdaTdoSMNSBIr
	QkH+NWDGng+6wdfkv6KvOHUTdktu3QO/wnAnb1ixQIB30g2LXpxnaSwm/JnvD0KtLjCdlBOTorcfE
	yIMjS5ClD2tzLifZvh1Ij/QhztDlOLfwk+jl8vQZHqK7Xv/hI/SQyiMz6edTGNRIrty/uxqTZzL5g
	3doBR+wg==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDawM-0000000FBv4-0opP;
	Tue, 28 Oct 2025 04:04:10 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Fei Li <fei1.li@intel.com>,
	acrn-dev@lists.projectacrn.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] virt: acrn: split acrn_mmio_dev_res out of acrn_mmiodev
Date: Mon, 27 Oct 2025 21:04:09 -0700
Message-ID: <20251028040409.868254-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add struct acrn_mmio_dev_res before struct acrn_mmio_dev.
The former is used in the latter and breaking them up provides
better kernel-doc documentation for the struct members.

Suggested-by: Fei Li <fei1.li@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Fei Li <fei1.li@intel.com>
---
Cc: acrn-dev@lists.projectacrn.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/uapi/linux/acrn.h |   36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

--- linux-next-20251024.orig/include/uapi/linux/acrn.h
+++ linux-next-20251024/include/uapi/linux/acrn.h
@@ -418,26 +418,32 @@ struct acrn_pcidev {
 };
 
 /**
- * struct acrn_mmiodev - Info for assigning or de-assigning a MMIO device
- * @name:			Name of the MMIO device.
- * @res[].user_vm_pa:		Physical address of User VM of the MMIO region
- *				for the MMIO device.
- * @res[].service_vm_pa:	Physical address of Service VM of the MMIO
- *				region for the MMIO device.
- * @res[].size:			Size of the MMIO region for the MMIO device.
- * @res[].mem_type:		Memory type of the MMIO region for the MMIO
- *				device.
+ * struct acrn_mmio_dev_res - MMIO device resource description
+ * @user_vm_pa:		Physical address of User VM of the MMIO region
+ *			for the MMIO device.
+ * @service_vm_pa:	Physical address of Service VM of the MMIO
+ *			region for the MMIO device.
+ * @size:		Size of the MMIO region for the MMIO device.
+ * @mem_type:		Memory type of the MMIO region for the MMIO
+ *			device.
+ */
+struct acrn_mmio_dev_res {
+	__u64	user_vm_pa;
+	__u64	service_vm_pa;
+	__u64	size;
+	__u64	mem_type;
+};
+
+/**
+ * struct acrn_mmiodev - Info for assigning or de-assigning an MMIO device
+ * @name:	Name of the MMIO device.
+ * @res:	Array of MMIO device descriptions
  *
  * This structure will be passed to hypervisor directly.
  */
 struct acrn_mmiodev {
 	__u8	name[8];
-	struct {
-		__u64	user_vm_pa;
-		__u64	service_vm_pa;
-		__u64	size;
-		__u64	mem_type;
-	} res[ACRN_MMIODEV_RES_NUM];
+	struct acrn_mmio_dev_res res[ACRN_MMIODEV_RES_NUM];
 };
 
 /**

