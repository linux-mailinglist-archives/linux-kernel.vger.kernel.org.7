Return-Path: <linux-kernel+bounces-805320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BA7B48724
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD88216D953
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31102F28E5;
	Mon,  8 Sep 2025 08:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgaBK3gR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0625B2F1FDB
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 08:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757320072; cv=none; b=R7J9iUkHWvKYSAyzBdqSwZ1puG3r39uQE4dZO5RkQ3U6Fn9PDBJymUVUf4se6l3wFLiuLOdQUnHS3IB0X90Ylwtf5vE7N5uU5y+4WF4FG85iLVP95Ic5U7t1GENfiotTgthIYC0AlJwORyqsTCXq99+b7VR2EwZWDhIccr7TZ8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757320072; c=relaxed/simple;
	bh=UwIstvxlYtiqE5m/jyDtG8VwOO9aujtFcYAYcLjppC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YElZBK3SM7i543kQodOHv+jh7pRxlFcFuHl/xXLOYSDYrt49W5TqjEpH0itcvh9lw7XalZCzISRMEpOncfrjjMTKL2hTSN6jv/kZXL1NcKhGRUuU/kIlQbGnnkfd81lwLpurKwQp07AkSsCFa0GbwHMgbO9N89HgFDk/wJelKEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgaBK3gR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE866C4CEF1;
	Mon,  8 Sep 2025 08:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757320071;
	bh=UwIstvxlYtiqE5m/jyDtG8VwOO9aujtFcYAYcLjppC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SgaBK3gRy2pLYt8ZO3EQDqsT3Gc3hI3gu8GAFXRe+nvpnn3Rz+RfkmwCL1IjO6q3t
	 Fcr9ZwTjB/HapA7mU/JHzk9CiQdif0bai96AKu12fZWwzJE0SSm0TjyAV3qB7ruQfF
	 8lw/RJ6zxOoD9Ms0VMXbthWyw/aUGw+KRoqXTFhG1OUzGCJE0c/Oc4r5bQ0Ak3nveu
	 v4U0HNYlUYfmZudcY4dzNglU48bGHSaI6X2GtbY64aL0bj5E3XPmK0sxnLMAXwV2au
	 5FzGMbVKgRlzpmwdBGOWiJSS087v4YawcpCbgEHGuxMKGYxMpd1qnUnH5phdrxPLWD
	 sAl3Bp1H6OjLg==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH v2 RESEND 1/3] irqchip/gic-v5: Delete a stray tab
Date: Mon,  8 Sep 2025 10:27:43 +0200
Message-ID: <20250908082745.113718-2-lpieralisi@kernel.org>
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

Delete a stray tab that is indenting the code erroneously.

[lpieralisi: reworded log message]

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v5-irs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v5-irs.c b/drivers/irqchip/irq-gic-v5-irs.c
index 13c035727e32..ce2732d649a3 100644
--- a/drivers/irqchip/irq-gic-v5-irs.c
+++ b/drivers/irqchip/irq-gic-v5-irs.c
@@ -571,7 +571,7 @@ static void __init gicv5_irs_init_bases(struct gicv5_irs_chip_data *irs_data,
 			FIELD_PREP(GICV5_IRS_CR1_IST_RA, GICV5_NO_READ_ALLOC)	|
 			FIELD_PREP(GICV5_IRS_CR1_IC, GICV5_NON_CACHE)		|
 			FIELD_PREP(GICV5_IRS_CR1_OC, GICV5_NON_CACHE);
-			irs_data->flags |= IRS_FLAGS_NON_COHERENT;
+		irs_data->flags |= IRS_FLAGS_NON_COHERENT;
 	} else {
 		cr1 = FIELD_PREP(GICV5_IRS_CR1_VPED_WA, GICV5_WRITE_ALLOC)	|
 			FIELD_PREP(GICV5_IRS_CR1_VPED_RA, GICV5_READ_ALLOC)	|
-- 
2.48.0


