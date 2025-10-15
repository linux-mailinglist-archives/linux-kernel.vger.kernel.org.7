Return-Path: <linux-kernel+bounces-855316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 101E6BE0DCF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 23:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80EE05486BC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C7E303A2E;
	Wed, 15 Oct 2025 21:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gKFX8OVD"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559DB2FFDF2;
	Wed, 15 Oct 2025 21:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760564880; cv=none; b=WzUOvAVoP83q+GphT+5qYhw4T4OozkphMWvb9sUjEP6wp97GTxjukvRo6dVlWPuVNRybCGOsvrUh1ysqOJ4ljK82t8C74KzADqfOlRtPIW823eqhakb2ZK7AnIONFNJr9JxrmVHgVB+EWm3oM/vMfHhhAh0zov96AHXecjXKu+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760564880; c=relaxed/simple;
	bh=XDru9vyLIiZMGzQy3Z/yJzJzIU5Vs6NKWuI08K7VFaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0HC9JOUhgvdOCcN9HxCZ8dXG/Yo3UmqaTMcst6oXILmWY0v9KSdXLIcaz3LpLKbnMQe/FMNRR6NXfzSkydxNF7sG58JzliMqMFaC7yG//coSpPfkRafGcMXUsifWSK8UrwqALsml115sUQVYAbPg20GI6rL3sjGS2GtiNlNqoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gKFX8OVD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BJKRSA2/UrZpBwMZJMLqiGvnJ9vtCKMc8nR4m+Bp2vo=; b=gKFX8OVD4AxfYUMWpmvDKQgeoP
	EfGtlIZLIs+J+AeSD5EwIrheoEEWfjMjayaJIE7qp0j+Qs+pJ27VxQCoBuuuaJW6am9znaAYFSH0n
	BGvFftZl9ZIUyCAqVVF8lYTpQE2Y5NWfFqLV6UpHOJjzd/TdqF9aE5Xj4m/OWzGIVYAw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v99LT-00B548-JQ; Wed, 15 Oct 2025 23:47:43 +0200
Date: Wed, 15 Oct 2025 23:47:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: rentao.bupt@gmail.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>, Tao Ren <taoren@meta.com>
Subject: Re: [PATCH] ARM: dts: aspeed: fuji-data64: Enable mac3 controller
Message-ID: <b0040541-31e9-4cda-9462-09b4a5622959@lunn.ch>
References: <20251015204840.80070-1-rentao.bupt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015204840.80070-1-rentao.bupt@gmail.com>

On Wed, Oct 15, 2025 at 01:48:37PM -0700, rentao.bupt@gmail.com wrote:
> From: Tao Ren <rentao.bupt@gmail.com>
> 
> "mac3" controller was removed from the initial version of fuji-data64
> dts because the rgmii setting is incorrect, but dropping mac3 leads to
> regression in the existing fuji platform, because fuji.dts simply
> includes fuji-data64.dts.
> 
> This patch adds mac3 back to fuji-data64.dts to fix the fuji regression,
> and rgmii settings need to be fixed later.
> 
> Fixes: b0f294fdfc3e ("ARM: dts: aspeed: facebook-fuji: Include facebook-fuji-data64.dts")
> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>

Thanks for adding the comment.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

