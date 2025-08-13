Return-Path: <linux-kernel+bounces-766866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8013B24C10
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D45677BB1EF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229DF2F0C62;
	Wed, 13 Aug 2025 14:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jtn0YPtS"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16C7302CD7;
	Wed, 13 Aug 2025 14:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755095562; cv=none; b=JrrGgP7ZIj6moLLvsujx3xDn3fqW9P+9+u7u3ylSxoOKFDRT1pN2nck920XFfb0HlrnppVDz34aDtMVq5T2vnLezImC18ldvGhPHibOE/L2v8lyQm0CeynOJ1Gn5xiap2byT8Gp5SrEUAttEoBFVihbT9dWMyheMdQ3b0hSmUiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755095562; c=relaxed/simple;
	bh=ZuprsWVy9JbWYxbiQaWGYd36YeuyxqS4SvjMCZYEwDs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KBNmbtPOW4gIdDhq21l3QIc+Xay3E6oAHOWnkiP8jS15/fVMTPOVKCzS3IN2r/4NcEvvTzKGX5rXOlJw3SVbjBXngGKhwVqjDm9qowbrqShIDssMka5GkGoMC+8XAXKAVOcuRi8MXC+InOcOna5xXljOd7aLe4Wz6pI4RBY4nAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jtn0YPtS; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57DEWTrN1718718;
	Wed, 13 Aug 2025 09:32:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755095549;
	bh=iB0oG4jCZar+MlBWg1xIuSPYx68EeANpTAsftMM0gM4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=jtn0YPtS0sv9JQ4EvXOhP04JPA1WSKMCJf0Jbhvxy6Ea1yvYMwK2knaDZIaNYZzfG
	 c9lJdlH0EbFjvZjO4jhwhCmKH9LJXPBVtAKIIspCseiXnY9A/VVzJiSIaFPdJMMg2C
	 B0jeBb3sqnmMBfFzJsYShZs674OyjihfqvaV7C3g=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57DEWTVI1036777
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 13 Aug 2025 09:32:29 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 13
 Aug 2025 09:32:28 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 13 Aug 2025 09:32:29 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57DEWT9A2134792;
	Wed, 13 Aug 2025 09:32:29 -0500
From: Nishanth Menon <nm@ti.com>
To: <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        Wadim Egorov
	<w.egorov@phytec.de>
CC: Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <upstream@lists.phytec.de>
Subject: Re: [PATCH] arm64: dts: ti: k3-am62a-phycore-som: Add 1.4GHz opp entry
Date: Wed, 13 Aug 2025 09:32:27 -0500
Message-ID: <175509553406.158007.6562770238537192028.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250805090021.1407753-2-w.egorov@phytec.de>
References: <20250805090021.1407753-1-w.egorov@phytec.de> <20250805090021.1407753-2-w.egorov@phytec.de>
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

On Tue, 05 Aug 2025 11:00:21 +0200, Wadim Egorov wrote:
> The phyCORE-AM62Ax is capable of supplying 0v85 to the VDD_CORE
> which allows the Cortex-A53s to operate at 1.4GHz according to chapter
> 7.5 of the SoC's data sheet[0]. Append the 1.4Ghz entry to the OPP table
> to enable this OPP
> 
> [0] https://www.ti.com/lit/ds/symlink/am62a3.pdf
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am62a-phycore-som: Add 1.4GHz opp entry
      commit: f13db4f77d54a6db644f09a168919ad1b3432f52

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


