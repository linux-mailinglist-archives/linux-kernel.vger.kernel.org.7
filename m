Return-Path: <linux-kernel+bounces-643966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A59EAB3538
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 12:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18F8C3A6656
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 10:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE52267B07;
	Mon, 12 May 2025 10:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YdYZzuz4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YwdcdbzB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA212673AB;
	Mon, 12 May 2025 10:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747047077; cv=none; b=YVZP7Wf70q1n5eNoseqw/8dhBHCqSEBQv2SCiJoZsR6FMDjMHmcKxFkTumFWSVs8JLMgFcUmt17ShVTqObalLpxFu57R5fVo7NL5PN2/Z/eOqSc83R8AVW7yn+B8q7bkMxVhDo5q+rGDhttgDNbP5RAAlOzxURKBLkwNjxW9TRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747047077; c=relaxed/simple;
	bh=9REGFnfyFOEyIjAE1cjJKsPFnrPKw4O7e9wg4waN3vU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gf7jx9qLvILNX49yBmMZWOpLV2etWri0JrGWm3oqTToHYj9TXW6XEwRXMJ2qnUCXtRYyjqd09SKJw1CX3GTLncwWaIZlhpTOHJ16OKA8aH76UV9VpVfW18cKj4T5iPuMPkafjzDufRctR88ydu0fOqnGmsnt2aR3SAxLfEC5Wjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YdYZzuz4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YwdcdbzB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747047074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9REGFnfyFOEyIjAE1cjJKsPFnrPKw4O7e9wg4waN3vU=;
	b=YdYZzuz4bpmuOAWJWNP0q7MekR/kKBBegmvJckCbPhh8paQ+Y5NpjduLkro30Qyv+8ozAT
	MmFtx3hWDGkzyAff7+5bLO0rNzOAZYHB3Xhu88nQLAjw2JQVJrVfAStINXcPAgYV6VxT01
	rsWLGjPLZZqv3a26t3INpIthkj9x2E2xqpltZMvADW7So5m+LJyHRSjUwtRmL0Rf2VqLUr
	VVfPJyMwRejRfXJlglB9BLOgZNvx10xDhkraFen2or5OxE1dxJKIwK9hUJZZe85oLIKVSx
	xyJtEMLlFISycmmMu7RrIKYCx+tS61KUa2Ox3LOKQT1HzsZAGPbuh5A+R/eS8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747047074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9REGFnfyFOEyIjAE1cjJKsPFnrPKw4O7e9wg4waN3vU=;
	b=YwdcdbzBhr+mVJVIRQOWjnormGWazKqKa9WpZHGWQSaNu+/E8lk7bcMKPb62cEoyqlKgBB
	NAJZLTtqloc19UCg==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v8 01/22] rv: Add #undef TRACE_INCLUDE_FILE
Date: Mon, 12 May 2025 12:50:44 +0200
Message-Id: <805abc4add788ca15bbf98e6cb7c59948290a273.1747046848.git.namcao@linutronix.de>
In-Reply-To: <cover.1747046848.git.namcao@linutronix.de>
References: <cover.1747046848.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Without "#undef TRACE_INCLUDE_FILE", there could be a build error due to
TRACE_INCLUDE_FILE being redefined. Therefore add it.

Also fix a typo while at it.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 kernel/trace/rv/rv_trace.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
index 422b75f58891..99c3801616d4 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -129,8 +129,9 @@ DECLARE_EVENT_CLASS(error_da_monitor_id,
 #endif /* CONFIG_DA_MON_EVENTS_ID */
 #endif /* _TRACE_RV_H */
=20
-/* This part ust be outside protection */
+/* This part must be outside protection */
 #undef TRACE_INCLUDE_PATH
 #define TRACE_INCLUDE_PATH .
+#undef TRACE_INCLUDE_FILE
 #define TRACE_INCLUDE_FILE rv_trace
 #include <trace/define_trace.h>
--=20
2.39.5


