Return-Path: <linux-kernel+bounces-743911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FDBB1054B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 836DD3B7AFF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F05C275B09;
	Thu, 24 Jul 2025 09:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8MzVUZY"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D752741B1
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753348286; cv=none; b=pCUAkjR/tAavPM/hchPyZEj6JpRuinuMiuXxlM2tza2uUVc5Gm3BOVLJ7ze3LGcfQOIeQfkHo6XU99lBoig3HGrHe4aTuFM9Fycr1+ecz73y+kqtGqwTT7f9fLA7Q0dEFyQ+Cq3JnAJEzS6OhWqDxTSAU97c1RMBzmdQeINEXo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753348286; c=relaxed/simple;
	bh=tbSQFNv/MhoaaNn3IAYkp7htH5eTqjbWGRjBTP7jM8g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BfxyJFEnz/REUs6/6w0g7wV1dV7IWftvlGf1zSFN6TkF4f9eKGsUE6UOQjyoRwCKI5lzgh7IA4tPZ9HQUb3cQ4w7SZ2SkSNRfdrKDWIA3QKu+7RTEDsCJ26NNqzNxSOZrJGyI1wgfLBI86KplTTNd/+8mNYwWobSn8tAzpp6WnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8MzVUZY; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6facf4d8ea8so5965256d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 02:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753348283; x=1753953083; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SUpZoTRQ8PHSSxzc5T9RmNDL3NO3Oqu60AwZYecA4DI=;
        b=N8MzVUZYPZG3Jd2RjXUf9/6MQal5M+UfgivN55sMCTPvoW0ZwUbaXtrjHa0Kt8GOVV
         ifnHTC2lgLfowjl8MZGvCN5kvsEtSoWY+er4s1tmsZvH/LB3NxtYonpM4dsLSf1uMrpz
         PkB+qUNU6yJ5WksbwL/mGQuemKdqkVTUT2NKJlRKSqzsLCeveHTzZjiCVYGteEK5OLhw
         Tj5vjrvKGBsmA5LVeBTpvQ36YJ3v6s3POyZDxfO/8dP30Erpy9X75F+YKzEJ51zfA/rH
         mdNg+gF4xi5ld8J7PbHozl4Tfv33eAP3dKtsvywFLUHK+MLWvimFgmLqZgJ+otCf5B4d
         Jdpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753348283; x=1753953083;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SUpZoTRQ8PHSSxzc5T9RmNDL3NO3Oqu60AwZYecA4DI=;
        b=jeoDxwBrYil00wmFAWCnS5Xdou76qpblsqZ4CYB81MMZYHjuuKP0z8vG57zap7AeGy
         MAPpTdoCgyPq6cr+BtWkfbjApk0TzX8pkv002yXQ/pcBJ45I/cCJKPKKy/lkevd1yJ9+
         REGThxzH/pxrGndMAN6mU3skIhlLFxVwWHrFu7rsbyu6VHQjk0yyqPFvzaT4m0t+Yiob
         9ETDIa7fK3qrWmM8xXPpF971qn7zpiDR/rTIQb0Mno8rRWwUWP7n9j2jOls5bJ5RjjGE
         66NQ4NiEwrxXyC8afaZoo6QJka012oX5y/P9BxjASdLiT4LvAYjylRp1WLB7Sk3a/M1f
         kJxQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3Ng/DVzoy7TPtMJCLymxjVSgJKzVAXyymiTybmpZGIlk/DrmZy0E6bM9k0JZ3X1j4IUEku4994k/Bj3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOOHKk1xLa9Aof+CzUnHEFhMX3AUQD1/32okbSJzhoYbuYEOz7
	hOdp2WBo7HddVhsyxdoZY/+savmYSoHG7TRWnfYIVgZ/p2gnsjCvIOEWeekJQtVF
X-Gm-Gg: ASbGncuTnoTR36LqG+ouJ/isojYbam0AK7IgKhhZE6H0zA76k6c6iCRJ+5ITnKBAQAm
	GM1Gyaje+5AzBY4MIs4jSZmjPC73aBNgkwVlmMLZ6XXS2yRT5qTmKdcDLiCMTt5087zSvniQnro
	7ESOpVfaEnf0DpSHPgmhb10eca7RY3eum3LSHcGX3dOWt/pMVpgjmUSbWJDQ9W2NfePtYO0hAtk
	+qwnvsdXTPtz1B0pK4tJCCPIiOpFri7Vwl2UeJ3ZIAiVX9IA538X9DXintfZGNqwzmKVk7fYZwa
	YIB+zTinyWtCOnjljeatYLfufFYaMwrl8O4hzP2bPvAcRwWRqL8GTaxNMd11odwB1E+LbHTSDtL
	BQ0rpYIpjKTidLDcwDDe0
X-Google-Smtp-Source: AGHT+IHO4MmWhNszJAhYF7A2fvJwzKpVbb06gfKWDB8KDmO4dX7UTL8XS8aa/TNr1h4dn+AU9ra1tA==
X-Received: by 2002:a05:6214:1cc7:b0:701:9d0:1408 with SMTP id 6a1803df08f44-707005665ebmr81663376d6.20.1753348283342;
        Thu, 24 Jul 2025 02:11:23 -0700 (PDT)
Received: from pc ([165.51.88.28])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7070faec0aesm10781906d6.8.2025.07.24.02.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 02:11:22 -0700 (PDT)
Date: Thu, 24 Jul 2025 10:11:19 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: salah.triki@gmail.com
Subject: [PATCH] bus: fsl-mc: Check return value of platform_get_resource()
Message-ID: <aIH4t9Ekj8hn7EEk@pc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

platform_get_resource() returns NULL in case of failure, so check its
return value and propagate the error in order to prevent NULL pointer
dereference.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 7671bd158545..980d427e857f 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -1105,6 +1105,10 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
 	 * Get physical address of MC portal for the root DPRC:
 	 */
 	plat_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	if (!plat_res)
+		return -ENODEV;
+
 	mc_portal_phys_addr = plat_res->start;
 	mc_portal_size = resource_size(plat_res);
 	mc_portal_base_phys_addr = mc_portal_phys_addr & ~0x3ffffff;
-- 
2.43.0


