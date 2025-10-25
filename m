Return-Path: <linux-kernel+bounces-870058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F69C09C98
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 18:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 693643B955A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 16:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20A7315786;
	Sat, 25 Oct 2025 16:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aidmQ6Id"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53172314D2D
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 16:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761410469; cv=none; b=JIcnHjqs0yyKHWcSzChPKIbdXO4vtNDcllMV3Zmpo14UyCiLz+TyEdGy+HOzw0Frh1JcucEjtZwVFTPYzLd5WEkTq3MeV4J7anMIns96yBOGmQ2kdZ3HYMitFxuyZ3SRoxIgAYsw6hCbuU01cuzQOeu5wE4JXgMt7LlXjN68qd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761410469; c=relaxed/simple;
	bh=XhV4d6vVAyK94tJmHv/pzX7uso4PaLhZOAOHlwMKMkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TULMSAl2H/lmEHZTexyhsyxxhm0laoNuHKBYOYC4fbKNJe/mQjXzpidk2exbdVnwwHhe7Tu8e8efwh5unubfXENuYhXxXhF72HGYmwI0CI71ErcjZwHsYQsg54dtHhUebhIHBzG18BUTlEKdtA+mVS/kvWiFbPDmpsnxFakI86Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aidmQ6Id; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-78e4056623fso32594506d6.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 09:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761410466; x=1762015266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ehiUcUt6iLCen11Ncs28J2yHpJNhGkVkWPyWS3jNXxY=;
        b=aidmQ6Id21oJUCYTKFpnRu/3uu5cLBBKQfFHDg6UqHM+oQ3eIbMTasl4LFPnWNWWtb
         TIaRe7dD6hA5zNu1nztSmKMu/rU3YMMGJgv8b5YD98SHeTOelHmCuQKj7A1M8R5kyYiE
         yQXF2slqIhWD44xiLUEv/rQ023S1+ggrFQ54zucCz4vkMkqAl28fRLxX5urqY8m4ZRbw
         6+qMPY1XoSUrKpBx6Cg7GuEdLBYV6/VsSvynH8BJwRWsI0QMeTzsyy0vCBWLNU3Qz2VT
         lleVdUZyqpmqYsxhidB56+k6+/0FiKvBxcTpwzVqgV5pciVQhF2YmSs8MeW/Lrp5Yler
         FwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761410466; x=1762015266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ehiUcUt6iLCen11Ncs28J2yHpJNhGkVkWPyWS3jNXxY=;
        b=DfYaIHvgytsKxZiofzA3NfFw0rdGoQqyYpVyeF+GF0QFvWxe+xJqBcM4B5IIGZmjKv
         IEcOSvIa+cH/qGx2tUYSUYg7a37SKGPrgFBSw7UmKoWOq6xBYl9DzDErc/G0enbDd62e
         afZqrhstkJwoIPmUH5mKKE7iGCJJ1bQo3EI+xEEvBQyqqNCj9EMpiKvoYEBhCe8g/LVs
         /HvJOMGYt9S28Zxp43jXmNtEMDNwIwCvyeAhuBajVgozE1EGgKRNzAI61IMlofpzR/bi
         kDj1ml+3jGR08psBcliK4uYph9Lpj21qJSj61ZXKRydjAuqIswYHAc3LjFRWbV1TCUln
         IN8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXgG2wmwV/9CEPQ+SD7D7TSstUD/lYShVkFeqBX+jJdJ2nxdzWsGoEz2J3qn2wswkPJ0CxTBp8zZuin0MM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6a1hS05ky1IZv7p6Et1nu63SVBdtlFKv0t0tnHx/dFQmhSjG9
	6pgM8Z7jY496oF3f7OwZm5oN0hAtPuXZKoxro8dF0JGvUzbp2Z+HT8HY
X-Gm-Gg: ASbGnctEVwp3CDoneh6lyTLNiKp+rAWrefEHQznDaITca1Gd/NZwvvrZcRBfxdB6KjV
	vOtKyMXrmbLFQzyq0DpghbuUV4mFpbALXgT8CJcsmN/T3dicGk3l+bVtnHd4+crdrDdajsBbmhJ
	nzNO/eUCwwwi1K6F13PTkFhkCpFjZp/s2BktGGdJxwAd9iHKgErtbrIer/qVr5fxYsnYgSIh20t
	5BUQWJ/aDhRR3xVacrRgAGDZDqeKlK7Cv/PrFIJb9dmJ/p8IvZruRw3GXX6hQGFcVg/jLPzR1Vc
	1xMf4z/DY8ABLBnpTzywQhVUZKct8NwG5lK1rEiXTA4CWmTiV5R8CsOxk36pUWot6MxvLIiXs/L
	x81UxHxdURJD7knFGzcqge+P+GzOY3+p5Ftrc9S+0meFuFpbxQJFAoZTN/lQ644Nh9MAbut2K98
	grNkAo2rU=
