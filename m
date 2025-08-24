Return-Path: <linux-kernel+bounces-783570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6706BB32F1B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 12:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C155202C97
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 10:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B62279915;
	Sun, 24 Aug 2025 10:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="ImifMFWC"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6430D2749DA;
	Sun, 24 Aug 2025 10:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756032901; cv=none; b=SWzhUNAYvhdydMLty/bZTpRByqwO2wZ3lfF/azaal4gH9tFQ27nbMa1nwgUg8MJEt4ZszN3ohjJcsDTGu9oPvVwJ1waqlv30lMioFbhnnrDQHunO/L8ftGryqc/sYW2VanwtXWKUsdivaznZTFX10sCRWdGgKcAx1iOp89MAs4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756032901; c=relaxed/simple;
	bh=hlAFeLmVa6EFGeDmmZAkAbE/r2Es2OyYGw7RToPB1UM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bQN6DWtHyfF70ajuRgIJ2SC+l9IzKd8gwy3IBF6hdpZUepJYOrpCEMai5Nv6LXSgbXf6tNHe1pnJxWDacrd1JIO3RmQRk9k9hnqP0VSfVX0LYlWLSLfGYL32NXElkLeuZ/OG6nUBIN4d6XzsicaYNVSd7A7JLricSB+Kb5RMgJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=ImifMFWC; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=kBZpfZMhb/qLJdhn2F1dJKc6DesZIGgqaeovqJQ6kSM=; b=ImifMFWCfk5+S05N4JvcBEGG0n
	tdOLPAbMzN11biP7h5CTgRFeE4Uy0nQO7ryhiYE4O4/acr9+k9VlTJNXiCgLp4vAZ8Q5g7bNbmOWd
	T3DN6O9PH7fw/HExaLfmfOYYfarMmtJK7gv2U7AEa5zq/I8mUhyskFkqKpkX6c9EbVwRiqaTBkYYy
	QZ57bpunXW/bqo7Juq3U1nYDsLuZbuYG3Q8p3B4LiJsR5yyZ16nXTLzFAACl+xT9aMuJrLoXbOyzT
	l1nxFda9sxtuK8GkUfmc4vq8stfO5NaO2QZmmxsNQPyTsDa+1mS6bCQ91KVaWQUgfjCk/QfQBvHmb
	wCYRGO+Q==;
Received: from [62.245.128.201] (helo=phil.wifi.munich-airport.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uq8N6-0005H4-H9; Sun, 24 Aug 2025 12:54:48 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Kaison Deng <dkx@t-chip.com.cn>
Cc: Heiko Stuebner <heiko@sntech.de>,
	honyuenkwun@gmail.com,
	cenk.uluisik@googlemail.com,
	i@chainsx.cn,
	damon.ding@rock-chips.com,
	jbx6244@gmail.com,
	sebastian.reichel@collabora.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: fix es8388 address on rk3588s-roc-pc
Date: Sun, 24 Aug 2025 12:54:41 +0200
Message-ID: <175603280231.3445205.18306877381327188841.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250814043230.2774813-1-dkx@t-chip.com.cn>
References: <20250814043230.2774813-1-dkx@t-chip.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 14 Aug 2025 12:32:30 +0800, Kaison Deng wrote:
> Use the correct es8388 address for rk3588s-roc-ps
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: fix es8388 address on rk3588s-roc-pc
      commit: 4138adfd3594ebe957c6cb640372c93e354aa171

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

