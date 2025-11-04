Return-Path: <linux-kernel+bounces-883885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F37C2EA81
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 01:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE3A81892AB8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 00:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009892147E5;
	Tue,  4 Nov 2025 00:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sf5MvS4F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567761E5B7A;
	Tue,  4 Nov 2025 00:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762216968; cv=none; b=pcuYSCiL/1wNyVLHedg2/PQiL5PmlWKzfcRxPSYhYfgxqacUcvP+zBOlZ+MAApd2+zNgKK1koS3am5UWH9NWWGWAnFVEt+QLevpvxItQBC9tvpIgcmc0kqxKRkmfZybIl+jBm/7jmePfn+P+AAtXDp5LHhiSdrR/BYcoQekUZWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762216968; c=relaxed/simple;
	bh=2r9Fw3iQ0QcFHr/gZjRs8ICBI3H+JDTg0UqfsW9Yfvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PJkclZA1zNoLSHTv3EssamuMiRF1p0SuEeQPBMK+bwj5fThSxr/+RjBsy19kQaIyx5luctqk0IbL+ezcmIrDOaDmFRh1DNx8dFUVuWNmtLPTeiGoip76fHJNrx/d5sy6mkjbvPICi2Y6hWuC8pZcLQQlSAAac9fKzfd8dQ6oqSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sf5MvS4F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBADC4CEFD;
	Tue,  4 Nov 2025 00:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762216967;
	bh=2r9Fw3iQ0QcFHr/gZjRs8ICBI3H+JDTg0UqfsW9Yfvw=;
	h=From:To:Cc:Subject:Date:From;
	b=Sf5MvS4Fc5vYlP1yJk7K3M/jJ9Vrzd3z12eYA745lnOdHhzDytTP1ZFAQv/fcIPa2
	 dFJ7OSon4GatWzsOb8zw7eSLYU6v1l3SspoRvo6YY130hRpg3Lz+RzZB7f5Yv7bTt9
	 ze2CX2Y6JOMid/GDVPoU+mlEdZnOkg7qGxY95nwXwi07CPsDFjao4wtQcrpCGIpOSL
	 9JLYsmSK8HVXRl9Vts836AAFiIbYSj6VdgTm4g+MwwBm/iLSzeYisePyUr+rv7dQKW
	 IeUp3ALO5dg61ePcnv0hgyjTAyJSjF9UCV0ZTBj/8bNmlEiRj4NG29fQp8z48OTTM5
	 BKBCoOgS+elMw==
From: Jisheng Zhang <jszhang@kernel.org>
To: Minas Harutyunyan <hminas@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] usb: dwc2: fix hang during suspend or shutdown
Date: Tue,  4 Nov 2025 08:25:01 +0800
Message-ID: <20251104002503.17158-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dwc2 on most platforms needs phy controller, clock and power supply.
All of them must be enabled/activated to properly operate. If dwc2
is configured as peripheral mode, then all the above three hardware
resources are disabled at the end of the probe:

	/* Gadget code manages lowlevel hw on its own */
	if (hsotg->dr_mode == USB_DR_MODE_PERIPHERAL)
		dwc2_lowlevel_hw_disable(hsotg);

But both dwc2_driver_shutdown() and dwc2_suspend() tries to access
the dwc2 registers, this would result in hang during suspend or
shutdown if dwc2 is configured as peripheral mode.

This series tries to fix both issues.

Jisheng Zhang (2):
  usb: dwc2: fix hang during shutdown if set as peripheral
  usb: dwc2: fix hang during suspend if set as peripheral

 drivers/usb/dwc2/platform.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

-- 
2.50.0


