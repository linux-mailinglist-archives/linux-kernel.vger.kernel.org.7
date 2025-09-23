Return-Path: <linux-kernel+bounces-828462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A802B94A80
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B89D19022F6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 07:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6CE31578B;
	Tue, 23 Sep 2025 07:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLahSg2u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957C4314B7A;
	Tue, 23 Sep 2025 07:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758610811; cv=none; b=kiLDQXwuD+ZK07A7wvmQtGe+6IDfk6Py+xnqAIzcsbuOLx0PWvVWN6vqSLkeuJyiZzuiBAjO+BGHm0nAclbi4jiF0XLr4f76XeSfAl8jD80SadiQfG/nf/vBLJUNzZfYL1/xTxkaBRIazulXTRt105dx2uyynnqnCXOxhFLgocY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758610811; c=relaxed/simple;
	bh=5sfUrtoOZp4BjKuJF6RyWHTN4aQhqobLwkByaxTv0as=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O69KRplhBCPQVMBb7fOz85tJEQV3w2IBMkdNfbakPIZ6FwLKsHv74dlet0xgKTgr8EkR/01gvlCMANu9AGsw9LfygU5VuwnpyMSeGChP7i2jQedpvpaogw7Sn/itIT5myes2fCUO5TUAFKqASsezKQ6su0vGOyeikNaRmp8x+Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLahSg2u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D0BC116B1;
	Tue, 23 Sep 2025 07:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758610811;
	bh=5sfUrtoOZp4BjKuJF6RyWHTN4aQhqobLwkByaxTv0as=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fLahSg2u2GoJZ5uWvLQAu63JCu8ZGFoaGK6/Y9Lx+lB/xqbOnmDkRR05AF3Bv9yql
	 VZ7svWWF8py5JVBJFLg0+8ip0jZiRVqiQ9knHFc70Z+qJnJsUAL4YwG0M+pgQSGtvX
	 6PlE9nHFd4iCOMcp+lnONvrQBrez+3tcYTEVwrBZtzbkGsPZBMUnpa9Rdiqrqmgl5N
	 3jZEjXbui+ks2H5VGuuApGnfT1h8htq0GKCYZ4pv8GB3Yh9r2ljlaoKwVp6MtJ+MD8
	 nGZDZUFzUzoNuRKgCOr6mjmIyVhL9HTfeZm8NDLoLWqSuYS1zJEh74OOnI5OhsTWfT
	 9pnTMjqre2fqA==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 23 Sep 2025 15:58:41 +0900
Subject: [PATCH v4 16/20] can: netlink: add can_bitrate_const_fill_info()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-canxl-netlink-prep-v4-16-e720d28f66fe@kernel.org>
References: <20250923-canxl-netlink-prep-v4-0-e720d28f66fe@kernel.org>
In-Reply-To: <20250923-canxl-netlink-prep-v4-0-e720d28f66fe@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>, 
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>, 
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2111; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=5sfUrtoOZp4BjKuJF6RyWHTN4aQhqobLwkByaxTv0as=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBmXXIPX35tcG3//qb90D5uL7LzenhkiFed7v8nP7ajan
 aF4bIl8RykLgxgXg6yYIsuyck5uhY5C77BDfy1h5rAygQxh4OIUgIk4cDH8LzMOKQ5arRE9573f
 nShGP/PZVy/5HlfX/sbHO2P7V8eG74wMS+Iikjxup2Vc4v1698DnvDv/XgZfOsFQM+3Z+6+nRNd
 WswEA
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

Add can_bitrate_const_fill_info() to factorise the logic when filling
the bitrate constant information for Classical CAN and CAN FD. This
function will be reused later on for CAN XL.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 drivers/net/can/dev/netlink.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index fa922a61f75afd18c587f144b6bb2a17be7f26da..9794f283ed588e37fbc9a189cb54c6965960d436 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -576,6 +576,15 @@ static int can_bittiming_const_fill_info(struct sk_buff *skb,
 			sizeof(*bittiming_const), bittiming_const);
 }
 
+static int can_bitrate_const_fill_info(struct sk_buff *skb,
+				       int ifla_can_bitrate_const,
+				       const u32 *bitrate_const, unsigned int cnt)
+{
+	return bitrate_const &&
+		nla_put(skb, ifla_can_bitrate_const,
+			sizeof(*bitrate_const) * cnt, bitrate_const);
+}
+
 static int can_tdc_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
 	struct nlattr *nest;
@@ -686,17 +695,13 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 		      priv->termination_const_cnt,
 		      priv->termination_const))) ||
 
-	    (priv->bitrate_const &&
-	     nla_put(skb, IFLA_CAN_BITRATE_CONST,
-		     sizeof(*priv->bitrate_const) *
-		     priv->bitrate_const_cnt,
-		     priv->bitrate_const)) ||
+	    can_bitrate_const_fill_info(skb, IFLA_CAN_BITRATE_CONST,
+					priv->bitrate_const,
+					priv->bitrate_const_cnt) ||
 
-	    (priv->fd.data_bitrate_const &&
-	     nla_put(skb, IFLA_CAN_DATA_BITRATE_CONST,
-		     sizeof(*priv->fd.data_bitrate_const) *
-		     priv->fd.data_bitrate_const_cnt,
-		     priv->fd.data_bitrate_const)) ||
+	    can_bitrate_const_fill_info(skb, IFLA_CAN_DATA_BITRATE_CONST,
+					priv->fd.data_bitrate_const,
+					priv->fd.data_bitrate_const_cnt) ||
 
 	    (nla_put(skb, IFLA_CAN_BITRATE_MAX,
 		     sizeof(priv->bitrate_max),

-- 
2.49.1


