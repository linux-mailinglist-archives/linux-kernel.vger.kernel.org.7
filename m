Return-Path: <linux-kernel+bounces-878440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D23F6C209A7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B4E91A238C2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C2226D4F9;
	Thu, 30 Oct 2025 14:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8DIED+I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6BD1F0E39
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834639; cv=none; b=OTUQoTyGE2xKBMGMpToJGjrv6W1IoT3+Iuny8HlE+dw3T0G9hJqPFjjF6MBNh5VustkDeIT0audTDpRIKNCY6fBcFWtCK+sk3ne/2jge5NKgGT80lvq2vNeL6OXEAtyPFsTmYAcwtIrPnBXp88ARGvRm30kC2dsojomGN+78rn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834639; c=relaxed/simple;
	bh=e3mxbHPnDbeeOfd5pf72XAquxAEEON4CQWxVDtHeawY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kOBp4JsjTns4DIs89QX4rVu6Z6E374vGVQ+ueY3aTN01hYc7Jv7B8nNcRpYgQTsyC3Zvb2lbjhAEwFAvNvcPWwRmtdd+C9/mNY3oFt4CB8AL7ZiG/3OKOnNeMTfe4XNR8bkOTxrUkQ94PfbsqQ6ZGPmdpOBJRFSBly8hYEDpGVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8DIED+I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9098C4CEF1;
	Thu, 30 Oct 2025 14:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761834638;
	bh=e3mxbHPnDbeeOfd5pf72XAquxAEEON4CQWxVDtHeawY=;
	h=From:To:Cc:Subject:Date:From;
	b=L8DIED+Ig4nVBN9ihtie+VndC1LMMRfBQXrjFCITOn6EleClZEtd7KG8EvhGk84hM
	 utdFtJf7IenY+Mp0L4mC2My1W2H0Np5Td/fo7aSEqgWwewlUsmGTckuAZhgyhoS8Q4
	 pbwd4ZqiZK/pNXpZjqw9kvaQcavF+TBvRTFg2Dn41mO2ts7lYZuXwXwCr2bq6DwBKk
	 GzSpTfM1AFkzASGg34EXCOmqV7IWZvMQ9e4EL+L9e8VRJmFpJZTI1eNTkMMdzfnnJF
	 lcMt4yncPlGVLmZvl6iPdlqS6X8u8RaDFczJvWV4gADrOMcdzwke+or7GyAbI+Uw/d
	 CODUTRtKdMgZA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1vETfg-000000010wq-2dyf;
	Thu, 30 Oct 2025 14:30:36 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] genirq: Fix percpu_devid irq affinity documentation
Date: Thu, 30 Oct 2025 14:30:32 +0000
Message-ID: <20251030143032.2035987-1-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, sfr@canb.auug.org.au
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Stephen points out that some of the percpu_devid irq affinity
documentation is either missing or not matching the data structures.

Address all the issues in one go.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 87b0031f7f73 ("irqdomain: Add firmware info reporting interface")
Fixes: 258e7d28a3dc ("genirq: Add affinity to percpu_devid interrupt requests")
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/interrupt.h | 1 +
 include/linux/irqdomain.h | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index fa62ab556ee32..266f2b39213a0 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -109,6 +109,7 @@ typedef irqreturn_t (*irq_handler_t)(int, void *);
  * @name:	name of the device
  * @dev_id:	cookie to identify the device
  * @percpu_dev_id:	cookie to identify the device
+ * @affinity:	CPUs this irqaction is allowed to run on
  * @next:	pointer to the next irqaction for shared interrupts
  * @irq:	interrupt number
  * @flags:	flags (see IRQF_* above)
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 5907baf6099d9..952d3c8dd6b7a 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -48,7 +48,7 @@ struct irq_fwspec {
  * struct irq_fwspec_info - firmware provided IRQ information structure
  *
  * @flags:		Information validity flags
- * @cpumask:		Affinity mask for this interrupt
+ * @affinity:		Affinity mask for this interrupt
  *
  * This structure reports firmware-specific information about an
  * interrupt. The only significant information is the affinity of a
-- 
2.47.3


