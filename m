Return-Path: <linux-kernel+bounces-764000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FF8B21CBC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 07:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5979718877AB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 05:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598B12C21CA;
	Tue, 12 Aug 2025 05:07:59 +0000 (UTC)
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328901A9FA6;
	Tue, 12 Aug 2025 05:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754975279; cv=none; b=YNL1V5fjVBYsFJjNoQM8qT83e+4+e5hCBet+2EYal5MbfjBKyzElr1DyudZEh80gBsERIV/3vlGyVzL75XwZOlSpFQIRp1YgW76soHM9ORIZwgvFADSthHX4ShCR8Mvb/hEjY8zJkkz9Qn6mxKLC0GH3salJvgrxNmNohsXhMmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754975279; c=relaxed/simple;
	bh=10+O5604qlxvSutID6a/mGeuyisqpxtE4eEmXYjsZSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=usV5Ul7SPDt1+uOhP/9aNPPlD5ZexgMPCIVmqgGJKv9UdpBuw7WMC5n08zNMIHa4mFYUMeeq4nwE7ZhPPUlz4uLWyyhLrWYsl1xg4TvoeJqmX/uHiEAMbOoxeq1p9EPM6u3YJFhltO2ELST7qoad3F70wCHbeKdiNGT+2Ctfsio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.52])
	by app2 (Coremail) with SMTP id HwEQrAAnLqYHzJpoR7UmAA--.858S2;
	Tue, 12 Aug 2025 13:07:19 +0800 (CST)
Received: from pride-PowerEdge-R740.. (unknown [222.20.126.129])
	by gateway (Coremail) with SMTP id _____wCXgJoBzJpo1LbVAQ--.40495S2;
	Tue, 12 Aug 2025 13:07:14 +0800 (CST)
From: Dongliang Mu <dzm91@hust.edu.cn>
To: corbet@lwn.net
Cc: linux-doc@vger.kernel.org,
	alexs@kernel.org,
	si.yanteng@linux.dev,
	dzm91@hust.edu.cn,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: add File entry for scripts/checktransupdate.py to DOCUMENTATION
Date: Tue, 12 Aug 2025 13:07:10 +0800
Message-ID: <20250812050711.2515173-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HwEQrAAnLqYHzJpoR7UmAA--.858S2
Authentication-Results: app2; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvdXoWrtr4DJFW8Gr1rXrWDKr45Jrb_yoW3WFgEyr
	nrtFWIgFykGF17tr4kGasxJr4avr1xXrW8Xan8Jay3AasrKrZxKF9xKas7Cw13WryfurZ7
	ZasxXr9xGr4avjkaLaAFLSUrUUUU8b8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbv8YjsxI4VWxJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI
	8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2
	z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2kKe7AKxVWUXV
	WUAwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AI
	YIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VACjcxG62k0Y48FwI0_Gr
	1j6F4UJwAv7VCjz48v1sIEY20_GFW3Jr1UJwAv7VCY1x0262k0Y48FwI0_Gr1j6F4UJwAm
	72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l42xK82
	IY6x8ErcxFaVAv8VW8uFyUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
	6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU0X_-JUUUUU==
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/

As suggested by Nathan, add a File entry for scripts/checktransupdate.py
to the DOCUMENTATION section to maintain this script.

Link: https://lore.kernel.org/all/20250811212446.GA924610@ax162/

Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe168477caa4..b7e3a8c8832e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7302,6 +7302,7 @@ P:	Documentation/doc-guide/maintainer-profile.rst
 T:	git git://git.lwn.net/linux.git docs-next
 F:	Documentation/
 F:	scripts/check-variable-fonts.sh
+F:	scripts/checktransupdate.py
 F:	scripts/documentation-file-ref-check
 F:	scripts/get_abi.py
 F:	scripts/kernel-doc*
-- 
2.43.0


