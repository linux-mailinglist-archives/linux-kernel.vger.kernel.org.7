Return-Path: <linux-kernel+bounces-872972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8931CC12BAC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 04:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91605587ED1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 03:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03E8270540;
	Tue, 28 Oct 2025 03:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWzsOQRt"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C726517C21E
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761621348; cv=none; b=OboKJme57TYRlEcQwNfd88oYHX87rtf9Sf8fr+8BINOVOrA296KiqvfifCHWPVbKg4mjNUJIkCxqhbOU9Hc3gLDViFogNU+Z/IxmWqM97Ip5qMUMhamjb6y95RsKqxPHOtOCkw1SW7/u8HMIpROb6rs9OOLjW0eG/OvvTyocLFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761621348; c=relaxed/simple;
	bh=WSsr4NQM/X+04B22IETHzX/8ocEsGUdwUHkdEc1qYYU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nTt8S3fDaXpUjMVJRukFQBSTD4ZiHQBYap63arJ/y4P2w2iaD160gUbhTm803LT/HK9CciPyP40/QB/4xF/5858fp0M6wrCVxjwUZt0Oqx3OT/0vULKa3fdb+VyppW6XiVWCxTVmT/t6uCrgqgOASABHfwu9ZtJIp7Ed87tRpOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWzsOQRt; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7a27bf4fbcbso4540715b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 20:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761621346; x=1762226146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Iwk85JlTUEBI3yJjsshayntPryiTY23zzfTEHf0Um/k=;
        b=LWzsOQRttv7yvjSu9wrVk5l3D6T+jR9/1I9CYLKqUydBp9ZobDKxk15MuVKV/dXg8l
         w8k8zOgahvYxTN+ElQdrvz6v4VbdGeB94/fKRhhgn5a1XnXyL7FdEcgXzOZ00HDo20NZ
         C5f5SFA11xnYq1WeoN55FbpAb+kOmu5XhY6BJzH8t1/HQx/tZu/7ArXftTCA9rVQpojq
         HGVnQD2yQM3ZIQClv+BkLVsOIVV9P19GHR4BetK5QMullRFhLcs1gkxQiI7AFRJKUJlk
         ho1+BVrm3WN1mHqMkQlPTJhastU5Dud/jMZ4MuiWLp7Jlp+2mERSbDRaSp0syC9amybS
         HgWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761621346; x=1762226146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iwk85JlTUEBI3yJjsshayntPryiTY23zzfTEHf0Um/k=;
        b=oSk5SGR86ZxM8S0AdyQajYwVoMDHaIQAm77EMmOLazJjhxMWFSPDWZpVT2g8xi/SuQ
         sfimX/FiuMkfB0EJI6VKs2XdQv+OiCgpnZ+nueaeUVw/8GAZy3nir1rueMX9qnbCMMkE
         c/j/dUsnjZBYpVqzB6vFPHqfjak80S8J91M2KxGW+tedn/QCKqNWXfPnJ7Q0moF+kzDF
         T04FHL7wSQqQyDur/f5KGxIUZEDuW3wZCIWT5WF9hGHqeuOnWgU7Hwi9MNAcVLHkRfwF
         9tE0JsPlxyGfgS6Y5ykeoG3obdbrJeEa5L9eXCBFXjGpKSs8uEVNu3bMwo46ANF/BPtK
         5cOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWH0XQBnbATTWGDf6MviVWSsHg8mmJXel8+7xXjfMGOyWakYIaU3/e9WVBiuIRotKOjjh4KxnvPx18XlLk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy02rtcxAD/yzUD/e/SdNoBTm8xVL5N3v93actRIjYA+BzDNwqA
	aeg97qPtLwkEK9Xg7Fl2C+2zcptGod2xzN4HZIzVBudrTGcyW7HiaN7z
X-Gm-Gg: ASbGncvR1NGJLy9iAJ3jKxVlPndN32tFahg3ECKHvntmDeW822RxHK71KH+dPEMllCU
	8wpnAWmt9jZ2SkhwJk7i3MdXV7sqDW0vutTVNvOUmZYtuOdCvw5+pS0WBlzfOGtXE5Ax7WeVcYN
	Ydczb0d7maL08TXNhS8Vqtoy7KVAXr26A4g4p5iYJsxnZuVoIjg8bmusIu2lolChfo5LPQoVuAE
	p2CV7dEEmagiwCSsib6A2aHo0ZdBOuUJV1xXke+J42/nObX5fdSeYfUD7vQYT0jW94SV05mnsOp
	JGny1gR6f4EXqCRvbQL0UohcS9nIU2/TwGtaZoe2qbAzD8ndX3ty4u8GfwmQJXaX/Q7zG12h+5L
	mxdtfvfFigSCIhaPNrYnDLdMs0JgX0wTjQy2PtGOq7K0zMM4/soul7FURXSQwFHH6+KXIhSNsaR
	r53VUCQr8Z5uOfmwNJV2j/hQ==
X-Google-Smtp-Source: AGHT+IGuxaZzDv7SIXihLd34aYSMzDHA1ChbWY+uD7KdVdbaExQIFl+ZQhnMyiYov0T8YhmH+laVjQ==
X-Received: by 2002:a05:6a20:734c:b0:342:c891:a9c6 with SMTP id adf61e73a8af0-344d1baa8a7mr2317412637.1.1761621345900;
        Mon, 27 Oct 2025 20:15:45 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b71268bdd50sm9123455a12.0.2025.10.27.20.15.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Oct 2025 20:15:45 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Sam Protsenko <semen.protsenko@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] soc: samsung: exynos-pmu: fix reference count leak in exynos_get_pmu_regmap_by_phandle
Date: Tue, 28 Oct 2025 11:15:27 +0800
Message-Id: <20251028031527.43003-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver_find_device_by_of_node() function calls driver_find_device
and returns a device with its reference count incremented.
Add the missing put_device() call to
release this reference after the device is used.

Found via static analysis.

Fixes: 0b7c6075022c ("soc: samsung: exynos-pmu: Add regmap support for SoCs that protect PMU regs")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/soc/samsung/exynos-pmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
index 22c50ca2aa79..a53c1f882e1a 100644
--- a/drivers/soc/samsung/exynos-pmu.c
+++ b/drivers/soc/samsung/exynos-pmu.c
@@ -346,6 +346,7 @@ struct regmap *exynos_get_pmu_regmap_by_phandle(struct device_node *np,
 	if (!dev)
 		return ERR_PTR(-EPROBE_DEFER);
 
+	put_device(dev);
 	return syscon_node_to_regmap(pmu_np);
 }
 EXPORT_SYMBOL_GPL(exynos_get_pmu_regmap_by_phandle);
-- 
2.39.5 (Apple Git-154)


