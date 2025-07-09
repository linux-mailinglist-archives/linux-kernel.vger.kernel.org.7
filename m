Return-Path: <linux-kernel+bounces-723334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE5CAFE5EC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E33815835FC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502B428D83B;
	Wed,  9 Jul 2025 10:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="whwcpcgb"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD7B25A354;
	Wed,  9 Jul 2025 10:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057440; cv=none; b=Ggq3lCZsfJWvc92X6NeLfI7QyLzfRRRsbhSZBbMkg6xgEIb/udcOneI8WhKfcYmEvAC5Y6tXep7c1M6lhpfb/C88gbkoSYHnB5gm5Un0z/vsj9/HYLQUNhWRUQU75dvLnv12sSJd0q0Z0xdbhWJJsmeVVTXBxSnmjx0ZoRCm+M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057440; c=relaxed/simple;
	bh=laM3VRd00aMDHYsaaq84DXgh52gc+H5jQHhkE+1TO8w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o5kOzgRLt064eyCfLVpjfpizFo9oFBrrTsHS/1vk30EzA3d5o/7rDlHjVJG4faYGj9rOECoH5jkiQUlCK289ZEi7LZdVEOW587a7bhmEbmmBWYiYsuW4eP+dk3fEati4aswDs5rugVKX5zFZBBrLzLAHW+tac6UQot4CZvEfa8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=whwcpcgb; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 569Ab0p51188098;
	Wed, 9 Jul 2025 05:37:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752057420;
	bh=iMUYSJ7xBVV0t5hQTWAsU9tTxBU1IRIZP+YZk6vKoeM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=whwcpcgbB8u/eMt37gEb+uE9LOQ0MvfGiDOrvSfVXRX/EMYJi8Y/nJl823PEUTKRi
	 cfQeHCC8Y/A/oIs50TNi5g43EVmsLBYrv9KJD7xFEQqJALUIgDEiIpqBEf8taR7Z1y
	 Ur1cjhAfbxMKK08p2FleJksLpbxgH/REOE4mS/bs=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 569Ab0e8051395
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 9 Jul 2025 05:37:00 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 9
 Jul 2025 05:37:00 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 9 Jul 2025 05:37:00 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.245])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 569AauhT3789718;
	Wed, 9 Jul 2025 05:36:57 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Parth Pancholi <parth105105@gmail.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        Parth Pancholi
	<parth.pancholi@toradex.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am62p-verdin: fix PWM_3_DSI GPIO direction
Date: Wed, 9 Jul 2025 16:06:42 +0530
Message-ID: <175205738886.920395.8483860730913081511.b4-ty@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703084534.1649594-1-parth105105@gmail.com>
References: <20250703084534.1649594-1-parth105105@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Parth Pancholi,

On Thu, 03 Jul 2025 10:45:34 +0200, Parth Pancholi wrote:
> PWM_3_DSI is used as the HDMI Hot-Plug Detect (HPD) GPIO for the Verdin
> DSI-to-HDMI adapter. After the commit 33bab9d84e52 ("arm64: dts: ti:
> k3-am62p: fix pinctrl settings"), the pin was incorrectly set as output
> without RXACTIVE, breaking HPD detection and display functionality.
> The issue was previously hidden and worked by chance before the mentioned
> pinctrl fix.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am62p-verdin: fix PWM_3_DSI GPIO direction
      commit: b1a8daa7cf2650637f6cca6aaf014bee89672120

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


