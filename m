Return-Path: <linux-kernel+bounces-602433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A43D5A87AD0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 10:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB7EA3A6348
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 08:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6761A268C4C;
	Mon, 14 Apr 2025 08:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrxgoMrO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7D01B4234;
	Mon, 14 Apr 2025 08:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744620231; cv=none; b=HzmXwEHWU+7JVWV7GavJsKWFGdvRHz/WFVmk4jrpU4FzFlZsxrIHZa4XAya+Sy915jBOrka24RJAfe0oCKnNFBUZYx+Mr5HeLbqbkrWSWdoBxumwyb5OGrKQ8y/ynuLIjMcxoLITYzBaoyJPVVe0Cp6xVdwrcmrJmxOiMWV9uLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744620231; c=relaxed/simple;
	bh=kZGZJs9fshO2B9a734LtIaqW+UPcDJtnxkAeSsKZ3AI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Gzj01tp3m/un38tJNV97Iwz3lorGzMsjVJKupREBgxUQIka91tc7CgUApev9TBHDikIvTWHFPCXDMHfz/LQBsLkSOgFKZX7Xc5U7JGSYMl1XBr6Yc5wHt84QXBMmnq5wuPnRdXntVYYxD3lzIKs50fxgfSDkJDxjMB0tB5wSxJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrxgoMrO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A47BC4CEED;
	Mon, 14 Apr 2025 08:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744620231;
	bh=kZGZJs9fshO2B9a734LtIaqW+UPcDJtnxkAeSsKZ3AI=;
	h=From:To:Cc:Subject:Date:From;
	b=ZrxgoMrOHFmHp/hG9gB0087c21Z9w8TyDT407cj7nJ71j4EBewMJ0HovJIuWBuzBh
	 UhND+TXLi686SSD+3ZWK2xK/Zq1uB5ZBXWCcQUGfrFovJKRnKwCwohUb7M30HE2KXO
	 Y4GQCY+pr+luDJpPYvsmSxzwyeHYx+D0EMCmmr7zI/VyM51+Q/G5/UYECOtWacnB0l
	 6NPJy4fegEKqjaht8U6fH/AY6dl5kx8xCOn+zuumANA7SKGnDOixEf9SRsTHluT8Cm
	 lOHHXTP/Ev61IDVake4Vbhx/kaXbme9zz96KFXcKEo5QcDRZXY1JhxVwehAXxH3nua
	 f8LouMteO6g2A==
From: Michael Walle <mwalle@kernel.org>
To: Saravana Kannan <saravanak@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH net-next v2 0/2] net: ethernet: ti: am65-cpsw: Fix MAC address fetching
Date: Mon, 14 Apr 2025 10:43:34 +0200
Message-Id: <20250414084336.4017237-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MAC addresses can be fetched from a NVMEM device. of_get_mac_address()
will return EPROBE_DEFER if that device is not available yet. That
isn't handled correctly by the driver and it will always fall back
to either a random MAC address or it's own "fetch by fuse" method.

Also, if the ethernet (sub)node has a link to the nvmem device,
it will fail to create a device link as the fwnode parameter isn't
populated. That's fixed in the first patch.

Michael Walle (2):
  net: ethernet: ti: am65-cpsw: set fwnode for ports
  net: ethernet: ti: am65-cpsw: handle -EPROBE_DEFER

 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 26 +++++++++++++-----------
 1 file changed, 14 insertions(+), 12 deletions(-)

-- 
2.39.5


