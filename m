Return-Path: <linux-kernel+bounces-842191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A70F3BB92E0
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 01:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C99F19A0666
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 23:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB25248898;
	Sat,  4 Oct 2025 23:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMkjKima"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A504B24728F
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 23:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759621831; cv=none; b=UjWJ0WSYi1U3XMvZsK5iJQwY1jDUoVKXcAFvQmRmKoT8Q2s9Se8FlTYrYAwI68Ij2jHR99MSz7ukbC9qiR4foy90tTY/AM0+c/hepZq2GwQvHAWHq59+7TmpT+8fbbe7bBFyin1LDgOiRXtAGHEHtjsUe/ekyBJ50+ser46j4yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759621831; c=relaxed/simple;
	bh=M8zHmRZzh1etGfBTEYtac4q+pXAyTpkj0u0emKPd9iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ULi2WPkbYmHLsdBJ4XuU4ZkWDknEbn58nRZudbEQAHzx2zNxC8bzR12lqlQi3uAym0cZ5+7f1M70kVLgbV2ZHh9NSkD2GLEBIbtVyFC6dzsDob757mZ6ym2CgMN3kGY+7nNAKe6hBhHA7Oe6eTWjgaPa2pqKXMm1xN/dwLk+SUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMkjKima; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-879b99b7ca8so23924266d6.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 16:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759621828; x=1760226628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NT7b4ZLvKRu3HtUu6iokqc97ftNCnhP9nU4dbxg6QfE=;
        b=fMkjKima8ShJwt0+Rc7DvxiVBD9aOe3Mxk1C+BfSNO74DAvOf7qUHpTZrX4eYD2YJf
         CQYhbdkDDL1RnDhGG8y185OCBSCo0gZHmFWS/UCtQ8qk2g4u8Et22mfjxSpKSadTUy8F
         Q2cpcNcI74psTU1hjyeGSe0TNKD1cZdIVp7d4eQHTjdUoS9+xnVu/2KBSohYRhkczgwk
         i9ZfZx7wZ4ahx8mbY4GGATIGHSyloaS1+B/6KlwPU1IXGJC7Ih9giVqtPf+7i/g5KcoX
         aOfGijmqt9pzgl+5R4NelymLL/1FSMX/hNajgvf3b2D16/zHwXyoIG4bAitWJuWPX384
         8imw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759621828; x=1760226628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NT7b4ZLvKRu3HtUu6iokqc97ftNCnhP9nU4dbxg6QfE=;
        b=f9dCUbOyrCUk0vRYwHHb0wmnDcsBCrsazV2T0+oE0LRHI58Gxbjg+arSvFDi2yaKNe
         1mf4erqqgADoiK5ULkpPD8KGT7Bgd6UPgz9QO+5C+dwIb1laFOzC3x4NgS8S3qVRlMCR
         k8CXZeVidEB/A+d7+z3gwjBFI2lo3PjC721m1I8Sntl8VFkZtN6uGJPB92JPmWQS4kPT
         xDu60xp1IJjVMnmR+m4YQdL+iiT7lwyVHi3Rp6CZfBf8PawksegL76ptx6kzI9clzx74
         eGZ/KsEAurjCo06cFzf+vfYtDQO9gdn4Adc+4zsyABcuFY5AXOblbVCNARxogNvWReR5
         HDRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVO/Gf57v4ZjHJqcAP52v12Okpnaw9+jd6hS00r/HTJlB4CpmlNQ3cGzUW3wo5lBjWmLx4IpRausFvU9RY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxcWhiaZODM1SkPmSCB9QFUj/9uQl2I6IsNPCMje3LlTOCsExH
	fzjGki3QDGUUUTJXyMCkDmrJHo8MtqmipDUVYDINxLtNsUoks8itGbOP
X-Gm-Gg: ASbGncswbcnbf/myydaSczGUzLJ8/zN8UTUlFhuRQZ8dfF8CLRaRcMtUBhni+NHX9Nj
	Df+9Ln9uFdBGIEcSPCil2op1fZQD26sXPE7Rx71AleWy0rGlNMCLmYRM1E1PPKPuK6kpvNHkdQR
	laziCzuARVVOwVE0vHrVEmbMHCaDQBo2FNsFXCxjVIOH4mUMsho6ul9NkhA2cZFXVgbPaSj+biQ
	As1y1qO/3k2JHkxBwSlAnOR0EZ4FqdvCo6eFlrMA0GNRY1rA0K6jApAYygI9EDgWXXV3MHZLxHu
	sHV202RGcGi69AbQtbbgaWQPHmnTN88kBEiHRKMIatMinA2mtZNqZ8bqR2uXLnliKhLqwidOsF/
	dGH3pWS61fFMWj25OM/7II58mGTBV1E1DFgbUTMlw5xf/jasV1aYY3O3MtW4h+CC95P1JFNXd24
	iU+AA9U1LvjsNeLBM=
