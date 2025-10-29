Return-Path: <linux-kernel+bounces-876735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9390CC1C747
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ED0A4670E3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03B534C142;
	Wed, 29 Oct 2025 16:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6u7zSRA"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EEB2F5306
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761755633; cv=none; b=Cbo8OKok49xyMUVJI/Xm4poUQaPLNOxLh4NEDmwZk/khYmpx8aZhGSeMMgHdceuW7R4nMJQk0J8VC/SvxxTZPF1Yn3708LhyPy/0KEyRV3CGBza42g/Dy7/TlTnRRG532gDvZahZAjajvhsa108C3v46l7gRoKo/yeb/uF3w2cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761755633; c=relaxed/simple;
	bh=T06l1/4GOHE/LpDkePy4eVSTWo0uNva18SmJ0icOHLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J6KWfQl3B0fNQYKg22PKfZ11ZKDfBmUQOt9bHFOYZfRzV61SVntGu15qnvYdstMIoi36oOtcKx1EK5j8LkzUjXL+nRObMiBqLIFwJbgmW9W0hIZnpLANf08bhiXFTDU9NHyxiAk1vcmh+0F5N+WGuQkCnhU40NR4gKbWsYRQuXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6u7zSRA; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b5e19810703so8923766b.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761755630; x=1762360430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XbRLU+7LExsM1Q2W4kgKdkH4Wh0K6zsU36k2L5dwa0=;
        b=a6u7zSRALXcD5cAfl7zziHXqingpPMwA+3HQpLoOUYAN+T4DZYbzvXQku88P5LytsG
         dSepd0zu7KwPEm+SLTpu7V5mZsAQiytCslwBZjiW4yUtTcTJQVUXYl8R4juqoTdj51JI
         hCf1+U2YwclJoZF5yhDg/VxPsE6YKgy2pkmrqgE4KuIgw4dbPiW6aPL5RpFKbASmU9Fr
         AQZoN4oxCVq06kTWykouoPPTYq731ySwec2CxMhlePbiX0q6OgoGOpbNmyKXbrtrsNd6
         Wt1rhpU4kMgjFyK9e0qmJH4LqvKrN/HO0Gl3VvRi3eWCGseFGqkfUaC9te4+Xnky0T79
         IADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761755630; x=1762360430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8XbRLU+7LExsM1Q2W4kgKdkH4Wh0K6zsU36k2L5dwa0=;
        b=CEv86I4pJorhmjD3pBLRMKzhjlEfT7mUmNJT0a3VvadZVya4DRu1M1rRNtA72lxVbf
         OyrTGi3BciO9x2F3+fj9XfFbF/szaWlE74aeiwm5EGZnGtNfzMTVYKE1z5ztWx0vncEG
         eVVoFLmJDSTWhX4GHKJdBGrE0AI0r+94yMn3GNkmolD3qHxOeO2zWyaF+1MhyaErvpef
         +49DpKatO54K4lTobjnLU0KwduodmURJ3m1CxSB3Q8J9AU5JODiiRZecE1wxTk3g9NFX
         Ud6IIy1GF3QO7o5CUIeF91JogXL5cQl5I+FZUGL5G79EPYIGNL52IsGPtJLJ1egNj4Xy
         BVxA==
X-Forwarded-Encrypted: i=1; AJvYcCWkrlSrBKNCyvMW6Dh9ohOWBEOAzbDupv5R/VyZ13Ppg1MaKlkSk1+D07tC8H1qyu7HaEW/Xkuxq7QqLeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjejHSc6M0HyYYLal8/VIOsaJaWrhzYg0VqIYwTFE0bV1MR3VI
	N0d2U0PYdcnhw4r+24JC4+c1ykqmFQEtpWg0m/VdoYQA7mYXeM7YPy0H
