Return-Path: <linux-kernel+bounces-887492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2450C385BF
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 00:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E58F3B035A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 23:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C906A2F658F;
	Wed,  5 Nov 2025 23:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="LX5iBlkR"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CE02F5A33;
	Wed,  5 Nov 2025 23:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762385202; cv=none; b=WROLFxHYdzzNB2wyBkTOJWBuXQ30W++v2pdhK59cy3kptybuqFYlOjCCK2niRzCvCyY7FOszw75uScVphm+Qsfr3hernxH8Kz/oenkmtEyQJC/YgO31Sw4zTbJgwtgI3mumhpSG3yeMhUQqzPkpeyUcyMLjQ1bUPkC27o4LTdME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762385202; c=relaxed/simple;
	bh=PIMhTwuVjXBk97J04AF7ttzGsns0vWw8LEqI5Oe/Y7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sBv9gLPk4RTdaFLYwSGQJfPbY2iwp2Ag1oOVR79U4aczSqYxm7GR2q8x8uzQj5gy8I33VMTAnnNLUcChJcT5vYdxZCoEMKmAYR00DqDP5uMA8+/Z9ooFCYQ1LFjXl+vJBvJBDlBYmMXl/6UjQeMtpQ7O2US7QkEDFhLvrqgp22I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=LX5iBlkR; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=wuFVci0OU2fN9OEAMkFdaSsZ4Y0TcQDJ7JJBOCcok8A=; b=LX5iBlkRbRi0vlWqwXCQ19fKzd
	PHiS9qvugmYaEiXl/VFD5u79R8DBHhkPPU7xiwOQ/p1yMwU9ZEpGRHg5l3P9Ota3u/XbA6C7Bd6qw
	bJXdjlDsmsgpCBTbeSTB030wIhy5ryWXtcBdhL2qKqw8wrDL2GIMsIzDesWCtvredOEKixoI0RZvM
	EiXJgRTHQwko2nq8WBYtNfSAv2CW5bIJp7sYFwLC1Rr68fFJ8Yq8iu4kcFTTAlgbI78jsXo3u7LWP
	9j0qZHZtwP8Lypfsqv+cX6S1UXqH1i7M9IjnVUdgIuuXFLaclY8uNbxwU1T2D1kX1H/Bq51Ww7kmD
	NVzwMjSg==;
Received: from i53875bde.versanet.de ([83.135.91.222] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vGmtf-0001FA-Bj; Thu, 06 Nov 2025 00:26:35 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Heiko Stuebner <heiko@sntech.de>
Cc: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	michael.riesch@collabora.com
Subject: Re: [PATCH 0/2] Drop RK3568's variant of the CLK_NR_CLKS constant
Date: Thu,  6 Nov 2025 00:26:32 +0100
Message-ID: <176238518188.156498.3345794880564705981.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251103234032.413563-1-heiko@sntech.de>
References: <20251103234032.413563-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 04 Nov 2025 00:40:30 +0100, Heiko Stuebner wrote:
> This drops the use of the CLK_NR_CLKS constant from the rk3568 clock
> driver and after that, drops the constant from the binding that should
> not have been part of it in the first place.
> 
> Heiko Stuebner (2):
>   clk: rockchip: rk3568: Drop CLK_NR_CLKS usage
>   dt-bindings: clock: rk3568: Drop CLK_NR_CLKS define
> 
> [...]

Applied, thanks!

[1/2] clk: rockchip: rk3568: Drop CLK_NR_CLKS usage
      commit: 2a42e3210d4331dddfb04b020050bd774cf99659
[2/2] dt-bindings: clock: rk3568: Drop CLK_NR_CLKS define
      commit: ca38f0f65eefd79889b409c89c6932d7e2fe0993

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

