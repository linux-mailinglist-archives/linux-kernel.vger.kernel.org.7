Return-Path: <linux-kernel+bounces-782649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8386B32321
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B01A2B2181E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 19:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FA12D5C6F;
	Fri, 22 Aug 2025 19:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XEJRFaL+"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF872C15A2;
	Fri, 22 Aug 2025 19:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755891945; cv=none; b=WRn4WNYOWJAPmYWTZZvK9SXEP983ABe9H+ES3jBT9XUYiW3KmfgWo9fgbCxTz5l5ivjXE7aBMmOXL5ATy2GfBvFdszGiPtZIyHro4Iarfoj2D7JAGbwx+Uu2gBJ7NT5zXi8aM8WYVPDFHXKiOpW4OGA+Y9nlItohCBWA+vniOJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755891945; c=relaxed/simple;
	bh=ZKLERqOKgHXb/xzTqRvZ+WYPteXr+Gy7F+ziFJ/AQnQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PH7+AOJGc7klOjF1caPdLjLLhYt5+gJxVOj/Av6scCSsgBixH1II6cn0tV14eExs0e5zc5v22LOZB0vby3oITcmjWNkC0Yce70xeeQg5441c4IdBuXnTCAp+okURRW+e0EWUWogVt4fho6opkZQ9f81pHdRhQ+uYAwlp+ie5B9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XEJRFaL+; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57MJjcpj319191;
	Fri, 22 Aug 2025 14:45:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755891938;
	bh=koQegF4UW9iKzxQUE2TMKsD0Dt3GZxMJZZ6wyyEEhGc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=XEJRFaL+NiFqNf5LwYG/ZDzlzvAozDmTRwwO+34DcAEtNfyH4cYg2HQj1ydPoXMLY
	 jcyCge7Yh9GNz7Qx/3gqp2/qwdfxXwLZi2TCXDFVn7Uey1py+M1T2ISd3WS0g8BKRH
	 uTWwhDAUfsa6k1a8gFJGExpedLXxh+6goXMuLg0Y=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57MJjcqL3503101
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 22 Aug 2025 14:45:38 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 22
 Aug 2025 14:45:38 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 22 Aug 2025 14:45:38 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57MJjcPP4032874;
	Fri, 22 Aug 2025 14:45:38 -0500
From: Nishanth Menon <nm@ti.com>
To: <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        Siddharth Vadapalli
	<s-vadapalli@ti.com>
CC: Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am69-sk: Switch to PCIe Multilink + USB configuration
Date: Fri, 22 Aug 2025 14:45:36 -0500
Message-ID: <175589190685.650517.15346755331299004953.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250819105717.372893-1-s-vadapalli@ti.com>
References: <20250819105717.372893-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Siddharth Vadapalli,

On Tue, 19 Aug 2025 16:27:00 +0530, Siddharth Vadapalli wrote:
> The SERDES0 instance of SERDES on the AM69 SoC is a Cadence Torrent SERDES
> and it has 4 lanes which are allocated in the following manner:
> Lane0 and Lane1 to PCIe1
> Lane2 to PCIe3
> Lane3 to USB0
> 
> Until [0], the Cadence Torrent SERDES driver only supported configuring
> the SERDES for a PCIe + USB configuration whereby all lanes of the
> SERDES configured for PCIe will operate at the same speed. As a result,
> PCIe1 and PCIe3 instances of PCIe will either fall down to a common
> speed based on the PCIe peers that they are each connected to, or, the
> PCIe link could fail to be setup.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am69-sk: Switch to PCIe Multilink + USB configuration
      commit: 76397d42e248335aa41acbf0af6d096220605202

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


