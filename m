Return-Path: <linux-kernel+bounces-726342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCA0B00C12
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 21:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 987BB764E71
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 19:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3DF2882DE;
	Thu, 10 Jul 2025 19:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="1gHgW9Wy";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="HQArWaY3"
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F31738DD8
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 19:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752175112; cv=none; b=PYLY+IIQP04lTnOOtwfgOl17WXQR+yeTtxdN9qKdVdjyxFDdbyCj3eghJzUgoa+nnAlZb7Rg0anZtMyVvm7wDSGfVi6+7As7HGpPoqxEBz7FhLOWREDWLcb48n3masUIFOSrpEZV6/UJHv+xBPYgUEjn0lytorgY8EpNtPZsEhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752175112; c=relaxed/simple;
	bh=hYWCsiLaucrRCXLWTJZUAVyVH9wiplFqSsUs/v0qq5I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YKLtY3De44esbrGwFbOohI/1zogYFCw+zcwGyYZPS/neWOqQ2y7DmZ0Sawljyig3QUlNTcO3YQAgskC3e7XULpzziJr1z9rVQO8RVfmvpfq3YnSencsu0IJPrej6iSOxH7j47WfErpJngr5xwwtj9mrE1Hk6JrmSVU1CKC4u9bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=1gHgW9Wy; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=HQArWaY3; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1752175107; x=1752779907;
	d=konsulko.se; s=rsa1;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 from;
	bh=yIKje5wAXurxmtbQ0lnpzvJAveEfbYFc+nB4ATz4KQM=;
	b=1gHgW9Wy1kLa3A2keL0jvqP6rnAv+NSNxIdwUQZduELYdUaBzW3GbfL0NeLnUrHTUmYm6TyE+tj5Q
	 hMnixWlvApGzFsyw0XbDtObJJmwAOarFEsQTnR3V9lx1r9W8mtuZI6B+kpjAkeB1Bv9d8HfFY9H4m2
	 5yMk+aOTr1eOnesJDQ6doUdyM65ysj6qcchRHkH7MEkbpeLG4LcJXrBQJFKBXDlsVagJXPAmQs7U3y
	 cEH2thZ8JH9qtSkkXT10BU91qSZRwPLImqQlmEoMZjRd2uGH5OdOCESI8awIjY3scoC0iX+bObh2ph
	 HgEVlPhrPkRcIkF1lPAj0mee+fLWnmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1752175107; x=1752779907;
	d=konsulko.se; s=ed1;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 from;
	bh=yIKje5wAXurxmtbQ0lnpzvJAveEfbYFc+nB4ATz4KQM=;
	b=HQArWaY3WmpuxBewTZ4jna2D0DGoDICP3dHMkkJD8aWwXj7GQbgWocHLwmlsPxc3ZgFbWu+m6LF22
	 9f4BGbSBA==
X-HalOne-ID: a754a754-5dc2-11f0-9693-85eb291bc831
Received: from slottsdator.home (host-90-238-19-233.mobileonline.telia.com [90.238.19.233])
	by mailrelay5.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id a754a754-5dc2-11f0-9693-85eb291bc831;
	Thu, 10 Jul 2025 19:18:27 +0000 (UTC)
From: Vitaly Wool <vitaly.wool@konsulko.se>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Vitaly Wool <vitaly.wool@konsulko.se>
Subject: [PATCH v2] mm: zswap: add myself back to MAINTAINERS
Date: Thu, 10 Jul 2025 21:18:18 +0200
Message-Id: <20250710191818.1429309-1-vitaly.wool@konsulko.se>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's been a while since I was one of zswap mainainers but nevertheless
I'd like to get back on board. There are some things in the pipeline
related to zswap/zpool and Rust integration that I'd like to submit in
close future and maintain thereafter.

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


