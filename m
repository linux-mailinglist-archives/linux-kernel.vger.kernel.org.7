Return-Path: <linux-kernel+bounces-889940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3667C3EE30
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 09:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1FBE3B164B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 08:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54634311C19;
	Fri,  7 Nov 2025 08:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvAUggh/"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DA03101AB
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 08:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762502887; cv=none; b=pLjwxjhAKX1r0usY+L6L72FgRUKH1OZuFCIPMkE1YNDfSp8CvtOOMQhROZIudZ+ctsz2EbuQn77tdCgUzK/JgqcRPtzVDCY2Tb2V/SmAnjlWUCbiIoA8qgiZ18Z+Rn2X6e0h6QxlcKZzbBSj+3O8fYANobputu15Uzc71yHLA9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762502887; c=relaxed/simple;
	bh=T+fv7B4EGOErJ4vvULFWmw8UusTVspY0S65zOSRYCp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UoRMo60UNdeV9XyOdUIwwQE+7v+4YkDePzPkniGBPXkYNzyQVcm/fp534gB2C3m9p7//DRPQXVGECfGHIZJGvSXWajeqHVoWhZCFErch4by8nnEdQph432QVUSX5IqpVdq5xCH7rIT8TBwDAnt5ALBlCfB77i/v08w/o+BpEs90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MvAUggh/; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b713c7096f9so62263466b.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 00:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762502884; x=1763107684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xZ5yli4HyPeAHciL3B8npkM3Dz4xiXZ5nUJPMyAy7w=;
        b=MvAUggh/j9KbagwjBgk/EWhlAc9pkXVQolxRfhDIb4KSplp2OHsbD8sJwBLi7AfyzX
         D6N1Dl9AG9Y/wHQiJCbO9khKXe6X9cTGDC9UmCDtCxclGCQkdYekgKZGhbFgJbHY8fVw
         85IW4mhTm3kDJVN2AoiALH6BIUm0Ma7Q09IMG/gMJ0xBQXY5yAVGBfUaAYXrpglcR81N
         M5fEKOkGCCIqv2YVSdivla4EOoL3nduNJkvGqP8zbXJ8NUU/z/9JSYdb8lhQXShI24jA
         cyaZrAaUsxK4XbLDWUEbtNB4K14LU2eOa1/9XfSfXEYQML5bodKI8As0otegYcpub80U
         Rg+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762502884; x=1763107684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/xZ5yli4HyPeAHciL3B8npkM3Dz4xiXZ5nUJPMyAy7w=;
        b=xLgnetw5XzICr5qaVr1/SytjL0rfSBCLivpwLNtdZrMz7PI6A4bPQpWwZSEtMATf7K
         gfXdHr4YAOpY6YZTDDkLjo3LbnROZ7xg8gXAEPbbjoKJx7QwxUWVeDFZUlGcRyCAzGr5
         X2V7ctqly9cf5IN+Bd1LywrFwdVYT1H1XJSQem0qVz88Om+MZW9mb7uaJnLPXXmxLcue
         WPin3dacFQP59TFlm9YWumNLcK3kM2TyH9eOuh3+VMQczy+6L85psdX83X7avUBJBzN0
         Bi3opSeB9cmFxDwEST7rATf4zhc7WEDYrSLD9syFu0WAwYYfTydln54NzEXMGI6A2Cp2
         IFug==
X-Forwarded-Encrypted: i=1; AJvYcCX+fNm2vfOeuNfyfFRx6DQ0B1sb/wBkEoaQEyV+Ev6c4s9+6l+JEpKDea3mjvCOCsfMSS4LKy/3NZjAnpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhUKRnFzLTKZ/85SiDIITFbwkAJpDSSAgCpvx2tHkXqYlvfYwz
	zbh+MTmFohZoRHu+4Mac+1wXp4jShT2QVic9WNw9ss1Z3FESt8swRXkJ
