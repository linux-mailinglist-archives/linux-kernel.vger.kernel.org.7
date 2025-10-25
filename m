Return-Path: <linux-kernel+bounces-869912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D898CC08FB3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 13:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 920933B9A77
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 11:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4D72FAC05;
	Sat, 25 Oct 2025 11:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJQlmbL9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B508D2F99AD;
	Sat, 25 Oct 2025 11:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761392935; cv=none; b=aeMp7kLqljZzMcThnZTqNlka5bFrPrGp2a0IGR+FcxqfSH7AMNt66iI/UqvjZat6R1+l67tkO1VO/0M+qB4AGYsI1BXAz7v38lR2fpk25fu5d+KrACZNa924+OSnH77vRUFUAk9zdAWMpvS/fZQe7056iiU22Y9d5xRP1oLs+YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761392935; c=relaxed/simple;
	bh=5QcXZmEDlre7Pfjfg0YVCIP6smPcgmXUIla/6CAzmaI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nyY7NttyugS2mVd1aDOygWMTL7iqmvvv89F3wsZbfJLRez2QiJMTWLjuMGgjuEoLL7vm03FitsGSlFTL60o+DcCTCIJxfSuiW7mvcw8z6ehjE/UW0MM32DOVCV36VNH20z7LFW459cF800DSWNHGXVrleC52F8bsRAedjuwcXjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJQlmbL9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD88C4CEF5;
	Sat, 25 Oct 2025 11:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761392935;
	bh=5QcXZmEDlre7Pfjfg0YVCIP6smPcgmXUIla/6CAzmaI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HJQlmbL9aliiO4jy5BqcoFwPpRpyfbASx9jBh+OrHDkglAn1X7HJFFv7mtkdP+AER
	 G4a6+j6glB4EQdu+FKWsX5OI9AKcDK50DlLahdZD6ipX010JiXOA7cJ9l6yMoFrb5k
	 h8fValTG53dfBVMqkUlHPChgRfs4xpOJ7nWeXWpghpnkZdChF4r5sCBP3loxD1vyXM
	 SBkzQ0ZACLjRcw22o84tNw1oaZipnPBLniy+Aj2X+mDH4hiBkPF0yjZHyGe9SNTNhI
	 e3umtIRp265AlkTfhC+oT4IS3pZn8MvUNZSe7GF5Yy1A7N9U0VGk42t9qI90f5Vw5a
	 wsuuZFd+uQ+JQ==
From: Lee Jones <lee@kernel.org>
To: Support Opensource <support.opensource@diasemi.com>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Steve Twiss <stwiss.opensource@diasemi.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
Cc: imx@lists.linux.dev
In-Reply-To: <20251014184114.2353199-1-Frank.Li@nxp.com>
References: <20251014184114.2353199-1-Frank.Li@nxp.com>
Subject: Re: (subset) [PATCH 1/1] dt-bindings: mfd: dlg,da9063: allow
 wakeup-source property
Message-Id: <176139292718.57173.11205869214255849611.b4-ty@kernel.org>
Date: Sat, 25 Oct 2025 12:48:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-52d38

On Tue, 14 Oct 2025 14:41:14 -0400, Frank Li wrote:
> Allow wakeup-source property to below CHECK_DTBS warnings:
>   arch/arm/boot/dts/nxp/imx/imx6dl-emcon-avari.dtb: pmic@58 (dlg,da9063): onkey: 'wakeup-source' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> 

Applied, thanks!

[1/1] dt-bindings: mfd: dlg,da9063: allow wakeup-source property
      commit: f17f1b16e90581d1a1d95781f94b8c57d5b43af1

--
Lee Jones [李琼斯]


