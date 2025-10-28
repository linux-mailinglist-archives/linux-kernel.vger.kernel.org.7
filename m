Return-Path: <linux-kernel+bounces-874296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CAAC15FD5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AB7E1AA5685
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CE3346A0F;
	Tue, 28 Oct 2025 16:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNuUWFVP"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88019347FE2
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761670315; cv=none; b=BLAU4btuSf8kNZbm7Cye8QfyD0WLQji+8OplcDDtfijHGmAohcs5Lcf8PMpgXQmYtBbwKSrwkvv3m2gy+efvHFX8eI4e27CpUb8nzznhVqyhuosAcHqBL93lhQ3Ae4v05bKJ1senMLJmji2E7edeneqCqIuwxZ2hJu5QTho/NB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761670315; c=relaxed/simple;
	bh=8Bofhv76xiZ6SkaSp/xpBcxYedthlmIGe5RQkTkfBLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LlCL9ieSlEFQwTF3TzWNBEKb7iHivjUaL/RGQnxSsYxoaNmHCSJ9AeJO9Z9t84ukketFzBUohfCAeieqKATLtHuRNAaXBpa2rU46CoQ6kL/1744r5jdUdVADfNkbeKJLxL0WGl+H/p4MxINoP2F9KSNNrDfStcJPqh4h0dHbFwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNuUWFVP; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-27c369f8986so55884685ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761670312; x=1762275112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqGbM5vvwSaAdyr+kisx/6GyJLMoi/JUgGO1sEcNgzM=;
        b=gNuUWFVP3N2CrMMyOfEaL0txGchAhfKjdaojawQFq9ZvFE4Gzx1CDrcWr8Gn7ypgJD
         9BqsPdZnvmbTo/sDJEXiZYrQviiqe9x4buUPVZcwsB2q9aL0WbG0RBBjyKHxQmG6wq36
         bQuYhbH27gBYk8+amVDN4fEgYm8wGtgv+dB0XtElja1Lze1EPgAQJrU0b6RTrbmDYYe8
         I+4kjv/T6sjezUzKIfYBEGMWHaSzXGUnAjB7/GoNAzjvMQkxggF/E4iYuxEaLhQZhntd
         3g/PSWEu1CdIe21xL882PpeS/p2wm3Qal06Wd/9QcStWflEB/Id6P+L0xlndoISxKune
         WCUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761670312; x=1762275112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nqGbM5vvwSaAdyr+kisx/6GyJLMoi/JUgGO1sEcNgzM=;
        b=wrr8DbEcc4cAcQ0yojDdMxFjrrnp02FHx4lYdyA1kbveoPHVn68/kGf0S4ME4X8Rej
         52VsbZfOdNHTw42F2tyMWTEyx5/sqvbeAl/gexdvi5xOlPWlKJFzEcHJ+LIK8UMWUygT
         +8ivUT+N0gNYsX1ZbsjzBcQCsym5uL3nIW2umomSY9YFnfauTMpzTgFyP8FbVu2tjnkc
         Ct2casthzdlmaHsxTSZO3xc8fMTnEpfIeJz1VWoIddF3nTZmXM7xXWXR/QTwsvPJzRFx
         jiom9jphMEDYbhpm5bzt+VvOSrTdKPW9ux8dd71/gec/uLuEF+KwGgiRmwVwYCqFbV1i
         iMuA==
X-Forwarded-Encrypted: i=1; AJvYcCVwKysyFX3/BqnoMO/y2YJHcEhDDMJYn7EMx23SB221D8edSxNmzLOz0PKjl0isIWZxP3sPA3TTXDWqUMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV2nL9Ffp37iH03Ou7X9AJlNUPAawkNo+NUq9AE0MoWy2TzVAT
	qQ86VddYQplK9lM3WYRNT27ebIjVUG1rhbOFT1Zy46kcmVw3Y3hktMQo
X-Gm-Gg: ASbGncsE1atWEpdH2guAD0d5uKCbZQeI3ebJOVh/VcZszksqf4GvpUR8WHd/xggMe//
	J+X7jCpjZN97Y6G8bSkR9BjbRmDLAyR5ykKeQAx8M/+wmJIEfoMIkZaDWvYHO7EcxJaq/6CCVVV
	0A8b3/VC0zlL86mnEr5jdw0uNA4f5mFxkKuvVMwXOrpiylidfrseU43SCb5h4IYgXOnGDJBQ9U4
	sLxRakKEwFEnADhxLMWQK15b1FSfjnVy7lQiEiECmOyC0pHjgW+c0+7w8RCX1gq5hrSolaejv7K
	mHJYFKEI6seF6v7bhftEf7T22z+t4FZpXj3/7hmtpnHhzPs60CAPnpwW+4ovCdwRz+Lxp5DjCiT
	9llmELFb3pC1zm+LT4HFppJKZEXg3WiQMS/zv5m2dd+bmwtPSwOux4wQvz4YPTO8+SVeH8V/cHV
	Vkzz0xR/o27eFgUvs/fs/mBA==
X-Google-Smtp-Source: AGHT+IHwlx7UTwHMvwMgoePukjEkmehBzU+pJX/qbbUcV5S5wP0HYILyy8+Mz1GCKLEfOQitsWAwUQ==
X-Received: by 2002:a17:903:1248:b0:269:8f2e:e38 with SMTP id d9443c01a7336-294cb378634mr57410855ad.6.1761670312365;
        Tue, 28 Oct 2025 09:51:52 -0700 (PDT)
Received: from iku.. ([2401:4900:1c06:77f0:168f:479e:bf92:ce93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498f0be0esm122123665ad.96.2025.10.28.09.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 09:51:51 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 1/5] clk: renesas: r9a09g077: Propagate rate changes to parent clocks
Date: Tue, 28 Oct 2025 16:51:23 +0000
Message-ID: <20251028165127.991351-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251028165127.991351-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251028165127.991351-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add the CLK_SET_RATE_PARENT flag to divider clock registration so that rate
changes can propagate to parent clocks when needed. This allows the CPG
divider clocks to request rate adjustments from their parent, ensuring
correct frequency scaling and improved flexibility in clock rate selection.

Fixes: 065fe720eec6e ("clk: renesas: Add support for R9A09G077 SoC")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1-v2:
- New patch
---
 drivers/clk/renesas/r9a09g077-cpg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/renesas/r9a09g077-cpg.c b/drivers/clk/renesas/r9a09g077-cpg.c
index 8b7e84a4c307..1cb33c12234e 100644
--- a/drivers/clk/renesas/r9a09g077-cpg.c
+++ b/drivers/clk/renesas/r9a09g077-cpg.c
@@ -221,7 +221,7 @@ r9a09g077_cpg_div_clk_register(struct device *dev,
 
 	if (core->dtable)
 		clk_hw = clk_hw_register_divider_table(dev, core->name,
-						       parent_name, 0,
+						       parent_name, CLK_SET_RATE_PARENT,
 						       addr,
 						       GET_SHIFT(core->conf),
 						       GET_WIDTH(core->conf),
@@ -230,7 +230,7 @@ r9a09g077_cpg_div_clk_register(struct device *dev,
 						       &pub->rmw_lock);
 	else
 		clk_hw = clk_hw_register_divider(dev, core->name,
-						 parent_name, 0,
+						 parent_name, CLK_SET_RATE_PARENT,
 						 addr,
 						 GET_SHIFT(core->conf),
 						 GET_WIDTH(core->conf),
-- 
2.43.0


