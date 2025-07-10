Return-Path: <linux-kernel+bounces-726481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B2FB00D84
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D33111CA48EA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 21:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC312FD88D;
	Thu, 10 Jul 2025 21:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KPFC/Cf5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0476274669
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 21:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752181883; cv=none; b=QPSlRrfitm/cupGKaqoTlgUE842LloBQ6mB6QlWzzeY76EuS6q/lDL1QZYfTKT2zSy63vJJyWUKAIkak8MFsS8eR6xIwcIcZSYh2KX9tnt/YvGFi+m8jaAnlr2c8aBX5gQSto7RUTMzpLg0Q3yYrJQTlhc/G+0OesXAq7gve4ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752181883; c=relaxed/simple;
	bh=sfg1D1VawT3AeNVMpNc6Mus+O16Hxr+I3BmqtW+ekY0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cJwrgDRdqev+C4y+WtpEZABbtlGwV5udvtyc1Z5or1WML2+dSbL1dccmV9j+Ldlb0+n41D7d8lYSirEwnOAi7a7RYZK48DMjk3cKNeqnSgulLvr0a7x1z/i4MkDgMNYXqr0T4PExdn/kMMyjP1C52iyRaM+uIRV0BZMxAsO6F4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KPFC/Cf5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752181880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I9YYJnViVPsfsEHtGb8q9J3Ez0LAkx4ujbOCWXp+c2w=;
	b=KPFC/Cf54gMXpa871YkvxeMWD1JyNx901VlCBYGqzftl1nnDj2SlowxlbMm0kXqCkzQ2Sv
	ENj+WyZGGyYlLslmPGdJs01p7a1a2lYEZs338fTIXwvgiJUMIDph8Ptpy54+FGao/TkmGm
	oTdWKd/lXP+6Vo34T7B3TDKW5AQzbYQ=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531--R1LtC7WNeibNlbnEp4oUw-1; Thu, 10 Jul 2025 17:11:16 -0400
X-MC-Unique: -R1LtC7WNeibNlbnEp4oUw-1
X-Mimecast-MFC-AGG-ID: -R1LtC7WNeibNlbnEp4oUw_1752181875
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-237e6963f70so20616165ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 14:11:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752181875; x=1752786675;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I9YYJnViVPsfsEHtGb8q9J3Ez0LAkx4ujbOCWXp+c2w=;
        b=VifbUz8tdV5PoHDwFRq3Cm2nfduIUqt1jw86wDmEdDjcvxKRlNmLjsUmF0JfrK0b8q
         FslfGq3wMhxF1BKhxCxopCBWBxd7kjFLh/vjF9xKOgW0pz/FYaxFRg7hhzRZz/uW0vtH
         8n05f/7uh6bMBaNYH/eBJiXZrwVF8/wlFG0o3kxC0p2LUyV5Cb6rDxJ8Y5u4JpmWgen3
         g1CvDcGFoQJd7/WFkkFKuiAjvTFKGkONEE5jV4M2wX/WKOFCoMbOELxBbcM/54dPK/ys
         dwztDhrxdjJ+k621ikrB/TAJfrpz2ppyPmHQ3Na1jHuQQBamZADNUClajt4+YjNkxBo1
         R+lg==
X-Forwarded-Encrypted: i=1; AJvYcCXvflWGqEpMveL4P+oQ3SUFoW1vvkteDi+NbnXN/S7svp9kLiGcN+VY7iBZbFKm2ogQZ9KmuyKFozrdjR0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxb1HO63tWR2SqpRJ89T6AOEkTdsq4tWaLibXXibEno2YXsgdk
	UgHHPSqEleL7SULzNGZVmOWr56hEXSOgFXi7EeZ1B838gBiGmzZycZqSnj3Mi9ZttzoE5/ST9ka
	jrCRMgVo363PEfPueLfFtP/731frlpTMnmV2kI+GTSRICnzz8eslXtIaOdY17YvaMRw==
