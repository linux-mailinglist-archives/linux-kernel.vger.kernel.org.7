Return-Path: <linux-kernel+bounces-875365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EADC18C5F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D38D42675B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377633054D8;
	Wed, 29 Oct 2025 07:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGIyhXmR"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414212FB08F
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761724077; cv=none; b=oGWUDwF7OSTAlEzct1/TBqE0d41PPohl8X+e3NixXoz9aAk0Vt7mdCAT79P0auKcxEzIkWdBI8HWfV6WjNwIZdFMHXKbPWXGLgKEmHj1UzkbxA9oWOlYn639S+t5cLMW7edQNGr28JA21qPRgz43xcMW8bP2ZYJyfPBjns8pXx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761724077; c=relaxed/simple;
	bh=vgS5Mv2an7aW8L2hop7Xh6r0KWmtXcOo0+xl9hewdoo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ArrHjLWrOIMM5OjxPYTCfmOTXlh92Ve8ovCfbpAt6nqXlk4DqBQ9WtEQb+mD7ItgPksMU5VKdWeGOnDMXbKUyiEw2Vq3+Hl7jVnaFPPZi8az/ss4QtejpbBKAh7h2ZFb1ZeRb4/CaBZwYPRb2p6W0/iK5lEOLs+ql7h19wvEiPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGIyhXmR; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7a26ea3bf76so9146159b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761724075; x=1762328875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q30GbqlTwe2nQMX4UB7blFcjur++GRluVV4AWK8Q6Ek=;
        b=EGIyhXmR6beY7fmK664Aa5uFl8nBOaEstHj+1FEqaWRiVxX3hipJxLOa8bRfNmnmHq
         scI3I34+CqMKezwK8LNBTefOm0+2Sg0z7r8HYRAFaSXpP7gQsMBg4+m9lb3AjSBawi1V
         SqFddqL9Z9IWhuzCSRddXmAhM/hDwstBZDnKqrI7b5ZZC+ZcPuMGMqnIvyW0fIf1O14B
         SUDcOzIyBEZGJX5kkEo/RE6ojiMuDHhCLCV7MjVKl4MN+biFc7E36COE3vurmaKg8O3k
         mKJipqz0CjFXVtpx/yTJd07nPjbyFIfBPIE6gGYTPmqF2HOK7Mf2Kje0GC8VW0mPS/67
         Gzhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761724075; x=1762328875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q30GbqlTwe2nQMX4UB7blFcjur++GRluVV4AWK8Q6Ek=;
        b=wZxq3ne5SXydxfXDsQOzXuR/t6DXXoX1AudHTqUXXNFfqrgyKuL73G1kgw4Qd/897h
         dhERFyOt7pEK89OsuvlrsGwTpGc7opVlPaPBEDqEa1lcG1eVY2bY9o7wFJGCGMHEcnRG
         2TIxxlm5DcQSSAt9meVefWwXGoAPhhh1OIKplBJzPqRyTLkuSQ7iYj4u2geWdeGqwIk9
         HgR87CQqj9MaLSWXrXxtsyVnlXJKRm9w0koGvZ9s3KfO5AyBMT4efOaSKbIw5LxY628V
         j5ORQRTkZrWsYVyJxkbgC7HzOUS6ktJrLDY1oy2JrVaPapIg8LAhB9aaxrO11CZwJ3hj
         spAw==
X-Forwarded-Encrypted: i=1; AJvYcCX4HKakEgPGLWNaewNMBdqv6UGSZ7qBXHCGuNglef+e7lNy5JxNmFwim3MyJhRvgQUsSUHg4kib3DH5MYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWfbr/gr/ZLyVEDnFyAvqGCYUALCTkKPq1YPBi+PeXVYo3tD6G
	djCxJMh6A0FEp3nKVTtzSBREcaEFeE598hmxTzKWCGIVBDxETzDEWppP
X-Gm-Gg: ASbGncvQHRmEhKphcbiaMT/pzr4lzCVfXkxZ0ZFOde5fwzzDLkZSTibkg3sM7ZuMzwZ
	OsftTqbvYNwYtCXnye8ZK1tmw16D0GMnCAo1MDpu0cL/ZCiXF3pV1mnI0ewr0ndpAUUqmiCqggG
	gpK1x106guZB/VjVGN979A6Fyy4aKzv8DuuxEMfvVe2lIafnndsmp7+rFjiligpbmDCt0RO2zi1
	k4TgeacExLKN6mFiypLQzcjvClwArxWKnjb1XNU3WLpuNVJtA6YnzoWKic9q+YRee/onV6denVU
	QOxm4Weaj5hir/JhrW71jEVoy/2KqSnVUkjSfl6oXlNokdC1zielU1JBrYjloKd7TzqpyCazQk5
	VovJrQPEzMbQUBn4Xd6VBtkmTlf8yACm6K+462reaT3I99u7notXXc6NIpwamG5Dp3Ma/XoACdx
	P4cwewPrxOuUXpmW/H5e58aA==
X-Google-Smtp-Source: AGHT+IFuC13ebf9tUyrUJPnxA/BVzsjUbwXpoTRR8n0eYfWFABlmJzwguFPrChLih2199JwTZmChYQ==
X-Received: by 2002:a62:e90c:0:b0:77f:50df:df36 with SMTP id d2e1a72fcca58-7a4e4c1ce32mr2077224b3a.18.1761724075412;
        Wed, 29 Oct 2025 00:47:55 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7a41408c4dfsm14201813b3a.65.2025.10.29.00.47.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Oct 2025 00:47:55 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Wadim Egorov <w.egorov@phytec.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] drm/bridge: sii902x: Fix device node reference leak sii902x_probe
Date: Wed, 29 Oct 2025 15:47:36 +0800
Message-Id: <20251029074737.18282-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_graph_get_endpoint_by_regs() gets a reference to the endpoint node
to read the "bus-width" property but fails to call of_node_put()
to release the reference, causing a reference count leak.

Add the missing of_node_put() call to fix this.

Found via static analysis and code review.

Fixes: d284ccd8588c ("drm/bridge: sii902x: Set input bus format based on bus-width")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/bridge/sii902x.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index d537b1d036fb..3a247ac3c7dd 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -1189,8 +1189,10 @@ static int sii902x_probe(struct i2c_client *client)
 
 	sii902x->bus_width = 24;
 	endpoint = of_graph_get_endpoint_by_regs(dev->of_node, 0, -1);
-	if (endpoint)
+	if (endpoint) {
 		of_property_read_u32(endpoint, "bus-width", &sii902x->bus_width);
+		of_node_put(endpoint);
+	}
 
 	endpoint = of_graph_get_endpoint_by_regs(dev->of_node, 1, -1);
 	if (endpoint) {
-- 
2.39.5 (Apple Git-154)


