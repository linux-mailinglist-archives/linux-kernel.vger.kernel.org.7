Return-Path: <linux-kernel+bounces-880458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D129C25CBF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7920188824E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D9825C802;
	Fri, 31 Oct 2025 15:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8o20q1Z"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A64225A2DE
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 15:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761923546; cv=none; b=E+SkBt9lIjurnrDioU3sVBdRvojXiJ6XGnZzPhbebjCfno4MX+YwuPE2TmAGlnPAS80nllrm2KOR2KsHT2JhygyRkyxhUaT26NTng6V3wp48KG5XcurkzqQHElG72nFzVPLu4xNS7AEqSxReo3pI3tDf/jW4P8ZVbhBp8KNDOf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761923546; c=relaxed/simple;
	bh=91kxninMOJuDZGlQ785bNKkAwCmu72JTeQOT5NZzEjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MlJV8aq/t35ZMeDr8wGQHQe2ci2Cyt3HsIrXD7HJ9qpmRaANMLUvtOgFLtlJR850sT35RF+cIJj7X8gvGe9mrAaRdF3uiIH3Rwdak2bgHbqgXBZ5XezRoc5Z7xCRAggdlEySyakummogfKa3hRCH9YuFG36xa/lxQaILpB4nbwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8o20q1Z; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-378e8d10494so23017571fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761923542; x=1762528342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FX+GUEAbTZu0XdxLl+sLP6JXHQTyzMeCDlR6Th/SyyQ=;
        b=G8o20q1ZhofSL1tSlGA0r8lCKnVdU6BfMluaTYExS3GR2zUtGQgKvEWs5EF7iKhGba
         fClj7Md/99KXE8xZLtaHLFRmGHEJBCntXLor1c3uipNPrbJ6UiZYMvN8jiqV1lZlpEIc
         IRt9xAnlCyyhv+diLVZVJB+2icb0DZ03zL9HKvciwJHvDFZcWbXkcWWz6F1QcX/aNhJW
         RPm210t+qokuNAjsV6oMek39qCiZ+yBD9t5x6ULZU505rkHh1s8Za9T9x8J5koMh2N/y
         Cauc8SROP7sDLnmwoEFN8MSOdmJPftyN0RCFi1XjfrXi0OAtfwVyBCQPvSE1PLPoMd7F
         DfhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761923542; x=1762528342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FX+GUEAbTZu0XdxLl+sLP6JXHQTyzMeCDlR6Th/SyyQ=;
        b=g3npPYTU/wHPyowDkK50RcMVNQllbn/HrvduO0zdgXAPrJY0u77Wbu5fR5A5/jTdnv
         rrJY+ZEcAf9f0I8Qsn7nFue8t8OvzQfGKVjMMo+Iqw2adftOmwzYNWASu01KPaaqmZSr
         urxTRNVLlImeffshd305uuqM7pAZn4E7sYGQ5BITJ/UHvW/26JBCzUSwMw5iTPrPsKob
         fix9DvwORqyIfvEleT4akEUVA6+BhT2FhksI1lDod6RR8ov2vPEmwLFi3+qKXbfj8N8i
         eCv9bGllkyw0+Cq8AzHCCKQcDMYvMe6h9o/cbMSqbzlks0WwZrtq3TQRAkadPZ46SonB
         1zgA==
X-Gm-Message-State: AOJu0YwPxgv8tobcqO2yUO3UNTEYBqYorvq/mSagCTby6IukjT6SS91Q
	Gdv+KzB4xmGxRL3JKY783I00dmyIQhFAzsIf+AEcTxfwaL4zuC/L6AxBgbaxBZnc
X-Gm-Gg: ASbGncs7VcfAtjk2cPre+V7Ri/rw20ObgcZovtbimRqkZrrvE8jk0C9NlDTqcy2Zqsr
	59b6iEetu/wDu51u1MOZY+QdW2TKDwUfaZc+dq3Wgm8JCr7U7MGIsiCZIKjj2P9mNGq0weqqsNd
	g+6MiR++aZN3JSPtXHcvgiYrUIkDS7D6KU5cJB9uGtPLHS4kutvdWUSFIkTtckLHo4yvaa/nzEC
	U0C0WKaiWlzQv2tlp+g8tSedtCF/Oz8e+NN5wFCBOMwYnrV/OFYuohoq4GoXZiuz6MXcy6ubnbC
	AAt6fJDFDqVhI1PijUY1bVvfIvkzTAXJRVFh3CTXFy8STyKBr+kAtfUy9JroKm/oAMem3pmZJ43
	gSll+Qu/x1bOaFohxqsUcak3rUUHvDy22DPBGt/lTL3/kP22tbnuvhlidYaOWUaJ0ruzsuD5b0A
	==
X-Google-Smtp-Source: AGHT+IGKbvonzx5y7ZgpL89fkDF2JVwXxKaHQ/ejt1OdBE6Ff68ddmi04P4EWTQqdMDYjNDgQ/iG9g==
X-Received: by 2002:a05:6512:3b1e:b0:564:2556:5bb8 with SMTP id 2adb3069b0e04-5941d53ee64mr1240323e87.37.1761923541591;
        Fri, 31 Oct 2025 08:12:21 -0700 (PDT)
Received: from archlinux ([109.234.31.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5941f5bbf47sm569710e87.82.2025.10.31.08.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 08:12:20 -0700 (PDT)
From: pgnmirror <vacacax16@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: pgnmirror <vacacax16@gmail.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	linux-perf-users@vger.kernel.org,
	zntsproj <vseokaktusah7@gmail.com>
Subject: [PATCH v2] tools/perf/tests/make: use IS_64_BIT for generic lib dir
Date: Fri, 31 Oct 2025 18:11:14 +0300
Message-ID: <20251031151114.5642-1-vacacax16@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the IS_64_BIT flag to set the lib directory generically for all architectures.
Previously, this logic was hardcoded for x86/x86_64 only.

Signed-off-by: zntsproj <vseokaktusah7@gmail.com>
---
 tools/perf/tests/make | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index b650ce886..64066e011 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -53,9 +53,8 @@ endif
 
 include $(srctree)/tools/scripts/Makefile.arch
 
-# FIXME looks like x86 is the only arch running tests ;-)
-# we need some IS_(32/64) flag to make this generic
-ifeq ($(ARCH)$(IS_64_BIT), x861)
+# use IS_64_BIT to select lib/lib64 generically for all architectures
+ifeq ($(IS_64_BIT), 1)
 lib = lib64
 else
 lib = lib
-- 
2.51.2


