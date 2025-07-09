Return-Path: <linux-kernel+bounces-723604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E537AFE906
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 991445817D3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AFD72613;
	Wed,  9 Jul 2025 12:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="ut7sGN8I";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="sZqEd+WT"
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1627C2D46AA
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 12:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752064502; cv=none; b=mc19wibvmWUeusvUOg7Vhcd9HZaV8Xuuyohn5RmHs2CmICHeHmJ1dCJlpF/QxuOmve9pLDmB1Jbh4Ta+8C57oJasKbl1O3AOU/crbxmK/3PZahSbZFaFunVpkEAnJTv7sVQx9Z9H+3Z1BFw8u78gRmSBbANvVQMVnfUVwc4fvyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752064502; c=relaxed/simple;
	bh=Tx6miTYD3YXmy/tuzpDItzemS2jcJpvPg+xmBCtLg1w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=enjUacIud1NrZ/tkTqwXsVvOr2OnP7opc8rfcveXkFhE/FDjoz1UH88Nf9a5Tj74JLMQAG7LUWU2js0MdPWdHdRGrkcP61ZCLI/sgdKI8AuQxeieWW1rlMsvb4HdE2INT5gY4N5hJq/4GMdEvtwAWfNit+HXvqEdF5w9FUytEEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=ut7sGN8I; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=sZqEd+WT; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1752064490; x=1752669290;
	d=konsulko.se; s=rsa1;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 from;
	bh=dCjZIRLv4pVmBGaWZV+gdpLoJB5gTm5uOl1/8FXeS1k=;
	b=ut7sGN8I008aZrN3Li455f3o0q9fHA7qsj/su+3qW7NVoNP2U0yFun84xrgXIhRpjz/zPRdvjWU99
	 lKoQLVW9kzTd1mpultXa+T66Q3Qwx2LHA3agq5vbaRCensGcc+gEQXDIEn63uEqs7kh6jUlkLaSbFl
	 SqK2t8kwO09ppOTkmHfND+34s4oB9Zp4y4cn7i/GuiBL2Sg0aMsgRwqJdwW4cx2Al5jdjJT5Xdqzml
	 ZnT2KQdYwe8if6byiEkBiWe3/2kEU39kU7TdTmQWy2KehUBE9NWvljq1AGXku8YXh0/wbODBUQ8ZAZ
	 Kh7z5QZog8JcZFpNVN0mifwnc39vTew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1752064490; x=1752669290;
	d=konsulko.se; s=ed1;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 from;
	bh=dCjZIRLv4pVmBGaWZV+gdpLoJB5gTm5uOl1/8FXeS1k=;
	b=sZqEd+WTk//Xix4UHBabhjeexEld2Tj8xKXjWDwA7CB8+iK/bkaZcjwADA5vNY2yEJMVaznjQTX1T
	 LYHyGTCBw==
X-HalOne-ID: 1a11fd12-5cc1-11f0-a243-632fe8569f3f
Received: from localhost.localdomain (host-90-238-19-233.mobileonline.telia.com [90.238.19.233])
	by mailrelay2.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id 1a11fd12-5cc1-11f0-a243-632fe8569f3f;
	Wed, 09 Jul 2025 12:34:50 +0000 (UTC)
From: Vitaly Wool <vitaly.wool@konsulko.se>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Vitaly Wool <vitaly.wool@konsulko.se>
Subject: [PATCH] mm: zswap: add myself back to MAINTAINERS
Date: Wed,  9 Jul 2025 14:34:38 +0200
Message-Id: <20250709123438.794466-1-vitaly.wool@konsulko.se>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch removing me from MAINTAINERS was sent when I was on a
winter vacation. Missed it then, my bad, but never acked it either.

Let's get back to status quo.

Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9dd4111d7d96..f3bfbfa27fce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27474,6 +27474,7 @@ ZSWAP COMPRESSED SWAP CACHING
 M:	Johannes Weiner <hannes@cmpxchg.org>
 M:	Yosry Ahmed <yosry.ahmed@linux.dev>
 M:	Nhat Pham <nphamcs@gmail.com>
+M:	Vitaly Wool <vitaly.wool@konsulko.se>
 R:	Chengming Zhou <chengming.zhou@linux.dev>
 L:	linux-mm@kvack.org
 S:	Maintained
-- 
2.39.2


