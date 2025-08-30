Return-Path: <linux-kernel+bounces-792962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3DDB3CAF1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 14:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 826F7582CAF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 12:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE1927EFF7;
	Sat, 30 Aug 2025 12:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="0kuy4wFj"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556BD279DCD;
	Sat, 30 Aug 2025 12:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756558697; cv=none; b=D7BwAR/bkZ1EGCi8BvkgUxVXXcmEZ8X+KFE/BhHpzGXArzXRzZroA4J/Jy8CE5NbhHHOIi0/ZMLi44l1KsLZtbsSgETrGgrG2Mj4Ktj1nyHd47z3sEA0epblNrP9HZQid60YLfu6PBHPnEhA68DgloUEXTkd3m91YqIL0ad4Kcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756558697; c=relaxed/simple;
	bh=aLdCpQk4qOOH9n4eTJvltiNy1q00UIQZSVG+Xc8ANlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tICjK8XB+mr8OGcU6Ii/DjJEA3ZvwQAXUMkNuCxBwFdf+HCy2SMAYKijLKK+SD2jV2AwgtKu9RVcPAB/tOvgNhVyKOgNRI6OVGe8GqxDcmj94bO7H0MgOr8nnVy/5Rbjku5yBlY6O3DovJitoIKepc9i8IIb5wGN+Mg1aPTF85w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=0kuy4wFj; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=X14SQTki9ZasmMlzi9oTZ8zLId5Sezu3LhgorHtMYcA=; b=0kuy4wFjJVcSrD9YmLdqAo06S0
	tdmp1+CAZpCCB50kKh9frPAwxf33cMyBxEIOAnbwbqeOFut3Dx/nQDhr+3LJt1q22qaq/6TrJeohK
	xIJjy67urdGDEdT6T/jXWx7juTEvARx/BN3AYYB3Z7KWTtVt7RbCklvq7dmIGi0Vyw7yMituLbQXr
	D2wD3RwSP4iLF6p/KzzwS4lX8MMajahDVuTR8Qh+X9kGHROXPTy0pQON2EaWVgNMGaYymKvQPjV5Z
	oS2nEU/J/rLGfyAldwYyV5L2oJHuZRXCfWWz4virMTWaPus7W6R/IJTEmtehC1OAlczJXNvYWUBiA
	rAL9ZIGg==;
Received: from [77.241.232.9] (helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1usL9e-0007bC-RV; Sat, 30 Aug 2025 14:58:02 +0200
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
Subject: Re: [PATCH] arm64: dts: rockchip: add IR receiver to rk3328-roc
Date: Sat, 30 Aug 2025 14:57:51 +0200
Message-ID: <175655867259.3578496.13748694495805410001.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250829054547.4053558-1-christianshewitt@gmail.com>
References: <20250829054547.4053558-1-christianshewitt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 29 Aug 2025 05:45:47 +0000, Christian Hewitt wrote:
> Add the ir-receiver and ir pinctrl nodes to enable the IR receiver
> on the ROC-RK3328-CC board.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: add IR receiver to rk3328-roc
      commit: 7c50e0cea2549a8d673bad62abf9be82b71e5477

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

