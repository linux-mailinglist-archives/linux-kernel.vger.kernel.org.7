Return-Path: <linux-kernel+bounces-790928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBE5B3AFDF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 02:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60E2D189E479
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 00:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0592248BD;
	Fri, 29 Aug 2025 00:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G4it6+L2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4351F2BB5
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 00:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756427937; cv=none; b=b1BatQxLZyc3mRpXR0gUdU1gukFYIfGcvzbGrI6RmkoASMyUidMNOKX1Lf4ZItInaBdyF77BHWIvfxNKPR3Y2UAHd3VHj47l2A+9oSEchGOCtIBdKVVjuqAsAKFxEz/jVB8ty7Ng3uOnplVi8tYYLJboKeBG3M9wjN/P+CegEH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756427937; c=relaxed/simple;
	bh=yQjDlKucQbDfv9rLtsx5KS2YxuVB1vqwKzuSAh7+mnM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VBF+Gxo7dgdK+og1xTe+XTDWoH1c0M15Mq8iCZ8eYPDhMytxaaz2rW8jPcmX0sl+DSj1HdBz0kN/ZN94gWhLz3hl5kKBmdVYi2iRMzxbeplUs2Hw1gIO0BFwU+MILg76F9vLQrwB/IM5rdFhNlvb3F3EfhNRGRu3ZaXSRLMWhAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G4it6+L2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756427934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GfKsJTdQgTKprCHDD3jSWtPOt7a36P0+9S4imFiAXj0=;
	b=G4it6+L2P9exKqWSeeKwnAiO2HWPPOiz8nXNRSD0zFVYLrVft26L4TfKkb8Mh+X0zXAjyM
	BZYU9XN1MckNtLXahgGX/Mn/bRYddFZ+cjDyx7l2V1Hp66LGnABpVT47Ca/v8W3vjus4Xf
	a0p9MiKu/+IE3WN1ZRMmtapS704o8pM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-tEZpyk_gMwa-LaB4a6vpCg-1; Thu, 28 Aug 2025 20:38:53 -0400
X-MC-Unique: tEZpyk_gMwa-LaB4a6vpCg-1
X-Mimecast-MFC-AGG-ID: tEZpyk_gMwa-LaB4a6vpCg_1756427932
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70ddd80d02fso18605806d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 17:38:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756427932; x=1757032732;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GfKsJTdQgTKprCHDD3jSWtPOt7a36P0+9S4imFiAXj0=;
        b=F/5mBEQGB5rQACIkp6iWQbHGByxs/9vBtUCuXQrYM2PZ8OHy+dZloTs/l6XNROYUzL
         7ieqvcLmg5uq/5y36pdjz5ms6W8K3TGOhG+0WiPYiifBsOdRuFElF0eWIZ7g2ahf9Zas
         I4+A3aopPB30aiyWyknxtFDsgBqWF9kypES2OcBgT331gUEyiagp4o576yJh21Arjsw7
         RURKzDlqOqlRKzz89IAsBMKYcM3KaiNaoKV3B4ZXRRLjLynh1UWIxdOWenPKfshOZhWS
         qM4AUqKiSdV1SQfVxh2BtPdhtQV1u6VbO0+W3V4vPkCwdWg5EvqFmD3pE1zv+8M9y9DT
         6u6A==
X-Forwarded-Encrypted: i=1; AJvYcCXYMc752veft09lxpZHkUg4LwIen+mtE072q7U4fbHkrGe2mrRy0MRKRj5r+jljrvPFZ5ThVMMishCv1dM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU/vyCkfCiosNlRQ2CXEc75w9uqedUGR3yq9HBdDj0rXPxL5IM
	+PB78T3HhvDf4GEystu4oJImhNaWpTpSCVjWDzFFT7Qw7Gzp1wDbFCC60HZUSE8BLuAV+MHpOM6
	85WfEbs0WproSanAwEu84BJfXoqXAGGBoilSV23emzzdPHbgygP/o3pjhwCc2hT/diA==
X-Gm-Gg: ASbGncuTGMjsiS/HTmz1lXZrJ+V6hq0MIdRErjWzvm5B9fDtbT8qhr00QZyjF9V64Q5
	DJO5qRr2rOtrjtRrF8wS79w54nJkX5Wj3jiBrDPJTN8y8e5ZLbjIbx85Mvm8vp5wQ+1FMrP+yZM
	8w5QXDVJW6E5hBzzhFPZ5xV+wcs0UzNX2oJfOMg1iblarNKrEk54z9xiiDzp8I/sDqn6Y5UVWgB
	70e5YCiWsooUHvdOXEM26IM4P8Ku50lTdwsOZswpRXTsvVKS7iZ8PW/RU/sBkF3A6l9rUPjysQJ
	2QFzRAbK1WT8Csw9HZ3ccPq0IGX+vjh7VKDU8+zqQJmKfJFtu8udlBSlgEghnyDY7PxdPLdxCXK
	5tegKiq0/mgQLLWTqpGdNWwg9f8RygjEE2g==
X-Received: by 2002:ad4:5ae7:0:b0:70d:6df3:9a8a with SMTP id 6a1803df08f44-70d9740287emr335625056d6.58.1756427932222;
        Thu, 28 Aug 2025 17:38:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwEc61ysJKMEZh0lWoU9IOEqRG7fUQ4re7qEY+oU+35ItiYKJvIfxusraAgiqWCmyxfYtUOw==
