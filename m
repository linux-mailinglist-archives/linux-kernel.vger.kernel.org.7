Return-Path: <linux-kernel+bounces-785469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C33CB34B31
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 21:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 397BD1A87F5D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 19:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C8828C5AA;
	Mon, 25 Aug 2025 19:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UTbY/hDh"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E042877C7
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 19:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756151665; cv=none; b=PESiymL5nVwfvVc9sARDKNfln6bOozx8mekYRMGbsW+wQAuQOGE9cmd1Gj3n1srz2Fc4E5hfpPqJouyW6RBDrrGhx5HnIOXo8AfEUZG5+oWfIj3eDViJIOImmhySxwQ8Nk+w2UeHIbnZKT0KPaJ7WFjprGNpfKsZFjfqca0vshc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756151665; c=relaxed/simple;
	bh=t04d4Oy06VwzJIBhx6LAbP5eDGbW7bns40eXZAs+uDY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UiwkMX7HLyjE5Z2kzsdRVbk8NRc/GVZQn6lFiSIu1eEmZU5YhpylIWLgxZvkGgsMB1+jb4Wh9BeXDngdvzecq5C523CMF35gBDN12b8D7dovDBkTcCZEXkXM8rplJZFGxoWwQJeal4MWf23H0RFb9PXuVZAzqm4pZ+KbW7PEQPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UTbY/hDh; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e952a588594so3424754276.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 12:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756151663; x=1756756463; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7hqzOPZ3n+4+BPd5zxBdaAo/dBfXsxzHsh8FnCKMBtI=;
        b=UTbY/hDhHssueAVyuU0EMvLnXUGu4KryDKE8IM+jkBN72Aaiisd0PHPZx2nMWAagM+
         MhYvBfflvUfx72U9/wPVEOL6Yf9Pu7jVKJiGIgWENCbj+5opi0CYhy8ClHuViXGwXmAA
         uUWDq4SfOibq9vkL6e9QvWMUjiWoTeI8Sq+2auHEFtVep8NtpYdZ7xNCvhY5FZRfzQDJ
         nGQBiEjXbR50uTIxbh9crKU/MnRwv8qqW5wD3sfzNQbwOLWtrJc+0het/2XnidUUJWCm
         jGOO5nlImgGZDAon5Wn1pIxB1yvaItVpaPj/twzA4EGwBGiAFwu9jwzJK8ywI37ciZe6
         909Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756151663; x=1756756463;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7hqzOPZ3n+4+BPd5zxBdaAo/dBfXsxzHsh8FnCKMBtI=;
        b=Xvnc3Q6ivA3vYQIwt0+4JLiJU0YC/DYwpQoocsjPc0di41g11IBzWgYCMPvOM/R3zp
         J9Ur2LQQTNBXlPh9tZl6RTftl2z+HAJt9CRgl8gmsB934oux/vdsCGwxRqJYD+40qSZm
         AO/YWBAQAU602sUdC+G7NFHr8KEt3hHIXVfZQM5Rt7+oHhIIIuAxtUXzYQidCtdYJAnL
         WscHjQ+zXx2qIY3Mrpl751eHJIBp16U6pz751jFLjSTxrv/Z5+aVBCgnG1Pgx7vvUvfZ
         uf5yvb9cDYQKASiMrGudsWTfNooOzW/4CfYOLJKTqlDCBm5DeP9dg08olthEPjJ8d/Zy
         1HJg==
X-Forwarded-Encrypted: i=1; AJvYcCUQwlbNO5gSRVZn9VAI529KeH8WTMyKeeDzXsVH5FdV63fByYcstdanG20w4OwFPJM0Dl/7bwaivVp75vo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhIM7Q/bswIFE6A64FazWwyG8C0bVWJfuRqPl4/iobRoqm9nxb
	6gzIH0LZCbNNP9KFZsTTijRTjTZ2MY5oPmIZ5mRkhg0MXX3gqTElHjU0h7e+QdDDVEJw+P/3Q50
	V0CsXh8HQ/A==
X-Google-Smtp-Source: AGHT+IHGeTIhTiaiwKR819i7y2HhpaGEe11entKqWV5wF/Zrp7DeGY8kgMotXF9bj9jl9+RkeVfm32naYnVe
X-Received: from ybbhj4.prod.google.com ([2002:a05:6902:3284:b0:e95:1b5d:27c4])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6902:2b8c:b0:e96:5bcd:f33a
 with SMTP id 3f1490d57ef6-e965bcdf5bamr6165552276.27.1756151662889; Mon, 25
 Aug 2025 12:54:22 -0700 (PDT)
Date: Mon, 25 Aug 2025 19:54:04 +0000
In-Reply-To: <20250825195412.223077-1-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250825195412.223077-1-zecheng@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250825195412.223077-3-zecheng@google.com>
Subject: [PATCH v2 02/10] perf dwarf-aux: More accurate variable type match
 for breg
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

