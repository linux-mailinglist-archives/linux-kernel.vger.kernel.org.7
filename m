Return-Path: <linux-kernel+bounces-814078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7037BB54EFC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DE941CC306B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA9A30F7E8;
	Fri, 12 Sep 2025 13:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyxZQlgk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB31330F550
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757682773; cv=none; b=SMd1hyo+hdtZ8N2N2Qv9vBquoPKqdPTf7QO2y2jQ8vyavw2h7zzh9fQni4z8mlGiDqmPGEpj4tXHM1Do8e29g5V4oHYyCoC2mUtsx22hndt30yvK5hftj+w8YhY3ZCfm20b94M+o9kTHRGIQMgDl1E2xhaUI2t2siOLSaH2K5/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757682773; c=relaxed/simple;
	bh=+xx2VY3aD/YgRxevcSVG/la82v/g8H19CdvdLzDejJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=io3bUW0AAMDN/admcchdWpChuH58jzPC1nBvsYlkC7S5GvNQQnm/Bxu2K+WowSqLBthYlTgmPHgniriy7BCuHDMuKEoN/yQtRmiwLttMVWMIOgdEyiL+CQCShBwfCXrkJOrnL/+6YpTSoBu+UNfey0RhxQbsF1NCTCl7CXXCBsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HyxZQlgk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31B3C4CEFA;
	Fri, 12 Sep 2025 13:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757682773;
	bh=+xx2VY3aD/YgRxevcSVG/la82v/g8H19CdvdLzDejJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HyxZQlgkH+gjGDyuFUxocvoglWbOdT5VBiJCmup57a48oLyxlR80XBEMY2LEuwLgI
	 NPbTdKf5bnwqbOeFY/KtqAhmLvSAIWzMohQokTetbDH71A6mvHiQAp8lJPqnffRHlW
	 Ck9dF5Z4jUOSeFpmswEE0VNuqEY+3i38nmURQFuuz5/LbvttWumdyeWuCkz/V5LChU
	 XQE2zSrEPFaBGcBgMwCRCIzldp4Gqk0IVcnNP3R2bwWA+dHhq8ga78VXfqwAiXLNUn
	 YWMPBbp1uNuhc9kgGJPFxubj9yr55nF1Q2mndDRUDL0RX5z2HlI0071OXYH54EBIH/
	 J5i2A5u/+Akng==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Ling Xu <quic_lxu5@quicinc.com>,
	stable@kernel.org,
	Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 3/4] misc: fastrpc: fix possible map leak in fastrpc_put_args
Date: Fri, 12 Sep 2025 14:12:35 +0100
Message-ID: <20250912131236.303102-4-srini@kernel.org>
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

copy_to_user() failure would cause an early return without cleaning up
the fdlist, which has been updated by the DSP. This could lead to map
leak. Fix this by redirecting to a cleanup path on failure, ensuring
that all mapped buffers are properly released before returning.

Fixes: c68cfb718c8f ("misc: fastrpc: Add support for context Invoke method")
Cc: stable@kernel.org
Co-developed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
---
 drivers/misc/fastrpc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 1815b1e0c607..d950a179bff8 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1085,6 +1085,7 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
 	struct fastrpc_phy_page *pages;
 	u64 *fdlist;
 	int i, inbufs, outbufs, handles;
+	int ret = 0;
 
 	inbufs = REMOTE_SCALARS_INBUFS(ctx->sc);
 	outbufs = REMOTE_SCALARS_OUTBUFS(ctx->sc);
@@ -1100,14 +1101,17 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
 			u64 len = rpra[i].buf.len;
 
 			if (!kernel) {
-				if (copy_to_user((void __user *)dst, src, len))
-					return -EFAULT;
+				if (copy_to_user((void __user *)dst, src, len)) {
+					ret = -EFAULT;
+					goto cleanup_fdlist;
+				}
 			} else {
 				memcpy(dst, src, len);
 			}
 		}
 	}
 
+cleanup_fdlist:
 	/* Clean up fdlist which is updated by DSP */
 	for (i = 0; i < FASTRPC_MAX_FDLIST; i++) {
 		if (!fdlist[i])
@@ -1116,7 +1120,7 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
 			fastrpc_map_put(mmap);
 	}
 
-	return 0;
+	return ret;
 }
 
 static int fastrpc_invoke_send(struct fastrpc_session_ctx *sctx,
-- 
2.50.0


