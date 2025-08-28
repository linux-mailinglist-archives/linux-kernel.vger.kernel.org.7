Return-Path: <linux-kernel+bounces-790071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C3FB39F01
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4D153AB4F7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B767313E3F;
	Thu, 28 Aug 2025 13:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="ykOBrZ7U"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CDC312829;
	Thu, 28 Aug 2025 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756387834; cv=none; b=t8rvn05w7v7KfaSEJvHeCuBQPSOfEUwE6fwxw+6sNsTzzi0+8oR6tNkPXZxRTOQAozsrkBSs/pHksWEgXJfPWFWj8VTEkkxudvsdRe5IxtVo0aLLD7awHeNantOPJrVFoZ1pi1QHY7ZSIUTotCH6jbwgADYjQXFTQCn5xtW1sXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756387834; c=relaxed/simple;
	bh=2cTZabYnaw3+u5tTEUzhHpRMXna671K+0RIe5C/DJGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tChnJx7QpHyVg6IVG/MqsUCCvNTKopGBIAU3nFlpSi0oOtTDPB1/fuuxXM1ayeSErbb95lNv96htYcXLXe+VVxB2BtXVXwdF2QhBX0xuLbF/gtXEnbfChV9js6qGZbwLGLU81IDKDXRvRtsIc0pgdXxeBedcqhvBWrOVuXGmIVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=ykOBrZ7U; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=f04tksORT2Z5GubC2DtLa7iShjF1q6m0nSzFPWX6pWw=; b=ykOBrZ7UblBvuc1IYSCp7ZX/pu
	Go5kXq27uB8uWBBImBuwlvFrYHOctgt6ormziStYxlPotkw0qv1xSqRfvbHFqGukv2vS6V2XaKVm6
	FkquplLdIwndXV/Sn4/CHU4u1KN1eEOhONMkuuct+Pa84npAh/ZQaM2nSmeYcNNLbCYUUqkJLHOb7
	vKYV8uplh6gR9H7EhWhnfQijVLyIJAxFWk/riHV8VpyHqzJCORacsHI94gjQSVkfGNkvQyleOpzgn
	11Ww/qT9PWJZosEApRU5ylnRCGiC68dzODsVe1hsJ8mciVZJP6TN06o6n4FPi7KUdWk9YgVlPlpmN
	YK7/IJoQ==;
Received: from [185.205.242.134] (helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1urchz-0004qj-06; Thu, 28 Aug 2025 15:30:31 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: anton.kirilov@arm.com
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	nd@arm.com
Subject: Re: [PATCH] arm64: dts: rockchip: Enable the NPU on NanoPi R6C/R6S
Date: Thu, 28 Aug 2025 15:30:26 +0200
Message-ID: <175638782391.3533599.15783338946891091467.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250827142210.2221606-1-anton.kirilov@arm.com>
References: <20250827142210.2221606-1-anton.kirilov@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 27 Aug 2025 15:22:10 +0100, anton.kirilov@arm.com wrote:
> Enable the NPU on FriendlyElec NanoPi R6C/R6S boards.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: Enable the NPU on NanoPi R6C/R6S
      commit: dfdda0881b353453afc376f7f2bf6a8306fcada3

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

