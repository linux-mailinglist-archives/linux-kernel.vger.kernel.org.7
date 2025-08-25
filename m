Return-Path: <linux-kernel+bounces-785467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF23B34B2F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 21:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AB99205017
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 19:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76762882DE;
	Mon, 25 Aug 2025 19:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QgB2lfcA"
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5637283FD0
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 19:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756151664; cv=none; b=TA/I8DgOef5aebF/noz8z0dIL3PiQVUfwUA709hYN0Xk2+onhoIhddqxUwP3/kZO7Tw/fisIq1DMNMvcAhC4421vIYCK/u/gwOHhTw84ajvrfZA+Y2hYcgOKsglYwZQqvqwNImrotMdmduKU/aomNWcrRUtpnyBPbwuZsyh4tPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756151664; c=relaxed/simple;
	bh=HcmjyPq+HJ69UUE8MXp8+eJ0FnVp+I6KpsIJwz1NOGU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mNT3RBWyC6qzHYTQH9kt3RqRxrrnqXmBxjvBCIuEJqoCaUrRp6P6VcLzRx6adlXfEbHVb9M1kth/GueYdJ/Ez+bZTCo/bOSFUCe68b/qaqxRN8UyybgJdm7hve9sTAamc7nH50Ci8EF+7QFoLrjh1J+27fjADKmHJeXt+1sNF0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QgB2lfcA; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7e8702fb9e1so1223574185a.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 12:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756151661; x=1756756461; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FDZ7rBECUpjb0yUDRUfPXJKV4c4fG0Ag2lJMPqsfsyY=;
        b=QgB2lfcAt7Ochqb0xQu+38tez+ONBRDTdrluaIGNvbjLSRTj4lg/0zWsi2R9HGp5iN
         ksvgjUMxx85ptckWyZpsTqjmLs5ZTP53OpT5E5Et2UauPNwOvSOCpGAvI+skJmNDAFQE
         sShA94jA4FQC/+DTA0C68JTTzEes0nQSun2NVda5rTnVi0nbuICl5cGz/F27BAiM7VH5
         F2XCcUF7iDfIs6igJTyBtqvx079OwpHRjgDZUI97TF5TgQjK7DfT55SN/RZCuAe6lTMa
         XqFdVECcVOsqZY5FKijFb8KeqBZosBMink+YpBsomBH8YGqNqyw/05nvZBPVOa1K0yPJ
         cOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756151661; x=1756756461;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FDZ7rBECUpjb0yUDRUfPXJKV4c4fG0Ag2lJMPqsfsyY=;
        b=ISTkp9IQIcdzWwQiaxXOrbBy//cPxRGvcAeY+FeSiny3tNaJSjfagme2Egf2UcGEuD
         B3KC+SoN7KOFex95KmIsJeqLFYQWcLM1JuY5mVPgPsa7FFQDESdLiko46Jx9A5DM0iJs
         gkuPBj/t5wIojDq55Vg2rNKIptHmDQ21Jg5VWUkamJTc8sY13QVRTH0mS2uw0oCNfRM+
         a/f6FYXe4Vd4YckxTWOHKdnK0sfB5kP9Ntfzo3JFBdPeHSslWZ8OyiY+uymqE435ohUJ
         VQArOdLSi9GKH7tOIoCfI21rCHkrcF1swgHjmpdCEjJIn7rMycZiCb9z1lKOWD+NdV3c
         L7gw==
X-Forwarded-Encrypted: i=1; AJvYcCWLTqM1m+PElFrXO2roGYdfyPahXc2q8W8IVMTnG9+/EO+RfWgvhQhylAobWoDErfwPTCbL6DDa4b/z4wE=@vger.kernel.org
X-Gm-Message-State: AOJu0YznYcD2zbzwRIFmJrSUW373qdB74qjm4XF7klH3VQk2mKxt/plU
	z/hIbh8seqDV1GoszIVfoQx4WAWvBNcE4ER9bH0sz6HTCt1ImpIKM/asQNZ+pY8KY2x2aWOkGjb
	+O4PxcXqhRg==
