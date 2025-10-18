Return-Path: <linux-kernel+bounces-859310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40377BED477
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 19:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BB823B8657
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 17:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03EB254864;
	Sat, 18 Oct 2025 17:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=josie.lol header.i=@josie.lol header.b="UtYNd+m7"
Received: from mail-108-mta23.mxroute.com (mail-108-mta23.mxroute.com [136.175.108.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B94919F464
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 17:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760807402; cv=none; b=oiLQRUSPMZsur635nhWkp4uZB7mPFwwTqprjjxfm4Vm88+Th1r1MweQfp3FkcdtUUkUukCwziK1S6D78A34wBTSfaOOkNqfgfOApYHWYwOT4AcOmW0Tb4ENAjBVP3+WVyDNkuN1gTQpLKwfnb3FrOXE+I8BacxG3bdKAXJokBQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760807402; c=relaxed/simple;
	bh=OVLQ4wYV6ilspUBsEcmRhS38IN5N5eGjlesu2GCraPA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CR4PJ1CkNMUu7qL8w30f0wCizJa/WHi8XAestlfN9k96h2XGW2jbVI20lUMpZKlBQwBA7MD0xX3ZXtX0+TX/+yhQhdS5M3vwX2YJIkfokwhyY+8fB2afdhNHhTbFc/niqw/QlysIlESzY1ckKDnCpPFJ+a5FuWuT7fqUBpT2ZbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=josie.lol; spf=pass smtp.mailfrom=josie.lol; dkim=pass (2048-bit key) header.d=josie.lol header.i=@josie.lol header.b=UtYNd+m7; arc=none smtp.client-ip=136.175.108.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=josie.lol
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=josie.lol
Received: from filter006.mxroute.com ([140.82.40.27] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta23.mxroute.com (ZoneMTA) with ESMTPSA id 199f847ec11000c217.003
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sat, 18 Oct 2025 17:04:47 +0000
X-Zone-Loop: 7bb67049f95e3cc3f430a82237c06c046f6381da790d
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=josie.lol;
	s=x; h=Content-Transfer-Encoding:MIME-Version:Date:Subject:Cc:To:From:Sender:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References;
	bh=qB1j/+I5/ZjuuObSlQbb2C9HSpLcHcdbskR3s4rIdGc=; b=UtYNd+m7cEUGGMDAHNEASp9fXe
	Il0E5icoPyU3EXmklLPkB20OCbbznfoSs3DB1tjKYCwys27L/Q2FBoCvvnTyqMB01P93C6ili0x9V
	1DNVrA4J5sZyYVtlzvSRhyJFnMRHgKAzFNuprMTDPiwYvselR5PcrlR1W2P6fdAoDffGD7q9TNkHj
	/YwjG1OyLl1W1kmxTb8/NkxCUmezHjsIiHu6TO8raH1aoHzPQNslja7JdUuIzT2RJGxzxq7DRil3B
	K4qCkFpu/s+LGh8gVsNJJuMEf8MdpOhO14IAM9zrsPHakLLXRl+7O2qhIfT8DOzcOo/Qza1K6l1X6
	vfKTvV3Q==;
From: Josephine Pfeiffer <hi@josie.lol>
To: linux@armlinux.org.uk
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] ARM: ptdump: use seq_puts() in pt_dump_seq_puts() macro
Date: Sat, 18 Oct 2025 19:04:42 +0200
Message-ID: <20251018170442.3355403-1-hi@josie.lol>
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

While there are no current call sites in the ARM implementation that
trigger this code path, fixing the macro ensures correctness and
prevents potential issues if new call sites are added in the future.

This bug was introduced in commit d02ca6d76ba7 ("ARM: 8736/1: mm: dump:
make the page table dumping seq_file") in 2017, which explicitly copied
the implementation from the buggy arm64 version (ae5d1cf358a5).

Fixes: d02ca6d76ba7 ("ARM: 8736/1: mm: dump: make the page table dumping seq_file")
Signed-off-by: Josephine Pfeiffer <hi@josie.lol>
---
 arch/arm/mm/dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/dump.c b/arch/arm/mm/dump.c
index cd032522d902..bc90cf2404d2 100644
--- a/arch/arm/mm/dump.c
+++ b/arch/arm/mm/dump.c
@@ -42,7 +42,7 @@ static struct addr_marker address_markers[] = {
 #define pt_dump_seq_puts(m, fmt)    \
 ({						\
 	if (m)					\
-		seq_printf(m, fmt);	\
+		seq_puts(m, fmt);	\
 })
 
 struct pg_state {
-- 
2.51.1.dirty


