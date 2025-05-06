Return-Path: <linux-kernel+bounces-633615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BABEAAA84C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 02:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28B714653A1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 00:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6DE34BA25;
	Mon,  5 May 2025 22:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g093yXm4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D20A34BA0A;
	Mon,  5 May 2025 22:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484780; cv=none; b=uha6HtbzfcXBLwbXeQd+o6idFvAbuNWFB9IeF7vDgXhoDW3FF9s8Xkz3EEo8Vm5KwFMvZBvb7+vSukbtGV6ncYZSKEKjF/+N6DvasoRucSW/akSiakKdV1C0mXu1z+Az57sssxK3CH5MPOFdjcP+qiiOxsa448/QLRS/MkLmKIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484780; c=relaxed/simple;
	bh=MPVCttLUZ6Z5MP4A3tCxoU+d/xL1p3APePi299j9y8c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uWsen5R3li+FRp8OOKVzu35p/4IAMtsUm6p1LJUdOxwMuVH6OrBYmNNJd+GKKzGPy4pQj0jGBPYlv9IxaQC0zRedKWxWSvgZEZKSo95xPEKvtg48sKnxagvYkVNSC1bw7SjX74AVuN5jlbKCR6znLKQstbG8aOKRm/61vDPbJtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g093yXm4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0FFC4AF0C;
	Mon,  5 May 2025 22:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484780;
	bh=MPVCttLUZ6Z5MP4A3tCxoU+d/xL1p3APePi299j9y8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g093yXm4mARMS2IcDJCM02g2NLQb/MKyYUpoidTLtnzwH/rw3XujaT542vxOBBbt+
	 ZqBuT8xENzPTHejOd9sjXbMCrNtrmudsf57StjEkF0Gsek6v1MiXR0cF8rHJbK/qKc
	 QjWqZUaJzhsgSj4FTgsIIdPAhUsqlNNvf5rJTkuO/kuaVQ4IOqlZWJZG4Ee0MkCBdJ
	 0WNYMcpOrEQT7/Yj4KfVtDTuhv1yTi+mxjVo0RaAIMmQiK+iD1ysLuw+s4MnNLobRg
	 KUm1OfAdKrf2tqHkEInUOUJZ07CHuvjq7M3FmKiUHTRPqUychfDiIDUuZMggcVKt3u
	 J34e78sIjJ0IQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	io-uring@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 010/486] io_uring/msg: initialise msg request opcode
Date: Mon,  5 May 2025 18:31:26 -0400
Message-Id: <20250505223922.2682012-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Pavel Begunkov <asml.silence@gmail.com>

[ Upstream commit 9cc0bbdaba2a66ad90bc6ce45163b7745baffe98 ]

It's risky to have msg request opcode set to garbage, so at least
initialise it to nop. Later we might want to add a user inaccessible
opcode for such cases.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://lore.kernel.org/r/9afe650fcb348414a4529d89f52eb8969ba06efd.1743190078.git.asml.silence@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/msg_ring.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/io_uring/msg_ring.c b/io_uring/msg_ring.c
index 7fd9badcfaf81..35b1b585e9cbe 100644
--- a/io_uring/msg_ring.c
+++ b/io_uring/msg_ring.c
@@ -94,6 +94,7 @@ static int io_msg_remote_post(struct io_ring_ctx *ctx, struct io_kiocb *req,
 		kmem_cache_free(req_cachep, req);
 		return -EOWNERDEAD;
 	}
+	req->opcode = IORING_OP_NOP;
 	req->cqe.user_data = user_data;
 	io_req_set_res(req, res, cflags);
 	percpu_ref_get(&ctx->refs);
-- 
2.39.5


