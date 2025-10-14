Return-Path: <linux-kernel+bounces-852940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEF8BDA4DD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9D3A3B8A11
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3EC2FF65C;
	Tue, 14 Oct 2025 15:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dPNOZ9MP"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003FF2FF170;
	Tue, 14 Oct 2025 15:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760454719; cv=none; b=XSzMZfD7Io/boUPxyHLxx9jFd1Kj9DizaMDppS6ceYsk+5V4c26repErYPtT0cOGGaeAjfxl1hQRlkOGEFg8NioWu0Ze0XlfSEx9XarbFAY6EzE2zLsoXKoBYrtOoTtB57gGl8MM5fQDjvlmoRH5EPU0/et7ImM1djwJ03A/610=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760454719; c=relaxed/simple;
	bh=nMXCK59lr1B1ifxXwPlFor2LL5SiTAoYcnWu84m3+4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UaUS1+WyJl9ObNf9s53Krp5kOukmIwvu7pSFpUFEG90yGVwey/XGUrTZy3eDZxq09d0GY0sJ0q/v+Nfsf6v9nU7AE6Dtuua23WQvjeICP9kLSKCHgkwjTXRzkf5j395Y6Y1+7/JQKshKQqQ5wyqz/nIKqkrH/c1CNZxa9PzJUXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dPNOZ9MP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=37Nmg2NVeBxxzfJbfuXsD1Mwnh3yE228KQ/4hDiITzo=; b=dPNOZ9MPtW2WVRmqQR3u2LpP6L
	uptROoyNGK69M2qy303wCSQ08YH58U2pV6nabHmV4yubRoZo3KZwD6KYU4wT/PC7p9jIp5x/zyLnv
	my7lTuyeVrrF2PsuULGhQHqYtNq+z+4Dw8VxhlwXeNUGZkU2qbO4Wukrq7DxsDDbN+P0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v8ggM-00AvfK-Pb; Tue, 14 Oct 2025 17:11:22 +0200
Date: Tue, 14 Oct 2025 17:11:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Tao Ren <rentao.bupt@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Tao Ren <taoren@meta.com>
Subject: Re: [PATCH v4 11/13] ARM: dts: aspeed: facebook-fuji: Include
 facebook-fuji-data64.dts
Message-ID: <f801a4cb-3d27-439c-82f2-d5ee5aa0d810@lunn.ch>
References: <20250728055618.61616-1-rentao.bupt@gmail.com>
 <20250728055618.61616-12-rentao.bupt@gmail.com>
 <79ddc7b9-ef26-4959-9a16-aa4e006eb145@roeck-us.net>
 <aO2kLyxGlGt12sKD@fedora>
 <ea64d3c1-e517-4bd8-9a2e-56432f286347@lunn.ch>
 <4e099ead-e6df-4489-a775-1730bc852dcf@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e099ead-e6df-4489-a775-1730bc852dcf@roeck-us.net>

> > If it is already in mainline, i don't care too much if it is wrong. We
> > don't want to cause regressions.
> > 
> > I only object when adding new nodes which are wrong. If we keep adding
> > broken nodes, there is no incentive to fix the broken driver to do the
> 
> This wasn't adding an allegedly (sorry, it worked for me) broken node,
> it was removing one that worked for me all along. Obviously I do not know
> if it worked (or if it is even used) on real hardware, but it worked for
> the fuji-bmc qemu emulation.

It probably does work on real hardware, because it is one of those
"two wrongs makes a right" cases. So i see this as a regression. The
node should not be removed. It should hopefully get corrected sometime
in the future when somebody actually fixes the aspeed driver, and
fixes both wrongs.

   Andrew

