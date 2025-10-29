Return-Path: <linux-kernel+bounces-876737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A67C2C1C45F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD3475A4AF8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385FF34F461;
	Wed, 29 Oct 2025 16:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPTPgjgT"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D6334889E
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761755636; cv=none; b=etsHjIdevy5///0YJDHD0OVDEnfFK19uclUFUKnsupyFyz3TgRkPzCukZ2QzWDYpO49FGeUg9ZobBCCzHlghny05o/CI3oOle+KtW14xh/U6PzibS9mkjACmdj/WtK6Gqvwd58rKu13i1V/+5I4HRkHnzSK3MkMLzNo1LV2YSac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761755636; c=relaxed/simple;
	bh=x/c8Gau2O3gfj3+358hMm8pmNs7v1wm+QbURDM7KfoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CjFWprSzjDK/QWGxmHpFVTh5atK0RCsj3qqpkmJnVC4oEhzx+E1Ddz4PpfoPy37ssFBGdfYJ1fd38MDAqKvEtIk4g8LQL8U4bLISU+2eO2h4OTdvJJq19/JoA4J/6CnzPFzRa8kg0z/V3CM4CENw19R5jLzADzEVwVgdoRzoP0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPTPgjgT; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so18726966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761755632; x=1762360432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3ZWzIw+tzavBMOmDgztL9+WJKK3w3KSDq6YVOazGFI=;
        b=nPTPgjgTOV4QvNiw767EkPXP8nZH+vMB95IK/uUyEapExC1xYDWPM9TY7fbFAnRlyR
         5go9001Apeiz1bCEoM9ktB19pnCqBYoMUiyerZmB97OscW9O+xPEWD3Y6x1trevTW6Gl
         gtcCynIa2cisxbIx6H8ZplCo7ErSv7aVeY2Jmyd1HkESnUSaaT5C6jz/K9oiV202/a/O
         ZCLReL5xckIEkVq8agGcgTNlA51Si/lOJzd6MVTxeioWIsLWGosNJ02BzgImHOjNw+nS
         ckb+/uuvh3BfuFZedwV9ZcgQrZ6O8PkRxXJZ+nnx1vURNkUTUuBoe6Rt32URkixI8fci
         PCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761755632; x=1762360432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U3ZWzIw+tzavBMOmDgztL9+WJKK3w3KSDq6YVOazGFI=;
        b=Ud7EPqVEsppVfNOPn1sU3wn8NwFRrsaDy1Ns4Q3CtihX8RkueVSKR6f0K6r9GNYd0f
         JcC7aKC8p0Bm+5Yp0+EZkTzZVkClwVkSoDEhqtdFMKXosXoDQYQAnuNXCr4HcPb/8d1i
         QQV6+67SQ7UgZHV+T//dgAcFGFywCJyFIgRbQS2EOcxHXPIbCkmWqoFWrPCa6RwdMa7u
         uj2Hvc+dsqcA0elIlMUAyVEosdFhxJdOFA5S+IaSm1ggOkGCgpWJaUisy8J3+CjMHXKt
         nLROodZa745jWG4xJu4nKAiZ4QOlCic3LvNXpH9MhTZX/brLeQcOMSwziBdwApsjbLLg
         8WGw==
X-Forwarded-Encrypted: i=1; AJvYcCWlVF9ZJmY7NqqUJwY2wftnSKSjtcooSXs73hwyDzu+WDi898O54tZQtH208kCshHn8l7plEQGON3kaspw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE2Onm51Ufl5CGkbaCeWRc1r6W0h1O8JX9risjJDj34HqBZVuM
	OTVE4yKjkeoYH7WWVzdJ+K2jxDyf76LqHzNGy26yVALzHYUcK+6DIkrT
X-Gm-Gg: ASbGncsZsNK+OCpf40lqu6fUzMJ+XWMyQp84nthfokczqafzUqCMYkJz1Nh0yO1/mzY
	gR+6nxoaam33tOUHgWrcQDokhRZH8DbnZincZfju3KNgZDzQMDYWz+M7hl79GvleLBNfgwsDn+h
	8BI+yDCSC/3OjHBlfmDsQb6Y386Gg2lBLGjjdcRBbDWcZh/aTKitq0xemseed0fhM0B7dqjtPiO
	oBMz2OGZVt1P/7vSpujUEnIA8ZHq7fD6tkLHo6lDzWZwkVf/TpVAml8zO0qA14LVrQufnVRjTVP
	KcqaNCG/oFyxzNQqvtXhkyJ33AW0xDzc5XsvNRD2kXxy8nlpmyHszlVUThR/bmDmd7atAmfbFUZ
	4iGUVHleMcuG2AYIOsiwleWlMr2KBaOaUBUAucH9JsMWqTE857Eif+tpWLW2eRgzHOThRnYEeqU
	unLMc/UXG2wq00u1w95w1Filb5DPgIW3Xx8lvQNRn8TufeMXMfiEK/l/PnGgV8L/WtRWsc