X-Gm-Gg: ASbGnctzP5BBQda5tkGq1D+2LMzFGgiFC966K6LiZWBZcOSODKE79Y8jhWhgNXeB5lD
	MEYmKiiKOZNtmaOJwBkoR3n4KE+uCuY3tRIrLUo2WghENuugwPWq0QGaPNW7Khnfd8cIomR0Vl0
	nVs8nmBZHxS/wk0K8CDi7/sw93ey9vgUtj1W1Gh2Mo1P+IfOLGRI0JZHna3E2eSQrf3hNvywaO3
	eaSG3H9KfGzbqky6pm4R8UsqK12GJqtY7fY56QH/IcxwF10dfcLI/6AeVSUqaMjbJ4pD+z42VuP
	quXdy7Q4KqTIVQ3LFpKTFcvGdnkcZJDNOlms3ACAdDm+7fnyYxRXRC6FzZi4hchq0bbOckrW/q2
	7qSDiJbCcEIGZL7JlH6Mb3ok9M+zRwETBtTfswUA5Z+wpdY8YViKbkpQDMr9FYpuLZ22g7lTgub
	nstvLSBRjuWPeth3AcDLLMQqw0g8AaO2nGi58Bj6UsaY/9Sy8Fe+RS4lER
X-Google-Smtp-Source: AGHT+IH9b/MYYIuDyWdT7ZTBQkoaDfwy59F6a7uHK4JT6ZExE1cuece4EF876eM8gMqHiUFkgjKe3Q==
X-Received: by 2002:a17:907:9608:b0:b6d:5718:d43f with SMTP id a640c23a62f3a-b72c0abc187mr227415266b.39.1762502884014;
        Fri, 07 Nov 2025 00:08:04 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf60ef8asm173812266b.30.2025.11.07.00.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 00:08:03 -0800 (PST)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/8] net: dsa: b53: provide accessors for accessing ARL_SRCH_CTL
Date: Fri,  7 Nov 2025 09:07:45 +0100
Message-ID: <20251107080749.26936-5-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251107080749.26936-1-jonas.gorski@gmail.com>
References: <20251107080749.26936-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to more easily support more formats, move accessing
ARL_SRCH_CTL into helper functions to contain the differences.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 37 +++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 9eb7ca878e30..b13437ea21a0 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -2033,18 +2033,37 @@ int b53_fdb_del(struct dsa_switch *ds, int port,
 }
 EXPORT_SYMBOL(b53_fdb_del);
 
-static int b53_arl_search_wait(struct b53_device *dev)
+static void b53_read_arl_srch_ctl(struct b53_device *dev, u8 *val)
 {
-	unsigned int timeout = 1000;
-	u8 reg, offset;
+	u8 offset;
+
+	if (is5325(dev) || is5365(dev))
+		offset = B53_ARL_SRCH_CTL_25;
+	else
+		offset = B53_ARL_SRCH_CTL;
+
+	b53_read8(dev, B53_ARLIO_PAGE, offset, val);
+}
+
+static void b53_write_arl_srch_ctl(struct b53_device *dev, u8 val)
+{
+	u8 offset;
 
 	if (is5325(dev) || is5365(dev))
 		offset = B53_ARL_SRCH_CTL_25;
 	else
 		offset = B53_ARL_SRCH_CTL;
 
+	b53_write8(dev, B53_ARLIO_PAGE, offset, val);
+}
+
+static int b53_arl_search_wait(struct b53_device *dev)
+{
+	unsigned int timeout = 1000;
+	u8 reg;
+
 	do {
-		b53_read8(dev, B53_ARLIO_PAGE, offset, &reg);
+		b53_read_arl_srch_ctl(dev, &reg);
 		if (!(reg & ARL_SRCH_STDN))
 			return -ENOENT;
 
@@ -2099,23 +2118,15 @@ int b53_fdb_dump(struct dsa_switch *ds, int port,
 	unsigned int count = 0, results_per_hit = 1;
 	struct b53_device *priv = ds->priv;
 	struct b53_arl_entry results[2];
-	u8 offset;
 	int ret;
-	u8 reg;
 
 	if (priv->num_arl_bins > 2)
 		results_per_hit = 2;
 
 	mutex_lock(&priv->arl_mutex);
 
-	if (is5325(priv) || is5365(priv))
-		offset = B53_ARL_SRCH_CTL_25;
-	else
-		offset = B53_ARL_SRCH_CTL;
-
 	/* Start search operation */
-	reg = ARL_SRCH_STDN;
-	b53_write8(priv, B53_ARLIO_PAGE, offset, reg);
+	b53_write_arl_srch_ctl(priv, ARL_SRCH_STDN);
 
 	do {
 		ret = b53_arl_search_wait(priv);
-- 
2.43.0


