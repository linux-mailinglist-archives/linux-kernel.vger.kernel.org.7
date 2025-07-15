Return-Path: <linux-kernel+bounces-731307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA2BB0527C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B2AF3A987E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156812550CF;
	Tue, 15 Jul 2025 07:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MuFLMb/8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211FA26FA62
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752563706; cv=none; b=fLkcws8fiIYdjoXOkqWmJGXyF7b45nobHtyF2Yh9adCm0xEhxz5cbHnJtWurZkJtNHgkQtU9UUT+32Hw5MjSIALtlz6JffIBPzQIdriyypR1ee45Cw8oLNIaP/zFF4dOigF5paB03tQ0hSl857GlS/HnaNz56mRAtmql1n6k1vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752563706; c=relaxed/simple;
	bh=R4rMR1/LBoP5QyQkec+H91+Abp3jWUPV/y9CWuKvXw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ltZTYCLOp5/q5Gl1o9VSTC4+P/Vayj+XcVFu2mUrHbShgZt24W96FfzXb0cfCisuvYcY8SKsJtq8Vk9gcsZRqr1XPmYt4tSzoa8p/VFx7vJMgs/KPZTQJ8tg41rknLsINxKyPP6eD7O6z0lPyFxTmPnP1BAyW/7jLNSgrSgoh58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MuFLMb/8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752563702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ugNoQXCbqoiLLEt6/qUSKF55w8XG71cY+EEtg+02qSs=;
	b=MuFLMb/8hJ1pcopRAw1OxJ5CmbBfyd8frMH33aQ5L60AH0lD0yqn45ylAuR+Qd/RwLWFC5
	V8RMgwllUz9Z0xetTt+4d1icjY/4AiLXphrOt4dovRL4L3ZoJ4ZV6LGvhXrjVN4Cm1KPIs
	RtTR4q+QreRwoEBRmEt44NRG5Z4XMME=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-wxGbJGZBMUO5gJLH2HDD6A-1; Tue,
 15 Jul 2025 03:15:00 -0400
X-MC-Unique: wxGbJGZBMUO5gJLH2HDD6A-1
X-Mimecast-MFC-AGG-ID: wxGbJGZBMUO5gJLH2HDD6A_1752563699
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 127991800289;
	Tue, 15 Jul 2025 07:14:59 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.224.115])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 90855180045B;
	Tue, 15 Jul 2025 07:14:53 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Nam Cao <namcao@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v3 01/17] tools/rv: Do not skip idle in trace
Date: Tue, 15 Jul 2025 09:14:18 +0200
Message-ID: <20250715071434.22508-2-gmonaco@redhat.com>
In-Reply-To: <20250715071434.22508-1-gmonaco@redhat.com>
References: <20250715071434.22508-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Currently, the userspace RV tool skips trace events triggered by the RV
tool itself, this can be changed by passing the parameter -s, which sets
the variable config_my_pid to 0 (instead of the tool's PID).
The current condition for per-task monitors (config_has_id) does not
check that config_my_pid isn't 0 to skip. In case we pass -s, we show
events triggered by RV but don't show those triggered by idle (PID 0).

Fix the condition to account this scenario.

Fixes: 6d60f89691fc ("tools/rv: Add in-kernel monitor interface")
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rv/src/in_kernel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/verification/rv/src/in_kernel.c b/tools/verification/rv/src/in_kernel.c
index c0dcee795c0de..72b03bae021cd 100644
--- a/tools/verification/rv/src/in_kernel.c
+++ b/tools/verification/rv/src/in_kernel.c
@@ -429,7 +429,7 @@ ikm_event_handler(struct trace_seq *s, struct tep_record *record,
 
 	tep_get_common_field_val(s, trace_event, "common_pid", record, &pid, 1);
 
-	if (config_has_id && (config_my_pid == id))
+	if (config_my_pid && config_has_id && (config_my_pid == id))
 		return 0;
 	else if (config_my_pid && (config_my_pid == pid))
 		return 0;
-- 
2.50.1


