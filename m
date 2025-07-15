Return-Path: <linux-kernel+bounces-731695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F777B05862
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E47234A0C2C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BEE2D8DA5;
	Tue, 15 Jul 2025 11:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="wyWkt5FS"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A142D8786;
	Tue, 15 Jul 2025 11:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752577432; cv=none; b=FivYEKpUot9gAKnWtiaU74Z8jQEHEa7MbLOkQ1aMeuniU2JzfgifugvQXxbMyAN3lvgU4NR0b183pH7KE7GLdvQdyAhSlaY3W4rA3YhwshJFXSoONpzzZlela5EWyhVotT9wcwFY1Qnk9ZMUfGhXVLEHaT5X2OtsFSVivApjndg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752577432; c=relaxed/simple;
	bh=M/aE9++D3/s+5ClBbVhvTF6BC8B+IdHP1ZmPHl2Dlo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QAeJwxI9E9Gcj6vXBt7wNn8TvuhAo/AWjS+QkQ+irrH+9LGnebDxR9aF/LbfIOORWxKZ+6A1cRUByad3dGAn9xPaiV7IPyQ0qhjIfynmZR6nKfWt5ZDNNt44ouDqCm8+HH4CzSv6kQqemu0CrwVqBAMZAt5VqDoXzgPstspJYuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=wyWkt5FS; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=pEqVl7UTU3h8kIn5gNcr2TqpCsHuRyehsMYidQ99ptk=; b=wyWkt5FS+IPee6aBG5i6+WSE9Y
	hfqG4TkExza4sbE8Pdeb+WY6+o+b5r0OhUFePlSFGQCFTDeN6Or6qrzt4N2ZgMlH2PTgsA8vctxqF
	g9aa4GE2dK32gpVqQi8qvGUNL1YgDIuDx3qbXkjGyjXvqneYr5qzP+7L52ifCCAM3ZnZF2KUgpw0J
	pbKn6DF5rLazeeE5jwi1z8yP8Axkf+umkvkH80xggIQg1KNHvwMbcs4Wr/pnxDWW1hDnKjrBQfJ1K
	yqufcjGTfSKtA6nA3Z3PvtyRfHQ4RZRKC9cFYPe+rVKJYEe1Jz5WBZfqeleacV6xENmzNAtrN4TeD
	mqZhWf4g==;
Received: from [194.95.143.137] (helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1ubdRd-0000L2-2C; Tue, 15 Jul 2025 13:03:33 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Diederik de Haas <didi.debian@cknow.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Dragan Simic <dsimic@manjaro.org>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Johan Jonker <jbx6244@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v4 00/10] rockchip: Fix several DTB validation issues
Date: Tue, 15 Jul 2025 13:03:23 +0200
Message-ID: <175257739695.2521784.1985937428277626271.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250709132323.128757-1-didi.debian@cknow.org>
References: <20250709132323.128757-1-didi.debian@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 09 Jul 2025 15:15:13 +0200, Diederik de Haas wrote:
> This patch set fixes several DTB validation issues and consists of 2
> parts:
> 1) dsi refactoring
> 2) various low-hanging fruit
> 
> ad 1) The display/rockchip/rockchip,dw-mipi-dsi.yaml binding had:
> - #address-cells
> - #size-cells
> 
> [...]

Applied, thanks!

[03/10] dt-bindings: display: rockchip,dw-mipi-dsi: Drop address/size cells
        commit: fd5fde69fd413b03e25fb3b8e2ce375c02e74b0d

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

