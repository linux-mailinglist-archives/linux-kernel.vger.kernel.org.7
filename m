Return-Path: <linux-kernel+bounces-844637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 13975BC2643
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 20:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB7594EAD6B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 18:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3562E92D9;
	Tue,  7 Oct 2025 18:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qof3P//d"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F631F92E;
	Tue,  7 Oct 2025 18:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759861989; cv=none; b=WXPixFosoW9FkD3+z9FfQzBMDsWfJG36tso3sl/RhrHRIcOXkBECTqT/5D81tZYh7wXmmkuUTYyRDiXzB0UiP0ekF28/aaMuFQXTEurX6FUKPD2yzPsqC2GE/ErpHHvDMej0IkrXVoLekrpusqSpB7+EzQekgft9kQJvMYPJyYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759861989; c=relaxed/simple;
	bh=mM2kP8wD0XEPbcLgnihTUxv/eJjqODbwCasIdYyIc8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTjCfL7kX3o5E2KqYQyiuIX6Qxh2REP6EGOKj7DpvbHe926rqd2qUGIU6PfIwWFY4PlU1lxgqAZeIOmWd/BJ0B/lNMcVx7GXybLE9f2/cs3pxJX7FGdIQIwPQUfJMpdu/TP3MjGteX1abzoMMwI/HonCKoZxCIxj/F76kXCo7E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qof3P//d; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nXZFtFTkE8xIC71M/N7hUPoMl0yiOIyLa6hKguyz/kw=; b=qof3P//dbmF0+Sf4x0+XNpMlD+
	aqzn3EyLNptQS4jZTQexx5yJhGVp3UvvsjWMDbogW0HAuOrsn/yq36ha83A29PFp6sW87mn7YzoB0
	mxPsp0dhFyxQyrV8WXV+fdDNAhtxmUDIrM/EyV/sy69XAJGsCr525eLcAS0g9e1V7YBY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v6CUP-00AO3J-AP; Tue, 07 Oct 2025 20:32:45 +0200
Date: Tue, 7 Oct 2025 20:32:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: jjm2473 <jjm2473@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	heiko@sntech.de, quentin.schulz@cherry.de,
	kever.yang@rock-chips.com, naoki@radxa.com, honyuenkwun@gmail.com,
	inindev@gmail.com, ivan8215145640@gmail.com,
	neil.armstrong@linaro.org, mani@kernel.org, dsimic@manjaro.org,
	pbrobinson@gmail.com, alchark@gmail.com, didi.debian@cknow.org,
	jbx6244@gmail.com, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] arm64: dts: rockchip: add LinkEase EasePi R1
Message-ID: <a0501abe-d86d-4f3a-9d55-c842bfafc190@lunn.ch>
References: <20250929065714.27741-1-jjm2473@gmail.com>
 <20250929065714.27741-4-jjm2473@gmail.com>
 <d8ad476c-d0c7-4e97-9e76-540a539ffb52@lunn.ch>
 <CAP_9mL4ofig-X-w9wx1A5D_eVXROo6AVFBSwp4mh=kj7webpPA@mail.gmail.com>
 <7e219aef-88a0-4184-9553-30dcbc8dbd79@lunn.ch>
 <CAP_9mL6utQjN_2EZ4vs3K8jzcxHxvKWNTNEXZ9fAx4HuA=DNXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP_9mL6utQjN_2EZ4vs3K8jzcxHxvKWNTNEXZ9fAx4HuA=DNXA@mail.gmail.com>

> I also notice that you suggest use {tx|rx}-internal-delay-ps instead
> of  {tx|rx}_delay in
> https://lore.kernel.org/all/e4d3127b-c879-4931-9ea0-de7449bc508c@lunn.ch/ ,
> but I think this depends on stmmac driver.

It depends on the driver implementing those standard properties. But
as pointed out elsewhere, tx|rx-delay are magic, nobody knows what
they do, so it is hard to implement the standard properties to replace
them.

     Andrew

