Return-Path: <linux-kernel+bounces-844665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E033BC2742
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 20:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1965318991F7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 18:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984D82EA46F;
	Tue,  7 Oct 2025 18:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PP2BNvKF"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DF12E9EC2
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 18:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759863348; cv=none; b=k51a5OMcC8pOBQdKPx6S6MyY41bklCZzLSlQ/heWHvVhIf7ligN/RvKIjPfuzwuzuqRL+jiukwvDfej4JTqlOvq05ggjsg2djcgUx539jnoUI0LOB2wcWplDSM85mv+49FyGCmTyLrM88ZU8VxtCrGmbdHGpYy3PRIo6GX+lix0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759863348; c=relaxed/simple;
	bh=L9zt2+mYIjZagYVVaj6OPHVn0B0rNs3RIPv8NtxcOPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gGxWHno9KIkr8NqlOBoGGNaYq78CvXbiL/+emmo9H0cTSVOgy04cy4ke/gB0A2wGIizL/3evaO2qg2J6oRtK9m9fSwKY2y+MHv3z54EKUvcCA00ScEHqcXC4sqHsAYzRtM5hWbCPQgFRGhxL+uDOHP0/pf1Nl+RWXNNnSv8dvRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PP2BNvKF; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b62fcddfa21so2094782a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 11:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759863347; x=1760468147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YEHJ86/7N3GoML0TX8U7iEmW2mKzHnR6gQNQcuV/G5Y=;
        b=PP2BNvKFj5gX6YhSJsPFuSSJNTvmLp3+TfvXC7KdFLq30aSCsG3MTporEK3E5UTB7j
         3BIndZGFzF+2Li7lbjN1JJ0kOFFCx5DKO2Rf0y4qGwbFfFpFOuxKoo3Zbva8DVeUluWa
         zHMx9U7kMbDlubajnTdzpyaOhu/47cBFRMU5KiMxq1ludhjfZCe6dk4j3Ed0yBjKzRFK
         6uPkNL0SI1qs+jaO4i2ple7VN/gY12LD9qx3Ib+0scFDrT+SFvM7GMULBxvmm9buZ7e2
         qzGCVxgN7LHT6ZIfhuo7i+FO2CIhlO5PXBAH/wbVZPnLwbIgAuhMb3fPYOCN66O0BSIv
         SsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759863347; x=1760468147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YEHJ86/7N3GoML0TX8U7iEmW2mKzHnR6gQNQcuV/G5Y=;
        b=SJFSioyZ8eP1QawSX6nmjIrXAMMDAEbK31hQ2pHplpbLxx+47XcY85mV4Tmyy827Eh
         EnQw5NqWBybkjZmVIDe60FszyFGw5W0uaOlRfzCFyITD2RNyJIwpHDw7hViG3NgFvM4H
         rmwakQQykiG0GKKNyhTzAitY10LW12tUnROmSlJLvyeu9BHgklPzCjtPeE92Ez0ZHeE4
         13Wn5LvNElkv1nl69GFVpU2xPDXaA7QPFF5S/EIHcy9TQ1ts3Hxiy3sI95ZYyDCX97dk
         mQ8Fgj5ifFjCzwMY62ANQoy1ATOg0qQoXy0weP3z45fw37GrjA5aDRQFTnoidgYJDShk
         S4Uw==
X-Forwarded-Encrypted: i=1; AJvYcCUsHFYnlwN9ljQHXE5pUKGSNigI1mDaNNkmJH41E8QnT55rF15JIZrq4EUTGQEshiTpQDnwCPZuLUuE8T0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVLD8NFsoXNF28Pv4hlRZrQKghWvAPRudh7h+e6J6M2QnrpP+e
	B1oZR7elxPo7J9xeC5wfQk8QmZFp8DYaSGUpeeXjO5tqZJuWFHBvz8oo
X-Gm-Gg: ASbGncvDT5CYa07dSKd71CzBwcIOHmojjxp3HlKlRv8laUtJktClgPugBMclO8wqF29
	K3wB588lDhy0NnpCtVL3ALUuMKe9oB3rjGGBXUQdMIXZZqYrE+44s5d6Hus98ezHWc9WBnB32Pd
	M5iyrVVsQTs0JERGVftEHL53C/s7jauPXaF4O+RcN3AxMHrzuwHfTp5oxexNzJWs84so53+kgRN
	2Z0Ka+fHEfUUwq9fdtEneC5ttYc3M62YkjiJz+YV5nHMueI6Wy+abP40UcLsUxSFhzLP4voiGro
	CZytbQE/KBpj37DMzhNu7imESicwH8slwp9xH2604x5hkdSaQBlHEj2qB63rGRhdjFQCMyLnz8O
	tFrarYSz+9oka9iLQkkC1t3W8YkDuaQ0bBF2TqLH/itC66yBSx9TcZIgvMsdIWBndkQ==
