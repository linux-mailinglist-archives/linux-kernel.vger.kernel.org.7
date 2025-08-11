Return-Path: <linux-kernel+bounces-761885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 522D0B1FFA1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 08:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E2DD3B019A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 06:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A612D878D;
	Mon, 11 Aug 2025 06:52:53 +0000 (UTC)
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F281E2D63ED
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 06:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754895173; cv=none; b=PJNkWqWfCwSeMdCsefjmDgd3o9FVYwF6ZAa3XfcEDygGQNZvFsqiY5LtBzJKgmDihoBcD6+Aac7HQ57Gomtj9lBYxTALuy8SGT3xD0sW3/pxmlMgZKApJXAi8KultPrbBqQhAJeSYWUmK4wlk+kkIxCL4rhEQ4xyxtre84SbVpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754895173; c=relaxed/simple;
	bh=A7fiIoRIM2hj0Kk8xKketx+1Pdjs454ZiRMz/trUCpY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KkKYn53xSIQN3q0VAE4XVlMPKHYiMQ6ll2a6AMBKH9Uegvpr8zJR19PUFwGjg6H4isbUKsUC+oEXjt6ymmjUwBA2LAQUoCWcXahIFXgeVu1v7ZJVKf0QPdEw9CF93TA0AbR6Vk+EOcEgcXX2Ir+EffYVzXI4dUfZsH9lz2U4p94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: Fushuai Wang <wangfushuai@baidu.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxppc-dev@lists.ozlabs.org>
CC: <frederic@kernel.org>, <christophe.leroy@csgroup.eu>, Fushuai Wang
	<wangfushuai@baidu.com>
Subject: [PATCH] soc/fsl/qbman: Use for_each_online_cpu() instead of for_each_cpu()
Date: Mon, 11 Aug 2025 14:52:16 +0800
Message-ID: <20250811065216.3320-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc8.internal.baidu.com (172.31.50.52) To
 bjhj-exc17.internal.baidu.com (172.31.4.15)
X-FEAS-Client-IP: 172.31.4.15
X-FE-Policy-ID: 52:10:53:SYSTEM

Replace the opencoded for_each_cpu(cpu, cpu_online_mask) loop with the
more readable and equivalent for_each_online_cpu(cpu) macro.

Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
 drivers/soc/fsl/qbman/qman_test_stash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qbman/qman_test_stash.c b/drivers/soc/fsl/qbman/qman_test_stash.c
index f4d3c2146f4f..6f7597950aa3 100644
--- a/drivers/soc/fsl/qbman/qman_test_stash.c
+++ b/drivers/soc/fsl/qbman/qman_test_stash.c
@@ -103,7 +103,7 @@ static int on_all_cpus(int (*fn)(void))
 {
 	int cpu;
 
-	for_each_cpu(cpu, cpu_online_mask) {
+	for_each_online_cpu(cpu) {
 		struct bstrap bstrap = {
 			.fn = fn,
 			.started = ATOMIC_INIT(0)
-- 
2.36.1


