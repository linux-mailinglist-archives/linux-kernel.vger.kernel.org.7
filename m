Return-Path: <linux-kernel+bounces-811241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8BAB52659
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 04:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD232583141
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 02:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D70620A5EB;
	Thu, 11 Sep 2025 02:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="Z319Chid"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176FA3FF1;
	Thu, 11 Sep 2025 02:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757556941; cv=none; b=tGCWvJwzfE33NVx/jkHM+yIDqtNAEa+oL8/ETaj7Uz7HarD0koBu4Pv2po7Gmib/+c/q7qV487mfJq5Gk4cfKD0Qz6LIce4xC2IE08bGWgJwfqe/rUxpETNTM9jTcB7BxrvP78NTQ+x/kGVcTmveBSClbxXeYKybj3wRY4F6SS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757556941; c=relaxed/simple;
	bh=SSiRaucCHQ4Dx8FmSHAjTYaMbAoODYXC3mIVmJLuKN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qzyki13T+CZ9irsjJKRRC2RbSw5QI3m+4w1iWWUvq6pE/eFpCeuhwxp3yzJDVbujyCi23qSCDbBvpc0+U/A7tUrOTU+cpXDemwxpCeZyDogijCsI/9ZAruqjuR8MXBs3d5NY7f7Kyo3VVCJB2Vfju38DVcKAX6+qL5b8x8naPLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=Z319Chid; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=+ANbRHVMw0mnGda34bSjs+M0HowPfnWkfMAWAlf5L/M=;
	b=Z319Chid69hmJgJlrAx+DlYiT5BzkPwCEtdfJrSJDh72JGa4WYTUI2tImqxJkU
	88FJzcvPtm+TslP9pH3WTlSYxo2OWJsLNUag4HAKvp+jqiSqt/0941BS4VXSDMJm
	IfawxAty7uDNu6gMAhmgUmDnLvJI+xZI9Vgc1ancmvPK8=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgAn5W6RMMJoJIhGBA--.44820S3;
	Thu, 11 Sep 2025 10:14:43 +0800 (CST)
Date: Thu, 11 Sep 2025 10:14:41 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] ARM: imx: Kconfig: Adjust select after renamed config
 option
Message-ID: <aMIwkWRY5c7tLIxV@dragon>
References: <20250826092901.43141-1-lukas.bulwahn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826092901.43141-1-lukas.bulwahn@redhat.com>
X-CM-TRANSID:M88vCgAn5W6RMMJoJIhGBA--.44820S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUOTmhUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiIhP6YGjCMJOieQAA35

On Tue, Aug 26, 2025 at 11:29:01AM +0200, Lukas Bulwahn wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> 
> Commit 3f490a74a8a1 ("clocksource/drivers/vf-pit: Rename the VF PIT to NXP
> PIT") renames the config VF_PIT_TIMER to NXP_PIT_TIMER, but it misses
> adjusting a reference to VF_PIT_TIMER in arch/arm/mach-imx/Kconfig.
> 
> Adjust the config reference to the new name.
> 
> Fixes: 3f490a74a8a1 ("clocksource/drivers/vf-pit: Rename the VF PIT to NXP PIT")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Applied, thanks!


