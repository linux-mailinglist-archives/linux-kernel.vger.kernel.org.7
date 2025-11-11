Return-Path: <linux-kernel+bounces-895660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52242C4EAE5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BCC942106E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5AF303C8D;
	Tue, 11 Nov 2025 14:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfLER98K"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41DF25C818
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 14:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762872272; cv=none; b=UejBsV8aHmyDZd9tiyBiRg65KvlhUEo/Uk0xVhsJDDYCTdG9eZ6A4d6n1dhRlhnBpYQYLodZEAjngTEfvUE6cYaA1jWmMmZO+vCb25G/EovrTFgj0uvCsgLgxlLrXVlzQBNJ+IVzaZ29GicP4X6FFgTIPeb8mrDHn4iuNEWRH8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762872272; c=relaxed/simple;
	bh=7qZkm47msQiGC9wUZgC0Pw7Arnt/Pg1GJgT2faSx30g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=axOdzV0VIKduNn7/CfJ73DiABbrt49vQ8VAGv+Bd5kxulygspsNIQZ5RCKXdMiRoZBm+EYu7r2/ZLIt4og3yLlRNEInCNCFerIyaV7KP5ewlsaDxmxqMUTeJD0V4jLHyF0+nypFIYc7ah3yFkEGxqNbnHAnnKYaKm4D8SRnCP8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfLER98K; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-640b4a52950so6319609a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 06:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762872269; x=1763477069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bSOY/KYVq1l+ZTGny5QvJvbkB22lOvmxEJPXtWJ9/7s=;
        b=OfLER98Kku72VjtxBG2TiuqdF1tQgd4fcIv6dzrSNA8rR0m8JiKIQI6YuP5SrFpd4u
         wWD6iOixcUT30VbY688npB/sox+G8QsYY62H0xrFOBUU2ZIdPXRwtJQOP9XELcu7tayX
         KOK/fGcG8eQKPMBDrvUZRPjWK8DRZ2SL0siaOUXKEIb6y6WK6KGEokMkKbrZ1PbjagNM
         SowoVkB6XVuupO12Kl2E4AvE58mU1qQuDeuSytx0x5iU5dLBjwLgXBMfRGqaLYRzEQir
         YIoYzuqaDYFZk/lx6lKp1b6sQqrJjZbxz6Ck47RJzYRFnbXwrsjuh4lYsWWoR/5SagAN
         n8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762872269; x=1763477069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSOY/KYVq1l+ZTGny5QvJvbkB22lOvmxEJPXtWJ9/7s=;
        b=haRNNxlRmo5Vazf1QLlkWTeJ1526sYkicokq0noNiThDVOvWdwtJIyHZX9uV76YClK
         aIVL9e2wp72tMv3Ve+/GlJ18c5+xVaBofgN64rX1Dtkc6RzR+ECOoUFhf/xFq3J6Ttyv
         tp3r/oZKxinP13AKxjsEGTsZljQejucGo0BxwEXapvv4fJvCpEIAeQrFhsG2djy0rYLO
         gy+CdVvTIguCy6KS6xLXYVMD0aHknBM7Eoj04eGpjgqourCD3/r06w30u3FNJwTCjzeQ
         LdaDu9YQRnGTqQFK3HlNOCEWm+RUV+9X6Mz6Vv/r+OmtvNGL8j5kkDubQ9XAY5off6gC
         /Rmw==
X-Forwarded-Encrypted: i=1; AJvYcCVkcLZSKkwS8rLEObWKMDy4uNw7IIRER1srVddZ+7uKul3d8nQ+DZ6vGrdu8vl/cHlu0c91l7CpnA7RJ2I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Qir48eIukqOhfEr2fBgQvv8E8XZWN5bbeNMGcpV2mUhCW+Xx
	1d/U/AYOY1O0StiKOsStlf7tYy5YFWUz/F8xblvyLAE5370koeegaax0
X-Gm-Gg: ASbGncsISF9m727SN4CdZ92592UHHTCYno5rc60H+JnI2EdsSZhwAWzN2XHU5oV9y1L
	I72m3ngzDrSZ8ofnHQEdX9BUeGrJC76pfmurjOW8QtJu1eiYs5XTQPa3r9uM1kRmWUtOVqj8Etc
	zslp0+BAQM34YHtX0Ezr2gcF4hfpsZRI/HdziM02eyxqigwDJuCdFqw+MbeAY0xNDtLQH8eX5MY
	ren4jz2betTzCdN28/o05d6p3Pt+LXNMIGMtyKdhlY/92fjLoV9qHai/Wv5Gtqf0yCL/g1b6sVP
	U9hplPRIsVbZbVWXSajPfANv8JeHmmXgDlh/bpcNrnIFLcOft5pLjp2iixV2jpNVPiC81EqJHfr
	FInx+ZMmzhzcV582ve2MBB8wnh5QB9WIjJV+3oTUDD3/O1bXS09IU5BFIgoC/f/qmKbWQ4ZaGaw
	l0Z5kyEA8lXV4Pcp36sJXFNZTzPje7oS66/KQSs1najagfBJgOljSoCr0Agw==
X-Google-Smtp-Source: AGHT+IFLzfSIruVyhPseL6KcmAwxsMRRRVGHRvcttnUr4aeu2qzhk3FXByCABO44SZU6s6Hjteu1zA==
X-Received: by 2002:a17:907:96a6:b0:b4e:d6e3:1670 with SMTP id a640c23a62f3a-b72e028c900mr970809766b.11.1762872268878;
        Tue, 11 Nov 2025 06:44:28 -0800 (PST)
Received: from fedora.tux.internal (85.191.71.118.dynamic.dhcp.aura-net.dk. [85.191.71.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97ea95sm1377118366b.44.2025.11.11.06.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 06:44:28 -0800 (PST)
From: Bruno Thomsen <bruno.thomsen@gmail.com>
To: linux-hwmon@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Bruno Thomsen <bruno.thomsen@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] hwmon: tmp421: check error when loading label from dt
Date: Tue, 11 Nov 2025 15:44:05 +0100
Message-ID: <20251111144406.7489-1-bruno.thomsen@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add error checking when loading temperature channel label defined
in device tree. Handling of error from of_property_read_string()
is inspired by lm90 driver and therefor contain same error string.

Signed-off-by: Bruno Thomsen <bruno.thomsen@gmail.com>
---
 drivers/hwmon/tmp421.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/tmp421.c b/drivers/hwmon/tmp421.c
index 9537727aad9a..1eded169e843 100644
--- a/drivers/hwmon/tmp421.c
+++ b/drivers/hwmon/tmp421.c
@@ -381,7 +381,11 @@ static int tmp421_probe_child_from_dt(struct i2c_client *client,
 		return -EINVAL;
 	}
 
-	of_property_read_string(child, "label", &data->channel[i].label);
+	err = of_property_read_string(child, "label", &data->channel[i].label);
+	if (err == -ENODATA || err == -EILSEQ) {
+		dev_err(dev, "invalid label property in %pOFn\n", child);
+		return err;
+	}
 	if (data->channel[i].label)
 		data->temp_config[i] |= HWMON_T_LABEL;
 

base-commit: 284922f4c563aa3a8558a00f2a05722133237fe8
-- 
2.51.1


