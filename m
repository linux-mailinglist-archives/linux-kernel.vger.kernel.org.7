Return-Path: <linux-kernel+bounces-868095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 80268C04593
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 06:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 311614EA461
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 04:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B839826E70B;
	Fri, 24 Oct 2025 04:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NfLTULst"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958B0125A9
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 04:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761280954; cv=none; b=buDxTqAmvXHLflb8t+t7aD+xJoQJkjC+T9JN45sSVncjZSVwN2quTfYUIp7uTcyP/pSmAUEmtJ6hVp6hBTm6x7JJ4NH7xeXncH01fRKCnLHDWbcP9r0BGjquw/tLyLa3PdqVTqfq28y2eKU15i/CWHuou1UYxVtVqShKts4+j+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761280954; c=relaxed/simple;
	bh=8EbEizH8Gn4G+K24QzLyAYniWHu/O8f+O/qypkjSSac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F0ufVwpBjBm+vpmNv6Pt1x84cH3OcFRe5K8mXCL5Nmi8qs3U88raVksp2iQDCaye8NLijz18tFeIueyYxaIDzCVQq44tG9LN/ls1dL/moE5Fl9RnhN9H/aYS5dRZ2cyR7dZ9fCmHoVJbmlI7fNqKQuUujdWsjNzGUpd4mhEEz0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NfLTULst; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=sbc4O0hCMw+D2bCz4SsmpeiF8ug+byP21lsVfk1Wqs0=; b=NfLTULsthzOkwhPaWueruw8XCW
	ec/U+aFlToKNPiV1K01ZZ25y9gMHVwrPTKDhLV/n44h4OeTESPNp5rNYwHkAjXDkVlmBBizFk1RqQ
	A1pymyaeiXZFBxRBYH7wAwYacBDj19ALJi9V7aJ4N4M6lCDWabnJddxJ1Q2S9MMGSSzx63XWhifhR
	aUB/F95UHaKbzovaUr3sYDQNL36lrvfhy1NY1xL/IKfsVbj14YAf8LUP7eYfSsC6sTAxAQ951NxOx
	TAM3or3pjpE4+3nugBbn3161DbTW+BCs5l0n3IaRTaLIYUn+VMY6QwhEZZBCT7Tn6OvsjoL/p0UDM
	jzQUAufA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vC9dD-00000008EsG-1Uzo;
	Fri, 24 Oct 2025 04:42:27 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Fei Li <fei1.li@intel.com>,
	acrn-dev@lists.projectacrn.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] virt: acrn: fix kernel-doc in <uapi/linux/acrn.h>
Date: Thu, 23 Oct 2025 21:42:26 -0700
Message-ID: <20251024044226.480531-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the kernel-doc comments for struct acrn_mmiodev so that all
struct members are rendered correctly.
Correct io_base to io_addr in struct acrn_vdev.

acrn.h:441: warning: Function parameter or struct member 'res'
 not described in 'acrn_mmiodev'
acrn.h:479: warning: Function parameter or struct member 'io_addr'
 not described in 'acrn_vdev'
acrn.h:479: warning: Excess struct member 'io_base' description
 in 'acrn_vdev'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Fei Li <fei1.li@intel.com>
Cc: acrn-dev@lists.projectacrn.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/uapi/linux/acrn.h |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- linux-next-20251022.orig/include/uapi/linux/acrn.h
+++ linux-next-20251022/include/uapi/linux/acrn.h
@@ -420,12 +420,13 @@ struct acrn_pcidev {
 /**
  * struct acrn_mmiodev - Info for assigning or de-assigning a MMIO device
  * @name:			Name of the MMIO device.
- * @res[].user_vm_pa:		Physical address of User VM of the MMIO region
+ * @res:			MMIO resource descriptor info.
+ * @res.user_vm_pa:		Physical address of User VM of the MMIO region
  *				for the MMIO device.
- * @res[].service_vm_pa:	Physical address of Service VM of the MMIO
+ * @res.service_vm_pa:		Physical address of Service VM of the MMIO
  *				region for the MMIO device.
- * @res[].size:			Size of the MMIO region for the MMIO device.
- * @res[].mem_type:		Memory type of the MMIO region for the MMIO
+ * @res.size:			Size of the MMIO region for the MMIO device.
+ * @res.mem_type:		Memory type of the MMIO region for the MMIO
  *				device.
  *
  * This structure will be passed to hypervisor directly.
@@ -449,7 +450,7 @@ struct acrn_mmiodev {
  * @id.fields.legacy_id:	ID of the virtual device if not a PCI device
  * @slot:			Virtual Bus/Device/Function of the virtual
  *				device
- * @io_base:			IO resource base address of the virtual device
+ * @io_addr:			IO resource base address of the virtual device
  * @io_size:			IO resource size of the virtual device
  * @args:			Arguments for the virtual device creation
  *

