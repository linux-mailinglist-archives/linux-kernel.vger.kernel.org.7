Return-Path: <linux-kernel+bounces-794274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B37E5B3DF5E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 431BF4E2007
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4F02AE72;
	Mon,  1 Sep 2025 10:00:46 +0000 (UTC)
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3283330DD30;
	Mon,  1 Sep 2025 10:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756720846; cv=none; b=bvIkkZYEoQ/3d2dyvO0oaSOBJwFnw1RQQwYKaSMUN1Csztb4H1wGwpdNcBD5AV0si86/L3N8a/b6wIlO8FFhYltl+2a1wlejB8UJjSNtu2FmXM/JLnuB3PHbE4k9z6lDHbEpmSAmAHEAOmEX0jHZFZmt0vJwyiVInXAauZdoiIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756720846; c=relaxed/simple;
	bh=jQoTwEojnP3KZFgtdwm7mSq+SdaGDk8SV0VOm2zB5qY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WOSfitpSqdda8BDJfm4An1uE12csZfPvQKUFVxZV1Qalovc0juFEPjziJV4a2mOWQew2znq9Q+VSrEhqmOYzwSso19A05CTi/DQu/g6qUtGtwnW74iUTIVG7TmmjGD7cDDM+keX0vYsJAt4m9CRutobrOyXNbk/xilJiOx+1hf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.212.9])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2148c25a6;
	Mon, 1 Sep 2025 18:00:33 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Chukun Pan <amadeus@jmu.edu.cn>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v3 0/3] arm64: dts: rockchip: Update Radxa E52C support
Date: Mon,  1 Sep 2025 18:00:24 +0800
Message-Id: <20250901100027.164594-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9904b8a29403a2kunmfa64e577374697
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCQk4dVhpMQhhMGEgeSBhOS1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKSVVCWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09LVUpLS1VLWQ
	Y+

Changed from v3:
  Add vcc_3v3_pmu label to vcc_3v3_s3

Changed from v2:
  Remove merged patches
  Remove VCC_3V3_PMU for Radxa E52C (new)
  Update pinctrl names for Radxa E52C (new)
  Update commit message for disabling display subsystem

Chukun Pan (3):
  arm64: dts: rockchip: disable display subsystem for Radxa E52C
  arm64: dts: rockchip: remove vcc_3v3_pmu regulator for Radxa E52C
  arm64: dts: rockchip: update pinctrl names for Radxa E52C

 .../boot/dts/rockchip/rk3582-radxa-e52c.dts   | 30 ++++++++-----------
 1 file changed, 12 insertions(+), 18 deletions(-)

-- 
2.25.1


