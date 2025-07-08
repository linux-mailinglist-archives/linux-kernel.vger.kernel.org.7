Return-Path: <linux-kernel+bounces-721725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F8DAFCD1D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74BFE7A382F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2062DFA34;
	Tue,  8 Jul 2025 14:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lojKRo/V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C82EEA8;
	Tue,  8 Jul 2025 14:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751984030; cv=none; b=YlDqzn7/CXFiWfFHyvFQQ5zyEcSb78yvn3djD4nsRxwfW1gS43lw5+avKCD5o8GqTNO7aCCBHzliyhqkI7PQhyfa+DBKM2ZWiDnPt7jFXZb2yyQJc9HKAFGYa0qsflpYEXyzmBoEue5YSEWGEmopgOYcnA6x3kBwhqZ7uZtbabw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751984030; c=relaxed/simple;
	bh=+5Ex0bc4kM2Y/CIfAlVeOTCIm9lVuDgffnp4Jfhrpes=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rpvfVdRuxExuO43d7I7SELiwO5I9RByEab2rme0oV+0if/wS9qW3dnlxXdGqpglzB0NGW2XPPv8ipHCvKjc4gg0Rwxb4sJdsep7jlc+hM38yUAMvYa0oNfPNlGuX/dvezcfacm81qllJ6+3kJ9dVhWRQzK9Tu8lglDOTSQWBRyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lojKRo/V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B75C4CEED;
	Tue,  8 Jul 2025 14:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751984030;
	bh=+5Ex0bc4kM2Y/CIfAlVeOTCIm9lVuDgffnp4Jfhrpes=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lojKRo/VmS3XGhlvEvM+YfHlzIRz9IBnARkuT04An6SkJnVkwZF3epS9pALryutBw
	 5KOepelmEbNkZWX0q+1gNoRSVHSmnraFqAPsTvoQr14H5ZQ6R8Ql1Y2wjytW1X/uwJ
	 ZpnKZkxsyEqDRWE9YvBLW2JnJYshNtGOmABNLvAbKaaCV+pCzY83qJGX1kpk6e2E/y
	 8tcVlwPhf5hNBtq+NqKbZwbIgaIZvEuZnWnQuBmxIgqcmH5MW1To3RL1eyoM2mEyZH
	 TXGLxCEcxkuxPzB5zOnRJeF7WLpMOM5bGFau5/ZCAu4Dee04B1kaR1BSD9fp49XBwI
	 PS62ofuRHj6TQ==
Date: Tue, 8 Jul 2025 07:13:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <Tristram.Ha@microchip.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Marek Vasut
 <marex@denx.de>, <UNGLinuxDriver@microchip.com>,
 <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 4/6 v2] net: dsa: microchip: Use different
 registers for KSZ8463
Message-ID: <20250708071348.2af94608@kernel.org>
In-Reply-To: <20250708031648.6703-5-Tristram.Ha@microchip.com>
References: <20250708031648.6703-1-Tristram.Ha@microchip.com>
	<20250708031648.6703-5-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Jul 2025 20:16:46 -0700 Tristram.Ha@microchip.com wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> KSZ8463 does not use same set of registers as KSZ8863 so it is necessary
> to change some registers when using KSZ8463.

drivers/net/dsa/microchip/ksz_common.c:2987:28: warning: incorrect type in assignment (different base types)
drivers/net/dsa/microchip/ksz_common.c:2987:28:    expected unsigned short [assigned] [usertype] storm_mask
drivers/net/dsa/microchip/ksz_common.c:2987:28:    got restricted __be16 [usertype]
drivers/net/dsa/microchip/ksz_common.c:2988:28: warning: incorrect type in assignment (different base types)
drivers/net/dsa/microchip/ksz_common.c:2988:28:    expected unsigned short [assigned] [usertype] storm_rate
drivers/net/dsa/microchip/ksz_common.c:2988:28:    got restricted __be16 [usertype]
-- 
pw-bot: cr

