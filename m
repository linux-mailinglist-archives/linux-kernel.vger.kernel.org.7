Return-Path: <linux-kernel+bounces-732624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 422C7B069B3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 01:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08475580377
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 23:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984322D0C7B;
	Tue, 15 Jul 2025 23:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZlgdwIIJ"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797E726FA6C
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 23:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752620504; cv=none; b=QsMFJWixWCAEmKsl0BJFixMu6l3F9FTNEm77SSPCk4VUhEyaJywyTxVuMbdFEuv9AG4IYhnqLlfjnzkzd0upwsp4Peqao6B0CV+ZU3zUXF/uP2GBc9gmk/ByUubTKac5SmDVEWUpLeYV402pbE/KffRRBvozsjBoeTf9dv3VVmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752620504; c=relaxed/simple;
	bh=hQBUKhXoZhnrg3aw/tvNsOjzOzq2grhpIyy5kdu/2c0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=L2GdjBpRjylK0tNRsozyQ/EUZA+TDoQHfGfvDpPX9TyC7BfdKUpPIpDYNJO/FlerbYGObAe0f5hA5Oh34O1sGuqVTI50Wax3a5AnJNou+mvqq9iGAhMipfXOuFr9MofrhyORAgfKlBjspFTh2wEJ6cHsZtLJ9RqcD4VurkuKEfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZlgdwIIJ; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-73ce2761272so3379253a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 16:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752620501; x=1753225301; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=46gEt3Bx0FBkn/nnSaRTnSsikfa6dw7cUtJIKu/AHuc=;
        b=ZlgdwIIJ011E895kg2zptBdrs9U43kLvRAKy6PQKD1kWhY/iaGFFzEVUfrgwhUuApL
         trsdjGVCzlThPDvGOid/rCR9SjvfM98yZLoBqsp8xmyYDh5BqRg2vJVM9rM1eTih6Fw5
         PTNh7K9Z3L+Ir4n/cVXUXudf9KGJ4OtuBkB3suVO9/yoVbmVq0Qpp8za1ocHAYNtNs15
         PPY7ZR9e9k6Fs0jIAcfnA1UZjCsUSGGpH2nnY2qb/TgGlo6ezjLF/WtprGJ2p0Y5KuqM
         tB4c3O6XSHww39/wRLV0pskukIycGfh4kqQnhIWVqKwabYuXU23xw4bM3Skr57uu1pEi
         MXyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752620501; x=1753225301;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=46gEt3Bx0FBkn/nnSaRTnSsikfa6dw7cUtJIKu/AHuc=;
        b=H1jAlbqH4Nu/MxuoZyzkiooeg+uADz79q4L+fiHJOOdvVaxf55rjvuEoFHJTTcYDn8
         On/xEB3dkUsEIVR03cEniU7B4Goqwutfig3sU76rvCyneCxSM24GBX1DoYQdsGKWJnhv
         jI4pxLgFf5+MKLD/PplcpRQIq0w0/DNjLQxC3cSf5FuCJol5JrTOjiiTYbEGX7jRaSr0
         LDyx9yNG4jnTnEG1L2h/6ytk4aQG4Cs4zXzw/JB+eryQrYb5k0OVOpjbHV23uztlxk5O
         Kqe4Y86dd5fs5KfXrtmV4QmlNhUwqmiAjFNnqzvNjz067br7dyTjgz1yLM9sE1nDjxoa
         LwLw==
X-Forwarded-Encrypted: i=1; AJvYcCXGw8evM0L6mzdFXlZM7lkk8hrzHSwyK1IcarEcmQE+91lwDeswUytaVCuKuNnpTEWMgz6YNeoI117Immw=@vger.kernel.org
X-Gm-Message-State: AOJu0YykDHJCHZOPV0AymUkEHopskJ3sRRyl7HFE9E0lUXu6nVNMtC/L
	VDknXuOKnNFt60MAD9knebCLYwWHd5hW1X0Vx2r1W/OOOGr7T8IUvPdDzGGbZsTTijE=
X-Gm-Gg: ASbGncv1NX/gXT1hzEtmaQ1eqX8eRJr/64tIg53B/tdPvNvYOwlj981vpOILHjioAvD
	KdBlo/lz8+yxjWKyWNzQ+uUvRoWiwaJmRbdeb5hqzLC/DhWZMbWdHQD6FsSJzb63nE4tyNA2D1n
	FjZHkE6f5DwlkDPoEXPzmyPOzC66I6RL6P1HxvMDMAUnfrrzBkjVFVGTuVLMm9UeMhXEH2v/raH
	dmZmVAwf+DmCeZaXd/ls0MWX574IoJlBKu+MMPi+48tUuc0phjA5paG/HTSpxLlhN0P9PwfoU1F
	KD/4ExJC2HgX6XKPkL6OEpDwxsGPI+XJIQnxCnrj/vuR0n9MGCYv6/rbt8aGzneFbK8ywAl6zGi
	DK+g3KTfaJ74zsFNPaJRcQ8BvjGDRLx8jEpzWWqg=
X-Google-Smtp-Source: AGHT+IFrIo3qo3Xq7DrVRugRg16jg4aCYHopevdB0f55AiC+g1RwMciM6Lgy4L9vDkABRNtjnbIHXQ==
X-Received: by 2002:a05:6808:30a2:b0:409:f8e:7272 with SMTP id 5614622812f47-41cf0cb0f3cmr543563b6e.38.1752620501381;
        Tue, 15 Jul 2025 16:01:41 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:9b4e:9dd8:875d:d59])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-41c73a25f04sm457282b6e.0.2025.07.15.16.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 16:01:40 -0700 (PDT)
Date: Tue, 15 Jul 2025 18:01:39 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] spi: stm32-ospi: Fix NULL vs IS_ERR() bug in
 stm32_ospi_get_resources()
Message-ID: <fb2a26a2-119b-4b5a-8d44-b29e2c736081@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This code was changed from using devm_ioremap() which returns NULL to
using devm_ioremap_resource() which returns error pointers.  Update
the error checking to match.

Fixes: defe01abfb7f ("spi: stm32-ospi: Use of_reserved_mem_region_to_resource() for "memory-region"")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/spi/spi-stm32-ospi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
index 72baa402a2c3..f36fd36da269 100644
--- a/drivers/spi/spi-stm32-ospi.c
+++ b/drivers/spi/spi-stm32-ospi.c
@@ -823,9 +823,9 @@ static int stm32_ospi_get_resources(struct platform_device *pdev)
 	if (!ret) {
 		ospi->mm_size = resource_size(res);
 		ospi->mm_base = devm_ioremap_resource(dev, res);
-		if (!ospi->mm_base) {
+		if (IS_ERR(ospi->mm_base)) {
 			dev_err(dev, "unable to map memory region: %pR\n", res);
-			ret = -ENOMEM;
+			ret = PTR_ERR(ospi->mm_base);
 			goto err_dma;
 		}
 
-- 
2.47.2


