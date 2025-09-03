Return-Path: <linux-kernel+bounces-798496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB8DB41ECB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49FA9683E30
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2E42F39B1;
	Wed,  3 Sep 2025 12:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ah0SU7Te"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB0C257851;
	Wed,  3 Sep 2025 12:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756902108; cv=none; b=qVs5lK7+kt8pM7WZ88SAeomeW8vAZEsPkjcnDl6mAPxts8MtciQ6ho33gEBxvHxFAZXAvhtaPtpw//OW0YwVhAd3u5UjHTvMPyipR3x1D664r01PKUwmvXGOsdvQEedKRcUsfPlaBQsY4vpXQGKu2KrrKvoLD3wn3j3rnrDSMHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756902108; c=relaxed/simple;
	bh=jvqVsAXADZBtoJw5DiA/hvX9OV0sU0VPQvB3C85K9m0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFXFdZxqREagLTfzkKqWKa0ngJ8USvcQmkl33MHU9qVoCRhopQKEGXxH0kmHJ9dDHDytImnPi4/RIxMQ/CuVVP9cow0/P7WcHDIMlbLw3oXNDYr8ULgwqcwoplgiXkZg2XCpklrHCk+PPRUlGr74LbkVPHJE8K3QHEeDfP/nKSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ah0SU7Te; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YUjvm9eofoV1ResAkmWD1i4gWOlEKZtbOKhgLDy60X4=; b=Ah0SU7TeDcUCOSpr1QDkS2w9T6
	X1BI7rrsOnffJ+UGQkLG2e6hIadpm3DWpHV8Jq3DjceYSGhp+RQIIAIlgPUujdcjUNq/pq3se2TlC
	P5ZGujTnFTicaOaeReDJvlWWfKE01m3xQ0exgGklDzV6Ynb/WIcr2BEMNEQfTps034ic=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1utmUS-0070oZ-Tc; Wed, 03 Sep 2025 14:21:28 +0200
Date: Wed, 3 Sep 2025 14:21:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Gatien Chevallier <gatien.chevallier@foss.st.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] arm64: dts: st: enable ethernet1 controller on
 stm32mp257f-dk
Message-ID: <5c49e94a-9267-459a-ba6c-70f3763f1a7b@lunn.ch>
References: <20250903-mp2_ethernet-v1-0-4105b0ad2344@foss.st.com>
 <20250903-mp2_ethernet-v1-2-4105b0ad2344@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903-mp2_ethernet-v1-2-4105b0ad2344@foss.st.com>

> +&ethernet1 {
> +	pinctrl-0 = <&eth1_rgmii_pins_b>;
> +	pinctrl-1 = <&eth1_rgmii_sleep_pins_b>;
> +	pinctrl-names = "default", "sleep";
> +	max-speed = <1000>;

RGMII naturally has a max-speed of 1G, so this line is pointless.

You only use max-speed when you need to restrict the system below what
it would normally use, for example if the PCB is badly designed and
the tracks don't support 1G, but can do 100Mbps

	Andrew

