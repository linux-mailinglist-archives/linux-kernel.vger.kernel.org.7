Return-Path: <linux-kernel+bounces-732621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 290DCB069A7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 01:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50D5C4E38BD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 23:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF6F2D0C7B;
	Tue, 15 Jul 2025 23:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NTcHzCPh"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2F72BF3DB
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 23:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752620475; cv=none; b=UFG0mzs6StjFPfu8fzA0WBkVCe2jTlgzcl2T7vt/okwD75SkTanNTNsvBNBn61W/sg7KVl8HReNvWwXf1FKhPI1X+zs3IDl8epYQyezQ17e0C2xxsQ0eXVZH7HCWGVj00u3jAvDp1RCTqYsXRfkU8guSHgjQ/xEYTQhMSjFMvDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752620475; c=relaxed/simple;
	bh=u3Mpdz2pmtyGUWJnzrCAlKzTsLeej4d/Sc2BmFxp/a0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZP3NhY5fMDTkxanX4W/il+QB6HQnYFRfvoZpj0shu56axRp1xRvDEfHcuqgc2kP8ypF1Jfb2KhSPlZSrENdSzGkMNw82GgcsIlMlBqRYuUMeJpZtq365eP6+Zf4aiSp0dTFbRTk5ugvP24uDu6rO8wcxYK90EdSukPNW7tFTD6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NTcHzCPh; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2d09d495c6cso2203451fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 16:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752620473; x=1753225273; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HMxhWC+6DIUyTBowpY7tH1U7/VAQSY6aI1DyTbhk/6w=;
        b=NTcHzCPh/zGWicsn0r5425ojf/BhrwXqmJXOTQC5BA6rcF+l1iCtyLhHpYBM78IQGJ
         6Lndy/90f54PSSGAR17B+0sUcqtN8eiwTmUGEleJkVXGQv0Q/qDEiqcwyp1bziAhU4SD
         icTLRbKr3SoouFIFb9lXpE7xnB1ADBv5IlgbJfYcQrCZLlrsfOGnJrYl9pudfGJJZwXV
         6VP/POt7aClBHDBOaoQREtc9dVYqtyP7gTUzDGAdisl6ymeOkZo9raj0FRbTqZ9Nxdl4
         ugN2FHzUOYX9zdo2YeeePFbHI2Uh31JDRjSc5nHgHOnsg77+TbSggJxXFnJH+4HG1Y5u
         wq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752620473; x=1753225273;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HMxhWC+6DIUyTBowpY7tH1U7/VAQSY6aI1DyTbhk/6w=;
        b=np8KYLOgLEKtny3+Ig2jvoRg6ZwpN/BL++mWiKMfSEdbKN4PzzX5s//4mJDfEnUJxb
         S99ToULY76KOjQxCqQOVb0nULV8rjBecDN6+OcQ5AsDMVU3UAy+SSpjOiafFs1/HAc/S
         enbUyrHbKq4GuvN+3RJNb431Sf20JAAU5fNWiOJv00JRZxfNxIS4D5QvU/J500DOiKKi
         M8DMYY9ulfmNBah3lDa6FhUNvjtvOEC/dCEmPwwUAco6SjX7zbVQ7VIAQJLOWfzh4E5j
         Ev00HpTKd3FnrBtkqRSfZw7tJywvXJDOB1/TSL/FOk6+0dC2Zl6mCzIDPD1JBC9HAEBL
         C3Mg==
X-Forwarded-Encrypted: i=1; AJvYcCW1txJzZHj9D81rb4uKYUWJU3FfVIzPI0xSfK4UQmPHyyvgEJTLkxC6PPRYmqNcjkp4iKr00TtMWFqR5zg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3F+6LIxmbHcZtTd2uX+oAHwyEAaS5NWC/YAdOjJBNFLUgWdBI
	brLiIZPlQESRzqFhooZjVoVHkAaNGQnXBqu5jZa8q2SsTg9wkMUqH9w7uA6lzWlY1rc=
X-Gm-Gg: ASbGncsabup6yqq2xa/gEP/UUMvyGPIuZkXuiCQHOCFDZ0cp6B9BLCkD3sacfwDjP1E
	lwtEOo8eLcV8LdhAsLb2F2y1xBF8xuSq3n57axpFffhrrtVqjqnCTdrg1FjLjJz4bgX2DGzGMYw
	DNexvODC+6odDGVWlgcikdfgB1HAvdLB1Wy/W7cYYFUCGJWFvPk1QV3m/FHxSNOdcjGPJcrZv9n
	fyGo7gIDb0JntcZGAdOiUsa/L8600RyLKM/A30ag+QnNvfXkmq8J9If98jhRRXdIe5KhL6idVyR
	vVkJVS5lcIZ3LSZeuW97i38WjFRX53gNgcpy3B5n02FEJt/phJqJbqzs4yuYCo3/ckJaeZElFub
	MvFivzhVDFxmaySSJmWKU1AaWbuef
X-Google-Smtp-Source: AGHT+IEls5whNRzvN01o90WxbCX3ovBdPRxqs7+TUz1Rw8UbE0E1ggiOCz+d99TGSZRB8SxM8NuTEg==
X-Received: by 2002:a05:6870:d0c2:b0:2e8:eccb:fe1c with SMTP id 586e51a60fabf-2ffb24ae8c1mr586050fac.31.1752620472817;
        Tue, 15 Jul 2025 16:01:12 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:9b4e:9dd8:875d:d59])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2ff11686cc3sm2964968fac.27.2025.07.15.16.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 16:01:11 -0700 (PDT)
Date: Tue, 15 Jul 2025 18:01:10 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] net: airoha: Fix a NULL vs IS_ERR() bug in
 airoha_npu_run_firmware()
Message-ID: <fc6d194e-6bf5-49ca-bc77-3fdfda62c434@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The devm_ioremap_resource() function returns error pointers.  It never
returns NULL.  Update the check to match.

Fixes: e27dba1951ce ("net: Use of_reserved_mem_region_to_resource{_byname}() for "memory-region"")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/airoha/airoha_npu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index 4e8deb87f751..5b0f66e9cdae 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -179,8 +179,8 @@ static int airoha_npu_run_firmware(struct device *dev, void __iomem *base,
 	}
 
 	addr = devm_ioremap_resource(dev, res);
-	if (!addr) {
-		ret = -ENOMEM;
+	if (IS_ERR(addr)) {
+		ret = PTR_ERR(addr);
 		goto out;
 	}
 
-- 
2.47.2


