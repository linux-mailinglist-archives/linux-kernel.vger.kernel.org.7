Return-Path: <linux-kernel+bounces-813614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 413DEB54842
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA2AA17E01B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6550027E048;
	Fri, 12 Sep 2025 09:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uTR3NtC/"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05ED227D771
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757670540; cv=none; b=SVAjBSKZcC3Vl9QAHTZL6pYnKhy6RxpFQMaKYcA/SdMGv5duXa7bDCRI9jlHDKuxNop7ig4Gng3UYiR1KOYO+7Y9COMl+1ARHHRB3jzy4GnmyPzo9FXA1XXb43UaT22zNdU8QoH7lRGm5NY5oiaLsRIWpbzqMPCVDiIBlgwRhkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757670540; c=relaxed/simple;
	bh=TJLBAe3bwF7tpWGBX1jro2IjXYhJPn7CFQGx10KhGgo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E9n9vzX4OtNZCK87SDGinnnKbzz/C1EpOLLJURUMXHkUlNNeG5KLOd34socIuH09YpKHbjc6Yzi1KvmuQGGjW/FSE1W76FZTiMHTzovTPYkTN9kQkfnGuXuKzLQkX5AcL7SfDTyzpo6xlLoyxQZWmXRD+ZByJbni6gex3HAG60M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uTR3NtC/; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58C9mm5q579991;
	Fri, 12 Sep 2025 04:48:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757670528;
	bh=EGxK3+nUDShNX5RD0otP1DIRgNRelbVrozYCdzGyYLs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=uTR3NtC/bik/LQGWHimx0CEUt1VZWX+hgHdaZo5SGlyfX6ViPXZEToSQYNNbTGH83
	 rSh9C1Ll4fUmsjunFdfBKPRT8XrqW7kKQDdFROpXuv7aKEWgj/JCzBzzq3X5WE/GUO
	 xrpMCQBZj0+ZnhYMG2oOn54UQw31c2pWXYEi1DuQ=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58C9mmTu1774944
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 12 Sep 2025 04:48:48 -0500
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 12
 Sep 2025 04:48:47 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 12 Sep 2025 04:48:47 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58C9mlLS3715784;
	Fri, 12 Sep 2025 04:48:47 -0500
From: Nishanth Menon <nm@ti.com>
To: Santosh Shilimkar <ssantosh@kernel.org>, Bryan Brattlof <bb@ti.com>
CC: Nishanth Menon <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] soc: ti: k3-socinfo: add information for AM62L SR1.1
Date: Fri, 12 Sep 2025 04:48:44 -0500
Message-ID: <175766773687.25324.14122074690665057486.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250908-62l-chipid-v1-1-9c7194148140@ti.com>
References: <20250908-62l-chipid-v1-1-9c7194148140@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Bryan Brattlof,

On Mon, 08 Sep 2025 14:15:28 -0500, Bryan Brattlof wrote:
> The second silicon revision for the AM62L was mainly a ROM revision
> and therefore this silicon revision is labeled SR1.1
> 
> Add a new decode array to properly identify this revision as SR1.1
> 
> 

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

[1/1] soc: ti: k3-socinfo: add information for AM62L SR1.1
      commit: 037e496038f6e4cfb3642a0ffc2db19838d564dd

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
Nishanth Menon <nm@ti.com>

