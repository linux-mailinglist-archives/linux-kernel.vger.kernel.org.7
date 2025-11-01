Return-Path: <linux-kernel+bounces-881241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11456C27CD3
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 12:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D14E71896AEE
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 11:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E7B283FEA;
	Sat,  1 Nov 2025 11:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="FA1uYQ10"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4865285CA3
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 11:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761997080; cv=none; b=IntfT2XJUxzyEir154QH5j9ox17CBBZjdpB1xmZZR4X06uzWKqf22DAI0djAAIi2Z+x6AoKm4iGLljvyU/w817OsuZY8cKZfYZadm5/ob5Fir2Q4Vq2CKClsGbYYp+LhiJ1WlP3/2kb+oQgPWOVZ3llpjNZ21ZkeDmDF/uFINF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761997080; c=relaxed/simple;
	bh=pNDcR1KTKm/T30iTW1kw7zpsKDTjUt4pmLuDVedD8lw=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=pBjXtEFrofrmfNpFTb+f/xhBr+S0QCz1zREANJ+cftNJTY28ecR0KgqCPxuutn4e50AyE2uO4fKxMIkq9UZjWYokT1LPU+4mT1rDmfZWBKZkg68oXYOeqx3lh/7XjC1eitTQBpChUiEKiN6R9KtoGRUnvgaWYXYjz4ACIY6+884=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=FA1uYQ10; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1761996765; bh=CUgEyo6nN7ShpfI6AF428d8IS4iX3QXo/uRoycL/89s=;
	h=From:To:Cc:Subject:Date;
	b=FA1uYQ10A43KA7/O9YZdAOYMXM7xBp1JO1nx1wqx+cszA9T+1i8H85xthdCYbPI2L
	 CqXPty9J+d6VokZy9XBqE0dLeXBVmpcdox5yupP+oBXbqI6cgklq8DsmQingDzXULb
	 EFOxB470q9xcU6ebiAkeCkPuVKlox4LptuI4AMZk=
Received: from ray-virtual-machine.. ([112.96.50.110])
	by newxmesmtplogicsvrszb20-1.qq.com (NewEsmtp) with SMTP
	id 686BAAF2; Sat, 01 Nov 2025 19:26:06 +0800
X-QQ-mid: xmsmtpt1761996366tmrr121w3
Message-ID: <tencent_59CE737B39C37282F84B9CF7765A6C1D8006@qq.com>
X-QQ-XMAILINFO: NX3IH4pixvQAWshGcEEQvgC8Eo3Fo/FLgaa5oCTS5Fe5JVHve2Tf9wPJ9yJNrk
	 21ezElm7i+lbEUaQHiFeMumRB70Pd5gJ91kxD81IHcQ7UO1YLKJPfbqafKWaeiGTX92YfNKW8ut/
	 zoY1RZ47kcP53xxaEtdC/E7P6Zm/cw/JSGGxD8LthoMla2q2h3jj+dsP1nxtl6sgzO8FeubPBpMF
	 sG+BxiH5zCbgqoBRWnAuIrRSzFKq5gv+rH5SKF+hexZJWDM/gVnUafd6QYwhvjLbnOngmqcFiUgY
	 daRETO9qsRBc0eZh5ukWnOHxbWiGPh60SO6gXgGYU6fm6vhw24PBJPODXibT9jijiusjVGAS3KmT
	 wtRm/+hC6TPY9YwDRGEPtwraubWR5l6P//FQRiIqJmfkKS0FV7e+oLln+lWp6RJDXdhAjslI3tao
	 +27GiX1k3Dcp+eCmImy6b+s4GpNLQyE8cIsDPIPs3mp5qu5k85aR7joovAe5vff9xSIIegiOW6JR
	 8UNsUomcF7MNl/mtH3TrpR1/dLk52AU9gLg0vg/28QoGFGwMoVOHnAi+QlQQ0TqFKpRFAU/SxV5J
	 awMItzS2xqx7V8g4nkxSYqghQyi20UJS3SvCRhuFozF/9iXpKnczLiYYfoSzdJghrQkdyjiqqbk8
	 xKJuXFyR2MHK8TsAzc2r/xQVE4nApYy8pGj1YDneDD/ZwJKPPzoSUjuVQBeIeOWxlUo25otm4HFW
	 igdhPwbBr1zvYh6w/YoDB5kNPdOzXElYd+hlk24uSmdaKiQN04+4DzKwLrAVdSyp9sIxEfdW9eE6
	 Qx4dbOXpD/ZRwvLmBDKBQMm5agiVfIuTqBc7JshrddxPR6jXXi3kk2Q+2kj62YlHyGoYNfztioYX
	 t1ZBG9PUABmTraRyZb+vSjrxfcJ0rAzd1blgqsDym4svhcq32FaIl6dCKSozfxYT++4v5fDl98Sz
	 Mg+IyhM4N6MqbOlLGREzZJameW3wqA7SGjdfcRncbypZg+xQKKiJ6Gmm4s0EXB7TpMSd2ivqcEtI
	 TxaJZByNIxfiDxe4HAo7qP6zeNjE0pIAeb81xE4Ooap6saf7Qit6O9XlvnQWYhsKISiAgrVJCtXf
	 gmDfQeSaO7ZiNk2Lty3TifDtLkGMAoIQICvPHm
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: ray <veidongray@qq.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org,
	ray <veidongray@qq.com>
