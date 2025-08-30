Return-Path: <linux-kernel+bounces-792961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C82F7B3CAF0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 14:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A8165E8136
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 12:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FCF27E1A1;
	Sat, 30 Aug 2025 12:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="govHmqqp"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55659279DC4;
	Sat, 30 Aug 2025 12:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756558696; cv=none; b=kNV+6h54HnQPw/ZaHJz9wYxpvUGOIUboYh7KHgQrQinqLrzDxaTPe0tQjfUY8baWZdZKEbVt/OiX2DWIaVpwL83Famafj/WDoX6lxGWT+hUyexph9ulOy3lVwkVUm43MP1sAakvmssvWkv6lGvketpu/CwrSlZn8w08d8ah3ycg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756558696; c=relaxed/simple;
	bh=RcVSmRC79Jf8VN5R5rO+AkRtTeQOx+RqdutkSm/+XR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pq/DVL3ZcD5nVoSdtDNdGTL2v15yXfU7rLT1+dUEmBmC4TsiSgAaKDPNP4NH3nzmD6+iPotNrO36v/cVu8U8XNo4BMFWUq9ushQQ+Be/zvtPa7mnXQKoCcMOCETtyuXsPEaKnhuHb8sSYdprBnrjLnDtzrHz/X1fBb00kCHh9KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=govHmqqp; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=x/dkWKo2DNAfJeWWb8yeq3cKKBe9SgmP3N40zr/J1DQ=; b=govHmqqpHCquzVG0n0T3/QySIt
	eRbzqlM6tmeQQi6bDjG/q1sdTkrodW4yK6E8c5hE4OiueE9kOFGHxx7NpuewBDPTRCddfOIOSkSar
	2R/p49BFdKH0fdQxv/loZAnpYYiS5vpAL1QOGKXtxyvZgug12XA1tBOy9d5q24oQ2f9hbpabq0GNc
	F9fbfxe38dDETxaTc1kQTKRixx+RadQsjapk9Ihoe1Q9d57DpyU7zE6J2Z3zPIWD6VotLSSjaCEVi
	H4BfukOhYJPHdQe3pFg9Rl2nuaIr34KZt1jYAN1uCnBVlTGkleoIvTsi+EiS3Kw0Qh8iAYkVvYol3
	4Nx2NbjQ==;
Received: from [77.241.232.9] (helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1usL9f-0007bC-AT; Sat, 30 Aug 2025 14:58:03 +0200
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
Subject: Re: [PATCH] arm64: dts: rockchip: add USB3 on Beelink A1
Date: Sat, 30 Aug 2025 14:57:53 +0200
Message-ID: <175655867259.3578496.17878662770551692525.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250828171645.3830437-1-christianshewitt@gmail.com>
References: <20250828171645.3830437-1-christianshewitt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 28 Aug 2025 17:16:45 +0000, Christian Hewitt wrote:
> Enable USB3 for the Beelink A1 set-top box.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: add USB3 on Beelink A1
      commit: cd20b50f4ea926aed3586f7200d95727368b021a

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

