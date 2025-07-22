Return-Path: <linux-kernel+bounces-741418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2CAB0E3D4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 21:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B46D5660FA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8882836BF;
	Tue, 22 Jul 2025 19:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="lr2x7wIz"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418B92798F3;
	Tue, 22 Jul 2025 19:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753210984; cv=none; b=WRZ7anh+zoJlE+QZLONGf3Y47eKB+vJ27zpS8Ki/nS3DBAM7x4rl27QTfqLBqAsViZ7bP646jR/fCcVJ0pU3wLOHgf2itzutW1H1EZhEo8VHxGGycdUx8jyWTjA5JPQFDfwQrbo3AkC/Slw4MbBHmDrlg149Sk9f9k3QPEZ0gBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753210984; c=relaxed/simple;
	bh=x+xNlYcHIfH0BUVjrTxYMTUyt8urQaFIeQ6X5dMM9kY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qz7lqNWQsSdi67zefvZQG5/pVq8wxwvU75Hthp3qA73bkGmRnBBjPKlmvmW1UQuJgFwqaxTl7RDFTpQ7vLy8ICGNyd78HPPrXpf+r1h9KdxKBhS9km5fHaEENy1uKIIwh99fCeWIujhdydTQgm5nQZfdNz7w9zJtBkUJ0fw2oxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=lr2x7wIz; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=fpHbqa+GZa+9xtkjqGUyA4wPVQgcPiYEdCW8HwmxJKw=; b=lr2x7wIzdyYfzWxnWrlp1LsOcT
	xAn9Kg06imYc2Vs0UJNYeBSOOE/GoBqJiRK642uNvjjb5cRJvcBF49FN8wCS4PQYZmftpCYNB4oLY
	ebUbZ/7gv9TzrTq7bU/53+C5B4xlCocgu8w94+/h+0SgILdXkiOuCw1wgwVoZMrg5SCp/pOCWAStC
	fAJweD3LDAeeKHedCfYvYstEzaHOX+DRqawsX6YSX5JIHrM7FzA6y1nXyUe2PVulbpnFAY9yCFrPr
	Q5ASWz2njNTawNz2uOiJjSafMXrjJ/mzE14xrZ4VubOflXxfmMxv8LgYo9ZxUCsed0AqCxt31cRo8
	KUAuXWNw==;
Received: from i53875ad2.versanet.de ([83.135.90.210] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1ueIGD-0006dq-Cz; Tue, 22 Jul 2025 21:02:45 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Diederik de Haas <didi.debian@cknow.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Dragan Simic <dsimic@manjaro.org>,
	Vasily Khoruzhick <anarsoul@gmail.com>,
	Tianling Shen <cnsztl@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Drop netdev triggers on NanoPi R5S
Date: Tue, 22 Jul 2025 21:02:43 +0200
Message-ID: <175321094779.3804838.4193109122815719935.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250722123628.25660-1-didi.debian@cknow.org>
References: <20250722123628.25660-1-didi.debian@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 22 Jul 2025 14:35:33 +0200, Diederik de Haas wrote:
> Sometimes the netdev triggers causes tasks to get blocked for more then
> 120 seconds, which in turn makes the (WAN) network port on the NanoPi
> R5S fail to come up.
> This results in the following (partial) trace:
> 
>   INFO: task kworker/0:1:11 blocked for more than 120 seconds.
>         Not tainted 6.16-rc6+unreleased-arm64-cknow #1 Debian 6.16~rc6-1~exp1
>   "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>   task:kworker/0:1     state:D stack:0     pid:11    tgid:11    ppid:2      task_flags:0x4208060 flags:0x00000010
>   Workqueue: events_power_efficient reg_check_chans_work [cfg80211]
>   Call trace:
>    __switch_to+0xf8/0x168 (T)
>    __schedule+0x3f8/0xda8
>    schedule+0x3c/0x120
>    schedule_preempt_disabled+0x2c/0x58
>    __mutex_lock.constprop.0+0x4d0/0xab8
>    __mutex_lock_slowpath+0x1c/0x30
>    mutex_lock+0x50/0x68
>    rtnl_lock+0x20/0x38
>    reg_check_chans_work+0x40/0x478 [cfg80211]
>    process_one_work+0x178/0x3e0
>    worker_thread+0x260/0x390
>    kthread+0x150/0x250
>    ret_from_fork+0x10/0x20
>   INFO: task kworker/0:1:11 is blocked on a mutex likely owned by task dhcpcd:615.
>   task:dhcpcd          state:D stack:0     pid:615   tgid:615   ppid:614    task_flags:0x400140 flags:0x00000018
>   Call trace:
>    __switch_to+0xf8/0x168 (T)
>    __schedule+0x3f8/0xda8
>    schedule+0x3c/0x120
>    schedule_preempt_disabled+0x2c/0x58
>    rwsem_down_write_slowpath+0x1e4/0x750
>    down_write+0x98/0xb0
>    led_trigger_register+0x134/0x1c0
>    phy_led_triggers_register+0xf4/0x258 [libphy]
>    phy_attach_direct+0x30c/0x390 [libphy]
>    phylink_fwnode_phy_connect+0xb0/0x138 [phylink]
>    __stmmac_open+0xec/0x520 [stmmac]
>    stmmac_open+0x4c/0xe8 [stmmac]
>    __dev_open+0x130/0x2e0
>    __dev_change_flags+0x1c4/0x248
>    netif_change_flags+0x2c/0x80
>    dev_change_flags+0x88/0xc8
>    devinet_ioctl+0x35c/0x610
>    inet_ioctl+0x204/0x260
>    sock_do_ioctl+0x6c/0x140
>    sock_ioctl+0x2e4/0x388
>    __arm64_sys_ioctl+0xb4/0x120
>    invoke_syscall+0x6c/0x100
>    el0_svc_common.constprop.0+0x48/0xf0
>    do_el0_svc+0x24/0x38
>    el0_svc+0x3c/0x188
>    el0t_64_sync_handler+0x10c/0x140
>    el0t_64_sync+0x198/0x1a0
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Drop netdev triggers on NanoPi R5S
      commit: 60d89a256079895a154d0f714caee8c64de586f7

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

