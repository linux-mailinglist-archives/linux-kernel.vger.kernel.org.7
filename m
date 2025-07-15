Return-Path: <linux-kernel+bounces-731210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8389CB050F3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49ED71AA7EB1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 05:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062462D375F;
	Tue, 15 Jul 2025 05:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JA8YKoe/"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B161B2D3750;
	Tue, 15 Jul 2025 05:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752557326; cv=none; b=ZcUOTTLXBNV4C8u3FokMlB+Q2CjaaIfrCWP7HUWllHheV9/JHLpeD9eje/fCkLZRA+TnhGYJS0UxPNTbWI/+MexAnrEAUzW7C9A/39Uh4OGPEA2fi0GJARoI5asT5B58wVEMFPL3qsVjk+e7ykVTI9gpaIF3bvVKX3xyLpikKmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752557326; c=relaxed/simple;
	bh=6dao5/mU1+e27W7yIMCzZW4rcWEmxmPTST4WP08oJeU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sRXkASLSLQuYSs0PkIvAxSOM/QvHYSl55OF6nElhJbvtRdlOR9/UG+EKV8JlNyTNbFjvm82zrXYIXIyL2AZ/XkyGhsPfoXOA1vhgH57oRMHXo2Ksc1IdytJ12QveR1UgJeLtWkjlBycrl4MYoVqCU+eR4rK36Sg4V0+hvuNCMfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JA8YKoe/; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56F5SbfV2816878;
	Tue, 15 Jul 2025 00:28:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752557317;
	bh=Y6AUnD9ldoupswdNyYd5yQBpwXm4lWNRcfH02OFGIUw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=JA8YKoe/7l0GGcUete/ZFMMBunpjDfgH6Gb5caMwDwCvs4dds8Qoxnr6zuo0QouCn
	 Jp41skGTlgFocXdwX6uBEemRbO/dL3Sb4qRT75mqdgxl0rd47XXQiBj7WH9saczdV9
	 yppZ/TItlrO6N1Pqr6JMdowWu/DUeRyhoCmAumLc=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56F5SbIN1036826
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 15 Jul 2025 00:28:37 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 15
 Jul 2025 00:28:36 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 15 Jul 2025 00:28:36 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.245])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56F5SWFb2336977;
	Tue, 15 Jul 2025 00:28:33 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, Hrushikesh Salunke <h-salunke@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <s-vadapalli@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <danishanwar@ti.com>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am69-sk: Add idle-states for remaining SERDES instances
Date: Tue, 15 Jul 2025 10:58:19 +0530
Message-ID: <175240652599.4073742.16760471366856167468.b4-ty@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250708113942.4137917-1-h-salunke@ti.com>
References: <20250708113942.4137917-1-h-salunke@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Hrushikesh Salunke,

On Tue, 08 Jul 2025 17:09:42 +0530, Hrushikesh Salunke wrote:
> In AM69 SoC there are 4 instances of the 4 lane SERDES. So in
> "serdes_ln_ctrl" node there are total 16 entries in "mux-reg-mask"
> property. But "idle-states" is defined only for the lanes of first two
> SERDES instances. SERDES lane mapping is left at its reset state of
> "zero" for all four lanes of SERDES2 and SERDES4. The reset state of
> "zero" corresponds to the following configuration:
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am69-sk: Add idle-states for remaining SERDES instances
      commit: 974e6cfd8d7b61c3fa27a9dd6ed452b7e7a06de9

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


