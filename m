Return-Path: <linux-kernel+bounces-739331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07529B0C4D8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B42374E630C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCD72DECC2;
	Mon, 21 Jul 2025 13:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lms+fLCb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2162DECD8
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 13:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753103133; cv=none; b=SM7dqwDiHTdpnoHTsSvfPQhH9o2eliPuDlg6ElWPhB+f/umOhNDUITfkLGYmYtSD5hf4XJPaLT3tNexnhjvv5SvnicqDdsiGFqsbg/vfcLIszjPCB1kJfcPZCb9SNdxqDEXE7VJOKZxEuOI0XLazOuDau6JT1qs/N29ui5RE684=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753103133; c=relaxed/simple;
	bh=Th1QW7VIgGaTx0b4fEZY7qgyPShbll/wzWSc2sU8P44=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HKiobQ4sCyHw9ace6q2SL2iZFs9hZnUwbekk70PrIhlPvDw6Xkj8OXTzBDMzUpqiiDO5QUeDp2NJbmL6J7EM5UOMXcelgmPSofWoorEdy1RpIyVwHLK6S9Q+WxFeQkJa2DUl0K0IL/GCGVTiF1UdI16HgW3lALiV2c9MFCC+4sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lms+fLCb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753103130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=5gxENCsb4R5H5BH/2kzZZWvwg59XUHk80ZD2DVRFzlQ=;
	b=Lms+fLCbfQ8BrS8efU4epRpFr5bfv8TpQH5flccMIZbveeUyTafsRKDoLksxbCdEch1kAn
	hwlGrFPQ6dXcuye1BO8fT5K76+Db3H5T35ZjjrpAuypQSwKnhsLWYOBG55atgm0y3l7hoj
	utmoFl0RomPDx2CONW4OSRG9c9LQJJ8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-340-oTjEZzH1NNqBLs4pXJtxJA-1; Mon,
 21 Jul 2025 09:05:25 -0400
X-MC-Unique: oTjEZzH1NNqBLs4pXJtxJA-1
X-Mimecast-MFC-AGG-ID: oTjEZzH1NNqBLs4pXJtxJA_1753103123
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D107E195FD2B;
	Mon, 21 Jul 2025 13:05:22 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.34.109])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 4AF1330001B9;
	Mon, 21 Jul 2025 13:05:16 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 21 Jul 2025 15:04:28 +0200 (CEST)
Date: Mon, 21 Jul 2025 15:04:22 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: David Laight <david.laight.linux@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Li,Rongqing" <lirongqing@baidu.com>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH] x86/math64: handle #DE in mul_u64_u64_div_u64()
Message-ID: <20250721130422.GA31640@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Change mul_u64_u64_div_u64() to return ULONG_MAX if the result doesn't
fit u64, this matches the generic implementation in lib/math/div64.c.

Reported-by: "Li,Rongqing" <lirongqing@baidu.com>
Link: https://lore.kernel.org/all/78a0d7bb20504c0884d474868eccd858@baidu.com/
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 arch/x86/include/asm/div64.h | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/div64.h b/arch/x86/include/asm/div64.h
index 9931e4c7d73f..dfd25cfd1c33 100644
--- a/arch/x86/include/asm/div64.h
+++ b/arch/x86/include/asm/div64.h
@@ -79,20 +79,27 @@ static inline u64 mul_u32_u32(u32 a, u32 b)
 
 #else
 # include <asm-generic/div64.h>
+# include <asm/asm.h>
+# include <asm/bug.h>
 
 /*
- * Will generate an #DE when the result doesn't fit u64, could fix with an
- * __ex_table[] entry when it becomes an issue.
+ * Returns ULONG_MAX when the result doesn't fit u64.
  */
 static inline u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div)
 {
+	int ok = 0;
 	u64 q;
 
-	asm ("mulq %2; divq %3" : "=a" (q)
-				: "a" (a), "rm" (mul), "rm" (div)
-				: "rdx");
+	asm ("mulq %3; 1: divq %4; movl $1,%1; 2:\n"
+		_ASM_EXTABLE(1b, 2b)
+		: "=a" (q), "+r" (ok)
+		: "a" (a), "rm" (mul), "rm" (div)
+		: "rdx");
 
-	return q;
+	if (ok)
+		return q;
+	WARN_ON_ONCE(!div);
+	return ~(u64)0;
 }
 #define mul_u64_u64_div_u64 mul_u64_u64_div_u64
 
-- 
2.25.1.362.g51ebf55



