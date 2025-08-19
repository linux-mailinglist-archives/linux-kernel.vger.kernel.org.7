Return-Path: <linux-kernel+bounces-776054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62663B2C7DF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7B6B725BDE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF8827F18F;
	Tue, 19 Aug 2025 15:00:58 +0000 (UTC)
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADA6279DAE;
	Tue, 19 Aug 2025 15:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755615658; cv=none; b=N1eywZj76mnSoRji8nzUkckYqd2jTudgSSQiu7ge5VMZUcDal4O3P6UdkxDLka+VjOe8M3ADSNTP0ZOF7OGggOsxiR/rOb/3o//E0kp0vR+1inGOo3ZI11BUJszoo/yQEs1FrZOuNu2TcLnk7pp9MU3ZFOs6kmhuCcOIuFxWJC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755615658; c=relaxed/simple;
	bh=0aUvSooSCQTWYsKXUSbOUSJKirbVP9KUqKjmxgbygxI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pjDVvlJeXrFPzWuZiCJz4CqPAfwwU4jyY0bZOfvkioSwTVxruBpHPDuHMhtVR2EJhSRhlZXN9YFMsQv0Dp8weGX443RlTiO53Omth2U4DHJSLkeYkTuQS0Fo1mTCaCgsnaTmD/jeRTE6oZIK+YaAGDPYF6dJpz2FRQLy/NGu/vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.213.154])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1fe57a9c0;
	Tue, 19 Aug 2025 23:00:50 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: naoki@radxa.com
Cc: amadeus@jmu.edu.cn,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 3/3] arm64: dts: rockchip: update pinctrl names for Radxa E52C
Date: Tue, 19 Aug 2025 23:00:38 +0800
Message-Id: <20250819150038.874297-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ABB74D9D1E3774F3+5a8c0d7d-fb7f-47c0-8308-e2b69f0628c1@radxa.com>
References: <ABB74D9D1E3774F3+5a8c0d7d-fb7f-47c0-8308-e2b69f0628c1@radxa.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a98c2d8e14303a2kunm2a21c9924065a4
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDTk5KVktPHUlPQkJLHkJNTlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKSFVKTk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE5VSktLVU
	pCS0tZBg++

Hi,

> "The name of a node should be somewhat generic".
>
>   https://github.com/devicetree-org/devicetree-specification/blob/v0.4/source/chapter2-devicetree-basics.rst?plain=1#L193

Usually we use the name on the schematic. For example, the patch for e24c:

https://lore.kernel.org/lkml/20250727144409.327740-4-jonas@kwiboo.se/

```
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpio0_a0_user>;
```

If this is incorrect, I will abandon the pinctrl changes for
the user key and power LED.

> > -		vcc_5v0_pwren_h: regulator-5v0-1 {
> > -		usb_otg_pwren_h: regulator-5v0-0 {

But I don't think the above is correct.

>   https://lore.kernel.org/all/20241216113052.15696-1-naoki@radxa.com/T/#u
>
> (I don't understand why this only applies to me...)

I don't know this. I thought the nodenames of pinctrl and regulator
were a bit weird, so I changed the pinctrl's.

Thanks,
Chukun

--
2.25.1