Introduces the function is_breg_access_indirect to determine whether a
memory access involving a DW_OP_breg* operation refers to the variable's
value directly or requires dereferencing the variable's type as a
pointer based on the DWARF expression. Previously, all breg based
accesses were assumed to directly access the variable's value
(is_pointer = false).

The is_breg_access_indirect function handles three cases:

1. Base register + offset only: (e.g., DW_OP_breg7 RSP+88) The
   calculated address is the location of the variable. The access is
   direct, so no type dereference is needed. Returns false.

2. Base register + offset, followed by other operations ending in
   DW_OP_stack_value, including DW_OP_deref: (e.g., DW_OP_breg*,
   DW_OP_deref, DW_OP_stack_value) The DWARF expression computes the
   variable's value, but that value requires a dereference. The memory
   access is fetching that value, so no type dereference is needed.
   Returns false.

3. Base register + offset, followed only by DW_OP_stack_value: (e.g.,
   DW_OP_breg13 R13+256, DW_OP_stack_value) This indicates the value at
   the base + offset is the variable's value. Since this value is being
   used as an address in the memory access, the variable's type is
   treated as a pointer and requires a type dereference. Returns true.

The is_pointer argument passed to match_var_offset is now set by
is_breg_access_indirect for breg accesses.

There are more complex expressions that includes multiple operations and
may require additional handling, such as DW_OP_deref without a
DW_OP_stack_value, or including multiple base registers. They are less
common in the Linux kernel dwarf and are skipped in check_allowed_ops.

Signed-off-by: Zecheng Li <zecheng@google.com>
---
 tools/perf/util/dwarf-aux.c | 38 ++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 920054425578..449bc9ad7aff 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1423,6 +1423,34 @@ static bool match_var_offset(Dwarf_Die *die_mem, struct find_var_data *data,
 	return true;
 }
 
+/**
+ * is_breg_access_indirect - Check if breg based access implies type
+ * dereference
+ * @ops: DWARF operations array
+ * @nops: Number of operations in @ops
+ *
+ * Returns true if the DWARF expression evaluates to the variable's
+ * value, so the memory access on that register needs type dereference.
+ * Returns false if the expression evaluates to the variable's address.
+ * This is called after check_allowed_ops.
+ */
+static bool is_breg_access_indirect(Dwarf_Op *ops, size_t nops)
+{
+	/* only the base register */
+	if (nops == 1)
+		return false;
+
+	if (nops == 2 && ops[1].atom == DW_OP_stack_value)
+		return true;
+
+	if (nops == 3 && (ops[1].atom == DW_OP_deref ||
+		ops[1].atom == DW_OP_deref_size) &&
+		ops[2].atom == DW_OP_stack_value)
+		return false;
+	/* unreachable, OP not supported */
+	return false;
+}
+
 /* Only checks direct child DIEs in the given scope. */
 static int __die_find_var_reg_cb(Dwarf_Die *die_mem, void *arg)
 {
@@ -1451,7 +1479,7 @@ static int __die_find_var_reg_cb(Dwarf_Die *die_mem, void *arg)
 		if (data->is_fbreg && ops->atom == DW_OP_fbreg &&
 		    check_allowed_ops(ops, nops) &&
 		    match_var_offset(die_mem, data, data->offset, ops->number,
-				     /*is_pointer=*/false))
+				     is_breg_access_indirect(ops, nops)))
 			return DIE_FIND_CB_END;
 
 		/* Only match with a simple case */
@@ -1463,11 +1491,11 @@ static int __die_find_var_reg_cb(Dwarf_Die *die_mem, void *arg)
 					     /*is_pointer=*/true))
 				return DIE_FIND_CB_END;
 
-			/* Local variables accessed by a register + offset */
+			/* variables accessed by a register + offset */
 			if (ops->atom == (DW_OP_breg0 + data->reg) &&
 			    check_allowed_ops(ops, nops) &&
 			    match_var_offset(die_mem, data, data->offset, ops->number,
-					     /*is_pointer=*/false))
+					     is_breg_access_indirect(ops, nops)))
 				return DIE_FIND_CB_END;
 		} else {
 			/* pointer variables saved in a register 32 or above */
@@ -1477,11 +1505,11 @@ static int __die_find_var_reg_cb(Dwarf_Die *die_mem, void *arg)
 					     /*is_pointer=*/true))
 				return DIE_FIND_CB_END;
 
-			/* Local variables accessed by a register + offset */
+			/* variables accessed by a register + offset */
 			if (ops->atom == DW_OP_bregx && data->reg == ops->number &&
 			    check_allowed_ops(ops, nops) &&
 			    match_var_offset(die_mem, data, data->offset, ops->number2,
-					     /*is_poitner=*/false))
+					     is_breg_access_indirect(ops, nops)))
 				return DIE_FIND_CB_END;
 		}
 	}
-- 
2.51.0.261.g7ce5a0a67e-goog


