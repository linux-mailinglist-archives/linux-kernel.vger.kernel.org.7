Return-Path: <linux-kernel+bounces-766874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E6EB24C45
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 782621C222A7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500392F4A16;
	Wed, 13 Aug 2025 14:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="H56pN8Da"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B082267387;
	Wed, 13 Aug 2025 14:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755095737; cv=none; b=RLYd5UR6X77Xkq6f76cMuN+cCrziR54dlkc0lfTSAT08WUBj9ALU4FYOdy4meHZRxbCxT6kLLbD16w/gmtaR6j9O6ZzEX/E31C8z+pJLrno9hub5+YpP0i4G0cMO0/60xBKjT4oocqV81F1ZDOqMBDc5lJ2mNRNml+RRuISSwmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755095737; c=relaxed/simple;
	bh=I9pYODd9df6b67za2xvvQUyG6iFFWFVzHbhxFcqOrgc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Doe04baAyNZjKQkNV0runr4SmOVisPp1oHV4ph82wcBsHiTvNe3w6R5Bl/vMx+ix7MauPMCW8Kx10Fk6RJXvwyeBhX/62HpPoYqRuaNjKHqG2rebuU9NO7j19MdQa50lU11bwOngy4rNTp7JPucRrylpZaeVp/WoVqpcj2VexQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=H56pN8Da; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57DEZULa2093635;
	Wed, 13 Aug 2025 09:35:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755095730;
	bh=itfQeuJgZ6yMyr17lXJ1F1UsA0C2s68L7ZMyeo8E+LE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=H56pN8DacZuRV0udq5J4QuMR/9tF4DDPtpsxxag/DFNfwpF6XldLasLNPdyNCHPDQ
	 5zuVCjjeBE3vDT5UFsALLlnItp/SflOKshQEx2bTVFDqMT/ClOJvS+pHt8j7w1InAZ
	 YTIc9Ufe6hJhby7RLG7tXnpbAh/Xq9CIklcMcZlw=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57DEZU5o125880
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 13 Aug 2025 09:35:30 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 13
 Aug 2025 09:35:30 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 13 Aug 2025 09:35:30 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57DEZUrA2137696;
	Wed, 13 Aug 2025 09:35:30 -0500
From: Nishanth Menon <nm@ti.com>
To: <linux-kernel@vger.kernel.org>, Brandon Brnich <b-brnich@ti.com>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        Devarsh
 Thakkar <devarsht@ti.com>, Udit Kumar <u-kumar1@ti.com>,
        Darren Etheridge
	<detheridge@ti.com>
Subject: Re: [PATCH v3] arm64: dts: ti: k3-j722s-main: Add E5010 JPEG Encoder
Date: Wed, 13 Aug 2025 09:35:28 -0500
Message-ID: <175509562183.158870.18075844501777832548.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250808155555.2632451-1-b-brnich@ti.com>
References: <20250808155555.2632451-1-b-brnich@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Brandon Brnich,

On Fri, 08 Aug 2025 10:55:55 -0500, Brandon Brnich wrote:
> This adds node for E5010 JPEG Encoder which is a stateful JPEG Encoder
> present in J722s SoC, supporting baseline encoding of semiplanar based
> YUV420 and YUV422 raw video formats to JPEG encoding, with resolutions
> supported from 64x64 to 8kx8k.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].

NOTE: I looked at the comment from Krzysztof[2] about the generic node name, and
I am assuming that jpeg-encoder is generic enough here.

Thank you!

[1/1] arm64: dts: ti: k3-j722s-main: Add E5010 JPEG Encoder
      commit: 47a32605c6e7f283f373b56e9caf97c56b7e5634

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
[2] https://lore.kernel.org/all/b5ba5a22-dc0a-423b-963f-5db6c7e04665@kernel.org/
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource


