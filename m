Return-Path: <linux-kernel+bounces-850535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9BBBD31F7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9FCE54EE3E2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A64B26AA94;
	Mon, 13 Oct 2025 13:00:26 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F6111CA9;
	Mon, 13 Oct 2025 13:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760360425; cv=none; b=hlleB3iBggo9OH8zG6nDGgnrOVLhmGbnVAG8h0ltyklZoScjVT9STuc1RRJndmNDKo6oHrNRULQqti35dW4Nk0Wb4/IDPlwQqorMfcY2xW9h2Yz6xH121lUWpqP/kuV74Kn3v1l0WDY04cj1n+m2BFRbB7S/nXG5eW8CReifcMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760360425; c=relaxed/simple;
	bh=vEfTWo7zWY3pPoa8E6MG3IBuWPCn42p0TYn1oxbgU7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bdb/rcJXXWSCTuWmSK/4Q9v8TFttG+sL6+TAKXgVf6Nn8vbkpuMkH53xPrikdXPng1Y+h6YxosgqNOphOH+RGU9bkh3TiwQ/Vtjv8lwXl9xd91i/3ktIlopaxQ/4vqUCnkXxt77jhFPcJ1855u47CIqN+XsLzl7RRG6NmS09x7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [116.25.94.88])
	by smtp.qiye.163.com (Hmail) with ESMTP id 25bc09e05;
	Mon, 13 Oct 2025 21:00:17 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: jjm2473@gmail.com
Cc: amadeus@jmu.edu.cn,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v5 3/3] arm64: dts: rockchip: add LinkEase EasePi R1
Date: Mon, 13 Oct 2025 21:00:10 +0800
Message-Id: <20251013130010.143271-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAP_9mL5=GmtJF3nSbfX6gRzPc=fAMrTOfMuOLyWFwq5D4OYUFw@mail.gmail.com>
References: <CAP_9mL5=GmtJF3nSbfX6gRzPc=fAMrTOfMuOLyWFwq5D4OYUFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a99dda846df03a2kunmd8d8089cbf42
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDQhhCVklJSxoYTU5DQ0tMTVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSk1VSU5VQk9VQ0NZV1kWGg8SFR0UWUFZT0tIVUpLSUJNS0pVSktLVUtZBg
	++

Hi,

> +&pinctrl {
> +	gmac0 {
> +		eth_phy0_reset_pin: eth-phy0-reset-pin {
> +			rockchip,pins = <2 RK_PD3 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +	};

Leave a blank line.

> +	gmac1 {
> +		eth_phy1_reset_pin: eth-phy1-reset-pin {
> +			rockchip,pins = <2 RK_PD1 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +	};

> +	gpio-leds {
> +		status_led_pin: status-led-pin {
> +			rockchip,pins =

No line break required here.

> +				<2 RK_PD7 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};

> VBUS on usb2phy0_otg is floating, this USB port only works on
> device (peripheral) mode.
> phy-supply is optional, so this should be fine, right?

Yes, if there is no log like this:
supply phy not found, using dummy regulator

