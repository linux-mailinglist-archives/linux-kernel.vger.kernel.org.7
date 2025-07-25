Return-Path: <linux-kernel+bounces-746315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F287B12564
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCE9BAE3F86
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C716125CC75;
	Fri, 25 Jul 2025 20:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CTBB0a+R"
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FD225A359
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 20:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753475305; cv=none; b=DTQ2lSjA8rLUkEhnIIWsgicgJoXmD7bUg/3YM6160t9VNXYemKIqfQG3sJX4dWLHP1mbUR4rc+/GG3m3iIsYK+b9dNKiE0J3r0yALmttjt88GW1dXl5I7EdaqonO8pOkt1qIpAQTWk4K3vfEnIYTOboInLONctH4R5Llj+GDV7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753475305; c=relaxed/simple;
	bh=4WUHG3gQhYHFYivqw1IpclYSWeb/z1fqX28zLV0M6hw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rRED8wLF6TLTvNi5R4WmIvr+u3GMxgDCxfTRvdFUFnPg6TZZSIeM3ngVKeebg2BjcjIa0qPIpLmDgtczV4kRR2Lnh8qgzTH5I4yRu/1nAG1IX5pek4YJVjF/HqxxFmKtI6KUK3oqb7GN/Jd8NwgXg1+AphwxhbPISiYETw6By7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CTBB0a+R; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-707205f0405so22634996d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 13:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753475302; x=1754080102; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M0eYSeMuUS/cZaFjj6vw+bFZjqUrA78ZYNsNfFMz9W4=;
        b=CTBB0a+RvgmYLxMQKDPItn3I79dXU/N+JZMQ/ReKU9yMqCMLj9/gz2/HP8QiJyrvR9
         2irvhfgFkwq8op4xL55sD5AInZqszuvb2s8MRgh79AmDQodm1UCiO1jxWMxv+c99P339
         FajrR/Pe2GtZj1Iq+U/b7Tn5/1KfyGAndNg96hinNe6FKUI/Dld47FLr6kkxx74odH0v
         +zWC206X3Yot7zcmfE77hoCYGVkQllm1M5BjG3xjWfqeSDX7Ox2+5TNdcL4djurKz1/S
         6QpSanMDJMgpzYHua3IDpxrLjhdXmJRaxkU/6nFSPyXoUT3DLCnozQFtUhnGusPX1HNa
         3fCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753475302; x=1754080102;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M0eYSeMuUS/cZaFjj6vw+bFZjqUrA78ZYNsNfFMz9W4=;
        b=QvOSdbHWC4avpBriYBThy5hixygAlM5Q9oiaIrlJDokqfOidpd1WsRByl0U1Q1Ueam
         VO+0kbq8b2r9T7UOHWD9iPpDkcODhPkmxx5rOVjPTWS+AfzGaReymIxn/8z6rnAZsEcK
         aBKpj3AiulY9aJx/28mE6pQ3mvRlbk29EBaoBALMipjcU/ruCNhtC3RnC9XDlOXPfv+J
         VoscYbGIT3mAncaB03Hw3/f4KLSf0wkKy3wzI6bJeAq2O/5zVMgqA93hvk2p1XSkP65+
         Y3y2uT2zFV5mbGjkZM5Z9ZHTXdy4S+RQ/MjR4wwUtdvMqThX37sx8MptQFkcyXk3i8kC
         AS0g==
X-Forwarded-Encrypted: i=1; AJvYcCWJIoqaehNM58za16ySW72DMdRif/s/0Kk4NM3d0NNGyybygltNmeJuAKLL5X9anfCYVlxyfT9060LZED8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrO9rxS2GtrHiVX0vWa0NV9APhBy7D/N+7MJ9ga/cGNfmdHjT5
	t6Gy9oisbGado4CyT1pMYTr+kBLDy+miFNk/EYGHSZqKe36vPKOIJtWjCGEra+IT6gPr9PSLTny
	lo+6CLJw/gw==
X-Google-Smtp-Source: AGHT+IGguu6Q5s+hXxqE9U/Ws3a68elF+ciB8met5fbwhcLiqcVm4bFlvEvADCzimGciV5znCZiumxeozGxb
X-Received: from qvb13.prod.google.com ([2002:a05:6214:600d:b0:6fb:5697:95f1])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6214:e46:b0:6fa:ccb6:602a
 with SMTP id 6a1803df08f44-7072053f3f2mr53217756d6.20.1753475302280; Fri, 25
 Jul 2025 13:28:22 -0700 (PDT)
Date: Fri, 25 Jul 2025 20:28:05 +0000
In-Reply-To: <20250725202809.1230085-1-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250725202809.1230085-1-zecheng@google.com>
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250725202809.1230085-3-zecheng@google.com>
Subject: [PATCH v1 2/6] perf dwarf-aux: More accurate variable type match for breg
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

