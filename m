Return-Path: <linux-kernel+bounces-856830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8498BE5312
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 21:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80C715E29BD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9412266EF1;
	Thu, 16 Oct 2025 19:09:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8080259C98;
	Thu, 16 Oct 2025 19:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760641741; cv=none; b=ktyUMbD2UysV1Svo80KK3dkaebC8HH7PeGKwe5/ceyt5zXK7k5hOy8em84HfyxhDh6NsULwGyyQdbUEojCP8rU54UhkScA+PWBQAxLEFzxtzXFXQCo1j9gy3pvCl3uP1fh+XCEwg5FKNPraXl1qfrCIMwBGf2amga3XzDkJ8Y4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760641741; c=relaxed/simple;
	bh=dOv0g/v/VcgHcJpr0BlvqBBGDuuxrQvMLLl9DuYFz58=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DefEVA+qyZ6dvkPFyM+RJzSnvz7CfEuH9gCZqbI7A8Ka9eLztN2V1dCyhAlBx4kgsgPF0Z5DwxabCR7Ujy1tjemiM/biziDTfzMSP8FgxyZ0qbPgg2HJxF73+7NeeHxXTAVVkP0aZ3HnfORz5iRzJWfnihpwPVVQ4vmKXqPmrbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05F8126BA;
	Thu, 16 Oct 2025 12:08:51 -0700 (PDT)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C3193F66E;
	Thu, 16 Oct 2025 12:08:57 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Thu, 16 Oct 2025 20:08:20 +0100
Subject: [PATCH 6/6] mailbox: pcc: Clear any pending responder interrupts
 before enabling it
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-pcc_mb_updates-v1-6-0fba69616f69@arm.com>
References: <20251016-pcc_mb_updates-v1-0-0fba69616f69@arm.com>
In-Reply-To: <20251016-pcc_mb_updates-v1-0-0fba69616f69@arm.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Adam Young <admiyo@os.amperecomputing.com>, 
 Robbie King <robbiek@xsightlabs.com>, Huisong Li <lihuisong@huawei.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, 
 Cristian Marussi <cristian.marussi@arm.com>
X-Mailer: b4 0.14.3

Some platforms may leave a responder interrupt pending from earlier
transactions. If a PCC responder channel has a pending interrupt when
the controller starts up, enabling the IRQ line without first clearing
the condition can lead to a spurious interrupt which could disrupt other
transmissions if the IRQ is shared.

Explicitly clear any pending responder interrupt before enabling the IRQ
to ensure a clean start. Acknowledge the responder channel via
pcc_chan_acknowledge() in startup before requesting/enablement of the
IRQ. This ensures a clean baseline for the first transfer/receiption
of the notification/response.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/mailbox/pcc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 2829ec51b47f..418007020439 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -468,6 +468,12 @@ static int pcc_startup(struct mbox_chan *chan)
 	unsigned long irqflags;
 	int rc;
 
+	/*
+	 * Clear and acknowledge any pending interrupts on responder channel
+	 * before enabling the interrupt
+	 */
+	pcc_chan_acknowledge(pchan);
+
 	if (pchan->plat_irq > 0) {
 		irqflags = pcc_chan_plat_irq_can_be_shared(pchan) ?
 						IRQF_SHARED | IRQF_ONESHOT : 0;

-- 
2.34.1


