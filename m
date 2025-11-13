Return-Path: <linux-kernel+bounces-899880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E8CC5905B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C20584A2020
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33782363C5F;
	Thu, 13 Nov 2025 16:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SiDNlWAh"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A1E33BBCD
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052585; cv=none; b=ml679+BSMFMwXFZkO+/YWwftqjpDVaeqX7ANtdCqSeOrmQOZxRN4pesaORw+C/pyNyWcAOVws4E4E94kCqVvEslnTX856jy0YodG1KvajcSS6gBkdjzBb9reTH8zparsQq+YaeSXAoDUIPGE3/ApH+wqaq6qAjr1tbqC75iuSJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052585; c=relaxed/simple;
	bh=jnb+jw4cJX0KYewnHVML539qHFFynflD2IXsBim5+Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sji/eP47l7gurVyYXyzCrjT818/s7j8krkMUJjdjAknE5I4Hp2G1XfES9fPb793/BTqIfBUPGHpQKqrEGgRqivuvbjb1VgUSqnQJcZvDaO64roJI8IwpNx9AHjIvdyi4ZnT8dkDxpAIUA3iuSQqsnoozMpztoaRM7ustDmJxLaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SiDNlWAh; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADEAVwJ006599;
	Thu, 13 Nov 2025 16:49:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=HGtNP
	jlJ6RQLlQzEl+bxrsWOw+SssZH+N/YbRTfEQDA=; b=SiDNlWAhUqbCcIJuMd0e2
	c3TUDRXpk2Bt+5emWJtIXt/j7VlywtWknfEl6fdBivLsc4nT0DhDVGZb8kzqP50w
	PTh/US0sO8TsnMIyYS0fkxz5jrWI7QHtdvTyB5ChXbxu0/Bw90CsASWMKV/Wj7a2
	GC151/hPkla++09Bg8ZZ6Eq8GORl6cReXaneZW8OVJUpoQoZ4eZh9z7S5UNHhbY8
	PZ4QR+g8ZmJEyEgaYbHTA05TbGIoC/dzC0vIU9JEdMH87HLa1YnQF62tLhgC5bl+
	EjF7xKwlQmWvuz7uSf7Ob5uYyOv/DQb8p3Jq/28ld/No3c/qaYL7CwdN+DbLKF8g
	w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acyraa674-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:49:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADGGeLg039056;
	Thu, 13 Nov 2025 16:49:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vacc3e2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:49:34 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ADGnKA1008288;
	Thu, 13 Nov 2025 16:49:33 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-154-172-143.vpn.oracle.com [10.154.172.143])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vacc38f-9;
	Thu, 13 Nov 2025 16:49:33 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH v4 08/28] objtool: Extract code to validate instruction from the validate branch loop
Date: Thu, 13 Nov 2025 17:48:57 +0100
Message-ID: <20251113164917.2563486-9-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251113164917.2563486-1-alexandre.chartre@oracle.com>
References: <20251113164917.2563486-1-alexandre.chartre@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_03,2025-11-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511130130
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE1MSBTYWx0ZWRfX0xCfDh8y6NVQ
 17bxwz2M8F0tVPS/GM0XUOW6ZV/iUnFvXEAcTmUBpmZXEhcLyO1OM1lcK8upAJ1fNcaHVeDStKJ
 vYyOh1Mq60Nx72C0tyrUdMzh+uiYT+NWxkJGym0nJ5rTRw6ZRA1HN9NVbSKCsz/fYieZvwfbIpO
 D/l80DEhFHe4sN3JfrpbJ7jcot/JUNAE6W5Fb5KIkdAnR7H4F4DoHrOT6mFyIndUZtBPJqpbqS8
 9UuU8bEfCCJZ1+t6nh2u9yvb6/kvRpHvRdK1Jgy09wo5nsThXnfb7Ctod5R5t5ZOu/KwjHBuu4r
 4SaovKGLofE9bfhF5hfudYUvHYCe6KslAIyZ+nXh25ZZ8/8uykWXDPkcNl8zS8EXTv2BGXNnMKZ
 ocW2UslPregtOol5XLrctJCDnc2hhA==
X-Proofpoint-GUID: cUm2NIBAWXYO3CwI99kfcfnKeiEZ-Bo8
X-Authority-Analysis: v=2.4 cv=ILgPywvG c=1 sm=1 tr=0 ts=69160c1f cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=45N9rFkX92oTsxCXvtEA:9
X-Proofpoint-ORIG-GUID: cUm2NIBAWXYO3CwI99kfcfnKeiEZ-Bo8

The code to validate a branch loops through all instructions of the
branch and validate each instruction. Move the code to validate an
instruction to a separated function.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 tools/objtool/check.c | 392 ++++++++++++++++++++++--------------------
 1 file changed, 208 insertions(+), 184 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 5b977bdb5512f..609994ad6ab41 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3535,256 +3535,280 @@ static bool skip_alt_group(struct instruction *insn)
 	return alt_insn->type == INSN_CLAC || alt_insn->type == INSN_STAC;
 }
 
-/*
- * Follow the branch starting at the given instruction, and recursively follow
- * any other branches (jumps).  Meanwhile, track the frame pointer state at
- * each instruction and validate all the rules described in
- * tools/objtool/Documentation/objtool.txt.
- */
 static int validate_branch(struct objtool_file *file, struct symbol *func,
-			   struct instruction *insn, struct insn_state state)
+			   struct instruction *insn, struct insn_state state);
+
+static int validate_insn(struct objtool_file *file, struct symbol *func,
+			 struct instruction *insn, struct insn_state *statep,
+			 struct instruction *prev_insn, struct instruction *next_insn,
+			 bool *dead_end)
 {
 	struct alternative *alt;
-	struct instruction *next_insn, *prev_insn = NULL;
-	struct section *sec;
 	u8 visited;
 	int ret;
 
-	if (func && func->ignore)
-		return 0;
+	/*
+	 * Any returns before the end of this function are effectively dead
+	 * ends, i.e. validate_branch() has reached the end of the branch.
+	 */
+	*dead_end = true;
 
-	sec = insn->sec;
+	visited = VISITED_BRANCH << statep->uaccess;
+	if (insn->visited & VISITED_BRANCH_MASK) {
+		if (!insn->hint && !insn_cfi_match(insn, &statep->cfi))
+			return 1;
 
-	while (1) {
-		next_insn = next_insn_to_validate(file, insn);
+		if (insn->visited & visited)
+			return 0;
+	} else {
+		nr_insns_visited++;
+	}
 
-		if (func && insn_func(insn) && func != insn_func(insn)->pfunc) {
-			/* Ignore KCFI type preambles, which always fall through */
-			if (!strncmp(func->name, "__cfi_", 6) ||
-			    !strncmp(func->name, "__pfx_", 6) ||
-			    !strncmp(func->name, "__pi___cfi_", 11) ||
-			    !strncmp(func->name, "__pi___pfx_", 11))
-				return 0;
+	if (statep->noinstr)
+		statep->instr += insn->instr;
 
-			if (file->ignore_unreachables)
-				return 0;
+	if (insn->hint) {
+		if (insn->restore) {
+			struct instruction *save_insn, *i;
 
-			WARN("%s() falls through to next function %s()",
-			     func->name, insn_func(insn)->name);
-			func->warned = 1;
+			i = insn;
+			save_insn = NULL;
 
-			return 1;
-		}
+			sym_for_each_insn_continue_reverse(file, func, i) {
+				if (i->save) {
+					save_insn = i;
+					break;
+				}
+			}
 
-		visited = VISITED_BRANCH << state.uaccess;
-		if (insn->visited & VISITED_BRANCH_MASK) {
-			if (!insn->hint && !insn_cfi_match(insn, &state.cfi))
+			if (!save_insn) {
+				WARN_INSN(insn, "no corresponding CFI save for CFI restore");
 				return 1;
+			}
 
-			if (insn->visited & visited)
-				return 0;
-		} else {
-			nr_insns_visited++;
+			if (!save_insn->visited) {
+				/*
+				 * If the restore hint insn is at the
+				 * beginning of a basic block and was
+				 * branched to from elsewhere, and the
+				 * save insn hasn't been visited yet,
+				 * defer following this branch for now.
+				 * It will be seen later via the
+				 * straight-line path.
+				 */
+				if (!prev_insn)
+					return 0;
+
+				WARN_INSN(insn, "objtool isn't smart enough to handle this CFI save/restore combo");
+				return 1;
+			}
+
+			insn->cfi = save_insn->cfi;
+			nr_cfi_reused++;
 		}
 
-		if (state.noinstr)
-			state.instr += insn->instr;
+		statep->cfi = *insn->cfi;
+	} else {
+		/* XXX track if we actually changed statep->cfi */
 
-		if (insn->hint) {
-			if (insn->restore) {
-				struct instruction *save_insn, *i;
+		if (prev_insn && !cficmp(prev_insn->cfi, &statep->cfi)) {
+			insn->cfi = prev_insn->cfi;
+			nr_cfi_reused++;
+		} else {
+			insn->cfi = cfi_hash_find_or_add(&statep->cfi);
+		}
+	}
 
-				i = insn;
-				save_insn = NULL;
+	insn->visited |= visited;
 
-				sym_for_each_insn_continue_reverse(file, func, i) {
-					if (i->save) {
-						save_insn = i;
-						break;
-					}
-				}
+	if (propagate_alt_cfi(file, insn))
+		return 1;
 
-				if (!save_insn) {
-					WARN_INSN(insn, "no corresponding CFI save for CFI restore");
-					return 1;
-				}
+	if (insn->alts) {
+		for (alt = insn->alts; alt; alt = alt->next) {
+			ret = validate_branch(file, func, alt->insn, *statep);
+			if (ret) {
+				BT_INSN(insn, "(alt)");
+				return ret;
+			}
+		}
+	}
 
-				if (!save_insn->visited) {
-					/*
-					 * If the restore hint insn is at the
-					 * beginning of a basic block and was
-					 * branched to from elsewhere, and the
-					 * save insn hasn't been visited yet,
-					 * defer following this branch for now.
-					 * It will be seen later via the
-					 * straight-line path.
-					 */
-					if (!prev_insn)
-						return 0;
+	if (skip_alt_group(insn))
+		return 0;
 
-					WARN_INSN(insn, "objtool isn't smart enough to handle this CFI save/restore combo");
-					return 1;
-				}
+	if (handle_insn_ops(insn, next_insn, statep))
+		return 1;
 
-				insn->cfi = save_insn->cfi;
-				nr_cfi_reused++;
-			}
+	switch (insn->type) {
 
-			state.cfi = *insn->cfi;
-		} else {
-			/* XXX track if we actually changed state.cfi */
+	case INSN_RETURN:
+		return validate_return(func, insn, statep);
 
-			if (prev_insn && !cficmp(prev_insn->cfi, &state.cfi)) {
-				insn->cfi = prev_insn->cfi;
-				nr_cfi_reused++;
-			} else {
-				insn->cfi = cfi_hash_find_or_add(&state.cfi);
-			}
+	case INSN_CALL:
+	case INSN_CALL_DYNAMIC:
+		ret = validate_call(file, insn, statep);
+		if (ret)
+			return ret;
+
+		if (opts.stackval && func && !is_special_call(insn) &&
+		    !has_valid_stack_frame(statep)) {
+			WARN_INSN(insn, "call without frame pointer save/setup");
+			return 1;
 		}
 
-		insn->visited |= visited;
+		break;
 
-		if (propagate_alt_cfi(file, insn))
-			return 1;
+	case INSN_JUMP_CONDITIONAL:
+	case INSN_JUMP_UNCONDITIONAL:
+		if (is_sibling_call(insn)) {
+			ret = validate_sibling_call(file, insn, statep);
+			if (ret)
+				return ret;
 
-		if (insn->alts) {
-			for (alt = insn->alts; alt; alt = alt->next) {
-				ret = validate_branch(file, func, alt->insn, state);
-				if (ret) {
-					BT_INSN(insn, "(alt)");
-					return ret;
-				}
+		} else if (insn->jump_dest) {
+			ret = validate_branch(file, func,
+					      insn->jump_dest, *statep);
+			if (ret) {
+				BT_INSN(insn, "(branch)");
+				return ret;
 			}
 		}
 
-		if (skip_alt_group(insn))
+		if (insn->type == INSN_JUMP_UNCONDITIONAL)
 			return 0;
 
-		if (handle_insn_ops(insn, next_insn, &state))
-			return 1;
-
-		switch (insn->type) {
-
-		case INSN_RETURN:
-			return validate_return(func, insn, &state);
+		break;
 
-		case INSN_CALL:
-		case INSN_CALL_DYNAMIC:
-			ret = validate_call(file, insn, &state);
+	case INSN_JUMP_DYNAMIC:
+	case INSN_JUMP_DYNAMIC_CONDITIONAL:
+		if (is_sibling_call(insn)) {
+			ret = validate_sibling_call(file, insn, statep);
 			if (ret)
 				return ret;
+		}
 
-			if (opts.stackval && func && !is_special_call(insn) &&
-			    !has_valid_stack_frame(&state)) {
-				WARN_INSN(insn, "call without frame pointer save/setup");
-				return 1;
-			}
+		if (insn->type == INSN_JUMP_DYNAMIC)
+			return 0;
 
-			break;
+		break;
 
-		case INSN_JUMP_CONDITIONAL:
-		case INSN_JUMP_UNCONDITIONAL:
-			if (is_sibling_call(insn)) {
-				ret = validate_sibling_call(file, insn, &state);
-				if (ret)
-					return ret;
+	case INSN_SYSCALL:
+		if (func && (!next_insn || !next_insn->hint)) {
+			WARN_INSN(insn, "unsupported instruction in callable function");
+			return 1;
+		}
 
-			} else if (insn->jump_dest) {
-				ret = validate_branch(file, func,
-						      insn->jump_dest, state);
-				if (ret) {
-					BT_INSN(insn, "(branch)");
-					return ret;
-				}
-			}
+		break;
 
-			if (insn->type == INSN_JUMP_UNCONDITIONAL)
-				return 0;
+	case INSN_SYSRET:
+		if (func && (!next_insn || !next_insn->hint)) {
+			WARN_INSN(insn, "unsupported instruction in callable function");
+			return 1;
+		}
 
+		return 0;
+
+	case INSN_STAC:
+		if (!opts.uaccess)
 			break;
 
-		case INSN_JUMP_DYNAMIC:
-		case INSN_JUMP_DYNAMIC_CONDITIONAL:
-			if (is_sibling_call(insn)) {
-				ret = validate_sibling_call(file, insn, &state);
-				if (ret)
-					return ret;
-			}
+		if (statep->uaccess) {
+			WARN_INSN(insn, "recursive UACCESS enable");
+			return 1;
+		}
 
-			if (insn->type == INSN_JUMP_DYNAMIC)
-				return 0;
+		statep->uaccess = true;
+		break;
 
+	case INSN_CLAC:
+		if (!opts.uaccess)
 			break;
 
-		case INSN_SYSCALL:
-			if (func && (!next_insn || !next_insn->hint)) {
-				WARN_INSN(insn, "unsupported instruction in callable function");
-				return 1;
-			}
+		if (!statep->uaccess && func) {
+			WARN_INSN(insn, "redundant UACCESS disable");
+			return 1;
+		}
 
-			break;
+		if (func_uaccess_safe(func) && !statep->uaccess_stack) {
+			WARN_INSN(insn, "UACCESS-safe disables UACCESS");
+			return 1;
+		}
 
-		case INSN_SYSRET:
-			if (func && (!next_insn || !next_insn->hint)) {
-				WARN_INSN(insn, "unsupported instruction in callable function");
-				return 1;
-			}
+		statep->uaccess = false;
+		break;
 
-			return 0;
+	case INSN_STD:
+		if (statep->df) {
+			WARN_INSN(insn, "recursive STD");
+			return 1;
+		}
 
-		case INSN_STAC:
-			if (!opts.uaccess)
-				break;
+		statep->df = true;
+		break;
 
-			if (state.uaccess) {
-				WARN_INSN(insn, "recursive UACCESS enable");
-				return 1;
-			}
+	case INSN_CLD:
+		if (!statep->df && func) {
+			WARN_INSN(insn, "redundant CLD");
+			return 1;
+		}
 
-			state.uaccess = true;
-			break;
+		statep->df = false;
+		break;
 
-		case INSN_CLAC:
-			if (!opts.uaccess)
-				break;
+	default:
+		break;
+	}
 
-			if (!state.uaccess && func) {
-				WARN_INSN(insn, "redundant UACCESS disable");
-				return 1;
-			}
+	*dead_end = insn->dead_end;
 
-			if (func_uaccess_safe(func) && !state.uaccess_stack) {
-				WARN_INSN(insn, "UACCESS-safe disables UACCESS");
-				return 1;
-			}
+	return 0;
+}
 
-			state.uaccess = false;
-			break;
+/*
+ * Follow the branch starting at the given instruction, and recursively follow
+ * any other branches (jumps).  Meanwhile, track the frame pointer state at
+ * each instruction and validate all the rules described in
+ * tools/objtool/Documentation/objtool.txt.
+ */
+static int validate_branch(struct objtool_file *file, struct symbol *func,
+			   struct instruction *insn, struct insn_state state)
+{
+	struct instruction *next_insn, *prev_insn = NULL;
+	struct section *sec;
+	bool dead_end;
+	int ret;
 
-		case INSN_STD:
-			if (state.df) {
-				WARN_INSN(insn, "recursive STD");
-				return 1;
-			}
+	if (func && func->ignore)
+		return 0;
 
-			state.df = true;
-			break;
+	sec = insn->sec;
 
-		case INSN_CLD:
-			if (!state.df && func) {
-				WARN_INSN(insn, "redundant CLD");
-				return 1;
-			}
+	while (1) {
+		next_insn = next_insn_to_validate(file, insn);
 
-			state.df = false;
-			break;
+		if (func && insn_func(insn) && func != insn_func(insn)->pfunc) {
+			/* Ignore KCFI type preambles, which always fall through */
+			if (!strncmp(func->name, "__cfi_", 6) ||
+			    !strncmp(func->name, "__pfx_", 6) ||
+			    !strncmp(func->name, "__pi___cfi_", 11) ||
+			    !strncmp(func->name, "__pi___pfx_", 11))
+				return 0;
 
-		default:
-			break;
+			if (file->ignore_unreachables)
+				return 0;
+
+			WARN("%s() falls through to next function %s()",
+			     func->name, insn_func(insn)->name);
+			func->warned = 1;
+
+			return 1;
 		}
 
-		if (insn->dead_end)
-			return 0;
+		ret = validate_insn(file, func, insn, &state, prev_insn, next_insn,
+				    &dead_end);
+		if (dead_end)
+			break;
 
 		if (!next_insn) {
 			if (state.cfi.cfa.base == CFI_UNDEFINED)
@@ -3802,7 +3826,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 		insn = next_insn;
 	}
 
-	return 0;
+	return ret;
 }
 
 static int validate_unwind_hint(struct objtool_file *file,
-- 
2.43.5


