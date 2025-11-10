Return-Path: <linux-kernel+bounces-893118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB48C468E6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7437F4EBD47
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAB130DD35;
	Mon, 10 Nov 2025 12:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ct+faKxR"
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59AA30CDA1
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762777098; cv=none; b=NeDOK4xqHQuleJW6Jj+BD/3IXyL7O6aQN46VR6HudacOrJUa6T3hjp5zH+7rxz8eBu6ibUDPRLXNtTVsH54D+r+G5N6J5UMzbVqMYpTr2wtq9x8KcpmvqTOikmIEbOxN/13k88ABUvpmFRKGZntLo2mddkWRVhdowj0cuZpLr9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762777098; c=relaxed/simple;
	bh=yiAV/fd/N37LsByBzQjNfuQsL1HCbFqYPib3ufTbct8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LYtnYGLqvlAqRl/qm/HTuDcwMDpeVDTtAu3Dd3l4fi6XJs4Iyz9QCuRUTpcUZNoOitzNhRd6NZVGI55aeJKZj38NytGz3L78xnPHZyLQ0aa81B7QLj8yXiY8tvoNgITyzaUwXhGbYPdfQNgwO/ZO5SRcBsG3rkRO3o9iZf5/x6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ct+faKxR; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2964d616df7so37807965ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 04:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762777096; x=1763381896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3js87s4uRJTX6J5wR1Akhgx1Ub9JhRGdk0bxXqN53yk=;
        b=Ct+faKxRDJuIZwIEukLItMP2Mfn4BESSr9u2UTnHure2YaRykmtcGApHGvaQpLDCUM
         WQUxLJzPOXS2089W+CmFeTvVV3YLtmVZyK9ljWwTPqmQ+ld6ZvtpKpmkmOcEMz8sfVGf
         Y0ropQijuqAt7AShED6pb1vxec3jLLIJ2gjTr7R/f8aXhjJNPg8Z/VjD/DQv0p14GNI0
         yNqATBFUnLHuiRJuboA+cip3kF1z/SV7RLNpTjVG9rYKi7ZJNmyzvL7NcTCfh77XGkO1
         ivcHtymR9SmfdXlkGkkjQrBerKAJt8OJsg1fs24VdkjNJL7PDUPkB1mlApzeLC8SlDHT
         9izg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762777096; x=1763381896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3js87s4uRJTX6J5wR1Akhgx1Ub9JhRGdk0bxXqN53yk=;
        b=OP3iUkWYPYaYZ/ZXhe9dakPNnVSVVWlUnIPkzSM3GnRCL6ehD1fSrqTP4otozopUDj
         L8r/m+lpjM++k/5PyNvmXWM0rfOl1hbDnbJV/XrFIDDQ/dFPALU5IMbgRuYKrSt4EoDk
         zd1OwlKD0bLQITAwtKFLJ+pMMALW3AaojK8BlxrNKbHmrbPJbfglA7f745amlwxb1Yax
         zgBGq65HJuIwv7E7EWu3aF7kcmMdYZzl2V/JA4xwYF0pZQd3Uved8NsqSiql9CKr5CPd
         4I+X/am9ZIhG9T8xUYUq2dlbvTjXoTSZhkWzAZIQ4uiCYayniAbP8hueCNELThbuVyMc
         TbcA==
X-Forwarded-Encrypted: i=1; AJvYcCWtKgPwMMx+uO9YGYyK7Pm8vsKYst25TYsOaXFJFNY/isnrCAi+D19Hg/JYtgnMuJveangwa3GxDW1CXfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZMkzp82cm8lLlU4c1VV61LJrHts2Hj5OWcz/bcbLJ1HgZ7SAs
	PHVX6F9TbDpyaObJF8rfwqvrzkHfX5fWQM5dFETYBLf22kc8B5a+icEHswIUK5gneUY=
X-Gm-Gg: ASbGncvl5opO+MTWQOB9FYOKfgFjwF+p0OvKg2Yg2cQNawTF00o7JbOIOBSkqMnEjIs
	kHj/wrzC2B7agF2l8bEEunnNwMMp/d6c5vB5MZw4+Mx5e/AzdR0pg2E4pFLJqOPKygzQsbvoMSL
	G8my/SlthKzvwTq9KG2uxqBmjdfDRQOMdrTYR0Xw194LHreC3Q35/ePvBxFVfBl6yaW7+wqBuiV
	hWscti18pQNW+vGkiQLlcUIU3VADA2hziz3p6PPFs9/r/OzrR8aM3VA7/2wnC87hgJfVxGoYo1E
	f9LvDEPLO995KEO7Hr3Lm6UCfifL5ZMvdkX1uZiP2Y+qMsTN9KRd1bjVoUhFfQmdTqs+N9Xs9o/
	VxNyDIjyFDBEX00jRhGZRNB0+r67+YVlPCC/Dp0UgYUbAaZo9zPv6PzeGAPD/z9zqTfRKpjtoLZ
	AHjvju7Idjtl8Kpi5BcF+gaA==
X-Google-Smtp-Source: AGHT+IEPwrYX6YCYhn6Q9zCx3HRfyuBq/4dWxpo0SHeeQsQ3hYDLG1ZkKZZn3/tm4vviI6ZKMPZscA==
X-Received: by 2002:a17:903:1450:b0:298:2cdf:56c8 with SMTP id d9443c01a7336-2982cdf5987mr23147225ad.60.1762777095893;
        Mon, 10 Nov 2025 04:18:15 -0800 (PST)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c8f2b3sm147271785ad.76.2025.11.10.04.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 04:18:15 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: rostedt@goodmis.org,
	jolsa@redhat.com
Cc: mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH] ftrace: avoid redundant initialization in register_ftrace_direct
Date: Mon, 10 Nov 2025 20:18:08 +0800
Message-ID: <20251110121808.1559240-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The FTRACE_OPS_FL_INITIALIZED flag is cleared in register_ftrace_direct,
which can make it initialized by ftrace_ops_init() even if it is already
initialized. It seems that there is no big deal here, but let's still fix
it.

Fixes: f64dd4627ec6 ("ftrace: Add multi direct register/unregister interface")
Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 kernel/trace/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 42bd2ba68a82..efb5ce32298f 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6043,7 +6043,7 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 	new_hash = NULL;
 
 	ops->func = call_direct_funcs;
-	ops->flags = MULTI_FLAGS;
+	ops->flags |= MULTI_FLAGS;
 	ops->trampoline = FTRACE_REGS_ADDR;
 	ops->direct_call = addr;
 
-- 
2.51.2


