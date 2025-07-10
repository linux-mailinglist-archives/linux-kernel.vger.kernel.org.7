Return-Path: <linux-kernel+bounces-726485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE136B00D8F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA25B544BD7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 21:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BBF2FEE05;
	Thu, 10 Jul 2025 21:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RgNvr+gw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D15C2FEE11
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 21:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752181898; cv=none; b=JCSd85ztS6hQnm8O7LsNSVCS7/i00iLXvyFYee3e7hP/pq1Myqxz/i8loaFrJQ+fVYa47dBlYcAVcuPwp1y2tN66J+atkDleM1eJFVIaAnd82Rl2RLf5PMA83A6gZ/a/EHegQchTsS/5ac0rAmG/MRCVpLE4BjoNVxvDusUgmDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752181898; c=relaxed/simple;
	bh=FmCXWb+BuxfKsiZrK/6kC2xW6WNc9yFq8m/tSU8l3Ak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JWax4/zxeaailAavKE3esKlm/GOcYfWJEFxamjjUEMPrK9AOHLyN0QyqWPTtZgz6vhB1VTOmPGICegKhuHFDDkfpYcYn3SA7x4f/p8ignOzImPRrSgoCBuu3wXkStTHIrzAxyLK0uWIZvxLLTNZ9h1D3/QffGDWdYlPae1/rBbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RgNvr+gw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752181895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7OdI2n2BbI6O31Zan070+SCB6OSAX+67NNWJKs1Y8dU=;
	b=RgNvr+gwYSSp0pIIpfqFmgMoqQOCsb+YFtq4xtxc+err/UliRLVqj5h54hpjFPJ41mtjGy
	JS1yCiFUpFMILqJsHJHLBMKLJ967qMoSYhmrC9/tyVyKFfWGSzj18PWYJF98N4EVesr12S
	qSh/f+dREHiAqaAV9IVQ4Sey4leViXI=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-jUX_gxP9P12Fv9_orZJrhg-1; Thu, 10 Jul 2025 17:11:34 -0400
X-MC-Unique: jUX_gxP9P12Fv9_orZJrhg-1
X-Mimecast-MFC-AGG-ID: jUX_gxP9P12Fv9_orZJrhg_1752181893
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2369dd58602so14330955ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 14:11:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752181893; x=1752786693;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7OdI2n2BbI6O31Zan070+SCB6OSAX+67NNWJKs1Y8dU=;
        b=vCB1TFMznJuGnMF3GQv58oEfnCo3wbcmSJvrqPJUS2Ju/v4/uZjLe96X0A5umFNbMw
         u7gy9YNZyJUHOxxiNlWbkbXqyoh1izThjyT5xMOKak3FnHla3NH2PEpn1VMORqHHimHO
         wBr4OVwvQBK2jgaPm9TfIDij3ZM6kPKa0B4P0q0pbfj1z3dh2baIDAua/6DZeZ25SIdv
         cCpZu8BppqwT/Wj2PwL/h2EulsjqssR6zJVlR4zIYAPh7NR8lUKlbm7zmwBKTMetYQQn
         NoU2SOfgAl5fz52e7L76qbWfLhjdR6wAPJW36yC8BYzKE8oDKs5A0vGyja9i/wrliHej
         Y/6g==
X-Forwarded-Encrypted: i=1; AJvYcCXELQKVsdiuq4rg4pHAkAjc4wbj4tByIeYo0oZqsYO3nXt0NvbMnRdmy+kJtr2VvOjYX6hqgLhD2DsfUm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqSu0ioPsenBPmzey3mvF0FiLT7YX14xczZARh8qUHwxrJm3R5
	XxsEhxaRr6aY1AYYVAfZowAVfKdVYW8tzOPQI7lEfrEjwg9zPTkAeAB81fBd0Q6AVz9nJn03lYE
	0OWWVLi9sC9uTZypkCWHPjqar2AI31+fMhk9LwP8OdFAZWbVnm/Va2dzqAgnYKV1N8g==
