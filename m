Return-Path: <linux-kernel+bounces-723330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5213AAFE5E2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3D144E2FC0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C08288C13;
	Wed,  9 Jul 2025 10:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XnBvEUaH"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF4C259CB9;
	Wed,  9 Jul 2025 10:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057357; cv=none; b=aXyyyu0Yjo0dz41M18veJOIv7AidpFUi/rKE5sbw91wD/KUqq2D+L4QRxpoDg2UI2KlkR5p3zBP/TXzmQ6blxcyodEkJ7fBCi4UcOeKGD5GADb7ER4DTUCjbqdWZEcnYKuK5nR18iCBdWmx2KqTKRgY3SvRTxAr1IPETDgWmXcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057357; c=relaxed/simple;
	bh=/ahQ3ZiV6pwWoOwIUd0eBa+odHaQGAbpayrcRK9aFNU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LfFsIi9A3lU2fZmrF4SKeR4uv+G+tb8Zrr9YqVvdXvNXUr5Qv2JOZXxpfSLv7ZvrqONrQpu7x6nPbcfAJIX1KAs6KBB0uFPBNyEft7ylAV26UodVFaIbFRmWyYwrEBAdSnrfsAdA8lpdMqqdCfZ2rHxszWDwodbWPGWpZ6ztIQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XnBvEUaH; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 569AZn6m1424425;
	Wed, 9 Jul 2025 05:35:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752057349;
	bh=BrknXeeMZbINo5PTZY1JnZ/Wo6pKkrTsxFeb+ow++AY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=XnBvEUaHGuOwr+5yuBWxiUIb/uuHwH9cgmHpaBZr0wm3RDD31tdeYHwVzgHim64CW
	 fdt1LvqlpQJsiBjIQvXZoaA1ZWTTha6dwxapT7xuGV0munOfkLevy8+RwyNsYZlhPP
	 y9FBnsEMfOA7icyRa8T9U2Epe2FjZSWqNw/3HjXE=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 569AZnjB1923404
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 9 Jul 2025 05:35:49 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 9
 Jul 2025 05:35:49 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 9 Jul 2025 05:35:49 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.245])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 569AZk8Y3496621;
	Wed, 9 Jul 2025 05:35:46 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Tero Kristo
	<kristo@kernel.org>, Andrew Davis <afd@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: Enable overlays for all DTB files
Date: Wed, 9 Jul 2025 16:05:31 +0530
Message-ID: <175205731408.919009.7168525111458377441.b4-ty@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702145314.71996-1-afd@ti.com>
References: <20250702145314.71996-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Andrew Davis,

On Wed, 02 Jul 2025 09:53:14 -0500, Andrew Davis wrote:
> Allow overlays to be applied to any DTB without manually enabling it
> for each file. This adds around ~10% to the total size of the DTB files
> on average.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: Enable overlays for all DTB files
      commit: bca4146b1f66dbca07591bfd6ad695c699b5a093

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
--
Vignesh


