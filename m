Return-Path: <linux-kernel+bounces-814074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CFDB54EF8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D8A74E2617
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C1130E84F;
	Fri, 12 Sep 2025 13:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hL/U8Gyh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACE630C602
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757682739; cv=none; b=RSzwAjWwWLpS3qLb6IPmpM0IavdgPMl8lZql+WC2iGR+zPooSuf91VDXB92bEMDokv1WykG4RI3LloRtpRWyNRtz1FHnj2c/VIIJjbTa9mNZOlB9NvXRQp4ugZVxxBVKFwEc/1SMTyJn8jYTwjIrIuBu1gM1APHzoackdXLiWFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757682739; c=relaxed/simple;
	bh=eeGP7giPWwNTuQgF22xTWAU5lcLNEJMEWbFT+tgMV2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i2L7UeHwd4mtoyJGlzM3Ag6BZBIj4CN3mwKcLKHzBVegHEk9OkdItZzblSfoxpqSsyHCONqBkdOjrwFLFPimQG/ezQW3GGXIq9xFTt9dHIjrjJb0QinCSBveJ8BnVnvR9dlahO9FKn0BzezOQGrJFFtqFnxgYUAf2UnU/9VSmC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hL/U8Gyh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6300DC4CEF9;
	Fri, 12 Sep 2025 13:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757682738;
	bh=eeGP7giPWwNTuQgF22xTWAU5lcLNEJMEWbFT+tgMV2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hL/U8Gyhx8jz4/KY/uwSLeabreYkQ0yDBlvVOQGPKJ82qC6cE0XEjTga1ruWYuQOi
	 mOxq0mD/PWvSJTVCf8ca8/qBd42dfLt75VNICB296v3SjyRFOOBz4g2S0yLWT2hlO/
	 t3GKe70ldxozagGO6C22fV+cYQXyaqt4i8TpZl6vmNljmS/MM7KbwoDQOGKsDn1t6K
	 2ATQnC1dG62Hw9v7wA2UrScf2oyYTh1buGUqzJCC9ccDvpd1GsUeYUJ2chg24GiFFp
	 EMnZguLBQvQ42YH/25Dux/q/+6g3SgXZSwZPebd6GPDSLTnmEXxOKha2AtqfFpqRW5
	 KSazpqVxlcL5A==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 3/3] slimbus: messaging: fix "transfered"->"transferred"
Date: Fri, 12 Sep 2025 14:12:02 +0100
Message-ID: <20250912131202.303026-4-srini@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250912131202.303026-1-srini@kernel.org>
References: <20250912131202.303026-1-srini@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xichao Zhao <zhao.xichao@vivo.com>

Trivial fix to spelling mistake in comment text.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
---
 drivers/slimbus/messaging.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
index 27ca16f00e77..e2dbe4a66b70 100644
--- a/drivers/slimbus/messaging.c
+++ b/drivers/slimbus/messaging.c
@@ -222,7 +222,7 @@ static u16 slim_slicesize(int code)
 /**
  * slim_xfer_msg() - Transfer a value info message on slim device
  *
- * @sbdev: slim device to which this msg has to be transfered
+ * @sbdev: slim device to which this msg has to be transferred
  * @msg: value info message pointer
  * @mc: message code of the message
  *
-- 
2.50.0


