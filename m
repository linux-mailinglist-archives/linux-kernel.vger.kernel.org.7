Return-Path: <linux-kernel+bounces-870941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F42C0C088
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE6E23B1526
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 07:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC632C027C;
	Mon, 27 Oct 2025 07:05:01 +0000 (UTC)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258472F5B
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 07:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761548700; cv=none; b=YYnPgY7lYnIaNOPkqqs+JhWWENi/rJem1ZZy1SFi5pMw6C9K3JStABC9/roiJVZbk5ijbnOMqQO+nEjHXaPsMF8F8T7Sll5yBlunHZ4dEgBIh9izfDOsSK11eaKMBysPcMoNtl8zInmgzNzE4Ki98WXsAOIwwi2ONW5Rl1f7clI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761548700; c=relaxed/simple;
	bh=qGU9eKrvAy6sRhh2qF+2G1/qW4tdEsW+NXohAD0wJBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Lp97Gnbzt13/ysmX4SD1tdT7E2ZGKoqRIamgL1r4Fo2V9FgXmz8Se27ZFR6u/gPbs6q4q9/IRuWQKPFwKgr5OCp6qJvELIy/eAd2zdp2LkGOvnRBYCNqxGR7M9ErKwPNWDg3TCbG3WOwH134A24bp48/44rr08Vigm/FZ+lg+As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=none smtp.mailfrom=linux.spacemit.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
X-QQ-mid: zesmtpsz9t1761548586tdf6a05ae
X-QQ-Originating-IP: SnvZo6rZqu1HMv/YMlq3zJ3p0SQy28vtuoi/p8hkNJ8=
Received: from = ( [183.48.247.177])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 27 Oct 2025 15:03:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 993538249610758676
X-QQ-CSender: troy.mitchell@linux.spacemit.com
Sender: troy.mitchell@linux.spacemit.com
From: Troy Mitchell <troy.mitchell@linux.dev>
Date: Mon, 27 Oct 2025 15:03:00 +0800
Subject: [PATCH v2] riscv/plic: assign context ID based on hartid
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-fix-plic-amp-v2-1-f077b9439112@linux.dev>
X-B4-Tracking: v=1; b=H4sIACMZ/2gC/3WMyw7CIBBFf6WZtWOA1Aeu+h+mCwpTO0mlBJTUN
 Py72L3Lc2/O2SBRZEpwazaIlDnx4iuoQwN2Mv5ByK4yKKFOUiiBI68YZrZongEvanC61WdtTQt
 VCZHqv+fufeWJ02uJn72e5W/9E8oSJToaSRmtzXAV3cz+vR4dZehLKV9DIY8fqAAAAA==
X-Change-ID: 20251020-fix-plic-amp-72bd94969ca4
To: Thomas Gleixner <tglx@linutronix.de>, Paul Walmsley <pjw@kernel.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Troy Mitchell <troy.mitchell@linux.dev>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761548584; l=4685;
 i=troy.mitchell@linux.dev; s=20250710; h=from:subject:message-id;
 bh=qGU9eKrvAy6sRhh2qF+2G1/qW4tdEsW+NXohAD0wJBk=;
 b=QVobr7HfSoGD5b6Tn4MJQ1V02hpGGfuq5xC5UmOXs1nE/R7aokxfR3oT8kPnTydcs5YV0Sstq
 IpuJabINtSYCvVzTmMGjUIMYw1QIplZ5vQaxGYPEzvu6K4dgZ4jiuI9
