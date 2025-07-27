Return-Path: <linux-kernel+bounces-746961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E5BB12D9E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 04:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33D61189E912
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 02:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388E317A306;
	Sun, 27 Jul 2025 02:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBg27zym"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C1F15E5C2
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 02:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753583516; cv=none; b=XNdAACGvDUdefOL5UnV1JD753Fb4WetiuVJoCDL/N8yU2Z42ME94maQgFu9jR/Gil09UQxtbNb4i6vGVZ7rwdFfV9HmjGTvQxKS1eywZKaIry/OQA0T0cWq+SQv6UBurhsUUPp/QzITS4DMFhfGrXDyDjEACZI2JMbpVjMnhgtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753583516; c=relaxed/simple;
	bh=nUATT1RQ2mXPzL28VdqxvX/LxGzD3VUNMX64BCSKnX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jBXdmw43c/BPUvhJTonRxh9cRjgVABLt3n9MhrRlkA2618Z/pi7/CT6u7VSVeeg3PgTuN9G8SqBrLDmzCb/OJxk3xKQnDZYFuTrxzl0DyZ5VQpYLptA3T/MSCER26ffrBJP5aR6XED1y0bdKaEdri5YBK15oNp3kfMdYuKB3LcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBg27zym; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b34a8f69862so2910992a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 19:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753583514; x=1754188314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=46Te9Euq/px4EVcaMH14cMQpZx16szBzITroK14Gdxo=;
        b=eBg27zym7f2SP+DCeDH8pgsmm4LBbkaLuTFbz73K7QYqDHk7n+FNsVCGQaN9aGy4/4
         hYFfsaRfrm4p0enBjjnrLj7UitPX/klhTdnRRn1srD2diyn658spQ2XVU7Z3RCYWjqdu
         pf7Bhbz2p2ie5icmVXxNrcTXzYO5fDDgcH2FfEVIiPbmlxNArVtfBrj3CjwjIVuOtvBz
         VA129y3iclHv3I3q2Ra/2thyl/1xp534mrIr/l7faoNgduv5ET08RZ5PHGCsOU6NDZgN
         j6lkK0lAomJu+f50fhwsQVjqgUfTVdwSZZ0iz+g2Wgk+WTpa9lY6tY5iJw8H0/RsmpPL
         bn7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753583514; x=1754188314;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=46Te9Euq/px4EVcaMH14cMQpZx16szBzITroK14Gdxo=;
        b=ciuP+sK6MiKxTCqpshztVrhzj2+b0m5Oz1ag2GRu9QgObv3wrSSuPQW3LbwcPiQ1M1
         sVSqdP86QCMJqqKSj5FiWrras1QNpjLaomUgPrsSzpycUzRKlxgHrYJh3t0eZQNNDe8S
         QKejZSolv/9ktWievy/GwW2T2bIZGpcDHc8CDJ5sEChL10oj84YLeeNaxH0blvmJv4Fg
         //Bl/EB6b6GMyrbvt+pFBVndEieFF6j15CShfMpdFbGKA2JzRvqOxYUohB2p1eE7Wbhv
         xilnXIgXGky9Kd9K6K8vm3U87f4ny3b5gYyyYPFBOOsQ1Vy7mrKmdbXoAaAxmqK3WHWb
         7OeA==
X-Gm-Message-State: AOJu0Yyet5c4B0uCjgPYpx3ArhMvEedoenGT4ZzQNOIud77ZGAUAx/hS
	11pjLxmFy8Ux1FVwLf+Lx5jx3Zyu7UzoJQTOp/vkj3JCntJ7f/8xCT6i4sDWHb5x
X-Gm-Gg: ASbGncvZ0EKCxmA+CzvgFtB7Ctppx47k+Qi4CU7AYhlN8WKqYyjEU6608b8IuXEfRI6
	l7nLRcGgovYwL/N4oBiC37pzzg87nWvmr/9VjYdSnBm57Gzqz8OdjkaLApYxSLs/KtGYnRu10gb
	M0eqvo4tg/in78SsKS+zS2SjznSpNhJ2KYuDkDulkIkm+o0oJLqSwo+bM5QZ8J6ScEvcz9EFVlA
	aeE8gWPSll0kvKM57xd4TnYOiZ8BHzHMNvh8qctqXkgRZPlUcmu94aT36iDwmYu63N/zc09TH2w
	+neJJQqxE6AtEgjesi3oPPUyREnW8WIRsSiApvFG8esUAi+axLvEDXidqJ+7hAFp2MqcV181mV8
	DOavtQUpUjSAHvFqmQJcZ7ptsSVN6PKe1B+wwOKTaGFaZCkr+079yMX+a
X-Google-Smtp-Source: AGHT+IGTTsGHnteSarpS73X/4TQB1R7YFVfr9nk14yGCUSVLYWbXLsL8K+oid8Ec5r8LJpAuT+Duug==
X-Received: by 2002:a17:902:dacd:b0:234:a734:4ab1 with SMTP id d9443c01a7336-23fb307cde0mr117132675ad.3.1753583514435;
        Sat, 26 Jul 2025 19:31:54 -0700 (PDT)
Received: from fedora (181-162-135-125.baf.movistar.cl. [181.162.135.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe329204sm25747115ad.53.2025.07.26.19.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 19:31:54 -0700 (PDT)
From: =?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Ignacio Pena <ignacio.pena87@gmail.com>
Subject: [PATCH] drivers/net/ethernet: Fix typo 'immedate' -> 'immediate'
Date: Sat, 26 Jul 2025 22:31:58 -0400
Message-ID: <20250727023158.82640-1-ignacio.pena87@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling mistake.

No functional change.

Signed-off-by: Ignacio Pena <ignacio.pena87@gmail.com>
---
 drivers/net/ethernet/mellanox/mlxsw/i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/i2c.c b/drivers/net/ethernet/mellanox/mlxsw/i2c.c
index f9f565c10..cc8743a28 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/i2c.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/i2c.c
@@ -671,7 +671,7 @@ static int mlxsw_i2c_probe(struct i2c_client *client)
 	 * For this purpose QUERY_FW is to be issued with opcode modifier equal
 	 * 0x01. For such command the output parameter is an immediate value.
 	 * Here QUERY_FW command is invoked for ASIC probing and for getting
-	 * local mailboxes addresses from immedate output parameters.
+	 * local mailboxes addresses from immediate output parameters.
 	 */
 
 	/* Prepare and write out Command Interface Register for transaction */
-- 
2.50.1


