Return-Path: <linux-kernel+bounces-859308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD298BED465
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 19:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E48993B7CCE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 17:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515CC1D618C;
	Sat, 18 Oct 2025 17:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=josie.lol header.i=@josie.lol header.b="Y75QYPhZ"
Received: from mail-108-mta119.mxroute.com (mail-108-mta119.mxroute.com [136.175.108.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4DC4A3E
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 17:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760807376; cv=none; b=Nrfi/h0YEUNo6Lcj346kor0ztubEg9q2yYKMePb5MLylG626cjLFruW5NPNEn5wljtCbHy7o9pn1mhVIA9y3Rb1GQDykxAPG2ruZm42TxF/zY1Xe+fBElFgrlodzSH2xFF6yWonCsc3A/T6E76yLqplOdwrtZq9OgJNMcjOnC04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760807376; c=relaxed/simple;
	bh=H3Ubg91H6s5TLhsNIssX3o/9x0rZWJ9XP6oHZcSgkzw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VSVbl1uYf94wf3dJ6yB+zcvHy90YYdFnzjgukNHeIDCcXu97hYR3dIQ+1dvdgU/5hXrVRcOETPvWt5BByvpc6K4ggU+MrmccyLd6cN3IVvEjUX2DRrvgisqb/V41YItMRqeLfv6UyVFRZuBVtBqAnwwfxP22fF0FN9DXb+aBcGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=josie.lol; spf=pass smtp.mailfrom=josie.lol; dkim=pass (2048-bit key) header.d=josie.lol header.i=@josie.lol header.b=Y75QYPhZ; arc=none smtp.client-ip=136.175.108.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=josie.lol
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=josie.lol
Received: from filter006.mxroute.com ([140.82.40.27] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta119.mxroute.com (ZoneMTA) with ESMTPSA id 199f84788af000c217.004
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sat, 18 Oct 2025 17:04:21 +0000
X-Zone-Loop: 0fae5856f7c4a581f1fb56948374179680f2bf078941
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=josie.lol;
	s=x; h=Content-Transfer-Encoding:MIME-Version:Date:Subject:Cc:To:From:Sender:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References;
	bh=czPLsVnnob4wEuO1VYDim5CWL4iqX/jfBfFcX+qk1oA=; b=Y75QYPhZdMhhH/QJcgGAkvHXhf
	SN8wY5VjlhHvk3m+yJ2tKwT5SMpnAHI7FC9K62+GZVL1e+VsvL0Ra+EmqPMn3b7CrlB7cbSFm9V+c
	JoHN+cEyznGgMc+cnoNa9eQ3k3pDjBD5a18H8Wff1Tg/izKwrWDA8YD5FHWD16HHORhIJ/2BrSP6J
	tYWv/S0dJL/8ujrSC3ipGu5IAeefZ05XlRweFAkzQE49LGrOgEbXlpQgJA7Jx7MYWPgy6Yf5Fi/4J
	DbmZo9W1FSaps7CRrfgs9WhrG/p3Z70r7mPnxLyKiteXnpoqgZsOFBKx1TTxqrxr/fFoeNb0NgujY
	7UVmvTKQ==;
From: Josephine Pfeiffer <hi@josie.lol>
To: catalin.marinas@arm.com,
	will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] arm64: ptdump: use seq_puts() in pt_dump_seq_puts() macro
Date: Sat, 18 Oct 2025 19:04:16 +0200
Message-ID: <20251018170416.3355249-1-hi@josie.lol>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: hi@josie.lol

The pt_dump_seq_puts() macro incorrectly uses seq_printf() instead of
seq_puts(). This is both a performance issue and conceptually wrong,
as the macro name suggests plain string output (puts) but the
implementation uses formatted output (printf).

All call sites pass constant strings without format specifiers, so
using seq_printf() adds unnecessary overhead for format string parsing.

This bug was introduced in commit ae5d1cf358a5 ("arm64: dump: Make the
page table dumping seq_file optional") in 2016, where seq_puts() was
replaced with a new pt_dump_seq_puts() macro that mistakenly used
seq_printf().

Fixes: ae5d1cf358a5 ("arm64: dump: Make the page table dumping seq_file optional")
Signed-off-by: Josephine Pfeiffer <hi@josie.lol>
---
 arch/arm64/mm/ptdump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index ab9899ca1e5f..a35fcd62bf75 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -35,7 +35,7 @@
 #define pt_dump_seq_puts(m, fmt)	\
 ({					\
 	if (m)				\
-		seq_printf(m, fmt);	\
+		seq_puts(m, fmt);	\
 })
 
 static const struct ptdump_prot_bits pte_bits[] = {
-- 
2.51.1.dirty


