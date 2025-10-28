Return-Path: <linux-kernel+bounces-872973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C86C12BB2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 04:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C89A588153
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 03:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C28277C96;
	Tue, 28 Oct 2025 03:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lv9fGlCp"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31B311713
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761621401; cv=none; b=Oaq+fSe+U61EIbm4kln3EgggSsT+ALogVfjXMIoy/2wwNtSiW+HOxwyFm85A7g2fZKOntbD7OOYktQTPBCiwHlfR9SEnArVnh5g2dmkx/SDPd4ZfUv/bYskJ1B7cKco7tcmikxWqd4VXYDkth8rJPF5T/DDceDHowdXzGezg/28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761621401; c=relaxed/simple;
	bh=cHHkD30AaxNGfUjFD9KtWlH0G5zDyjXDYQiWrVKJSIE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QPXLd+ntTmRvM4VDCK0QTS9dRqEFZA59yNWROTPkNsB+/iPoszz4dmSi5FNqLiOUimNGBCzJpTTB+txm0xO8mv5dCBFyZ3I6epy/aLWJYwMbwJpb4e4ikmW28Y+IOLEtZPeb3acq8QAnKVVxYccViOOZroXx/qb5foD+pJQg1NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lv9fGlCp; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7833765433cso6818618b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 20:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761621399; x=1762226199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q7Dr88n0rsMeY0SbLXIpFyJggBzx8goTlgYQ7zbZXXM=;
        b=Lv9fGlCpfXzsi6PkQ0jGtnCEf6t0rev5XwPG5y0I4hHwY/Y4ImeoGsil/3jeKiJygC
         ovZuqV4YvhZQrD3ILzoS/sMiLFwLBpjKd5Brcu6N9LJhbKXh9+O6bht+vOlRRIJ+znef
         JUR7wPR8aSUT/bbevN9Qi1Gb5PjPx81Y0UHNzXpnfEOqa/ttjrxHbVDY5qFc7ZQ9QL+Y
         zV1tWc410U4XxTdojpFIvWviPsiRIDuAC3qR+GSqOfMd23964ciyz41sI6upV07lTmDq
         xXcgEhhNLsS+id6X7A9yqhsnsOQ5GdoiKZkorcpVeDxgQ2IWQKFCZ843FlL/HlxoDH17
         AXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761621399; x=1762226199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q7Dr88n0rsMeY0SbLXIpFyJggBzx8goTlgYQ7zbZXXM=;
        b=CH2WagtiET6IgF/IbMqiJ55w677xP0SXtBlaG0b5ivgYABu+JYj3rfp9rhALxhgUQf
         2NY2lz0PvTBcn+aQ7AVu+m54eFPiKZC344DVpdssC863v+NTgz/n97sSjh4gZFEqZrXe
         4D5ahxnG8NNN9jtATB8DbxZT+kxoe+tUwso4GgSOp/y0bG1ZIRHXoJsvLK5Ovn9rVD1G
         OUeOr6p90zs5501SxFzyoTpU3IcHEunRfUwpIbDXTp0VALEAP37D6P1n5J5qcGZDHgmZ
         YzQ0W3YT7wEF5IpKBYP1/hb1InQOwmAkebjH7Tm0FbtcPcvljGTFoiDSe9b7KQB5+lBz
         UvmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ21urnxM1230Te87aqoypcI6CGYhCtTcKepGZXgPgMRz/sJDLvV/Cm915OcNkePD7/RKEZBYJuAWNKBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDY5+LsyR+L1SYhd1Kr3Dv9b4fyuB3DQiGdY5ZwBwrTFBKI/mb
	VNsYyrainGFiuQahuYBu100+IGYm+yAbNnCHXN1NQQLKfGRzb8N01ivhk8GwWLIHK5Q2LA==
X-Gm-Gg: ASbGncunfRlLgejiQAdfYXnAt4aUQjmWoRcqEzLES2S+lDm42qtHbPcgkoxLekrQbM5
	Dx/U5F612Lljqn7sdUlFMf2txbgRd/5w13kIQEqkv0dqybr4JBcEvf1wt+S2fHM0HrSchc8BaNv
	7iAs0TTFg34oEZF0KVZDonTNXXpcp4uDsNEu5IrJytXGWMfBYVA8DeNWLn9JthI5+1j8BAgabvh
	NZQk7eRD/gPZCFQRq09yBEQGmmiu/YZNFWyfTWecFNDmuLifYuecQ4W+ayGfd/FzoRzByCsANe5
	csYvgQuSs64+bDb+s7bO/gN+HrC2ZhZTjLzkGKrSR+4pYOWF2gF10Y4gSZnS5UBx1wlPZTXL3/D
	uoBhhKa6UgNNTJzAfvirmYPbwP60cKGyFMbm0hdsWlHu3h0WizCUoFD8Ak8usRKrOntz5hsCr4M
	DrUIuNwHJAHt3q9G50g8q8Sw==
X-Google-Smtp-Source: AGHT+IGeeElAGdz52QvzDON6TZ6X2VN+9KdN3tRsb9MvpzKrX+azsLuImQoCuSHnyIB4CWg/XHY7mQ==
X-Received: by 2002:a05:6a00:c8d:b0:7a2:6b48:5359 with SMTP id d2e1a72fcca58-7a441c46a7cmr2594121b3a.24.1761621399271;
        Mon, 27 Oct 2025 20:16:39 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7a41408c4dfsm9818276b3a.65.2025.10.27.20.16.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Oct 2025 20:16:38 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] soc: imx: gpc: fix reference count leak in imx_gpc_remove
Date: Tue, 28 Oct 2025 11:16:20 +0800
Message-Id: <20251028031623.43284-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_get_child_by_name() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: 721cabf6c660 ("soc: imx: move PGC handling to a new GPC driver")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/pmdomain/imx/gpc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
index 33991f3c6b55..a34b260274f7 100644
--- a/drivers/pmdomain/imx/gpc.c
+++ b/drivers/pmdomain/imx/gpc.c
@@ -536,6 +536,8 @@ static void imx_gpc_remove(struct platform_device *pdev)
 			return;
 		}
 	}
+
+	of_node_put(pgc_node);
 }
 
 static struct platform_driver imx_gpc_driver = {
-- 
2.39.5 (Apple Git-154)


