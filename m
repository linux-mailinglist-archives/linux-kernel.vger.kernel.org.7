Return-Path: <linux-kernel+bounces-897409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C459C52E89
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A6F97501949
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF0032C95D;
	Wed, 12 Nov 2025 14:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VjOBoLyf"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72642BF3C5;
	Wed, 12 Nov 2025 14:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958247; cv=none; b=T/r81w68MLXofGmROnyIevKTp5TCOm8JTG9PdYX4+L/mZPBvcyvGiKxjOoTGkglI8gHa93fc8q4j3gxcAM2aVzctLtFX2RFOth0oGM7KSYwW1u3Mmtgq9994GY88nUvZ/ajTrfVxTx2soNvMe4YOUf861olSEE3ptKfppWDPFmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958247; c=relaxed/simple;
	bh=2rN9cVOLQNBOCiMXSgtkSdhDPfGsitN4aJw2gBuh2bY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r88xCTMH1Ys/BomqSjV31dg51N+lo3aIzPDCy1bHDH+bD3XpiDELD7v7YYTxyictWQMCnRsSkyrlqXksGLP44yS2FBw6QG49AyB3C82E4RfD8Z8BaYrfoEV9LdWvRsoUcwebwMEsndqYDDTu4TNfGup3gk8n97nC2iVyo0Tlf/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VjOBoLyf; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762958241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ltyZ37LEJwhrSuuGnHe4IRgod3HGjI74kx98i9cMA80=;
	b=VjOBoLyfYylZG7PBMU03hQSIvcAZQVGfkc5kp0F3Sof37/OS4sFMu/hjb6+SLRxOcchROT
	FptiCz+YYndoCd+nL7SoPVpY+GeKqaT1nDEnKmREh/s6/9y1S4wcRpao6XLViWrqgR0Ptt
	lrw/Y2W4XTIAZ1BmYWRjb5VJh4JYMwY=
From: Yuntao Wang <yuntao.wang@linux.dev>
To: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Catalin Marinas <catalin.marinas@arm.com>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	James Morse <james.morse@arm.com>,
	Chen Zhou <chenzhou10@huawei.com>,
	Baoquan He <bhe@redhat.com>,
	Zhen Lei <thunder.leizhen@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Alexander Graf <graf@amazon.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuntao Wang <yuntao.wang@linux.dev>
Subject: [PATCH 01/10] of/fdt: Introduce dt_root_addr_size_cells() and dt_root_addr_size_bytes()
Date: Wed, 12 Nov 2025 22:35:11 +0800
Message-ID: <20251112143520.233870-2-yuntao.wang@linux.dev>
In-Reply-To: <20251112143520.233870-1-yuntao.wang@linux.dev>
References: <20251112143520.233870-1-yuntao.wang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Currently, many places use the result of the expression
`(dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32)` for various
checks.

To improve code maintainability and reduce the chance of errors, extract
this expression into two helper functions.

Signed-off-by: Yuntao Wang <yuntao.wang@linux.dev>
---
 include/linux/of_fdt.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index b8d6c0c20876..9ce2433865ae 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -30,6 +30,17 @@ extern void *of_fdt_unflatten_tree(const unsigned long *blob,
 /* TBD: Temporary export of fdt globals - remove when code fully merged */
 extern int __initdata dt_root_addr_cells;
 extern int __initdata dt_root_size_cells;
+
+static inline int dt_root_addr_size_cells(void)
+{
+	return dt_root_addr_cells + dt_root_size_cells;
+}
+
+static inline int dt_root_addr_size_bytes(void)
+{
+	return dt_root_addr_size_cells() * sizeof(__be32);
+}
+
 extern void *initial_boot_params;
 extern phys_addr_t initial_boot_params_pa;
 
-- 
2.51.0


