Return-Path: <linux-kernel+bounces-742610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DFCB0F441
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78276AA0B40
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6482E7BC5;
	Wed, 23 Jul 2025 13:40:39 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59AF8F58;
	Wed, 23 Jul 2025 13:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753278038; cv=none; b=Q9f7o+1nEHKTjAOFqZc0nYJkXOITxiDM+RR51N39VYAgE3gK3vgzxCOizvcgoBo1uPDScUQuQYHI+vxk66NX3G6ITE0+vWcWHaZCvZJpHLJCUo1/rM73VV9zPItxzYC4snJgcVjY86KNCI66dGYllfRxQCASPtgfgdFu2EObc6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753278038; c=relaxed/simple;
	bh=HNggllkUrnhj86EnsA0uyQ9qxt6zMSkV0XvPDFphXh4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=urRQCUbiU2m5KLa5p1qIjdArteDwzwOyNxkAP4ZRyJHH6TqXiFwRFPguwD6aERrFsTLIfB5IN+2dwTOdVh3LAhYd4oElPJrly+NUBf8ERWTuYjxdskB5DeMfA3IUYbn7055BV7VmrMrgxdz1XKkZyzVhM1yJfL8abSIZQ/mkzVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.214.181])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1d028433b;
	Wed, 23 Jul 2025 21:40:24 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: knaerzche@gmail.com
Cc: amadeus@jmu.edu.cn,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	jonas@kwiboo.se,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	ziyao@disroot.org
Subject: Re: [PATCH v3 0/6] arm64: dts: rockchip: Add ROCK 2A/2F, Sige1 and NanoPi Zero2
Date: Wed, 23 Jul 2025 21:40:19 +0800
Message-Id: <20250723134019.1076352-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <6d93c92d-2bba-4247-960d-5f2e5e12b594@gmail.com>
References: <6d93c92d-2bba-4247-960d-5f2e5e12b594@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDHR8eVh8dGh9DGUxITkwdHVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKT1VKQ0pZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0tVSktLVU
	tZBg++
X-HM-Tid: 0a9837838c6c03a2kunm45ceffd2fb6d7
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NhA6ATo4OTEdSTIsTCwhCw8Z
	KBQaFDRVSlVKTE5ISUxDS0lOTEhCVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	QlVKSUlVSUpPVUpDSllXWQgBWUFKTEJMNwY+

Hi,

> Nope.
>
> Are you really questioning my picture? Ridiculous ... see [0]

No, I mean some boards of this model have SoC silkscreen RK3528 and
others have RK3528A. The same is true for another Hinlink H28K SBC.

> I'm sort of impressed on with which conviction you continue to claim
> plain wrong things: [1], [2], [3].

If you spend a few minutes running mainline u-boot or BSP kernel
on your RK3528 board before blaming me:

BL31:
INFO:    rk_otp_init finish!
INFO:    RK3528 SoC (0x101)

mainline u-boot:
------
U-Boot 2025.07-...

Model: Generic RK3528
SoC:   RK3528A
------

BSP kernel:
[    0.768514] rockchip-cpuinfo cpuinfo: SoC            : 35281000
[    0.768990] rockchip-cpuinfo cpuinfo: Serial         : ...

> I'm fine if upstream decides not to care. But it is and remains wrong
> to claim that the other version does not exist

Unless Rockchip says they fused the wrong OTP during production.
Regardless of the SoC silkscreen, the chip type on OTP is the same,
so how does Rockchip distinguish these chips?

--
2.25.1



