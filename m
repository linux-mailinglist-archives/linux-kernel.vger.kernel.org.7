Return-Path: <linux-kernel+bounces-826543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE8CB8EC1C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 04:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AED8E3BE856
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 02:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACFE1514E4;
	Mon, 22 Sep 2025 02:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Des2JMz3"
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B7D1A285
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 02:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758507387; cv=none; b=D3nJUUYbtiKlJy6Is6mrd8LCcTM8EFNBpgSMX9MVqZ3QdMbyw+ePIEMtlVwL8riFla2UZ9gfqioNi+r9Acq975pmk1Nmtx/yX1CTwFtV3VZYpnOkKQvPF7UQx1fRe2r7yNNwMHi5asUTelTGIOD1gEfPI+qOJT1VjgQvARuL6Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758507387; c=relaxed/simple;
	bh=jPpyQUpv/4CcBv6uAghnEIdx7Sgff5lWMgTHTCTxE1E=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=ZirP2gTInhKXZDVUgg8M9SRq+CUp0ugI2AQTzNU/KQGJloU3XHFEpXcuCP4ylnQAaDw58M/Hg51h0vGcTJQQ1eltI6SnDY4agkK6XoXIvO8qZHI0N27ltqBKh++a7yz8LUUbyj8zefRTJUlA/Pfd0oyNG8xrzAeuQHZTviUFz4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Des2JMz3; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1758507079; bh=oZtgZeCXj/DWaxllRxN8B+8Trtm4h+TPzXKswsRcbvo=;
	h=From:To:Cc:Subject:Date;
	b=Des2JMz35V4sCz11T1ScKKwg3NYT4CW8GTvnx+DP1dg1189cDlC834TX8aFR45UtX
	 +wWfxb78HE41/AA79mj+twiJTRpkkUhAwqIl0ofg+WwH0FoCTx5nYEUoI3wd2oTR6n
	 7LXPC10IG+fodu6KcV58ETrEHvCQKk5v9PRO/AvM=
Received: from localhost.localdomain ([116.128.244.171])
	by newxmesmtplogicsvrszc41-0.qq.com (NewEsmtp) with SMTP
	id 2D08F46D; Mon, 22 Sep 2025 10:11:16 +0800
X-QQ-mid: xmsmtpt1758507076tkc60zpf3
Message-ID: <tencent_E0C8EAB7EBECF90582B0CD21490DBCF53A0A@qq.com>
X-QQ-XMAILINFO: OKkKo7I1HxIeUjrwISW56o6ujXkMLSJRfQkbWX/t1Gfp+vcDB9SeQU0tO3PdHR
	 /m3+xuZbI2Z+jGxzd1ibBxEXZC1TyLzb/ya+jOo/0kNRXmeysXru9Pj9ruY9LffpV6zbrFQwC4n+
	 ZpX/FU7UobIlotlZGxEb7welR0qGKGMCr6zGLwprW+LYBUfulfv9LvGIDDyDeoTVCw+xRI1B6le/
	 SkXQwLbLdL3Bf5yUh+sTgae9wG1DAdrIKbpIclly89/CstgADYx9AhJ9AP4XC8dr80GNTjyb/yqJ
	 tWwmdQPpOgPeRi/+D0OJXocZKGTCtNpecgNZ2d6TmauH5QwOM1XoB3D0RAqv/VM3EnhjYNEkN6Pk
	 MUx4EXyTorsn0AxLJuCcAh4+EMqQ/OjlqcRAKleorE2gmLML9Qcng+60E51LB/YkKo38TS9+Cb3a
	 Rr43voqBVjFmVBxdAKOvwh9p5e8gKT23/f+6DbkIKuxWdR80BOPdbrNJRcFD671w37V7X8m1hGB2
	 I4EHCDmRvmHVdAhB0Uh/hEetonnD6qq9jKGGoSGBsinbbZWU05SiyW6V1/kiNQBJ4v9lWkeOT/7b
	 81NUHLI8xNlWsAc4gbNGL65gyD68pBZ7dEy2k/F+WNAwKLLLj+iZmCEZ16Ikww95joWJYrjLT2jh
	 PILQYsLRJTi9tTAEWX6d7fUAdakNrFhjsx+lMTRaGYBgNRJLe2VatDbPmdbXLEdc8s+SEBQQCJl/
	 Az7ReEnHMpX4icK0bodNgwxxB257YNpSV7On4EPnBPzz1rYA8RVkNIyrEjmRAB87C71dypY+d2C3
	 wv6oeVGZsuNnpgUFcO+xZcOUXsyZhZwCCvjvr5G21rAtb+2EWQ2WJ4cPkRdPNXP2l+pEqbchUEAQ
	 so5mDt3DGXJgwgC3pNYlRsHJ6Zw79liNoGKAeAEYExwLWabiY29360+DUKRWqJeXlN3FOSV+dWjD
	 POagycbzcyeKbJg9kZSmRJahNt7vAfAZar4Lt8uvok3osuR3CFOYVH+B/hoAYuFnUgUpyj51zhze
	 a/SWIB91AsZ4d/hT1lmGKJhvtuUGXQSmomXTeWVoHo3pEfnDk4BTQIVDQbqQ9rmanMX6H0lw==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Haofeng Li <920484857@qq.com>
