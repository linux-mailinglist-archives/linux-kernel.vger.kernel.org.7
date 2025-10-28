Return-Path: <linux-kernel+bounces-874298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AB41DC15F63
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 750F7342CF4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168EA28980A;
	Tue, 28 Oct 2025 16:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBDswHIi"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83F63469E7
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761670328; cv=none; b=bOQbc5PgqnEA3vOgRUNQIwvLfS+N+NELGTEDsz7wM34YyTXz2wc8MqufEYD4mXKRSVZzs/y7qVYrlzuiEg3WOsLfZH63Y6BG7NvmRwOLpgnysnnaD5o0+sIhP0cY/aoeGMHkXA9fhTvbPeIhfESsBKlSWdTZHocuVDR8CzJNUQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761670328; c=relaxed/simple;
	bh=uAi2FHcWsJ3GX+mStHxzc2rrz7IQpZYtqIP74XffftE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i48BQKBXeXm5hev29J9syGUeGYxLqaAeXo2GHgrWMBOgVq7IxTmHByx3VeAF2aOuMWmlwPmhEIH6JMiq7bhOvvIl6oZNkM4QFuTqQ4TDEGjyB81NyvNn8l2aQvNxn1aQMd+CzwwNe/t/RLC9MWY9AuM/U75OlpwVxm4sKDIppA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBDswHIi; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b6cfffbb1e3so4528506a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761670325; x=1762275125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozhuagEONZfNxkbetsUDydMVsoqSUlAvk99bJ1oqkyE=;
        b=VBDswHIikAYS2q0DgNT6jElJeM8Tn4FQ7TG5FDNH5dlPJSmbWYSFpH+8UzamC+Grwa
         7zECYJ6zkBJ5LL7jKlSo5sSMtHNuZ9YBWMa+IycOp9PX/ye9nig7879/XMRyii81g2e8
         Z+ujwtzreE3lvFkPAyeTdgpELJ1RmsG0O9quDHapWU44hV8/rYLKmtEOT2W8c7DxE1W2
         MiD7VqliDv+qqrkTQCYQP8oGjJHElrxEqAqMwJ7a1UMBLnhUMYY1KDDAYLygJhU6Tark
         j5tLzCQhMReRF3B7Ic5WWJ5+dzYX+XUMyONO8bw/OJ2iwHknj4fz2RxBg+0co99nzPRR
         Z99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761670325; x=1762275125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ozhuagEONZfNxkbetsUDydMVsoqSUlAvk99bJ1oqkyE=;
        b=t6wsmXjamAEDCkMuZKbU1YKL/rOlKi6xhq9XFIH+jiu51SMmZsekSG7vvgSySR6bgq
         WUMSv+CnzgPUOocpKUDqDGXpSsjfTNetI1AV67D5YzUkxzyu8u7ly/nOek6DhUAtCKMW
         chb9hcXNMofaPYRrpbydm0aExFQo8l8RyP18pULMChZFdANsv0sej1deGfcDGdwJYriF
         OWG9aylulalor9+1PhnzZomibu1+3FGrg3OmEDT1QAan5iHwk7xysnQrnffR2oVxzIJm
         IDVA+GjxRLBVImPUsh1a5QmLYhUHAgJDEy4K+fkGw2H7qye+HKsP6VxBadnSaSI9/iEt
         9cTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLPM+v0OyVE9XUhShDYWy3FIOgVxBVgTWEcJOVL7uRAOvPTIZ0Gbx/IpMiDjxFsToG68g6YDN5Wi6JHlM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt1NZARWoTcFqoC8MQQcG2HDGMcP+Nwuo+wNLOzMI4TRKaWIkk
	k8kevQwvZo+1uEwD/wgMMRhSATxr+e+HbnlYgZQs22Ui6EyK9Ky/cHno
