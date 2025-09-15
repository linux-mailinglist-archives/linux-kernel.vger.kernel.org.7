Return-Path: <linux-kernel+bounces-817630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AD7B584B7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 20:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3A261A27DB7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765252D0626;
	Mon, 15 Sep 2025 18:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLHZXHiB"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406AA277814
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 18:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757961462; cv=none; b=LNWzuMviRXgPYtMMsWGnh67+TxPrjjxUCtj8/sGqyT1Gee3j3RnTy4RK7RY0JILoRr+pnbcm8zZH+pDJAc4YuupLqpoqZjuCDxLc+N0XjI8OJEy+dd1FDlMU6Ecjg4wWTvxmLg1CBiKNgitbUmI5ukfuPjeM6hOczvaHusWU4Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757961462; c=relaxed/simple;
	bh=saRKhQdSfkWWGMnDAouHGazpODy9OIrbPN7VfwvSKVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TnsGrs9SCtok+ESrkoIqfQVH/Nul4dfKryxFKjeQqDxSDAcAgQ1yRG8pbfFPg0ZbtObZ11GaHf3lOckipA3Fw6bcmXLEQcsun/dBl6rMygV8wadmx68ra69qV26ybSCTiUQJNJovdhVfXczzWXHK0eTOd8uIsJYExoYz7zbmzGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLHZXHiB; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-62f0bf564e4so3384224a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757961459; x=1758566259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EnZt//Gw8HEE+0ExEJAEOTVfUit0SOOn3jWqZZ6uos0=;
        b=eLHZXHiBnxdwQW40SxZmFwxCvfyFLqPxCkn+Bqrb0puSOdVht88p1zbDx3LEIFbYwB
         hjpab+fgOq3Bzf/fM9hemsO3nyL4PRee6PxP2e6ToX7W5xhmO2Rt0uNksv1/HAzCeq7S
         qOG0Bi3IpQLQ4l0KNnmiG5fdeWFsEVLVSMKpu/6/GB9CYal3Y4BzGyxQtwBcDjDVLKEh
         FnMZ73ZVqW4+cR/1gfkbe5kmZtOB80STlv4VOOBLcANfMCmj15jSA1DBn0inyXMXdcPG
         BgWHvmggZYWtL5tL2Ro1XHoWmCYg4jB/FM0dmS2jIDrFU/WSj5rQ+33kBm1d9h6SAnC9
         J8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757961459; x=1758566259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EnZt//Gw8HEE+0ExEJAEOTVfUit0SOOn3jWqZZ6uos0=;
        b=hEg5QK0i8CEp77bQt3YJ4jFBfKtEdn2rsDj2fuXAZPkYH+GgszAWnjJ9O7nkd6ksjO
         Gf0XysoYhwKUBvgEK25YKAz9OSWq7CcId0yMF49lfv6k6AfynlxLhgMSGUjpWYsbUIOe
         o22B1CxAly8MtH9sOg0d5ZhXcRBw7sccN76Nx4LxaL9mvxhJYWbNhNR+7V6FPj9vfH5Z
         NyNMGCaIc9/r64sovbFpigK3B4GB7pWLP4+fBJ3pJSVWFhHpAKWuflX+kvJJpO4Ju7PH
         HIQwDnVRShpP5EglO1f8qA+eAu6IlgxpNQNGsPj0Pniaafa4qHHaZwslBi4GeOA02on9
         AwnQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/MxFbuDjbN5cKFUKpSQB9+JXBbNNsud7QgwyV6Cs5pAiwAV+uGwvtxKesZT0VtiwMA8sR2xQUDoz4Src=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgjLc92lyQJ30GODFPF3d/dQ9WYpArf84BxOAhj8tcRkFjzRUF
	CLgwAzSfNnT4uFSLSgHVzBVS71KhDhU9RY1zAdKdRfX4fYCHhHQLfDbx4bytGQ==
X-Gm-Gg: ASbGncsfsZXSWJJg93fAXBn7TrgVXoRTxTNz2RUd8n2rWt1JB3gOPK7HE0y/yVY3cDO
	e7ikMOOiO9/6i/ySxkEu5MpcUTY1NvrKDqPjAU8xjGX66YbcUVcsumyQr/Tvb1TRZ2JUNjIRr4B
	HQprf7X1201EKY6mYY9e+enS/s85px7AGZcasrWMMJmePRecLeDemyGW+VWykcSo3Qjf5Yf64NO
	ndA2EhWDm9tRCH4wVyJwVHfIjYQ1971Xe1hA2ymwZ41g4nMQsG1aj6fn0NW7XgbiAycIbw3AqUT
	vHz14FuMO22woPOckgDzCsqm5Z6PtC1lou5rtVOKascph+Edi89XsTDIA3SXX2ctktVg1Gk0bsc
	oaw4l9AXW8m1SsepCzYXDeZ9p8IvSdTOIJ2C84FdzIqUH0ZW3WmpIeWqQerGcE9XavMitJ5aXaQ
	HqqG0=
X-Google-Smtp-Source: AGHT+IEHWw+SDHAsI+AJuF9hiHU1IZzFJOmeRVfV5E+4W7dXdDnkqNl8hapKzt5xJVXwH3B9F7lXMQ==
X-Received: by 2002:a05:6402:13c5:b0:622:173c:63f4 with SMTP id 4fb4d7f45d1cf-62ed851af9dmr13620728a12.35.1757961459419;
        Mon, 15 Sep 2025 11:37:39 -0700 (PDT)
Received: from localhost (dslb-002-205-018-108.002.205.pools.vodafone-ip.de. [2.205.18.108])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62f454f4288sm2119985a12.5.2025.09.15.11.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 11:37:39 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 1/7] spi: fix return code when spi device has too many chipselects
Date: Mon, 15 Sep 2025 20:37:19 +0200
Message-ID: <20250915183725.219473-2-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250915183725.219473-1-jonas.gorski@gmail.com>
References: <20250915183725.219473-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Don't return a positive value when there are too many chipselects.

Fixes: 4d8ff6b0991d ("spi: Add multi-cs memories support in SPI core")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
v1 -> v2:
* no changes

 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index f95c4304df8e..b07d6cdf587c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2445,7 +2445,7 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 	if (rc > ctlr->num_chipselect) {
 		dev_err(&ctlr->dev, "%pOF has number of CS > ctlr->num_chipselect (%d)\n",
 			nc, rc);
-		return rc;
+		return -EINVAL;
 	}
 	if ((of_property_present(nc, "parallel-memories")) &&
 	    (!(ctlr->flags & SPI_CONTROLLER_MULTI_CS))) {
-- 
2.43.0


