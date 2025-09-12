Return-Path: <linux-kernel+bounces-813622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B39EFB5485B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D5C417E420
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9C928541A;
	Fri, 12 Sep 2025 09:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="f/Uce/ZG"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A127F285417;
	Fri, 12 Sep 2025 09:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757670688; cv=none; b=suevmVHcdX8NqlZMUS0S1FvmZwGDf77nENAbLdffvb+pe2p/88jpgG14JAgL2W9Z7Ng+aem/Wuc3/bsygLb8KSyxDHO2rEzyRsbZmE2boNmFTODDoiS6HbTreUM14fpqIb7MjikQDziUs1Hqe77CQwHQGOaNN+5sPMAtS/NXHU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757670688; c=relaxed/simple;
	bh=V9qrsEOCQvc0rCGO5IvtfneCBXBfxXW4qDzjKgQZX/8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nlHkkfz3qdVSYK2OO5uttKBN6BIpQO5Tt7NJBSSdjFa9UGAWhFTlfrhqV+4FL++mx6sUa1Rzsn/Ee0vD9xKExSlKehYynCUCTOmp9rsw07fnqERrv+366itghDzWJZ+O2QkYZGwTgvTLbrSXouiyjx7mRvVtIqFU+qrGmFjQkKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=f/Uce/ZG; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58C9pKGu496054;
	Fri, 12 Sep 2025 04:51:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757670680;
	bh=LmafhAICvh/gGRdQhgiSg69lGgUytxA1oJDjGahIJTE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=f/Uce/ZGBlKZ5tln+ujWK5YkVDkUAasP58ovixIKjTXYQgzueVHKR32YZSBVfr2Pk
	 V9LUmtZkDBCuyrYbCt6yoq0VND1Ais995xJWXcPgPon//UPx6xOWTeu+Not9X9pS16
	 r/mURdbdLPFB2Mu1IVs6KK6ZmIOq1DKQ4Mj6ERqc=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58C9pKBY1776813
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 12 Sep 2025 04:51:20 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 12
 Sep 2025 04:51:19 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 12 Sep 2025 04:51:19 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58C9pJJn3414861;
	Fri, 12 Sep 2025 04:51:19 -0500
From: Nishanth Menon <nm@ti.com>
To: <vigneshr@ti.com>, <praneeth@ti.com>, Paresh Bhagat <p-bhagat@ti.com>
CC: Nishanth Menon <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <khasim@ti.com>, <v-singh1@ti.com>,
        <afd@ti.com>, <bb@ti.com>, <devarsht@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH v3 0/2] Add USB support for AM62D2
Date: Fri, 12 Sep 2025 04:51:14 -0500
Message-ID: <175766786895.26001.8838411000303413799.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250903062513.813925-1-p-bhagat@ti.com>
References: <20250903062513.813925-1-p-bhagat@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Paresh Bhagat,

On Wed, 03 Sep 2025 11:55:11 +0530, Paresh Bhagat wrote:
> This patch series introduces following changes:
> 
> * Patch 1 fixes the main pad length in main_pmx/padconfig for AM62D
>  and AM62A. This also fixes "i2c 0-003f: deferred probe pending".
> 
> * Patch 2 enables USB support for AM62D2-EVM by adding pinmux and device
>  tree nodes.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-am62a-main: Fix main padcfg length
      commit: 4c4e48afb6d85c1a8f9fdbae1fdf17ceef4a6f5b
[2/2] arm64: dts: ti: k3-am62d2-evm: Enable USB support
      commit: 5cd40f33273bb41b5eec763bcfc7c9b2e9fe2e64

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
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource


