Return-Path: <linux-kernel+bounces-886727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDBCC365A0
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 16:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E25F4FBD2D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 15:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35D8333431;
	Wed,  5 Nov 2025 15:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="JAfY12NE"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00D731DDBB
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 15:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762355995; cv=none; b=re9zL7s0S++ScIDLMk8E9buI+jVVdJvDSmyZ0aB+8ANJC9eDSU85wuUlNfqF0Kk9k2jNs6pTGvy3ytEnB4j8HMEe9t/cqnE0aTruEL43yUGW4gltNyFuZAPD+R6laxrggg3uTLqkhEIaeJwR7A1/z5DXBwsXQylDv7Uh++nKxZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762355995; c=relaxed/simple;
	bh=kvtKJDY2pNu9VyWgz/Mp/gNqGrK+aonpYO/S8VtjhPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h4tUe/nvSVg+x2AV9XJsRivIWy/3xPVffrcvj6wVDQHgVPGOM6DFvXx51fuxqtFWVt5liBznHkkImdi7cUIh861LuEa7P5QH8qKAbUvg1+sKr4rr8Lf2LeVrDXDcjZx43Ieoq/PBSmObVp9Zt9j1OZg/pNTAQz8y16f+NlrrMpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=JAfY12NE; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1762355641;
	bh=h0KCI/VnpGnnXdCZgBI8vuPjSYFr6CItFiDKjpOigWs=;
	h=From:To:Cc:Subject:Date:From;
	b=JAfY12NEGLS0zAJ157IAxLYtHIgEiDaoUT8jP3OvNrjsD+P5LtufUj/mVFwj0ZBBj
	 u82g0PAuVNIVH7zo6r/FR/gj8hvePSjaP9lu1Poq1vmw25TZE3C22yb8kKWXbbNNoC
	 rXblfpRb9128qEsHN47arQPOIkHucmcph0YLdpzA=
Received: from stargazer (unknown [IPv6:2408:824e:302:e8a1:c427:8c70:2426:6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id C15C866A4A;
	Wed,  5 Nov 2025 10:13:57 -0500 (EST)
From: Xi Ruoyao <xry111@xry111.site>
To: Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>
Cc: Mingcong Bai <jeffbai@aosc.io>,
	Xi Ruoyao <xry111@xry111.site>,
	loongarch@lists.linux.dev (open list:LOONGARCH),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/2] LoongArch: Bit reverse improvements
Date: Wed,  5 Nov 2025 23:12:52 +0800
Message-ID: <20251105151257.148530-1-xry111@xry111.site>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tie some loose ends in LoongArch bitrev.h to make it really useful.

Xi Ruoyao (2):
  LoongArch: Select HAVE_ARCH_BITREVERSE
  LoongArch: Simplify __arch_bitrev32 implementation

 arch/loongarch/Kconfig              | 1 +
 arch/loongarch/include/asm/bitrev.h | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.51.2


