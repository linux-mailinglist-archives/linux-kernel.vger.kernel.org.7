Return-Path: <linux-kernel+bounces-854053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A9DBDD6F6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5AF71893967
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFE130170C;
	Wed, 15 Oct 2025 08:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FntKxp/g"
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F470301702
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 08:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760517166; cv=none; b=Sk4QvWepDNyaF4KI88TNj0c6GBeV7BJtXbD6VnZs0W7JpVOpAbur8uM1lfbAUOFak1PM5ePyyTvHHmjMOYxT5/JGYADKRzOyNl0KvoZEruJM9e9/EKtPqjr3snstMWYe53SuDvUKfcGLEXc2pctyR7KALL9RCpU7vm/LNJeP44U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760517166; c=relaxed/simple;
	bh=kvAL+9sXIpj3PTIh76IBr6613CVdujv2Xh7EGODtLbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=blXg02+5zxFZBOGpZ5tfLGCo1ycDiEyfQWiJTKZHmcylv4y4rvLtzz6I9kGwUE8XSJieuW5KVozlyhh6GXa7M63yt0Xlaa3bdZeLemC3svCS39UiZJBnxjFEuzqSswcy3FtHicu7OxpGbrZ2vgILjKn7kTLbQyP5XMFFCnbZtNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FntKxp/g; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-b556284db11so5504830a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 01:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760517164; x=1761121964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Unis2qMmhyRpJCDJ7RaN7XWgJDSIS/FlvH2xyG99SG0=;
        b=FntKxp/gGF3NefNxDDuFJ2EiS9UzPKiqd4eOiMC9lHxsy+pV15uDoFVjYQM+x9tQTq
         opCHTyfR4e8IaH6yqWyTloWUbGwuzj3E/ZsJ1s94P7NP0l3snm52eQn1UqEXHbwkl9K6
         tdgMxSFjZ92ARgTJ/TH8favI7P4UaVk1uyTsDoPoTwdVxYEU0BlZwYxBjO5j1D2aXKj+
         E7IHjzX/Gj84e3AUS2oy9r91tH63H2UFD20KzMAjM9a3CnuuiKE24fmke++tHj03BJOn
         FI1ySdFBEIboPhDjtMMMYkIVwzKyMj4lh3XiPjVDOvRLlz09vEPmudF1Pz4P7DZYCyed
         zAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760517164; x=1761121964;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Unis2qMmhyRpJCDJ7RaN7XWgJDSIS/FlvH2xyG99SG0=;
        b=uwKE7NNBsOpZnH9Cg59ZW2NYeKrzpKk7byuoztMlQrAWRAQoQKCMfQ0DRLGyAnGOJK
         g2Fc6H/KNbtBSaVVS0U3PSAj5nIwJ4G0rgEnkovyDm94IfHghRk89GyEYxTPjdeLcsfB
         M1qJGWpethAca1IiJ1rOmtzoYu8AdcGUwBCUfbZQg4tOueQCImKEPs0anmTgMXLoUaZJ
         EwNZ7QnaYsLcdZ3L2RmBxoIFLxXEmxCHKX78+vYdi2GvheztuPr5iXQCz0Dq9lNDKmas
         xY31V04Dl9v1tCH7L7rb2zpddvA9okTTE4DRkU3wkU1apzj8vj3Koe7X0olIGjlOrnjJ
         AbWw==
X-Forwarded-Encrypted: i=1; AJvYcCWUR3qBzSJi4yLdIyzTfAZymDhos/4UXO1EQDcI+k9ZIB++yD6AQplYu9s4Pr8oZZrizxNmYlPYBAfPcL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHMbFJaaJMdFkTHi25nREoR424VfMAjIs/jnXIWNCtDp+Zy1+h
	Fk9DGq5xCbeVp0Tm9fn/jXGVwqEuxCt1wOIsdZwFmitxNAGTF41uk15j
X-Gm-Gg: ASbGncsHZ6hjIgRiQQKYuI8IeE8zyPfgOG1+q32YlGYY3anJe94ie112EWvEnXfay5R
	ZWIg5nlbRPWyqv6xIqbRr4WXb3o4x/v3kzQjTRziIikJXdYpMFNJNkZ44UHUQOCsFHZAa1GSTeC
	vCZitHpiV3AqpZjCaAjXlGQWeME0j2CIIqN2FH1TTrAY/1yXeKttGbH27DFGj5c1NYDi+OCcwdx
	IBLu9AxHmTTL59VCosWCEHecYHO4zmMJPl8ZZN+BSdV0tP0jieL0p+YYry0gl88jY4/wqLWmkTh
	fcE5S54na1DRxfO+ApevBlPWAzVrSiZMOxRK8sAvW7Rwp0jxXs9aX2AKLyZZoDvdZyGovgdDslA
	v/E9DpkV7SfwqphoE8IRfGHbRVXQrDfwQKow0IdI1e2gALaj4RU0b
X-Google-Smtp-Source: AGHT+IFrfU5Dg0coLJWp8rp4JqP2mYICgRQA5oJXaWGO4H3aK9sZvSgQGPKaZ1Y+JB/GSbIA6x+KXw==
X-Received: by 2002:a17:903:1a87:b0:26c:2e56:ec27 with SMTP id d9443c01a7336-2902737495amr365673965ad.19.1760517164118;
        Wed, 15 Oct 2025 01:32:44 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f35e62sm188932455ad.88.2025.10.15.01.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 01:32:43 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] tracing: fprobe: optimization for entry only case
Date: Wed, 15 Oct 2025 16:32:36 +0800
Message-ID: <20251015083238.2374294-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The first patch is to optimize the fprobe for entry only case.
The second patch is to add testcase for mixed fprobe.

This series base on the "linux-trace" tree and "for-next" branch.

Changes since V3:
* fallback to fgraph if FTRACE_OPS_FL_SAVE_REGS not supported

Changes since V2:
* add some comment to the rcu_read_lock() in fprobe_ftrace_entry() in the
  1st patch

Changes since V1:
* merge the rename of fprobe_entry into one
* add some document for fprobe_fgraph_entry as Masami suggested
* use ftrace_test_recursion_trylock() in fprobe_ftrace_entry()
* add the testcase for mixed fprobe

Menglong Dong (2):
  tracing: fprobe: optimization for entry only case
  lib/test_fprobe: add testcase for mixed fprobe

 kernel/trace/fprobe.c   | 127 ++++++++++++++++++++++++++++++++++++----
 lib/tests/test_fprobe.c |  99 ++++++++++++++++++++++++++++++-
 2 files changed, 214 insertions(+), 12 deletions(-)

-- 
2.51.0


