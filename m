Return-Path: <linux-kernel+bounces-790930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1F8B3AFE4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 02:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B253E188DD98
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 00:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83221A8412;
	Fri, 29 Aug 2025 00:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iTsfHydO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3F6235063
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 00:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756427943; cv=none; b=blEpNcVEhKSPcS0BBc16bSy9hqjes8d6Mrq8D0hh/SBZgw6gFZ3FgMkYArZw4r6Lr4pGMX3MqdvWh8a/jnRrG9pGi/BiuiHxniOafXRacspxd7l4wBEgwlPgrLdx7lZGsiYzX6wP96kvIDkuPeRrIF5mWNT7B95ry+2DWyoxZug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756427943; c=relaxed/simple;
	bh=58n95bQC3o+Nb/L33jeFcmWnqEOz/8LpB+ZJ4315jbA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LZGBUyst+PmRI1R9649LeiC0d/xO71mWgLEbUHosyg7NqNY/ubhJbbhMKz+npdmPXlng4Y16Vg2ko7L8v5AvA9X+hnzGLF/Z/akfWMFUhvzMS+QjgJ4FsqgAmYZxI7YvtcDsQTYmNVr6vis/WeOUMFBUTCqowKps1FjVyvO/Pb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iTsfHydO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756427940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/zv3Pf2hNuIQOUArm7ZxnDoNihXiep39POzlD21Z8Ns=;
	b=iTsfHydObZ1TrKcIrcmuKpxAyI9rsrD9M7j5jcZQkzBbvpoco9oMHP2pcwlFugTUtINW/8
	5Z/dbXNxDjYv0C/6HCzzMPyqr/++cmeacl4fzgXmxEU+bC1VZ925R+9VeCw0A/eNwWnBka
	WMUgcNyT2coHDKyk89dS3tCum/oQiPM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596--SIVQw3yOq2jSeDWW237Vg-1; Thu, 28 Aug 2025 20:38:59 -0400
X-MC-Unique: -SIVQw3yOq2jSeDWW237Vg-1
X-Mimecast-MFC-AGG-ID: -SIVQw3yOq2jSeDWW237Vg_1756427938
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70dfbead769so14848236d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 17:38:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756427938; x=1757032738;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/zv3Pf2hNuIQOUArm7ZxnDoNihXiep39POzlD21Z8Ns=;
        b=E85pHZz8s3m8TM3yIQUVooAsqSQO9oEh6j8FlELxl8Jrieqf1WrKjr5QZshM3pSiEe
         s5mcpyrYzB2rdHtk8CS0GGB0FBAtb+Uy3HNl7Fks+JxrcDYeLAcp/hxBNamWPPxO/5kq
         86g+GRyBmdvYkpPJaGkjxexH4AhsAmESzw8wbVNieKYFvibEkMcdDLhUI7vFKOUQdyUO
         2kg2Rj6bftEBBtjA+LRl15vsoEWW1k2F6aDv9YaZADZDWRLZp553IQrfqCkDjU9yNzaK
         euQpaRx3hoaRXzN2VcrIC6+Icou8R+krxGww5nHs8Z1BONX7dPUocVOZaPBpi1yiBih9
         l+pw==
X-Forwarded-Encrypted: i=1; AJvYcCXOyU1Ntbv+4Ptw9fqMybVaz6GwlzsqfsydtgWvbwjQ+TDrtX3qSssLFjKAs7OmJ+gwoTNdTUA9C+ZWSo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLfq9uAn3Q2zHX/F9z2mmMV9Z6ga1vlD2bgMWi55CAC6vw1Wfz
	5Smp4SlNp3yTQRtvYHlXQSEa1BDOPqgwIxAN0XgmiXsh74mj5tKTBFCPunoymhx6eX+RB3jepJ2
	NZUVXDTx+MNvsoFpGzjEGlZB8t7gIEygyYnmj24f1OXcv8OdRMzfTX3aGyZulm1BGdg==
X-Gm-Gg: ASbGncvfFwPc8Di0Ft3BiY85E14QATlei4+yqHD1zxCO6upD23lmKSiTpj5NerMaZdI
	K/n5R/VMZwC7yPwXuDsj66GjoBxjDHsrP4mcd+h9wDRLmJPn/6IU8o+U2yFrc2C3hNAtB0Wj6lL
	lHESYuP3ftANNrSC/YPzagn5R5l2FZOVKA8+cXOVWewxHPDWgqKSsA3qm1MdFN6VgZcBM8qIiLo
	43U1hWt7mCwNKZDeuLJnT8prWv9/gdFCNfG8zRDMb4Ia9YG8clZLZuFgFFnuvktDY2HslIl9z1v
	r/P5uq8M7gKnJz1avhWNfWMO+QM5Cyf7f6fkA9sN9+BLY3CHsev3GxmB8dsIBUHZ5sPq56+c6Bj
	XknaKuBWjrfipGg2kcsZ8tmFBPVAuIx1mKA==
