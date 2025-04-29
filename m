Return-Path: <linux-kernel+bounces-624487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E83AAA03FB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 09:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B940B5A6DC1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 07:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5939278E4E;
	Tue, 29 Apr 2025 06:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dot4+qaJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Oh2DXtC/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854A22BF3ED
	for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 06:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745909739; cv=none; b=e/JK3UOButuqsUjtAlebet3rcNZlap7Ik+f4Damcb2ElIdonsynA0p+60JudtxrgEOFZv+U90rggIUa6ATV77KtYVMctvx8tjT5bf2htWCzx4mTCO9xbVMK/E7eYxoe7INXcwhIYTJV210lzw1YJRXHduGBo/ZnEi1mLLjZSuqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745909739; c=relaxed/simple;
	bh=YVtZijiZyzlpE1ERBc6qBMrNAt6o6OH9MDI3lN1aRbk=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=T4Z+D/djB1PKg57Zfaee3gr5CB1tDEjWaWjxfQE3QhVh+YDVOPujsG36pTg6PvBlKmJijTWSr8chAr6IhuA6vKmAywBm6cfh5Gw0dqr+D9c1tLoecXgxHdUVhhqt+Kue1/dbIvG7/YbnHgIIiQQSUofVOaooCv3WLlunR+1Al0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dot4+qaJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Oh2DXtC/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250429065421.954584482@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745909736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=O1SZUl65koY2vfVoG5zr6VPLgG1xPah5aNKSZiQfGVA=;
	b=dot4+qaJF+wH3B82hLDhLvrvEn2bYcwRZRTaPCvqfgfdLQ9JIYSDQWxl17HGnkzWkz6187
	cet/tN6NAConXGZaI3rLzwg3wGCP1Lt0m835a3D7fVEaStwLUM5rd7A8yfPFVoaYMJoPIH
	6FE/9qHx7L1FhBDTcM+oKMdwT6uo7LCYLGADS7z7SDS1BEbJJvFyZQZ60ocU2G3qe41ICo
	XTwdTokNgYwQmXdtK7Voqzn8NWKKdY2UpvdNdrhGjyzFokS6zbi1xLOPYsFdHRVf93xa4i
	EnTrXAWIMVPRgNquJtGhghPmTamVwHvbbswzr26Bq6eW48tlDsfRMYkC8SCmjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745909736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=O1SZUl65koY2vfVoG5zr6VPLgG1xPah5aNKSZiQfGVA=;
	b=Oh2DXtC/UtVXEjPZaK/gUtSWTu29XopnCvUxiTpivkUc+kuI8nxxzcwTiP5F6SbeJHik8q
	oRYTzu6yT0BXlbDw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [patch V2 32/45] genirq/manage: Rework irq_set_vcpu_affinity()
References: <20250429065337.117370076@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Apr 2025 08:55:35 +0200 (CEST)

Use the new guards to get and lock the interrupt descriptor and tidy up the
code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 kernel/irq/manage.c |   40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -627,32 +627,26 @@ int irq_setup_affinity(struct irq_desc *
  */
 int irq_set_vcpu_affinity(unsigned int irq, void *vcpu_info)
 {
-	unsigned long flags;
-	struct irq_desc *desc = irq_get_desc_lock(irq, &flags, 0);
-	struct irq_data *data;
-	struct irq_chip *chip;
-	int ret = -ENOSYS;
+	scoped_irqdesc_get_and_lock(irq, 0) {
+		struct irq_desc *desc = scoped_irqdesc;
+		struct irq_data *data;
+		struct irq_chip *chip;
+		int ret = -ENOSYS;
 
-	if (!desc)
-		return -EINVAL;
+		data = irq_desc_get_irq_data(desc);
+		do {
+			chip = irq_data_get_irq_chip(data);
+			if (chip && chip->irq_set_vcpu_affinity)
+				break;
 
-	data = irq_desc_get_irq_data(desc);
-	do {
-		chip = irq_data_get_irq_chip(data);
-		if (chip && chip->irq_set_vcpu_affinity)
-			break;
-#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
-		data = data->parent_data;
-#else
-		data = NULL;
-#endif
-	} while (data);
+			data = irqd_get_parent_data(data);
+		} while (data);
 
-	if (data)
-		ret = chip->irq_set_vcpu_affinity(data, vcpu_info);
-	irq_put_desc_unlock(desc, flags);
-
-	return ret;
+		if (data)
+			ret = chip->irq_set_vcpu_affinity(data, vcpu_info);
+		return ret;
+	}
+	return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(irq_set_vcpu_affinity);
 