Subject: [PATCH] x86/irq: Precompute nr_legacy_irqs() for performance optimization
Date: Sat,  1 Nov 2025 19:26:04 +0800
X-OQ-MSGID: <20251101112604.45715-1-veidongray@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Precompute the return value of nr_legacy_irqs() in init_ISA_irqs(),
init_IRQ(), and native_init_IRQ() functions to avoid repeated function
calls in loops, improving performance.

Changes made:
- Precompute nr_legacy_irqs() return value in three functions
- Use local variables instead of function calls in loops
- Maintain original logic unchanged

Signed-off-by: ray <veidongray@qq.com>
---
 arch/x86/kernel/irqinit.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/irqinit.c b/arch/x86/kernel/irqinit.c
index 6ab9eac64670..bb7cbf99f65c 100644
--- a/arch/x86/kernel/irqinit.c
+++ b/arch/x86/kernel/irqinit.c
@@ -54,7 +54,7 @@ DEFINE_PER_CPU(vector_irq_t, vector_irq) = {
 void __init init_ISA_irqs(void)
 {
 	struct irq_chip *chip = legacy_pic->chip;
-	int i;
+	int i, nr_legacy;
 
 	/*
 	 * Try to set up the through-local-APIC virtual wire mode earlier.
@@ -66,7 +66,9 @@ void __init init_ISA_irqs(void)
 
 	legacy_pic->init(0);
 
-	for (i = 0; i < nr_legacy_irqs(); i++) {
+	nr_legacy = nr_legacy_irqs();
+
+	for (i = 0; i < nr_legacy; i++) {
 		irq_set_chip_and_handler(i, chip, handle_level_irq);
 		irq_set_status_flags(i, IRQ_LEVEL);
 	}
@@ -74,7 +76,7 @@ void __init init_ISA_irqs(void)
 
 void __init init_IRQ(void)
 {
-	int i;
+	int i, nr_legacy;
 
 	/*
 	 * On cpu 0, Assign ISA_IRQ_VECTOR(irq) to IRQ 0..15.
@@ -84,7 +86,10 @@ void __init init_IRQ(void)
 	 * then this vector space can be freed and re-used dynamically as the
 	 * irq's migrate etc.
 	 */
-	for (i = 0; i < nr_legacy_irqs(); i++)
+
+	nr_legacy = nr_legacy_irqs();
+
+	for (i = 0; i < nr_legacy; i++)
 		per_cpu(vector_irq, 0)[ISA_IRQ_VECTOR(i)] = irq_to_desc(i);
 
 	BUG_ON(irq_init_percpu_irqstack(smp_processor_id()));
@@ -94,6 +99,7 @@ void __init init_IRQ(void)
 
 void __init native_init_IRQ(void)
 {
+	int nr_legacy;
 	/* Execute any quirks before the call gates are initialised: */
 	x86_init.irqs.pre_vector_init();
 
@@ -106,7 +112,9 @@ void __init native_init_IRQ(void)
 
 	lapic_assign_system_vectors();
 
-	if (!acpi_ioapic && !of_ioapic && nr_legacy_irqs()) {
+	nr_legacy = nr_legacy_irqs();
+
+	if (!acpi_ioapic && !of_ioapic && nr_legacy) {
 		/* IRQ2 is cascade interrupt to second interrupt controller */
 		if (request_irq(2, no_action, IRQF_NO_THREAD, "cascade", NULL))
 			pr_err("%s: request_irq() failed\n", "cascade");
-- 
2.34.1