X-Google-Smtp-Source: AGHT+IFjfzhnSD4J6UI06bC9yT857vkVXOFiqMoQtCRwEtvPZj6aVMZXK+c3UV3wlvT3QXsIw6EeINIRV0cZ
X-Received: from qknpb12.prod.google.com ([2002:a05:620a:838c:b0:7e6:5fba:1a9c])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:45a8:b0:7f4:34c8:18e6
 with SMTP id af79cd13be357-7f434c81979mr93003685a.38.1756151660706; Mon, 25
 Aug 2025 12:54:20 -0700 (PDT)
Date: Mon, 25 Aug 2025 19:54:02 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250825195412.223077-1-zecheng@google.com>
Subject: [PATCH v2 00/10] perf tools: Some improvements on data type profiler
From: Zecheng Li <zecheng@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zecheng Li <zecheng@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi all,

I've identified several missing data type annotations within the perf
tools when annotating the Linux kernel. This patch series improves the
coverage and correctness of data type annotations.

Here's a breakdown of the changes:

Patches 1-3 fix type matching from DWARF. They address cases with
negative offsets (e.g., from intrusive linked lists) and distinguish
DWARF expressions for variable value or address.

Patch 4 skips annotations for LEA instructions in x86, as these do not
involve memory access.

Patches 5-7 implement a basic approach for register offset tracking
based on add, sub, and lea operations. The register is invalidated when
an unsupported arithmetic instruction on that register is encountered.
While this feature has known limitations and may regress in rare cases
compared to the original, it generally improves offset tracking in most
scenarios.

Patch 8 skips check_variable when the type is found directly by
register, since sufficient checking is already performed in
match_var_offset. check_variable lacks some DWARF information to
correctly determine if a variable is valid.

Patch 9 fixes __die_find_scope_cb for namespaces. I found this issue
when trying to annotate a Rust program. The Die for a namespace doesn't
have a PC range, so it would be skipped. Therefore, we should check a
namespace's siblings and children.

Patch 10 implements support for DW_OP_piece. Currently, it is allowed in
check_allowed_ops but is handled like other single location expressions.
We should split any expression containing DW_OP_piece into multiple
parts and handle them separately.

I have tested each patch on a vmlinux and manually checked the results.
After applying all patches, there are less missing or incorrect
annotations. No obvious regressions were observed.

v2:
1. update the match_var_offset function signature to s64
2. correct the comment for is_breg_access_indirect. Use simpler logic to
match the expressions we support.
3. add is_reg_var_addr to indicate whether a register holds an address
of the variable. This defers the type dereference logic to
update_var_state.
4. invalidate register state for unsupported instructions.
5. include two new patches related to improving data type profiler.

v1: https://lore.kernel.org/linux-perf-users/20250725202809.1230085-1-zecheng@google.com/

Zecheng Li (10):
  perf dwarf-aux: Use signed variable types in match_var_offset
  perf dwarf-aux: More accurate variable type match for breg
  perf dwarf-aux: Better variable collection for insn tracking
  perf annotate: Skip annotating data types to lea instructions
  perf dwarf-aux: Find pointer type to a type
  perf annotate: Track arithmetic instructions on pointers
  perf annotate: Invalidate register states for unsupported instructions
  perf dwarf-aux: Skip check_variable for die_find_variable_by_reg
  perf dwarf-aux: fix __die_find_scope_cb for namespaces
  perf dwarf-aux: support DW_OP_piece expressions

 tools/perf/arch/x86/annotate/instructions.c | 155 +++++++-
 tools/perf/util/annotate-data.c             |  35 +-
 tools/perf/util/annotate-data.h             |   6 +
 tools/perf/util/annotate.c                  |  18 +
 tools/perf/util/dwarf-aux.c                 | 372 ++++++++++++++++----
 tools/perf/util/dwarf-aux.h                 |   8 +-
 6 files changed, 519 insertions(+), 75 deletions(-)

-- 
2.51.0.261.g7ce5a0a67e-goog


