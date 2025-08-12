Return-Path: <linux-kernel+bounces-765290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DCAB22E22
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83B4F168290
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643052FABEF;
	Tue, 12 Aug 2025 16:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFemb9Pq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AD52FDC3D
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 16:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755016899; cv=none; b=e6mBiWTcWkdt7Gxa5VkFDR1D8gugVQ6txR/Fa9lv1LDlRcmfZ4CAnijqeSq004sxWihXGIA47QYN0CrL3U8/49oaPqsc2A6rxYhMepg9nFb85oTVo1wV49kfZcY+CpnDNdcGI6siBZjHMwDzxhmF9Qt6SJpAc6zs37E1IzSm9Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755016899; c=relaxed/simple;
	bh=dE2xwVe5G7Nhj4rDbrWqeDO5E+f+C3chdUySaONj5vE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VqQ/mJOfejd5xNUOUrMT+e9nl8zPLrRHVYQHMidleArUOrby/M+3yAiVfrvRNxmXSb7STZzjtwxlum1ZtIg5Fe4LIHUYYKqkL5WwPihnaPy49hpYWxNxvyAn0hL4Ztpkf604StfuHfG01P9Mw28zqw6/FUJFwaTww3J6gideXjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFemb9Pq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51301C4CEF1;
	Tue, 12 Aug 2025 16:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755016899;
	bh=dE2xwVe5G7Nhj4rDbrWqeDO5E+f+C3chdUySaONj5vE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BFemb9PqKS6hs7DNmeDiUOnWy/C7lXLfpJ2MKVCYqtDeoaFCZRR6FASWvd11SStiz
	 nB4WKHeEDobaFXbz7ebALS1mswyyctTyqe3BCiwFPSZ6ptKLmTPdUikyeL2S8yGHtr
	 Qrh24hBI6FpcpohRrQ0FjPirLgkyScVeyIPoia9pfQZOKoDCpSCpF1hNVbzLFWmku7
	 NXhb9QCMb8vBpltcMgYOiQw+nnx57ZieRWqOvefs1y9ws7EDIVof9mwBoV9DDLkacj
	 G5zjqXxeHaLUzXw0nRsmowPulADXVyXcuybX6ji3TiOsMK4E0D6pNxwaT348EgNR5a
	 gLGqiWHm8xOvg==
From: Vinod Koul <vkoul@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>, 
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250724131623.2662-1-johan@kernel.org>
References: <20250724131623.2662-1-johan@kernel.org>
Subject: Re: [PATCH] phy: ti: omap-usb2: enable compile testing
Message-Id: <175501689789.633310.16803003001477331009.b4-ty@kernel.org>
Date: Tue, 12 Aug 2025 22:11:37 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 24 Jul 2025 15:16:23 +0200, Johan Hovold wrote:
> Nothing seems to prevent the driver from being built on non-TI platforms
> so enable compile testing for wider build coverage.
> 
> 

Applied, thanks!

[1/1] phy: ti: omap-usb2: enable compile testing
      commit: 8343cfb636261f36796fde0e79a858422eeb0207

Best regards,
-- 
~Vinod



