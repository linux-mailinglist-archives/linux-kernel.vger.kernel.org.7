Return-Path: <linux-kernel+bounces-725362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C209AFFE13
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A50FD56393E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2672BD027;
	Thu, 10 Jul 2025 09:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="snosT+UK"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BAC2980A6;
	Thu, 10 Jul 2025 09:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752139649; cv=none; b=bXl8xWeSdF+uwTaU/+4tMxmbDpmgcqsVMtemokhmMVBNvrvp9QTncMuC0IpCrhskL6//i4Oz/p8tgmXy1Hbcmv/OZbMPQiMFobVS1smtu/M38Q5je5w1VEq30IepS3LXj0/sI5G/6dpPLHU9vxvJ7qNsPfNFZIgQ4Mup076J3k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752139649; c=relaxed/simple;
	bh=dW5evj19l9FfSA6GKi8YbKvxccsvI0yUzT5Kh9oWfCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nQC3Gxd2eyUB8G8sFbxDZs0oEgtakGo79+91pPjE0c3D7j48VGczrILyEYgIh8Cn8FUjGS57Y9MDzpjlpfPhuOpWK+HXvmq2nDJr6Cov0tNj5VppG4X1q7z4Z+IRnT2v194QUxMXiTvs2b0ICFdfvlkp+XDGNWjAws3jzlyB+wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=snosT+UK; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=IhhcCDU+2ooKNbUhegC94na+OdnsS3UuZ3bz8FOZEF8=; b=snosT+UKyAII2Wc7nTc8MNpVF+
	mIqgSSwuyse452MxgLHuEYo6EpYzZGUCDYNwtOstxDYEL+JeBarSYsVxIJ9IVtWJE72YotLOfmcTU
	lnZUNSkLnYQfKdkQzjibOFgi6kfAXkaABJbjicp4dgEAwinOduDwRW8ABOWolxutbuNz0diiD+2Oo
	SugXN+6RGtNe9l8c+A47FfTIgVvcmjYtcoBeX8qIv6NbGz2bXmJaxuOEdluOk6F5fCEUZVr7gQtkP
	MTCHC3kTVeTTDKBljl9wqeW0dpANWmvklpV6Q/HkZOT7U5WaImyhB5q+35uhjYPDbkYvBgnAq7CMB
	81Elml5A==;
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uZnYo-0003fo-Q8; Thu, 10 Jul 2025 11:27:22 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Enable HDMI receiver on RK3588 EVB1
Date: Thu, 10 Jul 2025 11:27:17 +0200
Message-ID: <175213962000.1887379.8818372315895664398.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250704-rk3588-evb1-hdmi-rx-v1-1-248315c36ccd@kernel.org>
References: <20250704-rk3588-evb1-hdmi-rx-v1-1-248315c36ccd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 04 Jul 2025 19:14:14 +0200, Sebastian Reichel wrote:
> Enable HDMI input port of the RK3588 EVB1.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: Enable HDMI receiver on RK3588 EVB1
      commit: e2fe8ad8f1e62c424b8b73cc89d1bc53d19c41b2

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

