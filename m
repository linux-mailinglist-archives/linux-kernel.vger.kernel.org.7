Return-Path: <linux-kernel+bounces-855280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D07A8BE0BA6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 22:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C0B024F6489
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AB43254A0;
	Wed, 15 Oct 2025 20:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="WoL4bVeZ"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE8D2D061B
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 20:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760561979; cv=none; b=uyXt3rxAIKbn8tknoOFa05u083YtJ7li6PioM6ObOwGaSCmUkbEzGXmvahW5xw9Bb0Z5ztkj1juX8CQf58z8wgtaw614ZrU1KeYVCOKUtGL5qCnE1SSUz+/DTcLfN7yV4GgqMfIt2CO5Ll0opw9EPA5TQHAEuP1UG/X3U6bOAp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760561979; c=relaxed/simple;
	bh=jnz1pve43wNu1d5A6zNO1YPOXzcgscIb+158hVsiE14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E7aaKnrHBi8240x7wAskI4fcFopTy1nTvZ/56MUOfph2JAeS0HkX0BzT0ULgI8bxTpwczp4Rr0uU2lJ4IDBCV/koIXua0+8Ph9gcBZbdSo+HY98KFX+rILn4P73FLLeIioWxmn2MjwGpW/DQ87jEbiXJh4/PSgtS1hy3mNdFLHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=WoL4bVeZ; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=LiajE/tdE3SWzf
	4kPctkcPc5diJca5eDM5dP0lETOqo=; b=WoL4bVeZbkQkQniWToLcI9/sItj0AV
	kse6JVVXq7T3ZhEhWg9Eq0FDB+ax1k4rkzc9e2eHNGYtGZL1oAufsUpeRmXmlSco
	B+MbPIHYeuy1tpVj8wh/NwnIaGreHzmDwRqlQGdp+Ib0j97Fe5PZB/m/iAQWd7Au
	ZnNHQH+/K6ces/RvgnyH4ZAw9N9+3HYw5YIF8aJTtdM5XZLzgaZaEZkqOjFpy7l2
	CI26q1ayOYxMfzgN8KeTG3c5UsmOTkgnjHJtRwVH+nWim44STw4hx15bRvtGMUB5
	+574gVOte//sls+ucxBUXQqiVlRkd5NKS2p10ebn6ertpUJ5sy7o+bjA==
Received: (qmail 3544936 invoked from network); 15 Oct 2025 22:59:32 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 15 Oct 2025 22:59:32 +0200
X-UD-Smtp-Session: l3s3148p1@xBz4xjhBYLMujnsG
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-kernel@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v2 0/2] reset: handle RESET_GPIO better to provide the fallback
Date: Wed, 15 Oct 2025 22:59:20 +0200
Message-ID: <20251015205919.12678-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the discussion[1] (Thanks, Philipp!), here is the updated series.
Details are in the commit messages. Please let me know what you think.

[1] https://lore.kernel.org/r/20251015112921.19535-2-wsa+renesas@sang-engineering.com

Wolfram Sang (2):
  reset: always bail out on missing RESET_GPIO driver
  reset: always include RESET_GPIO driver if possible

 drivers/reset/Kconfig | 1 +
 drivers/reset/core.c  | 8 +++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.47.2


