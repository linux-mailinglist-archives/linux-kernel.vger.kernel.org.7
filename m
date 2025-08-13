Return-Path: <linux-kernel+bounces-766891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57104B24C56
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E2327A6BE5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736692E8DF5;
	Wed, 13 Aug 2025 14:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fsiFJI3T"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD5818786A;
	Wed, 13 Aug 2025 14:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755096482; cv=none; b=INwtzYFvpmXAeVKV61vkQ0Pmzrqo3pJa/xUHqB3hRP8vCFj33hM06f2JE+9bOXagWAmJd00f4hb1fo3BF2ejgCiaoAKsRtbicfjNnFS1j31AKxKaJciqLVC+nDFBBHj66JZ2BCJXYcZEveXzk1wIZYMxMNqVO9ZS9H9lu4CCXfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755096482; c=relaxed/simple;
	bh=TpKhcJfYj0QeFNmSVAkK2qqKILtRN1I5HrA5QO8GQy4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=keoaGNWckAp3pq+diNM2NBUMmJS08n+dqds5nzNogoHgKBfxcpW48B4/XnNXyctibIiWcTTEISwJllKEoauL+kPjUy0XCnyh0BnlHyrJmXOSrzkC7TQlMmhz7GDpazNG0zUgxXngnQJaeBQro4/RoQ82ruJlbel10TXvH+zF2h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fsiFJI3T; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57DElvo02169650;
	Wed, 13 Aug 2025 09:47:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755096477;
	bh=K63jITfcwNP/6qrbBcd3v9SV1MMJ3VNtyqIBaX0/Bd8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=fsiFJI3T5QDMRXzrncN6kcQtVp9Z0R2cKqyPKIkTBrTidWQ9PuNcuc8+RYyQgVmU9
	 2d6C9ohZQX9UpRwr3yGs9sCcszth3dseFJlj4jj8rbWmpEZ2RiqOQ3V5mXlnC95L6h
	 sUpm2cUzS2qbngs9e+xAcfPyW+BWw5lhBg92JcxI=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57DElvAJ132352
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 13 Aug 2025 09:47:57 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 13
 Aug 2025 09:47:57 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 13 Aug 2025 09:47:57 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57DElvAl2152920;
	Wed, 13 Aug 2025 09:47:57 -0500
From: Nishanth Menon <nm@ti.com>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        "Rob Herring
 (Arm)" <robh@kernel.org>
CC: Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: arm: Convert ti,keystone to DT schema
Date: Wed, 13 Aug 2025 09:47:55 -0500
Message-ID: <175509646749.163971.1457357729984904510.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250806212824.1635084-1-robh@kernel.org>
References: <20250806212824.1635084-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Rob Herring (Arm),

On Wed, 06 Aug 2025 16:28:23 -0500, Rob Herring (Arm) wrote:
> 


I have applied the following to branch ti-keystone-dts-next on [1].
Thank you!

[1/1] dt-bindings: arm: Convert ti,keystone to DT schema
      commit: 20b3c9a403ee23e57a7e6bf5370ca438c3cd2e99

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


