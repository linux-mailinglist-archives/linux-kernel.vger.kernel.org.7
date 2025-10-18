Return-Path: <linux-kernel+bounces-859312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E9CBED47D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 19:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDFCF3A3815
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 17:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8497D24886E;
	Sat, 18 Oct 2025 17:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=josie.lol header.i=@josie.lol header.b="LHLjF33F"
Received: from mail-108-mta77.mxroute.com (mail-108-mta77.mxroute.com [136.175.108.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496912475F7
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 17:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760807441; cv=none; b=E28361NElyRMkGglQkccZAMgbWaGRUOPCNinkl84d5fmFr9MFhLM4p1IGovCw02Oh04l8IXHQxZ0/MVT9UQgcyaUfkazN/EDIxw4lAX5lvn/j/Cv351NHAEJ1oKmjB7U6z6X2R2W9oMrex/rqIBzAJinlmUT48Aa6JtTCbgaRbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760807441; c=relaxed/simple;
	bh=isUv48RfC+32G6E/apPc1kh0jp1vA5KzEKDiZR4OVmg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VaFTaIWaJFrI/E90NCwUIMujlL+iPmUCIogAOTYvP4KOLU89kqdW2iYNEFq+PnXvp3TPaL4dXyg6hi3bEvp/XkjlBYhIqRncxT35kCZ8LczAgYV1qnCQcYKP9i9QsKXOh7PYLrYJXMyw3sCkJpLiM0RdoGE5jRRnMreeTq9B76I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=josie.lol; spf=pass smtp.mailfrom=josie.lol; dkim=pass (2048-bit key) header.d=josie.lol header.i=@josie.lol header.b=LHLjF33F; arc=none smtp.client-ip=136.175.108.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=josie.lol
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=josie.lol
Received: from filter006.mxroute.com ([140.82.40.27] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta77.mxroute.com (ZoneMTA) with ESMTPSA id 199f8487c2c000c217.005
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sat, 18 Oct 2025 17:05:24 +0000
X-Zone-Loop: 311d45eb92a9539159b0e72ef36a147a068dd8f058b4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=josie.lol;
	s=x; h=Content-Transfer-Encoding:MIME-Version:Date:Subject:Cc:To:From:Sender:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References;
	bh=j5n2Zj0bvkxd7gcl32uW6FvwApEeWvBsdGCsdJ7/pxo=; b=LHLjF33FZVbK6SU0+Gf4mtjLDS
	2hTKzMiTDfozW9+Z8a6PdmgBAuoGZ40G0ClHWIUV13zBrq1G0fkKnrDSSLnOA4OM2KcdgTbYTevMi
	Z4h7aLqcq52GJI/f/IQv5uKVyfnI3ftD0i71rZC0BxZSPuUGuSF3UIa4IC+BRLMVVVovK8UGKegjV
	iztLvTKJbQPmNosHuElztTZAteX42aCTqohCp8mnuDhugK+5+tOsGe4Zm6fuJkblUKqIQ5c7R2vfV
	I2FSYcC9pdyB30dr8HLv+2c9Ln9XlwGEOasp1NrG1ycKvY/3ganO4WnqXIySs9gq9dTX9LiAGS+PI
	bDe5nAKw==;
From: Josephine Pfeiffer <hi@josie.lol>
To: agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com
Cc: hca@linux.ibm.com,
	gor@linux.ibm.com,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] s390: ptdump: use seq_puts() in pt_dump_seq_puts() macro
Date: Sat, 18 Oct 2025 19:05:21 +0200
Message-ID: <20251018170521.3355738-1-hi@josie.lol>
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

The macro is used in dump_pagetables.c:67-68 and 131 to output
constant strings. Using seq_printf() adds unnecessary overhead for
format string parsing.

This bug was introduced in commit 6bf9a639e76e1 ("s390/mm,ptdump: make
page table dumping seq_file optional") in 2020, which explicitly stated
it was the "s390 version of commit ae5d1cf358a5 ("arm64: dump: Make the
page table dumping seq_file optional")", copying the buggy arm64
implementation.

Fixes: 6bf9a639e76e1 ("s390/mm,ptdump: make page table dumping seq_file optional")
Signed-off-by: Josephine Pfeiffer <hi@josie.lol>
---
 arch/s390/mm/dump_pagetables.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/mm/dump_pagetables.c b/arch/s390/mm/dump_pagetables.c
index 9af2aae0a515..3692f9d20f0d 100644
--- a/arch/s390/mm/dump_pagetables.c
+++ b/arch/s390/mm/dump_pagetables.c
@@ -51,7 +51,7 @@ struct pg_state {
 	struct seq_file *__m = (m);		\
 						\
 	if (__m)				\
-		seq_printf(__m, fmt);		\
+		seq_puts(__m, fmt);		\
 })
 
 static void print_prot(struct seq_file *m, unsigned int pr, int level)
-- 
2.51.1.dirty


