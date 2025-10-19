Return-Path: <linux-kernel+bounces-859596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D5CBEE0C8
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 10:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D3C2934A758
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 08:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3BE29E0F6;
	Sun, 19 Oct 2025 08:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="NRtyKpz8"
Received: from smtp.smtpout.orange.fr (smtp-72.smtpout.orange.fr [80.12.242.72])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89BA17A309
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 08:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760863282; cv=none; b=qBR/8+xJiGJHhZg1elOoouLk/DaoGNn5wqRNA6YQRmavRl38+Ehex/bfiwJKAAH03SPdx0ZR0a4h5k0S+vVHMED5KIiU5ffNxp5OGHsU/Fp9v9y0AHzm9lggoHIbdbbwz8BCl/FUhxdnuAipSvUOL8oM/zmSxtWitizRH6czcAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760863282; c=relaxed/simple;
	bh=VY0QdSRwwAi2m7B89OrBGn7krD8bMcning4Iyxn0hco=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gwmiTPruAdXasfURtv/vOgb82yL5Cbm1E8y9uQ3GJaLymIzVmIKwzZtCWym1MY1tB45FxVKMP0FoUKTDFEuTIUQN2wcdEnCAtUMRJEGFdO0usGf4yipaIRBKN+H8A9FlZOuS6xHhtmXatXA6PMX6DtCmS7Erq6BNAf0l+TGZz5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=NRtyKpz8; arc=none smtp.client-ip=80.12.242.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id AOxXvSCWoRRqIAOxXvi37N; Sun, 19 Oct 2025 10:40:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1760863212;
	bh=375GixyP2t6cRC27YROhGt0BJh+2sR/VeKf/0aiAJIw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=NRtyKpz8KrUAQq+2PGhYvnKnV5ReagO7sNVGNp+tNrjyftafwfxIgbConJNAjmibs
	 vmNP/nrqXVosUhX2/klptvWDkfTjftRGq8nNxOl4ZdWr5R53d1uy3XJTSHnAh5fOzv
	 zj9l0Du8kV4j1SIjXjATP1eea9vJC5WKPV5NauirJLXhcfPO3UIOBj4ALPkjcWzZqq
	 vTn8GL6GgrtwiwIazbeyIOtBGdXaiHgys9zqo3fisc8DZGhsX9HboBfon/eQbkfdBV
	 8kRnV6s21Z9P/txWhwrG7JbOEJMCiM6uqbRlKCeZ/ezx0+sC+Tylts86JpXei1V/lF
	 U9aeA5PZx6s4A==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 19 Oct 2025 10:40:12 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] genirq/msi: Slightly simplify msi_domain_alloc()
Date: Sun, 19 Oct 2025 10:40:08 +0200
Message-ID: <1ce680114cdb8d40b072c54d7f015696a540e5a6.1760863194.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The return value of irq_find_mapping() is only tested, not used for
anything else.
So, this call can but replaced by a slightly simpler irq_resolve_mapping().

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
For the records and if interested with number, on x86_64, built with
allmodconfig, this also saves some byte-codes.

Before:
======
   text	   data	    bss	    dec	    hex	filename
  44231	   5172	    256	  49659	   c1fb	kernel/irq/msi.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  44026	   5172	    256	  49454	   c12e	kernel/irq/msi.o
---
 kernel/irq/msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index e7ad99254841..68886881fe10 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -706,7 +706,7 @@ static int msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	irq_hw_number_t hwirq = ops->get_hwirq(info, arg);
 	int i, ret;
 
-	if (irq_find_mapping(domain, hwirq) > 0)
+	if (irq_resolve_mapping(domain, hwirq))
 		return -EEXIST;
 
 	if (domain->parent) {
-- 
2.51.0


