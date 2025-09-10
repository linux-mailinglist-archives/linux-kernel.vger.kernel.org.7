Return-Path: <linux-kernel+bounces-810220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F62AB51763
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06F50467372
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C19A31CA4A;
	Wed, 10 Sep 2025 12:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lkR1tk78"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3533226D1F;
	Wed, 10 Sep 2025 12:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757509002; cv=none; b=Vf4Qa+8knR9xv5Cbwu4NIh014Wi+zlqh5yTNtypoM9sAcXE3OFRF9upgXWFCQjBZIXUQLVHNLt/Y3vsIBxwQ44tPNIuQbayEM348wD0dgQtUbBb5mck406KBKvQ3eqVP2BVakzeMHq0qIFP+ZODMG7A8I0iDXga81H4fEnDhKF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757509002; c=relaxed/simple;
	bh=0hauiEl/ij9Ej4OYJZOwnnhNDJNogKnuzNv8eCt7tYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JF1r6nAIfo+MMevOeE60EIjc+0fbhLt2/NQd/jw/hTHl9iV3N3ue06HkwPdVWBQJYJOar74C2Q/t0Qk5piw6wx3Xw8FIbtUe+ffgDbhMcm86v6CL1/ZNzGPZK6M1xsObhYYiVHzPci8NkSiv2Wur3jz6m0jZcuF5qVypiJN0qHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lkR1tk78; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8TgsJAPG+gvJuGo1mADyM4jldixKGYBoLgCB1sss4qk=; b=lkR1tk78PoV+Tma7HPr7R4vg4F
	89G9DYvsE0UEMbP3/X/fB068fW1Iba2c7JfnYajxoZlZ7vXiPSUusxi4rdETc8BwDacD0hfzRWikb
	F324HDIyWpZl/15fv3FvAq5siiiSaVLPbOmBefKd7SYlI8uqISsyAdq9a5wMbuSPg1Ss=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uwKN1-007wR1-Mv; Wed, 10 Sep 2025 14:56:19 +0200
Date: Wed, 10 Sep 2025 14:56:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Donald Shannon <donalds@nvidia.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org, etanous@nvidia.com
Subject: Re: [PATCH v3 2/2] ARM: dts: aspeed: Add NVIDIA VR144NVL board
Message-ID: <3114a51c-47a2-4b67-8965-33841ee87fd5@lunn.ch>
References: <20250910040601.240162-1-donalds@nvidia.com>
 <20250910040601.240162-3-donalds@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910040601.240162-3-donalds@nvidia.com>

> Changes v2 -> v3:
>   - Removed unused phy-mode property from mac0

> +&mac0 {
> +	pinctrl-names = "default";
> +	phy-handle = <&ethphy0>;
> +	pinctrl-0 = <&pinctrl_rgmii1_default>;
> +	status = "okay";
> +};

Oh, fun.

Please don't do that. At some point Aspeed it going to clean up the
mess they made with RGMII delays. And at that point, it is very likely
your board will mysteriously break, if nobody remembers it is doing
something probably no other board does.

	Andrew

