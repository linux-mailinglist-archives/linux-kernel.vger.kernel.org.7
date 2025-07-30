Return-Path: <linux-kernel+bounces-750812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE174B16153
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 15:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56A6B18C6438
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 13:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522B7279357;
	Wed, 30 Jul 2025 13:20:43 +0000 (UTC)
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10B11531E3;
	Wed, 30 Jul 2025 13:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753881643; cv=none; b=mOYjLOtSO6yQ0if1TlrTKHWPT3EvBEBwl923u3m40C1Avcm92wHB92h7J+j1qQlrWdVoHY7brdJTRsMqBb/Vv84YlSvLgOMYmrQ/zaEmaWZxQzOF3KRdHtYLC1IX9fTAeO597BEf3U7moFlpidKBNVowEcMVBKmxHi6rQGWaG0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753881643; c=relaxed/simple;
	bh=fkKm7APfsMSQiT77hCcKhZPKA8BOP+Knyo6wH1vqqko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pLcQXi1lx/+LX6Jjg7F7HgX3PWIBtac+vevRky1ZP25Z3dQNrmIOTCXoRTrx7xu37b6NCHccsS/TSrPC0pzNYaElNOOQ4Lchh7+i8GK4B6QdpM/iRQ7Nh8w317DElLvMuYsWjPA+o6trAoA7vl7p3a5YUZrItSrLrguvHZCnA80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.213.139])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1dc0b97fb;
	Wed, 30 Jul 2025 21:20:29 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: w@1wt.eu
Cc: alchark@gmail.com,
	amadeus@jmu.edu.cn,
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
Date: Wed, 30 Jul 2025 21:20:26 +0800
Message-Id: <20250730132026.214754-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250730071145.GA26734@1wt.eu>
References: <20250730071145.GA26734@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a985b7dd39f03a2kunm09ab435824e847
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDQktMVh9IHk9CHxlITEsZTlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKSFVKSEJZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE5VSktLVU
	pCS0tZBg++

Hi,

> My point is that if you disable cpufreq, the CPU is running at 1.2V, which
> is even higher. I don't know why it's running at this voltage, maybe as
> the result of initializing some regulators, but that's what we're getting.
> So the question about safety of running between 1.13-1.15 resolves to
> "it's at least safer than running without cpufreq" in the current state.
>
> And as I mentioned it's clearly linux and not u-boot that is setting 1.2V,
> because under u-boot and during kernel selection and image loading, my
> board is at 0.95V. It's only once the kernel starts to boot that it bumps
> to 1.2V.

If opp-table is not configured, kernel will initialize the pwm-regulator
to maximum microvolts. This can be solved by configuring the pwm-regulator
in U-Boot (waiting for U-Boot to synchronize the DT of kernel 6.16):

```
&vdd_arm {
	regulator-init-microvolt = <953000>;
};

&vdd_logic {
	regulator-init-microvolt = <900000>;
};
```

Thanks,
Chukun

--
2.25.1



