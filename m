Return-Path: <linux-kernel+bounces-892034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C20F6C4427C
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 17:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 36CFD4E4CF5
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 16:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0673303C9C;
	Sun,  9 Nov 2025 16:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZjgQ5Bhx"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4D6303C81
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 16:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762706224; cv=none; b=rvgbSsKT94QV0Rk+axso2qsY+hERS6CdmH+LdOr/U3vFYVnrhdRpbStuz8Yujt2PNA3kDqcUZBAKFTFWCbZvM6qhk+P6V27F7Meqjg/d140R8BHU2FsvCrAau6ceo+S+FGKkqDISk4EBMYo+KnekD8rgSxUQL66Jfdi3yDtQNXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762706224; c=relaxed/simple;
	bh=zMlAgK7Vfadh2JGekv30Yi3HICQKbllq6IxAioW86y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BioTRaF8MMZ1z8bCwWvTcKGlFEnSJWPTlQ3X715xoKYpD+KjX1lWRU+9F4HcmhBbAjBO99JibkRsKm8bPk4WtU+i+c2a1w0tYEn7g9wf1PyxSe130p+5nboedRHTKFCwao7g4Ga3ymyqeuMcMZu4r9T+JNncaGYIrXNmoc9Fwm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZjgQ5Bhx; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762706209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5VAP3oB7GpBydxTF8/qJglhhf0NNtnfVJXegyQuiKgU=;
	b=ZjgQ5BhxFucJEi1DMFumNdX6jv1H42gt1f0a+84UtwSVFkPt/iBQjj4bGfwmj7LtoDI8kj
	W5xjz0CYwmOGcypnCZ/TbSodB7A5OjbwEYntS2Qhptp9SmZvZLlfqAiF2lPut9Yofb9TmT
	HJ/wb9HsLzGVXp5Yd8jQ4iHZmx2D9BU=
From: Tao Chen <chen.dylane@linux.dev>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next v5 2/3] perf: Add atomic operation in get_recursion_context
Date: Mon, 10 Nov 2025 00:35:58 +0800
Message-ID: <20251109163559.4102849-3-chen.dylane@linux.dev>
In-Reply-To: <20251109163559.4102849-1-chen.dylane@linux.dev>
References: <20251109163559.4102849-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From BPF side, preemption usually is enabled. Yonghong said, it is
possible that both tasks (at process level) may reach right before
"recursion[rctx]++;". In such cases, both tasks will be able to get
buffer and this is not right.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/events/internal.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index d9cc5708309..684bde972ba 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -214,12 +214,9 @@ static inline int get_recursion_context(u8 *recursion)
 {
 	unsigned char rctx = interrupt_context_level();
 
-	if (recursion[rctx])
+	if (cmpxchg(&recursion[rctx], 0, 1) != 0)
 		return -1;
 
-	recursion[rctx]++;
-	barrier();
-
 	return rctx;
 }
 
-- 
2.48.1


