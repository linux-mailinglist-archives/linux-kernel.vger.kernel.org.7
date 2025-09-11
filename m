Return-Path: <linux-kernel+bounces-811689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EC9B52C9E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EB703B0534
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3200D2E7BC1;
	Thu, 11 Sep 2025 09:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="y4zRtMJU"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057551F5851;
	Thu, 11 Sep 2025 09:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757581560; cv=none; b=LuoYbfZAJMY1tvv6gXjTA2cBj7k19L8oKzdcaBtSmViByluRHAYYwAntyC5F8Yf+bOskWZ6C7J8iKj17gSarYsOXYqLnOa9HbZvxeYda7ubRzP+cyygULD/XmY7+HI7Unw8Zh/+YJ+EZeeSk4hoG6Y4B+HmDDcJesVZVFazTHmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757581560; c=relaxed/simple;
	bh=u8bnKyroTcOBPWuSACf2ieZCxmYz2vSpFLoEowJb1p0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T7Oy6lfzQYeOT8axoz+pOCsIhsir40lACUIF+OpiwDYNg2AvNQ0xZszFjDEWuiEWjD0lDcDNcEMAvegbr/ex7lUA8OboCP0xKNOvJ6XCiwqYRQls+8Om3molAGCb20Na0RVTQhskJQyyd/8+JuT65lqKxDZXS4YIEl5F2dHRst8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=y4zRtMJU; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=6gx6VMk7TDXvQGr0QBI+xdzzWNaTJzaWnQI1EKY6rgU=; b=y4zRtMJUhMlPYzMKYM/wIDAVHN
	VBCCrSyfwSo4g3qFvDrBo2m4c9WsXLPOgJ28hfc+lm9ZaMllmgVPLp73lSu5SGWL1pcq6c13G0P0Q
	+6heFKHDxHJrrTobTY4ynEY0FBh87NfuA4Dz2/DuUVDN0w3s2KISyXaLIzX/oKqUQGsg7nkHfPVFn
	l1tAABgnZb04drR4A0eeXQvLgeKW6v7S6LCgnGyyfUaUMOprKFgic3hpQVj4Cj/hEYWyl7CniNMYv
	l+PBUwM+ZQfDJ+f8My81hBuIsRFhetOCOwmrMoUJa5UMU8eATxkQ+zshadXVmNagYKp3oQXQbhf29
	91TqB45w==;
Received: from i53875b0e.versanet.de ([83.135.91.14] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uwdFa-00005b-CZ; Thu, 11 Sep 2025 11:05:54 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Christian Hewitt <christianshewitt@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Alex Bee <knaerzche@gmail.com>
Subject: Re: [PATCH v3 1/2] arm64: dts: rockchip: add GPU powerdomain, opps, and cooling to rk3328
Date: Thu, 11 Sep 2025 11:05:42 +0200
Message-ID: <175758154015.610665.11518544255206774361.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250906120810.1833016-1-christianshewitt@gmail.com>
References: <20250906120810.1833016-1-christianshewitt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 06 Sep 2025 12:08:09 +0000, Christian Hewitt wrote:
> Add GPU powerdomain, opp-table, and cooling map nodes for the Mali
> GPU on the RK3328 SoC. Opp-table frequencies are sourced from the
> Rockchip Linux v4.4 vendor kernel while voltages have been derived
> from practical use and support work: keeping voltage above 1075mV
> and disabling the 500MHz opp-point avoids instability and crashes.
> 
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: rockchip: add GPU powerdomain, opps, and cooling to rk3328
      commit: 718efbc6a773dd07047f2ac3d62bbbf3bc4b104f
[2/2] arm64: dts: rockchip: enable the Mali GPU on RK3328 boards
      commit: d81b0c3099d02f6c7a4be7a15d33145b3700b159

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

