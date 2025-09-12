Return-Path: <linux-kernel+bounces-813615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA23B54844
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 670FE7AE364
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655DC285417;
	Fri, 12 Sep 2025 09:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="h4JuWNDQ"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D9B27B4F5;
	Fri, 12 Sep 2025 09:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757670548; cv=none; b=HS6vTj3LYd1qoM34ecFtG15t5giNJZ0t3f2J5y/jN3PSHZ2qgeEhHD4RCdIK18itpH7sf927tnEmjQSoVtaDYm2blGyzSpb5Vvrw0XFRSwvmr4E7SiZFo0qQJfIiiYmR8LX7GSIkV9k9Ti9LjIDDnH7+pqcQSTE48s9qEligayE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757670548; c=relaxed/simple;
	bh=Sdg1NAQGFsOKkh1ScLEOZGGLKMK6oPxVQ3JwS8cbF7Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FrRjW+bXszl1ml0zrKaRhAERkEjwEonz0SdI/62q/J7pbRmHuwWEAlJXpp1r4dWBosyb+8Ei4IsIsGVU2tbliv4UfkQFsnxgVlyff4QVcAsgqeNEybajzRy0ew7J5k2Vp1rvxptA/L4LNEHnjukXhTttJrI8n4qQ6p5toLIDQnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=h4JuWNDQ; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58C9n2E1580003;
	Fri, 12 Sep 2025 04:49:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757670542;
	bh=k2+RB6MUOQtyzxNDapW6pVtIpKR/wAmc57WmHmeFGhs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=h4JuWNDQkmKTC5rEsIYfu5pCqofF1pvE5x7WTBswvkhhc/CH7ko9MFLI9OVrCIv3+
	 x48ALvy2WrpCmlauo7u/JqPOktTHfPiv6DQefxscbVkuYwxABJFUohcl//pOo2wnO+
	 TS3fkQaXj+n257fq8HExvwE3VlT+tgSgTYSwa1vc=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58C9n2F81218723
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 12 Sep 2025 04:49:02 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 12
 Sep 2025 04:49:01 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 12 Sep 2025 04:49:01 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58C9n1An3715971;
	Fri, 12 Sep 2025 04:49:01 -0500
From: Nishanth Menon <nm@ti.com>
To: <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        Beleswar Padhi <b-padhi@ti.com>
CC: Nishanth Menon <nm@ti.com>, <afd@ti.com>, <u-kumar1@ti.com>,
        <hnagalla@ti.com>, <jm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-j742s2-mcu-wakeup: Override firmware-name for MCU R5F cores
Date: Fri, 12 Sep 2025 04:48:57 -0500
Message-ID: <175766786719.25561.15602931252398544025.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250823163111.2237199-1-b-padhi@ti.com>
References: <20250823163111.2237199-1-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Beleswar Padhi,

On Sat, 23 Aug 2025 22:01:11 +0530, Beleswar Padhi wrote:
> The J742S2 SoC reuses the common k3-j784s4-j742s2-mcu-wakeup-common.dtsi
> for its MCU domain, but it does not override the firmware-name property
> for its R5F cores. This causes the wrong firmware binaries to be
> referenced.
> 
> Introduce a new k3-j742s2-mcu-wakeup.dtsi file to override the
> firmware-name property with correct names for J742s2.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-j742s2-mcu-wakeup: Override firmware-name for MCU R5F cores
      commit: 00c8fdc2809f05422d919809106f54c23de3cba3

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