X-Received: by 2002:ad4:5ae7:0:b0:70d:6df3:9a8a with SMTP id 6a1803df08f44-70d9740287emr335624916d6.58.1756427931903;
        Thu, 28 Aug 2025 17:38:51 -0700 (PDT)
Received: from [192.168.1.2] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70e6264141asm5588696d6.65.2025.08.28.17.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 17:38:51 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 28 Aug 2025 20:38:25 -0400
Subject: [PATCH 6/8] clk: sophgo: sg2042-pll: remove round_rate() in favor
 of determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-clk-round-rate-v2-v1-6-b97ec8ba6cc4@redhat.com>
References: <20250828-clk-round-rate-v2-v1-0-b97ec8ba6cc4@redhat.com>
In-Reply-To: <20250828-clk-round-rate-v2-v1-0-b97ec8ba6cc4@redhat.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Vladimir Zapolskiy <vz@mleia.com>, 
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, 
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, Bjorn Andersson <andersson@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Andrea della Porta <andrea.porta@suse.com>, 
 Maxime Ripard <mripard@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, sophgo@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756427914; l=2918;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=yQjDlKucQbDfv9rLtsx5KS2YxuVB1vqwKzuSAh7+mnM=;
 b=NIACu2uEJBGAECXwzUlTYQmeDeO89xJedpYWiz+3jVOZMhats8C5aEq2W9Xgn57Xm3aQE46TX
 bO0ZY19dAj/ACNhybTA+CdBVvm/B0H9sIJNyaJ+3B0kXEmy97yyk1w2
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

This driver implements both the determine_rate() and round_rate() clk
ops, and the round_rate() clk ops is deprecated. When both are defined,
clk_core_determine_round_nolock() from the clk core will only use the
determine_rate() clk ops, so let's remove the round_rate() clk ops since
it's unused.

The implementation of sg2042_clk_pll_determine_rate() calls
sg2042_clk_pll_round_rate(), so this folds the two into a single
function.

Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/sophgo/clk-sg2042-pll.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/sophgo/clk-sg2042-pll.c b/drivers/clk/sophgo/clk-sg2042-pll.c
index e5fb0bb7ac4f97616f3b472fcab45e5729eb653e..110b6ee06fe4b61e89f3cbf2ce00eb03c078afb6 100644
--- a/drivers/clk/sophgo/clk-sg2042-pll.c
+++ b/drivers/clk/sophgo/clk-sg2042-pll.c
@@ -346,37 +346,30 @@ static unsigned long sg2042_clk_pll_recalc_rate(struct clk_hw *hw,
 	return rate;
 }
 
-static long sg2042_clk_pll_round_rate(struct clk_hw *hw,
-				      unsigned long req_rate,
-				      unsigned long *prate)
+static int sg2042_clk_pll_determine_rate(struct clk_hw *hw,
+					 struct clk_rate_request *req)
 {
 	struct sg2042_pll_ctrl pctrl_table;
 	unsigned int value;
 	long proper_rate;
 	int ret;
 
-	ret = sg2042_get_pll_ctl_setting(&pctrl_table, req_rate, *prate);
+	ret = sg2042_get_pll_ctl_setting(&pctrl_table,
+					 min(req->rate, req->max_rate),
+					 req->best_parent_rate);
 	if (ret) {
 		proper_rate = 0;
 		goto out;
 	}
 
 	value = sg2042_pll_ctrl_encode(&pctrl_table);
-	proper_rate = (long)sg2042_pll_recalc_rate(value, *prate);
+	proper_rate = (long)sg2042_pll_recalc_rate(value, req->best_parent_rate);
 
 out:
-	pr_debug("--> %s: pll_round_rate: val = %ld\n",
+	pr_debug("--> %s: pll_determine_rate: val = %ld\n",
 		 clk_hw_get_name(hw), proper_rate);
-	return proper_rate;
-}
+	req->rate = proper_rate;
 
-static int sg2042_clk_pll_determine_rate(struct clk_hw *hw,
-					 struct clk_rate_request *req)
-{
-	req->rate = sg2042_clk_pll_round_rate(hw, min(req->rate, req->max_rate),
-					      &req->best_parent_rate);
-	pr_debug("--> %s: pll_determine_rate: val = %ld\n",
-		 clk_hw_get_name(hw), req->rate);
 	return 0;
 }
 
@@ -417,14 +410,13 @@ static int sg2042_clk_pll_set_rate(struct clk_hw *hw,
 
 static const struct clk_ops sg2042_clk_pll_ops = {
 	.recalc_rate = sg2042_clk_pll_recalc_rate,
-	.round_rate = sg2042_clk_pll_round_rate,
 	.determine_rate = sg2042_clk_pll_determine_rate,
 	.set_rate = sg2042_clk_pll_set_rate,
 };
 
 static const struct clk_ops sg2042_clk_pll_ro_ops = {
 	.recalc_rate = sg2042_clk_pll_recalc_rate,
-	.round_rate = sg2042_clk_pll_round_rate,
+	.determine_rate = sg2042_clk_pll_determine_rate,
 };
 
 /*

-- 
2.50.1


