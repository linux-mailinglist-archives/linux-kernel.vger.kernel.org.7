Return-Path: <linux-kernel+bounces-732622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D82EB069AC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 01:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C47497B2537
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 23:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1376C2D6419;
	Tue, 15 Jul 2025 23:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v9GXd4uu"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83582BF3DB
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 23:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752620485; cv=none; b=hJVyLPJvVyo762HNgy4qsSlES85rOPAAu7hB5lXvX6kcq2mNWKa+fctN3QvoH5gZjM7psv40cXiX+O7lD51ErXnAS3DO4hTJSg19paDpHqQPofA+u6oIktWxwp/Imm8shQjfy+/4Wbyv9nDBIhzmfCiYgnIKQO9K27nix9WmWfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752620485; c=relaxed/simple;
	bh=b/LA/fS6G1ALR75iCSwylRoGN9ZsUCbGZpu9YxrMRv0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PUPgSRiZLYRXkandfHON6CFN4QZN/STJ6wVdZBHaMRw2SYee3wgeIDZn+3pGGW7wekOpiTfQtZoh2ZeLfLa8No54Nb8UQTTR1Xf2xA8hS4rmTkWUeWQWaF9yNwSww2EYfts2Ug+ZlTYx+yTrSRfZymH72G9GcEFsSvzFpAk/2K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v9GXd4uu; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-41b6561d3e6so980458b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 16:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752620483; x=1753225283; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k0CRRO8Zw5SYMNCeis2H0ecNCwZ1xJBBe/YWgqbP+9k=;
        b=v9GXd4uuanam7MiY9coe2hgWN/wJfqgjJcecYUy7JPw4f2lPJ3cupMj0zdQz76nUZS
         8KND3N+WJDPM5aZZsQDdAQ1gk2QVoSHYiJlG9qFxZpifZ29ugoWfz4qoWZxTmj213yTA
         N7kZHT0KUrBSRaObYepCZunlD16Ypncjjf1E+O4QhWV1v3LeXIc1LAHpuf0BTGCdXh0L
         m5O9OkoaXk+Kz504c+lmzERyeRizZp9doePktFeDx74nvUhy6JvT/veAt1Xh1+lCSriq
         u7EJJhGDkwwdAm912DlQs1PqMUZttsgPOYNZKQBwI0uL8pLaNm/eyQnt93I4lMF6lQHe
         Sglg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752620483; x=1753225283;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k0CRRO8Zw5SYMNCeis2H0ecNCwZ1xJBBe/YWgqbP+9k=;
        b=l5qt83FXMLlt/GVe514U4JiZRaqpqM0uSdegeg940e8jl0ShRJfe1bZ9HXCMcV2Ke2
         kPzl/Iye0srKdziOBZL9Xv5UzqCxV6NcUr+Crfryu2MFKgw8+EnsyZC/OBfUGwi3Xf/z
         SpxB+jw1cHx0YoZKbElcEAEQe8PXuu4TMIFHwfPbUMKz/RFvFmbF8+rbxjoDgbeJX6yp
         HIFOiOe4XQg0ZwBHEVTKXHTo3gU1BthloanmflCh26dY9uquuVdnOAtiNs8NpIzphD5i
         OZVjViFfPJdwrEoEtea9lS/BqwtAL4+sBrXmU+BFNbec7LwwKCPz5ioUEuU+eO13LLdr
         iLNA==
X-Forwarded-Encrypted: i=1; AJvYcCUG5C8Ly4OoZgbV/BujnCyX/Cqx6NVkZ3f2YcskFaz5s8M2rHK1mKWdxAWX3a3DDWwcFQ8+gZPX1gxfsLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfCwl8ZQggHEpHu/iNrEQF0OC3EUhxuwxn5cC3sqkyDC4AeKMb
	+lZ8lq4sohxLb6+eVP8bFWg51picBrlSML8Q8ffoEuoe8pExM4ZZWCG5Vj2q4gDzxWk=
X-Gm-Gg: ASbGnctmdMY6nvgRAcO7N6kqZc7Vht0jI+YWpQd3ORM0Qc9E5OCPmEMrJOYoua1pF4Q
	Hknc0+US4Y9/pyPcYsDxVR0Yf3xdVRj9W2pq29HfjeG5hC5pqPTE4VA+ntHmCupvWldZ4HqR/rP
	+c9Q6yxRILdYQ1SXHrsHjmUjd07hJQv6KI9Fie1hwewKi7ocBmXp9YNcl8s0iv87Ls4+x7hKpnx
	ulZ4QIwmxFoekphCCb1BfdD6SfuQC20OUK0XWemhCUAYcj1PttLSJcOGPiDRmyZq4Qla6IlpsTG
	E0L/yaUtB3/jWEu7I7KEiXxN5rMKhMpth/qxdTj2S1Q10PRSkU9uVDysfR9+N6/ZAC0ZTWGCXmi
	9QAOt7K90/DuraL4a+jxgbLd30sYp
X-Google-Smtp-Source: AGHT+IGQtllmBc9kuXNMSNrT8BdEoXm/J1sAHyCL8mClXy5PmdAT8mA8+MNoRfXMLo08tASsstG21g==
X-Received: by 2002:a05:6808:199f:b0:41b:75ca:b104 with SMTP id 5614622812f47-41d05d37a1emr470408b6e.39.1752620482690;
        Tue, 15 Jul 2025 16:01:22 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:9b4e:9dd8:875d:d59])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-41418c0ae9bsm2349086b6e.6.2025.07.15.16.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 16:01:22 -0700 (PDT)
Date: Tue, 15 Jul 2025 18:01:19 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] net: ethernet: mtk_wed: Fix NULL vs IS_ERR() bug in
 mtk_wed_get_memory_region()
Message-ID: <87c10dbd-df86-4971-b4f5-40ba02c076fb@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

We recently changed this from using devm_ioremap() to using
devm_ioremap_resource() and unfortunately the former returns NULL while
the latter returns error pointers.  The check for errors needs to be
updated as well.

Fixes: e27dba1951ce ("net: Use of_reserved_mem_region_to_resource{_byname}() for "memory-region"")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/mediatek/mtk_wed_mcu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed_mcu.c b/drivers/net/ethernet/mediatek/mtk_wed_mcu.c
index 8498b35ec7a6..fa6b21603416 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed_mcu.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed_mcu.c
@@ -247,8 +247,10 @@ mtk_wed_get_memory_region(struct mtk_wed_hw *hw, const char *name,
 	region->phy_addr = res.start;
 	region->size = resource_size(&res);
 	region->addr = devm_ioremap_resource(hw->dev, &res);
+	if (IS_ERR(region->addr))
+		return PTR_ERR(region->addr);
 
-	return !region->addr ? -EINVAL : 0;
+	return 0;
 }
 
 static int
-- 
2.47.2


