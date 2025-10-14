Return-Path: <linux-kernel+bounces-853202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B9BBDAE78
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 20:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BF5E934357C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9123330E821;
	Tue, 14 Oct 2025 18:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="oWce2nmH"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B72B30DD0D;
	Tue, 14 Oct 2025 18:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760465230; cv=none; b=QLK/TvpAEJ5XwW8LuSMQn4danmwJhH8rLhEDnlav2jB3DlOzbSvBRe0OkbNEWO097gap3NxKtqUCr5GhMtoAsdlb1yOdxRQKkbCh1DAqlRtwlhPMPmsB92WXzK8kbX6MQjEBQxnqm3Ahy7Ty/vHBnSASyKwCo2GC67pc67/6esQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760465230; c=relaxed/simple;
	bh=aLDMjqU/R0EG34Jb2xDYyMv9kcIAj3PdK/m4H2Irob0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GgMg6ZtMaCGAA1gyLsFvdP1fixD1ptsI7SW00NnBIZs7/cTkSSBj8xlvZpYl60NnW6xfiKQPcQb2vUN0zVC2ugXRuSR3l39kt/DrX2oRHhF4vyZqfqdTN+ZSvProsxLzYhLkEUBWFGn1UrEoiqIq8E+ZEvU2fMUj/OY2pPJNPXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=oWce2nmH; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=rIEDzwv7QdB31GWJ+XTDLBa3gIoDkaeLOaqFwxH7huU=; b=oWce2nmHWPWWoNXeYgtzvmVX/+
	hA0OkoEPV9FKtQomxOXwECRZ1fIRfyBUXTVILAz9OyIqcsolM26xiEC9LcZvtSQtEETvN2s5jNiUM
	VekHnoxEnHGurZGh5AfbgA8s+SVbjWZaBPsqQWoNX7BSwl0XLeo91KiVqruss+Xu6QC+M0MvUf8qC
	8St4tVG84On1cTrJtoKvmmiSfX1dQAhqHuOBHOss0ZOuOS2vhX3u0VVy81WXCKQi//XerfUsLlKYC
	EG+xrbzWwBDMNm2nJppzEw1Z25fwWUbSw3bYKNwX03xfsKuCV6FJKcQvcnl5CJ4g38TQDBOldDlqy
	nuyMJYSQ==;
Received: from i53875b75.versanet.de ([83.135.91.117] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1v8jQC-0001Gj-A8; Tue, 14 Oct 2025 20:06:52 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Andy Yan <andy.yan@rock-chips.com>,
	Chaoyi Chen <kernel@airkyi.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Dragan Simic <dsimic@manjaro.org>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Peter Robinson <pbrobinson@gmail.com>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: Enable DisplayPort for rk3588-evb2
Date: Tue, 14 Oct 2025 20:06:37 +0200
Message-ID: <176046473179.1662867.6131209694998628350.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250918062825.194-1-kernel@airkyi.com>
References: <20250918062825.194-1-kernel@airkyi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 18 Sep 2025 14:28:25 +0800, Chaoyi Chen wrote:
> The rk3588 evb2 board has a full size DisplayPort connector, enable
> for it.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: Enable DisplayPort for rk3588-evb2
      commit: 134fae98cfbabb7e90b1b2d957fb374408061034

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

