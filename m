Return-Path: <linux-kernel+bounces-866983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 546C6C01418
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D38C718929DF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30B53148AC;
	Thu, 23 Oct 2025 13:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRDPy2MI"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6B6303A14
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761224693; cv=none; b=jqn717fg9C/rED44vXGjU8E4IawZR/Rl9fufnngTPO4JKYJ+drVrektQtopqQXRiz9GewiCrTefWTfV7MrD+MiC6xV5h1sUe9IxoK23ZX4bgrxAlDG5Zv+4adyfgTrNDRY0To+gGkiDQzpj/11P7b3oDzTpUZ5z3TiYxVjixaiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761224693; c=relaxed/simple;
	bh=MZntrYzYxpIKR4lTEuQ8vg90cnWJfjxVo3eqGMp0mdI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=X2IWMUQVmmbXTAnJqLkRjbIHX+7yu0E6eUxOlGSeJFNE2ms3Da/dTv37angLI8Ee0No401dYOerOFAzRfx1CiDFxrEwahM3y735d3YGAs1VneU0SHK2LdD4HlgdwQaRxRBq2QqQ8LaMGGsgoA8sublFt0nghqVt7gwGjDXORYw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRDPy2MI; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77f67ba775aso986704b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761224691; x=1761829491; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=id+wIYbTFy4GJ5sovEHifiUi3WKFfS9SlpVUAwl/jlY=;
        b=XRDPy2MIfvKe3KdQ0elCbYt/EZ9FxkDveVOsmuBftxdASGrbQMlv/z3EExxk+VLHbu
         oBpxOE3WNtRlk4z+ZamqPJlXfdV05Fni7Qy47zuT9q3b35dJNCj0n0semYS7JDG+IAlo
         fUaZ/Ps+16lb7fwpm4RkG9ZUmHhiVLvEQzwv5Hbrn4eh9nNCqqgud+mClCZ7tZ3bk5Tp
         o4Q5xDfvGc5ZSE/IiEF8YC392HcCdFwvKOBN2edBCJricVMmQ2CSLMksJ7yItaC5iftV
         unMMPZTM3IkB4yidd+it3nUnFIq99c/SKsLOlLNaIyFnNe3VMZTm8SN8rctOTI8kQsTC
         RQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761224691; x=1761829491;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=id+wIYbTFy4GJ5sovEHifiUi3WKFfS9SlpVUAwl/jlY=;
        b=ounp5127EH5VbrBM20JRJEd1sZj9maqnEqXS4J7ThAhMrHh2gqw7zP2OXwlDsl1SSa
         JYqzOzmzrBDJkmNExIP8SqkqpVJsLLff3xJ3YTof/8pZF1R2sBfNOyvYBQ1iyW2J092d
         tVM8OvCzecRFuv/0oyDCQ8IvS9g/tGVn+DgyIZ9tGo5lLwhyrP+U9W9tYd1L9zmj18yp
         m84JdQsf0JevtHNSLOwM2sXZ3am/SdxZHA100MzH/LUXJBO0a4NU8IwagzOH7773ejR4
         QSYFZ9IrBbRbmJNhs7pWctZ3dKv3GxIFKSB3E1j6E3IfycEkGR334O+tKp7J9RTVwvJ/
         t5sg==
X-Forwarded-Encrypted: i=1; AJvYcCXOhVJRXpclHn+GyU06bFwgjFRF73ZwGb3SW9EdpVIvVHfxyTt84r/pFK3QXbqjBgMf9G/aUVdy3Yy1FAI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc1kZQrPMQ7jiR/u+R28TH+DkyLeuV6diH979AooND7ZyXSLJf
	IPtT720ZNz2Tjp7ajf+KX0dcVTp9z4ntofe0kiOWXqSwa5Up+A6gMFLS
X-Gm-Gg: ASbGncuK5bV7m/PmLCGrzp3FSETZj6R/RRHOusIM1tk0O7edMZo/PyEvMgLyOOCZcm4
	jYanXX6A77HKYFYxy0lrL/M820kkVfzOH//9dvKHMsm3Np2NZGKnE/GnlvJXq4IuZWm+cqcMsKt
	PCcKngk2nHHuuN5HCxE7PHTgUlegGaCPm8L/vl77dapJj4NI8DP9TFDMfiB45Ve9e0PmUrU+gd2
	0bxG3COH28bQ8exyevxbVgCBL+SRMQfQQKjjBS1uTgMijuA9RyJ/3gM5opXZ6ERH8cy4/ODj5L8
	yChqOTeEWGelFwl/AhQ2+D6/EtwDimbF0uyXNMM3gJT9ocQITDZKrBmazTmC613QQbCbq7fHv7e
	RjzP0A9/2LXwmj0NsgUYL9vKYTeGDEXmS3hzQpRP5351RTDvt0GJphzCP9d6Vo0JGQOqPe5nImR
	1rFbK3Z7+A
