Return-Path: <linux-kernel+bounces-898431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A3CC5545D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8C02F346CE8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 01:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E59029AB11;
	Thu, 13 Nov 2025 01:39:17 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0610296BB7;
	Thu, 13 Nov 2025 01:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762997957; cv=none; b=eU1KK/IHoUPspa/VyzEiUtsj93Tk/t0lyGlOjOzFXCwHeeDPkwfQQXeyiCMscIZFjpwqCJP8XXX54uG2TjvSSdQaH4rdym4UzsX3K4eRazwlIVWzuXtSZemDHIOlRote94gJLQvqmkhQxT9ubIbXqmzNOqzLBX6TPDSdmDw+PXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762997957; c=relaxed/simple;
	bh=JygIpOvdjkfAndQJfh4E4L0cPtNT12MMpZX4gntrBFQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f3HppIgxmzdzjsDg6+9swN2+zxknTZRtMkllMo6YFpWYV0unpYXcZ8AfZMhdraK3ijCHexEQN54OEn05pV2kLtiMI300YICv+y+D+eLNLVsVV8wkmoCFuRlb5+j3PRKJCKmrfIR6lm2qTmDgtamAhztTeBOdLoqJeQEJyduzCuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005152DT.eswin.cn (unknown [10.12.96.41])
	by app2 (Coremail) with SMTP id TQJkCgBXmay5NhVpTCt7AA--.40662S2;
	Thu, 13 Nov 2025 09:39:06 +0800 (CST)
From: dongxuyang@eswincomputing.com
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	troy.mitchell@linux.dev,
	bmasney@redhat.com
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	huangyifeng@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	Xuyang Dong <dongxuyang@eswincomputing.com>
Subject: [PATCH v8 3/3] MAINTAINERS: Add entry for ESWIN EIC7700 clock driver
Date: Thu, 13 Nov 2025 09:39:02 +0800
Message-Id: <20251113013902.1277-1-dongxuyang@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
In-Reply-To: <20251113013637.1109-1-dongxuyang@eswincomputing.com>
References: <20251113013637.1109-1-dongxuyang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgBXmay5NhVpTCt7AA--.40662S2
X-Coremail-Antispam: 1UD129KBjvdXoWruF4UZF4rGw13AFW5CrW5Awb_yoWDJFc_Gr
	4xCayxXFyrWF4ak3ykZF93JFyYkw4xJr4jganFkw4av34jvr1DKFWDXwn2vw47Gr43GryU
	WFyrKF9FgF17ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbhAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r1q6r43MxkIecxEwVCm-wCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1U
	MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I
	8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOEfODUUUU
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/

From: Xuyang Dong <dongxuyang@eswincomputing.com>

Add Yifeng Huang and myself as maintainer of ESWIN EIC7700 clock driver.

Signed-off-by: Xuyang Dong <dongxuyang@eswincomputing.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ddecf1ef3bed..61f9f77385fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9246,6 +9246,14 @@ T:	git https://github.com/eswincomputing/linux-next.git
 F:	Documentation/devicetree/bindings/riscv/eswin.yaml
 F:	arch/riscv/boot/dts/eswin/
 
+ESWIN EIC7700 CLOCK DRIVER
+M:	Xuyang Dong <dongxuyang@eswincomputing.com>
+M:	Yifeng Huang <huangyifeng@eswincomputing.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/clock/eswin,eic7700-clock.yaml
+F:	drivers/clk/eswin/
+F:	include/dt-bindings/clock/eswin,eic7700-clock.h
+
 ET131X NETWORK DRIVER
 M:	Mark Einon <mark.einon@gmail.com>
 S:	Odd Fixes
-- 
2.43.0


