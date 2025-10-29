Return-Path: <linux-kernel+bounces-876738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE16C1C7D1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D2B8662AD9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4CD3502AD;
	Wed, 29 Oct 2025 16:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ly00Kxs6"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E176034C9A6
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761755638; cv=none; b=CeolDgvxAKAJBbcAU5mNz9KbffaSMCDewus9sezbp0qQGOZPgunwv2SVXMDEE0BB/eN+NCCcVH8oyw79gODUc9lZnUAOrCIyUFOl+sGugPDclrqgCSYN0xIyBehbUGPcW60SDEtL0Xs0SvmoZ2SypQxmaK44f4B1+blivz/vkco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761755638; c=relaxed/simple;
	bh=oprYoP8yymfB2u4RbgujgsNH+i0ZQOd4dygbCg75p/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LBsUOvUoHjx45WZ09t5DyaEp72NQ8uPnMYkoYkH6Z+R6ON+zMIF8ZpYgjuYEls7Jnr+/rR4pNzp8/sUKKjM8KUqDcMOEQkKF9+i2kPu8DB9k7wYLQMpNPnajTTFXBkwSmJEeBfwlVkq97GYD2rn4ZOS48OLHsg7nIWCOewvL464=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ly00Kxs6; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b50206773adso246092466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761755634; x=1762360434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D7niwucTDN3MnvT2f7z1+zCVDCBNmgQwG7r5182Kk6g=;
        b=ly00Kxs6I33Cts0szvsBGq4htnfjRKgDLfJgp+irQhH6eKg2aQ+FeYSXrktnVcZglE
         LS1X8DzpiRogsiDYx1QlAxeVNlePirHa2e0t8myHtbCX7sceXUAroMRjnaP7pZtJAbGa
         ZQzZ7QGt9Cgzf9F2250kNiJs2S8eGvhA39TaZ7wBXvUJagjjHROm1FCFEM7ezV7ijWgH
         yYqbR7ZF6gG5NFwzSbTizMHnnb6tYgQvX8/iw3UfEgYviyLxh7pJ1sBtoXpBN5ZZsY3J
         VUAZn8FHew4EfgiHNxME1+S8wmyvm3kKigBup4ENf8sONeuxDxeoy2tUw78yc1EHNZon
         eVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761755634; x=1762360434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D7niwucTDN3MnvT2f7z1+zCVDCBNmgQwG7r5182Kk6g=;
        b=mW5Ist+OaS7eZPiupR9vylTG8wFETLNMnTbf9XuZsQ0pF6huT+l/zI8hNbfMsJVUZ8
         klLFAmS/cNH5fPDLE748kkgEeeWV1wv74b2JkJ5RJ7u3iRnhNmdiSYhwBW7yrB7CKPOn
         /uhrt5QS6kUTQPzp5rFjl98Bv1zLgR7Eio9+nxkBEUJIH5AlSBjICuvMPNYw6QdMnJLd
         FzsimJpl8HkRuq57kC1VA58yL+UBLoxYhch1GMB7xYbd8PH2JtTgGeJ6tv/JEc4ol0pO
         ssHWbFFQn1lNH8zAfDH5cWB6jY3whU+e+St42h5ijlUY4IOfj+LDtXze2TzwK4ISe2A8
         hEZg==
X-Forwarded-Encrypted: i=1; AJvYcCXKqq4p9T9IfIvEXARz2XBFql3gFXX9xQga7SUhWI8FrVtKzF5NrbLcVTRDo2Wf9aDuaGlovC35gtx+veY=@vger.kernel.org
X-Gm-Message-State: AOJu0YywjwKdbmCrWKAP3Ji27DPYHLAl7NC0DaHSF/1Vbbv2QEPgPT3+
	4eghUT4RIa23NcahEZ2NlZQ82EapsSb81gYihqxd7DNewAeEVnju58hU
