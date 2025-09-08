Return-Path: <linux-kernel+bounces-806400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61826B49633
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6965E1B22F2F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3081D30F948;
	Mon,  8 Sep 2025 16:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrjiafo9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD3F30E0DC
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 16:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757350410; cv=none; b=sNXXJwa2lznnl26lfLzpZ5VW9wcHnrATt909WX0MnbxWJa9TTj+0IVtqccanlO31UHidPG4BaV7UHqpKrGnZa5hhKyTXl0dXoCBStb9VTA0cpcFeHpZSaDHf+ToyPBkObUCNuRvHcTpu2ufA2UiRXdHTXIBtBcfo8anQJzRbXCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757350410; c=relaxed/simple;
	bh=lIwMGsX8rVAj1hlFZRnAqjgbFxOF1OO6b+5+oa8jvqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=REf5hON3gDKLjOcgV+7C3ploprSyHJVCCz9s8wSu//dVaE/dtu4a0TYJz6vFGW4RIn1vQLHI3JspY6fFoE8p1OdP0EV9nmMxVXFjyVFRqIwwO3mzZKHXrW9Put2Mt88nMVMsGgRskKqZIo3ZwNzy+Gdblpk50uTy5aEQQ9EcQQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrjiafo9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC68C4CEF1;
	Mon,  8 Sep 2025 16:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757350410;
	bh=lIwMGsX8rVAj1hlFZRnAqjgbFxOF1OO6b+5+oa8jvqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jrjiafo9XvIsqKjx9/UW5YbO0UB+1DVsPCuBi/0WOsEKXClsELTF1zZGbQY5pOQtx
	 gpVG075om3VV+ctJkaVQePWSUcwzyLA0/p0zXkI+4VDyBu1Fw32gDRsgC8yRxROQTo
	 3kTjo972jtVh9H59j/B9sqFcaSpOW4mOcI7c9pFq4eWEvd2EJ5M+EJydNmbZkNe+ir
	 1Ft2Q+ozgDBNtz98uZ7THDO/hw5Jgg69SwQK+bbV05iWuTtI2tiCGCbKAGbN0foyvj
	 N2yPUAI46WsFjicC/jdM+WJ2uXSZuNqRP6GHrSrFfwSaN2AjnfPSu4BQ3ejx+7CRn2
	 9ZOSc8T7qVFJA==
From: Saeed Mahameed <saeed@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Avihai Horon <avihaih@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH fwctl 1/2] fwctl/mlx5: Allow MODIFY_CONG_STATUS command
Date: Mon,  8 Sep 2025 09:52:55 -0700
Message-ID: <20250908165256.1255985-2-saeed@kernel.org>
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

From: Avihai Horon <avihaih@nvidia.com>

MODIFY_CONG_STATUS command is used to enable or disable congestion
control according to a given priority and protocol.

Add MODIFY_CONG_STATUS to the allowed commands under configuration
scope.

Change-Id: I6099206ca683de5173fe74fe56f63994f1c4c911
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 drivers/fwctl/mlx5/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fwctl/mlx5/main.c b/drivers/fwctl/mlx5/main.c
index f93aa0cecdb9..7f3a1a9f7224 100644
--- a/drivers/fwctl/mlx5/main.c
+++ b/drivers/fwctl/mlx5/main.c
@@ -188,6 +188,7 @@ static bool mlx5ctl_validate_rpc(const void *in, enum fwctl_rpc_scope scope)
 	 * filter commands manually for now.
 	 */
 	switch (opcode) {
+	case MLX5_CMD_OP_MODIFY_CONG_STATUS:
 	case MLX5_CMD_OP_POSTPONE_CONNECTED_QP_TIMEOUT:
 	case MLX5_CMD_OP_QUERY_ADAPTER:
 	case MLX5_CMD_OP_QUERY_ESW_FUNCTIONS:
-- 
2.51.0


