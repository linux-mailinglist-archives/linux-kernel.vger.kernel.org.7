Return-Path: <linux-kernel+bounces-752824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60203B17B4E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 04:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F29F545B35
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 02:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F144E14AD2D;
	Fri,  1 Aug 2025 02:50:07 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1C2487BE
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 02:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754016607; cv=none; b=q2X/GecWS8C0My/9SixrJ7TmvGKpeyqqnsSWisTu98EMVECyYzQvc4RADRULjtUA4DGExb1QdlKF1+jVQvAXOF2kcq/KCzkr9gh7bo1qDeaQUdUyRnk9ljqAn8zs7Oakyj+dxAyez+WG9z1x3L10Cr9erGXoUJfkRKPp73zKhtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754016607; c=relaxed/simple;
	bh=MqDXBQ1oPnFaUWMVYYS9aaAOQed3q/QU16mTcUNZPro=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=oKXxIdkQpVm4wsPf4jq4YnP6xIu+2O8RXUWEOM45ukoMXSNpTC/5NhdNoaIcUqmW+90n/GANGIoCZDG8jMUJvUFhKJMtgPRsHGm5e8ltj8jGTEh5Nldmvdi39/190Dx1aTCKYa0l/JGHb4A+8msEWQlRdvjN/D2crE0hr1I/whQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4btVmR0ZDYz5B15M;
	Fri, 01 Aug 2025 10:49:59 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 5712nlsR073301;
	Fri, 1 Aug 2025 10:49:47 +0800 (+08)
	(envelope-from liu.xuemei1@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Fri, 1 Aug 2025 10:49:48 +0800 (CST)
Date: Fri, 1 Aug 2025 10:49:48 +0800 (CST)
X-Zmail-TransId: 2afb688c2b4cffffffffbab-fbbcd
X-Mailer: Zmail v1.0
Message-ID: <20250801104948133AaMr5S6E382PbNNhoJgHA@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <liu.xuemei1@zte.com.cn>
To: <paul.walmsley@sifive.com>
Cc: <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
        <liu.xuemei1@zte.com.cn>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIFJFU0VORF0gcmlzY3Y6IG1tYXAoKTogdXNlIHVuc2lnbmVkIG9mZnNldCB0eXBlIGluIHJpc2N2X3N5c19tbWFw?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 5712nlsR073301
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: liu.xuemei1@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Fri, 01 Aug 2025 10:49:59 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 688C2B57.000/4btVmR0ZDYz5B15M

From: Jessica Liu <liu.xuemei1@zte.com.cn>

The variable type of offset should be consistent with the relevant
interfaces of mmap which described in commit 295f10061af0 ("syscalls:
mmap(): use unsigned offset type consistently). Otherwise, a user input
with the top bit set would result in a negative page offset rather than a
large one.

Signed-off-by: Jessica Liu <liu.xuemei1@zte.com.cn>
---
arch/riscv/kernel/sys_riscv.c | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
index d77afe05578f..795b2e815ac9 100644
--- a/arch/riscv/kernel/sys_riscv.c
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -10,7 +10,7 @@

static long riscv_sys_mmap(unsigned long addr, unsigned long len,
 			unsigned long prot, unsigned long flags,
-			   unsigned long fd, off_t offset,
+			   unsigned long fd, unsigned long offset,
 			unsigned long page_shift_offset)
{
 	if (unlikely(offset & (~PAGE_MASK >> page_shift_offset)))
--
2.25.1