X-Gm-Gg: ASbGncu52ukDWdLmwYrBTo8DGD37z0v1F7l7uU1MZrU3p0Yqp2PyXUof4ixfbRWxFM5
	1+SZyNS5cI2vTj0TyMu/QGxbQFgwyeAVUS+xcAzByxgFhyLsxqPMvuD+1kiRtFgsFYH6DPhDNw3
	o2eGwg2h+sffih2kY3cZpQX1akYBBCJ77hOEfHMQ8GopgJ2JW+JV4rCmwVAtcDJ9QeUjXreq6B3
	3hLvHLbzvFHr9oobCaOUzkZW9JpPnUFiWzfnvrJ74T19XP7geK4s0vrdxIrrmzTEu3XT6sGSW54
	S8kTqrSTC7wb+XKPqIpK4+5LIRCm2nJYqroRdXgvyWzp+i/rYSuXqEtZUscSC78VkTmuJBwItPK
	aLeWRPBZX2QO2CZUEAUp/VRe7Xz3BTl2+CX0rOWhJG836ZsQfSDp+9GrS8Tiza83S0jSAsH2XFz
	6OI5EPdfIVampj37S/rCh5rrBnvjHolPmBTM/RpdbfKlP/Qv/FX9xt3TGTLEOTQ5lzBCWp
X-Google-Smtp-Source: AGHT+IGxst0GGPbE3zlpzuYvmZD7MtT+fgNns/2gbspQBUcAcExwpAJ9gNyBIh9hmr+9IwgchPtgzg==
X-Received: by 2002:a17:906:6a21:b0:b3f:f6d:1d9e with SMTP id a640c23a62f3a-b7051f278acmr28890666b.6.1761755633985;
        Wed, 29 Oct 2025 09:33:53 -0700 (PDT)
Received: from localhost (p200300e41f274600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f27:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b6d853696a3sm1468789266b.27.2025.10.29.09.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 09:33:52 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-mips@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/7] clk: mvebu: Use contextual data instead of global variable
Date: Wed, 29 Oct 2025 17:33:34 +0100
Message-ID: <20251029163336.2785270-6-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029163336.2785270-1-thierry.reding@gmail.com>
References: <20251029163336.2785270-1-thierry.reding@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thierry Reding <treding@nvidia.com>

Pass the driver-specific data via the syscore struct and use it in the
syscore ops.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v3:
- adjust for API changes and update commit message

 drivers/clk/mvebu/common.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/mvebu/common.c b/drivers/clk/mvebu/common.c
index 5adbbd91a6db..8797de93472c 100644
--- a/drivers/clk/mvebu/common.c
+++ b/drivers/clk/mvebu/common.c
@@ -189,6 +189,7 @@ void __init mvebu_coreclk_setup(struct device_node *np,
 DEFINE_SPINLOCK(ctrl_gating_lock);
 
 struct clk_gating_ctrl {
+	struct syscore syscore;
 	spinlock_t *lock;
 	struct clk **gates;
 	int num_gates;
@@ -196,11 +197,10 @@ struct clk_gating_ctrl {
 	u32 saved_reg;
 };
 
-static struct clk_gating_ctrl *ctrl;
-
 static struct clk *clk_gating_get_src(
 	struct of_phandle_args *clkspec, void *data)
 {
+	struct clk_gating_ctrl *ctrl = data;
 	int n;
 
 	if (clkspec->args_count < 1)
@@ -217,12 +217,16 @@ static struct clk *clk_gating_get_src(
 
 static int mvebu_clk_gating_suspend(void *data)
 {
+	struct clk_gating_ctrl *ctrl = data;
+
 	ctrl->saved_reg = readl(ctrl->base);
 	return 0;
 }
 
 static void mvebu_clk_gating_resume(void *data)
 {
+	struct clk_gating_ctrl *ctrl = data;
+
 	writel(ctrl->saved_reg, ctrl->base);
 }
 
@@ -231,13 +235,10 @@ static const struct syscore_ops clk_gate_syscore_ops = {
 	.resume = mvebu_clk_gating_resume,
 };
 
-static struct syscore clk_gate_syscore = {
-	.ops = &clk_gate_syscore_ops,
-};
-
 void __init mvebu_clk_gating_setup(struct device_node *np,
 				   const struct clk_gating_soc_desc *desc)
 {
+	static struct clk_gating_ctrl *ctrl;
 	struct clk *clk;
 	void __iomem *base;
 	const char *default_parent = NULL;
@@ -288,7 +289,9 @@ void __init mvebu_clk_gating_setup(struct device_node *np,
 
 	of_clk_add_provider(np, clk_gating_get_src, ctrl);
 
-	register_syscore(&clk_gate_syscore);
+	ctrl->syscore.ops = &clk_gate_syscore_ops;
+	ctrl->syscore.data = ctrl;
+	register_syscore(&ctrl->syscore);
 
 	return;
 gates_out:
-- 
2.51.0


