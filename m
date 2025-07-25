Return-Path: <linux-kernel+bounces-746318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FDAB1256A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B9E8AA459D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F2D26057A;
	Fri, 25 Jul 2025 20:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BVyy4621"
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D6A25DB1D
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 20:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753475308; cv=none; b=dJyZyb8kw+Y9T6d1kxUKgob+DcnMibF4/jBXwoWkYB5VHt9IqnF4SDfoCPbcU9ZoDRA8h2I4dC3G5k7gu8sB8Yr2dtzUfepvLrd6KKyR19t/P+H8KF939vFvSEjTZMI3f8wQ5oqf2hQDCcvtbAsD41j7vp2Y+kv4C+CMQW1ITw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753475308; c=relaxed/simple;
	bh=eqiNdrNNyNQ3rEI/7tgLzhp5UuUTLh3U4kfXBxwdLsM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cABrOXJTEJ3KieUbv4LinsRfgBYYugRxe0Yvd1oI8FH0+/v9m9yT92hiEMIalBzFa1z4TNUY2RF+JS64aiA5gQolHDFDzHk7gNKpLAbZbaN0jDdcQFW/8rXVgMLOmJunvJfkBMZQCb8YcCRhsYS1vY4u203G+TbxAj44pH4ecPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BVyy4621; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-7071d802a76so10482076d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 13:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753475306; x=1754080106; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wAsAF9iZYEJs1sam0wHaYd1qu3uSk+JqG6BWLJsyAu8=;
        b=BVyy4621QpGYwWyB72U/65hCMdWPlauIZUGXYdR6YePrkPcHxyfKXRNPiqj1k6Qcdv
         I2sXaD6tIqVK1+IrPAsTi/xiiUKjvBeZe2llf/82kjq/8wfbH8fWX2q7lRwrkHgbbOWN
         nUuG/yDzFzkylh1CrBczmEAcMANZs9JKuDtGWzM/9IfQ+x0SNrkeTR52dCjpDIt0Gt5y
         9iSfY+pN/GkoZ84xqSh5XJYLDJ480mPaWlre3IrfQ3FzKWnS7LQBFpjGO/PyCmTEmUO3
         +aY62aWP6AnwKkXZCwLpF0Q+2OrSWM0EuZxEZGN7G1tbSxxLUoGP4M5W3Ok+21R3qOmg
         y9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753475306; x=1754080106;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wAsAF9iZYEJs1sam0wHaYd1qu3uSk+JqG6BWLJsyAu8=;
        b=ffk3641xvyAQODpQnH1EHaCY2thI9EnupUQQ0ZV/qrYvE+ukGmkfLTupTtsL3/V5ez
         98awB2LQrNCCC/A8QZZ84nGAai6G3LJfmlabx+Zu75Ox3RM9tMnw7QKVO7BjzvR6JcqA
         MJm4c044JgSxMKe2kx7+NxG9l98lwxYBiAmIef0HL5spqw1bhNEoJ0Gi4kSe51wcNkjY
         sfCf5S2YSeVYgvTb4HtRZ7myijHdWZt1lEAsAnjHrpUSlIHrKyfhR8+0QqZ4wYUspITu
         rkV7Wuk97Vs7yMy5CEQCViVkbTr3qYHJ1hTtMN7EEAh0YDwr8dT95mj21YLGJccDEp9b
         mNfw==
X-Forwarded-Encrypted: i=1; AJvYcCWTnK+NuLfs8vRojFBWIYv0ItW38Ve5zZWsQfKOnDxmILs96RyYN5MyebV8e8hiaVRXB6rq1qk4kvyzHOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZlacKKS+Xcm2+Vs50VwJL4Oergg/cd8A89Qo5zDLY0OyeKkue
	hukPgWuVeqrim8Gn4DPnjJ7SoguXP2ZD3F/Tafb6WDNK/24FVbtyKPbTE6wv+RR3mKYJh9GzXkf
	k3c0XOhGMYA==
X-Google-Smtp-Source: AGHT+IFC21i9K0c6rPNOKxlTLDf5sxgCJsd5DNkYpywRCfVT8HRuIL0FCuuTh/eeK3uPHkKd3jeNZIkFY0nx
X-Received: from qvbmn12.prod.google.com ([2002:a05:6214:5ecc:b0:704:88ad:4ae9])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:a0c:e304:0:b0:707:ce0:d19b
 with SMTP id 6a1803df08f44-707204bde1bmr32951266d6.6.1753475306090; Fri, 25
 Jul 2025 13:28:26 -0700 (PDT)
