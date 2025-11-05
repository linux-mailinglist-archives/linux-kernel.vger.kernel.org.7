Return-Path: <linux-kernel+bounces-886471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AF088C35B21
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 13:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6F75B4F839A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 12:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3548313284;
	Wed,  5 Nov 2025 12:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="UnSE+vxs"
Received: from smtp113.iad3b.emailsrvr.com (smtp113.iad3b.emailsrvr.com [146.20.161.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A6F2DF132
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 12:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762346799; cv=none; b=meVfvfb1TnspTddtRwNmgSmnC3XwYJe4p8+I2VvcHYHkxdLvt03f6hRuo/JUXFdjytVvVGkQO7IBz6XuX6V+Ir91hMGEGZoPXrGnh0d3uLBKRkuulZ4+E02tCOJOtz39k/EviXjaqRj2mVGvCwHBhScASNFKTf2W94BhirWjZBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762346799; c=relaxed/simple;
	bh=sA95L5WyTW33LUQ85VxqvUvQI/0mZhbO6q/ZdLqbfbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B5L0n99fUmCLfhZoXHB1lB5MwTlTUfTDzXCdpCqBYVHK2Lal/QE6kad+vu4lgOojAxmUDCftzWtoeKWyokVpGEVhOY7iJ4rAGqXvw90mmG2hg+WoTu8jB5DpJiNFGEq1MDBLZyCNVN99aHE5zGdZ9RaW1RfoUUqetguTxCEtRGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=UnSE+vxs; arc=none smtp.client-ip=146.20.161.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1762346281;
	bh=sA95L5WyTW33LUQ85VxqvUvQI/0mZhbO6q/ZdLqbfbg=;
	h=From:To:Subject:Date:From;
	b=UnSE+vxsyr2OScOYRPS8+O9/dpV/L32i6tdaxs0KVqSFoA0rEzoKzUW8S5U8Q/aGE
	 9wnST7OvWtVm6W9eWcGEgRBvw/jY0y14HskbohPfigmISzBeCzM5cbBVZ2WOrmJF6E
	 7x1eOWFUH40slLUn6kkDgyQ68FJiCHWmSi8enqr8=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp7.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id F22C86032B;
	Wed,  5 Nov 2025 07:38:00 -0500 (EST)
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-fpga@vger.kernel.org
Cc: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] fpga: Add dummy definitions of API functions
Date: Wed,  5 Nov 2025 12:31:04 +0000
Message-ID: <20251105123752.93672-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104153013.154463-1-abbotti@mev.co.uk>
References: <20251104153013.154463-1-abbotti@mev.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 2331ede2-2f65-45fd-b71e-e0d81416256f-1-1

Add dummy definitions of the FPGA API functions for build testing.

v2: (1) Add a missing #endif to altera-pr-ip-core.h
    (2) Change conditional compilation tests to use #if
        IS_ENABLED(CONFIG_xxx) instead of #ifdef CONFIG_xxx to avoid
        compilation errors when the options are configured as modules.

1) fpga: altera-pr-ip: Add dummy definitions of API functions
2) fpga: bridge: Add dummy definitions of API functions
3) fpga: manager: Add dummy definitions of API functions
4) fpga: region: Add dummy definitions of API functions

 include/linux/fpga/altera-pr-ip-core.h |  8 +++
 include/linux/fpga/fpga-bridge.h       | 75 ++++++++++++++++++++++++++-
 include/linux/fpga/fpga-mgr.h          | 95 +++++++++++++++++++++++++++++++---
 include/linux/fpga/fpga-region.h       | 44 ++++++++++++++--
 4 files changed, 208 insertions(+), 14 deletions(-)


