Return-Path: <linux-kernel+bounces-835949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB57BA86B2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 10:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A16C216AD04
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BBB26CE10;
	Mon, 29 Sep 2025 08:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AEDKsbr2"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E515C222584
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 08:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759135197; cv=none; b=K6ZT1q6jm6Hn6kcspop/igs6o0cRlQjUnux6cc3B3hk/FlSk3hCMuPD/ojTqx5Wx1iD1/pI2i9NbivxoTLyfRfj1SBSadOMB6NfD0bIU8DBP2inJEgMXPE8wdhBgIzxc47BcqoCeMY9Fh3CKT6X9TBYFouxKD+QZzHPv0T8krWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759135197; c=relaxed/simple;
	bh=tgyTWWc9iyml5ZCcF1nqLNFofxskc69pTAShj7pd2mM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=FhrRxwXosDuFvRIGRG47hgCyzZBBXbejqGF1GI3bpGyVh+/7u2N+esf1FSh22AQZVEFWzesz2yCxX6oNdeg+B8eDYmhsf7w4MW4xIraxOUAs86ovChuz9vDmKroeWaaXuHnhWYTJY1LT+w3jteFWBWd2hYyCkG61Zut6fjU80yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AEDKsbr2; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=XU5lVVSaP+wA1T1YwcSaR3VIxk5o7QvOy4ynIl9fYiY=; b=AEDKsbr22Fhd37Rm9pG0wF+Ecy
	vMoKiHC/3AMa/WxOZrRHyLf5gqApjEfGdaF/6Thef7me5tM+YR3ITrWv2yqcHaRIuaxg0AC5ezbYU
	NgXcKcjt7xXbfd8oSQjP6QBNl9WVcfx44n6dQ2lK7kVpiIzuU4dQ/DW4cY0x3feQxOXWpAXJUyfjI
	LNCSR119cnMiNI+coQvRRrrL6OFraVw7vWCYbKvSM+UyGX9bGGERhTyM2otMQwDkfiX03uQ596o1P
	zS6tcENf+QKz9yiqEE8ZRdgpZ+aDIHpMHhHk9zQsDeEeDdrpEjrKdV1VEwpwq4Qj5+yEnc29X5khS
	hdZR/xdA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v39QF-0000000BwKS-2Nah;
	Mon, 29 Sep 2025 08:39:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 69328300558; Mon, 29 Sep 2025 10:39:48 +0200 (CEST)
Message-ID: <20250929083609.407282775@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 29 Sep 2025 10:18:55 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org,
 hpa@zytor.com,
 ludloff@gmail.com,
 andrew.cooper3@citrix.com,
 mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 andrii@kernel.org,
 olsajiri@gmail.com,
 jpoimboe@kernel.org
Subject: [RFC][PATCH 2/2] x86/insn: Simplify for_each_insn_prefix()
References: <20250929081853.230968966@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Use the new-found freedom of allowing variable declarions inside
for() to simplify the for_each_insn_prefix() iterator to no longer
need an external temporary.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/boot/compressed/sev-handle-vc.c |    3 +--
 arch/x86/include/asm/insn.h              |    5 ++---
 arch/x86/kernel/kprobes/core.c           |    3 +--
 arch/x86/kernel/uprobes.c                |    6 ++----
 arch/x86/lib/insn-eval.c                 |   12 +++++-------
 tools/arch/x86/include/asm/insn.h        |    5 ++---
 6 files changed, 13 insertions(+), 21 deletions(-)

