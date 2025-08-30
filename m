Return-Path: <linux-kernel+bounces-792958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 867D8B3CAED
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 14:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0144E582CF3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 12:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434E827E045;
	Sat, 30 Aug 2025 12:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="glPsh/ES"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF44EEA6;
	Sat, 30 Aug 2025 12:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756558696; cv=none; b=p2hGwbczJsmYOe9OuMAiE/GYTgzwEg/F9alrR/tc+tlUuoOsGNQceSY7Udh/W61meKZwaWoXZzOAaP8K3Qex4DbPYEljVMg61PfTffp5ZAVrLveI8AQOH5Eq+DSbTYsDw1UEM5ecCqD8w+lCWRkjJYgk6YMp3QUxvTWQyA2658Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756558696; c=relaxed/simple;
	bh=Fqpa5AA8y/domu+LUCsZRMXnjqF+oJU9R3fonkhLLOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EBXSgeT4GlUL0TgYavsdtQ+ff6BURuJkUr6wQ6qCuc8qU37ebHuGfai5eMwyinpTBpTgR9TKgxQMasGgJhAF/n0311il/W7/ZY9AjyT+sjPLxQVAwMo6/XbO7s1tvoHTdfXOXf6rlx0wmh351wNBVJM6FkK8KNmxEDGs1mqm90M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=glPsh/ES; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=aW9LGu3CF6euzt6Lnsx4iO3RXC2O1JmxKXtfo6HvoHI=; b=glPsh/ESSL0d1WedMKArvTtqr3
	lVffULGdmcdtItMdkPqP+e8PbMBO+iOK0XqbpV9dX5C87mk2t2lBVBqjhFzbnwmOGe9woHkw7nCaJ
	To98WPlaggdLtb0/W3TPX2692siEo0vmEEOLn29x/2e5tQmlK+m/xZ2BdhJNA9sSf0Yno817wZwcM
	d1TCv0pJIEcEWpColyQQdiXNxDkA9iIOvhCCsQuB2XYU4/bQ2YudiANj2yCVqJ1tYjXE/m5S6pfAn
	6KQOttA/WSwDr2p6QD1/ZlyA55in3CKZhBmwpECjt1FUWIWI230Dp7Z7CNuLIbUhnuFRhmJvDPQJG
	0jo97lLg==;
Received: from [77.241.232.9] (helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1usL9f-0007bC-Vf; Sat, 30 Aug 2025 14:58:04 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Heiko Stuebner <heiko@sntech.de>
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] dt-bindings: soc: rockchip: add missing clock reference for rk3576-dcphy syscon
Date: Sat, 30 Aug 2025 14:57:56 +0200
Message-ID: <175655867261.3578496.11838740893720919956.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250828131107.3531769-1-heiko@sntech.de>
References: <20250828131107.3531769-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 28 Aug 2025 15:11:07 +0200, Heiko Stuebner wrote:
> The rk3576 mipi dcphy syscon controls a clock, so needs to allow the
> clock property. Add the missing entry in the list for it.
> 
> 

Applied, thanks!

[1/1] dt-bindings: soc: rockchip: add missing clock reference for rk3576-dcphy syscon
      commit: 941b9a558f34c8cab0a28f3387d5f4063a0ef5f2

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