X-Google-Smtp-Source: AGHT+IHRieiPBGU6MC5P5jZHI6G/6PD4P6RVg3Iggx9u+yanu4koYZOv2T4MUr84z07ifr1PiVwzxA==
X-Received: by 2002:a17:907:3da4:b0:b6d:8da0:9a24 with SMTP id a640c23a62f3a-b703d2dc3fcmr322653366b.9.1761755631652;
        Wed, 29 Oct 2025 09:33:51 -0700 (PDT)
Received: from localhost (p200300e41f274600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f27:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b6da1e2226fsm1067814666b.20.2025.10.29.09.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 09:33:50 -0700 (PDT)
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
Subject: [PATCH v3 4/7] clk: ingenic: tcu: Use contextual data instead of global variable
Date: Wed, 29 Oct 2025 17:33:33 +0100
Message-ID: <20251029163336.2785270-5-thierry.reding@gmail.com>
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

 drivers/clk/ingenic/tcu.c | 63 +++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 33 deletions(-)

diff --git a/drivers/clk/ingenic/tcu.c b/drivers/clk/ingenic/tcu.c
index bc6a51da2072..8c6337d8e831 100644
--- a/drivers/clk/ingenic/tcu.c
+++ b/drivers/clk/ingenic/tcu.c
@@ -53,9 +53,9 @@ struct ingenic_tcu {
 	struct clk *clk;
 
 	struct clk_hw_onecell_data *clocks;
-};
 
-static struct ingenic_tcu *ingenic_tcu;
+	struct syscore syscore;
+};
 
 static inline struct ingenic_tcu_clk *to_tcu_clk(struct clk_hw *hw)
 {
@@ -332,6 +332,29 @@ static const struct of_device_id __maybe_unused ingenic_tcu_of_match[] __initcon
 	{ /* sentinel */ }
 };
 
+static int __maybe_unused tcu_pm_suspend(void *data)
+{
+	struct ingenic_tcu *tcu = data;
+
+	if (tcu->clk)
+		clk_disable(tcu->clk);
+
+	return 0;
+}
+
+static void __maybe_unused tcu_pm_resume(void *data)
+{
+	struct ingenic_tcu *tcu = data;
+
+	if (tcu->clk)
+		clk_enable(tcu->clk);
+}
+
+static const struct syscore_ops tcu_pm_ops __maybe_unused = {
+	.suspend = tcu_pm_suspend,
+	.resume = tcu_pm_resume,
+};
+
 static int __init ingenic_tcu_probe(struct device_node *np)
 {
 	const struct of_device_id *id = of_match_node(ingenic_tcu_of_match, np);
@@ -430,7 +453,11 @@ static int __init ingenic_tcu_probe(struct device_node *np)
 		goto err_unregister_ost_clock;
 	}
 
-	ingenic_tcu = tcu;
+	if (IS_ENABLED(CONFIG_PM_SLEEP)) {
+		tcu->syscore.ops = &tcu_pm_ops;
+		tcu->syscore.data = tcu;
+		register_syscore(&tcu->syscore);
+	}
 
 	return 0;
 
@@ -455,42 +482,12 @@ static int __init ingenic_tcu_probe(struct device_node *np)
 	return ret;
 }
 
-static int __maybe_unused tcu_pm_suspend(void *data)
-{
-	struct ingenic_tcu *tcu = ingenic_tcu;
-
-	if (tcu->clk)
-		clk_disable(tcu->clk);
-
-	return 0;
-}
-
-static void __maybe_unused tcu_pm_resume(void *data)
-{
-	struct ingenic_tcu *tcu = ingenic_tcu;
-
-	if (tcu->clk)
-		clk_enable(tcu->clk);
-}
-
-static const struct syscore_ops __maybe_unused tcu_pm_ops = {
-	.suspend = tcu_pm_suspend,
-	.resume = tcu_pm_resume,
-};
-
-static struct syscore __maybe_unused tcu_pm = {
-	.ops = &tcu_pm_ops,
-};
-
 static void __init ingenic_tcu_init(struct device_node *np)
 {
 	int ret = ingenic_tcu_probe(np);
 
 	if (ret)
 		pr_crit("Failed to initialize TCU clocks: %d\n", ret);
-
-	if (IS_ENABLED(CONFIG_PM_SLEEP))
-		register_syscore(&tcu_pm);
 }
 
 CLK_OF_DECLARE_DRIVER(jz4740_cgu, "ingenic,jz4740-tcu", ingenic_tcu_init);
-- 
2.51.0