X-Developer-Key: i=troy.mitchell@linux.dev; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MExkIg7Bfu69me4zLr5MwX8PeHib5G93/iGwuQEtw41iVS237tUMs31+
	Gl6cnsEPQc8MTu6VOKMMGZfWtnXGB0GCOFnuHPOKw8oAsgSX9BG0qrLyItntqcerjuC2Ozi
	O9AxionRuTj9RLRUg3/pcOeXYjZdhfaXL3fn0lTeZeJN2UVbdOxv7qnBnpMaNkchvmBVkvj
	YVOqqWFDkqEjOMcmP3kJxv5ZHyDM8vS6RS87EGUl5wx2NzXpSyJYYHMml63NI3u3p14CPG5
	+ov54eO9f0EB2TMpl5kVqEvumBdf8vkjbehW3kW4Ekf3E6nfoTf/kuGAx9ycu62IztSXTCy
	fERvys0QRsVpTjaxWcy80iV1XFnP25EPcDbxeMPekCtpDTNZ6RAM5pdX4WuEhj9twL7O0Vz
	6FGi5QCnbQiZpdNoVTq93SoR9BvWQmHErgbEe4Zhx7IPd+skhRvwe/gfmqqUcqQUSiKJwFi
	GSzRnK5/iPDGrfrrbEs1lhGensUcx/VOM+GyTLiAQk6n4GnEQykG3rEzoh7xhlXuI3mWilN
	LO83CO5hRfsL+4yh1+0dlBUHL3OSv/yxc4fadN4uAYmHHBpUbTwc0YJtTLqW9roBWunipoR
	MFhntPEBaaxB6vTB1BbiF5pBhdmA3mRMzIuCsjCbLaaq6U39yzyS/6c8XOdQIL0GfhXvXFd
	ta21yXiX/XDCtsto2FdF99/bBMp9v4QlYr/wrkVurXUyMCNfbmJu2LfqwpeqrHzpnTWccMJ
	6Usd4+yg4eFHynFTB2uD7XCeM8mMOjJwaV95gZWyMn8ksOyR3cO0QlKnVSxsgy03To2qbVj
	aMa5+YWZ89c+aZGZdNBQO96gDOkJWGDUTYztD+l9qIWwnnRfb7GcnFG60cIa3H05ea+AGV2
	F7Zg+QcZ/mozs8e/t8HKwy8WuNKgYNjWTq1QPwYhsrz7QV21U4c73Cax2MTUR8S30LZHDEk
	CAmQo1V8QWCHYm/3ecGJvjHx5ahyniZRsDlbcwh8WvqbunBoXBJmNYcyE0bEL000/bk3bU2
	TMDkiw7bxnmSQzF2lHVOE4xheR9qyIk3I6cTzwuhHRnAexMOQSQ2JGriVy8KdPDbSQje6oh
	9jGyINl8ZY4638b2zTGgMjbrWbN317XlA==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

The PLIC driver for OF-based platforms currently assigns 'context_id = i'
within the context loop. This implies an assumption that all harts are
numbered contiguously starting from 0.

In Asymmetric Multi-Processing (AMP) systems, where Linux might boot on
a non-zero hart ID (e.g., hart4), while other harts (e.g., hart0) are
running a different OS, this assumption is violated. This can lead to
 different system inadvertently sharing the same
PLIC enable_base register. Consequently, this causes configuration
conflicts and incorrect interrupt handling.

Assign the PLIC context ID based on the actual hart ID provided by the
OF node. This ensures that each hart context maps to a unique enable
region within the PLIC, thereby resolving conflicts in AMP setups. This
change preserves the correct behavior on Symmetric Multi-Processing (SMP)
and Uniprocessor (UP) systems.

Signed-off-by: Troy Mitchell <troy.mitchell@linux.dev>
---
Changelog in v2:
- add comments
- modify commit message
- use `context_id` instead of `i` when skip contexts other than external
  interrupts for our privilege level