X-Google-Smtp-Source: AGHT+IEcdM7hV7nizE7lspbXruEQ0gaeKJxvv0wIeUknnaa/wTQkABYZuABFdsJHbIclfJ2CGnpjFQ==
X-Received: by 2002:a05:6a00:4f81:b0:7a1:373f:c216 with SMTP id d2e1a72fcca58-7a220a9ded3mr30485012b3a.14.1761224674688;
        Thu, 23 Oct 2025 06:04:34 -0700 (PDT)
Received: from [10.248.7.103] ([2409:40f4:2040:16ed:f15f:ed0a:f0b7:34d2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274b8b291sm2509346b3a.42.2025.10.23.06.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 06:04:34 -0700 (PDT)
From: Rakuram Eswaran <rakuram.e96@gmail.com>
Date: Thu, 23 Oct 2025 18:34:13 +0530
Subject: [PATCH] wifi: mt76: mt7996: remove redundant NULL check in
 mt7996_msdu_page_get_from_cache()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-mt7996_mac_c-v1-1-580a3cbb2678@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMwn+mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyMj3dwSc0tLs/jcxOT4ZN1UQwMLS5Mki6SkJBMloJaCotS0zAqwcdG
 xtbUA48HPY14AAAA=
X-Change-ID: 20251022-mt7996_mac_c-e10894b8bbb4
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Rex Lu <rex.lu@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 david.hunter.linux@gmail.com, khalid@kernel.org, skhan@linuxfoundation.org, 
 linux-kernel-mentees@lists.linux.dev, kernel test robot <lkp@intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Rakuram Eswaran <rakuram.e96@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761224666; l=1686;
 i=rakuram.e96@gmail.com; s=20251022; h=from:subject:message-id;
 bh=MZntrYzYxpIKR4lTEuQ8vg90cnWJfjxVo3eqGMp0mdI=;
 b=jgYbQsrBeTw7tVtVJy36z0p2uDhIq4lvHZ86UI3xTp4Zr4APqXvIxFrHqF4MZMKViKRawY9Ky
 POX/j+CfAclAH0ZtDNhHsqHPK1379DlAhezZtod7if6PDUPry4Wh5CG
X-Developer-Key: i=rakuram.e96@gmail.com; a=ed25519;
 pk=swrXGNLB3jH+d6pqdVOCwq0slsYH5rn9IkMak1fIfgA=

Smatch reported a warning that the NULL check on `p` in
`mt7996_msdu_page_get_from_cache()` is redundant:

  drivers/net/wireless/mediatek/mt76/mt7996/mac.c:1651
  mt7996_msdu_page_get_from_cache() warn: can 'p' even be NULL?

The function first checks `list_empty(&dev->wed_rro.page_cache)` before
calling `list_first_entry()`. When the list is not empty,
`list_first_entry()` always returns a valid pointer and can never be NULL.

Hence, the `if (p)` condition is unnecessary. Removing it cleans up the
code.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202510100155.MS0IXhzm-lkp@intel.com/
Signed-off-by: Rakuram Eswaran <rakuram.e96@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 9501def3e0e3e20132fdbcfe0b1f489694afdc5f..284f2eea71e5bf0a34c7fe84084d998164a31a05 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1681,8 +1681,7 @@ mt7996_msdu_page_get_from_cache(struct mt7996_dev *dev)
 	if (!list_empty(&dev->wed_rro.page_cache)) {
 		p = list_first_entry(&dev->wed_rro.page_cache,
 				     struct mt7996_msdu_page, list);
-		if (p)
-			list_del(&p->list);
+		list_del(&p->list);
 	}
 
 	spin_unlock(&dev->wed_rro.lock);

---
base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
change-id: 20251022-mt7996_mac_c-e10894b8bbb4

Best regards,
-- 
Rakuram Eswaran <rakuram.e96@gmail.com>


