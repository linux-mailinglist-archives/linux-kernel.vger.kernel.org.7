Return-Path: <linux-kernel+bounces-861215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4607BF2158
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8D0E18A7E07
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AAB264628;
	Mon, 20 Oct 2025 15:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="KEuwc5vx"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012CD21C17D;
	Mon, 20 Oct 2025 15:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760973912; cv=none; b=HHbYABIZyJZiOs1XxOgefKAd5/Z2P25pqbfX0JSpsNH47sBVpffyCnjJwRuUTA0QS9lJm/l+Z/GBrdvAIPrv0e0dfqHmKHE/LQdfzZ2w5jicVBYrmp3fxNUqeOO6YXFFrj/TNW0zamBE0klld7hrhmIOsDHinYA3IjMFsqGLBt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760973912; c=relaxed/simple;
	bh=bZHdXbGliS471bJEVtaICQs2UgcPF+D+TEtPHJ82sJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cbemll6AhNOhh8olDbGi+EG0uBpVQ23xjG7GoyYltnEMRwq4phYUHDIATDTydEtnmNHfMLXaHg8g5KSq9sRJpgJxrHHbpcjJokuB7a9dk4NyO1mIB8smXet8c0PFnEOZdhux2bC+6XcF7CWXkPpxkSzx6KoPOfmUvzwvG70DP/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=KEuwc5vx; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=NmhX4kAAyfaAWBf9jg1TYvPxGghx+4HQ1uSQaHLqzz0=; b=KEuwc5vx/e6kDEjIO3rjrixtnS
	oqjdbr/vo4yVqGp59A2by8CYFxZoL23j0lzT4clDJAMncPvYCSxDZebw6BwxtY3SJuleFJ40yfxHD
	50TkE9YPx/uEnARb4ZftLhNxCch5Wjn9oScTeVAC73WMcl95ZfWH5kH5IA4e20rKdeq4xL6ASKQKF
	PMhXftWXTaBDCuoB64xF96KhTSj6uwimGeBs9mvweMhcp3bKrDf+hi1i5ZOPgTaGm+xenwS2Qy5YL
	1BGdjO4tMg9fY+32av1W3BwDaV9SEE5yYoyx1TrwXaH6B9zAeZHAHq2dV+JOps/M1hPexpCpOM4zG
	NYARyCog==;
Received: from [212.111.240.218] (helo=phil.guestnet.ukdd.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vArkZ-0002qD-Sn; Mon, 20 Oct 2025 17:24:43 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Fred Bloggs <f.blogs@napier.co.nz>,
	Hsun Lai <i@chainsx.cn>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Conor Dooley <conor.dooley@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: rockchip: Add 100ASK DShanPi A1
Date: Mon, 20 Oct 2025 17:24:41 +0200
Message-ID: <176097387775.44471.9315562892075549326.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <0601AB836AE5F348+20251014021623.286121-2-i@chainsx.cn>
References: <0601AB836AE5F348+20251014021623.286121-2-i@chainsx.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 14 Oct 2025 10:16:13 +0800, Hsun Lai wrote:
> This documents 100ASK DShanPi A1 which is a SBC based on RK3576 SoC.
> 
> Link: https://wiki.dshanpi.org/en/docs/DshanPi-A1/intro/
> 
> 

Applied, thanks!

[1/2] dt-bindings: arm: rockchip: Add 100ASK DShanPi A1
      commit: ff29a83cda0f6eebb57d14f0a6456e3d1e5dc7c3
[2/2] arm64: dts: rockchip: add DTs for 100ASK DShanPi A1
      commit: d809417c5a4012feb4379cd1767549b3568906e3

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

