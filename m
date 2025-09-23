Return-Path: <linux-kernel+bounces-829364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BD8B96E33
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 18:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AFF6321115
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3FC329F06;
	Tue, 23 Sep 2025 16:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fgyMez20"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C1A3294EE
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 16:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758646762; cv=none; b=YpyK/wVbGn+h4r8dEiOmquwz06eTiQfkPnG0riKe1BTNjGInhAWmZuldKv3Owi2QdV89Aoz30UnqfPsNBzdeunMYat1MmFY59Cmrk7d0RWe3HMHpZHBARYu+081lznHntIKCY8+d3/yE04kFYThGOKeSj26VreI41t3gXGMeKcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758646762; c=relaxed/simple;
	bh=YJlkXO/ZITWmEi69lauof1/RW6YMbUVumNSLKe5TqAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gE9VyfWcWap3uzgDczfNfQXIT3Z97Xhuipz6HlruqndNPDKvLIp4I7wrW4z4c2Cv2cksbRcKN83CQ46yf6Q13F7z8WtB0qEaqFBq/OwXDNXeuYLwe8bfZ2PP6fqjddUg+uO60kyzeWVr2S5Lknwt8AHmsQz6BXrpyTHPSEh7sFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fgyMez20; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46b7bf21fceso29369515e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758646758; x=1759251558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TVJ0iQtlBKSgYr2iZSN1ZuLASEInLOEHg7PGBAMqWac=;
        b=fgyMez20JRLSwWcli1Jk0ROBACIZjvnWelepnpaDUT2/0QfaA/I+/GLmQ3ICQH89Fa
         cBIDizXdDuTbheA/BMS6DQym7S3U4I0hPT223ewd5rtWoMSHLM2hqsGmYikSQnpSJpfU
         EuLUKqI4YXOFIRDJMqjIR2sgujj2pwQEImN80E9lly+tTwjwaHoSQ9QpJBazd3AEqgZq
         DS8E986kKLRTfFf9Yn5+pgoRUTDBnc/cUt5ftnNcmr4aT8oU3VULdnpqYysHdTIbMwz9
         C2emB0FWIDYSMHHEW0aMCnTvT86Bm4hAyS2GinO1tg92whWJM9g3Jd1SyEGuI8s1RS09
         SUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758646758; x=1759251558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TVJ0iQtlBKSgYr2iZSN1ZuLASEInLOEHg7PGBAMqWac=;
        b=fUlko0T0nqjtV6hoF1nVZSCmYrZ3ztZ0Qj0kZy7oCXN3AFaOgpmn6yX3RWS1hslLtU
         DTVxjXCw7YIeyJiMn9AzoahN+ELXvmEseAVosYOFEA1ilIKh1+cNxUPxa6fLlNknZvyD
         I8zoGbWMUzK/xC43wbmM0hT58r/qKPbONXTt1eI2/Xs3ZG71v1irqZbl47zw/LG/eVw6
         iF1ZsAslrySMZ3wdVALe/uZ0Gr/QA3Bh1KXLiTpLuwHEcY0/NAeVMEHzU/J+o6G/1H8d
         V2jIBor+QexNecgtlXC9sd15TjD3q0QoEyVg7ERuZWg2fuYjswnuWCUJAy/rc9VUvWha
         xLlQ==
X-Gm-Message-State: AOJu0Yzx073iV/94G5B51HgBi3U/sHuj+bhBskX72v9CZuXGVf7hXTwV
	I7fLAsTPEr9SRq5o6wfqP4hv4oUAd8R37NTjD4hNueyLHGKi/A13hwQg+myC0HkWq+ZK23oZ9i8
	i3J9O
X-Gm-Gg: ASbGnctgEWt3XoZZ1YL5Tr+m1u/c7xojEziL8ga7kJzge/pnvF2yF76PzF5TAkb43/4
	4qV8mf4RjwjRoQUN6ldZ942+eUEhCL/PVsgFBFqZ4SSTOdvGEdRfyLEKI7NjPmc2mzcAS2O6Dca
	9AunnamhlLdlUhoWUw3o8Bn5CTYBx/VzTGBYovjBkDY7dZSThvI6yEvn8tWPGfGheW/AYE+lICo
	KUnL1DHZeN1Qvw8meCcgznMsZa0Ng+m4bt3tmgUc5rmf17U5vUMLOq8gA7t6cVXfh41iN0IaEMS
	wvQAzBwr5PXXaEVceMEWNiqZXu+cAQuwea5APIsgby9kLkJnXiPmIyPbiPMgdq6v4YhHrG8+j+h
	oTDpDaPGxbmkxVOAqYblRGQQj6X/o+BKRvJp+2InsARI=
X-Google-Smtp-Source: AGHT+IH6FsdRHwPLQobQ/I7blfetgrGu9IWl79+904uwLjysCfsJwBxPJRmS0Ytnh5dlEiMpfJnu3Q==
X-Received: by 2002:a05:600c:4515:b0:45c:4470:271c with SMTP id 5b1f17b1804b1-46e1daacdc1mr36741925e9.18.1758646758594;
        Tue, 23 Sep 2025 09:59:18 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f00cc58b91sm18616483f8f.1.2025.09.23.09.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 09:59:18 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] tracing: Ensure optimized hashing works
Date: Tue, 23 Sep 2025 18:59:07 +0200
Message-ID: <20250923165908.2399256-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If ever PID_MAX_DEFAULT changes, it must be compatible with tracing
hashmaps assumptions.

Link: https://lore.kernel.org/r/20240409110126.651e94cb@gandalf.local.home/
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/trace/trace_sched_switch.c | 2 ++
 1 file changed, 2 insertions(+)

Drive-by flushing an old idea. Take it or leave it.

diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sched_switch.c
index cb49f7279dc80..aabae7daaac91 100644
--- a/kernel/trace/trace_sched_switch.c
+++ b/kernel/trace/trace_sched_switch.c
@@ -243,6 +243,8 @@ int trace_create_savedcmd(void)
 int trace_save_cmdline(struct task_struct *tsk)
 {
 	unsigned tpid, idx;
+	/* so that map_pid_to_cmdline indexing is efficient */
+	BUILD_BUG_ON(!is_power_of_2(PID_MAX_DEFAULT));
 
 	/* treat recording of idle task as a success */
 	if (!tsk->pid)
-- 
2.51.0


