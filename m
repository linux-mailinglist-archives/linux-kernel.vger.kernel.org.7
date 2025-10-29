Return-Path: <linux-kernel+bounces-875366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 388F5C18C7C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFDD818987C0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACBE30CD8D;
	Wed, 29 Oct 2025 07:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLPvLioi"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E640D2FB08F
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761724169; cv=none; b=cnpyH8DzhwKDig4cDSbWLBOQi5EhxkyaTlXic+2b1BWQPNKUbT0IXrjPBNnBEaKJBTC5gMyOAYHLt6lTaikkN852Mx3jGOKqYL57Q1aTFfQ9mB61kqcf1CtrBdSPDIb54aK1ldWJ93sA1vhpm31+mY6HjhuqfhIwVOsCkvZZGNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761724169; c=relaxed/simple;
	bh=1GaD607Sv/bHk2ImqjRGCbXa2CMQD2Ts9MTofIV/RBw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YpE5sOmK3sBBHo0mOPAi0rkCAU626k3t5AePyrCy5HMU4k6WJFyQ8qdQyjWujjox41zhgf/qYx34qVnM+XEc/qo+cTqHOklPr9h0yi/BaDvggDKVtQCVUmclT3/tU3macOK3H5OV9hZHfNIC1lzusr/Qitx3Owq4n6urUf6jMYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLPvLioi; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-793021f348fso6170226b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761724167; x=1762328967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4RLA/DGKm3EXMzePk9BvP8NDtl/YaS8WddbAf4crKqY=;
        b=VLPvLioib32raB3ikPJFEP9NE1vwcEQy41fV4lNGkxox2BPyjHqJT20fgnjuNtR/7o
         BC/tuEWTgcv8OQ1+vsYOo+P6W4BAqRHTN/div523QeUt3HqAWuFrgPLaHhyT5x8rTWMx
         lofi6/wANJpHGGPo0UOrWbfB5Z5AcFlD9R/+FDSud2U/ufopmpzLK9gvxw90b0Hck8+L
         N8fQb2i9dSBh9OP7arnV9JnwXrNNp8L9/FU8nwRISzoD+xHTTlZECvibX1k1bqU3Gx56
         A/M9QOG6y9My93X1SEC8e44bjmpbq36z3L3Z2yMqBRdow7sac5Ton8vmXt0oWgx90evi
         6oAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761724167; x=1762328967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4RLA/DGKm3EXMzePk9BvP8NDtl/YaS8WddbAf4crKqY=;
        b=CR5eBp+3hSNzxfzU3blUW/ux4bBQdPWRFbzB0I8Na0Ea1HxCu1BQ7okRi4UdPgXfMW
         mgkq5L5f5yrBaktRWgGEP4w/c9RWqbJPNE32fHXPz1JT1T3+AguJewGEU9VM4d48CtOR
         5oBYl9Hp9WwwVNpkO2vPXbChxu6RAim2Z8TfRIUpTl86M0TF0Bw28UVzoUPSV28XnYWe
         rRYtsHYYrzI0TAwZP4h2cTqgeXDGzNBb4VnlBWOaWQEvEwMlk6Zx1sOpiMgN/v399JH2
         yi6a2D2hMwKipuUvu3WhJEmQByMzoOcszNA4bmZ/4zPiETb9E7eyhvKV5LfE8eq0C9Fy
         IC5w==
X-Forwarded-Encrypted: i=1; AJvYcCXM/3DlxcA77i3mCbo+7Zpx6oF/QCdwFZO6KHIpNT+yKdk+SUuPCV8zNFP0gMeISEDhjoljSMz4KHZTwYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxYVa3HAqhJCp1mw+puHMeAd5liW5fxyiE9gU2/MTN4DHOMuDZ
	n0nRYXcM43IQahC27CaEjD5TCxQYo8oDoKP+QFQX75onapvFyza2HqEV
X-Gm-Gg: ASbGncuRW+0UFwliXCts/4xUhYlnp8A4Nk8ZwMRd/3PGycDnlB4iMPn9B2aDoG/WYnm
	mpVTBFQhY5HjFnieuZkUwkxyN6a26/VecwzDEoZKIDZgGac7TxrwI74Xppsas7ivCz79bkxru/7
	EY6oBamGaCDTCKH2u2GsvqabnWLetcTh1F59VVgXvu1SMIgjb8cXgSGo/85IUOXr4Se3sQW2/f/
	JZhT4vw+8Q9ZDrWwExRPtyg/zN028UqZn5XennyQxIw8hlcI3qDZPiEGXsdTc1sZsA7ek8+FApw
	ndECqqkyWnRwQRbrcACSfe2ww3eHNvyPtHKdVMFV90dZ3AfWmA2IQ0B+aLczplKEqkBEPLj8s4B
	Mrfr5e4Z/Pou+owDQCa9A33X45MKyz4GXawt54w5m6Zyow5uSDsp+EagVcDscFM6OCZw5IGFc+W
	nVp6tGimvX6sxa6PLOXzckcw==
X-Google-Smtp-Source: AGHT+IEjGFYHvTA0394tCrKBxDkPiihw2m2Mpe1BSWvzEwpLa5iv/ijoEfCshocB13qZhqbfk34Zvg==
X-Received: by 2002:a05:6a00:4907:b0:7a4:f552:b524 with SMTP id d2e1a72fcca58-7a4f552b7d3mr1920900b3a.28.1761724166997;
        Wed, 29 Oct 2025 00:49:26 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7a41404dddcsm14151864b3a.38.2025.10.29.00.49.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Oct 2025 00:49:26 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Maxime Ripard <mripard@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] drm/sun4i: Fix device node reference leak in sun4i_tcon_of_get_id_from_port
Date: Wed, 29 Oct 2025 15:49:10 +0800
Message-Id: <20251029074911.19265-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a device node reference leak where the remote endpoint node obtained
by of_graph_get_remote_endpoint() was not being properly released.

Add of_node_put() calls after of_property_read_u32() to fix this.

Fixes: e8d5bbf7f4c4 ("drm/sun4i: tcon: get TCON ID and matching engine with remote endpoint ID")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 960e83c8291d..9214769a2857 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -970,6 +970,7 @@ static int sun4i_tcon_of_get_id_from_port(struct device_node *port)
 			continue;
 
 		ret = of_property_read_u32(remote, "reg", &reg);
+		of_node_put(remote);
 		if (ret)
 			continue;
 
-- 
2.39.5 (Apple Git-154)


