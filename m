Return-Path: <linux-kernel+bounces-772478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94056B29330
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 15:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C9172003FB
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 13:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B34B28504A;
	Sun, 17 Aug 2025 13:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="CNlusVoJ"
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D636C241674
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 13:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755436241; cv=none; b=rba2cs7Lz8IlxDY2VHNj/QXk/V9fgGk4qJ6celSWAXdGZFRWbra2jGslxnRE6aWzsK0J91jSDvKwAkgs17Ai44C1GTc21JdZxv2LwZOFtBDZVfR8thWsSXU8YfDQqwrpas9z6ggJjU+bOLpPnGoq54obWZiVElre/dRKL2NFjj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755436241; c=relaxed/simple;
	bh=qvyPL+OnX4gAOYPzS957ni/30ldw08avClgjr5yeEbs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DZ87ijbR7QTqBAk/dCRq2i7gA2M48D14eF0J0hi+ZrNaO0SlC3U+6/KMW6dFW1RDuWxg7BLO9pnaDlrAcl6JVBFh2r/9aKcv3soX8z4TU6FxfkBFQw7FTgYLVRu9kqroNbvW6N8US91aPm8bpatg60qwvs4ZyygYjL31KR+gM0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=CNlusVoJ; arc=none smtp.client-ip=212.77.101.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 34713 invoked from network); 17 Aug 2025 15:10:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1755436224; bh=RhthSyV3t/gyGPi39+Cup5UQ7hIQmjcMOs6E6JDWgz8=;
          h=From:To:Subject;
          b=CNlusVoJOdFTvO3Pksk/6W1/gabPuDvhNimasuqdLmxpNOqHemBqjj3uQAX1xe0UE
           HizGJZwzFzCKsGrSq/tU5tpNtQrOoKOiB1BBvzcPhLX8mjxkLEn8n11zX6WMz1ftBs
           +M1cAyJWvQqdt0LUJPi+8MSmCpU8g0svwZMy0DwKxyVvyu/4JCXFd/zjs5lV2F6CAF
           58UImR1vdYcfFU9DILIY6jbm8Uu8WohruTT6ZIF9O3WlidP++Wx7ipCJnDGKWKXJlk
           p7r9JR0FMwJMO/6evXCEEganuXFlKcRXIiQP+s9XMbMDoqLkOY45TAtBMQb8MYyBMH
           WjJXpGIRpqOAg==
Received: from 83.24.134.210.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.24.134.210])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <robh@kernel.org>; 17 Aug 2025 15:10:24 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	tsbogend@alpha.franken.de,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	john@phrozen.org,
	olek2@wp.pl,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 0/2] mips: lantiq: fix ethernet support
Date: Sun, 17 Aug 2025 14:49:05 +0200
Message-ID: <20250817131022.3796476-1-olek2@wp.pl>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 086d2ee042e4bcc9373b0416932c200c
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000A [sYNE]                               

This series fixes broken Ethernet in the upstream danube dts. The
driver doesn't attach due to missing burst length property. OpenWRT
has its own dts, which is correct, so the problem has only been
spotted now. Other dts inconsistencies with bindings have been
fixed as well.

---
Changes in v2:
- renaming clocks in sysctrl
---
Aleksander Jan Bajkowski (2):
  mips: dts: lantiq: danube: add missing burst length property
  mips: lantiq: xway: sysctrl: rename the etop node

 arch/mips/boot/dts/lantiq/danube_easy50712.dts |  5 ++++-
 arch/mips/lantiq/xway/sysctrl.c                | 10 +++++-----
 2 files changed, 9 insertions(+), 6 deletions(-)

-- 
2.47.2


