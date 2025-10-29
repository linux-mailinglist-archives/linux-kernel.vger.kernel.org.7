Return-Path: <linux-kernel+bounces-875315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A5CC18AC9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F360B46269E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C35314B62;
	Wed, 29 Oct 2025 07:19:24 +0000 (UTC)
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253433101B8
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761722364; cv=none; b=dv4tBcnpOzuRS03R9MQOgZ7f8HcaNhHB4W3ytfnQV7xOnbNOU7Kzfke4Dk8s2PTk+T1fcHwoTalK7gBd6M7JLMe6G/AUFBoxEwS49xMtCXe89L/IktVA/iIrR1tvHsuYGkssCvC1OSWgGY0xf1oZZcytErZ3o9yoezr637zNdrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761722364; c=relaxed/simple;
	bh=ZHQCUGP5vwOFaRy0YlmIz5/pr+pYYAckZb1zci6Jq4k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gGbpmqyP11V/KgtIvmom4r3w3CCT6mQ1PbWT8oBiVkmv3+RVTCmn7CgO7lRBVA3jSHUzhFEf8E6cAp/C7F3jdqH6lFt8oJb0xqwpJkTJZAApKrcAdQo798hdjkHWYEGdE98Zm13QBzIhiumpvPzjjjL7R1G+ZlJhPQoSG8XRcMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201623.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202510291519137869;
        Wed, 29 Oct 2025 15:19:13 +0800
Received: from jtjnmail201626.home.langchao.com (10.100.2.36) by
 jtjnmail201623.home.langchao.com (10.100.2.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 29 Oct 2025 15:19:13 +0800
Received: from jtjnmailAR01.home.langchao.com (10.100.2.42) by
 jtjnmail201626.home.langchao.com (10.100.2.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 29 Oct 2025 15:19:13 +0800
Received: from inspur.com (10.100.2.113) by jtjnmailAR01.home.langchao.com
 (10.100.2.42) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 29 Oct 2025 15:19:13 +0800
Received: from localhost.localdomain.com (unknown [10.94.19.60])
	by app9 (Coremail) with SMTP id cQJkCsDwlHjwvwFppzgHAA--.5619S2;
	Wed, 29 Oct 2025 15:19:13 +0800 (CST)
From: Bo Liu <liubo03@inspur.com>
To: <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
	<alexander.deucher@amd.com>, <christian.koenig@amd.com>, <airlied@gmail.com>,
	<simona@ffwll.ch>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, Bo Liu <liubo03@inspur.com>
Subject: [PATCH] drm/amd/display: Fix double word in comments
Date: Wed, 29 Oct 2025 15:19:11 +0800
Message-ID: <20251029071911.17786-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cQJkCsDwlHjwvwFppzgHAA--.5619S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4xCw18ZFWxJF15Cw4Uurg_yoW8Gr1rp3
	yDKrWYq398GF17t39rWF1DWayag398WFy3t3s5CwsxCa1UJrWxXwn7uw1YkrWUCFWFyF1Y
	yr98CFWrWFyqyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26rxl
	6s0DM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbCPfPUUUUU==
X-CM-SenderInfo: xolxu0iqt6x0hvsx2hhfrp/
X-CM-DELIVERINFO: =?B?SVELsmLVRuiwy3Lqe5bb/wL3YD0Z3+qys2oM3YyJaJDj+48qHwuUARU7xYOAI0q1Re
	KIpedjRVREeXrKp2GVcC1+hy8UA3v4YLioUy1QX4XtPbugOBkHUbSmiG4iRGoNFPrkYiqq
	TaRnPrDe8agINCvjjdQ=
Content-Type: text/plain
tUid: 202510291519133de33ef3a36d45fee600a25e63dee77a
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Remove the repeated word "the" in comments.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 .../dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index f809c4073b43..4287f9d22f3d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -5624,7 +5624,7 @@ static bool CalculatePrefetchSchedule(struct dml2_core_internal_scratch *scratch
 			// vs the latency based number
 
 			// prefetch_bw1: VM + 2*R0 + SW
-			// so prefetch_bw1 will have enough bw to transfer the necessary data within Tpre_rounded - Tno_bw (Tpre is the the worst-case latency based time to fetch the data)
+			// so prefetch_bw1 will have enough bw to transfer the necessary data within Tpre_rounded - Tno_bw (Tpre is the worst-case latency based time to fetch the data)
 			// here is to make sure equ bw wont be more agressive than the latency-based requirement.
 			// check vm time >= vm_trips
 			// check r0 time >= r0_trips
-- 
2.31.1


