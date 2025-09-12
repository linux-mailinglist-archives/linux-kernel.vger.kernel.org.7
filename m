Return-Path: <linux-kernel+bounces-814079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BA3B54EFD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0D3B7C7768
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17527310654;
	Fri, 12 Sep 2025 13:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZafejnTu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632C03101B5
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757682776; cv=none; b=u0dLnJOljvxC6fmM0UIfdnXXkmY0TFNnF72xQIRNHaJ+GUhoY80J+SSbSPKoPFXv7g+wC5j8h+ZjMJm8u5bdaTE8ByLHqRvHfO+XZjSCwIPQw93d45sTudKKRfi4jznwDI3UXm2haSQ5jycfYEhG8S60Kvk5hGbmi0qowyD8hYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757682776; c=relaxed/simple;
	bh=eGV2y5TFSFQkteHzHzoS4O4WMQxEMS72NLxJWUbTZMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iRZAQlBjLvDQQKIyvDvimZPKndXDPWhOtOgr5akXqZNwDshTbrpoeNm5Hfx0g6mNEJXuzurLU17ErFUkdLLvHafzdyMdTNntJ3CC+QKZ8hW6UerFJsMajt3sJKCw7zhPuqmyrMmcw6qthqyGg32Evmf9CCVMfa7NMYWK7cEo2Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZafejnTu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2817C4CEF1;
	Fri, 12 Sep 2025 13:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757682775;
	bh=eGV2y5TFSFQkteHzHzoS4O4WMQxEMS72NLxJWUbTZMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZafejnTuVvUBdDciIeWJrJGIuYDL19u8Nk68tFOa/c25CVG50YB/7qPfg+mlTstrh
	 Ct1uWhdvXqAl+6BXY5knGfKcI+QHtf9yu+1Zro5NpNo0wKOHDn3gWF42rZO5m1ykyy
	 g5aaKkOHzOS5M7fAHpSO1u+7AaHSMOEliN/UIGaw4pCBU4I6ZrP+AwP+Zzip2YdB9I
	 AP4qTy+rNbaejRar3TOb+BafqeVYXqcdhdSiv64iOLNb1sgw/S+CBy0sUPnWqqW2C2
	 CKY+4AYOyojdCezpZX5FTCzV05mNkcNcP3SFih0AsGDG/ZRbEjvvo57qOIFze/oNWW
	 ZtPkUUYHT30xg==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Ling Xu <quic_lxu5@quicinc.com>,
	stable@kernel.org,
	Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 4/4] misc: fastrpc: Skip reference for DMA handles
Date: Fri, 12 Sep 2025 14:12:36 +0100
Message-ID: <20250912131236.303102-5-srini@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250912131236.303102-1-srini@kernel.org>
References: <20250912131236.303102-1-srini@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ling Xu <quic_lxu5@quicinc.com>

If multiple dma handles are passed with same fd over a remote call
the kernel driver takes a reference and expects that put for the
map will be called as many times to free the map. But DSP only
updates the fd one time in the fd list when the DSP refcount
goes to zero and hence kernel make put call only once for the
fd. This can cause SMMU fault issue as the same fd can be used
in future for some other call.

Fixes: 35a82b87135d ("misc: fastrpc: Add dma handle implementation")
Cc: stable@kernel.org
Co-developed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
---
 drivers/misc/fastrpc.c | 45 +++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index d950a179bff8..7eec907ed454 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -363,9 +363,8 @@ static int fastrpc_map_get(struct fastrpc_map *map)
 
 
 static int fastrpc_map_lookup(struct fastrpc_user *fl, int fd,
-			    struct fastrpc_map **ppmap, bool take_ref)
+			    struct fastrpc_map **ppmap)
 {
-	struct fastrpc_session_ctx *sess = fl->sctx;
 	struct fastrpc_map *map = NULL;
 	struct dma_buf *buf;
 	int ret = -ENOENT;
@@ -379,15 +378,6 @@ static int fastrpc_map_lookup(struct fastrpc_user *fl, int fd,
 		if (map->fd != fd || map->buf != buf)
 			continue;
 
-		if (take_ref) {
-			ret = fastrpc_map_get(map);
-			if (ret) {
-				dev_dbg(sess->dev, "%s: Failed to get map fd=%d ret=%d\n",
-					__func__, fd, ret);
-				break;
-			}
-		}
-
 		*ppmap = map;
 		ret = 0;
 		break;
@@ -757,7 +747,7 @@ static const struct dma_buf_ops fastrpc_dma_buf_ops = {
 	.release = fastrpc_release,
 };
 
-static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
+static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
 			      u64 len, u32 attr, struct fastrpc_map **ppmap)
 {
 	struct fastrpc_session_ctx *sess = fl->sctx;
@@ -766,9 +756,6 @@ static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
 	struct scatterlist *sgl = NULL;
 	int err = 0, sgl_index = 0;
 
-	if (!fastrpc_map_lookup(fl, fd, ppmap, true))
-		return 0;
-
 	map = kzalloc(sizeof(*map), GFP_KERNEL);
 	if (!map)
 		return -ENOMEM;
@@ -853,6 +840,24 @@ static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
 	return err;
 }
 
+static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
+			      u64 len, u32 attr, struct fastrpc_map **ppmap)
+{
+	struct fastrpc_session_ctx *sess = fl->sctx;
+	int err = 0;
+
+	if (!fastrpc_map_lookup(fl, fd, ppmap)) {
+		if (!fastrpc_map_get(*ppmap))
+			return 0;
+		dev_dbg(sess->dev, "%s: Failed to get map fd=%d\n",
+			__func__, fd);
+	}
+
+	err = fastrpc_map_attach(fl, fd, len, attr, ppmap);
+
+	return err;
+}
+
 /*
  * Fastrpc payload buffer with metadata looks like:
  *
@@ -925,8 +930,12 @@ static int fastrpc_create_maps(struct fastrpc_invoke_ctx *ctx)
 		    ctx->args[i].length == 0)
 			continue;
 
-		err = fastrpc_map_create(ctx->fl, ctx->args[i].fd,
-			 ctx->args[i].length, ctx->args[i].attr, &ctx->maps[i]);
+		if (i < ctx->nbufs)
+			err = fastrpc_map_create(ctx->fl, ctx->args[i].fd,
+				 ctx->args[i].length, ctx->args[i].attr, &ctx->maps[i]);
+		else
+			err = fastrpc_map_attach(ctx->fl, ctx->args[i].fd,
+				 ctx->args[i].length, ctx->args[i].attr, &ctx->maps[i]);
 		if (err) {
 			dev_err(dev, "Error Creating map %d\n", err);
 			return -EINVAL;
@@ -1116,7 +1125,7 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
 	for (i = 0; i < FASTRPC_MAX_FDLIST; i++) {
 		if (!fdlist[i])
 			break;
-		if (!fastrpc_map_lookup(fl, (int)fdlist[i], &mmap, false))
+		if (!fastrpc_map_lookup(fl, (int)fdlist[i], &mmap))
 			fastrpc_map_put(mmap);
 	}
 
-- 
2.50.0


