Return-Path: <linux-kernel+bounces-685798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39182AD8EC8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 16:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34C503BB3BB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 14:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9752BF064;
	Fri, 13 Jun 2025 14:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lk/XcyRn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2768914BF89;
	Fri, 13 Jun 2025 14:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749823232; cv=none; b=tOOQU/8cvIxEgrfR4AgsPjBuqqqA2fOGdOVTftegmnhnGX+VR41v/cNR0A0aT80CVa9XevBBAB/pAzFVNMwGHLks5a/n+R4iANgSg/wwoSxK8ua986YebnMlYIZh7kjCLaMfKVyN8PNMvrOCcuQrSlmQydTRKh079JfjwP15pUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749823232; c=relaxed/simple;
	bh=H76P9O5vnRjLnOJ2KGvl9BaRxTqr0YGtquLAPQfhvcs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=I+XVCFD0G3TraM6sXHIT5UvC016T+ndf/UGySkn02oHDOdBZFHjSI1aW1PS4NLkmaDMBPrUmzrYY+R0GkhtLUE2SPReilUZyPBnRJKPWaZcwet6RuFPbURf0XO7XMW9t61VcZgEkgYvMK6KoFOF3BNKj2P1sL7XsqWYABI2xQ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lk/XcyRn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A332C4CEF0;
	Fri, 13 Jun 2025 14:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749823232;
	bh=H76P9O5vnRjLnOJ2KGvl9BaRxTqr0YGtquLAPQfhvcs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lk/XcyRn69dyFz8G1KM5qJqbly0C63sDuWgT8i9cyKCb7oGGWrZ1nnh3gG6KZEAZ5
	 1bKNJ3Sud8bbaDR6DilpTK3FHwIDjHt0aPVCn/pJCMc4vQpKpxDlg0RpgbL/QdWwmZ
	 8eF1k6QfsWrlznmBkkltBklJJ2QdIHePGWg5iofNKlrG8tUekyaeCydawVB8vcZupG
	 HEA47qG2YWSrrT0jxtiHrdX9Y1x99C5HG3qW49Rew8SqjcitsuxIMX3saCLkCQ4zpH
	 r2gJ3hY/VqK5z3zY02DJKYR5oRV5D/nctY4p2xi2cuwMm98Ipi9gAZCF28beJY5/ZW
	 BGSKR01P1ZPow==
From: Lee Jones <lee@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Lee Jones <lee@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 Vladimir Zapolskiy <vz@mleia.com>, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dmaengine@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, Frank Li <Frank.Li@nxp.com>
Cc: imx@lists.linux.dev
In-Reply-To: <20250602143612.943516-1-Frank.Li@nxp.com>
References: <20250602143612.943516-1-Frank.Li@nxp.com>
Subject: Re: (subset) [PATCH 1/1] dt-bindings: mfd: convert
 lpc1850-creg-clk.txt pc1850-dmamux.txt phy-lpc18xx-usb-otg.txt to yaml
 format
Message-Id: <174982322878.923450.10813100067215475436.b4-ty@kernel.org>
Date: Fri, 13 Jun 2025 15:00:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-459a0

On Mon, 02 Jun 2025 10:36:10 -0400, Frank Li wrote:
> Combine lpc1850-creg-clk.txt pc1850-dmamux.txt and phy-lpc18xx-usb-otg.txt
> to one mfd yaml file.
> 
> Additional changes:
> - remove label in example.
> - remove dmamux consumer in example.
> - remove clock consumer in example.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: mfd: convert lpc1850-creg-clk.txt pc1850-dmamux.txt phy-lpc18xx-usb-otg.txt to yaml format
      commit: 8a22d9e79cf039512d56bddeae038a249c26f977

--
Lee Jones [李琼斯]


