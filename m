Return-Path: <linux-kernel+bounces-771796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52822B28BA4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 10:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 113A1AC5F5A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 08:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3899C230BFD;
	Sat, 16 Aug 2025 08:00:49 +0000 (UTC)
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5011E0DFE;
	Sat, 16 Aug 2025 08:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755331248; cv=none; b=NPA/JUYCN29XF1s693/70Q5oFsZ9hzXtQsm1PHlN8PNCTSU6oCMQ6Fsk87lOuCbTDHL9JsH8/VCtZN++CS2S0beDTawTrvm4NSOEH8hMUyheqxVahv5jFPuaY7BVQQh3YGkRVSpUDVQmCKJfOc46DriLfj0+9YFzX1pNFQhFbkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755331248; c=relaxed/simple;
	bh=rDhXEhM6sO/wVkn3ko/kOWXUw+XTgXSS6AoFjXOUZTo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kL4gQ142YpiZPZdHHkyyvqEQUlJl99BUegK73SMloEcv4nC9MsytMPgRiqOXJyj7b38HCBocOMv/iydxEDz269NPlxUEyM6IYRecgip3mydCjwmhj5hmJgPYlA8nGtEFRht6y6WAfc7pNGpSdeWL4GdMenZfnFBeEOg1IjSzOxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.212.9])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1f93a30c3;
	Sat, 16 Aug 2025 16:00:38 +0800 (GMT+08:00)
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
Subject: [PATCH v2 0/3] arm64: dts: rockchip: update Radxa E52C support
Date: Sat, 16 Aug 2025 16:00:27 +0800
Message-Id: <20250816080030.183931-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a98b1e51b5303a2kunm56d2169525b6f6
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSkhCVklCHRofGEpITUMaGFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKSVVCWVdZFhoPEhUdFFlBWU9LSFVKS0hKTkxOVUpLS1VKQk
	tLWQY+

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


