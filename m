Return-Path: <linux-kernel+bounces-834228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 153C8BA43A4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC0EB1C0714D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E32201033;
	Fri, 26 Sep 2025 14:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0DzEk1y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880F814B953;
	Fri, 26 Sep 2025 14:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758897107; cv=none; b=OcYVrKaeZKTK0zKulSC27lj9FdZ9dTm209ze/R1UaK2HdYEhLqzJ+xv1YLbtiEIfmqW6pTIy+qq0aIOnxuvLTwCoAeiy8nmpY8vJXf5mtqWueFh+yaqV5tJa3TwqrDjgz0Lhc3DTnAmyuWoT0i8xnokDYLdrkUAyci6le4BYz1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758897107; c=relaxed/simple;
	bh=OnDdN5s5SMJAOdUjTlTdk8YSqexHLi2AY5mkc+V9J+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GypgzrPuPG2E/FTzQpMZDJYLJisWYX8adhaGFrsv47AXymWNo1q2ex6zI4h0q5uIOFxj9Er5TuK02vgyn+AFNjrRAjGdjtN6vcPrrgKWVwdbMO0BPp99RWBlSG9xGymLsdHFbAwXh1zdrN6LJ+9z/x4+gU1N4kSD/9UM66veGMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0DzEk1y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E0EC4CEF4;
	Fri, 26 Sep 2025 14:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758897107;
	bh=OnDdN5s5SMJAOdUjTlTdk8YSqexHLi2AY5mkc+V9J+g=;
	h=From:To:Cc:Subject:Date:From;
	b=Q0DzEk1y+aCWugKcowIs/VXzxgz1ao9F4vFW2HEEvuRHZGBtr6w5c2/p7XJ6JE6MQ
	 NF7KEmpVWjr79wR8ANvFru+TJ30c5DwJdnBdU1l6wPc+HoxEDVna7COsrwuaH/Zvp0
	 1yX/W/PacmB4ugm7y4IrVZa39m3qJggMjzqRMlSCnkv/C+yD/ugZIqX5aozPa2qt5k
	 djPK0jD10ahl5S7ld2RIAy+fsMHw0eqOLaCyMgRKi65Ye6nrTUQiP6oDRQQvWIwDBD
	 BJJUERdlKqHTXSyIUlWSvGBSHYalFwn0OoLVTw4lZbTlV31XBwf/XC90iMtLsyGTdY
	 X5+qi2HCo1uPg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v29U4-000000001g0-2lej;
	Fri, 26 Sep 2025 16:31:40 +0200
From: Johan Hovold <johan@kernel.org>
To: Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>
Cc: Neal Gompa <neal@gompa.dev>,
	asahi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/2] soc: apple: fix device leak on mbox lookup
Date: Fri, 26 Sep 2025 16:31:30 +0200
Message-ID: <20250926143132.6419-1-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes a device reference leak when looking up mboxes and
simplifies the sart lookup by dropping the corresponding reference
sooner.

Johan


Johan Hovold (2):
  soc: apple: mailbox: fix device leak on lookup
  soc: apple: sart: drop device reference after lookup

 drivers/soc/apple/mailbox.c | 15 +++++++++++----
 drivers/soc/apple/sart.c    | 13 ++-----------
 2 files changed, 13 insertions(+), 15 deletions(-)

-- 
2.49.1


