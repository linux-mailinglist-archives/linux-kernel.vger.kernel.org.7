Return-Path: <linux-kernel+bounces-723331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 431D6AFE5E4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FEA518984C3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF1D28CF67;
	Wed,  9 Jul 2025 10:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ykc5PPtx"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0D02580F7;
	Wed,  9 Jul 2025 10:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057386; cv=none; b=c9dvmEeCJ6ahR/xKmlbPvwJK8OJgoD4D/6gPk1W1uzwK36UmKPTa7vqDQJst9ABC+GU31rx/uK0xSKMk65c2c1Tv2BEhx/YUWG77k2XEf1GjH70RdR4N6kfpvj2lhnIgyO9gVwzHv07IK8n8+XXh/LRKVhv3dzNpkj17TWsGZw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057386; c=relaxed/simple;
	bh=0ymFJB9KbboYSosezzraNLioZo6TGlf8YQ1eeMXYEPs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RbRZc9iKg9st6Zp5m3Y06770A1miQRWlkeCtVLcD0HGI+4ARyR/7jqMS8ykGDIzb2WOwi+TiCxgWwtJOLVU13cvd8wlDms91HXk+Zp+LcqUCiK7W8jexLe+/BhDtipINxNnZ01B8lWm7Eq7YY4BXo6wmkgdrdbU9juvgexfkHv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ykc5PPtx; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 569AaDh91453015;
	Wed, 9 Jul 2025 05:36:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752057373;
	bh=kUwbZxXvUidWuICcpMpWi7Gq0aS8eGh45D4id751BMU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ykc5PPtxfhPM7jZRzfohY5s1aiQ3ayN/IH63bb7M+pmczTf6qJo74YsCj1gk4yeJ4
	 SXB3bxoYL00Bq9WF6aGj0DpF5orrfKnEwljBDi52IQ4gQtVk8+B65f1VxglIKZ7JuN
	 DR8181SsQbarVuNxxxcUjPzDLe8aW17+g0E5+0hc=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 569AaDOH3270868
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 9 Jul 2025 05:36:13 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 9
 Jul 2025 05:36:13 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 9 Jul 2025 05:36:13 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.245])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 569Aa9Iq3789169;
	Wed, 9 Jul 2025 05:36:10 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <devicetree@vger.kernel.org>,
        Alexander Sverdlin
	<alexander.sverdlin@gmail.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-pinctrl: Enable Schmitt Trigger by default
Date: Wed, 9 Jul 2025 16:05:54 +0530
Message-ID: <175205731408.919009.13331484172952220730.b4-ty@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701105437.3539924-1-alexander.sverdlin@siemens.com>
References: <20250701105437.3539924-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi A. Sverdlin,

On Tue, 01 Jul 2025 12:54:35 +0200, A. Sverdlin wrote:
> Switch Schmitt Trigger functions for PIN_INPUT* macros by default. This is
> HW PoR configuration, the slew rate requirements without ST enabled are
> pretty tough for these devices. We've noticed spurious GPIO interrupts even
> with noise-free edges but not meeting slew rate requirements (3.3E+6 V/s
> for 3.3v LVCMOS).
> 
> It's not obvious why one might want to disable the PoR-enabled ST on any
> pin. Just enable it by default. As it's not possible to provide OR-able
> macros to disable the ST, shall anyone require it, provide a set of
> new macros with _NOST suffix.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-pinctrl: Enable Schmitt Trigger by default
      commit: 5b272127884bded21576a6ddceca13725a351c63

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