--- a/arch/x86/boot/compressed/sev-handle-vc.c
+++ b/arch/x86/boot/compressed/sev-handle-vc.c
@@ -29,11 +29,10 @@
 bool insn_has_rep_prefix(struct insn *insn)
 {
 	insn_byte_t p;
-	int i;
 
 	insn_get_prefixes(insn);
 
-	for_each_insn_prefix(insn, i, p) {
+	for_each_insn_prefix(insn, p) {
 		if (p == 0xf2 || p == 0xf3)
 			return true;
 	}
--- a/arch/x86/include/asm/insn.h
+++ b/arch/x86/include/asm/insn.h
@@ -316,7 +316,6 @@ static inline int insn_offset_immediate(
 /**
  * for_each_insn_prefix() -- Iterate prefixes in the instruction
  * @insn: Pointer to struct insn.
- * @idx:  Index storage.
  * @prefix: Prefix byte.
  *
  * Iterate prefix bytes of given @insn. Each prefix byte is stored in @prefix
@@ -325,8 +324,8 @@ static inline int insn_offset_immediate(
  * Since prefixes.nbytes can be bigger than 4 if some prefixes
  * are repeated, it cannot be used for looping over the prefixes.
  */
-#define for_each_insn_prefix(insn, idx, prefix)	\
-	for (idx = 0; idx < ARRAY_SIZE(insn->prefixes.bytes) && (prefix = insn->prefixes.bytes[idx]) != 0; idx++)
+#define for_each_insn_prefix(insn, prefix)	\
+	for (int idx = 0; idx < ARRAY_SIZE(insn->prefixes.bytes) && (prefix = insn->prefixes.bytes[idx]) != 0; idx++)
 
 #define POP_SS_OPCODE 0x1f
 #define MOV_SREG_OPCODE 0x8e
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -141,7 +141,6 @@ bool can_boost(struct insn *insn, void *
 {
 	kprobe_opcode_t opcode;
 	insn_byte_t prefix;
-	int i;
 
 	if (search_exception_tables((unsigned long)addr))
 		return false;	/* Page fault may occur on this address. */
@@ -154,7 +153,7 @@ bool can_boost(struct insn *insn, void *
 	if (insn->opcode.nbytes != 1)
 		return false;
 
-	for_each_insn_prefix(insn, i, prefix) {
+	for_each_insn_prefix(insn, prefix) {
 		insn_attr_t attr;
 
 		attr = inat_get_opcode_attribute(prefix);
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -259,9 +259,8 @@ static volatile u32 good_2byte_insns[256
 static bool is_prefix_bad(struct insn *insn)
 {
 	insn_byte_t p;
-	int i;
 
-	for_each_insn_prefix(insn, i, p) {
+	for_each_insn_prefix(insn, p) {
 		insn_attr_t attr;
 
 		attr = inat_get_opcode_attribute(p);
@@ -1404,7 +1403,6 @@ static int branch_setup_xol_ops(struct a
 {
 	u8 opc1 = OPCODE1(insn);
 	insn_byte_t p;
-	int i;
 
 	if (insn_is_nop(insn))
 		goto setup;
@@ -1437,7 +1435,7 @@ static int branch_setup_xol_ops(struct a
 	 * Intel and AMD behavior differ in 64-bit mode: Intel ignores 66 prefix.
 	 * No one uses these insns, reject any branch insns with such prefix.
 	 */
-	for_each_insn_prefix(insn, i, p) {
+	for_each_insn_prefix(insn, p) {
 		if (p == 0x66)
 			return -ENOTSUPP;
 	}
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -63,11 +63,10 @@ static bool is_string_insn(struct insn *
 bool insn_has_rep_prefix(struct insn *insn)
 {
 	insn_byte_t p;
-	int i;
 
 	insn_get_prefixes(insn);
 
-	for_each_insn_prefix(insn, i, p) {
+	for_each_insn_prefix(insn, p) {
 		if (p == 0xf2 || p == 0xf3)
 			return true;
 	}
@@ -92,13 +91,13 @@ bool insn_has_rep_prefix(struct insn *in
 static int get_seg_reg_override_idx(struct insn *insn)
 {
 	int idx = INAT_SEG_REG_DEFAULT;
-	int num_overrides = 0, i;
+	int num_overrides = 0;
 	insn_byte_t p;
 
 	insn_get_prefixes(insn);
 
 	/* Look for any segment override prefixes. */
-	for_each_insn_prefix(insn, i, p) {
+	for_each_insn_prefix(insn, p) {
 		insn_attr_t attr;
 
 		attr = inat_get_opcode_attribute(p);
@@ -1701,7 +1700,6 @@ bool insn_is_nop(struct insn *insn)
 	u8 sib = 0, sib_scale, sib_index, sib_base;
 	u8 p = 0, rep = 0;
 	u8 nrex, rex;
-	int i;
 
 	if ((nrex = insn->rex_prefix.nbytes)) {
 		rex = insn->rex_prefix.bytes[nrex-1];
@@ -1773,7 +1771,7 @@ bool insn_is_nop(struct insn *insn)
 	if (p == INAT_PFX_REPE)
 		rep = 1;
 
-	for_each_insn_prefix(insn, i, p) {
+	for_each_insn_prefix(insn, p) {
 		if (p == 0xf3) /* REPE */
 			rep = 1;
 	}
@@ -1836,7 +1834,7 @@ bool insn_is_nop(struct insn *insn)
 		if (sib && (sib_scale != 0 || sib_index != 4)) /* (%reg, %eiz, 1) */
 			return false;
 
-		for_each_insn_prefix(insn, i, p) {
+		for_each_insn_prefix(insn, p) {
 			if (p != 0x3e) /* DS */
 				return false;
 		}
--- a/tools/arch/x86/include/asm/insn.h
+++ b/tools/arch/x86/include/asm/insn.h
@@ -312,7 +312,6 @@ static inline int insn_offset_immediate(
 /**
  * for_each_insn_prefix() -- Iterate prefixes in the instruction
  * @insn: Pointer to struct insn.
- * @idx:  Index storage.
  * @prefix: Prefix byte.
  *
  * Iterate prefix bytes of given @insn. Each prefix byte is stored in @prefix
@@ -321,8 +320,8 @@ static inline int insn_offset_immediate(
  * Since prefixes.nbytes can be bigger than 4 if some prefixes
  * are repeated, it cannot be used for looping over the prefixes.
  */
-#define for_each_insn_prefix(insn, idx, prefix)	\
-	for (idx = 0; idx < ARRAY_SIZE(insn->prefixes.bytes) && (prefix = insn->prefixes.bytes[idx]) != 0; idx++)
+#define for_each_insn_prefix(insn, prefix)	\
+	for (int idx = 0; idx < ARRAY_SIZE(insn->prefixes.bytes) && (prefix = insn->prefixes.bytes[idx]) != 0; idx++)
 
 #define POP_SS_OPCODE 0x1f
 #define MOV_SREG_OPCODE 0x8e



