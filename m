Return-Path: <linux-kernel+bounces-871711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E39F0C0E21B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 527564FC6CF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB412FD1A8;
	Mon, 27 Oct 2025 13:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5ZdgJxR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C564E2FC011
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761572302; cv=none; b=PftmNquAhWIUvfoCZ1I/M7tuc/KcMhHLOgczzfuYmmAo/uGSByk9O+xmym3lnICmqujMOPk0BqQDKuNteGt8aTuCx832CbzpBuQ78O/Jjgk9xcQK84uLYWgrm9HANBbA+gWJGeeM0mrW89LE05CryK7YqPVRoQDwEWjFefWQNdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761572302; c=relaxed/simple;
	bh=n1gX487Ji8F9MMeRztdpxusxXwkFcuD1ntzXkoOtN9s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U9fVI8ZjGEIWqwNFf91EAHRQFXfi9YdhlDjG1oiZtZ3uPh1DT386JZTJDWdOtdi0diB/4kneymDcyW8a0cMQWlTbdE05J+lPVu6YZalD9wJfAhwVc8C0esjnBYLsm26opAtEbDr0YzMMi95kZIqBPUbFB+1k8uMLu3376ROhrqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5ZdgJxR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D9EC4CEF1;
	Mon, 27 Oct 2025 13:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761572301;
	bh=n1gX487Ji8F9MMeRztdpxusxXwkFcuD1ntzXkoOtN9s=;
	h=From:To:Cc:Subject:Date:From;
	b=p5ZdgJxRluQe4BUQhOGbiqzLXCCEC7rsrh4cFcL8QjV8Fi5o9ReZuAM72gcU/dc8m
	 m+GQ0KAmGm5BsifHGO0vMl+HiwOsg9amuGMrjITwEoiBQ0+AIPAAjXGgVhgmcm4wJB
	 f7WSFu8ZctKYJLhd1zlC3ljpF1Cg6v21165BsQZVtLHnzlGKNFyrKXy4ETvVs3VwTQ
	 hwricYnofXiclvCy69VJtB43vj60G3Cc0Kzv3gW2Ih1mRyFNNCRPRHgWBSlRI+NEqo
	 yai6oV9J7yh/EBymGZD+cy3lYVWVAHRM15+iUjw0+nx203gXv6060K2dOhpsE5JKS/
	 odNG+wQ2017bw==
From: Borislav Petkov <bp@kernel.org>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] x86/microcode/AMD: Select which microcode patch to load
Date: Mon, 27 Oct 2025 14:38:17 +0100
Message-ID: <20251027133818.4363-1-bp@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Borislav Petkov (AMD)" <bp@alien8.de>

All microcode patches up to the proper BIOS Entrysign fix are loaded
only after the sha256 signature carried in the driver has been verified.

Microcode patches after the Entrysign fix has been applied, do not need
that signature verification anymore.

In order to not abandon machines which haven't received the BIOS update
yet, add the capability to select which microcode patch to load.

The corresponding microcode container supplied through firmware-linux
has been modified to carry two patches per CPU type
(family/model/stepping) so that the proper one gets selected.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Waiman Long <longman@redhat.com>
---
 arch/x86/kernel/cpu/microcode/amd.c | 107 ++++++++++++++++++----------
 1 file changed, 69 insertions(+), 38 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 28ed8c089024..8d3d1114881b 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -186,47 +186,58 @@ static u32 cpuid_to_ucode_rev(unsigned int val)
 	return p.ucode_rev;
 }
 
