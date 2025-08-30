Return-Path: <linux-kernel+bounces-792964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C2AB3CAF6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 14:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57A4F1B24EAB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 12:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3477E2836BF;
	Sat, 30 Aug 2025 12:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="MCO/SKuH"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E72827A916;
	Sat, 30 Aug 2025 12:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756558698; cv=none; b=dzNtxn+tlbAPWl7gl3TRAgbQihnfSeBH4w7tjsL2b50pb+ZC9/cOHTxiYtl3OgvrL3DqU/sRL+GnsTfsXtelOP/8e0R2lkG1Y8BejL0C3Yai5+kJC1AkTEJOX51JJfexVir/xhbSNhlCrp6G3xR6XV00Pl35lLv/cYDJ+3L8Uo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756558698; c=relaxed/simple;
	bh=RRRafiFeC/Jbm5ClmtmOoYBl76CdozwQHN3fSI2UNmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BC0vDGaCMop0QxGHJfoBvuj0V9yUBzDtkKmmSrH8XoRqM4heqPRdd31i06gJB19vCpDeyYKvHhAi+F98Xs642O9nV2NWXyKp1tj1n1IUO7SAOEy4YLlSWzxlTcjBwWoJWmfqiqSyDVlCU/J36suJA0EXoPdt1FuJKHKhQvDNRA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=MCO/SKuH; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=6Yab2QYSQioLjW07dBEfvQXsxs75hrGlncclPnBVlOE=; b=MCO/SKuHraOTO9oshIGbh7VLKj
	ekirWjqz5oFNJcK6b1yN+mquhjWrrqyMYLok9rZec7kkj++iLct6oWY72lFBjCmW1gxDoMxdA3Skd
	PA1U17u7sg6ywKizboTT+8AggXwitfB7OvU9p7HW7eiTxaHHy3dsI6/rXf76TEoMC3AKhjTCXMFgL
	+bYJbIyxg6HL3DBfAQGXwNs017mW5MMS1BYuj8drwP0/L3ABWTyT2ue9Ll9TNi4/EVdTyJaioVgPf
	l90RoY+yDf+eWZH9xGxNLXpH05DFxczwf+6VTfc01Se0kBv5GHAENkbGhETsFTLrQIGLFQMziLE0s
	/lI45k+A==;
Received: from [77.241.232.9] (helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1usL9f-0007bC-Ok; Sat, 30 Aug 2025 14:58:03 +0200
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
Subject: Re: [PATCH] ARM: dts: rockchip: add HDMI audio to rk3288-miqi
Date: Sat, 30 Aug 2025 14:57:55 +0200
Message-ID: <175655867260.3578496.11571731070517001514.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250828163501.3829226-1-christianshewitt@gmail.com>
References: <20250828163501.3829226-1-christianshewitt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 28 Aug 2025 16:35:01 +0000, Christian Hewitt wrote:
> Add the sound and i2s nodes to enable HDMI audio output on
> the MiQi board.
> 
> 

Applied, thanks!

[1/1] ARM: dts: rockchip: add HDMI audio to rk3288-miqi
      commit: 2a91dcd5be9dde3239c87e4309f5878d3e4fb9d2

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

