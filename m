Return-Path: <linux-kernel+bounces-771207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8107B28430
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DBC31D07161
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C03A30EF70;
	Fri, 15 Aug 2025 16:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IOIeJ+3V"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDEB30EF66
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 16:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276149; cv=none; b=KEW4H7Ph5zGEch00dZhvR3s4WnWe0SodQJ1D2FJbIvyYnYVa7Gq3JiRX0xv5skgEFA23CbStiuRPsxE2boeg4/PpGODZN54439cnNWbXnQlQFRQcY9x6h5G4bC2VYCEt0sKfkmjNfYH7O50SP14ase3jmODww8bsI+1XP5ksTak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276149; c=relaxed/simple;
	bh=p//DIAb1o0PSZ6DvNk+rfn7EAVGIhRuQCvhSRYLKYx0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MB5oLDvQLnMu6J0O1/ctzDhg1a+m2DFBxiNa7tRPA3zLz/y6J0FxBzL06RP6AEg4XfauaEx2SohdnRfwt8Iu8Z98JUxqVpZhaxEYOyxl8o7LidhSIVBNQVjwPOojoalVRyZfNAlpQsTClt/MXf/IsVsvLKbauYnhGCNHEC/CWkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IOIeJ+3V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755276146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=jsgs2I4eW/oDPIBzBndKIkVFS0Utz6B10qho7rxIjSU=;
	b=IOIeJ+3VXwUJGID9e96KmttEKLjl/QduR30vw8GoJYMemSAoJ9Ic5q5a6ti2X68jrrT2xT
	j9B+xVKU/oXg6/4d2nX7RCCB5du5PgYUcvY8ibAAymz+y+IiHDbGPCeUMKfxCBwL9SDY8i
	6m9hnF1p1o+gDDsYE75OP/b9L/KSdEE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-249-ALt5hXROMU6zHKv7_dW2Gw-1; Fri,
 15 Aug 2025 12:42:21 -0400
X-MC-Unique: ALt5hXROMU6zHKv7_dW2Gw-1
X-Mimecast-MFC-AGG-ID: ALt5hXROMU6zHKv7_dW2Gw_1755276139
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4954F195422A;
	Fri, 15 Aug 2025 16:42:18 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.47])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 89E1A1954B06;
	Fri, 15 Aug 2025 16:42:13 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 15 Aug 2025 18:41:01 +0200 (CEST)
Date: Fri, 15 Aug 2025 18:40:55 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: David Laight <david.laight.linux@gmail.com>,
	Li RongQing <lirongqing@baidu.com>, Yu Kuai <yukuai3@huawei.com>,
	Khazhismel Kumykov <khazhy@chromium.org>,
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v3 1/2] x86/math64: handle #DE in mul_u64_u64_div_u64()
Message-ID: <20250815164055.GA13444@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815164009.GA11676@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Change mul_u64_u64_div_u64() to return ULONG_MAX if the result doesn't
fit into u64 or div == 0. The former matches the generic implementation
in lib/math/div64.c, the latter doesn't. Perhaps we will add a WARN()
into the fixup_exception() paths later.

No need to use _ASM_EXTABLE_TYPE_REG(), we know that the target register
is pt_regs->ax with offset == 0, so a simple EX_DATA_REG(0) should work
just fine.

Reported-by: Li RongQing <lirongqing@baidu.com>
Link: https://lore.kernel.org/all/78a0d7bb20504c0884d474868eccd858@baidu.com/
Reviewed-by: David Laight <david.laight.linux@gmail.com>
Tested-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 arch/x86/include/asm/div64.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/div64.h b/arch/x86/include/asm/div64.h
index 9931e4c7d73f..c2532d38ed0a 100644
--- a/arch/x86/include/asm/div64.h
+++ b/arch/x86/include/asm/div64.h
@@ -79,18 +79,21 @@ static inline u64 mul_u32_u32(u32 a, u32 b)
 
 #else
 # include <asm-generic/div64.h>
+# include <asm/asm.h>
 
 /*
- * Will generate an #DE when the result doesn't fit u64, could fix with an
- * __ex_table[] entry when it becomes an issue.
+ * Returns U64_MAX if the result doesn't fit u64 or div == 0.
  */
 static inline u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div)
 {
 	u64 q;
 
-	asm ("mulq %2; divq %3" : "=a" (q)
-				: "a" (a), "rm" (mul), "rm" (div)
-				: "rdx");
+	asm ("mulq %2; 1: divq %3; 2:\n"
+		_ASM_EXTABLE_TYPE(1b, 2b,
+			EX_TYPE_IMM_REG | EX_DATA_REG(0) | EX_DATA_IMM(-1))
+		: "=a" (q)
+		: "a" (a), "rm" (mul), "rm" (div)
+		: "rdx");
 
 	return q;
 }
-- 
2.25.1.362.g51ebf55


