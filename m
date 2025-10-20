Return-Path: <linux-kernel+bounces-861361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B642BF2877
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F1F464F1A42
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618BE330B1E;
	Mon, 20 Oct 2025 16:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="2d3D0YC3"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45FF32F765
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 16:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979122; cv=none; b=l/oTMZ3/96T+D7rdVjZBPAFr9fj1PigtLpg0Cxc5qVDCklAlH2W+Q7NEeVjeh/zeCkZcGi+HwVS79vLb4BjeJ4BYZMZkwkmKolkshOE4nkYj/pqRch9sNUaxsHIWG/4bIyknXr/1OovEcg5ENawn/Th34U9WL6ZXEfh4ykP8lnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979122; c=relaxed/simple;
	bh=gzZET6mP2OucMjDQ4thYViOeZ8/OsV2OQsQvxJj19l4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n7uOvOfzWuGpLe4Xlb+E5BDeJ+68zhU5Yl8U+wrv/7z9tq5569EbNR5whYo0JJH4Q6cD6eU5Mt1hSY1B2qbTcZNGoflPPHDQw5I31K6MwVR4x47hGogPcuB26BE1az6nfzIYMVylOgGKE5lIlIWS1Z3tbCdHCEZOXBaSna2YLGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=2d3D0YC3; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-940dbb1e343so44533339f.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1760979120; x=1761583920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAFHx5Fe28+JucgqjXAxBLPfwtGRK1k39/wAp21/umo=;
        b=2d3D0YC3K3FJP52bQYr6pQ6xtsimF+G9blY4Uwb3rne5njWGKZYidz14jLmTgx35SE
         X1UM8sCtqPdT6O3UuI+fzsGAQfzyEzEEn1VkrpkGsBTNPx4aWPs3y9R9ZfFm4ukdtP8e
         ZFyy/bSPrh4joBEe/zIp86kJjkar58fwzeK9ewZYONp8BtpS6pHhAdqyMfuTFWpEMNUN
         6FcsKWaLclMDpxnsvYt2n5fY2ufVFr0VYwuoWm99AVaJZdedHMYB+wlTfpINKmgaImR/
         9lPEsp2DKOCwTFRp4t0olR/2Vpq82fT8zeuJOVSyR5WIOm0k95oN2zsCM8ILpbWH7F4Q
         47mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760979120; x=1761583920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GAFHx5Fe28+JucgqjXAxBLPfwtGRK1k39/wAp21/umo=;
        b=s2ZFOokRKbISG0K4U7RVwt2eOtNfFLibnlosDY5oh1UepWUYREcookihOC4j6aKgGP
         F7TLhaKYv5AMgLctmDKlceJa3wtD+D2QCzKL3QBypkEI51oX1TU/T373oAvaMCwzt0BV
         pqWrClMLsLrK2+FpTehrfggUKo8neIWRNBajMaakF8JsJcl8pSZWVhmmjYluenh/CVYB
         r6q+aMufQdtjRI6hv0VjUt8Hs+hJv4SPCQkcjbSmFCqimkyVeVd3qnLjgy+90cIoJSWg
         3bBskr8dLbGxTU10A1kcFCT1s/RTI5FB6kRteQI2lFN1rJLXpRbSOHKWCyuQr1XFxpJr
         9FWw==
X-Forwarded-Encrypted: i=1; AJvYcCWZqAtVnYljw0z/8eansKuUnMsmTkCM5Uu90ac6mzKe4QFlfc2/6VkkjUUIFArexbyecZfNfV92su+Cd84=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywem26IanQihrEAYTQ+m2776nHAPvIysuC+GCoFwux9mCZdf6+p
	RUfZpjAVKIlDna0SNm4C3Uj1n5SHLSBp1Gs0wF3BVlv8IdemmLbylmsRWXxI5ok6wtM=
X-Gm-Gg: ASbGncvfOYWFKMj+5Vo3RQCVSMZl0LDFXJQ4/LJLwyXXPMUYmnN3HuPL5ghxm3osdTW
	du3OGNkeE3i+LNy6sIT5J/RDypVSe/+iALBfRckoCnuvUQ7NS9CyvYH9I5/6+H1dDgiMkTaf9Uo
	kQiCKPLIhPJExOrGlp58X0zqxNeNhWdoOaAypkXvEKoxV+Ygugp/ncIFEnhxzV5iactuTR7x0ag
	ebln2f+WlukTyToyAZzs64sx84Ez2tfbmZDtK5P0VUIHtysaUAPnLLjFsnmcteQHEdsHR1AYmhy
	Nq5+IWJ3doSPFYNVNZoe/0ID8XWCRy+K34J1koo30qoaIQB0JXCQ3O/7oZcNU5HYBnk+av0/LRM
	7H9t+A5nCp48UybX6lvIIcjHBUXYb1DYQzPdA5jszBPPWQ0ozv5pOWP0rGaCLVP6tPA6i56Q4XB
	IKZzN/uNSWxP0h9FOPZIslZgOOs1numSuJl6uE8HF1rWcGH6MNi43ngQ==
X-Google-Smtp-Source: AGHT+IGrysi/n+6wy3sDQX5W8PX80X7sxp0qMRXdkSjXbUhQItP2k8/GDMxk0YCbp0Wy5FwbdhktFw==
X-Received: by 2002:a05:6e02:3e8e:b0:430:ce63:4180 with SMTP id e9e14a558f8ab-430ce6342cfmr168487305ab.8.1760979119873;
        Mon, 20 Oct 2025 09:51:59 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a9799428sm3116783173.63.2025.10.20.09.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 09:51:59 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: han.xu@nxp.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlan@gentoo.org,
	guodong@riscstar.com,
	devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] dt-bindings: spi: fsl-qspi: support SpacemiT K1
Date: Mon, 20 Oct 2025 11:51:45 -0500
Message-ID: <20251020165152.666221-3-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251020165152.666221-1-elder@riscstar.com>
References: <20251020165152.666221-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the SpacemiT K1 SoC QSPI IP to the list of supported hardware.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
 Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
index 0315a13fe319a..5bbda4bc33350 100644
--- a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
+++ b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
@@ -22,6 +22,7 @@ properties:
           - fsl,imx6ul-qspi
           - fsl,ls1021a-qspi
           - fsl,ls2080a-qspi
+          - spacemit,k1-qspi
       - items:
           - enum:
               - fsl,ls1043a-qspi
-- 
2.48.1


