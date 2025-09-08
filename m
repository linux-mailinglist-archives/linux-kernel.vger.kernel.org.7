Return-Path: <linux-kernel+bounces-806399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BADB1B49632
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B8F83A4C9A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5848530BBBE;
	Mon,  8 Sep 2025 16:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRPz0r9O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73CE53A7
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 16:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757350409; cv=none; b=te7/aCRHLn/XxnFeCF3XLWh+vei9MF19nFzN5YRx4Q7bLEzQoDddw2s/AmiJ6KDOe59nvy1Y7MZBAoE6/lRs/G3z5W6Ans/1r7MpO+PqujDcdQt96+i1D87WuVABTjRRs4HruMNdMYaGI/9loLOwgt7eYzfRkNlh5yauPM49t84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757350409; c=relaxed/simple;
	bh=lV0yv8d3FQGn2JQRxpKFAPLC8gctlKYdHFBgM3YrfCw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GR69AqzFZYxmYRTk9CJqqGTg7ck4jilbXV78mlscw4aW8lzE6lAD1ANf+ar7hPMHKOi6Mtw0W0rWbDUfPJUYykFZKHkD3wyLD3WVgMdMeCfKvZcQklGynjkx6HpUT7UAj/GgKz/zOsJdTob1nFTjjmLa4TJNlZ+T9qn45MO520w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRPz0r9O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F75C4CEF1;
	Mon,  8 Sep 2025 16:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757350409;
	bh=lV0yv8d3FQGn2JQRxpKFAPLC8gctlKYdHFBgM3YrfCw=;
	h=From:To:Cc:Subject:Date:From;
	b=PRPz0r9O+LJ13Rzfout3/km0D9YWENTPrDpECj+WDHCnmAF0A5u9DD95be4egtac/
	 AnCN2+ME4T0OMk5rNXbcC4PC/iJDNT/VfwP53h2rKDBHatWe/pXa6n7EBOs9Mzy0Pj
	 2JYnr9ZWve+0F/CDDKeXSIiTHVyV1TCcoOI34ZuDf1IPuxEoBNux0Td5GfJNJsOTzK
	 FvxzUnmXR/iZ0f6EAyH2hosxr/QtR9lq2fLh7B7uqq4IeMSJJ2W9VW4e1CP8aopuT/
	 JmgCFholqbxFpplnFclkU7QhcKzWUNOpuzw1VMnx8+jj+ryazpn2sOy0Ihs2aRosrc
	 i3EcOyRS/jrQQ==
From: Saeed Mahameed <saeed@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Avihai Horon <avihaih@nvidia.com>,
	linux-kernel@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH fwctl 0/2] fwctl/mlx5: Add few new FW rpc commands
Date: Mon,  8 Sep 2025 09:52:54 -0700
Message-ID: <20250908165256.1255985-1-saeed@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

Hi Jason and Dave,

This series adds few new commands to fwctl/mlx5 driver:
1) Adjacent function query commands and their scope
2) Modify congestion status command

For more details please see each patch description.

Thanks,
Saeed

Avihai Horon (1):
  fwctl/mlx5: Allow MODIFY_CONG_STATUS command

Saeed Mahameed (1):
  fwctl/mlx5: Add Adjacent function query commands and their scope

 drivers/fwctl/mlx5/main.c | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
2.51.0


