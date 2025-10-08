Return-Path: <linux-kernel+bounces-845435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7B1BC4E57
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 14:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 30AD6341F33
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 12:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D3424E4B4;
	Wed,  8 Oct 2025 12:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cEXR6/5l"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5523824BD0C
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 12:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759927359; cv=none; b=Qv+95xRaLWryw/1u/c7bVDZTZNpDG9m4Hj0qoMY8wIldGZDoD/sLYuuiylcGTLBCioTELC6o0M8RcNJW5+rq35wPIrrOwX3mD9D/pZ/a/1FRzhxPq+0otYjh4slig7p0r9WVuulsTHSnXkQBLZhDaOmDUamzwC/1GJ92+m81Ufw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759927359; c=relaxed/simple;
	bh=0eHoYPcdGZEMlCC0AF9zZdja0XSKfe7tlSR7tgd1aCM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qbSfw/F9M2mWpaITPCd1iNzpnB5AVYCpYjfiTUs7atQZybRf8nBzyrDJmg3V3Ylp9/SE8ghEVbB+xVC7nsIA3XLE6ra6B//2mCS+EK3+8n6I/RYbTtlcMduCgm31khJC0tuQ27rRScIPk/r8A/nCyvUCNzXSzYoi/V2hHlX/Ehc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cEXR6/5l; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso490770f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 05:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759927356; x=1760532156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c1h9bQgnrHSVl4Y0jfCrEgYmaDZISuGnayrwZXACWK0=;
        b=cEXR6/5lwIvUGp1xQSQMRRJerKrrmker/PWYiY7y4Oki1IBR5sDfqhbj4Dby2nc2SJ
         zAsDy2hWKWV9zPdJZUkQuIP0QJdJSO0GLeRDntX0+W+CNODhimGOXYaX40zDKYjVsEzc
         cTbflCQ8VfkPFpDxLiR01Ev1lSSNyAzOahQTZD51UGMNi/6GpCgiu709spqiEsM02Xdg
         1VQyEjvgVTeCak2syoTDVcjmj9d/J63wLpRiPw/wY+iWO615uVESz1/b2Uh75yNAJVdM
         U7UXZYW5BHcUHkZXr5qYreJXytLhPb+6Siex9NSB1ikKvU25UgJMylVy9uqhZ4WqNDD8
         jDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759927356; x=1760532156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c1h9bQgnrHSVl4Y0jfCrEgYmaDZISuGnayrwZXACWK0=;
        b=lujFur2xC4pmwae5Sytwuf6w+Q2FY6KPHp0gjYpK2xNVMQxJ7bBvAS0ATQ86vp45Ky
         nVH19tRC1rQo16kE1nVXc80KjBKfknnMtpepkZWWQOIyH6oBNwhqNllWIArVOHIUlRTO
         eFSm2/Wi5cVg5QKmj4x7cY5jO4lvVvQw/uDUG54rIVebXwbUHr+WXHUe3CAdTxddpaoA
         O/Ks4JYs+YsKLMJDElAp/oL7RrJxezu6Z0+slkJixbUgiJhk0liDWopvOOa+Zoi6gWr8
         rRpe9DfYBcn8BuuClq5rbgPNda1gaphejibgIFLib67yz5fi/RvTfztmj975ODKklv14
         rTeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyTuDNoRDUUTrxnETMk667GPC4WytvXlvEvgzB42B38MDnbFG9XoTqwOX0ESCESrjqQoQkYbStHRmhGn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpalhKHSCWANQQ8ZexE1z//IcsRy3h+tXArvQ5PGygWW1BGOLx
	WQ1Ai8l16bZ7FvesX9jot1a5ziCJPnu0QioDPUhuBoDoBmiOWIkvbPlAYVeX/31IzFWxh4AZRkI
	zJcRb
X-Gm-Gg: ASbGncsexdwPeNrTvOSOjsv877Hc9F5NjPrhX23sKx1hAVfDxqZjdnlIT19w4xMHin2
	Jbep4qcKwEYuhmDITdJHgm+iYSzhIDCFjIBgWOgiDQR5fi4ikKYIhXJhO9nnruCq0KuGQq9ULog
	PyowHWSukcOsjBgRGLVFB3Q/+qxnsgWWgqXReQjQf9Lyg0ZL67UqrebePuHChWNhiLnPaFw357w
	qfGP1c3zyHw/fIV/0d58cxFzNKAGLGjqGfxdvFqvlkCDkWcAStqN74EXgXcOMhFS7h/E6KS4nQI
	s1+x/mbWVcRGSKfxwSZ8Ahekcbnc3VeLqZWDL3Mxch3L6459Vr3NSuThMWSUou8yqhHdw+BYlC6
	TF0Un6F4VAaRoHU4C9woFG71PDTwkSd2gWP3Xj3oRz+m+P7fuA4iPdtkQNz1YuWD9RkGYVmKGHU
	v7zg==
X-Google-Smtp-Source: AGHT+IEHXbTr3EM01NQrVZFVeU0wqRKUe+r4Uos2QGhIy+lPLvKrMSJAAnCKjcEayyikIAHTO7TvsQ==
X-Received: by 2002:a05:6000:2504:b0:3ee:11d1:2a1e with SMTP id ffacd0b85a97d-425829b0d45mr5498131f8f.10.1759927355550;
        Wed, 08 Oct 2025 05:42:35 -0700 (PDT)
Received: from localhost.localdomain ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9bf953esm35978165e9.1.2025.10.08.05.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 05:42:35 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	irogers@google.com,
	namhyung@kernel.org,
	acme@kernel.org
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] perf tests: use strdup() in "Object code reading"
Date: Wed,  8 Oct 2025 13:42:00 +0100
Message-Id: <20251008124201.875919-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use strdup() instead of fixed PATH_MAX buffer for storing paths to not
waste memory.

Suggested-by: Ian Rogers <irogers@google.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
Applies on top of: https://lore.kernel.org/linux-perf-users/CAP-5=fV1N-j+f4GBFnDWsmoMZcz_k0U=nu1A7NZz-g4gzCH4KA@mail.gmail.com/T/#t

Changes since v1: handle strdup() failure

 tools/perf/tests/code-reading.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 4c9fbf6965c4..1acb12b1a2eb 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -43,7 +43,7 @@
 struct tested_section {
 	struct rb_node rb_node;
 	u64 addr;
-	char path[PATH_MAX];
+	char *path;
 };
 
 static bool tested_code_insert_or_exists(const char *path, u64 addr,
@@ -79,7 +79,11 @@ static bool tested_code_insert_or_exists(const char *path, u64 addr,
 		return true;
 
 	data->addr = addr;
-	strlcpy(data->path, path, sizeof(data->path));
+	data->path = strdup(path);
+	if (!data->path) {
+		free(data);
+		return true;
+	}
 	rb_link_node(&data->rb_node, parent, node);
 	rb_insert_color(&data->rb_node, tested_sections);
 	return false;
@@ -94,6 +98,7 @@ static void tested_sections__free(struct rb_root *root)
 						     rb_node);
 
 		rb_erase(node, root);
+		free(ts->path);
 		free(ts);
 	}
 }
-- 
2.34.1