To: Quentin Monnet <qmo@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	linux-kernel@vger.kernel.org,
	Haofeng Li <13266079573@163.com>,
	lihaofeng <lihaofeng@kylinos.cn>
Subject: [PATCH v2] bpf: fix netfilter link comparison to handle unsigned flags
Date: Mon, 22 Sep 2025 10:11:06 +0800
X-OQ-MSGID: <20250922021106.981094-1-920484857@qq.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: lihaofeng <lihaofeng@kylinos.cn>

The original implementation of netfilter_link_compar() used subtraction
to compare the netfilter.flags field, which is  an unsigned type.
This could result in incorrect comparison results when the unsigned
value wrapped around due to underflow.

Changed the comparison logic for flags to use explicit conditional
checks (similar to how priority is handled) instead of subtraction,
ensuring correct negative/zero/positive return values regardless of
the underlying data type.

This fixes potential sorting issues when using this comparison function
with algorithms like qsort() or bsearch().

Signed-off-by: lihaofeng <lihaofeng@kylinos.cn>
---
Changes in v2:
- Added conditional checks for all fields (pf, hooknum, flags) to prevent
- overflow while preserving consistent comparison style and original order.
---
 tools/bpf/bpftool/net.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
index cfc6f944f7c3..a8caea07be8f 100644
--- a/tools/bpf/bpftool/net.c
+++ b/tools/bpf/bpftool/net.c
@@ -801,22 +801,27 @@ static int netfilter_link_compar(const void *a, const void *b)
 {
 	const struct bpf_link_info *nfa = a;
 	const struct bpf_link_info *nfb = b;
-	int delta;
 
-	delta = nfa->netfilter.pf - nfb->netfilter.pf;
-	if (delta)
-		return delta;
+	if (nfa->netfilter.pf < nfb->netfilter.pf)
+		return -1;
+	if (nfa->netfilter.pf > nfb->netfilter.pf)
+		return 1;
 
-	delta = nfa->netfilter.hooknum - nfb->netfilter.hooknum;
-	if (delta)
-		return delta;
+	if (nfa->netfilter.hooknum < nfb->netfilter.hooknum)
+		return -1;
+	if (nfa->netfilter.hooknum > nfb->netfilter.hooknum)
+		return 1;
 
 	if (nfa->netfilter.priority < nfb->netfilter.priority)
 		return -1;
 	if (nfa->netfilter.priority > nfb->netfilter.priority)
 		return 1;
 
-	return nfa->netfilter.flags - nfb->netfilter.flags;
+	if (nfa->netfilter.flags < nfb->netfilter.flags)
+		return -1;
+	if (nfa->netfilter.flags > nfb->netfilter.flags)
+		return 1;
+	return 0;
 }
 
 static void show_link_netfilter(void)
-- 
2.25.1


