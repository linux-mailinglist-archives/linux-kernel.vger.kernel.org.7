Return-Path: <linux-kernel+bounces-797633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D0AB412BD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 05:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D24661B637A1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 03:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC732D0C83;
	Wed,  3 Sep 2025 03:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mF4aqh+1"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7342D0638
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 03:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756868557; cv=none; b=JqmurCs2hpODmKomS99YYAQWOwzp20C/tQA7m0Bxc/lbA3FQ2PmN3r9ik45Sv2dwJfEqRhh75622FXL2HpqYZsXfCNxWJoHCDPTpK6Kg+p7Ry0v0niNFkqaLjVcWxRv7agxjRKIbRmW4LUprr55YGmP+4W39KfEQ8wHhf+onZhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756868557; c=relaxed/simple;
	bh=QUKo6e58SSJFQgr+/h0Hwp0bH0rAwKhcQAAdxn7j7xs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AvVaqzsyq+SrZO734KHG9KjH0H4sEDIwsSRid+qJBTwp+jEuwVUHC2eQ60OwhLmlkehEhA4Zo8H6TvKqXkdEMNlvoIPvhA9WvrWWCOOG5V6ysHJQ7aCYdie9MCdiAvOudmcY9YjW9jS/q/m7VJmsGoLI2gOvxC5z82jI7Fqi7Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mF4aqh+1; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756868554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cRynx6jaHBNziqdWwYMx6lpx2wd+0zdA8DgB67CZ52I=;
	b=mF4aqh+1V/7wCkaLaALq3wIS5h4V21NQrY/AN44J2nbOiurpql+JHY/6ILtCAnCC4aZxNi
	wwtqekrTRGXl1XrPjM8A1pQoESrS4M7YiC0YcXnvvoAMAefcCR/iUDDqd2atZR6mgfpGKk
	R6w0RZRIzYjiS4fpFUg6seR/coxRNmU=
From: Youling Tang <youling.tang@linux.dev>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Baoquan He <bhe@redhat.com>,
	Yao Zi <ziyao@disroot.org>,
	kexec@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH v4 7/7] LoongArch: Enable CONFIG_KEXEC_FILE
Date: Wed,  3 Sep 2025 11:01:00 +0800
Message-Id: <20250903030100.196744-8-youling.tang@linux.dev>
In-Reply-To: <20250903030100.196744-1-youling.tang@linux.dev>
References: <20250903030100.196744-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Youling Tang <tangyouling@kylinos.cn>

This patch enables config KEXEC_FILE by default in the
loongson3_defconfig, so that user-space tools like kexec-tools
can use the same as the default interface for kexec/kdump
on LoongArch.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 arch/loongarch/configs/loongson3_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/configs/loongson3_defconfig
index 34eaee0384c9..6cfea2f37cc0 100644
--- a/arch/loongarch/configs/loongson3_defconfig
+++ b/arch/loongarch/configs/loongson3_defconfig
@@ -45,6 +45,7 @@ CONFIG_EXPERT=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_PERF_EVENTS=y
 CONFIG_KEXEC=y
+CONFIG_KEXEC_FILE=y
 CONFIG_CRASH_DUMP=y
 CONFIG_LOONGARCH=y
 CONFIG_64BIT=y
-- 
2.43.0


