Return-Path: <linux-kernel+bounces-822443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4EBB83E64
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0045A58494F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB992C027E;
	Thu, 18 Sep 2025 09:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r+arTYz0"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDAB13D638
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 09:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758188915; cv=none; b=arnp1oq99LxciicCSQZZ+hJ+NYmoJ28yKcIpgogYlg1caL3PR6ygRrRx1GnyXc2o0XAu93hp/m4DlmcQN66wi0nhEHRep5mIp9dJU74WWlhNa4kvSo8PENhCW5Voh5OIuw/hq8AyygZGYQ2QXmob/YJ1T41vUs0JugKrdG6qOvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758188915; c=relaxed/simple;
	bh=iUOnXzAnIbz12WMKiHCmVwMEY+TGpgiWwPuQO/o7Ofc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nlTqMQsrvQW2ycxeHhjzNLBsCuxCKqykZdd9Z27rtbHb7ydGkYauM/ue69uc4qExczK0oLhlTPbYolTRixihv75TY+rFNHZTfY3UDILrLEZlesoU1kPyk5QgJGganTDeKs3OEPK8qPd9wmyUrhUI0vFcYNjjjZGQbOqo8xDRm78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r+arTYz0; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45dd7b15a64so6684195e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 02:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758188911; x=1758793711; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FRKX/a9t7ARzNjcgVwY27xm/KGPFcrC2ZLWzVexu+GA=;
        b=r+arTYz0c+clTxfqZjOXw1/NTcn/y+hfsNFHTGQC1Kq17gZkb/R12l2fW4+3DhbVd2
         h2wxTEsHKs7jtPWRARPpP86AT8S/MF7eH1g1pOcbSuuS7luMcWWA5grRuyfNgxC2/3lm
         On99ALYgJfokFIbbyVbXPpSnRPcuhJV3A+eGJXLnxf6pWMms5fKR3FIthwfp/m19+wdT
         +lPJupqSaLbJV2dkTgjOW0s208Geygsm2/tMXyhnpxN/aIUBi7CZjHfMfIKxa52AHdy/
         nTBu34evmIg8MrNMb8yWtO0XFZf6NK8i7WUnVxt/vbBHbnDb4yDjgzI8gSVQOtDnmr8V
         VW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758188911; x=1758793711;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FRKX/a9t7ARzNjcgVwY27xm/KGPFcrC2ZLWzVexu+GA=;
        b=JD56JSAuahyDPTd9RVm3um0HV/W2WLCg1RX0q63brmERar54HThkFsWpGeN8RcKTXQ
         +OKKYx04U2bTdqHBFDBIPVYC1G9OEFAA1yU6LRrECBSUtkAwe9LdrvDC6TstfPepbjAp
         /gGwxf+QA56UEYHOHrgYGrIaTJjMzRGpJPLyo5L/4ZQDpTQnZgz8SwjdKm7UcOiuZawq
         wDoMhU7uUosKSDonyDMzKU4h7ZmQNpXGks/ECmfMESAsXupF9OmknB4yw95+hWzpQWHB
         shxpespAq4+pnNXG6JWVVWjogEFQpJ542Uvmp7WLysNGt7aWHbWLzYJq5yRJdqMl9ScJ
         jNTg==
X-Forwarded-Encrypted: i=1; AJvYcCWpksyhjVd+1PEEKuFpizjnJsSkP8SZiHIEPZg5PhlhtMS5FYcpcHpAIYz6O731tcdxEFw/5d88KQTBBVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqrsnznEdP6MYsK2/Td7YJDjolKntan3yOoVO5WNO4eyhbyuM4
	StCcJbwAi9AsrvUEV/ZukQ39T1DR2IS7Z+Oqxc3iRdcCmSfEj34FhwUkQN9jESt7q48=
X-Gm-Gg: ASbGnct9Ay693dF9IuC7moeKLfVdcGlRLE20oRE8JiMF4XjIRf9cSc5Icy7MbPw43Gg
	HLpH2vsACW9FnKryPfKRldy6fmy8iF+axjEi2zwL5GYl2mGDYh4jNR5XWQDRXffxnadq7eRXYD/
	u4RchxWZJhLudCwsCHZxoCIz6Ezvv8TGsQlOEAW1zQ5Tf4PPSSx3towlB/O7s42EiE1j/gyb1wV
	2bTS2ZWMAukeRrEfqZpNL5UGR+8NN/rW2FkYO3vzEq2GDFSlGPPZx1ogOab+D4yWL86I7eq57WB
	dOL858jRSE9j30tV7ftL0Dbz/m/BWz9CxhSwwKLTbDRsEBwh4zR09XDKMVZJGYk6iAfBx+a9D+6
	zYjIJTCa5fbxXKxBDXi2huINGnxeV2cs2gTOVPoNbMWw6eQ==
