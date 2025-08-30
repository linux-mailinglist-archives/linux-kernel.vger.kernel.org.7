Return-Path: <linux-kernel+bounces-792963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F32B3CAF5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 14:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8382758321C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 12:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34813283C82;
	Sat, 30 Aug 2025 12:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="fKecV1Pn"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E67E279DDD;
	Sat, 30 Aug 2025 12:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756558698; cv=none; b=hSvnappmNynXTskz34jClqJq5NXStZA7Nz5KywnhQgN/I+7VNgVM+1XTGimXNhDDX6RruRIz5Vm4OvYmWeQ+BNXZ1SxDrvpvo66G7PT8MXUUt7I0bL5xdDau/9T/XFZiC/gULyFspGGCRKg1uN2i5tspeQbROIZd/lwYOTbJgVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756558698; c=relaxed/simple;
	bh=nkH3eIamYPeCNetAJcclk/SLknqkbV2RYykT1eFsBL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g3mFXNeaSanft5KR72ctawH/y9gKl2VPiY761jKHjiuUHbfU7bpREVNhME+gP6dMDYEnIjdSBDBTPgCDgSBIh86hUf1X8FdpJSMwGElohQ/YJNfCbha/1XwJ9xbleI2rBRJe+GlOy/ggqVsTYeVLBins5y9We8n+aBgoRg3lw1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=fKecV1Pn; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=oDmWqsxitH8ilfXlpH8wKy0vkKGYPgRhyivr03Uy/cg=; b=fKecV1PncNZJBBYrj9lXpcMvjV
	3ByvZ1QFZHbOrnGx8uV/zWf+ZCJd1LUyI4+VOtmMrVJDX9ooHv7mR27MFbGfnWONpF7P/WlP6XzL0
	xebmVWg4uqBkmb5g7V2Dmzdr57Ux/VFG82awVmxX9nw4RUERo0KBmV1IfC7FKAz4xG0HXgjupd5K3
	PgLk9YIuul5AiLk3k7k9Vi/KyQQY4j+8ZYvt2NBsXu+7+XyhS1+4grClo4zvi9Bii9KIGkZOQkw+Q
	nM712+/MDpoEPdMdTAxjIgDAystRYiW4qjmXlp2v1K629NQypPY5zrvr1/hIizyrtUbAFjRwgXVxT
	GNA9mxig==;
Received: from [77.241.232.9] (helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1usL9g-0007bC-6H; Sat, 30 Aug 2025 14:58:04 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	kernel@collabora.com,
	FUKAUMI Naoki <naoki@radxa.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: fix second M.2 slot on ROCK 5T
Date: Sat, 30 Aug 2025 14:57:57 +0200
Message-ID: <175655867262.3578496.599026461545727624.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250826-rock5t-second-m2-fix-v1-1-8252124f9cc8@collabora.com>
References: <20250826-rock5t-second-m2-fix-v1-1-8252124f9cc8@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 26 Aug 2025 10:08:36 +0200, Nicolas Frattaroli wrote:
> The Radxa ROCK 5T has two M.2 slots, much like the Radxa Rock 5B+. As it
> stands, the board won't be able to use PCIe3 if the second M.2 slot is
> in use.
> 
> Fix this by adding the necessary node enablement and data-lanes property
> to the ROCK 5T device tree, mirroring what's in the ROCK 5B+ device
> tree.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: fix second M.2 slot on ROCK 5T
      commit: 5567a036d1b00fb3c6c77bbbd2944291afe1938e

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

