Return-Path: <linux-kernel+bounces-887649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C965FC38CD1
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 03:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E25054EBD6B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 02:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC64226D14;
	Thu,  6 Nov 2025 02:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="B1kxuvoo"
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E588EDF6C;
	Thu,  6 Nov 2025 02:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762394878; cv=none; b=eQzEUSsglGgd2PapAFh59IN791vIdQ0KNoMwyKMnWFhDo/g8AJr4x5fQeHvj8tlsMg64dZ4izGgRXUY7PYvA7SKIsJEImIZOM82L4y0UW3kkxM8lv0SM+4jGQysKvQ5V534qkaSW3ptivyBBdRkJQTlk+fVthbpAcyIGJiAvr3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762394878; c=relaxed/simple;
	bh=q/O5jS5BqeQsuyDsuXUwZuvtJThb2oTdqTNPgEcLa6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=No+UfRs7a+gnipNw1jA6Lcg58mllfUgsmEpO6vz+HTsawVciKp1OdOQTxB0UnBCrQvcd4tfDIbvzfRP1uCoF28SbtODxYpRg2+g4xZkmkcrn0uwvlzP2yAylQpjZ3BvGzTMxAE3tvNGaRCrZNZhgTu4KOphZGUQ0/VpbakxCE4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=B1kxuvoo; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1762394810;
	bh=x0b6nYcdg7hiAcKdA4JhGlxHiilGQ3K7Dert+al7aoA=;
	h=From:To:Subject:Date:Message-Id;
	b=B1kxuvooB2GQMghXnBGjsUY0nM2kNBC6VAT7XUeXLGjGFv8I3THJNKkFd6jMVBj2v
	 4wiXOm2KR9GmWWX6cmZXw9teXpRioPjmrmDWNXjEepDP8BZvFaWxjvE4ranHaEXEyx
	 Y6G/5S98C//Tznwl9dSNk4Rw6wcR+VI3tdaPw8N8=
X-QQ-mid: esmtpgz15t1762394808tb962b6a1
X-QQ-Originating-IP: Kxt++LRpNywAhVRcx54Iw5qydXwjg4t+r/VQWDBNVZU=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 06 Nov 2025 10:06:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3992485569025743558
From: Chaoyi Chen <kernel@airkyi.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-phy@lists.infradead.org,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>
Subject: [PATCH 1/9] dt-bindings: ili9881c: Add compatible string for Wanchanglong w552946aaa
Date: Thu,  6 Nov 2025 10:06:24 +0800
Message-Id: <20251106020632.92-2-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251106020632.92-1-kernel@airkyi.com>
References: <20251106020632.92-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OYPMZDjp99nuc/wUw2MdUSwpzyG4/mrfL/0v7O17UWEQtq6vNT81vMIG
	zuZLhWSFK8nSwjfqDwWyRYACQ1qqjB0pmwx2NzfvxuuB9KZCFkyupnNq53wtAl6zea0cTC5
	Nl+qSww2hhZporfG0iYXlbdmtOMYpk2GLLDAQd5G9h8zA9nAy9lu6oGb2WP6rVfQEPWI8mr
	nHWRgbZsezAuiel/k1VxmGDhGXLiOa+8BdMFLAwa4vHMyBOIXRP1FjNjvsu1snz/oqJzJCJ
	E1ZnxpTUcN+L6vXTTBljbkrrsITOZdFeKcLm0N1dpxVRHKcgSWmj7UOy6lijJ/1KivuNXQT
	Yj8hRnA3tcwynQgXD4ulRxnwf9md2hbEMf7UPLVewWOaxVS7x04Wp8oTTjZOOWELQG0vQ2U
	f1EyFXKl/1v7mquAGnagRv0gNOeSyat/JIS2o9MpBepMSnpVFKIpw6lhSSxqEt/o0JiSwXK
	5sQgSJUzi5tyA/kL+Umr1BmCSvpa6KkhFHoTwO8XQ/nGnJZCg9TJFVHJ9BdjgfJ8nCV2pKq
	eTkS4HrkNbimGUl8XZH4C6Sz+s1e/wvS5QXWXnPiY9o+Cc/01PoubsaFRzWo+E7L0b5zCKi
	4fOdbXVLQ1OR4zUwkL5YDhPlygfYyanvAbBZbMRfrIqMHHiOtsGoiKMXhTI3EB3ViY8KwlX
	ROfKRhIiZc5eWFD+KtmHejBlZXKtDTV9hpdcVojcgJrZMO9+a99CWY6+DDqZeKFZHmL1C7P
	TVN63/+zLjzVY2CIV+yL/g6y/IjYzGrNzz/oos27I8d1mvDxuAcTsNDbHmmAh62lGveHYSo
	UW7Pn9uBbH8nOU8WKDMr8BOdqLjeE79JTxMi3sBebZlUBr6gcvWULrGoTVt5iE+BNKF6FrY
	fsigN7Jrk0qLoV99BLRCW3fKX4cLqLF6eCAvxgybyZsYPkzbAyuKz4f78QAh1O8kxb6O1uE
	g7tdfXdCJjIROf3ZmqQ10XJ39qdUVokqjMbN6mxQzz0PnNVQYSubJOqdY+mnlladSNraHJv
	zwjx2WrWPrsS1QqI51iCtcsKCxatWcpeGcoziCZA==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

Like w552946aba, w552946aaa uses the Ilitek ILI9881D controller chip,
and it supports up to 2 lanes.

Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
---
 .../devicetree/bindings/display/panel/ilitek,ili9881c.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
index 434cc6af9c95..f331a47cc759 100644
--- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
@@ -23,6 +23,7 @@ properties:
           - raspberrypi,dsi-7inch
           - startek,kd050hdfia020
           - tdo,tl050hdv35
+          - wanchanglong,w552946aaa
           - wanchanglong,w552946aba
       - const: ilitek,ili9881c
 
-- 
2.51.1


