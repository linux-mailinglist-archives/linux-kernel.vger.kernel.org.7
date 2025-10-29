Return-Path: <linux-kernel+bounces-875305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D9995C18A6F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A8FE54E6CCE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FE83112AD;
	Wed, 29 Oct 2025 07:16:48 +0000 (UTC)
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCAA30E82B
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761722208; cv=none; b=MnGMH/ZsfzQmcZy5AXYJcRykOPFKk9iOKq5smq43Jcbs0yGN9MXdUBxjD3IPLC9waPDHRVXOba9Z/hD56dgmU7gJwRhV3QfKdy1JKLNOvj+bGAuppY6Z+cnapu2WQIbX2QP82c1/r5QGTT34RIMlsKKq25+V9h6S79gwTRp2t7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761722208; c=relaxed/simple;
	bh=mg9rW5YybuFCwFgED3s/yW/Cb0Tm4ADzukKVUuMGIQk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WF3GalgK4NEae13b157+3LmUUydVKhdkuoh7lNBvJuUPJKDWKzHETuhta7FzEirmuOMst6j1PgJ9OAdMFqzTaEtcqk3w86BeLiNlAL5gtffEZghmH0WQ+ONYthCM0zfFAewPIuCVIk/pYOVINozii2D+aGlWKucpiYftBcXOib0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201620.home.langchao.com
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id 202510291516302169;
        Wed, 29 Oct 2025 15:16:30 +0800
Received: from jtjnmailAR01.home.langchao.com (10.100.2.42) by
 jtjnmail201620.home.langchao.com (10.100.2.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 29 Oct 2025 15:16:31 +0800
Received: from inspur.com (10.100.2.113) by jtjnmailAR01.home.langchao.com
 (10.100.2.42) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 29 Oct 2025 15:16:31 +0800
Received: from localhost.localdomain.com (unknown [10.94.19.60])
	by app9 (Coremail) with SMTP id cQJkCsDwSHlOvwFpVTgHAA--.5675S2;
	Wed, 29 Oct 2025 15:16:31 +0800 (CST)
From: Bo Liu <liubo03@inspur.com>
To: <w.d.hubbs@gmail.com>, <chris@the-brannons.com>, <kirk@reisers.ca>,
	<samuel.thibault@ens-lyon.org>
CC: <speakup@linux-speakup.org>, <linux-kernel@vger.kernel.org>, Bo Liu
	<liubo03@inspur.com>
Subject: [PATCH] Accessiblity: speakup_soft: Fix double word in comments
Date: Wed, 29 Oct 2025 15:16:29 +0800
Message-ID: <20251029071629.17705-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cQJkCsDwSHlOvwFpVTgHAA--.5675S2
X-Coremail-Antispam: 1UD129KBjvdXoWruw4DZF17WF18uw1fAw17GFg_yoWfXrb_Ca
	47Can7Jw15CaykKFnru3WavFy3Kw409rn3ZFsagF93Cw1fXF45JF4kZr45urnrGw4xG3yS
	yF1kt3ZxAw12qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbV8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_GcCE
	3s1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v
	4I1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvj
	DU0xZFpf9x0JUvg4fUUUUU=
X-CM-SenderInfo: xolxu0iqt6x0hvsx2hhfrp/
X-CM-DELIVERINFO: =?B?lP6CiWLVRuiwy3Lqe5bb/wL3YD0Z3+qys2oM3YyJaJDj+48qHwuUARU7xYOAI0q1Re
	KIpSUJw1l9uuIZu3aTmRbkRE1t64R219fJMxPZFuCSaG1Tie7FPIg2ZrFnj2byLPgBcgtG
	3laTFx1GhazC5gRBQJk=
Content-Type: text/plain
tUid: 202510291516313e6a65ea56c1cafe5cf06482fd7a8bb8
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Remove the repeated word "the" in comments.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/accessibility/speakup/speakup_soft.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accessibility/speakup/speakup_soft.c b/drivers/accessibility/speakup/speakup_soft.c
index 6d446824677b..6549bfb96e7f 100644
--- a/drivers/accessibility/speakup/speakup_soft.c
+++ b/drivers/accessibility/speakup/speakup_soft.c
@@ -446,7 +446,7 @@ static int softsynth_adjust(struct spk_synth *synth, struct st_var_header *var)
 	if (var->var_id != PUNC_LEVEL)
 		return 0;
 
-	/* We want to set the the speech synthesis punctuation level
+	/* We want to set the speech synthesis punctuation level
 	 * accordingly, so it properly tunes speaking A_PUNC characters */
 	var_data = var->data;
 	if (!var_data)
-- 
2.31.1


