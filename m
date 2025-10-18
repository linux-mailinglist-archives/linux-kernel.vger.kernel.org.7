Return-Path: <linux-kernel+bounces-859311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B473BED474
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 19:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A83294EBF6A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 17:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D6E24729C;
	Sat, 18 Oct 2025 17:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=josie.lol header.i=@josie.lol header.b="WzBI4rFx"
Received: from mail-108-mta25.mxroute.com (mail-108-mta25.mxroute.com [136.175.108.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC1823B61A
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 17:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760807412; cv=none; b=HjRlMW5SHFs2GXqhtfXN/EYr8pF/jrLWO2z9ponw81HFgHJTBYLUTZgUdTMTnajlIE4koJAuM5lfC2BSasFp8sTyTYqnE0YOAF86YdYLJGcYR61PQPyTowOTvp4kGLmyvMcTJN27kmSLgRkr5z7kXsEIZbLwp0RgVcjz1eF1MY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760807412; c=relaxed/simple;
	bh=bLYRU3WoeL89tTaQ3m/O69kxhMDwd4HvrS1JHCJDQIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XKe6AcSn9FjYCNWRYnOQ3sTRSBV9AYb5WKJC9G/v12g3iYKRYUtFtTFT9znQ9suj2IdzbV/S8EEPisL+NA5o2vkoOIrr04EImQo5TPKgwcR9vIAQQD1sLl9mgNd6AGPpEM4CnImo4YNh9ukLlgy4zjLF6kblJaF13cumtUG60OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=josie.lol; spf=pass smtp.mailfrom=josie.lol; dkim=pass (2048-bit key) header.d=josie.lol header.i=@josie.lol header.b=WzBI4rFx; arc=none smtp.client-ip=136.175.108.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=josie.lol
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=josie.lol
Received: from filter006.mxroute.com ([140.82.40.27] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta25.mxroute.com (ZoneMTA) with ESMTPSA id 199f8481138000c217.006
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sat, 18 Oct 2025 17:04:56 +0000
X-Zone-Loop: e87fdb5eed0366ace24c3eb8bfc3c4fbee8d214f855f
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=josie.lol;
	s=x; h=Content-Transfer-Encoding:MIME-Version:Date:Subject:Cc:To:From:Sender:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References;
	bh=RMXTb0TY3KLzvpj/5GiiYWJ/BKvw9XvuCO3jYEcFf2I=; b=WzBI4rFxiGzJTT5HdREkAMs6dy
	9W5P5Zj1K8wOCeyZabzNXOBwTCQL7L7fwQw/vAi+kzpqYaw6dMEyy/U9l4yTFJxLcIX7jOx3Jz1Db
	AuJAso0lqHkWqIZ2wW04yHeDtYGvX1bARjHZxrkz5lfDxvkH4tnQV9UL3DTkXT4kx8x/idy3JxTxk
	pq+AoLONfyvSvZdKucZmemWuzJFgkPVw7ufplbzzb9+RB8e55cKOzxXqNHcM2LteklmugSBIqevn2
	lknAn5SwIx7tNq83GKtYbtRNIuhm8F2e1IVZfffIIxXO6REf7vAgLqbLJlJlqW5BMxDWPFUpEzJpr
	jjA+GODA==;
From: Josephine Pfeiffer <hi@josie.lol>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: alex@ghiti.fr,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] riscv: ptdump: use seq_puts() in pt_dump_seq_puts() macro
Date: Sat, 18 Oct 2025 19:04:51 +0200
Message-ID: <20251018170451.3355496-1-hi@josie.lol>
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

The macro is used in ptdump.c:301 to output a newline character. Using
seq_printf() adds unnecessary overhead for format string parsing when
outputting this constant string.

This bug was introduced in commit 59c4da8640cc ("riscv: Add support to
dump the kernel page tables") in 2020, which copied the implementation
pattern from other architectures that had the same bug.

Fixes: 59c4da8640cc ("riscv: Add support to dump the kernel page tables")
Signed-off-by: Josephine Pfeiffer <hi@josie.lol>
---
 arch/riscv/mm/ptdump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
index 3b51690cc876..34299c2b231f 100644
--- a/arch/riscv/mm/ptdump.c
+++ b/arch/riscv/mm/ptdump.c
@@ -21,7 +21,7 @@
 #define pt_dump_seq_puts(m, fmt)	\
 ({					\
 	if (m)				\
-		seq_printf(m, fmt);	\
+		seq_puts(m, fmt);	\
 })
 
 /*
-- 
2.51.1.dirty