X-Google-Smtp-Source: AGHT+IFkMKsThVh6BHIAWVgjKNvGuStlv8+DHWcDDo6wEzsC1RPtLuqj3cUETmYY2xxLYuWZjAbclw==
X-Received: by 2002:a05:6214:19e1:b0:76a:fcee:97ad with SMTP id 6a1803df08f44-879dc8ab120mr106203176d6.60.1759621828437;
        Sat, 04 Oct 2025 16:50:28 -0700 (PDT)
Received: from seokw-960QHA.mynetworksettings.com ([2600:4041:4491:2000:dd54:e5ff:d4b7:cf43])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bdf5383fsm76180216d6.56.2025.10.04.16.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Oct 2025 16:50:27 -0700 (PDT)
From: Ryan Chung <seokwoo.chung130@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	shuah@kernel.org,
	hca@linux.ibm.com,
	corbet@lwn.net,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	seokwoo.chung130@gmail.com
Subject: [PATCH v3 1/5] docs: tracing: fprobe: document list filters and :entry/:exit
Date: Sun,  5 Oct 2025 08:46:55 +0900
Message-ID: <20251004235001.133111-2-seokwoo.chung130@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251004235001.133111-1-seokwoo.chung130@gmail.com>
References: <20251004235001.133111-1-seokwoo.chung130@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Ryan Chung <seokwoo.chung130@gmail.com>
---
 Documentation/trace/fprobetrace.rst | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/Documentation/trace/fprobetrace.rst b/Documentation/trace/fprobetrace.rst
index b4c2ca3d02c1..629e2d7402bd 100644
--- a/Documentation/trace/fprobetrace.rst
+++ b/Documentation/trace/fprobetrace.rst
@@ -25,21 +25,36 @@ Synopsis of fprobe-events
 -------------------------
 ::
 
-  f[:[GRP1/][EVENT1]] SYM [FETCHARGS]                       : Probe on function entry
-  f[MAXACTIVE][:[GRP1/][EVENT1]] SYM%return [FETCHARGS]     : Probe on function exit
-  t[:[GRP2/][EVENT2]] TRACEPOINT [FETCHARGS]                : Probe on tracepoint
+  # fprobe (function entry/exit)
+  f[:[GRP1/][EVENT1]] SYM_OR_LIST[:entry|:exit] [FETCHARGS]
+
+  # legacy single-symbol exit
+  f[MAXACTIVE][:[GRP1/][EVENT1]] SYM%return [FETCHARGS]
+
+  # Probe on tracepoint
+  t[:[GRP2/][EVENT2]] TRACEPOINT [FETCHARGS]
 
  GRP1           : Group name for fprobe. If omitted, use "fprobes" for it.
  GRP2           : Group name for tprobe. If omitted, use "tracepoints" for it.
- EVENT1         : Event name for fprobe. If omitted, the event name is
-                  "SYM__entry" or "SYM__exit".
+ EVENT1         : Event name for fprobe. If omitted,
+                  - For a single literal symbol, the event name is
+                    "SYM__entry" or "SYM__exit".
+                  - For a *list or any wildcard*, an explicit [GRP1/][EVENT1]
+                    is required; otherwise the parser rejects it.
  EVENT2         : Event name for tprobe. If omitted, the event name is
                   the same as "TRACEPOINT", but if the "TRACEPOINT" starts
                   with a digit character, "_TRACEPOINT" is used.
  MAXACTIVE      : Maximum number of instances of the specified function that
                   can be probed simultaneously, or 0 for the default value
                   as defined in Documentation/trace/fprobe.rst
-
+ SYM_OR_LIST    : Either a single symbol, or a comma-separated list of
+                  include/exclude patterns:
+                  - Tokens are matched as symbols; wildcards may be used.
+                  - Tokens prefixed with '!' are exclusions.
+                  - Examples:
+                        foo             # single literal (entry)
+                        foo:exit        # single literal exit
+                        foo%return      # legacy single-symbol exit
  FETCHARGS      : Arguments. Each probe can have up to 128 args.
   ARG           : Fetch "ARG" function argument using BTF (only for function
                   entry or tracepoint.) (\*1)
-- 
2.43.0