X-Gm-Gg: ASbGncuHEqA5AEnC411FaoE3RLlXc5fH2FZPZmYNaGLt0pFVCaF10Bd9tMzvn/sCCLr
	NwV97H1tzPiCkZAfoAR+lcj5x00RH2qRtqdEOhkwIzkHWMJE8ov2ZTP1gLDPMFksiJJvjFbJA9n
	vYrAmaELao7Ls7pM7b3/ACfc4YHqgYcOteL+qirREDKtYncGlDPL2otiUOy5+WfVxgUCy/5hAl8
	lXsLo8LVESbJabf4xEV9Fx0jHmW3XbJiydLc3CzFITNzlEnUK78rvI/0etaazkipEM15Ta6ndtY
	wdIl7Z6gJE5aEhNywvbtDpANxRpX2kHpzuhyTvL3x7P4QhwE6Jub4NFaMO5E4R6uVtjFA35TgT4
	Uo4ZLolwdMKSGN3Ecu3bY8sI1GiWR4QOs71Fi+PI9zYVgSayl7nTs2qzXUkXuhBpIR4j5kOt58j
	XhAXtM/eNMM1eWY2dZzIFiGrVW8IfmHA4v/JeCRWZVNjpZ48mCpa2HgooiC/TUmW75YXOK
X-Google-Smtp-Source: AGHT+IFQlpirQWvqETIaDsilJH4sjQW05iHSTqO+BVFy04krtNR3muOIO8OYFK3MmzGZwCCaLhUORw==
X-Received: by 2002:a17:907:1c8c:b0:b3e:580a:1842 with SMTP id a640c23a62f3a-b703d557003mr393915166b.48.1761755629552;
        Wed, 29 Oct 2025 09:33:49 -0700 (PDT)
Received: from localhost (p200300e41f274600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f27:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b6dad195456sm939661066b.72.2025.10.29.09.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 09:33:48 -0700 (PDT)
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
Subject: [PATCH v3 3/7] bus: mvebu-mbus: Use contextual data instead of global variable
Date: Wed, 29 Oct 2025 17:33:32 +0100
Message-ID: <20251029163336.2785270-4-thierry.reding@gmail.com>
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

 drivers/bus/mvebu-mbus.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index dd94145c9b22..d33c8e42e91c 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -130,6 +130,7 @@ struct mvebu_mbus_win_data {
 };
 
 struct mvebu_mbus_state {
+	struct syscore syscore;
 	void __iomem *mbuswins_base;
 	void __iomem *sdramwins_base;
 	void __iomem *mbusbridge_base;
@@ -1008,7 +1009,7 @@ fs_initcall(mvebu_mbus_debugfs_init);
 
 static int mvebu_mbus_suspend(void *data)
 {
-	struct mvebu_mbus_state *s = &mbus_state;
+	struct mvebu_mbus_state *s = data;
 	int win;
 
 	if (!s->mbusbridge_base)
@@ -1042,7 +1043,7 @@ static int mvebu_mbus_suspend(void *data)
 
 static void mvebu_mbus_resume(void *data)
 {
-	struct mvebu_mbus_state *s = &mbus_state;
+	struct mvebu_mbus_state *s = data;
 	int win;
 
 	writel(s->mbus_bridge_ctrl,
@@ -1074,10 +1075,6 @@ static const struct syscore_ops mvebu_mbus_syscore_ops = {
 	.resume = mvebu_mbus_resume,
 };
 
-static struct syscore mvebu_mbus_syscore = {
-	.ops = &mvebu_mbus_syscore_ops,
-};
-
 static int __init mvebu_mbus_common_init(struct mvebu_mbus_state *mbus,
 					 phys_addr_t mbuswins_phys_base,
 					 size_t mbuswins_size,
@@ -1122,7 +1119,9 @@ static int __init mvebu_mbus_common_init(struct mvebu_mbus_state *mbus,
 		writel(UNIT_SYNC_BARRIER_ALL,
 		       mbus->mbuswins_base + UNIT_SYNC_BARRIER_OFF);
 
-	register_syscore(&mvebu_mbus_syscore);
+	mbus->syscore.ops = &mvebu_mbus_syscore_ops;
+	mbus->syscore.data = mbus;
+	register_syscore(&mbus->syscore);
 
 	return 0;
 }
-- 
2.51.0


