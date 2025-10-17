Return-Path: <linux-kernel+bounces-858375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E406BEA867
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B16AE964B64
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB82924678A;
	Fri, 17 Oct 2025 16:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D7zQ7cSB"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2D2330B3B
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 16:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760717082; cv=none; b=lulGDeo0qvefcLrpLwEo9qCAWV869NKHN5HyPQnvc8qtoAWBOpHaxVF2/xyzbBTQurVlNFFKxP4uy33yBAXiR43y2nimiiRNMf84Q+M/CEn+/9by6foBs8JtfvmEcYIDh9lBtNWhZqLYrsJFBV9fcqxtW42Gw6lE4KktxKCT7xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760717082; c=relaxed/simple;
	bh=21MzbEOZZxXcBp8tJHgBWsUDFReLMA5Fun7i72mkmC8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ac8dQSCetKydR67f6Jn1r0c12Ce15ql7ICMBEuNCEznE0Jgv6fPzYwXy4w6hkiHrEnSoA2MawOHVsf09dleY5thrlddry3KqomloaTr0OiCYSJQ3UoEWr5vM5YjDctAYR9efrLNWXkcNyQtuQfMrz74TrOS5OXBDommANEW5llU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D7zQ7cSB; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4710665e7deso10240585e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760717079; x=1761321879; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=950Q3osvXfNrhNZDR0R7N+wo2IA1yL5cHorDQTcIxKM=;
        b=D7zQ7cSB9vFPaq/b/m0EfXvPBlSWRXcAguuwC3wCW4e3eDIEjtJSSIT/JesCfDWvLE
         0y3LE96XMeyHVZevh08q03BV4CVKHvitEK8Y9hYA1JeXV86n/k2ZjMXNvlwAZWJqvoEN
         P8rLTY1T4EK3wHVoMPirhx4G0kZvV+5yXbRgWziGDKmo+oRiXOroyftaEsxoYlD4W0kM
         0HsnjZ3dc16xWTtKwSbhEQgILlh4HBYJ6csRoO3WUoyNe3r1EJPLaXMcZu7DeziR2nWG
         g1BuF5Z0LxKTWSujw1yAc9qxSZ2lBHDoYDTdvamiPWh8zsFzcs/ICeiKrkW1quBnRwFG
         jKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760717079; x=1761321879;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=950Q3osvXfNrhNZDR0R7N+wo2IA1yL5cHorDQTcIxKM=;
        b=o2uJHtGB4XXZjoguGQ+G9eMEsKv3T1+gysTlDlY+cNvPoBOB977nQ2o5JM3HIWg+qj
         460yhtDO+zPJrMYYtjbkh9CszA3ke50+26C4zdc7jLU2xHZjPvb9jY+vsDC9OVzxBkCV
         ubdYy0MdpJKmv14gq2RYUUcyRsod+g8WR93AqNvHGzMWsqAcTkddeMhdFUMdvZIDphBG
         TxuEgioJvf/8wuuWNNBr+emi2CSYC1p2vMREgv6xvD5aS2PfDiDvqrUWnVn29H5xKLXL
         /3BZfl69sInOz/U83nk7ANOVeZasccZkPBsJ2jTssLHMn7m/EdyyO7FDmSrswGXS/u7C
         PWgg==
X-Forwarded-Encrypted: i=1; AJvYcCVHpahCBflSzxkjy9acN20KU7I/8WZkvKSvwiYi6KsDYZrvL8LCK8fYeeChPNKBwpVpyWlIHrS1eko3UNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCVUqpccRIdcUFgiszlo+iz/Fuj44M+TIu1lYXzkD9bhNDpXys
	QPenuCq6IvA4pitrMuN/ctBc2izKyblT/AJ69WGRlKK4S8aCAs1acrxt7/PoGzJHbFc=
X-Gm-Gg: ASbGncs97USG6rv+2f0k3sspv+A6EPHmjPGEvxIjyDpGylLxReQ//Il1vFQsUSUbw51
	E2VN0ObHUm6y2XHuxEVK8G3NWhDJtXVd0PLn4MOK6G2oMfkM55wvueWuSjSct5oz3olBH2p1a7e
	lR8wrn7I6pWIJi35VOEVn0rytk35DP53nafn2Rm3lyZKqf331w5x/NMkMMxUl4W9gzUYVmLD1nl
	1EKxkDXiyTR15fyjLJh+EF0Y6oRBhLNY69RyNU4rIuI99chLLdMyMh25CvV3by4VTIOtuFXscus
	YjHpPGIFEM/2vxrcAu9PlAgu/TNJkM4i7fQ4Y9XJOTRTlsFzqsHnLAFw9dz3xOV/q+ZEfsp3Dt1
	MAEsQNaGjVDi6mFlCOZ4muTwilfo0f6bNh2TbMDCYHqjPLs25gphGRiTj08dsv4x5Sj/HaEs5oY
	0qQ8Q/XA==
X-Google-Smtp-Source: AGHT+IEqaf8aEdQodsl+JMqmg15To8fNumQ1pcFMtGOlWgs5DrBRbhx4c+4oaiAKATvKgQ4yjwGtCA==
X-Received: by 2002:a05:6000:26c5:b0:426:d72e:9924 with SMTP id ffacd0b85a97d-42704dd6cf9mr3110630f8f.51.1760717078511;
        Fri, 17 Oct 2025 09:04:38 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427ea5a1056sm544f8f.2.2025.10.17.09.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 09:04:38 -0700 (PDT)
Date: Fri, 17 Oct 2025 19:04:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
	Mark Brown <broonie@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] spi: aspeed: Fix an IS_ERR() vs NULL bug in probe()
Message-ID: <aPJpEnfK31pHz8_w@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The platform_get_resource() function doesn't return error pointers, it
returns NULL on error.  Update the error checking to match.

Fixes: 64d87ccfae33 ("spi: aspeed: Only map necessary address window region")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/spi/spi-aspeed-smc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index 0c3de371fd39..822df89cb787 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -865,9 +865,9 @@ static int aspeed_spi_probe(struct platform_device *pdev)
 		return PTR_ERR(aspi->regs);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (IS_ERR(res)) {
+	if (!res) {
 		dev_err(dev, "missing AHB memory\n");
-		return PTR_ERR(res);
+		return -EINVAL;
 	}
 
 	aspi->ahb_window_size = resource_size(res);
-- 
2.51.0


