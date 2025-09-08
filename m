Return-Path: <linux-kernel+bounces-806401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDF2B49635
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F0657B9B95
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027CA31158A;
	Mon,  8 Sep 2025 16:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O29U1YQa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623A431064B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 16:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757350411; cv=none; b=UNV6IdTdAzqcyL8918nhGkjN+TsrABnAi8vTbB0F/Io8tmqYxr+7UvC2V92spHlFPrT9pBH8HBE4R/pWvXyCfUlJKFUHYBPnwJw6ygDslw7vPbsMTCfgOIok5ZT6DbG8lQTxIqcvmYl4Hq0oVVfb3hhiGu9lbvSrGuRqwjccGzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757350411; c=relaxed/simple;
	bh=fqdr4JVyB4sy+PnRDDsbuIbYZ7kKcZQkLE9NcMRrAeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ru+t2MmGxXL+qx+C0IXQ3g8+E8yVtwEIcwpLXA4DPgqht7UhAx9tWof9uprhDue+PkEgTpbN/6/qnkOShVWVNM3y3SbcCKyEWrwPDOYSEh8MetJy1n8gZEjfV8gJD2wbVRYPIjRD1hXT7jKx01rfKrnlrwi2j77hnS0XWbcs2Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O29U1YQa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97CDC4CEF1;
	Mon,  8 Sep 2025 16:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757350410;
	bh=fqdr4JVyB4sy+PnRDDsbuIbYZ7kKcZQkLE9NcMRrAeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O29U1YQaFpJL5lCEfeBk4eKYiPhwKjGdj2s4iJ0gRiHgH+ZQngdLa54yD4ntUPm61
	 1UJiWQ3jc07BMg7aLwip0Jld1NhZ1MKAGvkbqI95VVibGTFw1hZzL3Biva8mOBWOgp
	 0ANbiHB0pDR3ub4CeWU5qetq9mh9XAyj/hrgCd4WmKCVrR/sjU1JKgaatmXpgqf7Q6
	 pBQPraSPSG1bQheG9qGEk4STTuFZ3WL7C0fnYGAkHM8a1onRSzgvf4QxgEi+vGqknS
	 vFTatsVwVrHSP2hprTUF0clHOLOLsSby6o2Grv1mDz0UZ/fhvAZMjU9dok3XcT8vIU
	 x5DEwV2feYViQ==
From: Saeed Mahameed <saeed@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Avihai Horon <avihaih@nvidia.com>,
	linux-kernel@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH fwctl 2/2] fwctl/mlx5: Add Adjacent function query commands and their scope
Date: Mon,  8 Sep 2025 09:52:56 -0700
Message-ID: <20250908165256.1255985-3-saeed@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908165256.1255985-1-saeed@kernel.org>
References: <20250908165256.1255985-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

MLX5_CMD_OP_QUERY_ADJACENT_FUNCTIONS_ID:
 - Query Adjacent functions (PFs/VFs) of the function calling FW.

MLX5_CMD_OP_DELEGATE_VHCA_MANAGEMENT:
 - Delegates own VFs to be managed/seen by other adjacent PFs

MLX5_CMD_OP_QUERY_DELEGATED_VHCA:
 - Query current function delegation state.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/fwctl/mlx5/main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/fwctl/mlx5/main.c b/drivers/fwctl/mlx5/main.c
index 7f3a1a9f7224..5b453742a5c5 100644
--- a/drivers/fwctl/mlx5/main.c
+++ b/drivers/fwctl/mlx5/main.c
@@ -58,6 +58,9 @@ enum {
 	MLX5_CMD_OP_QUERY_DC_CNAK_TRACE = 0x716,
 	MLX5_CMD_OP_QUERY_NVMF_BACKEND_CONTROLLER = 0x722,
 	MLX5_CMD_OP_QUERY_NVMF_NAMESPACE_CONTEXT = 0x728,
+	MLX5_CMD_OP_QUERY_ADJACENT_FUNCTIONS_ID = 0x730,
+	MLX5_CMD_OP_DELEGATE_VHCA_MANAGEMENT = 0x731,
+	MLX5_CMD_OP_QUERY_DELEGATED_VHCA = 0x732,
 	MLX5_CMD_OP_QUERY_BURST_SIZE = 0x813,
 	MLX5_CMD_OP_QUERY_DIAGNOSTIC_PARAMS = 0x819,
 	MLX5_CMD_OP_SET_DIAGNOSTIC_PARAMS = 0x820,
@@ -197,6 +200,7 @@ static bool mlx5ctl_validate_rpc(const void *in, enum fwctl_rpc_scope scope)
 	case MLX5_CMD_OP_QUERY_OTHER_HCA_CAP:
 	case MLX5_CMD_OP_QUERY_ROCE_ADDRESS:
 	case MLX5_CMD_OPCODE_QUERY_VUID:
+	case MLX5_CMD_OP_DELEGATE_VHCA_MANAGEMENT:
 	/*
 	 * FW limits SET_HCA_CAP on the tools UID to only the other function
 	 * mode which is used for function pre-configuration
@@ -282,6 +286,8 @@ static bool mlx5ctl_validate_rpc(const void *in, enum fwctl_rpc_scope scope)
 	case MLX5_CMD_OP_QUERY_XRQ:
 	case MLX5_CMD_OP_USER_QUERY_XRQ_DC_PARAMS_ENTRY:
 	case MLX5_CMD_OP_USER_QUERY_XRQ_ERROR_PARAMS:
+	case MLX5_CMD_OP_QUERY_ADJACENT_FUNCTIONS_ID:
+	case MLX5_CMD_OP_QUERY_DELEGATED_VHCA:
 		return scope >= FWCTL_RPC_DEBUG_READ_ONLY;
 
 	case MLX5_CMD_OP_SET_DIAGNOSTIC_PARAMS:
-- 
2.51.0


