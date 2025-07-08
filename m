Return-Path: <linux-kernel+bounces-721470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BEFAFC99F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFC7D5643A5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 11:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA412D97B8;
	Tue,  8 Jul 2025 11:31:20 +0000 (UTC)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DB021D587;
	Tue,  8 Jul 2025 11:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751974280; cv=none; b=jialoz0DJvM+PtWOZ9xs6fuwpwxAalpUlYz8sDZhkBQ+DUuIPX7IIbpY+JrbNej00wZoxJIgwj1SXxn4UY9jq9SUHaHgT2US1voPFo+5d+q2vKcAWBlWELvFOwTaXPsYjtMNjTes5SVuALGsZKkpaoFk6kQPsyLhKLSBtZooMig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751974280; c=relaxed/simple;
	bh=k4qaNKCYx5GSxH/3gvN7kn3pe4FFdl04qyrc9sOYmrE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=H35J7+aRKReLUGhxQwZuaYv78Cp2npu7MBVLqILWyF8Skb5fxUlMAP+gRKs5heiqEviznO5HQ26k11HHy/mGyg3sOC6qcg0OgnhzSXsK7qbLSzYLQ0zOYlPVneGWudLkvtADn937CBgvWr7w28PzTTPypygk9g68njom0i7MQAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com; spf=pass smtp.mailfrom=foursemi.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foursemi.com
X-QQ-mid: esmtpgz15t1751974218tfc59f54c
X-QQ-Originating-IP: oQ5w8Pj/k7PGhxfLB9nh4Yt/Gr2W9dZu8UC2CKjH6Es=
Received: from localhost.localdomain ( [113.89.234.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 08 Jul 2025 19:30:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1388642757589725141
EX-QQ-RecipientCnt: 14
From: Nick Li <nick.li@foursemi.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	nick.li@foursemi.com
Cc: xiaoming.yang@foursemi.com,
	danyang.zheng@foursemi.com,
	like.xy@foxmail.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] dt-bindings: vendor-prefixes: Add Shanghai FourSemi Semiconductor Co.,Ltd
Date: Tue,  8 Jul 2025 19:28:58 +0800
Message-Id: <20250708112901.25228-2-nick.li@foursemi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250708112901.25228-1-nick.li@foursemi.com>
References: <20250703035639.7252-1-nick.li@foursemi.com>
 <20250708112901.25228-1-nick.li@foursemi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:foursemi.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MbY7GcL85SkKqpxBdXLqNRk0bBULSTbv3177mykWFsmTjQfdXCMM8yML
	j+XuDogEzFZ4ZtjVu2Ju96WvpIx/j2qsTUpOS+sT0uk+kdf/lLHR3kZCLToLyjOO44TBlBe
	R29q+vfMolnc7/B1/GcM8H6FBORzaUtO8GqCtljrwf4uCqNLARJkfCBlLkiWhg5cqB/midz
	XVq9GZLXCfkkewUVmK8QXtnMRZQnfdmxsowTz/Q/HQGX6zMZXTBg/Q/loC1XQgf0t6tWoeO
	+hMVr91pffE4N2nsWHhcegpbzmszTSqm9SIFaC17kzy13/zLUQD4QSXgYC+cIGI96cIe1Wu
	yg+ikoKQsnyYVU2IdM4isE6iP3LjezxDrhdtj3x+ysiB4lXLPzMm4hoA4t5j+wemhzHmjo8
	GiG5QvhrrIs6f2BShU9wHnFrEz2B6STME0v0vjpABxUXDc/gMkWzIcGzsA+0ka/Qvy/usAB
	84y17t0Ved7Cf4ozEFj78uqFd+RYG0b73AmvNop00TqXC6QC5tlqPDA58gQi41E/Gn6oD8L
	IGY0VP7deHC0BM9xLPb6PqCItok6lWxnccr4Z8VJ2NJkHIVrFG4lm16yDfGLpdp5s51JAWX
	vQdGpOJx4/JWs9gGusBOSdeAG0BbWqtVu8wQ2TZ+/Ek59gxzuoO7FdBDr8CzsxPmSaJ0lQW
	4cU3sjPPDuP9wlmOqnRPN3vz7DEkni+lpD7MkRWq9xJBidtXFEKiYNPVSjqlwCxSZZKrl6o
	fJkgjtsGcb8nbzDe2BTShOtqZR5MD9sCQ4CpeW61Pr7iZEFZfAawUwvatjyx70stK8v+ZVw
	7Khe0RseoEgPTsP+43SSbLO/Dj1jDkUAv+ovDGMk2JCB/yPTFSdySBtKmTmGOdTqPzFle1d
	utx6CNeA97rFTovJHDWQh1mFg1z1VKNe3HSf3Q3NPLC9mSdeFFuA1+zGjeEE1Fknz6YHJ0v
	pWHMhJQfuAcWhL4qF2n2WP3vmZQj9PnKQOMkkAmqYTNcaZ+t87SUuSMbUdC/BgVcjfHHdKs
	xFc1yeEYxrPVvGg+LypzAx8ZpO7v5eEeMf7NEWV3IYbj/TxoDfJ79Wyq70LNm2a/wXgJdsm
	4rq1feb66lb
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add vendor prefix for Shanghai FourSemi Semiconductor Co.,Ltd
Link: https://en.foursemi.com/

Signed-off-by: Nick Li <nick.li@foursemi.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 5d2a7a8d3..e42d54313 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -543,6 +543,8 @@ patternProperties:
     description: FocalTech Systems Co.,Ltd
   "^forlinx,.*":
     description: Baoding Forlinx Embedded Technology Co., Ltd.
+  "^foursemi,.*":
+    description: Shanghai FourSemi Semiconductor Co.,Ltd.
   "^freebox,.*":
     description: Freebox SAS
   "^freecom,.*":
-- 
2.17.1