X-Gm-Gg: ASbGncstKiNTnSpDAOstdR2QJhjZuoQuaPsOn7cDdn+Jtmg/qUauqEFTX742zXOgrTY
	NGCI0VcOBL0gecB8r1zyf1Js/w3nlC1etFucCAsPg0+xhdO2B0gQs4+mATAEek+AIVXXS2apnNb
	ypxwMWae/sVgJIZDRByqXr1RWkkPkiRiUFZIh3Dy/ITffspaJftZarjZqJ4RRZ/dkEuX8vQ1z95
	bVIj4ATTMjgVx3LXtXKf0rp/zHwgaVEjRH0x5wmWJDDNZEtlEcndWNkw3vyo/vrXz70WWianbjU
	hW4Av1bzS3fdWPcsDXZqTGdqk1GiG1Y46WV/9bYRtGXgYQ==
X-Received: by 2002:a17:903:284b:b0:234:bca7:2920 with SMTP id d9443c01a7336-23dee26e1e7mr7066245ad.24.1752181892849;
        Thu, 10 Jul 2025 14:11:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAu3uiVY2jtZDcVPMevBM73tyCaoBmEhvedjxReOqIZVBYPZ2AIvZ/v7pzQGp0pUiWsezqJw==
X-Received: by 2002:a17:903:284b:b0:234:bca7:2920 with SMTP id d9443c01a7336-23dee26e1e7mr7065935ad.24.1752181892473;
        Thu, 10 Jul 2025 14:11:32 -0700 (PDT)
Received: from [10.144.155.224] ([2600:382:7716:65ad:9491:c054:6f2d:80ed])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de433e51asm27790595ad.180.2025.07.10.14.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 14:11:31 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 17:10:37 -0400
Subject: [PATCH 05/13] clk: imx: fixup-div: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-clk-imx-round-rate-v1-5-5726f98e6d8d@redhat.com>
References: <20250710-clk-imx-round-rate-v1-0-5726f98e6d8d@redhat.com>
In-Reply-To: <20250710-clk-imx-round-rate-v1-0-5726f98e6d8d@redhat.com>
To: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Maxime Ripard <mripard@kernel.org>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752181866; l=1723;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=FmCXWb+BuxfKsiZrK/6kC2xW6WNc9yFq8m/tSU8l3Ak=;
 b=hclBooQtsYlgA2vFqMcl7brjchHA4Ks2oNDabec40XP6enmczIY/tMlPLkAvRmJvAPEBVB+de
 m+Reyr1sht6D3e09RWi133tloOn8bbGLpkWznbErndPrN6S8OmRbddA
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

The change to call fixup_div->ops->determine_rate() instead of
fixup_div->ops->round_rate() was done by hand.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/imx/clk-fixup-div.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/imx/clk-fixup-div.c b/drivers/clk/imx/clk-fixup-div.c
index 100ca828b052d701be84b62378844c1a9fcc1aaa..6af8fd065fd3cd71b66713105aa68b3b19a22810 100644
--- a/drivers/clk/imx/clk-fixup-div.c
+++ b/drivers/clk/imx/clk-fixup-div.c
@@ -41,12 +41,12 @@ static unsigned long clk_fixup_div_recalc_rate(struct clk_hw *hw,
 	return fixup_div->ops->recalc_rate(&fixup_div->divider.hw, parent_rate);
 }
 
-static long clk_fixup_div_round_rate(struct clk_hw *hw, unsigned long rate,
-			       unsigned long *prate)
+static int clk_fixup_div_determine_rate(struct clk_hw *hw,
+					struct clk_rate_request *req)
 {
 	struct clk_fixup_div *fixup_div = to_clk_fixup_div(hw);
 
-	return fixup_div->ops->round_rate(&fixup_div->divider.hw, rate, prate);
+	return fixup_div->ops->determine_rate(&fixup_div->divider.hw, req);
 }
 
 static int clk_fixup_div_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -81,7 +81,7 @@ static int clk_fixup_div_set_rate(struct clk_hw *hw, unsigned long rate,
 
 static const struct clk_ops clk_fixup_div_ops = {
 	.recalc_rate = clk_fixup_div_recalc_rate,
-	.round_rate = clk_fixup_div_round_rate,
+	.determine_rate = clk_fixup_div_determine_rate,
 	.set_rate = clk_fixup_div_set_rate,
 };
 

-- 
2.50.0