X-Google-Smtp-Source: AGHT+IFtTvflDnDVga6tSkVQUnvou1LUWOf9MCJHjvLvWiRbsFrn5VG8YDKujN10eze6W/WhgJGaUQ==
X-Received: by 2002:a17:903:19e5:b0:27e:ef35:2dbf with SMTP id d9443c01a7336-290272c1c46mr8620475ad.30.1759863346715;
        Tue, 07 Oct 2025 11:55:46 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d110cdfsm173529655ad.13.2025.10.07.11.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 11:55:46 -0700 (PDT)
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: rostedt@goodmis.org,
	corbet@lwn.net
Cc: Gopi Krishna Menon <krishnagopi487@gmail.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	crwood@redhat.com,
	tglozar@redhat.com,
	costa.shul@redhat.com,
	jkacur@redhat.com,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 3/8] Documentation/rtla: rename common_osnoise_description.rst
Date: Wed,  8 Oct 2025 00:24:52 +0530
Message-ID: <20251007185508.40908-4-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007185508.40908-1-krishnagopi487@gmail.com>
References: <aOUMyGvkibvOV0IS@archie.me>
 <20251007185508.40908-1-krishnagopi487@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

common_osnoise_description.rst is intended to be included by other rtla
documents and is not meant to be built as a standalone document.

Rename common_osnoise_description.rst to common_osnoise_description.txt
to maintain consistency with other common_*.txt files and prevent Sphinx
from building it as a standalone document. Update all include references
accordingly.

Suggested-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---
 ...n_osnoise_description.rst => common_osnoise_description.txt} | 0
 Documentation/tools/rtla/rtla-osnoise-hist.rst                  | 2 +-
 Documentation/tools/rtla/rtla-osnoise-top.rst                   | 2 +-
 Documentation/tools/rtla/rtla-osnoise.rst                       | 2 +-
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename Documentation/tools/rtla/{common_osnoise_description.rst => common_osnoise_description.txt} (100%)

diff --git a/Documentation/tools/rtla/common_osnoise_description.rst b/Documentation/tools/rtla/common_osnoise_description.txt
similarity index 100%
rename from Documentation/tools/rtla/common_osnoise_description.rst
rename to Documentation/tools/rtla/common_osnoise_description.txt
diff --git a/Documentation/tools/rtla/rtla-osnoise-hist.rst b/Documentation/tools/rtla/rtla-osnoise-hist.rst
index a39285817566..55616085275e 100644
--- a/Documentation/tools/rtla/rtla-osnoise-hist.rst
+++ b/Documentation/tools/rtla/rtla-osnoise-hist.rst
@@ -15,7 +15,7 @@ SYNOPSIS
 
 DESCRIPTION
 ===========
-.. include:: common_osnoise_description.rst
+.. include:: common_osnoise_description.txt
 
 The **rtla osnoise hist** tool collects all **osnoise:sample_threshold**
 occurrence in a histogram, displaying the results in a user-friendly way.
diff --git a/Documentation/tools/rtla/rtla-osnoise-top.rst b/Documentation/tools/rtla/rtla-osnoise-top.rst
index 58321322d24e..ea0e9f5a5c0a 100644
--- a/Documentation/tools/rtla/rtla-osnoise-top.rst
+++ b/Documentation/tools/rtla/rtla-osnoise-top.rst
@@ -15,7 +15,7 @@ SYNOPSIS
 
 DESCRIPTION
 ===========
-.. include:: common_osnoise_description.rst
+.. include:: common_osnoise_description.txt
 
 **rtla osnoise top** collects the periodic summary from the *osnoise* tracer,
 including the counters of the occurrence of the interference source,
diff --git a/Documentation/tools/rtla/rtla-osnoise.rst b/Documentation/tools/rtla/rtla-osnoise.rst
index 997a981fe397..540d2bf6c152 100644
--- a/Documentation/tools/rtla/rtla-osnoise.rst
+++ b/Documentation/tools/rtla/rtla-osnoise.rst
@@ -14,7 +14,7 @@ SYNOPSIS
 DESCRIPTION
 ===========
 
-.. include:: common_osnoise_description.rst
+.. include:: common_osnoise_description.txt
 
 The *osnoise* tracer outputs information in two ways. It periodically prints
 a summary of the noise of the operating system, including the counters of
-- 
2.43.0


