Return-Path: <linux-kernel+bounces-813060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7100DB54046
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 04:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3043D585831
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 02:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7881CDFCA;
	Fri, 12 Sep 2025 02:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBAblwgr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068FC13AA2F;
	Fri, 12 Sep 2025 02:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757643529; cv=none; b=ArpD0l7mQz8htmdviR2rfiMk1NH/ioHAFmExfIoq5b5GXPG1iqW2yBXVr4WR/XQ8Hx0z+jPm92BaUa9hmqmrWCD7CTEDXJdoU42BOgbXxKilpf9VpzcYrKdwikFrJqmu+WaejYgo0Eb97xtV+4zGvFOFTj6b+9mt3lGHAwDTJMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757643529; c=relaxed/simple;
	bh=tb0RjiLR6dlhzgJ2yxZd7kUCUULJpTEX6t1+ERYfcZE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DjOagLRTEGxIzVD9DIzM41zQy8IhsNFe1yoYDhmcE1fn1tqLSBc00TtdSHM2kh5LEjWjJO2tdOhdpvoQOum+QFrDFkNC7ItNIAnN+rxgDKjCPt5/GH1Ex6MW6uqSnT+bdXjmvdiHHiRZlYw8xTowX3BPbQQbxjg3Vf8VZW0qHmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBAblwgr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0925C4CEF0;
	Fri, 12 Sep 2025 02:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757643528;
	bh=tb0RjiLR6dlhzgJ2yxZd7kUCUULJpTEX6t1+ERYfcZE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RBAblwgrKsvAkqQgSLkoWJW23Ot1J8i2Na5+2dUb8/piRiCvokjPDtVt2+DYqdO9s
	 GGfMqxrAqsJAB/jBoeic3i93qKfDGq/gcR9dUbcj7jqvNAPmU8AwLqFrNH5wuG8hnH
	 f70BC8l1EXgC0sFaBpCLLTjxvmSPHbppiOMUClcCKt4H+2yzK4o1sOGLcbs+kONWnF
	 X6WYHut038Jd9RUiVt0P1dYxMe47+feVXIJWAnJ0zgV+FLibG9gzi+373ykr258Fja
	 Jrn8KcPTA1ekm8t4j0OdGvQ9l6e1in+8YM9IbiIalG0lbIO4PyhFB77FbfxyDWkXis
	 orW58qpaTeTdQ==
Date: Thu, 11 Sep 2025 19:18:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Kory Maincent
 <kory.maincent@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Nishanth Menon <nm@ti.com>,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
 linux-doc@vger.kernel.org, Michal Kubecek <mkubecek@suse.cz>, Roan van Dijk
 <roan@protonic.nl>
Subject: Re: [PATCH net-next v5 0/5] ethtool: introduce PHY MSE diagnostics
 UAPI and drivers
Message-ID: <20250911191846.273bc7db@kernel.org>
In-Reply-To: <20250908124610.2937939-1-o.rempel@pengutronix.de>
References: <20250908124610.2937939-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Sep 2025 14:46:05 +0200 Oleksij Rempel wrote:
>  In practice, such scenarios can only be investigated in
> fixed-link mode; here, MSE can provide an empirically estimated value
> indicating conditions under which autonegotiation would not succeed.

Does fixed-link make sense here? I thought fixed-link meant MAC-to-MAC
in most contexts

