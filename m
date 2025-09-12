Return-Path: <linux-kernel+bounces-814363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 731CEB552EC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 17:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 355BF5C345D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F1232CF79;
	Fri, 12 Sep 2025 15:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VjAiS8Xg"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB595317708
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 15:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757689876; cv=none; b=ZTEdqZLYW3ibibKQATkteG9uyS8Jt2fItG03A9FSaTe9MJ7DHSXntGef47NF9rbwblyYb3qp3gTwVga/Kqf+Y14YMs5FMWf5JnmyHbm/gk7SJdVxnpNZHqnsXdgsLRFW98E8Ib2WCrTzQByQMRUU1MZp15s/4BfRNk4KOzrbzyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757689876; c=relaxed/simple;
	bh=SaxLNwPjG7byVt6l+p6cg0if9w4/pkHze4tv4MutSeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BhP4pnZIdgwam4gNKqP2TgDbZN5ikt2q0bLqGDVpsIF+rbwHx1d3nc/qjXOfP4KG6N1xYZREOinHaGy1H+VRrKi8//d6ZQD5j7Ai+HKoSy2G1NHReZ+g6sne/8knLStm51YOlhqZmf6UTmyDCrFg4Eq4kCrImmxEGWyfm5kSlKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VjAiS8Xg; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-724b9ba77d5so20276277b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757689873; x=1758294673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CNs2h9oqVJ2U55pyNU2xzrbkzs9MTq1sjEL+cOU6gkc=;
        b=VjAiS8XgtXdzKrUmMwBmLiNbs2EgyM6GmNxbpZai9EZhieVl9fu/1Lp4nbNLwhvzQP
         8wpPed/SEK5/wi4s35QCMhrNkKEf10JMs8CtILbmBESRW3ZP/etDBFt96wyMychc1chG
         LcNRs6mLqth8+U9L6omrCfSmW8im4VbBEmJ6MMRLry8tpYVlbhRWTxEq7LPyjHELgiw5
         QRzsqRBxeqV3e8otKZ9yXyOD3u8wAynvR1NKs5e84W5emwdpMIGepeUzlrRa/PmIBtR1
         ExuSg/Tt3vScbYc6rEbzRSa8Mh4Me1W17/K4p7HAaaILzo0WrdPPG/tKMKEF6/rhqLCx
         SX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757689873; x=1758294673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CNs2h9oqVJ2U55pyNU2xzrbkzs9MTq1sjEL+cOU6gkc=;
        b=fsaYmBOutJdoTKCbdPlXIoysNECFqyst0EeGhAsI2e1YxaNwznrqd/bzzqn7MvaccM
         Qk+OqIzIzENr1k/Hb+HG/2IfgyiE4AiE4DIEFrcfFO8HKS/pcqckv1c1s/VdPKMKR9of
         95EDh+56TTauPpNunYwHXd3FomcmLGwQlVilj0J6W/A/KzSX2/oLavFYZvQLZ+xfrOAi
         hH9QraugrTraNULjpLr5lld/5mqgpl0q23gKjRW9ImGjdrWeUCu+BsRu2lGwNCrm0zKm
         T5Xw7oh3bmRK3f2ss+2pBWCaSVRGlGydpxE0ctYD5/ypQOGqPZX1mXdqci06g4pzTBGN
         MQjA==
X-Forwarded-Encrypted: i=1; AJvYcCUgCJdhN6YbVFh+99kINLZahiFkBTQ621szfH2OwZwJkZrZvLMPkCMbb0OZgHWPMIFCadwR372f/KYkN5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI2vYc8ZQJ1RSpXpPzoU1shpyH9UI+I1XmcqtqcWLhGMYbMRYz
	NEOj6B9xgpzbWvdd2NdopsKIjon5brwECv5N0TG5WitxRkgJsNX3nN7sMT+jBkzTuaA=
X-Gm-Gg: ASbGncsq3V88PZybT2WStHqQ5RUglsAN/L5BnJf0X9lMl4ANasp5gDKH+gfD2DkDJ3W
	5bkZwU8rlTcBnkLrnVWMrdfRwyD+p29klo0Y9eUSbAAgbVO1mQlyESwiJsE5xvKDl40tM6mgB92
	t9/UyPEPHlO/lqw4D8+8r8sUUMOvX4qqbxt4XuFGn6MR66MH2KxsdkCi3r+BTLuJMzOwhWPFxGr
	N7/8W1gCxu51WXSzTFS13vtyKZ+UB9M4rPNUvoZiayH//LhvDMaNgywsE1yCBQTlARz0FiZdowR
	D8eQCzhtTxg5pYglE1wh55A7OUWxZ9lwBEOvRavi7EBtl7rIn4H7i37hAbW3zgSo9tss+7JnNsn
	N+iDplYUVJ8aluGRMbpwvM5N4BzeOm/4TkA==
X-Google-Smtp-Source: AGHT+IEpiP8vlE6JAkelU9ryV0aqgK+NNUoCmR9E9pT/XsbUls6aw+6SDhLPMx2e7d1wIx+kCxhExw==
X-Received: by 2002:a05:690c:4a0a:b0:71c:1754:2696 with SMTP id 00721157ae682-730659ba7ecmr33141997b3.36.1757689872581;
        Fri, 12 Sep 2025 08:11:12 -0700 (PDT)
Received: from eugen-station.. ([145.224.119.89])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-624841586c1sm1302244d50.6.2025.09.12.08.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:11:12 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com,
	rdunlap@infradead.org,
	corbet@lwn.net,
	david@redhat.com,
	mhocko@suse.com
Cc: tudor.ambarus@linaro.org,
	mukesh.ojha@oss.qualcomm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	jonechou@google.com,
	rostedt@goodmis.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [RFC][PATCH v3 16/16] dt-bindings: Add Google Kinfo
Date: Fri, 12 Sep 2025 18:08:55 +0300
Message-ID: <20250912150855.2901211-17-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912150855.2901211-1-eugen.hristev@linaro.org>
References: <20250912150855.2901211-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add documentation for Google Kinfo kmemdump backend driver.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 .../bindings/misc/google,kinfo.yaml           | 36 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/google,kinfo.yaml

diff --git a/Documentation/devicetree/bindings/misc/google,kinfo.yaml b/Documentation/devicetree/bindings/misc/google,kinfo.yaml
new file mode 100644
index 000000000000..b1e4fac43586
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/google,kinfo.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/google,kinfo.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Google Pixel Kinfo debug driver
+
+maintainers:
+  - Eugen Hristev <eugen.hristev@linaro.org>
+
+description:
+  The Google Pixel Kinfo debug driver uses a supplied reserved memory area
+  to save debugging information on the running kernel.
+
+properties:
+  compatible:
+    items:
+      - const: google,kinfo
+
+  memory-region:
+    maxItems: 1
+    description: Reference to the reserved-memory for the data
+
+required:
+  - compatible
+  - memory-region
+
+additionalProperties: true
+
+examples:
+  - |
+    debug-kinfo {
+        compatible = "google,debug-kinfo";
+        memory-region = <&debug_kinfo_reserved>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 65d9e5db46a9..6a846c51db04 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13821,6 +13821,7 @@ F:	mm/kmemdump/kmemdump_coreimage.c
 KMEMDUMP KINFO BACKEND DRIVER
 M:	Eugen Hristev <eugen.hristev@linaro.org>
 S:	Maintained
+F:	Documentation/devicetree/bindings/misc/google,kinfo.yaml
 F:	mm/kmemdump/kinfo.c
 
 KMEMDUMP QCOM MINIDUMP BACKEND DRIVER
-- 
2.43.0


