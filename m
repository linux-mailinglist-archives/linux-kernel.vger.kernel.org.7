Return-Path: <linux-kernel+bounces-889910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC66C3ECFB
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 08:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C183A34B21D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 07:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62E029AAFA;
	Fri,  7 Nov 2025 07:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="e9m/WST6"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF08171C9
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 07:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762501673; cv=none; b=RxxLlsqBEPL1OwkPE9TEk4mjyOUv5gQ1/IwsXc4Anq+hsGf/e/Jue+TxEWEWK9TXCRGceWugj6KmH+NVnIHMo/796uG+WfhY+nhhmegynwYuAK0GcABKoUR86kWP/IjfoFeCUpdLz1+E4YSgx7cwkwAV5sUVSduvM9pvMMKPi5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762501673; c=relaxed/simple;
	bh=025IzmbW4Wc3EeyOm9XQcrgIQYgzrZ8MDSsacAZRxIc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U6pVj7slxgIASpAGLdZ2Cns4fltXLdAFm2yxaNnCxxT9SjLnSPgzVFAdr6SPKoULJja4kP+ySF55h1fXVQY0y7FwlPGfE3cG77SgeAyRZpV/CiGMP2Unuh0z4WBeSKQWZpSeVB2ZkcgfaDEvbNLlT0mEWnd7zpVQKv6ohqV9mfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=e9m/WST6; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=wi
	3bgEDBM9Uf2jfHLmZUkwbG/cbmvBsTkTYC1hpNh4E=; b=e9m/WST6SKohWJPqdS
	1HFoatsGC7dbsAknkD93KO98WXtsbyvHhEb/z3HPrLcCLVwqF76GoRhjvuDA0zHk
	GmAlj8Frzy8RK2D926QDGO3oEjQNw7w/UvFy+pJtzQeLqqjBQkKtYleO45CbRdMX
	wm7a9xzni6bE9n8kYk7+0EyWg=
Received: from thinkpadx13gen2i.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDnDyIZpA1pQvUtCQ--.60818S2;
	Fri, 07 Nov 2025 15:47:39 +0800 (CST)
From: Zongmin Zhou <min_halo@163.com>
To: david.e.box@linux.intel.com,
	linux-kernel@vger.kernel.org
Cc: Zongmin Zhou <zhouzongmin@kylinos.cn>
Subject: [RESEND PATCH] tools/arch/x86/intel_sdsi: Fix memory leak when No command specified
Date: Fri,  7 Nov 2025 15:47:36 +0800
Message-Id: <20251107074736.35550-1-min_halo@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnDyIZpA1pQvUtCQ--.60818S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF48WFy7ZrW7Cw1rWw4rXwb_yoW3XFX_uF
	13Ww48CryrtFWrXFnYyr4S9rnavasrGFZ5Ary7Jw13Aa4IyF13GFWDA34UXrZY9a1qg3y3
	Aay3XryrAF4akjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjXAwDUUUUU==
X-CM-SenderInfo: pplqsxxdorqiywtou0bp/1tbixxf+q2kNWyrvuwABsF

From: Zongmin Zhou <zhouzongmin@kylinos.cn>

Just give devno and don't specified the command,return -1 on
default case directly can result to memory leak.

Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>
---
 tools/arch/x86/intel_sdsi/intel_sdsi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c b/tools/arch/x86/intel_sdsi/intel_sdsi.c
index 766a5d26f534..dcdb88c21134 100644
--- a/tools/arch/x86/intel_sdsi/intel_sdsi.c
+++ b/tools/arch/x86/intel_sdsi/intel_sdsi.c
@@ -856,7 +856,8 @@ int main(int argc, char *argv[])
 			break;
 		default:
 			fprintf(stderr, "No command specified\n");
-			return -1;
+			ret = -1;
+			break;
 		}
 
 		sdsi_free_dev(s);
-- 
2.34.1