X-Received: by 2002:ad4:5d6d:0:b0:70f:5a6d:a24c with SMTP id 6a1803df08f44-70f5a6da382mr3848636d6.3.1756427938569;
        Thu, 28 Aug 2025 17:38:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNGUlyT+ctgue+dRAvvl/QvlMdyIOiL7k4jZZ7Wud+MSEXYojVVEBluU8riRrhIojKE6e3Kw==
X-Received: by 2002:ad4:5d6d:0:b0:70f:5a6d:a24c with SMTP id 6a1803df08f44-70f5a6da382mr3848306d6.3.1756427938041;
        Thu, 28 Aug 2025 17:38:58 -0700 (PDT)
Received: from [192.168.1.2] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70e6264141asm5588696d6.65.2025.08.28.17.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 17:38:55 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 28 Aug 2025 20:38:27 -0400
Subject: [PATCH 8/8] clk: zynqmp: divider: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-clk-round-rate-v2-v1-8-b97ec8ba6cc4@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756427914; l=2556;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=58n95bQC3o+Nb/L33jeFcmWnqEOz/8LpB+ZJ4315jbA=;
 b=uy+XUWiCv9yIjSAyrE0/4I1CLGHob+UIZ+EQxuc1qyVM5xq9Nhgg1+JCuBhoLqxMKDOrEirQl
 MnnF6BAHL2DDr0riIPtjEh4AcWFPyXh0pP1ewj5MPPjAgu3gyCxOVpL
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/zynqmp/divider.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
index 5a00487ae408be4ffd586704859b232e934c1f6e..c824eeacd8ebd4d670d78f1af2186e61008bdae2 100644
--- a/drivers/clk/zynqmp/divider.c
+++ b/drivers/clk/zynqmp/divider.c
@@ -118,9 +118,8 @@ static unsigned long zynqmp_clk_divider_recalc_rate(struct clk_hw *hw,
  *
  * Return: 0 on success else error+reason
  */
-static long zynqmp_clk_divider_round_rate(struct clk_hw *hw,
-					  unsigned long rate,
-					  unsigned long *prate)
+static int zynqmp_clk_divider_determine_rate(struct clk_hw *hw,
+					     struct clk_rate_request *req)
 {
 	struct zynqmp_clk_divider *divider = to_zynqmp_clk_divider(hw);
 	const char *clk_name = clk_hw_get_name(hw);
@@ -145,17 +144,21 @@ static long zynqmp_clk_divider_round_rate(struct clk_hw *hw,
 		if (divider->flags & CLK_DIVIDER_POWER_OF_TWO)
 			bestdiv = 1 << bestdiv;
 
-		return DIV_ROUND_UP_ULL((u64)*prate, bestdiv);
+		req->rate = DIV_ROUND_UP_ULL((u64)req->best_parent_rate, bestdiv);
+
+		return 0;
 	}
 
 	width = fls(divider->max_div);
 
-	rate = divider_round_rate(hw, rate, prate, NULL, width, divider->flags);
+	req->rate = divider_round_rate(hw, req->rate, &req->best_parent_rate,
+				       NULL, width, divider->flags);
 
-	if (divider->is_frac && (clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) && (rate % *prate))
-		*prate = rate;
+	if (divider->is_frac && (clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) &&
+	    (req->rate % req->best_parent_rate))
+		req->best_parent_rate = req->rate;
 
-	return rate;
+	return 0;
 }
 
 /**
@@ -199,13 +202,13 @@ static int zynqmp_clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
 
 static const struct clk_ops zynqmp_clk_divider_ops = {
 	.recalc_rate = zynqmp_clk_divider_recalc_rate,
-	.round_rate = zynqmp_clk_divider_round_rate,
+	.determine_rate = zynqmp_clk_divider_determine_rate,
 	.set_rate = zynqmp_clk_divider_set_rate,
 };
 
 static const struct clk_ops zynqmp_clk_divider_ro_ops = {
 	.recalc_rate = zynqmp_clk_divider_recalc_rate,
-	.round_rate = zynqmp_clk_divider_round_rate,
+	.determine_rate = zynqmp_clk_divider_determine_rate,
 };
 
 /**

-- 
2.50.1