X-Google-Smtp-Source: AGHT+IHXja+pZTgNTOTckYTv2vp7ew+2RtTFibAkrz6i7j2uNLlasmLdSudrmUnD6HjK82+q28mc+Q==
X-Received: by 2002:a05:600c:43c5:b0:45d:d295:fddc with SMTP id 5b1f17b1804b1-464f7027ee6mr16687145e9.4.1758188910448;
        Thu, 18 Sep 2025 02:48:30 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-461391232e7sm72907635e9.6.2025.09.18.02.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 02:48:30 -0700 (PDT)
Date: Thu, 18 Sep 2025 12:48:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Roger Quadros <rogerq@ti.com>
Cc: MD Danish Anwar <danishanwar@ti.com>,
	Parvathi Pudi <parvathi@couthit.com>,
	Roger Quadros <rogerq@kernel.org>,
	Mohan Reddy Putluru <pmohan@couthit.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Basharath Hussain Khaja <basharath@couthit.com>,
	"Andrew F. Davis" <afd@ti.com>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] net: ti: icssm-prueth: unwind cleanly in probe()
Message-ID: <aMvVagz8aBRxMvFn@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This error handling triggers a Smatch warning:

    drivers/net/ethernet/ti/icssm/icssm_prueth.c:1574 icssm_prueth_probe()
    warn: 'prueth->pru1' is an error pointer or valid

The warning is harmless because the pru_rproc_put() function has an
IS_ERR_OR_NULL() check built in.  However, there is a small bug if
syscon_regmap_lookup_by_phandle() fails.  In that case we should call
of_node_put() on eth0_node and eth1_node.

It's a little bit easier to re-write this code to only free things which
we know have been allocated successfully.

Fixes: 511f6c1ae093 ("net: ti: icssm-prueth: Adds ICSSM Ethernet driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/ti/icssm/icssm_prueth.c | 30 +++++++++-----------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.c b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
index 65d0b792132d..293b7af04263 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
@@ -1390,7 +1390,8 @@ static int icssm_prueth_probe(struct platform_device *pdev)
 	prueth->mii_rt = syscon_regmap_lookup_by_phandle(np, "ti,mii-rt");
 	if (IS_ERR(prueth->mii_rt)) {
 		dev_err(dev, "couldn't get mii-rt syscon regmap\n");
-		return -ENODEV;
+		ret = PTR_ERR(prueth->mii_rt);
+		goto put_eth;
 	}
 
 	if (eth0_node) {
@@ -1398,7 +1399,7 @@ static int icssm_prueth_probe(struct platform_device *pdev)
 		if (IS_ERR(prueth->pru0)) {
 			ret = PTR_ERR(prueth->pru0);
 			dev_err_probe(dev, ret, "unable to get PRU0");
-			goto put_pru;
+			goto put_eth;
 		}
 	}
 
@@ -1407,7 +1408,7 @@ static int icssm_prueth_probe(struct platform_device *pdev)
 		if (IS_ERR(prueth->pru1)) {
 			ret = PTR_ERR(prueth->pru1);
 			dev_err_probe(dev, ret, "unable to get PRU1");
-			goto put_pru;
+			goto put_pru0;
 		}
 	}
 
@@ -1415,7 +1416,7 @@ static int icssm_prueth_probe(struct platform_device *pdev)
 	if (IS_ERR(pruss)) {
 		ret = PTR_ERR(pruss);
 		dev_err(dev, "unable to get pruss handle\n");
-		goto put_pru;
+		goto put_pru1;
 	}
 	prueth->pruss = pruss;
 
@@ -1569,18 +1570,15 @@ static int icssm_prueth_probe(struct platform_device *pdev)
 	}
 	pruss_put(prueth->pruss);
 
-put_pru:
-	if (eth1_node) {
-		if (prueth->pru1)
-			pru_rproc_put(prueth->pru1);
-		of_node_put(eth1_node);
-	}
-
-	if (eth0_node) {
-		if (prueth->pru0)
-			pru_rproc_put(prueth->pru0);
-		of_node_put(eth0_node);
-	}
+put_pru1:
+	if (eth1_node)
+		pru_rproc_put(prueth->pru1);
+put_pru0:
+	if (eth0_node)
+		pru_rproc_put(prueth->pru0);
+put_eth:
+	of_node_put(eth1_node);
+	of_node_put(eth0_node);
 
 	return ret;
 }
-- 
2.51.0


