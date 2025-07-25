Return-Path: <linux-kernel+bounces-746313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B469EB12561
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC91D17FB30
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94E025B2F4;
	Fri, 25 Jul 2025 20:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wAPUzRxI"
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9D325A2A2
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 20:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753475303; cv=none; b=ApIs3W5UWNII90IkZagJRyXI/WQq4c8Ihnv7Zc16TsYowCJrizZ/rjnEOMDOgQTRAOX+UxcOqdz0sNNKL5aXdTj6Xh6QQGWMe2xnuJpv9stdEzIG7Vq4x9lFJDxx9UyOon4VKPymCTi5pJArRfplizTt/vpGg0rhBtcYQUTmgYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753475303; c=relaxed/simple;
	bh=y7ZMmXMl4AeF7iTeFou5MQEhQkYueVSw9Jduxng0eNo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PN7LFcoLOoSqOzCC4NmIJsTzT0LmK1+reStWECxNXeulzB6glgd6zqRVkiVFMEwB3KPktP6nkhzgty8uDf0UQujR0ZpGPc9F6Savfxd/MsiW4xTM8eBcbefONbZhS0VIHcw2bI8FKIgPvxC0hlMZSopBpxF4tD9r7TnqgOKXuUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wAPUzRxI; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4ab76d734acso71795811cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 13:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753475301; x=1754080101; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aSnOCIynF2EPoUgwxpXJNlBKEOIAjcwZq8VcJJ4NIKo=;
        b=wAPUzRxIdzE2StFBz8MQFaxMr/vU3Hg6RL0xyCp4bkTyBtggfpsx9wyGJDnEiCR+Aa
         FnWgeyMVcU8FN3ePNub3og6Bm52yeEpgTSD2QQ9G2HoStyWcDzHc3cIRVIE3dqhPRXQt
         DtnMqN2gdcOwWA2GzLuzT1naquz3d9g46h3ONzXrECh88hDZVrw5+qn9oeMIQF3X3MGz
         V7PXNAQfVcZWHpj4a38J8GC/Cwq88eQyOpCJ1bVZEVO/0Vg1gzv+O+hCjliceWiqkPPm
         K6HEJWv6F/7R1oYtXyhB7hciTfk6zK4dkj3fKneVTkJ6auY2Gc/vopC26ke62MZ+D+jU
         d3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753475301; x=1754080101;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aSnOCIynF2EPoUgwxpXJNlBKEOIAjcwZq8VcJJ4NIKo=;
        b=l3Jgll0IbyoPHp0fP5P21BrBY3YUaIU5HUWLbbzTo1x5hLwvQtoCelFk1IcEkuslk2
         LkmScAwoh4GAVDYhYo4DvtPdWDxT9aSDbigb8gw/xpIiu1uiCuyIA4xuqB9q1djslLnz
         TRXSkw0uMLy+gwucmuXEi98c923O8gV+x7YU1C1PKfUJ4GtXxIdB2qT3xF3bUDbF0PaE
         wb0+9XBAdXL2WCBOppqTsX/kixRj9VNJsNf+zgLyMEmOsUeR9GywJQZyyByFe0WnQAOp
         s1akc4A8YZ+FXqgEXWhHlJzx5Xs8sR09hDPqyxcKwv9ETguL8joM02mk8mOsDeejPHBr
         Qj4A==
X-Forwarded-Encrypted: i=1; AJvYcCU1wYzLvfX+RLltl3GsF9m9U6H9/lqgdWlpxAbUqM4dLjQAOSMT0km++c5eDI4P1Qlm8leyjaz2NCSM4MQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YymKYoVgTkcPormYj6U6CgY9V9MJGyWpEFSBaN+3d3uXI4UH63Z
	3jf7iBAD9fi180UdfPw+hpbCV54vnGgQvJg+rTTxekHiDwxPKR1z7zRCAL5+9dRWwGz3gf8btEC
	Tk0A6p845Cg==
X-Google-Smtp-Source: AGHT+IEtaubTt49Ik8s9cRgE+B+Ay3+2JHiCaKE3hc7DgJYA6W0TCehhgfWQ7j17dc3k3QPYrwA+8oaWNbSX
X-Received: from qtbcp4.prod.google.com ([2002:a05:622a:4204:b0:4ab:6375:3dda])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:a05:622a:5448:b0:4ab:63b8:3320
 with SMTP id d75a77b69052e-4ae87225337mr79667211cf.23.1753475300882; Fri, 25
 Jul 2025 13:28:20 -0700 (PDT)
Date: Fri, 25 Jul 2025 20:28:04 +0000
In-Reply-To: <20250725202809.1230085-1-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250725202809.1230085-1-zecheng@google.com>
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250725202809.1230085-2-zecheng@google.com>
Subject: [PATCH v1 1/6] perf dwarf-aux: Use signed comparison in match_var_offset
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

match_var_offset compares address offsets to determine if an access
falls within a variable's bounds. The offsets involved for those
relative to base registers from DW_OP_breg can be negative.

The current implementation uses unsigned types (u64) for these offsets,
which rejects almost all negative values.

This commit changes the local variables within match_var_offset to
signed types (s64) before performing comparisons. This ensures correct
behavior when addr_offset_ or addr_type_ are negative.

Signed-off-by: Zecheng Li <zecheng@google.com>
---
 tools/perf/util/dwarf-aux.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 559c953ca172..bf906dff9ef0 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1388,10 +1388,12 @@ struct find_var_data {
 #define DWARF_OP_DIRECT_REGS  32
 
 static bool match_var_offset(Dwarf_Die *die_mem, struct find_var_data *data,
-			     u64 addr_offset, u64 addr_type, bool is_pointer)
+			     u64 addr_offset_, u64 addr_type_, bool is_pointer)
 {
 	Dwarf_Die type_die;
 	Dwarf_Word size;
+	s64 addr_offset = (s64)addr_offset_;
+	s64 addr_type = (s64)addr_type_;
 
 	if (addr_offset == addr_type) {
 		/* Update offset relative to the start of the variable */
@@ -1414,7 +1416,7 @@ static bool match_var_offset(Dwarf_Die *die_mem, struct find_var_data *data,
 	if (dwarf_aggregate_size(&type_die, &size) < 0)
 		return false;
 
-	if (addr_offset >= addr_type + size)
+	if (addr_offset_ - addr_type_ >= size)
 		return false;
 
 	/* Update offset relative to the start of the variable */
-- 
2.50.1.470.g6ba607880d-goog