+static u32 get_cutoff_revision(u32 rev)
+{
+	switch (rev >> 8) {
+	case 0x80012: return 0x8001277; break;
+	case 0x80082: return 0x800820f; break;
+	case 0x83010: return 0x830107c; break;
+	case 0x86001: return 0x860010e; break;
+	case 0x86081: return 0x8608108; break;
+	case 0x87010: return 0x8701034; break;
+	case 0x8a000: return 0x8a0000a; break;
+	case 0xa0010: return 0xa00107a; break;
+	case 0xa0011: return 0xa0011da; break;
+	case 0xa0012: return 0xa001243; break;
+	case 0xa0082: return 0xa00820e; break;
+	case 0xa1011: return 0xa101153; break;
+	case 0xa1012: return 0xa10124e; break;
+	case 0xa1081: return 0xa108109; break;
+	case 0xa2010: return 0xa20102f; break;
+	case 0xa2012: return 0xa201212; break;
+	case 0xa4041: return 0xa404109; break;
+	case 0xa5000: return 0xa500013; break;
+	case 0xa6012: return 0xa60120a; break;
+	case 0xa7041: return 0xa704109; break;
+	case 0xa7052: return 0xa705208; break;
+	case 0xa7080: return 0xa708009; break;
+	case 0xa70c0: return 0xa70C009; break;
+	case 0xaa001: return 0xaa00116; break;
+	case 0xaa002: return 0xaa00218; break;
+	case 0xb0021: return 0xb002146; break;
+	case 0xb1010: return 0xb101046; break;
+	case 0xb2040: return 0xb204031; break;
+	case 0xb4040: return 0xb404031; break;
+	case 0xb6000: return 0xb600031; break;
+	case 0xb7000: return 0xb700031; break;
+	default: break;
+
+	}
+	return 0;
+}
+
 static bool need_sha_check(u32 cur_rev)
 {
+	u32 cutoff;
+
 	if (!cur_rev) {
 		cur_rev = cpuid_to_ucode_rev(bsp_cpuid_1_eax);
 		pr_info_once("No current revision, generating the lowest one: 0x%x\n", cur_rev);
 	}
 
-	switch (cur_rev >> 8) {
-	case 0x80012: return cur_rev <= 0x8001277; break;
-	case 0x80082: return cur_rev <= 0x800820f; break;
-	case 0x83010: return cur_rev <= 0x830107c; break;
-	case 0x86001: return cur_rev <= 0x860010e; break;
-	case 0x86081: return cur_rev <= 0x8608108; break;
-	case 0x87010: return cur_rev <= 0x8701034; break;
-	case 0x8a000: return cur_rev <= 0x8a0000a; break;
-	case 0xa0010: return cur_rev <= 0xa00107a; break;
-	case 0xa0011: return cur_rev <= 0xa0011da; break;
-	case 0xa0012: return cur_rev <= 0xa001243; break;
-	case 0xa0082: return cur_rev <= 0xa00820e; break;
-	case 0xa1011: return cur_rev <= 0xa101153; break;
-	case 0xa1012: return cur_rev <= 0xa10124e; break;
-	case 0xa1081: return cur_rev <= 0xa108109; break;
-	case 0xa2010: return cur_rev <= 0xa20102f; break;
-	case 0xa2012: return cur_rev <= 0xa201212; break;
-	case 0xa4041: return cur_rev <= 0xa404109; break;
-	case 0xa5000: return cur_rev <= 0xa500013; break;
-	case 0xa6012: return cur_rev <= 0xa60120a; break;
-	case 0xa7041: return cur_rev <= 0xa704109; break;
-	case 0xa7052: return cur_rev <= 0xa705208; break;
-	case 0xa7080: return cur_rev <= 0xa708009; break;
-	case 0xa70c0: return cur_rev <= 0xa70C009; break;
-	case 0xaa001: return cur_rev <= 0xaa00116; break;
-	case 0xaa002: return cur_rev <= 0xaa00218; break;
-	case 0xb0021: return cur_rev <= 0xb002146; break;
-	case 0xb1010: return cur_rev <= 0xb101046; break;
-	case 0xb2040: return cur_rev <= 0xb204031; break;
-	case 0xb4040: return cur_rev <= 0xb404031; break;
-	case 0xb6000: return cur_rev <= 0xb600031; break;
-	case 0xb7000: return cur_rev <= 0xb700031; break;
-	default: break;
-	}
+	cutoff = get_cutoff_revision(cur_rev);
+	if (cutoff)
+		return cur_rev <= cutoff;
 
 	pr_info("You should not be seeing this. Please send the following couple of lines to x86-<at>-kernel.org\n");
 	pr_info("CPUID(1).EAX: 0x%x, current revision: 0x%x\n", bsp_cpuid_1_eax, cur_rev);
@@ -473,6 +484,7 @@ static int verify_patch(const u8 *buf, size_t buf_size, u32 *patch_size)
 {
 	u8 family = x86_family(bsp_cpuid_1_eax);
 	struct microcode_header_amd *mc_hdr;
+	u32 cur_rev, cutoff, patch_rev;
 	u32 sh_psize;
 	u16 proc_id;
 	u8 patch_fam;
@@ -512,11 +524,32 @@ static int verify_patch(const u8 *buf, size_t buf_size, u32 *patch_size)
 	proc_id	= mc_hdr->processor_rev_id;
 	patch_fam = 0xf + (proc_id >> 12);
 
-	ucode_dbg("Patch-ID 0x%08x: family: 0x%x\n", mc_hdr->patch_id, patch_fam);
-
 	if (patch_fam != family)
 		return 1;
 
+	cur_rev = get_patch_level();
+
+	/* No cutoff revision means old/unaffected by signing algorithm weakness => matches */
+	cutoff = get_cutoff_revision(cur_rev);
+	if (!cutoff)
+		goto ok;
+
+	patch_rev = mc_hdr->patch_id;
+
+	ucode_dbg("cur_rev: 0x%x, cutoff: 0x%x, patch_rev: 0x%x\n",
+		  cur_rev, cutoff, patch_rev);
+
+	if (cur_rev <= cutoff && patch_rev <= cutoff)
+		goto ok;
+
+	if (cur_rev > cutoff && patch_rev > cutoff)
+		goto ok;
+
+	return 1;
+
+ok:
+	ucode_dbg("Patch-ID 0x%08x: family: 0x%x\n", mc_hdr->patch_id, patch_fam);
+
 	return 0;
 }
 
@@ -585,8 +618,6 @@ static size_t parse_container(u8 *ucode, size_t size, struct cont_desc *desc)
 
 		mc = (struct microcode_amd *)(buf + SECTION_HDR_SIZE);
 
-		ucode_dbg("patch_id: 0x%x\n", mc->hdr.patch_id);
-
 		if (mc_patch_matches(mc, eq_id)) {
 			desc->psize = patch_size;
 			desc->mc = mc;
-- 
2.51.0


