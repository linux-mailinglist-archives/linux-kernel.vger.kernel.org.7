Return-Path: <linux-kernel+bounces-728517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D49B02959
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 06:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22DE51BC82F3
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 04:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364B01F3BA2;
	Sat, 12 Jul 2025 04:05:43 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E441AB672;
	Sat, 12 Jul 2025 04:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752293142; cv=none; b=u+T3x8Bkt2dy6en/cJqRBdWuePThAjvgHmmTAHd8YZ5xFEesMDjV/U3u/NHe4w0BDBlFE75yY9Jule2+oDRxx5M+2B8fmwg/o1KOFKTJmwKehiAah8VuNC6xfma4T3Y8rV8VouTiykRz1zue17HnqTcbJBGkR4Ppt0v3l6L7qdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752293142; c=relaxed/simple;
	bh=CVKX3Mpp0w8zflaFt5fOYFiyIo4h8/FcQe9HvX+VfU8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MqDx/vWNTBiBpBgg5e/dEYPStlwx1A12qznxAOmwPQ28UVtqGIfqVHPJ7s0FUWdCBLdeSdTkU/19gqMQmMML13vtIHDieWw4N12oTU87QDIIgPk6/h9i88L8EmhJsQyjAoobHbz7HhPoXRO6bvEbvCflH+s+i4m4mOc5p2XA2N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.214.98])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1bc2c329a;
	Sat, 12 Jul 2025 12:00:26 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: jonas@kwiboo.se
Cc: amadeus@jmu.edu.cn,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	ziyao@disroot.org
Subject: Re: [PATCH v2 4/6] arm64: dts: rockchip: Add ArmSoM Sige1
Date: Sat, 12 Jul 2025 12:00:19 +0800
Message-Id: <20250712040019.165440-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <acbbf570-7a56-4d88-a631-32acd13d29c7@kwiboo.se>
References: <acbbf570-7a56-4d88-a631-32acd13d29c7@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZH0lCVk8aHRlMQh4fSk5NH1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKT1VCQ1lXWRYaDxIVHRRZQVlPS0hVSktJT09PS1VKS0tVS1
	kG
X-HM-Tid: 0a97fcca9bd403a2kunm68a720276516be
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mww6Sjo*UTE3DR1IHyMMTB4R
	DQ8KCTRVSlVKTE5JSUJJQ0lNQk5JVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	QlVKSUlVSUpPVUJDWVdZCAFZQUpNQ0w3Bg++

Hi,

> > Should this label be named as led-0/led-1?

> The nodes must include 'led' anywhere in their name according to schema:
>
> """
> patternProperties:
>   # The first form is preferred, but fall back to just 'led' anywhere in the
>   # node name to at least catch some child nodes.
>   "(^led-[0-9a-f]$|led)":
> """
>
> Using the color name similar to the the pin labels in schematics made
> most sense to me.
>
> Do you want me to change these to conform to the more restricted
> ^led-[0-9a-f]$ pattern?

This will be better.

> I only try to enable controllers for devices that are properly described,
> so I ignored the pwm-fan and its required pwm6 controller. Mostly
> because it make more sense to describe the fan once thermal support is
> completed, work [1] currently being blocked by a rk356x otp series [2]
> and that depends on a rk3576 thermal series [3].

Ok, I got it. Is usb2.0 also stuck?

Thanks,
Chukun

--
2.25.1


