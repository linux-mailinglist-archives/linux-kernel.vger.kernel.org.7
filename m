Return-Path: <linux-kernel+bounces-783865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A965B3339A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 03:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BCA44409B8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 01:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0294221D5B3;
	Mon, 25 Aug 2025 01:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="hYDQYF7I"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8CE22A4FC
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 01:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756085783; cv=none; b=WCNmeOixQ1QHuyN0HN3kw25Cj4uArrFcd41QlWoGzOg4Dj9wofUioPYZQumNtAD6ckQUQzNL9VwnfuHyJgUHGEigx32AZGOJ6tiQ+XyF8eAkET6LKmEPgecf7Rzf1A+WCxJyVGx2qaGp/xDG4WjTx3h1T56s646tQfOPYEPU2P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756085783; c=relaxed/simple;
	bh=GhygJecCQvm3mzcdYSI9+jCmwk7K/3IYFL9Y1pDOE64=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=u5SM3yjTkUg1agU5i2LK9PCvSnHXot+IhdPmxkUTxxWULIKOmX2f4pFygLHlfR9fLcCMB6i4JQzzLPKrk/3Ok17HzfjTobQIcAn9qp2IEJSb4X63R0W+CIfrD7e1UpoeYP2OSXSpMq/R8Y0aTB7/CUyLwC+9+J14q7q05O/3/0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=hYDQYF7I; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1756085780;
	bh=4788WmMOb8QcQZCKza1zlDpD6qQhfOULV+R7eq25UYE=;
	h=Subject:From:To:Cc:Date;
	b=hYDQYF7ICrPQbbVsQ9aGIrolwpB1J3Xl7bPdu3NyuDciq9+EM38ftWyhio1x04cJR
	 l10v8DPXE3dwOsJVLgYzpCaS/0QhKlpj1ZkX8ydz/89wJ5mLmWEExbZudHAf/mjZE5
	 yxPCl7gn7ruTzxoRtVfORyVa4ete4LN6Amw3kuEnS0QTFz38c6JHcYa6xdismMexyc
	 3wn22phg3f22RIhMQSVQW87dmNmu8V3FbOdMe+TEsc/AhHtbBDS6hIFOk3LJXDe3PF
	 zuYm9BPlJBE3w7gYVxjrJTwnAiTJD/muy1kJbz9OVfznWS9iK91Mq786Ke9RlORuur
	 u8oGISEBNos1Q==
Received: from [192.168.68.112] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 9E95964C1A;
	Mon, 25 Aug 2025 09:36:19 +0800 (AWST)
Message-ID: <2d122b5c4a19261148993b66e4b98371a684ba74.camel@codeconstruct.com.au>
Subject: [GIT PULL] aspeed: early driver changes for 6.18
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: soc <soc@lists.linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>
Date: Mon, 25 Aug 2025 11:06:19 +0930
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello SoC maintainers,

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585=
:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bmc/linux.git tags/aspeed=
-6.18-drivers-0

for you to fetch changes up to c30dcfd4b5a0f0e3fe7138bf287f6de6b1b00278:

  soc: aspeed: socinfo: Add AST27xx silicon IDs (2025-08-11 09:37:53 +0930)

----------------------------------------------------------------
Early ASPEED driver updates for 6.18

Two small changes, the most interesting being the addition of the silicon I=
Ds
for ASPEED's AST2700 SoC family.

----------------------------------------------------------------
Rob Herring (Arm) (1):
      soc: aspeed: Use of_reserved_mem_region_to_resource() for "memory-reg=
ion"

Ryan Chen (1):
      soc: aspeed: socinfo: Add AST27xx silicon IDs

 drivers/soc/aspeed/aspeed-lpc-ctrl.c | 14 +++-----------
 drivers/soc/aspeed/aspeed-p2a-ctrl.c | 14 +++-----------
 drivers/soc/aspeed/aspeed-socinfo.c  |  4 ++++
 3 files changed, 10 insertions(+), 22 deletions(-)


