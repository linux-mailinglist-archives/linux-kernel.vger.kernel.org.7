Return-Path: <linux-kernel+bounces-833124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E162BA146C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA51F386FB7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DE131E891;
	Thu, 25 Sep 2025 19:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvyEsx2d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD9B31B829;
	Thu, 25 Sep 2025 19:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758830244; cv=none; b=rxrYFWfsRbnB/FeqgYEHFF8LGB50bRhdC+rjeosMoDjGng97XPJpXxBdhqfbNc5/BuALcnmZMJPCeSHMmuo1lAJkOaEwufNIG/zTfnxGa2oHh7rhDjYZBK1cXEaYLkPeNXFmh70PvZWqOzfU+cyzhX1Den3EC/nFc8hLb5MSqr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758830244; c=relaxed/simple;
	bh=HxWRAsbo9T/qCfDhR7VtdRIj4AuqN+7L7CRZOBD92ms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V5TpwhFNW4hFNa4k6U+2zSNtLZePeQm0atsM4W0c3O05EPQkkGiMPsNgS6ejw2U+gUSW7f4ZiLBN6ESViZWhMsiyfqTKGD46oEo+RIDjMRVMoFORnKCGabmz0eBj78TUSsMXCx+KsyumgCDnV3Dqk2vVOa7w1+Y+hbbVObLGQX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvyEsx2d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59DB5C16AAE;
	Thu, 25 Sep 2025 19:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758830243;
	bh=HxWRAsbo9T/qCfDhR7VtdRIj4AuqN+7L7CRZOBD92ms=;
	h=From:To:Cc:Subject:Date:From;
	b=VvyEsx2dQ1jpOaDSp0GTfKEgCmIjh66R084CC6ee0tgmP9ZA1hIdEV3fM14TWZmoi
	 LN2+Qk05/5Rx0iSyoypCOAq6m77H3vTt/mp4aEA4QUrnTSfmoDGylqn7xC7ZWissGx
	 OECNLKD2pv+8JVRNpEk+FiGeVnjsjbOyMLso8yRpSIZhfzyWv3u60pI5FcqTAZgg+W
	 fRGyaFFWFmlsPaoiDj7DJbGlCQnL3y1olgZ2W6mq4qE3VnPigOwkGfWqhlc2O+tVDf
	 OSP7VeNJofiGLdwx3+7sp/fWd/lZ7YhuDfoRS8UNJcvs2QTpz09SZArAyjROrFMfgR
	 ZotOVwrO0r8mg==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] of: base: Add of_get_next_child_with_prefix() stub
Date: Thu, 25 Sep 2025 14:56:30 -0500
Message-ID: <20250925195720.2200088-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

1fcc67e3a354 ("of: base: Add for_each_child_of_node_with_prefix()") added
of_get_next_child_with_prefix() but did not add a stub for the !CONFIG_OF
case.

Add a of_get_next_child_with_prefix() stub so users of
for_each_child_of_node_with_prefix() can be built for compile testing even
when !CONFIG_OF.

Fixes: 1fcc67e3a354 ("of: base: Add for_each_child_of_node_with_prefix()")
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/of.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/of.h b/include/linux/of.h
index a62154aeda1b..5e2c6ed9370a 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -550,6 +550,13 @@ static inline struct device_node *of_get_next_child(
 	return NULL;
 }
 
+static inline struct device_node *of_get_next_child_with_prefix(
+	const struct device_node *node, struct device_node *prev,
+	const char *prefix)
+{
+	return NULL;
+}
+
 static inline struct device_node *of_get_next_available_child(
 	const struct device_node *node, struct device_node *prev)
 {
-- 
2.43.0


