Return-Path: <linux-kernel+bounces-735684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA8FB09289
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 19:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 745D81C47158
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C162FE32E;
	Thu, 17 Jul 2025 17:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="X9ovGZ4M"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681702FE314;
	Thu, 17 Jul 2025 17:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752771658; cv=none; b=kI4A1OSTsqXKarrBdSAtC89PXs/ldrJRjHH3MU25i+dhNwa4OMyl5X2pAyoGeoU3X4LsHfKl0JSGmov6ZOOIYc+bu7INMiugR7OzGO8cevy4iItxBlM3Yc0A4wdeEfeTaqp/nYEzQ4z2AIJMn2SJZJGuntpSENHFVTXKDDu59Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752771658; c=relaxed/simple;
	bh=4ZcjHRstOuEAO8PSBD5ogAY/bV7qinmgxezVi25T0vM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADhM8w6cBLSYp8qu08C/wn2RfGshTet/mhAw8DyERyo+odu1sM3AMXUO7wGkHE1VEmt/cGmG54P4+3HvGJoH8XRQDOtNPsFqL+6qmJyXtdnJ9GppqA+a8nL+0ElD19ncjI+PKDaH3nwSrbGoPsoEEEIIKVoaL/kEE26YAiDywcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=X9ovGZ4M; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QNkoBmSrQhOotHhcZ/pt+jefZGvWgsF4nd+f/EvmSvE=; b=X9ovGZ4MkcBJYK9anYVaqgUArl
	eHIcgGHatBzFf+0yHuuSLDmyz/6GWwj0ykwmdE8NCSE9rFIE/5bjNYYu1kndxizmpJJMojBTjMUL/
	h8mPXrNzHj/M6PmeDpAGvCjXj+LGiRfpwJOiF8PELJ68pW0Wc/TyJgDdxwZO2J3h52Kk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ucRy8-001uYl-NC; Thu, 17 Jul 2025 19:00:28 +0200
Date: Thu, 17 Jul 2025 19:00:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Willie Thai <wthai@nvidia.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Deepak Kodihalli <dkodihalli@nvidia.com>,
	Ed Tanous <etanous@nvidia.com>, Leo Huang <leohu@nvidia.com>
Subject: Re: [PATCH v3 4/4] ARM: dts: aspeed: nvidia: gb200nvl: Enable MAC0
 for BMC network
Message-ID: <e0d61de2-00e7-457c-bed9-21f0d7b5488a@lunn.ch>
References: <20250717-update-gb200nvl-dts-for-new-hardware-v3-0-f28145c55c98@nvidia.com>
 <20250717-update-gb200nvl-dts-for-new-hardware-v3-4-f28145c55c98@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717-update-gb200nvl-dts-for-new-hardware-v3-4-f28145c55c98@nvidia.com>

On Thu, Jul 17, 2025 at 09:52:13AM +0000, Willie Thai wrote:
> Upstream-Status: Inappropriate Bad devices
> 
> Signed-off-by: Deepak Kodihalli <dkodihalli@nvidia.com>
> Signed-off-by: Ed Tanous <etanous@nvidia.com>
> Signed-off-by: Willie Thai <wthai@nvidia.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

