Return-Path: <linux-kernel+bounces-782644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C4EB32314
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BBE93B7243
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 19:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61162D47F6;
	Fri, 22 Aug 2025 19:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uQ21zCCC"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793BC26A1B9
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 19:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755891844; cv=none; b=knZsN+oFXU3S7kvX60eOvXsyJStUEHUvrVWU7GHFWbV00gM1kaBCBVKumv7RZjBVLQ+lz/KlygA6wUuw7zT/dXwtpfIYab42V5boN8WKo8YdYibt2s3c9/lpVFHp7rt+KnOBtwqk88OlMrHjyO5cqf0iYaG1oG7nhNZ/1HEC4Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755891844; c=relaxed/simple;
	bh=lG54dGD74C2YmxzbuhuFxB+4cfSVfNscmA6zFCw6y/4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BpzaQ5S4i9XoyvzBjFjwuxbM/eVSglG71lIjQxTiMjUIxsmGFCjecSC2ZasJJXoLzC0+iRTdlkpiBDBBcei0WiwlTQ0lzMSSC2mejoFWD7hYYMG0r1ElHbrpCMRuiymbkPfHjXj61KC8FfUvAPZsC1aR8/nODK8DvlQ1ybc6ZNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uQ21zCCC; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57MJhrJ1793716;
	Fri, 22 Aug 2025 14:43:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755891833;
	bh=iuHnFL8d+8/viIGVZQNRtgFVz9XiwjlhUnqOaKNJpUw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=uQ21zCCC6cQIu/wNfEdrUHRhEERVHu4TEXhezvJJsSM9lvseQYtsy6RzLwAaUECcO
	 psU5/+b+ubion6O/HcDuYwREdvDJHHk/0JoQ67RbEBQzZgFXdvI982tBGGYRuJm/B+
	 +AKdDB6TkQOxkC+IAX2wDSM1yRCzOU2WFOW9Z3bU=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57MJhrVb3139313
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 22 Aug 2025 14:43:53 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 22
 Aug 2025 14:43:52 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 22 Aug 2025 14:43:52 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57MJhqAB4030877;
	Fri, 22 Aug 2025 14:43:52 -0500
From: Nishanth Menon <nm@ti.com>
To: <kristo@kernel.org>, <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Kendall Willis <k-willis@ti.com>
CC: Nishanth Menon <nm@ti.com>, <ulf.hansson@linaro.org>, <d-gole@ti.com>,
        <vishalm@ti.com>, <sebin.francis@ti.com>, <msp@baylibre.com>,
        <khilman@baylibre.com>
Subject: Re: [PATCH v4] firmware: ti_sci: Enable abort handling of entry to LPM
Date: Fri, 22 Aug 2025 14:43:51 -0500
Message-ID: <175589181464.648753.7944472542726572522.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250819195453.1094520-1-k-willis@ti.com>
References: <20250819195453.1094520-1-k-willis@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Kendall Willis,

On Tue, 19 Aug 2025 14:54:53 -0500, Kendall Willis wrote:
> The PM co-processor (device manager or DM) adds the ability to abort
> entry to a low power mode by clearing the mode selection in the
> latest version of its firmware (11.01.09) [1].
> 
> Enable the ti_sci driver to support the LPM abort call which clears the
> low power mode selection of the DM. This fixes an issue where failed
> system suspend attempts would cause subsequent suspends to fail.
> 
> [...]

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

[1/1] firmware: ti_sci: Enable abort handling of entry to LPM
      commit: 0fdd3240fe5a9bf4785e40506bf86b7e16546b83

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


