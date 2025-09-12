Return-Path: <linux-kernel+bounces-813610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1410B54839
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E3683BA2C1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB652820B1;
	Fri, 12 Sep 2025 09:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="h3oVCo+S"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EEE241663;
	Fri, 12 Sep 2025 09:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757670407; cv=none; b=K6c4xfAdEUO1Q6Fng7xsBU31sLt8Da4JP9UxybZRMjDJTh/bwEZHO713Dfg2STgn3vKXk48MhiixIxRj+U7KyIY1NV/oWUJn2jjK6ppru1vcQTHuzmjSicXlnNxhLo0VCWvxxRlQBTtX/x5h8syBciIqdiG5X2qmHbj7/tUri8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757670407; c=relaxed/simple;
	bh=DA/Xq2GsxY1KYAN7+x3/Jvxwrct9X50zEgqEO3bUWyM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AIxFsL/M9pdDQBdn9pVuBEVMCWczs9dtKf3KKC47tRKoCS2lt1q6Hjq0PW90MZ6J6z8+yHA1KEJQoAj9L9wPHdVWW3TumgfTnDtLtFS1FItoLvXkZxxasfCC6ind0Fzsl55y4lm6xaHOeBUJ027MQKqZ/WYNJcqrn+6veQaMkY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=h3oVCo+S; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58C9kVwf579719;
	Fri, 12 Sep 2025 04:46:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757670391;
	bh=79lD+UZN7+w3yfpLoI0y3gCWro/hQPDPRWzjwz0DUuU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=h3oVCo+Sf9Gu/55IxtFRGR54EiDM3W5ytBriP/OeCnh42mxQujyzFxybH4uIC+rX5
	 fgpfNTrW6E1y88EVbc8hRQbKlyrJ8Ayv6qgZEiRqX4+ZqdNhlb+WTeBWU2b376CI6d
	 xr67A/YXIHxwSdetWrLzpu08tVPMdSBrlBvkBQPM=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58C9kVTf1893099
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 12 Sep 2025 04:46:31 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 12
 Sep 2025 04:46:30 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 12 Sep 2025 04:46:30 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58C9kU003409325;
	Fri, 12 Sep 2025 04:46:30 -0500
From: Nishanth Menon <nm@ti.com>
To: <praneeth@ti.com>, <afd@ti.com>, <vigneshr@ti.com>, <d-gole@ti.com>,
        <u-kumar1@ti.com>, <sebin.francis@ti.com>, <k-willis@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Akashdeep Kaur
	<a-kaur@ti.com>
CC: Nishanth Menon <nm@ti.com>, <vishalm@ti.com>
Subject: Re: [PATCH v6 0/4] Remove unused bits from dts and add support for remaining pinctrl macros
Date: Fri, 12 Sep 2025 04:46:25 -0500
Message-ID: <175766787054.26424.12411839583402198052.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250909044108.2541534-1-a-kaur@ti.com>
References: <20250909044108.2541534-1-a-kaur@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Akashdeep Kaur,

On Tue, 09 Sep 2025 10:11:04 +0530, Akashdeep Kaur wrote:
> This patch series cleans up the dts files to remove the pin control
> DeepSleep configuration that does not take effect in hardware.
> This series also adds the remaining macros in the pin control file
> supported by SoC so that any configuration can be used as per requirement
> in dts files.
> 
> Link to Previous Versions:
>   -V1: https://lore.kernel.org/linux-arm-kernel/20250731115631.3263798-1-a-kaur@ti.com/
>   -V2: https://lore.kernel.org/linux-arm-kernel/20250901122835.3022850-1-a-kaur@ti.com/
>   -V3: https://lore.kernel.org/linux-arm-kernel/20250902071917.1616729-1-a-kaur@ti.com/
>   -V4: https://lore.kernel.org/linux-arm-kernel/20250904112538.529857-1-a-kaur@ti.com/
>   -V5: https://lore.kernel.org/linux-arm-kernel/20250905051448.2836237-1-a-kaur@ti.com/
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/4] arm64: dts: ti: k3-am62p5-sk: Remove the unused cfg in USB1_DRVVBUS
      commit: fe0e018b05f118cb8e5c8cd77dd74185b2cb7177
[2/4] arm64: dts: ti: k3-am62x-sk-common: Remove the unused cfg in USB1_DRVVBUS
      commit: 121babfed84a0c6d7ebee4486db4fbd9a900d9f5
[3/4] arm64: dts: ti: k3-pinctrl: Add the remaining macros
      commit: 42558822658e0ad249a8f109fd053e3bad4476e9
[4/4] arm64: dts: ti: k3-pinctrl: Fix the bug in existing macros
      commit: 2e79ee4d64e9ba4a3fc90e91dfd715407efab16d

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


