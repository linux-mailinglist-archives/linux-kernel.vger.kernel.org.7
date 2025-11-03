Return-Path: <linux-kernel+bounces-883179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A84C2CC2A
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 16:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5A4D3A8B62
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C46313E23;
	Mon,  3 Nov 2025 15:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0jXFkQg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195B744C63
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182371; cv=none; b=c0zUOhEIZ1LVpV3fACd5osumHV2s23MWlICGIaOTYlk9puiTecsnsu8HN0WXMux2rZl1MvjH7hk/NixurwFRnywcmZwL045xQA3cRXAxWrYJwjCieYWl63lEWnPNrOsE6I9mTrn0OoacQdEnVxfTLdxCJj2Rx0bdevTkm0IbrIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182371; c=relaxed/simple;
	bh=baDm2VqEOdN0jCEUpzXO5wRW1mZqbENh2wIatZtOiw0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Onk2qfYVUy9+sb3iOJVXhjxG/4rYcKLcqmG0kHR0+NA3c1vntIkxUs7ANihCYpREcWoPR6LujD+jUVod/CGUBsNTnfLUbRot8op2h8P/CrZeQAerC35bbeHP4QhJ5W55bXWELNUS0gPx6FvxpfeStCntHFnnZDTsiMtVPTWpCYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0jXFkQg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5616BC4CEE7;
	Mon,  3 Nov 2025 15:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762182370;
	bh=baDm2VqEOdN0jCEUpzXO5wRW1mZqbENh2wIatZtOiw0=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=V0jXFkQgg79lri4jgYsr6IJS4cDNC+4iCc68w0O/pp9woomcRJxiDEMGvpo1hQmUR
	 YPbfjuYCcbxwyeufHBCvq4In1xAgWZMzH//6kPA6RLjWOVXd+jvI+br0txPreWdh7C
	 KRawP8fGjhYZepRnqBPwT5cZEOxvcMDRUBg9tk5CeCzSc745JYWP7Wgzr+UUEpVkO0
	 YF1FlNnAFCItQCia2HdwlCOvmEPjezWpUAAMHRNsYVyvM832uMKd1pEKf5yF1Q6Z45
	 nsUV6IH/pGJhpfg4/mi4I+eiNyT/EjiUUyehDeb8xkDmdua/hgcc07a2+EveFEK96b
	 l+Dgkt07O2VFA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465E3CCFA06;
	Mon,  3 Nov 2025 15:06:10 +0000 (UTC)
From: Aleksa Paunovic via B4 Relay <devnull+aleksa.paunovic.htecgroup.com@kernel.org>
Date: Mon, 03 Nov 2025 16:05:48 +0100
Subject: [PATCH] riscv: Update MIPS vendor id to 0x127.
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-mips-vendorid-v1-1-4fcb5f4d53fe@htecgroup.com>
X-B4-Tracking: v=1; b=H4sIAMvECGkC/x2MQQqAIBBFryKzbkCNCLpKtJAcaxapKEgg3r2h1
 eM9+L9DpcJUYVMdCjWunKKImRSct4sXIXtxsNouRs8GH84VG0WfCnv0QaIjgVlBNrlQ4Pf/248
 xPmYzIjhfAAAA
X-Change-ID: 20251031-mips-vendorid-df103aedf117
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: Djordje Todorovic <djordje.todorovic@htecgroup.com>, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Chao-ying Fu <cfu@wavecomp.com>, 
 Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762182369; l=1072;
 i=aleksa.paunovic@htecgroup.com; s=20250806; h=from:subject:message-id;
 bh=3SOEHxo/iLuGukJm8WAmBVDY7Kaj7mnCfvYaKbPje/c=;
 b=4Kkbdn4PPtXv972XSyF6kf21wrzTj1bJorDUmNmTyjB4IwTbb7oxuMvedD8ZLszZ2g9Nqoo7u
 scJ+8ITMU60CBZIIxKx9oqKbZ2ibIQMpBlaBbdfTKqGsbYUHHuWe1DK
X-Developer-Key: i=aleksa.paunovic@htecgroup.com; a=ed25519;
 pk=Dn4KMnDdgyhlXJNspQQrlHJ04i7/irG29p2H27Avd+8=
X-Endpoint-Received: by B4 Relay for aleksa.paunovic@htecgroup.com/20250806
 with auth_id=476
X-Original-From: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
Reply-To: aleksa.paunovic@htecgroup.com

From: Chao-ying Fu <cfu@wavecomp.com>

[1] defines MIPS vendor id as 0x127.

[1] https://mips.com/wp-content/uploads/2025/06/P8700_Programmers_Reference_Manual_Rev1.84_5-31-2025.pdf

Fixes: a8fed1bc03ace27902338e4f0d318335883ac847 ("riscv: Add xmipsexectl as a vendor extension")
Signed-off-by: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
---
 arch/riscv/include/asm/vendorid_list.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/vendorid_list.h b/arch/riscv/include/asm/vendorid_list.h
index 3b09874d7a6dfb8f8aa45b0be41c20711d539e78..55205f7938055ba2b744dba5118bba935bcac008 100644
--- a/arch/riscv/include/asm/vendorid_list.h
+++ b/arch/riscv/include/asm/vendorid_list.h
@@ -9,6 +9,6 @@
 #define MICROCHIP_VENDOR_ID	0x029
 #define SIFIVE_VENDOR_ID	0x489
 #define THEAD_VENDOR_ID		0x5b7
-#define MIPS_VENDOR_ID		0x722
+#define MIPS_VENDOR_ID		0x127
 
 #endif

---
base-commit: dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa
change-id: 20251031-mips-vendorid-df103aedf117

Best regards,
-- 
Aleksa Paunovic <aleksa.paunovic@htecgroup.com>



