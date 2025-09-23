Return-Path: <linux-kernel+bounces-829424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92861B97117
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1CCE19C5F0E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC45D285040;
	Tue, 23 Sep 2025 17:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgnwIqd5"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B081F280A20
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 17:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758649409; cv=none; b=sRS4a/lyjHsQVLSrPN3ugSWBlrfjnEFagIn30KPDQ6zn1qKuvWO4UvonGi0CxWa4hdaf0zkKJs+U8nc2cQ8mMBFZW0tGsSzpHuw0buqeV3Igx4/Wd4f2rZnVutFlLFmsd8HZKtJ8R10/hlKsycp/RI9qJIStpCjf+5ZtRc09jQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758649409; c=relaxed/simple;
	bh=TBydUlaZwvjaoiWXQNjwVx4nHU3n7XPX1BEYGfUeY7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SRqp8nwKamBMR3z6N13nPu63e3civ4UL8aZbbGN8LA3Xnw8kRcJWDWI0Ikx+t1sRURwAsBGpA0wswAKUaaYdn1TWcok6NzYhA1pKnDx3JK1NjIJY1cBhTgIoB9ShsvuCFcdNA3zeXer7z3hPtSdXohZaOwCQRKzpAHie2eh4iqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dgnwIqd5; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b5516ee0b0bso3239584a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 10:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758649407; x=1759254207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=12Psv0L7KGLemGCvbz5saQeHawW9GRBxiy9osVzP4Fc=;
        b=dgnwIqd5tQQFOwAxJIjv5aJUCnX3QDolOWplSTEitXAZF4l5ZQaAFezo80E9sslJms
         FGmZBDmxuGFAGJWUbTS1L4d0+eSushVx+6v2/puY1f1cRdmwFz9uruinD0vzv3uS5ind
         eRzzufSc0blTnnqGOyOeG8eclAKOvU4WSGm+QdAe2VHohX2Af9RpNI2I0NJ4sOm1x1nr
         ks9fDMG3U8YPZRn4gRYZbMfFJY8JMYpMIsT1khA6eEg+mE7PE6I8cVn8JL8jKBRYOdC+
         GmUnNvuuS0CnbUD1Yc/VDLOqBtBqsP1YO2z214BABOxWmO2JWLSHxDKpUiSFDZoqWqEO
         yYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758649407; x=1759254207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=12Psv0L7KGLemGCvbz5saQeHawW9GRBxiy9osVzP4Fc=;
        b=t+AATYfJsGa+8ZddaNVji3JpgOYEqXL/qJlvbbsae/e0C6okj7QSvhUsLKklKX0kOP
         nqJP9dECk6MbrFcVB6ADYRIMbVHeJcYjnzQnkqIVrxPg/+D1EX/xWmIzWYTeUoA/J2NZ
         W5WOWvQsi3aEnPkqiMdR9lqj9KYNzAXYjss1SIPm/eJ7BC3NsnpkpymoGauLlXFeWCEL
         po/XF5zPBShKJ3D52sYST83Fz6XgWodBc1YEo61PVv6xyCXp65+nMGy3qt4M+VnacLzL
         1sjLAUZFkmxIuwkVrcJ7Ma8WYLShX+QC3xjItmrWIqzsXS/y6NAXopJjHqIxPPMa8x2s
         XPuA==
X-Gm-Message-State: AOJu0YyzfdK1JUj86Ww+Hs7ULDN+UQxPYGPpnFR5otaixJ4axiYR2yYB
	b5DYj7C7Gvgdx7QmHPKwfgCy0DDhhSMc2wyPfliiVGmtLCiCwc8o8Vqd
X-Gm-Gg: ASbGncv9qNHPUdR2X1RlpLgi96VdT9WiOXLHqWQFTVbLEF+V6E0RoBZmZ5xiglqnFeP
	Z+EuOP4t5RY0bHegC15EgBxRf+TQIyaTzou5ZEJM6B9mHHf8PTHy4oCrjoDy9r199bC3XAcQDAt
	7qK02tOhyocf0trCYygg5kBVXFNl/rYWNQ/Bu20j9nq9yG0G8FhToZTtj4ti5dsWcFVj1aVZxf2
	cPdZV/xjh4gmed2DPJcVGoWpupiyUOoGf/zbraRIRwgt5IjOCvjFOiIZ5qE9zsnLkzR7vJQYIsI
	G+llfxw/aUciJcufGWwEfvKVf/oSyhjxYQT+/z6r/R3DevIjcOlrZvPJ0dPPmwVUoqmSf5+2Fpi
	1/f1mBo9RHNykQEG9mTrcp/yndDzgQs0=
X-Google-Smtp-Source: AGHT+IGHCtQSXDsLg+/XpjGWOyQYA66vNcWGwDZNAlzZTqpJwx4fxepOvpgiWPPekyfcQ3iavGr2cA==
X-Received: by 2002:a17:90b:4c02:b0:32e:59e7:c37f with SMTP id 98e67ed59e1d1-332a92da740mr4865746a91.12.1758649406858;
        Tue, 23 Sep 2025 10:43:26 -0700 (PDT)
Received: from archlinux ([205.254.163.16])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3303ffe611csm18562321a91.9.2025.09.23.10.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 10:43:26 -0700 (PDT)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Subject: [PATCH] perf/annotate: Use architecture-agnostic register limit
Date: Tue, 23 Sep 2025 23:12:36 +0530
Message-ID: <20250923174236.12372-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the arch-specific guard around TYPE_STATE_MAX_REGS and define it
as 32 for all architectures. The architecture that perf is built on may
not match the architecture that produced the perf.data file, so relying
on __powerpc__ or similar is fragile. Using 32 as a fixed upper bound is
safe since it is greater than the previous maximum of 16.
Add a comment to clarify that TYPE_STATE_MAX_REGS is an arch-independent
maximum rather than a build-time choice.

Suggested-by: Ian Rogers <irogers@google.com>
Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
---
 tools/perf/util/annotate-data.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index 541fee1a5f0a..1f76885facb0 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -189,12 +189,15 @@ struct type_state_stack {
 	u8 kind;
 };
 
-/* FIXME: This should be arch-dependent */
-#ifdef __powerpc__
+/*
+ * Maximum number of registers tracked in type_state.
+ *
+ * This limit must cover all supported architectures, since perf
+ * may analyze perf.data files generated on systems with a different
+ * register set. Use 32 as a safe upper bound instead of relying on
+ * build-arch specific values.
+ */
 #define TYPE_STATE_MAX_REGS  32
-#else
-#define TYPE_STATE_MAX_REGS  16
-#endif
 
 /*
  * State table to maintain type info in each register and stack location.
-- 
2.51.0