X-Gm-Gg: ASbGncttvoFW7C8+srgUJMjxw7SSyd9+MgLCPHbv6RsFAHKLErl+AWJpGjvBNvph3HM
	Ur9C4+T1+forujKD10ZnIfN02FAZ5j1G3BEeLhNzYDqk8ICZL6WsAikBrLAMCblPI+u//yGsqsv
	LzrzUnxEeQdQgIq/L+GtKIHEaWJ7xCS4R4ePc3KYl4sCeSgWHXUy56+bwYqQufNQ7qTwrEjuYVC
	vpDL+AyoDoszEeb5TpZ/VsryAbjD8nBeSCfqIEQ4F5k5PRdnCY4bIkYenQ/qqRMS5r7zCtGhN4c
	VsYaQ8/lbECIaZxRGm6Byk+jTuFG0IRh4IwWlOzZ0N6znSIZITrKkAe4BHtEF9Wq+OHdGA5nImJ
	P1WBa1+LzhtMbeXEhBV559i7RiYOVltC5+Hb+LS1UhzUL0rk2USWyIPiJLlHN6247ttvbIvlonX
	iiU5l6MR/vrbPuCCCVjyX5jA==
X-Google-Smtp-Source: AGHT+IH8qFlYrrL24sCRWgUP6EN5lsSkXhcAlMQevGU1F8wGdL4QnVY/o2LpJYNhO1zLzXrVH+kFBQ==
X-Received: by 2002:a17:902:d2c1:b0:292:dca8:c140 with SMTP id d9443c01a7336-294cb6739b3mr50494845ad.44.1761670324753;
        Tue, 28 Oct 2025 09:52:04 -0700 (PDT)
Received: from iku.. ([2401:4900:1c06:77f0:168f:479e:bf92:ce93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498f0be0esm122123665ad.96.2025.10.28.09.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 09:52:04 -0700 (PDT)
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
Subject: [PATCH v2 3/5] clk: renesas: r9a09g077: Use devm_ helpers for divider clock registration
Date: Tue, 28 Oct 2025 16:51:25 +0000
Message-ID: <20251028165127.991351-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Convert the divider clock registration in the R9A09G077 CPG driver to use
device-managed (devm_) helper functions.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1-v2:
- New patch
---
 drivers/clk/renesas/r9a09g077-cpg.c | 30 +++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/renesas/r9a09g077-cpg.c b/drivers/clk/renesas/r9a09g077-cpg.c
index 666fc16b9a81..b46167d42084 100644
--- a/drivers/clk/renesas/r9a09g077-cpg.c
+++ b/drivers/clk/renesas/r9a09g077-cpg.c
@@ -220,21 +220,23 @@ r9a09g077_cpg_div_clk_register(struct device *dev,
 	parent_name = __clk_get_name(parent);
 
 	if (core->dtable)
-		clk_hw = clk_hw_register_divider_table(dev, core->name,
-						       parent_name, CLK_SET_RATE_PARENT,
-						       addr,
-						       GET_SHIFT(core->conf),
-						       GET_WIDTH(core->conf),
-						       core->flag,
-						       core->dtable,
-						       &pub->rmw_lock);
+		clk_hw = devm_clk_hw_register_divider_table(dev, core->name,
+							    parent_name,
+							    CLK_SET_RATE_PARENT,
+							    addr,
+							    GET_SHIFT(core->conf),
+							    GET_WIDTH(core->conf),
+							    core->flag,
+							    core->dtable,
+							    &pub->rmw_lock);
 	else
-		clk_hw = clk_hw_register_divider(dev, core->name,
-						 parent_name, CLK_SET_RATE_PARENT,
-						 addr,
-						 GET_SHIFT(core->conf),
-						 GET_WIDTH(core->conf),
-						 core->flag, &pub->rmw_lock);
+		clk_hw = devm_clk_hw_register_divider(dev, core->name,
+						      parent_name,
+						      CLK_SET_RATE_PARENT,
+						      addr,
+						      GET_SHIFT(core->conf),
+						      GET_WIDTH(core->conf),
+						      core->flag, &pub->rmw_lock);
 
 	if (IS_ERR(clk_hw))
 		return ERR_CAST(clk_hw);
-- 
2.43.0


