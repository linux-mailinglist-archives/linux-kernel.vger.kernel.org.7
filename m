Return-Path: <linux-kernel+bounces-889335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B42FC3D4F4
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 21:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 498EB188C175
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 20:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2284E3559D2;
	Thu,  6 Nov 2025 19:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifE25RUs"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC4F355030
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 19:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762459189; cv=none; b=AYjCdfgXrROC7NTUZ+p9F5RQVZUsJ3P2gXjoilp8W+NUTjS1lNgSIArTZ3rdf3749nGwirIEXD4seuSl5BOIaN7f75SVRjHo3srDc25nFTkXOlAh5L9pLLGCrtRwlTiqT/t4YoWmwHKGaZ7TE9ZSkXcDi4Qal+lQcPHPEQUbrfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762459189; c=relaxed/simple;
	bh=I8gVSNxw2aOO4ZdP0s2HcOB6Vs9l7ZVMP8y4tYKEw8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQ6amwBv2AfNug5aMfYeNVv+lGO20Jkl0zRQFvTc/6YpmH6LW38eRx1NsvQDr+zwmmM0ReCqPUtBhGw5rQLGlz8HQBmeghTfO8bebywIivtpZBr8Puj8sHAzvhJSMyYYS8Dd6MHLVLDF7FlWsk0MOK2rxRcVXCck08aLQvHnYh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ifE25RUs; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-429c8632fcbso9020f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 11:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762459186; x=1763063986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l76VTWaL5JNJWQVkhMGxzjJJc96x+kz2NkszPplq7c0=;
        b=ifE25RUsMNw2vSR1pkbyhbaCC+gNIB8zeoK9vS8CtQIO+ImDGdPwZXuQ/8RPkfn9BR
         Ax+lEW4D/Lx8KxQwPuas2VkiZW3+fEmb45psvAtKNQpqTFXx/+G50mtg8CXsz684mzC+
         CvS2yiZO8BRhLBiegs/aYQbrAibQ0SUjLMkQjPzPlLdcauh5SpGqqyl2dPVUmhfmDy6F
         hPpWQo98NAFTcEjidenKEclGZSZZrWOo8Fj+mVmpKEpIOJkKLmpLuEVI7LGUJxvLCZ2q
         V2HMPs042r8HTTsPzpVBB2AxLM9n7fiLgLe4m+/QtUpGPZc5gafU8JgoMAxxZoHB+HzE
         t8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762459186; x=1763063986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l76VTWaL5JNJWQVkhMGxzjJJc96x+kz2NkszPplq7c0=;
        b=U8KQBrAKVRkCkBjCeu3fPLAEuV9jfv6X/ueSjrAm/MIvkxJkdgb2fLVAR2wheKjUWP
         HckZ1rMAFSxsFZAsnujgq0VQ0XJouUsfnlHnXwhljWjs4ExWPkPkC2O+/m7rGLsYgy0J
         MruQz6aiPXDApKIw2N6zAafAImCc3voSjzx5p4w0jXSCrcxrl8Gs7I7xprIpnBclQWlo
         uZBtLQwp237cQPjvhmts4hr8bt3hfYj8mIZ1VWpvzJxLG7lScv0XrD9PQhrjEYACQmK+
         z8ZaJU5INfNUbVH2r3FHV7uddFo4C3IHW7EJqDL0G1bMAy0nl+cZpnorepnfbbHH2CRr
         5BgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwA7gOK8qq9ztc5p7d6qNuxCa6f6jLhbOmqsOpABigDVlanuPbw1lXKeqpJj+6yXsGqzCR0YCNOj+JVH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGT3ELwV+adn93Wsce5agUMpIpgeCsvvt0GpG1D/QWkYo+SM+F
	KDILlVyQTHMAvZYCIg3eXXc2AJxfRuw7ApuySiRxBCINyM38qzKRvWZd
X-Gm-Gg: ASbGncsiLxQfMqMcBSeKC5e7lhHKdcpqIdqd+FdfGdm2dkuZUzaFlEUZiWeOiQUvn5m
	i8j+ZyiQATX8HL6Rlwr1SR4VqVTttsNU0TC/TccsQRko8QeVL0Ec1EIKzlKfD/kb1/p3z962mWO
	+rG2cjwrNpV9mazH7RYuJMPtdrX+WP1Hlg7Hpjt+uYZOascmqs7JPJ4S/vA2Tpoy2EW1fLA4QlL
	c8DV/2LWgC477a2cxX0VhFCsaUzzYEzQ1UMjGLuZ51Q5xLcwML9e3hz2Tlera9bhWJD4M09xQB7
	BOCO4Si77+0e/CkGnpe+Vspg4tBDkCzeRZQMthzjoX2/Th15XEonyXBtCGGwU7QGTPH7dtvAx+b
	1JXHwS4lQXo1UiyRHH49OgGTUvEYS07A0imqK4+IDWKoHbSmgjr0CRjYA90FGRIkX4ZqwULKqSP
	5yMm07GPgKgTuKtRTYIOoiDns0yu8Exg==
X-Google-Smtp-Source: AGHT+IGybaf/NHxxtkPxDjDcb06HnUaaOs9P0uCx6jOwYau+YGwUCltbbYeXhcnTI89446yRK7nF1g==
X-Received: by 2002:a05:6000:4186:b0:429:ce0c:e661 with SMTP id ffacd0b85a97d-42aefb487b9mr302347f8f.54.1762459185944;
        Thu, 06 Nov 2025 11:59:45 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-42abe62bfa0sm990037f8f.5.2025.11.06.11.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 11:59:45 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Felix Fietkau <nbd@nbd.name>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v3 3/5] clk: en7523: reword and clean clk_probe variables
Date: Thu,  6 Nov 2025 20:59:30 +0100
Message-ID: <20251106195935.1767696-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251106195935.1767696-1-ansuelsmth@gmail.com>
References: <20251106195935.1767696-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rework and clean en7523_clk_probe variables to make them consistent with
the rest of the source. Also apply some minor cleanup for pdev
variables.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/clk-en7523.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/clk-en7523.c b/drivers/clk/clk-en7523.c
index b040f0f0d727..d98990a157d3 100644
--- a/drivers/clk/clk-en7523.c
+++ b/drivers/clk/clk-en7523.c
@@ -700,25 +700,27 @@ static int en7581_clk_hw_init(struct platform_device *pdev,
 
 static int en7523_clk_probe(struct platform_device *pdev)
 {
-	struct device_node *node = pdev->dev.of_node;
 	const struct en_clk_soc_data *soc_data;
 	struct clk_hw_onecell_data *clk_data;
-	int r;
+	struct device *dev = &pdev->dev;
+	int err;
 
-	soc_data = device_get_match_data(&pdev->dev);
+	soc_data = device_get_match_data(dev);
 
-	clk_data = devm_kzalloc(&pdev->dev,
-				struct_size(clk_data, hws, soc_data->num_clocks),
+	clk_data = devm_kzalloc(dev,
+				struct_size(clk_data, hws,
+					    soc_data->num_clocks),
 				GFP_KERNEL);
 	if (!clk_data)
 		return -ENOMEM;
 
 	clk_data->num = soc_data->num_clocks;
-	r = soc_data->hw_init(pdev, soc_data, clk_data);
-	if (r)
-		return r;
+	err = soc_data->hw_init(pdev, soc_data, clk_data);
+	if (err)
+		return err;
 
-	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+	return of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get,
+				      clk_data);
 }
 
 static const struct en_clk_soc_data en7523_data = {
-- 
2.51.0


