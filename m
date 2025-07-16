Return-Path: <linux-kernel+bounces-733715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A01F9B07827
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7777F3A284F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6D4264602;
	Wed, 16 Jul 2025 14:30:38 +0000 (UTC)
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B795263889;
	Wed, 16 Jul 2025 14:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752676237; cv=none; b=MlF67vIUnXOmYyUgEFpg4zCTJBk722WGCJ4QQQxvurC27F5TQNjVuzkuasSCbZZ66u1efMsJeSNfVlbmweTDN74PKgWhquGhNW92m9RM077XhWTc4YuTWioSGGYdTIKUxCsQ/iD7T54gC5u7ppyYwOQY40fb9wbRC+2K8Xnia2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752676237; c=relaxed/simple;
	bh=KYPR5zMwjv9ZkbNWdRQQpTF0AKu9yHdbi7BjAVMCMcc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ne+1vFHs5/zHi4WiRbOls07oLzl1XcAlG7CVnBksjkZ1hIjRcF6gTEwry187BDPfGhLfaOsMPtqUsfS+00izBT9Y4Hlv2fNfXQPZuRHa79PTGL064tY/WDBTCpTassJnv6zO/W8j5GRrhC2UudpdP893RQ/FgBCFBjiLf3AbJU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.214.181])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1c3b8f49f;
	Wed, 16 Jul 2025 22:30:22 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: alchark@gmail.com
Cc: amadeus@jmu.edu.cn,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	jonas@kwiboo.se,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	ziyao@disroot.org
Subject: Re: [PATCH v2 1/1] arm64: dts: rockchip: rk3528: Add CPU frequency scaling support
Date: Wed, 16 Jul 2025 22:30:16 +0800
Message-Id: <20250716143016.620430-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CABjd4YzCL3U9yf65FUBE6EMqFjZHosULU7fUcjVo9VJ_=Ov+Dw@mail.gmail.com>
References: <CABjd4YzCL3U9yf65FUBE6EMqFjZHosULU7fUcjVo9VJ_=Ov+Dw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSk9CVhpJT0lLSUgdHk5PGVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKT1VKQ0pZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE5VSktLVU
	pCS0tZBg++
X-HM-Tid: 0a9813a4c74803a2kunm62c672118974a5
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ODI6Hgw*EzExDQ1LVk0MNTM8
	DTxPCz5VSlVKTE5JTUxNSUlIQ0pNVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	QlVKSUlVSUpPVUpDSllXWQgBWUFITk9LNwY+

Hi,

> > There has often been the argument that selecting a frequency that has
> > the same voltage as a faster frequency does not save any power.
> >
> > Hence I remember that we dropped slower frequencies on other socs
> > that share the same voltage with a higher frequency.

Sorry, but soc.dtsi on rockchip doesn't seem to have dropped slower
frequencies with the same voltage?

rk3562.dtsi: CPU 408MHz -  816MHz 825mV | GPU 300MHz - 600MHz 825mV
rk3566.dtsi: CPU 408MHz -  816MHz 850mV | GPU 200MHz - 400MHz 850mV
rk3576.dtsi: CPU 408MHz - 1200MHz 700mV | GPU 300MHz - 600MHz 700mV

> I.e. here the mainline kernel will always choose opp-1008000000 as
> long as the regulator voltage is 875000 uV, unless explicitly
> prevented from doing so by userspace. Whereas the BSP kernel [1] would
> request different frequencies for different silicon, e.g.
> opp-1200000000 for a silicon specimen with a leakage value of L4 and
> opp-1416000000 for a silicon specimen with a leakage value of L8 - all
> for the same regulator voltage of 875000 uV.
>
> So my 2 cents would be: no added benefit in having "lower frequency,
> same voltage" OPPs defined here until we implement an OPP driver
> reading the NVMEM programmed leakage values and selecting different
> *-L* voltages for each OPP depending on those. Once there is this
> support in the drivers, those OPPs can be added together with
> leakage-specific voltages (opp-microvolt-L0..11).

I assume this has nothing to do with the NVMEM driver?

From [1], we can see that the voltage used by the same board from
408MHz to 1008MHz is the same. The actual test is also like this:

The first  board: CPU 408MHz - 1008MHz both 850mV | 1200MHz 862mV
The second board: CPU 408MHz - 1008MHz both 875mV | 1200MHz 875mV

[1] https://github.com/rockchip-linux/kernel/blob/develop-5.10/arch/arm64/boot/dts/rockchip/rk3528.dtsi#L227-L271

> Right now OPP values with frequencies lower than 1008000000 won't be
> selected by any of the energy-aware cpufreq governors anyway, because
> their voltages are the same. Exercise for the reader: try to convince
> e.g. the "schedutil" governor to select anything below 1008000000
> without touching
> /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq :) This may
> change if OPP tuning logic is implemented such as in [2]: that will
> try and find the _voltage_ resulting in PVTPLL providing a frequency
> closest to what cpufreq requested, and use that for the in-memory OPP
> table instead of what was provided by the DTS.

Thanks for the clarification, so should we remove 408MHz, 600MHz and
816MHz from the opp-table? Is this also the case with GPU's opp-table?

Thanks,
Chukun

--
2.25.1


