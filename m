Return-Path: <linux-kernel+bounces-739646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B12B0C91D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 18:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12EF7543CC6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646702E0B71;
	Mon, 21 Jul 2025 16:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="U8PxSP7F"
Received: from sender4-op-o16.zoho.com (sender4-op-o16.zoho.com [136.143.188.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B5C2DAFCF
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 16:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753116840; cv=pass; b=EW7nAs4iW6yxNzUHXFIyo2RFRw2xm+bpdF4PY4JNqHHVf9zcct7VuZFk+fhvArJf1p2lR6PMGo5Nd0nmxTN6m8aIQZ7nsppQZVIykdJlpN8btKqAWJOpQtlxaQ3yUXSTKxcjuPNCB2lCO9AyqeSormvcu9FRyOhe8D8bgEKSvHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753116840; c=relaxed/simple;
	bh=8aa4aOgAFKMJPtQtLgebkKi8jY3Nm5PlNejqTQ4PL4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ksJmdnA4fYh0BGmcaIezJfL7Do5SsbFMOjPng6lf2ZOuLM3ZKP9lqc/4e2TKU918wjQB3NtKFyuvWT5IxLFX70o9jkTC96g51VOuGAB3n8/UtuJIUFYIbkiTOAyKrgfFBU5TFq41fqaT8anKnr/WVqsh00kdjZpaPsr5yWuAVnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=U8PxSP7F; arc=pass smtp.client-ip=136.143.188.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
ARC-Seal: i=1; a=rsa-sha256; t=1753116827; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=e3TQyV2QFyu0BmLM2mtPTTUtOxoInEXuLRXIa3hOb5TPIP2XirJMyuhxH8OT5J5Ot+EUNTvF2ynsvKCIGim4reoKCyiKlRtQqiYKPx+4N3tbVfHnROows7rixKdnbSKgyy6YEUxWkYv7Uhm3f6cTx7pMEWJQrA0blgUfGYQnT0U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753116827; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=guH1gEq7EB4ma+n+Bnc8AILG5/I4uWiJdDHnSwIDV3s=; 
	b=GxNqoq6AnN/NzSyQEPvpSwq3jtDZddeMLmq4tXGaTRTJ/RuSis3J8wHbkvyVW2k+jxgHW0aruCajPAjJXBcsp26amejXnE5YtEgbydzcTnC+8GttjB40V1A15XfY4a6cCwdv6LAc/j4ztRBUjOSl7ZlHEbOrAYNVJyjWDR9BKPY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753116827;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=guH1gEq7EB4ma+n+Bnc8AILG5/I4uWiJdDHnSwIDV3s=;
	b=U8PxSP7FtMQWyzd14INNYozqGxtJN7npBLTh2/40uHYmku+I5EVlLt0B3uiC/T1K
	dWIdxKmKTU4TY4kVp8dI+ElNQQsco7s5MnhekDwmok45hyGjtgSsd2XXs0858HZPlRp
	uaKkDq3HNoClimwmyXEC31WmNvXO0wCcuxEroyRA=
Received: by mx.zohomail.com with SMTPS id 1753116825578288.23596100290104;
	Mon, 21 Jul 2025 09:53:45 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Tue, 22 Jul 2025 00:53:10 +0800
Subject: [PATCH 1/2] riscv: mm: Return intended SATP mode for noXlvl
 options
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-satp-from-fdt-v1-1-5ba22218fa5f@pigmoral.tech>
References: <20250722-satp-from-fdt-v1-0-5ba22218fa5f@pigmoral.tech>
In-Reply-To: <20250722-satp-from-fdt-v1-0-5ba22218fa5f@pigmoral.tech>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Junhui Liu <junhui.liu@pigmoral.tech>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753116810; l=1738;
 i=junhui.liu@pigmoral.tech; s=20250507; h=from:subject:message-id;
 bh=8aa4aOgAFKMJPtQtLgebkKi8jY3Nm5PlNejqTQ4PL4w=;
 b=0CKoQNvGa9bvXhEimcIpVL8cV2IwHutDdliaTsYcDFB2s/xG+tbXSY8Pd0rKGLSdEV9YirlAm
 bGvKT3iLZtJARjcs6a53AKNbwmzVezo9MouD8g4mIaLqC0LNKnRhGDD
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=d3i4H2mg9LUn4SQemoLAjLRQy0nTcyknIv6zgKMwiBA=
X-ZohoMailClient: External

Change the return value of match_noXlvl() to return the SATP mode that
will be used, rather than the mode being disabled. This enables unified
logic for return value judgement with the function that obtains mmu-type
from the fdt, avoiding extra conversion. This only changes the naming,
with no functional impact.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 arch/riscv/kernel/pi/cmdline_early.c | 4 ++--
 arch/riscv/mm/init.c                 | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/pi/cmdline_early.c b/arch/riscv/kernel/pi/cmdline_early.c
index fbcdc9e4e14322af0cedd31343aeb9403ba2dd14..389d086a071876dde2fd57ee6f6661e65c38b7c4 100644
--- a/arch/riscv/kernel/pi/cmdline_early.c
+++ b/arch/riscv/kernel/pi/cmdline_early.c
@@ -41,9 +41,9 @@ static char *get_early_cmdline(uintptr_t dtb_pa)
 static u64 match_noXlvl(char *cmdline)
 {
 	if (strstr(cmdline, "no4lvl"))
-		return SATP_MODE_48;
+		return SATP_MODE_39;
 	else if (strstr(cmdline, "no5lvl"))
-		return SATP_MODE_57;
+		return SATP_MODE_48;
 
 	return 0;
 }
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 8d0374d7ce8ed72320f58e4cea212d0e2bce8fd4..d03e02a92379f2338a4f4df0ab797a7859b83dfc 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -864,9 +864,9 @@ static __init void set_satp_mode(uintptr_t dtb_pa)
 
 	kernel_map.page_offset = PAGE_OFFSET_L5;
 
-	if (satp_mode_cmdline == SATP_MODE_57) {
+	if (satp_mode_cmdline == SATP_MODE_48) {
 		disable_pgtable_l5();
-	} else if (satp_mode_cmdline == SATP_MODE_48) {
+	} else if (satp_mode_cmdline == SATP_MODE_39) {
 		disable_pgtable_l5();
 		disable_pgtable_l4();
 		return;

-- 
2.50.1


