Return-Path: <linux-kernel+bounces-817635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C027B584C1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 20:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4263A1A2877F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFAD329F0E;
	Mon, 15 Sep 2025 18:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aevUUoVH"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B5A315D33
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 18:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757961468; cv=none; b=Vp2B6+TMqAw+vC/exmt3aTC5+qKYbtDdr8hqfNeGYMtGjM3GSJKlMhonIgEjF50WHvSePwMgR9xDl62j5PCUI9YB4B2hJl8g8SoahBoiyAX+dW1tCZGdRYcTsGTHqxMXmtH++n+IJStO99R0TNyjHrKq3PgJpwpH33yYjPk+n/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757961468; c=relaxed/simple;
	bh=QAbUqWkSjFj8vv8re1gL9uKqrXQ0aq6hKWDoZOQJvFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aSUF8PxJRhMx+26ixiM1FSxi5DM/ltnDqy2eNyo8YBU3q2BV4vQ7ifcCiSmv5s4WbYk8iNefk1IArz1wFRr0oxdvP09LelA03DgH1vl9HOgDzo2shpsp4MI+e2wu7ym5u7m/YV9EhLdHWX6FZ+nr3VhIRszOx6aZXNmdm7Hock8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aevUUoVH; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-62f0411577aso4648423a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757961465; x=1758566265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmTJoZFxd/UizIvu0+o0FQEf2UBZJpqtSSU3Va1l+q8=;
        b=aevUUoVHBmIA9VPTJJNym6BAw/UGnToVjolgsCMnPHcho+It9JFjgh/mQpXrINXpaq
         PgXDDgZlrKcWboxFc3FQSr81VkzZNVcXFnJzZF9H03HMQb4hPlURP/ctHq4yWK9hudWF
         8/Hr3y5WVknCbMJrArzKdJe9HjkUvucW0T2nVliCzxVnu/QyzxcD5eMq1OE7C0lITNCJ
         o6y82XfCj3a75Rg75WA0XYG0SHgogbtYunGzinpsrOobmGw+dqHuAHfRfP87pn5MspQy
         5LeUsc/3GDLySWPUaKT9Ql4YSKTNrrMfYszE0U01J/SMl23DmKRvXE3yGee6m1CXQTCl
         lGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757961465; x=1758566265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fmTJoZFxd/UizIvu0+o0FQEf2UBZJpqtSSU3Va1l+q8=;
        b=ouvhX0H8uhrMWG4kHOKd0wqZcPfvcl50+gdR/swW7AT5lFceMw+sD56GIy/jJagZTB
         eR0yeNIabfaC0B0j2mgBX482RTNgFKFhapmN5h2uvvBfEYg+5Nt82KL5qVs5HUQsMHYO
         riiIKQs6P9MT97jeD0uSqeG9RQ08++/jELI2ra6b2uvwMi6T8X6NBwFKzj9HnyTT2kBe
         31Vr+A2WXJtQgOuPe8o+Nqic3EqwWfQaQ6gkc3iIC/ydZlw2mGxEhGC0Q8pGKqt3Ka0m
         IheozoB7IhkPOx90npUIuwDvH22thpUUbovEM+LDnb96R8+66Q/5gq5ivJOrvJwykzVK
         Jzhg==
X-Forwarded-Encrypted: i=1; AJvYcCV0Lbdv2GcJaerPK7CjhyP1Zjy3sPbdxpWUHOwON7k0mZIl1VhriHHsaJ+KyPqsf6ZUS6N1q5Y7uV28RlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV7t9jnTTGjjc2GA6cNTlOwO//WJJ6fZRSFnaVWV4R1+WRDZNw
	6tXdaDhwToeSDvpxrxtEkoQTAAGEwSz+K5aNjnh/tIshvaundf9KY/uA
X-Gm-Gg: ASbGnct736u6FRLv7t60H0Z6K0FXLQErKi1YjQy+G2H28LyeWA/WlGQu18lGGLZdkE9
	suOJcw6IE4GrmharWcnZxuvdgiSqBJm9mxXQ4wmfH5fVbhmHLGlh3JBz22/g2SWoLyahf3nrQBh
	kRCzkeNdPozFtvvQ2788z8E9aYHyGipkHs77arxTaIqpeikbxdmX8GFHsL3OTq8o3nARyLIHoGw
	ku7Qk4xwCqpFpTkGrWg/AK8jUXE6pI1BkqnirGK9KUT1MKdKNk9Y3lI6bsXTbc5WSysLFfZp9zv
	Dd6YtIJVyTHtUDnxDRaXyLgkFyjWFyr0K7DLV88PhnwoOskEEN/gCECPeF95UBbr4YUQkRYpfsh
	Ha8pq5WoP7M3Te0tKRsu316zbid8wivO3IgXweJ0boePEnlgCmCUJjjPDqsGzbrQJuV1BdF5mnM
	mqebY=
X-Google-Smtp-Source: AGHT+IGWgnAO5l3hIYL3IEZLVlHRwLHiJ4By/g9hfpqmnTd2frdisat/kWwywXjBeT9mDnq7CCvwzQ==
X-Received: by 2002:a17:907:6d29:b0:b04:85f2:d26f with SMTP id a640c23a62f3a-b07c35bd9b4mr1581764966b.25.1757961464914;
        Mon, 15 Sep 2025 11:37:44 -0700 (PDT)
Received: from localhost (dslb-002-205-018-108.002.205.pools.vodafone-ip.de. [2.205.18.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32dd309sm991919966b.53.2025.09.15.11.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 11:37:44 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 6/7] spi: reduce device chip select limit again
Date: Mon, 15 Sep 2025 20:37:24 +0200
Message-ID: <20250915183725.219473-7-jonas.gorski@gmail.com>
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

The spi chipselect limit SPI_CS_CNT_MAX was raised with commit
2f8c7c3715f2 ("spi: Raise limit on number of chip selects") from 4 to 16
to accommodate spi controllers with more than 4 chip selects, and then
later to 24 with commit 96893cdd4760 ("spi: Raise limit on number of
chip selects to 24").

Now that we removed SPI_CS_CNT_MAX limiting the chip selects of
controllers, we can reduce the amount of chip selects per device again
to 4, the original value.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
v1 -> v2:
* reworded and rebased onto newest changes

 include/linux/spi/spi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 49c048277e97..df4842abbc6f 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -21,7 +21,7 @@
 #include <uapi/linux/spi/spi.h>
 
 /* Max no. of CS supported per spi device */
-#define SPI_CS_CNT_MAX 24
+#define SPI_CS_CNT_MAX 4
 
 struct dma_chan;
 struct software_node;
-- 
2.43.0