Date: Fri, 25 Jul 2025 20:28:08 +0000
In-Reply-To: <20250725202809.1230085-1-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250725202809.1230085-1-zecheng@google.com>
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250725202809.1230085-6-zecheng@google.com>
Subject: [PATCH v1 5/6] perf dwarf-aux: Find pointer type to a type
From: Zecheng Li <zecheng@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Zecheng Li <zli94@ncsu.edu>, Xu Liu <xliuprof@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zecheng Li <zecheng@google.com>
Content-Type: text/plain; charset="UTF-8"

Implement die_find_pointer_to_type that searches for the pointer type to
a given type in the CU. There's no guarantee that a pointer DIE exists
for every possible base type. Compilers only generate DIEs for types
actually used or defined.

The performance could be improved by adding a cache for the pointer
types. Currently its impact on the annotation time for vmlinux is low.

Signed-off-by: Zecheng Li <zecheng@google.com>
---
 tools/perf/util/dwarf-aux.c | 69 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/dwarf-aux.h |  4 +++
 2 files changed, 73 insertions(+)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 4039dbd2b8c0..49d509839a85 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -2121,3 +2121,72 @@ Dwarf_Die *die_deref_ptr_type(Dwarf_Die *ptr_die, int offset,
 
 	return die_get_member_type(&type_die, offset, die_mem);
 }
+
+struct find_pointer_type_data {
+	/* DIE offset of the type we want to point to */
+	Dwarf_Off target_type_offset;
+	Dwarf_Die *found_die;
+};
+
+static int __die_find_pointer_to_type_cb(Dwarf_Die *die_mem, void *arg)
+{
+	struct find_pointer_type_data *data = arg;
+	Dwarf_Attribute type_attr;
+	Dwarf_Die type_die;
+	Dwarf_Off ref_type_offset;
+
+	if (dwarf_tag(die_mem) != DW_TAG_pointer_type)
+		return DIE_FIND_CB_CONTINUE;
+
+	if (!dwarf_attr(die_mem, DW_AT_type, &type_attr))
+		return DIE_FIND_CB_SIBLING;
+
+	/* Get the DIE this pointer points to */
+	if (!dwarf_formref_die(&type_attr, &type_die))
+		return DIE_FIND_CB_SIBLING;
+
+	ref_type_offset = dwarf_dieoffset(&type_die);
+
+	if (ref_type_offset != 0 && ref_type_offset == data->target_type_offset) {
+		/* This die_mem is a pointer to the target type */
+		if (data->found_die)
+			*data->found_die = *die_mem;
+		return DIE_FIND_CB_END;
+	}
+
+	return DIE_FIND_CB_SIBLING;
+}
+
+/**
+ * die_find_pointer_to_type - Find a DIE for a pointer to a given type
+ * @cu_die: The compilation unit to search within.
+ * @target_type: The DIE of the type you want to find a pointer to.
+ * @result_die: Buffer to store the found DW_TAG_pointer_type DIE.
+ *
+ * Scans the children of the @cu_die for a DW_TAG_pointer_type DIE
+ * whose DW_AT_type attribute references the @target_type.
+ *
+ * Return: @result_die if found, NULL otherwise.
+ */
+Dwarf_Die *die_find_pointer_to_type(Dwarf_Die *cu_die, Dwarf_Die *target_type,
+				   Dwarf_Die *result_die)
+{
+	struct find_pointer_type_data data;
+	Dwarf_Die search_mem;
+
+	if (!cu_die || !target_type || !result_die)
+		return NULL;
+
+	data.target_type_offset = dwarf_dieoffset(target_type);
+	if (data.target_type_offset == 0) {
+		pr_debug("Target type DIE has no offset\n");
+		return NULL;
+	}
+	data.found_die = result_die;
+
+	if (die_find_child(cu_die, __die_find_pointer_to_type_cb, &data, &search_mem))
+		return result_die;
+
+	return NULL;
+}
+
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index 892c8c5c23fc..7e1336ff276e 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -156,6 +156,10 @@ Dwarf_Die *die_get_member_type(Dwarf_Die *type_die, int offset, Dwarf_Die *die_m
 /* Return type info where the pointer and offset point to */
 Dwarf_Die *die_deref_ptr_type(Dwarf_Die *ptr_die, int offset, Dwarf_Die *die_mem);
 
+/* Find a DIE for a pointer to a given type */
+Dwarf_Die *die_find_pointer_to_type(Dwarf_Die *cu_die, Dwarf_Die *target_type,
+				   Dwarf_Die *result_die);
+
 /* Get byte offset range of given variable DIE */
 int die_get_var_range(Dwarf_Die *sp_die, Dwarf_Die *vr_die, struct strbuf *buf);
 
-- 
2.50.1.470.g6ba607880d-goog


