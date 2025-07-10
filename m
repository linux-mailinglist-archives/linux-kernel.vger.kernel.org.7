Return-Path: <linux-kernel+bounces-724772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA288AFF6C4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 04:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73CD664009E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 02:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468D727F730;
	Thu, 10 Jul 2025 02:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="O3MbPEDV"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A08027F171
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 02:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752114261; cv=none; b=YlMsAyR4VCDLtdsuV0Qa2q+Qxt+F8kGqsKz5Q5S3qEYwsp8sTm9aLSPJpYYb9YRIy201L491pnawzcoIxZx9xvqV2BAviBtMB9LY2tjKNxfTzq0Ak/tjGfsDb/qDEjcBnzuatRQbV9Dihu/f2MNid+5l11LeXB4yoq55A1hi2/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752114261; c=relaxed/simple;
	bh=/5k29OQG3+cl0g0MxRk70gG+2eKmdFtzpYOa/bQR91o=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=cgVvXqiQ9yXSuWRQ4gcCLcZAchWme2HM7a2YsJFnxVRfsd6bRd2QFQli+sVQGryQSwyBdoKT5FmyFJT9OzCg4F3LGmFyADgAxyewHyPahht/vxXIn6Xs1BR7M7QqXid39LX6UlSibcEwLqWJHoUbbbpHOZPDehvDn6SqVSx1r/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=O3MbPEDV; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1752114257;
	bh=lFaBzW/UFNKRDOoKgOilQk2+bD1ofG50x/0d54hiwwo=;
	h=Subject:From:To:Cc:Date;
	b=O3MbPEDV8Vl5EyZd0IlS9GM7zFbwanUKbgi8uw38SA+/7kAG7A5I3K6ne6QLYVQ5W
	 QYE7yjtnUqcs6SXZNOQoj/kRpTxPpnbabtnuBeHjf6ZqZO/Xow2zMoyTTtz8/x2YZz
	 mM3u9e1zWiE7P7qvwU1e+DhY4ykrkeIJVcCIA+Tcvw4N6nsHPwoGnT2d6yo92Oeztn
	 dUMJODDPBsu0MHHxcO39SIobpy3QdatzTOhVNLX4+hJ2N52Vr4KpGrQp/64oXoNuGm
	 8YsAJQzi05wkBJqBKvptPYI5gftXk3EvuiRymsscENZpuzd6NoJk0g4po/FpHeRPRC
	 Av0g/SX3FK7OA==
Received: from [192.168.68.112] (unknown [180.150.112.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id D972E6508A;
	Thu, 10 Jul 2025 10:24:14 +0800 (AWST)
Message-ID: <d119a7b44b25a1e55a710adec7fce3e9a9fc898e.camel@codeconstruct.com.au>
Subject: [GIT PULL] aspeed: drivers: changes for 6.16-rc6
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: soc <soc@lists.linux.dev>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-aspeed
 <linux-aspeed@lists.ozlabs.org>, linux-kernel
 <linux-kernel@vger.kernel.org>,  Joel Stanley <joel@jms.id.au>
Date: Thu, 10 Jul 2025 11:54:13 +0930
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

Here are two fixes to the ASPEED LPC snoop driver for the 6.16 release
cycle.

Cheers,

Andrew

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494=
:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bmc/linux.git tags/aspeed=
-6.16-fixes-0

for you to fetch changes up to 56448e78a6bb4e1a8528a0e2efe94eff0400c247:

  soc: aspeed: lpc-snoop: Don't disable channels that aren't enabled (2025-=
07-02 11:05:20 +0930)

----------------------------------------------------------------
ASPEED SoC driver fixes for 6.16

Address concerns in the ASPEED LPC snoop driver identified in the first two
patches of the cleanup series at [1].

[1]: https://lore.kernel.org/all/20250616-aspeed-lpc-snoop-fixes-v2-0-3cdd5=
9c934d3@codeconstruct.com.au/

----------------------------------------------------------------
Andrew Jeffery (2):
      soc: aspeed: lpc-snoop: Cleanup resources in stack-order
      soc: aspeed: lpc-snoop: Don't disable channels that aren't enabled

 drivers/soc/aspeed/aspeed-lpc-snoop.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)


