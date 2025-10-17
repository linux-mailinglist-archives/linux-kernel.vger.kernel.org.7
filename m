Return-Path: <linux-kernel+bounces-857312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A23BE67DB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 07:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2250404D20
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 05:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA4430BB9A;
	Fri, 17 Oct 2025 05:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzgpuDiM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6B9211A05
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 05:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760680355; cv=none; b=ROahLIsgnF1QM7qEQOI7/2KT5El3jI3h2tspI62JQsuv20ItyLjx8ac2zMDk3XDojngwVQb9uohJUTFKMQ1qGkydvyFsmegBNKOR/Ko7otCQ3Hhf+pA+hXMHq4CgqyWka4e6CR06zrhDYRSbWCq1qCRERqC9K9K8oTTpLvO2ziw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760680355; c=relaxed/simple;
	bh=3cCds9qDHmtp02xTwdmkuhYBtlQcrlqOIqjib2VRFKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HmKdaLGCbKIcalPZcHPoS6SfTmT9SACItNwaDvOWLyNoH+59SJt0U7oo9Wd/Osu6KHMJ8b5BPEKiySBp/RUgV7tI8xo/4jB/9PDpTiIjCDVfpCNb3QCPVPCQUJEzzFopLtFbgIUrlxk6S8eVFWK5wU9r+b+QRCFL3zCcTZyDlcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzgpuDiM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E303FC4CEE7;
	Fri, 17 Oct 2025 05:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760680354;
	bh=3cCds9qDHmtp02xTwdmkuhYBtlQcrlqOIqjib2VRFKs=;
	h=From:To:Cc:Subject:Date:From;
	b=LzgpuDiMRosgjdrKVmiK5aUC/ThK+rF0UaCt44mOZphqCpgrRsIjrU6LLn2kwS3F4
	 JM30vaTQ8Bd/7LoEsD7MmSHSh/lHQp7S68gnbwfCfkRX72UC6lpXqkzjGYPuwikTas
	 nMOiGV/0tdCKs5Xdk3dYuWtsNv/h99Z4SeUTr7sFROdbhSdHA+J+R2ZV/GlvY7pCDl
	 UWQQ45ac1PbIBlNFxcxyMbfWVPgrJnpwVR3gdvjtwi7Ei1KfUQFjQjSdFws3irxUNK
	 FM5RKC5USi2jrd8df1tq5SXyjsNuLz5i0RX5A78DO5Q6uWadxjReCJWU28sI77rpkG
	 iroywoNTKQvfQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v9dOH-000000001xg-2g2e;
	Fri, 17 Oct 2025 07:52:37 +0200
From: Johan Hovold <johan@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH] irqchip/qcom-irq-combiner: Rename driver structure
Date: Fri, 17 Oct 2025 07:52:26 +0200
Message-ID: <20251017055226.7525-1-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "_probe" suffix of the driver structure name prevents modpost from
warning about section mismatches so replace it to catch any future
issues like the recently fixed probe function being incorrectly marked
as __init.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/irqchip/qcom-irq-combiner.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/qcom-irq-combiner.c b/drivers/irqchip/qcom-irq-combiner.c
index 9308088773be..09819007d08e 100644
--- a/drivers/irqchip/qcom-irq-combiner.c
+++ b/drivers/irqchip/qcom-irq-combiner.c
@@ -266,11 +266,11 @@ static const struct acpi_device_id qcom_irq_combiner_ids[] = {
 	{ }
 };
 
-static struct platform_driver qcom_irq_combiner_probe = {
+static struct platform_driver qcom_irq_combiner_driver = {
 	.driver = {
 		.name = "qcom-irq-combiner",
 		.acpi_match_table = ACPI_PTR(qcom_irq_combiner_ids),
 	},
 	.probe = combiner_probe,
 };
-builtin_platform_driver(qcom_irq_combiner_probe);
+builtin_platform_driver(qcom_irq_combiner_driver);
-- 
2.49.1