- Link to v1: https://lore.kernel.org/r/20251020-fix-plic-amp-v1-1-defe2a99ab80@linux.dev
---
 drivers/irqchip/irq-sifive-plic.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index cbd7697bc14819cbe3b77096b26901b605491f75..2289eb2f77bbd0da460d22ad3ffcd3e7ef2bde40 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -487,18 +487,18 @@ static int plic_parse_nr_irqs_and_contexts(struct fwnode_handle *fwnode,
 }
 
 static int plic_parse_context_parent(struct fwnode_handle *fwnode, u32 context,
-				     u32 *parent_hwirq, int *parent_cpu, u32 id)
+				     u32 *parent_hwirq, int *parent_cpu, u32 id,
+				     unsigned long *hartid)
 {
 	struct of_phandle_args parent;
-	unsigned long hartid;
 	int rc;
 
 	if (!is_of_node(fwnode)) {
-		hartid = acpi_rintc_ext_parent_to_hartid(id, context);
-		if (hartid == INVALID_HARTID)
+		*hartid = acpi_rintc_ext_parent_to_hartid(id, context);
+		if (*hartid == INVALID_HARTID)
 			return -EINVAL;
 
-		*parent_cpu = riscv_hartid_to_cpuid(hartid);
+		*parent_cpu = riscv_hartid_to_cpuid(*hartid);
 		*parent_hwirq = RV_IRQ_EXT;
 		return 0;
 	}
@@ -507,19 +507,19 @@ static int plic_parse_context_parent(struct fwnode_handle *fwnode, u32 context,
 	if (rc)
 		return rc;
 
-	rc = riscv_of_parent_hartid(parent.np, &hartid);
+	rc = riscv_of_parent_hartid(parent.np, hartid);
 	if (rc)
 		return rc;
 
 	*parent_hwirq = parent.args[0];
-	*parent_cpu = riscv_hartid_to_cpuid(hartid);
+	*parent_cpu = riscv_hartid_to_cpuid(*hartid);
 	return 0;
 }
 
 static int plic_probe(struct fwnode_handle *fwnode)
 {
 	int error = 0, nr_contexts, nr_handlers = 0, cpu, i;
-	unsigned long plic_quirks = 0;
+	unsigned long plic_quirks = 0, hartid;
 	struct plic_handler *handler;
 	u32 nr_irqs, parent_hwirq;
 	struct plic_priv *priv;
@@ -569,14 +569,15 @@ static int plic_probe(struct fwnode_handle *fwnode)
 
 	for (i = 0; i < nr_contexts; i++) {
 		error = plic_parse_context_parent(fwnode, i, &parent_hwirq, &cpu,
-						  priv->acpi_plic_id);
+						  priv->acpi_plic_id, &hartid);
 		if (error) {
 			pr_warn("%pfwP: hwirq for context%d not found\n", fwnode, i);
 			continue;
 		}
 
 		if (is_of_node(fwnode)) {
-			context_id = i;
+			/* each hart has two contexts: M-mode and S-mode */
+			context_id = hartid * 2 + i % 2;
 		} else {
 			context_id = acpi_rintc_get_plic_context(priv->acpi_plic_id, i);
 			if (context_id == INVALID_CONTEXT) {
@@ -594,7 +595,7 @@ static int plic_probe(struct fwnode_handle *fwnode)
 			if (IS_ENABLED(CONFIG_RISCV_M_MODE)) {
 				void __iomem *enable_base = priv->regs +
 					CONTEXT_ENABLE_BASE +
-					i * CONTEXT_ENABLE_SIZE;
+					context_id * CONTEXT_ENABLE_SIZE;
 
 				for (hwirq = 1; hwirq <= nr_irqs; hwirq++)
 					__plic_toggle(enable_base, hwirq, 0);
@@ -694,7 +695,8 @@ static int plic_probe(struct fwnode_handle *fwnode)
 
 fail_cleanup_contexts:
 	for (i = 0; i < nr_contexts; i++) {
-		if (plic_parse_context_parent(fwnode, i, &parent_hwirq, &cpu, priv->acpi_plic_id))
+		if (plic_parse_context_parent(fwnode, i, &parent_hwirq, &cpu,
+					      priv->acpi_plic_id, &hartid))
 			continue;
 		if (parent_hwirq != RV_IRQ_EXT || cpu < 0)
 			continue;

---
base-commit: fdbc36b17e9f2fa24c940959e39df90f53ccce2b
change-id: 20251020-fix-plic-amp-72bd94969ca4

Best regards,
-- 
Troy Mitchell <troy.mitchell@linux.dev>


