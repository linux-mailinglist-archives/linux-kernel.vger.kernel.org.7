Return-Path: <linux-kernel+bounces-813613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCB8B54841
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 124A01BC4E23
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B994A28136B;
	Fri, 12 Sep 2025 09:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Q16QU3RU"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3161A27D771;
	Fri, 12 Sep 2025 09:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757670519; cv=none; b=L99lnU2SoS2BGd8mVBJ31J8QTMly5g+Sqzzb29ddilF3QQZ2zJJEq42F9h54hgM4mD7iBk4YBVyo2meEHxjOCvOCcL6lsJL3OkNdO/9EHJh6Uz//qY/KxYaO6oAh7w9UfpKiMs+U2GMwLTyaBFdM8HVtmE3JO7GUOLpLAUx5Tf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757670519; c=relaxed/simple;
	bh=iqQ1Yw/DqLZRc/p7ftpsV0eMyy6LzD42Nr10R5sz5E4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=okEEVsNBYEj4MiSQDl1SKb1xfrsmrkDpTXSiiypcRfyDxwi8J+RJahqKs6M4owBNACIAaTne24AW+Go6OkceSHhTARlcieA5YH1jS3TdJc5ZJedjV7SSv5ejU/o4gBkHVba7nAXUBJN8672RkXCB7DnTqs2mIN9ee6vNegQONb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Q16QU3RU; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58C9mLV91008151;
	Fri, 12 Sep 2025 04:48:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757670501;
	bh=r4hpL1WjqUwGCaqWkzYGDifvsElcMhYMPsGMRUV9Mt8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Q16QU3RUq3NqRnLwztT1oObzs5RQ9HBg/64I5/34nKjWYKYRXvUF0xAqenQ9rupSm
	 DMDLYcUGpMrMC2FMrdaCCIf+THvnRcVL4q1MZxP8km86Reh3oR+YtkLSCpW/LqMw7s
	 xca8z1LyEo+Pu2BSGApkVozSY7+vZx0pnVuj8a04=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58C9mL8S2685103
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 12 Sep 2025 04:48:21 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 12
 Sep 2025 04:48:20 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 12 Sep 2025 04:48:20 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58C9mKuC3715494;
	Fri, 12 Sep 2025 04:48:20 -0500
From: Nishanth Menon <nm@ti.com>
To: <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        Anshul Dalal <anshuld@ti.com>
CC: Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/4] Add support for TI AM6254atl SiP
Date: Fri, 12 Sep 2025 04:48:17 -0500
Message-ID: <175766786841.25865.5286816232704724647.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250814134531.2743874-1-anshuld@ti.com>
References: <20250814134531.2743874-1-anshuld@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Anshul Dalal,

On Thu, 14 Aug 2025 19:15:26 +0530, Anshul Dalal wrote:
> This patch series adds support for AM6254atl SiP (or AM62x SiP for short)
> to the linux device-tree.
> 
> The OPN (Orderable Part Number) 'AM6254atl' expands as follows[1]:
> 
> AM6254atl
>      ||||
>      |||+-- Feature Lookup (L indicates 512MiB of integrated LPDDR4)
>      ||+--- Device Speed Grade (T indicates 1.25GHz/1.4GHz on the A53 cores)
>      |+---- Silicon PG Revision (A indicates SR 1.0)
>      +----- Core configuration (4 indicates A53's in Quad core config)
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1]. As part
of applying the series, I have had to fix a minor merge conflict due
to the order I picked patches, do check if all OK and report if not.
Thank you!

[1/4] arm64: dts: ti: k3-am62*: remove SoC dtsi from common dtsi
      commit: e0b9feca7329c495a76891d7766a781dea73787d
[2/4] dt-bindings: arm: ti: Add binding for AM625 SiP
      commit: 3e915577cf0b7d3f9088c398888e5e01e10356d7
[3/4] arm64: dts: ti: Introduce base support for AM6254atl SiP
      commit: 7c1d13a14e61ab33eec330cb6cabbddb37eecaa9
[4/4] arm64: dts: ti: Add support for AM6254atl SiP SK
      commit: 2517e476b819df986fa1fe53927c099032bb72dc

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


