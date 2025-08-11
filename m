Return-Path: <linux-kernel+bounces-761992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 889D1B200D7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29B1916E7E8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28B12DAFA6;
	Mon, 11 Aug 2025 07:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="CgnpbDDn"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D897F2D94AE;
	Mon, 11 Aug 2025 07:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754898742; cv=none; b=iBQD+ZuWLnq8PA3cV9UIqmfuPwGAMi0phB6p4U298LRXIEMAECrx3GHK3qzKU00ggY8spWLvvR7zMKLNtWn+MtzUDYwU0DfgibXBDbH7SAOa0YZ25JYrFxow8mN4kgnt1eMQaKUVgaq3f+KhWLzesudIMmT0vVZzW8aD7z3NjVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754898742; c=relaxed/simple;
	bh=pa3mSlWo6UWxCuLMBiX+Lmtwcj14hZ3VkXKZtCc5hvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kb5D/S9tcI0WDEb/D1g2GNI+yLHhherHbEcSnIlD8yKodoOg6iZHOnMdBdSGl+1ahRn/7J7W2I+YsisbawxCbU3YE4ZnszbaxlJPBiaJXpc39Ux/cZsX4q71rfXJe6TlcgkOED69CWzIFQSCziZaPA7VioexPoxTE+TJdUHF1tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=CgnpbDDn; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=1KiC4N41/KHigU06qv8He7zylxzTPNYQyWifnaopVfQ=; b=CgnpbDDnSRDZtTYOR777mqH/Y8
	B/6E0EA7JUyq61MEu6+3YVYd0rs3JGriIs7mFCD+4JZ09sRdB6PNgCUgPVGekA9KwrKmm+u73RceM
	lwxX4Y4Xv/l6JhtG3Iw86Izy6kEEgEenvBWHhUNVctzKyXTE31BnNWut4srzL0oV/clR1flUtsN2k
	9uiVzh/7rqBzsikonyA8VZsh+oQi4xFYBT4oktGgptjNXOwCELp5dKpUKnGuE+F4yBz6U1GHize3a
	6H8zY9SKzgqawBE4TRGq0StTPDc92r9/WNA8CMoRV52+0Es/6667CU1WaV2Dg4ldaI2o2MK/gFQxx
	+PLn3beQ==;
Received: from i53875a0c.versanet.de ([83.135.90.12] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1ulNKK-0007Ro-PA; Mon, 11 Aug 2025 09:52:16 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: anton.kirilov@arm.com
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	nd@arm.com
Subject: Re: [PATCH] arm64: dts: rockchip: Enable HDMI audio output for NanoPi R6C/R6S
Date: Mon, 11 Aug 2025 09:52:01 +0200
Message-ID: <175489870459.808197.8017772403276802011.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250807170012.88178-1-anton.kirilov@arm.com>
References: <20250807170012.88178-1-anton.kirilov@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 07 Aug 2025 18:00:11 +0100, anton.kirilov@arm.com wrote:
> Enable HDMI audio output for FriendlyElec NanoPi R6C/R6S boards.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: Enable HDMI audio output for NanoPi R6C/R6S
      commit: 91ec67fa33250059a0c52bbf3148302f364a6e99

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

