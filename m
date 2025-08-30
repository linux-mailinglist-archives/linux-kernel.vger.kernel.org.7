Return-Path: <linux-kernel+bounces-792960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6ECB3CAEF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 14:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00BD45E8111
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 12:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F31C27E07E;
	Sat, 30 Aug 2025 12:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="IgkJzNwo"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555A8275B04;
	Sat, 30 Aug 2025 12:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756558696; cv=none; b=J4MV/27BzEh5mZVSUfwhG6Qj3ErO1kCT6gruD/8xATVOlLUFuZ4uldjzlmdUMOKY0ccBpLlnVpgqe7X0ifFwvkvfx+CqnSq9xoiZJADlvK4Yaw5etR79OVuj5oK6GRBSG4voXCoYYrON5WS1ft97p3JA43OetzlOp4t1qdNYj50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756558696; c=relaxed/simple;
	bh=q5//S9MNQg8Ci4fbQAwksA280wS2Re9LSdVWpDA+tE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LhIqbfkVLZAZsQiNdcCYZu81Rvigu1qkP3VEyrbIDbUGka8cMUEhbffn+mpFWYixrXoKdxyB1F2L8vGrrD9VlI71rmXfiNr+qEhH7+djMVx3PlpgNKOWBX1uF22lvac7sQmhae7n8m5kkTaBrdSmsSWiYPmISCVpE4zHScZVuiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=IgkJzNwo; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=cyeksMM363Muy7eoR4PZwic5CrAi696wMNmLIRYM+CY=; b=IgkJzNwoqvOdFKPjReSFGp06ik
	++yGvp7odhI7g+JD6FIgkhG0CIac09VbfKOD+gAcfAr2wi/Ok11FScytffpOhFkInA/VZ81D1QOMg
	XV6jCz84xbBIKdfi/cLMvMHQEFaDCiaQ/u8Tevs5DRMb49iw/x4ZsddCILbyR6JnIg1ka/QMtowzO
	4Vb4pN0UaUfQXfLHnEklWQThM8NP6THuyt29M8Y37aRtQVScqodjvyGO+VdIfX5315+t5G9XU/187
	rkbSdtJxnxQE91fiPfQVToAtNFRmFCi9ee7fNSlC2oZXdfTUNmLBmA8NUjtfQQk2ZeEh41YDMVix6
	tkubLmCA==;
Received: from [77.241.232.9] (helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1usL9f-0007bC-IA; Sat, 30 Aug 2025 14:58:03 +0200
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
Subject: Re: [PATCH] ARM: dts: rockchip: add CEC pinctrl to rk3288-miqi
Date: Sat, 30 Aug 2025 14:57:54 +0200
Message-ID: <175655867259.3578496.5154920723858883845.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250828165421.3829740-1-christianshewitt@gmail.com>
References: <20250828165421.3829740-1-christianshewitt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 28 Aug 2025 16:54:21 +0000, Christian Hewitt wrote:
> Enable CEC control on the HDMI port for MiQi.
> 
> 

Applied, thanks!

[1/1] ARM: dts: rockchip: add CEC pinctrl to rk3288-miqi
      commit: 2850f6f1ecf2a42c6ae7a6d55874c9eb17eeb622

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

