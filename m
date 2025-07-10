Return-Path: <linux-kernel+bounces-724807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 154A1AFF722
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 04:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 648AD5A1FAB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 02:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841B028031D;
	Thu, 10 Jul 2025 02:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="bjicqfx2"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7926A27FD7D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 02:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752116044; cv=none; b=aZbu+2vEUQGmgP1A8xm1exOHajgD8DRAFae/BypmV9tTWygixeeT9uoJzZuWYmKh/IHVG2Uei/YTPFnwl56k8+DujCSqMVNig/TH6BL5zAAJ4IQkFDYshsfP6pmJ8I/6eoos1cuOsEfA15PFDChFA0zEn6I1o242aufgpJ9MVu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752116044; c=relaxed/simple;
	bh=q461qi+6eQxV71VQ/tzFqufYpF/M8CGNdgnC6kmWhiU=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=nTpsUlL5ZLBPmXbgwY3MfcjMwwZdn4+lGBlmOy3JpGXwuxMW0WharuEhMd3SIEgdfFkbdlNZccRwHI+eXzbAcIod5EXD79xaobz44WtXGb+4W8dRXkT+unF2SaUg/XK4oAXAP6ahCjo9tSnpMM04XxpFvAdl2vppshqSxxxXBCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=bjicqfx2; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1752116040;
	bh=8dzREoZ/WsyaHQKz6zD+3j3tk+9rN2BHKiKlFhHQROA=;
	h=Subject:From:To:Cc:Date;
	b=bjicqfx2rgywaAX0RM2JysJJTO3TVqwRoCaMymwSQcoJL5VujZkVZM+TNowxxjUuo
	 v6BuM6P+Px0ibNyrm/wG0mfebevRTIvUApMST7bTO7upckx19xnc594OiAHYPXRdht
	 zJuS+zk31AZxWUbG7Y3qnapLI4xjSUyN8RJnypB8GRfkrVDu5LrLqxTaVkCVLKbnaG
	 vb2SntBDI9QjLtYdlhjT9QANxeVgLG2Tx00M0DBy98Vdtf269dwFjJlFliiDsDGPDU
	 z6dDpDjnhPnpMVSDlrA9fVdcvq5QDVMxQccQNN+FgSiPPny1CFPlHPpRzB3VtCGPrp
	 NSCBI15IteGPg==
Received: from [192.168.68.112] (unknown [180.150.112.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id D2D856508A;
	Thu, 10 Jul 2025 10:53:59 +0800 (AWST)
Message-ID: <9123f151280e52c63dcb645cb07d4eee3462c067.camel@codeconstruct.com.au>
Subject: [GIT PULL] aspeed: drivers changes for 6.17
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: soc <soc@lists.linux.dev>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-aspeed
 <linux-aspeed@lists.ozlabs.org>, linux-kernel
 <linux-kernel@vger.kernel.org>,  Joel Stanley <joel@jms.id.au>
Date: Thu, 10 Jul 2025 12:23:59 +0930
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

I've done further rework to the ASPEED LPC snoop driver in addition to
the immediate fixes found in the PR at [1]. The commits in the tag for
this PR build directly on top, so those from [1] are also listed in the
shortlog relative to v6.16-rc1.

[1]: https://lore.kernel.org/all/d119a7b44b25a1e55a710adec7fce3e9a9fc898e.c=
amel@codeconstruct.com.au/

Let me know if I should arrange the changes (or the PR description) in
some other way.

Cheers,

Andrew

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494=
:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bmc/linux.git tags/aspeed=
-6.17-drivers-1

for you to fetch changes up to fdf003f30b99e232cd3e61cc42d836ed14d08ccb:

  soc: aspeed: lpc-snoop: Lift channel config to const structs (2025-07-08 =
11:35:07 +0930)

----------------------------------------------------------------
ASPEED SoC driver updates for 6.17

The ASPEED LPC snoop driver was recently the cause of some concern. In addi=
tion
to the initial fixes, the channel configuration paths are refactored to imp=
rove
robustness against errors.

----------------------------------------------------------------
Andrew Jeffery (10):
      soc: aspeed: lpc-snoop: Cleanup resources in stack-order
      soc: aspeed: lpc-snoop: Don't disable channels that aren't enabled
      soc: aspeed: lpc-snoop: Ensure model_data is valid
      soc: aspeed: lpc-snoop: Constrain parameters in channel paths
      soc: aspeed: lpc-snoop: Rename 'channel' to 'index' in channel paths
      soc: aspeed: lpc-snoop: Rearrange channel paths
      soc: aspeed: lpc-snoop: Switch to devm_clk_get_enabled()
      soc: aspeed: lpc-snoop: Use dev_err_probe() where possible
      soc: aspeed: lpc-snoop: Consolidate channel initialisation
      soc: aspeed: lpc-snoop: Lift channel config to const structs

 drivers/soc/aspeed/aspeed-lpc-snoop.c | 224 ++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++-------------------------------------------------=
--------
 1 file changed, 110 insertions(+), 114 deletions(-)



