Return-Path: <linux-kernel+bounces-805319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A33BB48721
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D56F2169A91
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE242F069C;
	Mon,  8 Sep 2025 08:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7EWGPpQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA072EFD9C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 08:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757320070; cv=none; b=MWNzl4aJv1bZ525c0KlHRB0nJJAYD8Qrysrox+TGuzNm0iG/re5RSK30s79+pUB0jFVO8bXv3gzWzVmVEZn3H42FM7NU8BwtgINfqYYbURSOgtS1K12fQ6XdAbfMgaTOAzI1EuUbs+RZAfuMi4UMmUh0OLemLi0u6LnCKTT/RJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757320070; c=relaxed/simple;
	bh=Nb3qhP80Nlzt5njY6nq6o7jwZimes1XKvb1BpVbuRyc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oyiMEGm1LvJ7pihiQSpl+Y1DBJgidv+59x6s+soW8b2Xe7C3PH+eOQMI8STP352mSd+vmco/jshQAmIEDZCG5VBiFKerxMB9Rp0y8v5BRUz4tQ+W/mnL8R3teQqB7TdxzxqZ7qNMNXmgx7ddDcWMgCaCmO17y0Z6KxvawcJ+i4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7EWGPpQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F75C4CEF5;
	Mon,  8 Sep 2025 08:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757320069;
	bh=Nb3qhP80Nlzt5njY6nq6o7jwZimes1XKvb1BpVbuRyc=;
	h=From:To:Cc:Subject:Date:From;
	b=A7EWGPpQfQu4EqhlcknsiynPAPp+Z8q4DF00ROmmFAHJwxgE0ohcGftR7RRqSFGz7
	 dRfioxr9+xpGeGr6ObnV8FR2X8ffOUeiOVTNSAr4D01AO763HmjJHxrgfTKzJqPRS9
	 30tT8K8DYCVo1l3mmgNu4kEkaWeVg21aBGmY0CsZhoPXk2mHzunmdvpxkVnasx0TyK
	 fK4apVrDjH54VK2G/cr0RkGAbIaP+l1T6EmXHGt8e0ihqioqeTmSBk+fw6Irb4WgMb
	 HRd7Xqy8Mc0vWik8tQ25DrP79SLl5LmpIm5LcDHrGGAcuqrrNg6h7MZxvVuJAjPxno
	 9XB7IEAtNgMLw==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH v2 RESEND 0/3] irqchip/gic-v5: Holdover fixes
Date: Mon,  8 Sep 2025 10:27:42 +0200
Message-ID: <20250908082745.113718-1-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Thomas,

I am just resending fixes posted by Dan in [1] before the v6.17 merge window
started and GICv5 code was queued for -next to make sure they did not
get lost in the process.

I tested them by forcing the relevant error paths to happen (patches (2)-(3),
for patch (1) there is nothing to test).

Please apply them whenever you deem that suitable, thank you.

[1] https://lore.kernel.org/lkml/670bb1dc-7827-4916-84f3-bb46ee408b20@sabinyo.mountain/

Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Zenghui Yu <yuzenghui@huawei.com>
Cc: Marc Zyngier <maz@kernel.org>

Dan Carpenter (3):
  irqchip/gic-v5: Delete a stray tab
  irqchip/gic-v5: Fix loop in gicv5_its_create_itt_two_level() cleanup
    path
  irqchip/gic-v5: Fix error handling in gicv5_its_irq_domain_alloc()

 drivers/irqchip/irq-gic-v5-irs.c |  2 +-
 drivers/irqchip/irq-gic-v5-its.c | 24 ++++++++++++++++--------
 2 files changed, 17 insertions(+), 9 deletions(-)

-- 
2.48.0


