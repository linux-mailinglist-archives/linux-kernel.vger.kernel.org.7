Return-Path: <linux-kernel+bounces-755356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B44B1A551
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 16:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C24373B063E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D6A215F48;
	Mon,  4 Aug 2025 14:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aR5El4H7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7773F205513
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754319364; cv=none; b=sJ++Z5VIpWsn6qWdhNcPsKr2pmWKLaTnOKMlVSdYyDnqI1fuXouZ4Cn511OjAMyI3I1B6TjdBS3Bo7Fns8l7Lu5qUH2EF4MEciRaNjE5TgyHJKMUP9WkQzf8QWeybctLaHW5/KIBcnJ8NdRKBdPkYlm//To5IF9SlHW8zFzMPs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754319364; c=relaxed/simple;
	bh=AsFEDSuwiU6dwZcqz43qfo52c8csif1QTc3tvddFOGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KUMapcDjS5brBiwfggJ/9vOrZ7oyloIK4R3mC0xl5X96DfpxwykC1Giv2ahE4LGcHrLIdlhb23wSSxurNUacKjWs14wOvG7sIyjfmAqAfDKeQ8o7XNIxbKYCYDxYFXBwyDfAFvx08SzGd1SquAZnY3w93mSt2T4SrlOvIWegcPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aR5El4H7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16BCAC4CEF0;
	Mon,  4 Aug 2025 14:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754319364;
	bh=AsFEDSuwiU6dwZcqz43qfo52c8csif1QTc3tvddFOGs=;
	h=From:To:Cc:Subject:Date:From;
	b=aR5El4H7hWOwyfvGwcp+I+/mD7ivYfdc0H39VN4pQoPcm+DNi4Cps7R13tAhyZKb/
	 715ZJU9cj2P7jgsxnijz5qSUWW6DF0cfBZd6PnMky9KxrMBz9hLffM3vKep4mQ7eIj
	 GVnKvFtq5AT5NO4vJbu5ZUVhN1uu1lmE8GHgfWrcYSUEFmzsXjnHyrFNThydJCRofZ
	 smJx/rbFHjJmbBo6JFEnnHn4leW1tx9aKOUBezjEH96X/57OzjNS6enm7WpDnQiGp/
	 itQOCwISO7d5B7vpvunMS0Zrnqtg5FiAMgPeuE5TCNKrth0rC4cJeGctLUR79Zr8Xl
	 T3AZtRraC845Q==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH] irqchip/msi-lib: Fix fwnode refcount in msi_lib_irq_domain_select()
Date: Mon,  4 Aug 2025 16:55:53 +0200
Message-ID: <20250804145553.795065-1-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 8b65db1e93a2 ("irqchip/msi-lib: Add IRQ_DOMAIN_FLAG_FWNODE_PARENT
handling") added logic in msi_lib_irq_domain_select() to match the
domain fwnode against the fwnode parent of the fwspec.fwnode.

The fwnode_get_parent() caller must call fwnode_handle_put() on the
returned pointer value, lest fwnode refcounting for the parent ends
up being out of kilter.

Fix this by relying on the fwnode_handle clean-up handlers and by
incrementing the fwnode refcount regardless of whether we use
parent matching or not (the domain selection code already holds a
reference before calling msi_lib_irq_domain_select() but to make
the exit path more uniform if IRQ_DOMAIN_FLAG_FWNODE_PARENT is not
set fwnode_handle_get() is called again on fwspec.fwnode so that
the clean-up code is the same for the two matching patterns).

Fixes: 8b65db1e93a2 ("irqchip/msi-lib: Add IRQ_DOMAIN_FLAG_FWNODE_PARENT handling")
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rob Herring <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
---
Hi Thomas, Marc,

Noticed while adding GICv5 ACPI support - I tested this patch on arm64 with
DT (GICv5 and v3) and ACPI (GICv3).

msi_lib_irq_domain_select() is used in other arches, I could not
test on those (don't know if they have non-[DT/irqchip/acpi] specific
fwnodes) - from a fwnode interface perspective I think that this patch
does the right thing, it should not add any issue to existing code
to the best of my knowledge but it has to be verified.

Thanks,
Lorenzo

 drivers/irqchip/irq-msi-lib.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-msi-lib.c b/drivers/irqchip/irq-msi-lib.c
index 454c7f16dd4d..908944009c21 100644
--- a/drivers/irqchip/irq-msi-lib.c
+++ b/drivers/irqchip/irq-msi-lib.c
@@ -133,13 +133,13 @@ int msi_lib_irq_domain_select(struct irq_domain *d, struct irq_fwspec *fwspec,
 {
 	const struct msi_parent_ops *ops = d->msi_parent_ops;
 	u32 busmask = BIT(bus_token);
-	struct fwnode_handle *fwh;
 
 	if (!ops)
 		return 0;
 
-	fwh = d->flags & IRQ_DOMAIN_FLAG_FWNODE_PARENT ? fwnode_get_parent(fwspec->fwnode)
-						       : fwspec->fwnode;
+	struct fwnode_handle *fwh __free(fwnode_handle) =
+		d->flags & IRQ_DOMAIN_FLAG_FWNODE_PARENT ? fwnode_get_parent(fwspec->fwnode)
+							 : fwnode_handle_get(fwspec->fwnode);
 	if (fwh != d->fwnode || fwspec->param_count != 0)
 		return 0;
 
-- 
2.48.0


