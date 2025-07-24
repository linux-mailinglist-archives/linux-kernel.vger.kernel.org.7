Return-Path: <linux-kernel+bounces-743752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFEDB102D3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B8E7AA0326
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D7E271A9D;
	Thu, 24 Jul 2025 08:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMwAL61f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE322701D0;
	Thu, 24 Jul 2025 08:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753344343; cv=none; b=gqZWAwV+fOJ4jmDZjkiXa5/rhM5NRqwCtXIFucuZaBDt/YN5ZbR3vM7wct5GHjN8ODVLrKE1MH6CMyEVfX12UYqVBCHD0SFEIpG6m1P+3HmTWOQF52dTk7nIN8/t71NhPOj532HnPH5tqRhFMB3NCjt4Fl52GXWYn/nh0xr8woU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753344343; c=relaxed/simple;
	bh=QQ/KUR9EUnReinV6lJwLLr0fnjQkBu0aezOtyeBubts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=axJO5QLRj+Vbh2O5dOUGr9RmNXtHMmVz+wJa5PEN6lvXaNy8TiiqtwkClczC3JudcRp/ye/mUVxjlRAwZ4u3RS94USYasYeNpbtxL6xzn3Ex6cIL21azJfWgpC+KG1a6N5k+Cjx4LUR7E7xhzjSlfFWtm2iMJFhD++mE1PKKgbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMwAL61f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D984C4CEED;
	Thu, 24 Jul 2025 08:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753344342;
	bh=QQ/KUR9EUnReinV6lJwLLr0fnjQkBu0aezOtyeBubts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jMwAL61fiSNB5XAz4p2SUVMSHj4GsnjdjPunEMS0CWrz2TCLkANqT1xzJUjRcvNQQ
	 cQkv0TRaEDZPgtV/oigHfWj/+Jg0O8D5V60g8GM+VKvxpZK10wM07tYX4W/VwSBTqP
	 J3/eb9Y/iVNqRoXHHTxLaDbJ5VCPFP+zuW42sBCSWPEXyX2sTINfI2n2fLboGF12S1
	 VYeXT5EmMHp8MMMSjmlnRfkxU9GgHbBpivtR0cZ5vqAIkkuheWdCZ8gZWKkFpUOZK7
	 dYImub39SSfDGHOv3KPnDJYEr79kUA+uz9E/gc4E0EJdR+yIPYh+tbtO49si0YyCJ5
	 4yQkyHskw5vqg==
Date: Thu, 24 Jul 2025 10:05:40 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: rentao.bupt@gmail.com
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Tao Ren <taoren@meta.com>
Subject: Re: [PATCH v3 07/13] ARM: dts: aspeed: Add Facebook Wedge400-data64
 (AST2500) BMC
Message-ID: <20250724-overjoyed-panther-from-camelot-f2ff4f@kuoka>
References: <20250723233013.142337-1-rentao.bupt@gmail.com>
 <20250723233013.142337-8-rentao.bupt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250723233013.142337-8-rentao.bupt@gmail.com>

On Wed, Jul 23, 2025 at 04:30:03PM -0700, rentao.bupt@gmail.com wrote:
> +		/*
> +		 * PCA9548 (11-0076) provides 8 channels connecting to
> +		 * FCM (Fan Controller Module).
> +		 */
> +		i2c32 = &imux32;
> +		i2c33 = &imux33;
> +		i2c34 = &imux34;
> +		i2c35 = &imux35;
> +		i2c36 = &imux36;
> +		i2c37 = &imux37;
> +		i2c38 = &imux38;
> +		i2c39 = &imux39;
> +
> +		spi2 = &spi_gpio;
> +	};
> +
> +	chosen {
> +		stdout-path = &uart1;
> +		bootargs = "console=ttyS0,9600n8 root=/dev/ram rw";

Drop bootargs. You are duplicating stdout path and choice of root is
definitely not a mainline user friendly.

Best regards,
Krzysztof


