Return-Path: <linux-kernel+bounces-747084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 841DEB12F7C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 14:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABF3C17871D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 12:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870AA204F93;
	Sun, 27 Jul 2025 12:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HDX61K+/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45D4610D
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 12:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753619783; cv=none; b=tCK/ZzdIeIBU0ZfjBmxSb9KtPGX4wH6Zt4d7McMXGoq5XrxR6BwNdlZC38fU3MQDiJNVOLvp9rWwU7roaAYCbxmxmr1wdbHpuqgU5q/4YyGt3pnmPouQF0u3S5FqXPpdlAnk1uQX+3nEgaOcRaRijV1Fbz6GJv9uboAAwXDlgbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753619783; c=relaxed/simple;
	bh=mreXsClTLOlzk8X2O1NqLJ9eH+di+fBAa32gcpMf/Yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VxliUGZqWvJqRcsK+rVVmVd9DAut412wMGMSYgiebYYXpwK61OpKB5aWYgySaGNACU3PBbpa1CbC6jPdJfJkh2SzHbsm8in6L4qJh+CiyRiHIjCz7G0O/U96ETov8wvfSDjRmPGUHXvGk7Bk45R2GEhrbvA73+HCtxLizMNejE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HDX61K+/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753619779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NsbSEibnFvJRbf7IZMUW1BQlaokDEij77vVGU8eDxnI=;
	b=HDX61K+/Vqr0tl80l/SYt760baCjyrdZS2RgWdO9auEmpiBGVq5EjOCjg+tJHe22qR1XCC
	Yu1yAYUFf41HXcQqcTX0A5f5MBRnLo5vY/URr2Ito3j+fZAvF0Sc08h6peAYOwIYddblJR
	v0+YVTj0rxwn2BG7jzylbHxs/wnEDdA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-134-5dcf-AiFNrCBOCi0YjSxsQ-1; Sun,
 27 Jul 2025 08:36:15 -0400
X-MC-Unique: 5dcf-AiFNrCBOCi0YjSxsQ-1
X-Mimecast-MFC-AGG-ID: 5dcf-AiFNrCBOCi0YjSxsQ_1753619773
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 41034180045B;
	Sun, 27 Jul 2025 12:36:12 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.39])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 9B9EC18003FC;
	Sun, 27 Jul 2025 12:36:07 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 27 Jul 2025 14:35:03 +0200 (CEST)
Date: Sun, 27 Jul 2025 14:34:58 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: David Laight <david.laight.linux@gmail.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Li,Rongqing" <lirongqing@baidu.com>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v2] x86/math64: handle #DE in mul_u64_u64_div_u64()
Message-ID: <20250727123458.GA16775@redhat.com>
References: <20250721130422.GA31640@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721130422.GA31640@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Change mul_u64_u64_div_u64() to return ULONG_MAX if the result doesn't
fit into u64 or div == 0. The former matches the generic implementation
in lib/math/div64.c, the latter doesn't. Perhaps we will add a WARN()
into the fixup_exception() paths later.

No need to use _ASM_EXTABLE_TYPE_REG(), we know that the target register
is pt_regs->ax with offset == 0, so a simple EX_DATA_REG(0) should work
just fine.

Reported-by: Li RongQing <lirongqing@baidu.com>
Link: https://lore.kernel.org/all/78a0d7bb20504c0884d474868eccd858@baidu.com/
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 arch/x86/include/asm/div64.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/div64.h b/arch/x86/include/asm/div64.h
index 9931e4c7d73f..0bf2c6afe66e 100644
--- a/arch/x86/include/asm/div64.h
+++ b/arch/x86/include/asm/div64.h
@@ -79,18 +79,21 @@ static inline u64 mul_u32_u32(u32 a, u32 b)
 
 #else
 # include <asm-generic/div64.h>
+# include <asm/asm.h>
 
 /*
- * Will generate an #DE when the result doesn't fit u64, could fix with an
- * __ex_table[] entry when it becomes an issue.
+ * Returns ULONG_MAX if the result doesn't fit u64 or div == 0.
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



