Return-Path: <linux-kernel+bounces-883854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53538C2E93F
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 01:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 133B23A3FE6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 00:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F891A08AF;
	Tue,  4 Nov 2025 00:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgWfkAHb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B3072631;
	Tue,  4 Nov 2025 00:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762215724; cv=none; b=MTbsW8pNR5a+Skz6tloCp/aEtflga6/d1jtyFvBubir6U/drWDPSztkFbVKvyX+Fsj6633jjuT3+5rZ8X3vCREPcSgof3y+ZXR5j0vziHXRFwLVBCZpTD6nw4fJsaA8jiqGLh8+8+SkhJ7RRODZBdT/G/7Xj5Dx5ja6xBJd5Z3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762215724; c=relaxed/simple;
	bh=PZC6ZAFX5mF9YpTkaCf/jKGSfMQTSFoPUl3PB0kzxEA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p8evYP/v832lltrpgxvhWkQGBHMlnwXGqWB4jcYsM/c+HJMGp3pY2nzTPLIHhfV1FngeBGAsjOgnDU6RgymNAUZAVLaljseLyJaN01YnAt7mNt4mBNiVQYoCmaC4FUToOdfA4SSSAQmqIMwHu4Yl8IPNmhMiQzsenpo/OaHPmSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgWfkAHb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3140DC4CEE7;
	Tue,  4 Nov 2025 00:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762215724;
	bh=PZC6ZAFX5mF9YpTkaCf/jKGSfMQTSFoPUl3PB0kzxEA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jgWfkAHbxDoD2BP9iwLha/1gvlsiF+jnLgr+WZifolFV8R5Egc0AIiBEvR5rsz4g5
	 eK7tWcNkCdVUq+7RKQHBkE8gcWNmBDvriEI0qcRx5En9g0HpHrA0UAOAnQOYiY8UmM
	 WT1XtGrThAoV48lvxFlXafD7NhcgI6X3J49WtET07eOA8P01A/SQpoxOyiO+dUgm/a
	 NGNek3UIn5jcORQ9NXJ1pGpsj0MXt+NgvNWy0TPuJGVQKsRqsT2bwGdr3FB1IFqRB4
	 t+RQF86mNa+58QWc81TjbMTVQBV9+/qYLVtQeN21XdaERSkPYbo5KpT5x046flgsCO
	 dB9BvXJGVm+HA==
Date: Mon, 3 Nov 2025 16:22:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Han Gao <rabenda.cn@gmail.com>, Icenowy Zheng <uwu@icenowy.me>, Vivian
 Wang <wangruikang@iscas.ac.cn>, Yao Zi <ziyao@disroot.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "Russell King (Oracle)"
 <rmk+kernel@armlinux.org.uk>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, sophgo@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, Yixun Lan <dlan@gentoo.org>, Longbin
 Li <looong.bin@gmail.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH v6 2/3] net: phy: Add helper for fixing RGMII PHY mode
 based on internal mac delay
Message-ID: <20251103162202.1bd0dae0@kernel.org>
In-Reply-To: <20251103030526.1092365-3-inochiama@gmail.com>
References: <20251103030526.1092365-1-inochiama@gmail.com>
	<20251103030526.1092365-3-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Nov 2025 11:05:25 +0800 Inochi Amaoto wrote:
> +/**
> + * phy_fix_phy_mode_for_mac_delays - Convenience function for fixing PHY
> + * mode based on whether mac adds internal delay
> + *
> + * @interface: The current interface mode of the port
> + * @mac_txid: True if the mac adds internal tx delay
> + * @mac_rxid: True if the mac adds internal rx delay
> + *
> + * Return fixed PHY mode, or PHY_INTERFACE_MODE_NA if the interface can
> + * not apply the internal delay
> + */

Please add a : after Return, so:

 * Return: fixed PHY mode, or PHY_INTERFACE_MODE_NA if the interface can

otherwise kdoc warns:

Warning: drivers/net/phy/phy-core.c:116 No description found for return value of 'phy_fix_phy_mode_for_mac_delays'
-- 
pw-bot: cr

