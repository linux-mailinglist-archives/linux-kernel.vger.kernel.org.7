Return-Path: <linux-kernel+bounces-753022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC9EB17DDC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 09:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFDB5A81090
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 07:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F086520B1F4;
	Fri,  1 Aug 2025 07:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/bAdO6t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEF4208994
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 07:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754035121; cv=none; b=UY6KDkeTfZYQrjOuDAAZJwcSUBSjAbyjYaxtq+wSQl930TVdTbSaGJDUEp72fhT6QSrTY6nnaoGkU62OFzVjS0uI6IZl2VFcn1HDQDd9zhG8YPOy8qTL8vGQwH/lXpGp+28j+thQ6oFlKNejXvUuMGG++e6Iez36EJT6cS8xjeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754035121; c=relaxed/simple;
	bh=ljibB/ctJYFLkO9vQS1KGFA64OMGWVieVJTPRuAfKhU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QvSse7juCeNFRlqUwtAPaJkTtb/D8NH8442vIJWUWkqh76mXneMYYb3iDLqN1jKhvM/OdbdtzkCtb9UXDMcRNhcorxqCDIH0qo0x6u4Pf8EeySoBP0tbyIMK9i6L+oqxcEuW7y6ULspkMegPv/at7V0LTlTurBP2T3ji9dG12cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/bAdO6t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3009C4CEE7;
	Fri,  1 Aug 2025 07:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754035120;
	bh=ljibB/ctJYFLkO9vQS1KGFA64OMGWVieVJTPRuAfKhU=;
	h=From:Subject:Date:To:Cc:From;
	b=j/bAdO6tAieIMYHyfxqtpt4IUoDEIGaiH1k8+Tbu9WvYd8YfEe6JyWuTlLttNdndo
	 YRYmTiGZzyc4zWwkbLyJaM7VC0c3ncWSMxGo36qo6czTBKkWH1MSAJjVaLXxbFX3pX
	 K9jmMYBXp/KfnHLEbsQNvZG0Fc5bHExQRd2O+BZY9iSJEbODj42VcjHmhvan6ELQMV
	 ykaMo7aNghki2zgp3DnTbFbJeeLstt/uBjIjAWNavki0DktTKb/HYOv14xP7k9JXJE
	 Z+B9xfOs2xHdJ9y9VO57z7o2e2pqcD6V0BIfdH6IPJMMj/R44rLXnTN8HoTHhxBx4V
	 CaBuI7VFOHpwg==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: [PATCH 0/3] irqchip/gic-v5: Minor clean-ups/fixes
Date: Fri, 01 Aug 2025 09:58:17 +0200
Message-Id: <20250801-gic-v5-fixes-6-17-v1-0-4fcedaccf9e6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJlzjGgC/x3LQQqAIBBA0avIrBtQy8SuEi3EJpuNhUIE4t2Tl
 o/Pr1AoMxVYRIVMDxe+UocaBITTp0jIezdoqY20o8LIAR+DB79UcEZl0U2OPI3BGDdB/+5Mf+3
 burX2ASzeG7BjAAAA
X-Change-ID: 20250731-gic-v5-fixes-6-17-949eae3c5594
To: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Sascha Bischoff <sascha.bischoff@arm.com>, 
 Timothy Hayes <timothy.hayes@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.15-dev-6f78e

A trivial fix for a kbot reported issue and two clean-ups
discovered after the initial series was queued for v6.17;
now that the driver code is merged I am sharing them.

Only patch (1) is a fix, the two others are cleaning the code up
and removing useless constructs.

The series apply cleanly on top of this three-patch series [1] fixing
some exit path issues with the gic-v5 driver that should also
be considered for merging please (I reviewed it and tested it [2]):

[1] https://lore.kernel.org/lkml/670bb1dc-7827-4916-84f3-bb46ee408b20@sabinyo.mountain/
[2] https://lore.kernel.org/lkml/aHoU8sKPuyzEFRIn@lpieralisi/

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
---
Lorenzo Pieralisi (3):
      irqchip/gic-v5: iwb: Fix iounmap probe failure path
      irqchip/gic-v5: iwb: Remove module boilerplate
      irqchip/gic-v5: Remove IRQD_RESEND_WHEN_IN_PROGRESS for ITS IRQs

 drivers/irqchip/irq-gic-v5-its.c |  1 -
 drivers/irqchip/irq-gic-v5-iwb.c | 14 +++-----------
 2 files changed, 3 insertions(+), 12 deletions(-)
---
base-commit: 260f6f4fda93c8485c8037865c941b42b9cba5d2
change-id: 20250731-gic-v5-fixes-6-17-949eae3c5594

Best regards,
-- 
Lorenzo Pieralisi <lpieralisi@kernel.org>