X-Google-Smtp-Source: AGHT+IHdUbKQhz7684jsgoRDJdwRjaQ2Xzm+lx6YWL84J4FmuB+pEZxn/rvpLnFKlTlrkm8ZxkpTCg==
X-Received: by 2002:ad4:5ca9:0:b0:87c:11cb:6d0c with SMTP id 6a1803df08f44-87c20573120mr383057026d6.17.1761410466214;
        Sat, 25 Oct 2025 09:41:06 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc49a9d92sm16338826d6.51.2025.10.25.09.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:41:05 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 13/21] trace: don't use GENMASK()
Date: Sat, 25 Oct 2025 12:40:12 -0400
Message-ID: <20251025164023.308884-14-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251025164023.308884-1-yury.norov@gmail.com>
References: <20251025164023.308884-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GENMASK(high, low) notation is confusing. FIRST_BITS() is more
appropriate.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 kernel/trace/fgraph.c      | 10 +++++-----
 kernel/trace/trace_probe.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 484ad7a18463..4f21bd837055 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -106,10 +106,10 @@
  *     (RESERVED or BITMAP)
  */
 #define FGRAPH_FRAME_OFFSET_BITS	10
-#define FGRAPH_FRAME_OFFSET_MASK	GENMASK(FGRAPH_FRAME_OFFSET_BITS - 1, 0)
+#define FGRAPH_FRAME_OFFSET_MASK	FIRST_BITS(FGRAPH_FRAME_OFFSET_BITS)
 
 #define FGRAPH_TYPE_BITS	2
-#define FGRAPH_TYPE_MASK	GENMASK(FGRAPH_TYPE_BITS - 1, 0)
+#define FGRAPH_TYPE_MASK	FIRST_BITS(FGRAPH_TYPE_BITS)
 #define FGRAPH_TYPE_SHIFT	FGRAPH_FRAME_OFFSET_BITS
 
 enum {
@@ -123,7 +123,7 @@ enum {
  *   FGRAPH_INDEX (12-27) bits holding the gops index wanting return callback called
  */
 #define FGRAPH_INDEX_BITS	16
-#define FGRAPH_INDEX_MASK	GENMASK(FGRAPH_INDEX_BITS - 1, 0)
+#define FGRAPH_INDEX_MASK	FIRST_BITS(FGRAPH_INDEX_BITS)
 #define FGRAPH_INDEX_SHIFT	(FGRAPH_TYPE_SHIFT + FGRAPH_TYPE_BITS)
 
 /*
@@ -135,12 +135,12 @@ enum {
  *  data_size == 0 means 1 word, and 31 (=2^5 - 1) means 32 words.
  */
 #define FGRAPH_DATA_BITS	5
-#define FGRAPH_DATA_MASK	GENMASK(FGRAPH_DATA_BITS - 1, 0)
+#define FGRAPH_DATA_MASK	FIRST_BITS(FGRAPH_DATA_BITS)
 #define FGRAPH_DATA_SHIFT	(FGRAPH_TYPE_SHIFT + FGRAPH_TYPE_BITS)
 #define FGRAPH_MAX_DATA_SIZE (sizeof(long) * (1 << FGRAPH_DATA_BITS))
 
 #define FGRAPH_DATA_INDEX_BITS	4
-#define FGRAPH_DATA_INDEX_MASK	GENMASK(FGRAPH_DATA_INDEX_BITS - 1, 0)
+#define FGRAPH_DATA_INDEX_MASK	FIRST_BITS(FGRAPH_DATA_INDEX_BITS)
 #define FGRAPH_DATA_INDEX_SHIFT	(FGRAPH_DATA_SHIFT + FGRAPH_DATA_BITS)
 
 #define FGRAPH_MAX_INDEX	\
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 08b5bda24da2..88de129dcde0 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -401,7 +401,7 @@ static inline int traceprobe_get_entry_data_size(struct trace_probe *tp)
 #define TPARG_FL_USER   BIT(4)
 #define TPARG_FL_FPROBE BIT(5)
 #define TPARG_FL_TPOINT BIT(6)
-#define TPARG_FL_LOC_MASK	GENMASK(4, 0)
+#define TPARG_FL_LOC_MASK	FIRST_BITS(5)
 
 static inline bool tparg_is_function_entry(unsigned int flags)
 {
-- 
2.43.0


