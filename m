Return-Path: <linux-kernel+bounces-805322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 922FFB4871F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C0271B22C6B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0992F1FDB;
	Mon,  8 Sep 2025 08:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUhJopxZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6128B2F3C32
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 08:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757320074; cv=none; b=GAsKECp4tvWWzSd1qm0Yk9fbD3VUXOApr36g9kfoJpNJkgMmPbBi0GVMKQItKNGACBlWtry2IJPBlNqAkBvSfpi/O5nhmvJLA7vu9fT6zlGCAVFyNpWd6opTEhE82MqycEtxbVOoYwgGWJQsTJZjW3qAWDTX7hNvS4OTKT7lkPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757320074; c=relaxed/simple;
	bh=P/vlG6t4K0nRMEfMtDS6pVBd3+VY1KFLZviC+h88F5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lalbn3AWMi0iJkqRwWWTGxt14PNeoU978cnJcaM2OQTYpuEiCkWzgyuKbRSRYlo/TEgkISg2jFP9lazSSGRJQXueaf5EPTq85F3CUwn9x3FcyOgTBoBXPwy/3TQRin92H+yAsTKo45EZPOBeef0Qd2QEhTrGefW2Xhxf3O1P8ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUhJopxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F76C4CEF5;
	Mon,  8 Sep 2025 08:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757320073;
	bh=P/vlG6t4K0nRMEfMtDS6pVBd3+VY1KFLZviC+h88F5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JUhJopxZVT0XDCNhhdmGwvnjr5AQ++YQD87Z5jb/6SjmVJkLJo37/tKfhl0NOFw0m
	 ikYD4dJRS1uXcK/+coDje9w8jchfyBXBKBdkrkscxIkXknclhJPHHcKZQ9LdCj2n9s
	 wA+CCfn97QsArsl4FtosaA0gwbSJtUN/iYjmneda2ABluTgPS98Q9tLqV019rN1Ua0
	 vYnk2hOAyrd4lieVwva8//OIZ1CY3xTO0cXGKz7HGQoGnvhngp5rdJosD1pDAVDWKH
	 kVWyq4zPmy5lLhgId+45y4urANQwajoNIB09Z7tgDexSVY3pF7fQjEP/9B3q9JqbTG
	 /ESCYn9Kr5DeQ==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH v2 RESEND 2/3] irqchip/gic-v5: Fix loop in gicv5_its_create_itt_two_level() cleanup path
Date: Mon,  8 Sep 2025 10:27:44 +0200
Message-ID: <20250908082745.113718-3-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250908082745.113718-1-lpieralisi@kernel.org>
References: <20250908082745.113718-1-lpieralisi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dan Carpenter <dan.carpenter@linaro.org>

The "i" variable in gicv5_its_create_itt_two_level() needs to be signed
otherwise it would cause a forever loop in the function cleanup path.

[lpieralisi: reworded commit log]

Fixes: 57d72196dfc8 ("irqchip/gic-v5: Add GICv5 ITS support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v5-its.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v5-its.c b/drivers/irqchip/irq-gic-v5-its.c
index 9290ac741949..4701ef62b8b2 100644
--- a/drivers/irqchip/irq-gic-v5-its.c
+++ b/drivers/irqchip/irq-gic-v5-its.c
@@ -191,9 +191,9 @@ static int gicv5_its_create_itt_two_level(struct gicv5_its_chip_data *its,
 					  unsigned int num_events)
 {
 	unsigned int l1_bits, l2_bits, span, events_per_l2_table;
-	unsigned int i, complete_tables, final_span, num_ents;
+	unsigned int complete_tables, final_span, num_ents;
 	__le64 *itt_l1, *itt_l2, **l2ptrs;
-	int ret;
+	int i, ret;
 	u64 val;
 
 	ret = gicv5_its_l2sz_to_l2_bits(itt_l2sz);
-- 
2.48.0


