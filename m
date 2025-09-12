Return-Path: <linux-kernel+bounces-813627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F89B54864
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14B5D1C24D15
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2130D266B6F;
	Fri, 12 Sep 2025 09:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AHbERkDw"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6C9285417;
	Fri, 12 Sep 2025 09:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757670795; cv=none; b=AsfXoNdnBD//QoZGWaOzyy7egk7PCvMQErPiJPkdBHZqzGpPLAAUDssLnA5SKExNfnzdlpzhYwUl8IJiYtRxOQX9k2wI3aXWQhm/UlVISUA75iS/A7Xaq3Y8m/xyq2B38xZRBdyp0hTPLG0xZ+Wl971YWuNHHi+xzsI/raGLnkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757670795; c=relaxed/simple;
	bh=p1ZQ3iTjcNmrGpxXr+vDEA9tYw3JvlqDt/tXref+YtI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HI6mZIumohhAJDDpI6PFNdQIOlsrd+atfDJ8MevuatsC8r9r6pk7SosDDKx/a1sm7sP54DVohfyypRIORZpp2z1egRrLDHEv2sZVS3Ah0duk9TjO4zP3muI6lk7Km2YjwbWDWT5JgetYzF2QHvnsJonUHeZhO6f6B176xkKFu3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AHbERkDw; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58C9qxr01008759;
	Fri, 12 Sep 2025 04:52:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757670779;
	bh=LO6oQYvzd+j6JJ+27I0KVimve6UrPTkIHXhZD5Zibfw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=AHbERkDw3FV2IixdDYbLbm6rtAF8UL0ALN8OSq8wJd8RKU6KYs3+ez/i0emeOA1z3
	 No4x1rmeaobpjNs07qFmpTtStzUAknd8Q2NezETovu1YItCc+SRZMxubrQVg26X5dE
	 YdSGUPmPXlAhd1pLyfMondkqLfcbWrbtnCm87CzM=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58C9qxLS1895849
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 12 Sep 2025 04:52:59 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 12
 Sep 2025 04:52:58 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 12 Sep 2025 04:52:58 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58C9qwTK3416131;
	Fri, 12 Sep 2025 04:52:58 -0500
From: Nishanth Menon <nm@ti.com>
To: <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        Wadim Egorov
	<w.egorov@phytec.de>
CC: Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <upstream@lists.phytec.de>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am642-phyboard-electra: Add PEB-C-010 Overlay
Date: Fri, 12 Sep 2025 04:52:54 -0500
Message-ID: <175766787263.26980.13993594214350390779.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250910141716.2133707-1-w.egorov@phytec.de>
References: <20250910141716.2133707-1-w.egorov@phytec.de>
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

On Wed, 10 Sep 2025 16:17:16 +0200, Wadim Egorov wrote:
> The PEB-C-010 expansion board adds two extra 1Gbps ethernet ports to
> the phyBOARD-Electra-AM64x.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am642-phyboard-electra: Add PEB-C-010 Overlay
      commit: e53fbf955ea7753ef7970b866ca229abe32d5639

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


