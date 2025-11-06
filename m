Return-Path: <linux-kernel+bounces-888749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DADCC3BD06
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D96341889805
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64FF3446AF;
	Thu,  6 Nov 2025 14:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="nwrEISv/"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83144343D8D
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 14:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762439794; cv=none; b=ZDaH4ilql4qaUuScHu94W1CkORNM81Zp+DTydEom8FpexyK3JBF3uo6S2rChLwTCKW+BQGui7GwR4Y89YgoyoaeniyN++PDxJMJhR4//Uj4Rwz1tVSI1g04OkQE7nj5snaUlYXng396P6PQFetFAADDJIGCG+I97mX+ISi7WfvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762439794; c=relaxed/simple;
	bh=GHnwtPsZXjN+kRDiAE0fB8kcSglMVgvTqZiFQJxM6fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ctJCUG/Cc9hQqghIb3NsDCWuOeAD7BPROmwMlQMqw6nW28JhjO009avSfmmYkoo9HorxGZ0HSjoN5xT3dPTDbTIDdijRq0imPsWsCralLmezqO/qJ61hjBVt5As3ouVDXCJWkpQ/xXr7acD+Ndescasi7uUO+6h0zZwsoti1pm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=nwrEISv/; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47758595eecso5632285e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 06:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762439791; x=1763044591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLJObSZguYooG//hSzVwf4p86h8hNnf76dlK6vZI5T8=;
        b=nwrEISv/qstiqS+MzcCkNyZhwaMcLN13d60xJ++6uifS47yJesiKJ37D2UcQPAzL5u
         lb6IMIswLfHMsWxyWb416B1pnyCOw7hk3yYkW5FGy5DTFeQIgouCdhDLYYisUH/fgJP/
         e4b3+FHrMlQKoTVUrA7EakUHj/28mb7X51wwAI/CTzGcxX2UvbzEOrToC4SmXw9punPH
         b5rgBtfRwKFNklMihpvkSCiDrK7imrr59RI27iAlgEf7wE3+MJpsgm9VVG3SD3Pj62Ll
         nY9ArsG1Xwi8WZfZlOstoCiTDbtHnfzLkcGX+tMXfC+Fw7UA3/CU6r5YVMnQRYcV+Xjg
         TH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762439791; x=1763044591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KLJObSZguYooG//hSzVwf4p86h8hNnf76dlK6vZI5T8=;
        b=L1AkUQKyoDZeUnjo4QUZ9TXU/30cIGBwGwNL/eqvyI/mZ9MuRAXWbtXw9clhvz+1a5
         1V7O+KUDWOquqBKPHRGaURqtjY6DB3NUiMcl1N1dbcg0qvv16oljlCv+H918/Osd+Ce6
         h7Q1FkYRwhDNsxJDgYe8+ZqA6BP/0/9hcWG8X+syIb1SITo1X1bb/ttIjFPeP+9ABdjq
         8FKYhzTNuaU90D+UcrsrOHTcJH6mT5SV2KmH7n3kJXlwqR3eqwV1aqF0t5fIqmrSTvWs
         uBGv0NlMNiyEQkerNgrdjKJOsrr6Otjb1PV1SedExfuzajQ3TJw/MvKwZP52UaImK85T
         gvTg==
X-Forwarded-Encrypted: i=1; AJvYcCUeSypUeOYCgZrti/DCMuyPasQMypoyv7unVdRix1s0pKcu2A5FyMAyOSwDbheZFQwGNSVVaju/aDaBd/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqZyqgGlJxmOGefgHBmej1XUIiHO4OJNThh7odWalOcer9l2Lx
	iMysqFzM4CMbDZdD5g41kKnZu6ipVrc5E6N87pxkSszpjc2+0ZhxtCjhdulwYe1Ic8M=
X-Gm-Gg: ASbGncunpbi9oQC2ePQXg6guNZDyHAutQS93HV5gqUBJN9v+qoSgjJ0nX5GOmMJnuYA
	B59VEGl/QZgXznnA4f3tF3En4K0SPNqW4makdo0B8WhTRGehAQr3WMPOIUysZ0yBFVqR6bdmy1D
	rvlFa4RDrt18FRWFvubRRK3lcwpf3nEL97QYv5x2QdyrqiHhaK0yla6G9ksw9rs/adaNL2rpQaw
	3mZsEvOYIkEVPpIVqZ1u2T9ArV6rZ2Np18PdKONH1lXkIhhim+vOALwMTM6bPvzPkrQB6zNbV0x
	/z4ASyuRm3XehfINiq3OWdlq1TGK/NmsfbKqrabWNz+j7DG57D72+DkECz8gg2Gzo/LyS/dACJy
	xhRFwuqGI2Qhp/5s1bYC/c4aJj7j9AzzDaDeGt0NT8/C9CRENpxiCpBblfRlNfvHtOTMqpLLRwC
	14xh9SKs7v6Of19X+zPKhmtLSY+Qj7Q/OCRxUcmum1
X-Google-Smtp-Source: AGHT+IFv33x2P872TieHOJvR5x8J1BT/j4Lv/kS9+Tc1cAVcKxr+2HllDBXtSXFFGFzhCzx5Kr1b6w==
X-Received: by 2002:a05:600c:348f:b0:476:a25f:6a4d with SMTP id 5b1f17b1804b1-4775cd9c069mr60508955e9.1.1762439790728;
        Thu, 06 Nov 2025 06:36:30 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce2cde0sm112185495e9.15.2025.11.06.06.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 06:36:29 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: stern@rowland.harvard.edu,
	gregkh@linuxfoundation.org,
	p.zabel@pengutronix.de,
	yoshihiro.shimoda.uh@renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	kuninori.morimoto.gx@renesas.com,
	geert+renesas@glider.be
Cc: claudiu.beznea@tuxon.dev,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 1/4] usb: host: Do not check priv->clks[clk]
Date: Thu,  6 Nov 2025 16:36:22 +0200
Message-ID: <20251106143625.3050119-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106143625.3050119-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106143625.3050119-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

There is no need to check the entries in priv->clks[] array before passing
it to clk_disable_unprepare() as the clk_disable_unprepare() already
check if it receives a NULL or error pointer as argument. Remove this
check. This makes the code simpler.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/usb/host/ehci-platform.c | 3 +--
 drivers/usb/host/ohci-platform.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index bcd1c9073515..57d5a7ddac5f 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -112,8 +112,7 @@ static void ehci_platform_power_off(struct platform_device *dev)
 	int clk;
 
 	for (clk = EHCI_MAX_CLKS - 1; clk >= 0; clk--)
-		if (priv->clks[clk])
-			clk_disable_unprepare(priv->clks[clk]);
+		clk_disable_unprepare(priv->clks[clk]);
 }
 
 static struct hc_driver __read_mostly ehci_platform_hc_driver;
diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
index f47ae12cde6a..af26f1449bc2 100644
--- a/drivers/usb/host/ohci-platform.c
+++ b/drivers/usb/host/ohci-platform.c
@@ -69,8 +69,7 @@ static void ohci_platform_power_off(struct platform_device *dev)
 	int clk;
 
 	for (clk = OHCI_MAX_CLKS - 1; clk >= 0; clk--)
-		if (priv->clks[clk])
-			clk_disable_unprepare(priv->clks[clk]);
+		clk_disable_unprepare(priv->clks[clk]);
 }
 
 static struct hc_driver __read_mostly ohci_platform_hc_driver;
-- 
2.43.0


