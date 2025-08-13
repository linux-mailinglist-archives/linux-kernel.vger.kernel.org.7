Return-Path: <linux-kernel+bounces-766862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B021B24C0A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCDBD7BAE01
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25901DE8B5;
	Wed, 13 Aug 2025 14:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZiAeBJYc"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C4B1DE896;
	Wed, 13 Aug 2025 14:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755095542; cv=none; b=RKX2IZJvYfl3xef55u72KXWYwqyoSDinr4i1yEjNg81g3CPO1m/G5baPB2GaYSoaHrBgxvgi/+7fRxdG7LUTgISmc3xs9BFGZgDmtAfdVRMTWuw2IZRL9drVb2UI/q62TVnj6Ly8KTvvfTMgEhAg1GmyCGm5p+eIz1196k9Iaz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755095542; c=relaxed/simple;
	bh=/EhEWG9EO9qtvc4CfChN1MldpWaQ//ZskyMXUA+S+UA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=msokv4iSYFWn0hhycxLTrjSR+Z7EfADPedBwMaSEmoCRPaCjLM+nzcXDwVyGwIbFhvWJIE/hfoF1zuz32rsdKOUDgXZ+bm7g4I+42iMXyFnYcq/vJDAYMUl12T4GhGj7ZmYz0qCG1dh/BPzCIp2GeOdxFfbuvkLfblhNn+72lxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZiAeBJYc; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57DEW9wU2093149;
	Wed, 13 Aug 2025 09:32:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755095529;
	bh=XimLamn4Mz+6hg6tinLd+SKZfD3TGjk59OoPPjemj7E=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ZiAeBJYcGeXF0blL7GEu+qezR4zKyDyG0liZ8Q2gEdU28tOdE0EGbXjdNQH2h1rKr
	 a4NlX2rUY6kTny2zdqzQyDrxlwHz+vM3x6+MIedtQeynskZQNRV4/ZwHayHszfZGQA
	 8saQ+zCMVTHfqqmpC9k9HN8IbHDs04qZkD00h8zo=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57DEW92Z1036690
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 13 Aug 2025 09:32:09 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 13
 Aug 2025 09:32:09 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 13 Aug 2025 09:32:08 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57DEW9pp2440532;
	Wed, 13 Aug 2025 09:32:09 -0500
From: Nishanth Menon <nm@ti.com>
To: <vigneshr@ti.com>, <kristo@kernel.org>, <obh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        Wadim Egorov
	<w.egorov@phytec.de>
CC: Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <upstream@lists.phytec.de>
Subject: Re: [PATCH] arm64: dts: ti: k3-am642-phyboard-electra: Add ti,pa-stats property
Date: Wed, 13 Aug 2025 09:32:07 -0500
Message-ID: <175509551721.157835.6025291111862070229.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250804105450.2322647-1-w.egorov@phytec.de>
References: <20250804105450.2322647-1-w.egorov@phytec.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Wadim Egorov,

On Mon, 04 Aug 2025 12:54:50 +0200, Wadim Egorov wrote:
> Add ti,pa-stats phandles. This is a phandle to PA_STATS syscon regmap
> and will be used to dump IET related statistics for ICSSG Driver.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am642-phyboard-electra: Add ti,pa-stats property
      commit: 6aa4c1a38cf10c9760f81d456b7f92ff157e5f83

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


