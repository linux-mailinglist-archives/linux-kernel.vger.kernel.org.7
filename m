Return-Path: <linux-kernel+bounces-785470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1956FB34B32
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 21:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFE0A2055D8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 19:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343EF291864;
	Mon, 25 Aug 2025 19:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C8KYsIyr"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A052882DB
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 19:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756151666; cv=none; b=uV/1u3FR8brdCc6uZidvzPfHfuowqCa1rmhErHwj3GRKR9rsOFNPywZdUi7ED3TZEkSxLGKftB+FKsDcvrdHuuHvlun9lzdV3ePdXzn66O+ad+GL9x84chnF7oO3Le3eQGs/CJe2pR5GExuf9qMeEGrZzM3LejwuY+HYNaiHg7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756151666; c=relaxed/simple;
	bh=O6fi34kLE2WffLAMr8krbBKjYrYF9u/Vvi/W7cleMsA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ISwOFjz1p1FFPWQr2a2QuhXQ9StmkWB1u6NBS/S0WnP20y9N9kT6pT6afrX8YNjmd75aLIljqUYjW9Yo6yt/VRcsxSP5BC1Ki2lHOGHEwhHi16Y0VYB4X7fTvPCeLAZwhsBm/GIciDMXfzeYU5rjVuGFlliCG0KKrPUxbXiEhk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C8KYsIyr; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-7210f3f176dso14633547b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 12:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756151664; x=1756756464; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zirMWhl4xBXueLBkph4wktZqzKV75VLuK+PtwgK8OPo=;
        b=C8KYsIyrjuwZsffgZ6tMchBdm2u+KhPjz8AyktHrvSdcMcvlqjsjn7sjb/ahzKGMEw
         q8nUgvnTEjfllWthyym8QoVrD1hXD3TFu0XO+CDqaipbqaXLB6oR1/vVo9Ck5cT9x/eq
         xyIRqfRwvvVQP/s9L7Cu1dMCYr+f8Ab5RMAy9j9gTZAIayLb71amtkInnwPXsi072fTQ
         7ruSXUntkeIxVj3Ik5kkIdDJ4W3Pk61yMPP7AuaByB5gw/Oifb/72FCv6+WbQNsm9TWo
         KEIAsGWxyOnrqWgxBSs5KDJWNJrG9qQ2LU2PaJqCEe8sdgGjxXcnUB0Awxq4TvOLsXYg
         K4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756151664; x=1756756464;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zirMWhl4xBXueLBkph4wktZqzKV75VLuK+PtwgK8OPo=;
        b=jgaZkMCT+Is4lDr6fAouUwIWeVB6LVVY16pil7Gkun1pf4s2CvJXzgleU0hxm2WDBb
         N3Vrx8/Mz8H9RYjIa1Go+kTlFB3JFsGf+JUqh4YThymL5SBnC/Kz2Zblwuf7zHryBXfc
         Nkja4oOh5EAewotK1objk8zgFBXsEBLV5ORDUlsidVnuDlroMr4aqhUQJEZ2U3WLiDad
         clQ6+augV2Xqqu9X2lTezeAjQFYJk70oebdUqAj0sTqBf08bfhw5iI5FtKV+b8U0HZwi
         jrPEY2aWjXlFAkPHLmyrV2MPtsmWr5r5HwY/lrtqNI3T3SGBu8eg6jHDozrz7WOBuDBx
         blBg==
X-Forwarded-Encrypted: i=1; AJvYcCXEqq/YVGVQuYedpS9qLsTZECQPGH1085UTfOySJwRw86FoQNLG1f/5BpX/QJutQN3vOnEl0zVggR6sXCI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5K+v9Bd8DahLcsB0nbLROraSHJsinniJL7SADAw123wxMxJpK
	UTmP0BsHuTTsL6FJaRObkNxYgS0QfqYdA07NArigjdoaYwRhwfAsTSUYk9540Sqd2K1hdUzxlo/
	oHcv0v2Apjg==
X-Google-Smtp-Source: AGHT+IHhzKwxA3TibUrFn4/0MjLFsWXvqt/zUi25ZV8iNAIObgEPfgbxXUdrvADXK5z3Km0N7D3B+19FD6zM
X-Received: from ywbhf7.prod.google.com ([2002:a05:690c:6007:b0:720:9ca4:8dec])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:5009:b0:71f:f942:8475
 with SMTP id 00721157ae682-71ff94286camr77440607b3.11.1756151664027; Mon, 25
 Aug 2025 12:54:24 -0700 (PDT)
Date: Mon, 25 Aug 2025 19:54:05 +0000
In-Reply-To: <20250825195412.223077-1-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250825195412.223077-1-zecheng@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250825195412.223077-4-zecheng@google.com>
Subject: [PATCH v2 03/10] perf dwarf-aux: Better variable collection for insn tracking
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

Utilizes the previous is_breg_access_indirect function to determine if
the register + offset stores the variable itself or the struct it points
to, save the information in die_var_type.is_reg_var_addr.

Since we are storing the real types in the stack state, we need to do a
type dereference when is_reg_var_addr is set to false for stack/frame
registers.

For other gp registers, skip the variable when the register is a pointer
to the type. If we want to accept these variables, we might also utilize
is_reg_var_addr in a different way, we need to mark that register as a
pointer to the type.

Signed-off-by: Zecheng Li <zecheng@google.com>
---
 tools/perf/util/annotate-data.c |  9 +++++++++
 tools/perf/util/dwarf-aux.c     | 11 ++++++++++-
 tools/perf/util/dwarf-aux.h     |  2 ++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 1ef2edbc71d9..258157cc43c2 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -868,6 +868,11 @@ static void update_var_state(struct type_state *state, struct data_loc_info *dlo
 			int offset = var->offset;
 			struct type_state_stack *stack;
 
+			/* If the reg location holds the pointer value, dereference the type */
+			if (!var->is_reg_var_addr && is_pointer_type(&mem_die) &&
+				__die_get_real_type(&mem_die, &mem_die) == NULL)
+				continue;
+
 			if (var->reg != DWARF_REG_FB)
 				offset -= fb_offset;
 
@@ -893,6 +898,10 @@ static void update_var_state(struct type_state *state, struct data_loc_info *dlo
 
 			reg = &state->regs[var->reg];
 
+			/* For gp registers, skip the address registers for now */
+			if (var->is_reg_var_addr)
+				continue;
+
 			if (reg->ok && reg->kind == TSR_KIND_TYPE &&
 			    !is_better_type(&reg->type, &mem_die))
 				continue;
diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 449bc9ad7aff..6fd2db5d9381 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1627,13 +1627,22 @@ static int __die_collect_vars_cb(Dwarf_Die *die_mem, void *arg)
 	if (!check_allowed_ops(ops, nops))
 		return DIE_FIND_CB_SIBLING;
 
-	if (die_get_real_type(die_mem, &type_die) == NULL)
+	if (__die_get_real_type(die_mem, &type_die) == NULL)
 		return DIE_FIND_CB_SIBLING;
 
 	vt = malloc(sizeof(*vt));
 	if (vt == NULL)
 		return DIE_FIND_CB_END;
 
+	/* Usually a register holds the value of a variable */
+	vt->is_reg_var_addr = false;
+
+	if (((ops->atom >= DW_OP_breg0 && ops->atom <= DW_OP_breg31) ||
+	      ops->atom == DW_OP_bregx || ops->atom == DW_OP_fbreg) &&
+	      !is_breg_access_indirect(ops, nops))
+		/* The register contains an address of the variable. */
+		vt->is_reg_var_addr = true;
+
 	vt->die_off = dwarf_dieoffset(&type_die);
 	vt->addr = start;
 	vt->reg = reg_from_dwarf_op(ops);
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index 892c8c5c23fc..cd481ec9c5a1 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -148,6 +148,8 @@ struct die_var_type {
 	u64 addr;
 	int reg;
 	int offset;
+	/* Whether the register holds a address to the type */
+	bool is_reg_var_addr;
 };
 
 /* Return type info of a member at offset */
-- 
2.51.0.261.g7ce5a0a67e-goog


