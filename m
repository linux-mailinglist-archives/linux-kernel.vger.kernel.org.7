Return-Path: <linux-kernel+bounces-895950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E41C4F58A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E876534C4AE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A033A5E89;
	Tue, 11 Nov 2025 17:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rootcommit.com header.i=@rootcommit.com header.b="Ys+p6vvt"
Received: from poodle.tulip.relay.mailchannels.net (poodle.tulip.relay.mailchannels.net [23.83.218.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B143A1D15;
	Tue, 11 Nov 2025 17:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.249
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762883974; cv=pass; b=Lxv53RKTdGo7WBgrCgEtzFMthl2+f2Op2OvjicompmOxtBBXkIdtHiYd3ciuiuO6H4GECmoPaJmUoHwTH2MZYcgRtS7DKmUVRnZrDDspLebO1rD3M9u27IBrEDs3DggLidUYFqw09jxwbcJU1yUNzBJg45JgJhvbsMcwb8AZ97s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762883974; c=relaxed/simple;
	bh=yp4rFo1W4EAC9fTgAbvJ+nMmI2hbCFgIprALX6uhgUU=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:
	 Date; b=NgTnclVhqUzkxP7QPYYz4JJ1Mln3f3ocaZFr5I+7/pqZ1Jz4cFdxqKXDSiiCGXraLrHqb2NXrxRLa0+ZYaCeKlbiPs2pSehIiniH6NKyia0CkZ1cSD0anGGc0EU6YLHLAEQQDG/WVWEXjeqwPmS0U1iPkxNc8g8bmvFPDr/ZoRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rootcommit.com; spf=pass smtp.mailfrom=rootcommit.com; dkim=pass (2048-bit key) header.d=rootcommit.com header.i=@rootcommit.com header.b=Ys+p6vvt; arc=pass smtp.client-ip=23.83.218.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rootcommit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rootcommit.com
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 81CD47E18E9;
	Tue, 11 Nov 2025 17:20:26 +0000 (UTC)
Received: from fr-int-smtpout26.hostinger.io (100-124-9-98.trex-nlb.outbound.svc.cluster.local [100.124.9.98])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 4F03C7E1A7E;
	Tue, 11 Nov 2025 17:20:24 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1762881626; a=rsa-sha256;
	cv=none;
	b=VvTwKOUpRnJWgxs/U7fNXgU+EhqywGHzwF5L2ad1/FXS6ip8RkpPn2lJeuB78dhs3eMDId
	eltSOR+ZY8TE89kudLuKEgKmBCgqKEGbZ9oZGP0ZPTCU8JTZS2CqN9NB4/BjV/meU45+Nm
	OMCh6PKa6D06KwxSd6EYSMPNIdZDJkVWrntpCykPva2nEyZKnzsLmRY2t4Okbfq2saj4HE
	afmXePTiu8RLkazujXF/ocmD/KZ/2Q1Mfn/bXb/7+m9p+pKimR61zBYY0OxagVrz76sEjQ
	+AvfN1U/FGuhhNgP+gSKxXSKDfgDVY/5r/W2uB9sLLigkUDjrvKsphxyFRR0hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1762881626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=xEimgvO9FbydGKYDZAi+OA9bdxdc/t9KnNEuVRqer4Q=;
	b=bHtT05ZrEazOxh0b7s6novbb9FPtrrcNDZWP1lIvBlViKiuZDTs3K1uBon2LPuTHVnQ4pq
	q+1+YHyKt3I0HF/N0EggSdEq6SoCWGF2jkMHyvHIlrYJ/QhDHekSXZZId6kd1PbWlVi53Z
	duCcPB6eSWFgdHtAxoE/nPN31OTO3eJD8aiL3xU6w3EGUuR/sBX5XXHF22kZSg04E2dUas
	331ctt+mvAwuBtcvy1mD4RFVJIi1qaqZUEmxcmC1keGF21XdEYBG/gGAjWAgOqYzhaEDQ0
	fwKMlBlgYjB5SqK2gz4JAhkFGG+43WFmAkc/ETRQ36BcLndG5SagGeieiZElUw==
ARC-Authentication-Results: i=1;
	rspamd-768b565cdb-f69nt;
	auth=pass smtp.auth=hostingeremail
 smtp.mailfrom=michael.opdenacker@rootcommit.com
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MC-Relay: Neutral
X-MailChannels-SenderId:
 hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MailChannels-Auth-Id: hostingeremail
X-Towering-Shade: 5182774c58ba6c7a_1762881626347_4281697641
X-MC-Loop-Signature: 1762881626347:335366262
X-MC-Ingress-Time: 1762881626347
Received: from fr-int-smtpout26.hostinger.io (fr-int-smtpout26.hostinger.io
 [148.222.54.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.124.9.98 (trex/7.1.3);
	Tue, 11 Nov 2025 17:20:26 +0000
Received: from localhost.localdomain (unknown [IPv6:2001:861:4450:d360:c518:3c38:613e:ee54])
	(Authenticated sender: michael.opdenacker@rootcommit.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4d5YFf1BZlz1yRY;
	Tue, 11 Nov 2025 17:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rootcommit.com;
	s=hostingermail-a; t=1762881622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xEimgvO9FbydGKYDZAi+OA9bdxdc/t9KnNEuVRqer4Q=;
	b=Ys+p6vvtJdRhTJ0LHR7/bsmMe4zlofuZv7LIrFQV2HnPclLxl5UALRvA/9DNANgq9nbXt0
	A/6ywtZ5y8bYHbcmURnLIArEvJ4JqxEEa/6LkVycB/1ONETJsrQT4xa23N3vIpGyfTtFv9
	J45NDYbDitO0l5vv6F4S0L6OUd/pTP2CHPeGDL+t9zgwCHXFI3jsKnB7vSGNvcE++RULR+
	5lM+GgTxAW9UGkeap62ULV3ltG6Ijz6O6H+qa0EdCWSkGlh7u385432YdJF8RdeXMPwZR9
	Fi/nAfBYwMAlWHNuHyWe5l18jMkp1SvOy/rZDANhGxwriORQg9PdyixpQ2sc2A==
From: michael.opdenacker@rootcommit.com
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Michael Opdenacker <michael.opdenacker@rootcommit.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: arm: rockchip: Asus Tinkerboard 3 and 3S
Message-ID: <20251111172003.2324525-2-michael.opdenacker@rootcommit.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251111172003.2324525-1-michael.opdenacker@rootcommit.com>
References: <20251111172003.2324525-1-michael.opdenacker@rootcommit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Date: Tue, 11 Nov 2025 17:20:22 +0000 (UTC)
X-CM-Envelope: MS4xfME+LT8k9sz13NZY7Bg6fHQMkoZ8d6CueaNPZycRIzXB+DFOXJdDTtotaA8kDfh74NoOJFTDrCXUoZJOwAuqxHq8+v9qr6gPOhdtZWpe6lscL7mSQfCt YIw6cILIbeLmKT0iaVdFwsVvOzXyUBj3mASis1fIjV0jtIFhcZ3Es3XumT1rF1nnL6y7aYZCLG4MiXc+ABpMDH8A59sgQeDFkESGWNyBATfq5DarvPNLHiMl 74mRBxiDO5u5X7R9H7KCAVR1vGVW3rZroeRI6n0t9gRVjoJ+l+2Z7n0x5cxxMWjtHTL1l4HcI/p9UZ9hbZEpl/j/t0KOsz4hliwU1qaTUn4Y2+vMAmScCVne 3LLdZ5OJuJQjeEcpVPbqSgFIUkc+D5+BCSFu7fTVshWIj6ntpJNVlPsKgtK4eAl+236cVZP7D7NVvTXbl84XIQDTtfHweiqjjWpNeddh4Q5OFS1wa8f6fJox XtZBF+M3BYVKCwuZfa1JM9HH4LkEslKFNdB35vhu1wOivyR9yBqUGt3C97aggMftbiaIGbYMXN+rIW49ybhrfK29dnq129hhJGCRsHb2XfBNRE7qadQNxxuJ uzo=
X-CM-Analysis: v=2.4 cv=Lflu6Sfi c=1 sm=1 tr=0 ts=69137056 a=4Ac7OKPmaT9y8oRpUfBUJQ==:617 a=xqWC_Br6kY4A:10 a=-Yt9tNsTAAAA:8 a=d70CFdQeAAAA:8 a=k1XjlL_sdP34A_Td12AA:9 a=qPQde0g9OtMA:10 a=HTceBwxjnJgA:10 a=NcxpMcIZDGm-g932nG_k:22
X-AuthUser: michael.opdenacker@rootcommit.com

From: Michael Opdenacker <michael.opdenacker@rootcommit.com>

Document the compatible strings for Asus Tinkerboard 3 [1] and 3S [2],
which are SBCs based on the Rockchip 3566 SoC.

The "3S" version ("S" for "storage") just adds a 16 GB eMMC
and a "mask ROM" DIP switch to the "3" version.

Link: https://tinker-board.asus.com/series/tinker-board-3.html [1]
Link: https://tinker-board.asus.com/series/tinker-board-3s.html [2]
Signed-off-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 6aceaa8acbb2..451597a6cffb 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -86,6 +86,17 @@ properties:
           - const: asus,rk3288-tinker-s
           - const: rockchip,rk3288
 
+      - description: Asus Tinker board 3
+        items:
+          - const: asus,rk3566-tinker-3
+          - const: rockchip,rk3566
+
+      - description: Asus Tinker board 3S
+        items:
+          - const: asus,rk3566-tinker-3s
+          - const: asus,rk3566-tinker-3
+          - const: rockchip,rk3566
+
       - description: Beelink A1
         items:
           - const: azw,beelink-a1

