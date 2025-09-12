Return-Path: <linux-kernel+bounces-814077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D16B54EFB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C493D7C7BA2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8EE30F54A;
	Fri, 12 Sep 2025 13:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEsU7onV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E887B30EF90
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757682773; cv=none; b=jl4u4mSwL/5+7zkeEzdzHiswiY6obaU+b+FcIVt1cbxudnSbg/z02lHY+OqWY144Ql5Ft8XL9vOuhBGzeZwjM3EpKyyXfXJXjjkDybD2WrMX65luCe/AL90HpnU8x7bgxcQqvNWZMUfBDMqvdOVG65f9cpBQ1AcJJ5T5CUhqhBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757682773; c=relaxed/simple;
	bh=tdwo+nYVdYg7cQqJ6RkgwgBb8l3EtRx9h1/tdvcwODk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XqVksnkv8dvvsYMxEukTnWJJT14fQ8IlTCSCxMu5HAVnqRWtqcNYTYC6bFgiDk3enCcjletRBpj76LNAp0tXZVLUAh4qPkGLSYseAUNfkDm9xrXB0AFRMVgQb2aGvuJbpY6C2nfMDZ2gqxstgummOFtDBl6bmskVGxT2YFuU9D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEsU7onV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30984C4CEF1;
	Fri, 12 Sep 2025 13:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757682771;
	bh=tdwo+nYVdYg7cQqJ6RkgwgBb8l3EtRx9h1/tdvcwODk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IEsU7onVCQUb1Hfd450lYShrEII9Y5vT1s1wZMLomH7yTPE15pyw/CUe1qBa9YyPD
	 c63e6UYl95303xllOoGtcTdV66nhOGqrUMicxUw7GT6cH8Pd+yooScpv7wBXBAN8l+
	 PytEjrNcBPYMBONlk0IZulW9Xk8dAUiBiDZdwZxeB1eZNjQjpfnQP+LmWvhILHn6vs
	 aFXPffE1c0d15fK3jzre5zq/h3gcQoGc1ENal0ngLaCnt6ppXTLhelxtE7v0dCUbBO
	 GJI96smcQ0YGJ7zIcRRuTEyESmGL+QV9cV9j++l0uCMCEPYBK2Vt4MjDmc6cvT0pGI
	 a5JksJuDQ7QcA==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Ling Xu <quic_lxu5@quicinc.com>,
	stable@kernel.org,
	Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 2/4] misc: fastrpc: Fix fastrpc_map_lookup operation
Date: Fri, 12 Sep 2025 14:12:34 +0100
Message-ID: <20250912131236.303102-3-srini@kernel.org>
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

Fastrpc driver creates maps for user allocated fd buffers. Before
creating a new map, the map list is checked for any already existing
maps using map fd. Checking with just map fd is not sufficient as the
user can pass offsetted buffer with less size when the map is created
and then a larger size the next time which could result in memory
issues. Check for dma_buf object also when looking up for the map.

Fixes: c68cfb718c8f ("misc: fastrpc: Add support for context Invoke method")
Cc: stable@kernel.org
Co-developed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
---
 drivers/misc/fastrpc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 52571916acd4..1815b1e0c607 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -367,11 +367,16 @@ static int fastrpc_map_lookup(struct fastrpc_user *fl, int fd,
 {
 	struct fastrpc_session_ctx *sess = fl->sctx;
 	struct fastrpc_map *map = NULL;
+	struct dma_buf *buf;
 	int ret = -ENOENT;
 
+	buf = dma_buf_get(fd);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
 	spin_lock(&fl->lock);
 	list_for_each_entry(map, &fl->maps, node) {
-		if (map->fd != fd)
+		if (map->fd != fd || map->buf != buf)
 			continue;
 
 		if (take_ref) {
-- 
2.50.0