X-Gm-Gg: ASbGncspLBGQ2PARjmPhUv4JfFBv6ZGUFik1/H+UId5mioJk2z0se/VAA3V2Loivd19
	VvxS4TJM6oOvcx1LxlCDtMUeL26CFZV/Kwpuzo9OqCs0CJRXuRRpljg+UHdu0rRtEJO3pCerBmE
	L0pVc4rkc60+pOhSy00XrLrCfDaHFAo5TVM93PWDih+n3AdoyKi2yfgb1uvGRJAHzsGG737tFX4
	suF0wBQZdQktaG/No2B3xpzZR6S7OP7MANpNzNCgLFBCzlnnn4uJ1b1ruR67ANbtEo1lgthh4RB
	dRNfLfaOH/LOWNXzFoaMlVkBEiAspw+GQguCwSXlOy3ntg==
X-Received: by 2002:a17:902:eccb:b0:234:e8db:432d with SMTP id d9443c01a7336-23dede8d53bmr10041975ad.39.1752181875448;
        Thu, 10 Jul 2025 14:11:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtPLby5dImEh4am3XdyrII2Yntq//gK06C7azIRRxqBEH0aY25p3N3xI1B7mTgwV0/nXxQcw==
X-Received: by 2002:a17:902:eccb:b0:234:e8db:432d with SMTP id d9443c01a7336-23dede8d53bmr10041625ad.39.1752181875042;
        Thu, 10 Jul 2025 14:11:15 -0700 (PDT)
Received: from [10.144.155.224] ([2600:382:7716:65ad:9491:c054:6f2d:80ed])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de433e51asm27790595ad.180.2025.07.10.14.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 14:11:14 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 17:10:33 -0400
Subject: [PATCH 01/13] clk: imx: composite-8m: remove round_rate() in favor
 of determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-clk-imx-round-rate-v1-1-5726f98e6d8d@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752181866; l=1717;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=sfg1D1VawT3AeNVMpNc6Mus+O16Hxr+I3BmqtW+ekY0=;
 b=Blg+J8i6MkcMkoaGUje1wzbwYgk1ZyPQvX73Fwg8TLuepmHSDlLAj0LMghIN3/KasFrhpihnH
 tnb3i6CqC7/DhjkxxkVAc+yA7mEN3HuU1bi2XXgEYAMrcDuURfTP3dC
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

This driver implements both the determine_rate() and round_rate() clk
ops, and the round_rate() clk ops is deprecated. When both are defined,
clk_core_determine_round_nolock() from the clk core will only use the
determine_rate() clk ops, so let's remove the round_rate() clk ops since
it's unused.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/imx/clk-composite-8m.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
index f187582ba49196e3cee2b5dbaba9bdd9b091bb40..1467d0a1b9341bc4b0a40591bca00392eabf7cfb 100644
--- a/drivers/clk/imx/clk-composite-8m.c
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -73,21 +73,6 @@ static int imx8m_clk_composite_compute_dividers(unsigned long rate,
 	return ret;
 }
 
-static long imx8m_clk_composite_divider_round_rate(struct clk_hw *hw,
-						unsigned long rate,
-						unsigned long *prate)
-{
-	int prediv_value;
-	int div_value;
-
-	imx8m_clk_composite_compute_dividers(rate, *prate,
-						&prediv_value, &div_value);
-	rate = DIV_ROUND_UP(*prate, prediv_value);
-
-	return DIV_ROUND_UP(rate, div_value);
-
-}
-
 static int imx8m_clk_composite_divider_set_rate(struct clk_hw *hw,
 					unsigned long rate,
 					unsigned long parent_rate)
@@ -153,7 +138,6 @@ static int imx8m_divider_determine_rate(struct clk_hw *hw,
 
 static const struct clk_ops imx8m_clk_composite_divider_ops = {
 	.recalc_rate = imx8m_clk_composite_divider_recalc_rate,
-	.round_rate = imx8m_clk_composite_divider_round_rate,
 	.set_rate = imx8m_clk_composite_divider_set_rate,
 	.determine_rate = imx8m_divider_determine_rate,
 };

-- 
2.50.0


