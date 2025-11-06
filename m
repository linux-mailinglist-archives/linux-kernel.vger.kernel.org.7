Return-Path: <linux-kernel+bounces-889460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A4758C3DAAD
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 23:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 493A734FDE5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 22:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC472D3A60;
	Thu,  6 Nov 2025 22:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKOVOFGU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22712248B4;
	Thu,  6 Nov 2025 22:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762469165; cv=none; b=OsICUPiBDkoevwpeUpLJYyNhTcb9HbsLL/L23Vqejk/QMjU7UAZ5w7h/75GqeNcGHYrm6EtSBLkXyPj2JBENCOkpNIPv5IVl2PB5866h0jnIdF5Etm4q7j93GMmDcdxX7kJ9LVOhDQN+ywHunzxibfoMDc9HRCkItAT1LiRw6Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762469165; c=relaxed/simple;
	bh=vRhGOEcSzhWTgzIoNVdNU8Fkl/OJll56puzq1hpG7zU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aNColPOXoOnQjMrqm+YrtWHFwU3y8anpRBIUx0oAy6akOY30CBDUkqrg/Vpxatr3pyX5dngY3010hLkgEDOK0Z2QwGOivnU8wz5P2irCMHt+CazmIVVSgf/kX+OKn2TPoaaeO2JXXeT0Pv/A7TPZriSH9drArBAU7tnosAX8HaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKOVOFGU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EEE0C4CEFB;
	Thu,  6 Nov 2025 22:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762469164;
	bh=vRhGOEcSzhWTgzIoNVdNU8Fkl/OJll56puzq1hpG7zU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mKOVOFGUZ3hMcVu1O/dC+STgEOM3EJSBVprA0UQ8RyAIDRuRvIrFldR3rM8O5Ojlv
	 JVK4dWQt+2LwCRO2neaeOtqv9jaTbaaCJoR4JqMhZTfA6wewgRl5UINLdXlXtSO8lD
	 ZU7REAAPZVgJMMP8dyXXSWUTDKVrc+x5TfLuDe53TWuwIo+3da+PSznp4igHL+r4b+
	 pnPKsJWMoBvkDyd8QddDJ4mSzI1ebGT6vf82yCgdt7ypGECmTs/QFE5S0+mRhgIy7d
	 rB54IJaiFQTzrmfC7MjPkHi6y78Ze0McsfQSllofblpwDaAehLSae5YS4nM7sPz67X
	 pQhZBBRVhL0Zw==
Date: Thu, 6 Nov 2025 14:46:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Buday Csaba <buday.csaba@prolan.hu>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 3/3] net: mdio: improve reset handling in
 mdio_device.c
Message-ID: <20251106144603.39053c81@kernel.org>
In-Reply-To: <11b197641e5498cab3e43f8983120fcabe06257e.1761909948.git.buday.csaba@prolan.hu>
References: <cover.1761909948.git.buday.csaba@prolan.hu>
	<11b197641e5498cab3e43f8983120fcabe06257e.1761909948.git.buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Oct 2025 12:32:28 +0100 Buday Csaba wrote:
>  	reset = reset_control_get_optional_exclusive(&mdiodev->dev, "phy");
> -	if (IS_ERR(reset))
> +	if (IS_ERR(reset)) {
> +		gpiod_put(mdiodev->reset_gpio);
> +		mdiodev->reset_gpio = NULL;
>  		return PTR_ERR(reset);
> +	}

We usually consider all sort of leaks as real fixes.
Let's fix this in mdiobus_register_device() in net/main first?
Then do the refactoring once net merges into net-next (every Thu)?
-- 
pw-bot: cr

