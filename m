Return-Path: <linux-kernel+bounces-814073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03479B54EF5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B353C7C6B00
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8E230DEDE;
	Fri, 12 Sep 2025 13:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oR2c6JfI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF6A2DC793
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757682737; cv=none; b=EuQ4gc/3CSQhhWz7OdC5CIcGv+x16Bf+VUYMD13uow8OZmW6DhVma3db131mw8F4yyXqLMsdHPMEnS5J6QB2mgmCT6nRhzAnu+1MKtqteH/lEA/E32kU/FFmG4Mri6IThvd8dPX4GkNctVPlPRnIfqhnCKNJqXeIZv3Cr0lhJMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757682737; c=relaxed/simple;
	bh=14JPV4hhNh9z23akKKme8qub7sXLyZ77nvFihK4p7y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e85mhDDJr7Aj9aaekyv/GyhUDXeaYVtXXYKD6s1+JIWhG4q+mOs7mVXX6LGlBLYQXTWBwGAUOq3pvbpf4FaB7gEoiaWJSo6L3P/Q+Nu9H3GbmVrNJVDk/jI3NoFDHpAPBDYyq2o2iK3LZPhpzVQcSvfnh3Qx8IHZ9QqF0EG0ghk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oR2c6JfI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1764DC4CEF7;
	Fri, 12 Sep 2025 13:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757682737;
	bh=14JPV4hhNh9z23akKKme8qub7sXLyZ77nvFihK4p7y0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oR2c6JfI65vg07R5bUd1SrFz7Od4x1z2EIjiGwZ05KDfuvXExZShHqwtUrIO7aJtE
	 52Euw4A5o9P04T5JkTC525UEIk+LBBJU4NMJ+cbNZmhz3ThaV7qWXCcyr4U0F7kmg1
	 rE+SyhvTD58+xtkpcnFEVJxa9amQAPrga+gpppyiVE7kg20Lju6DFTxSP3avfy4Ye1
	 cqKMzGMkBl+2Bu8fVx0skjwhrbcDV7JM+wmBQ4YcasgOY6magBNyUS9WpnqaneTXHx
	 L/k5s5NVpsRiTw6BLqRj2W9hdLR+KJG9Q2da7mHwXuZB+DOPswsIBKL+FohBkyhq17
	 XzcBe/ZdKV1ZA==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Qiang Liu <liuqiang@kylinos.cn>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 2/3] slimbus: messaging: Remove redundant code
Date: Fri, 12 Sep 2025 14:12:01 +0100
Message-ID: <20250912131202.303026-3-srini@kernel.org>
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

From: Qiang Liu <liuqiang@kylinos.cn>

Assigning txn->comp to itself has no effect.

Signed-off-by: Qiang Liu <liuqiang@kylinos.cn>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
---
 drivers/slimbus/messaging.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
index 6f01d944f9c6..27ca16f00e77 100644
--- a/drivers/slimbus/messaging.c
+++ b/drivers/slimbus/messaging.c
@@ -143,8 +143,6 @@ int slim_do_transfer(struct slim_controller *ctrl, struct slim_msg_txn *txn)
 
 		if (!txn->msg->comp)
 			txn->comp = &done;
-		else
-			txn->comp = txn->comp;
 	}
 
 	ret = ctrl->xfer_msg(ctrl, txn);
-- 
2.50.0


