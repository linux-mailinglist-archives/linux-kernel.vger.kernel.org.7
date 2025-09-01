Return-Path: <linux-kernel+bounces-795306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA5BB3EFB4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 22:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C49F47A993A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 20:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E031269CE6;
	Mon,  1 Sep 2025 20:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UL3lR5Oz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E2226281;
	Mon,  1 Sep 2025 20:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756758662; cv=none; b=MaP4ScFSxkXzflxqkJIVfckzhzuuIqa/MbMBDb4Z77pxikMlh/EEn4jAHtxQb0dEIo8QCHXFtFAhgy9MXHxSJWGgHbZXHX/W7BLkheSC7yxCqL9lsBeuwfklK25yBv5JV28ZlER/ovVWOVVmO6jFBxBWoMCziQ4LImiJ7gubcqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756758662; c=relaxed/simple;
	bh=o1ifKcPsvn2MDOy5ZM3uMxa2Jwl6bMXiXquuke3efXw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eciM25+73PSnLf/ArTq3iqlZ83I1XD6YmASfeaSuAwZdGQkQKRwHVMiTR24znvANAY2YbWNoFzJUzuNjT3iSWJrfK2BosXK/OmUsngBw9P9Cl/lb4200YV6lRvoEaibglt3k9I3lONl1kCOu8scp7iBq/PM4yL5XLczzWBwsrXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UL3lR5Oz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0AA7C4CEF5;
	Mon,  1 Sep 2025 20:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756758662;
	bh=o1ifKcPsvn2MDOy5ZM3uMxa2Jwl6bMXiXquuke3efXw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UL3lR5OzH+TCiL96WCUm0pOyyjFwjmGkDEis71rAtLmNjO0pu2vEKVOcwpW1IodW7
	 kgmAwqwppHJfAdAu7c4a9X3UF1urmvy2L3tn0odXOQCe/ec8XWLBSWU4NXN6EKCqst
	 gam80LHpp2Ny1IpQUSRIg73ZkieXY4DB95XyXIWRja9LYV3S0+NIiGUEFYGAT4ynSn
	 KqPbY2KvIULi2nOXLBqZhi2hvKdvsi3AFVHFcxcCgI1AmpBDnbVLGtiuKtmaVuxKQD
	 s+juAUShvLhQPmghzQbGfgQTpMXM3Ibc/5ucCJ8UHiA1oeMc8DsBp3hgTk0d7pDsTx
	 WxwhEtOpcGphA==
Date: Mon, 1 Sep 2025 13:31:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko
 <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, kernel@pengutronix.de, Dent Project
 <dentproject@linuxfoundation.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/4] net: pse-pd: pd692x0: Add devlink
 interface for configuration save/reset
Message-ID: <20250901133100.3108c817@kernel.org>
In-Reply-To: <20250829-feature_poe_permanent_conf-v2-4-8bb6f073ec23@bootlin.com>
References: <20250829-feature_poe_permanent_conf-v2-0-8bb6f073ec23@bootlin.com>
	<20250829-feature_poe_permanent_conf-v2-4-8bb6f073ec23@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Aug 2025 18:28:46 +0200 Kory Maincent wrote:
> +The ``PD692x0`` drivers implement the following driver-specific parameters.
> +
> +.. list-table:: Driver-specific parameters implemented
> +   :widths: 5 5 5 85
> +
> +   * - Name
> +     - Type
> +     - Mode
> +     - Description
> +   * - ``save_conf``
> +     - bool
> +     - runtime
> +     - Save the current configuration to non-volatile memory using ``1``
> +       attribute value.
> +   * - ``reset_conf``
> +     - bool
> +     - runtime
> +     - Reset the current and saved configuration using ``1`` attribute
> +       value.

Sorry for not offering a clear alternative, but I'm not aware of any
precedent for treating devlink params as action triggers. devlink params
should be values that can be set and read, which is clearly not
the case here:

> +static int pd692x0_dl_dummy_get(struct devlink *devlink, u32 id,
> +				struct devlink_param_gset_ctx *ctx)
> +{
> +	return 0;
> +}
-- 
pw-bot: cr