Introduces the function is_breg_access_indirect to determine whether a
memory access involving a DW_OP_breg* operation refers to the variable's
value directly or requires dereferencing the variable's type as a
pointer based on the DWARF expression. Previously, all breg based
accesses were assumed to directly access the variable's value
(is_pointer = false).

The is_breg_access_indirect function handles three main cases:

1. Base register + offset only: (e.g., DW_OP_breg7 RSP+88) The
   calculated address is the location of the variable. The access is
   direct, so no type dereference is needed. Returns false.

2. Base register + offset, followed by other operations ending in
   DW_OP_stack_value, including DW_OP_deref: (e.g., DW_OP_breg7 RSP+96,
   DW_OP_deref, DW_OP_plus_uconst 0x64, DW_OP_stack_value) The DWARF
   expression computes the variable's value, but that value requires a
   dereference. The memory access is fetching that value, so no type
   dereference is needed. Returns false.

3. Base register + offset, followed only by DW_OP_stack_value: (e.g.,
   DW_OP_breg7 RSP+176, DW_OP_stack_value) This indicates the value at
   the base + offset is the variable's value. Since this value is being
   used as an address in the memory access, the variable's type is
   treated as a pointer and requires a type dereference. Returns true.

The is_pointer argument passed to match_var_offset is now set by
is_breg_access_indirect for breg accesses.

Signed-off-by: Zecheng Li <zecheng@google.com>
---
 tools/perf/util/dwarf-aux.c | 42 ++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index bf906dff9ef0..814c96ea509f 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1424,6 +1424,38 @@ static bool match_var_offset(Dwarf_Die *die_mem, struct find_var_data *data,
 	return true;
 }
 
+/**
+ * is_breg_access_indirect - Check if breg based access implies type dereference
+ * @ops: DWARF operations array
+ * @nops: Number of operations in @ops
+ *
+ * Returns true if the DWARF expression indicates the variable's value is
+ * a pointer that the memory access dereferences.
+ * Returns false if the expression evaluates to the variable's value directly.
+ * This is called after check_allowed_ops.
+ */
+static bool is_breg_access_indirect(Dwarf_Op *ops, size_t nops)
+{
+	ops++;
+	nops--;
+
+	/* only the base register */
+	if (nops == 0)
+		return false;
+
+	switch (ops->atom) {
+	case DW_OP_stack_value:
+		return true;
+	case DW_OP_deref_size:
+	case DW_OP_deref:
+	case DW_OP_piece:
+		return false;
+	default:
+		/* unreachable, OP not supported */
+		return false;
+	}
+}
+
 /* Only checks direct child DIEs in the given scope. */
 static int __die_find_var_reg_cb(Dwarf_Die *die_mem, void *arg)
 {
@@ -1452,7 +1484,7 @@ static int __die_find_var_reg_cb(Dwarf_Die *die_mem, void *arg)
 		if (data->is_fbreg && ops->atom == DW_OP_fbreg &&
 		    check_allowed_ops(ops, nops) &&
 		    match_var_offset(die_mem, data, data->offset, ops->number,
-				     /*is_pointer=*/false))
+				     /*is_pointer=*/is_breg_access_indirect(ops, nops)))
 			return DIE_FIND_CB_END;
 
 		/* Only match with a simple case */
@@ -1464,11 +1496,11 @@ static int __die_find_var_reg_cb(Dwarf_Die *die_mem, void *arg)
 					     /*is_pointer=*/true))
 				return DIE_FIND_CB_END;
 
-			/* Local variables accessed by a register + offset */
+			/* variables accessed by a register + offset */
 			if (ops->atom == (DW_OP_breg0 + data->reg) &&
 			    check_allowed_ops(ops, nops) &&
 			    match_var_offset(die_mem, data, data->offset, ops->number,
-					     /*is_pointer=*/false))
+					     /*is_pointer=*/is_breg_access_indirect(ops, nops)))
 				return DIE_FIND_CB_END;
 		} else {
 			/* pointer variables saved in a register 32 or above */
@@ -1478,11 +1510,11 @@ static int __die_find_var_reg_cb(Dwarf_Die *die_mem, void *arg)
 					     /*is_pointer=*/true))
 				return DIE_FIND_CB_END;
 
-			/* Local variables accessed by a register + offset */
+			/* variables accessed by a register + offset */
 			if (ops->atom == DW_OP_bregx && data->reg == ops->number &&
 			    check_allowed_ops(ops, nops) &&
 			    match_var_offset(die_mem, data, data->offset, ops->number2,
-					     /*is_poitner=*/false))
+					     /*is_pointer=*/is_breg_access_indirect(ops, nops)))
 				return DIE_FIND_CB_END;
 		}
 	}
-- 
2.50.1.470.g6ba607880d-goog


