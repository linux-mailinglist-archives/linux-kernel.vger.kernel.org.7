Return-Path: <linux-kernel+bounces-888371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F40B3C3AA97
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 12:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8865E46830B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 11:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA5C3126BF;
	Thu,  6 Nov 2025 11:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="TcoZBupi"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6524330F805
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 11:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762428874; cv=none; b=X+8/HT4/Hk+zdY/VE8RMYQPRm5DePOrDe1mU+LwI8JpOTyan0qDDpMkVFdf7cnZBGDz9hIr65mgCqI7mfTwViL4+Eu0DKN2UiBJFBqCnI2KDTzBfebQDxCkGUY7Cpq5n/s+zRuLj67MdaH7nwscharF4iuyGnJDbAl45FVNmNaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762428874; c=relaxed/simple;
	bh=Gtyj9mEcu6V4pcGmC+SaB8NL97WnrKFGqIgBzP4NOeY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nOUAdti9Huu+gNhxCazqpGKm9V7LbRBcQpqy2Um9L63/I4Zy1m88C8cx0heC8y8uO336hsNPEc8oXlMjKgE0SKNyF4BQCzyl2LvkHHK71TSU0qsJTXsSMlHHnIFLaDnC980HmSJ9y/OIftim5PmWqQ50dNzTH54XI6OtTJosM1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=TcoZBupi; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47112a73785so5363025e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 03:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762428871; x=1763033671; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ps1dtuocIgHWNi4XIFGNgY4rWCwPTvVS8YGMM8z4E8=;
        b=TcoZBupiGTHOlhzOH33JG2PhzSY51RD/jkQInI2w6hUgcR21h9S+ROa9s17oSfbUfg
         8sWwDe6HiJ3qNswIIzt6AOHg2G81D3uTgYpCHU68IwvUrhz5d+latMv/RJrgHZRn2yWo
         Bu8FPydRToEIfv/QDEZxm1qYl1U54MnrXBJXBWoaU9yEFPxazJ4WqvE+Mvocw4ga2VSo
         35NQqzPeqt98aRpOZZAX7Jv3xTgpNFuGN+tbTlkr76XAITNVORfIuLrkNsHdOLfrs5yt
         oFkEex2lUQfdzli+zgtvB/IapqaI2nWnwit7Cpc9WhcgGeglsenxfTZ9gIYk6/eT3wgW
         /L+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762428871; x=1763033671;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ps1dtuocIgHWNi4XIFGNgY4rWCwPTvVS8YGMM8z4E8=;
        b=uU2shxAm+Hi15s3LuRnypMGuTIQIPHUDEcTa+Y29eRSHpXwKU4qMN15xH+A5RmlSrJ
         CNLdwPJ659UNbrlhu009YOVK2qQODkz1QtOfgHpWuk0dzoFRZ6mr2Xaa/LI7LT8KlVbf
         xorrSU2TlhrJ59u388epe+u7oy4sicj5AXtE4n+JZPfEbRN7VqaDf6lE0YPbYG2cTTt7
         A9YsFtylvACBijvVH+qCvTqM2p3kf5gTyTiMGFHE4yJG7lGByE+jL1d7RWsLNE/BSOqd
         g5FHv7gARZ4RFd+b2r6lJVFExTXRGs7vE7gQua8EleqZGl/aKQnhEOsUIsorhjdAETv/
         UNsg==
X-Forwarded-Encrypted: i=1; AJvYcCVYJG3A8mEx9MDTK0zY4m2l16set6Je6d5LZuPJ9nPsqh6QcV2gCIiWqzw8yitQDuS6t7MJAidn4wNgNLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGcyXmtnoNN05pqs/3FaJeXwMfgLcNMByZ0BfvoFWVGdHGQyqw
	HMA+bEOgrGxBvzCPxc7iOPlhnLGKFpljjjp5SQaqJrIWKpghRjgBSiTkNQoz9jgwg/A=
X-Gm-Gg: ASbGncvahRyzUKuurvtlXc0fcF7EYNaicfmTv30CDJwPkyyJw4So+4RKEVOnhBJeHsl
	TX1T0PCDJzamMRSFrpZ96yr2pDbD8nVEpz+3XSwumtSSqf1hLchfI/7KV+lF/diHXMtORdm2XjN
	j3aV6k/wO60CNXAjkaAAafAarIhIbMgNElYSgMZwE2NnyEdwrMk9tgBgYtYvvvTuPwWtK4haCsL
	16rIYoyeDX1PCP3fBo8wztGnJAlP/mHKWboNNBB6ZHKtElU8R/+JC7Ga/4bNBsB6gn5I+4jNRQO
	Rzoh2DVBY7rpoerLbGsrW4CcCKg9ZjyxX1EX2EiHhHA9SPYTRPMO0pvaaPRr+jXJNDuqo0rUh8O
	EFug7B/lsvx2QGsZVd+ccewJhlqFRvr9TNIy4RfPsXddEnPjwGjw671qRSpBMFufIo9cj
X-Google-Smtp-Source: AGHT+IEd5LLOqacXKfenHhj7E4pku5yvYiQZ/LXG7Z5ut7z2Sn6vJh9v6vSGwpj/odFCat1KlpmtFw==
X-Received: by 2002:a05:600c:4f0b:b0:475:de14:db1e with SMTP id 5b1f17b1804b1-47769d50255mr6509055e9.24.1762428870670;
        Thu, 06 Nov 2025 03:34:30 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:d9de:4038:a78:acab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb40379esm4389459f8f.9.2025.11.06.03.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 03:34:29 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 06 Nov 2025 12:34:00 +0100
Subject: [PATCH v8 04/11] crypto: qce - Include algapi.h in the core.h
 header
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-qcom-qce-cmd-descr-v8-4-ecddca23ca26@linaro.org>
References: <20251106-qcom-qce-cmd-descr-v8-0-ecddca23ca26@linaro.org>
In-Reply-To: <20251106-qcom-qce-cmd-descr-v8-0-ecddca23ca26@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, 
 Udit Tiwari <quic_utiwari@quicinc.com>, 
 Daniel Perez-Zoghbi <dperezzo@quicinc.com>, 
 Md Sadre Alam <mdalam@qti.qualcomm.com>
Cc: dmaengine@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-crypto@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1185;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=ho7Q/QFIJOMH0B7qxH+AazIfS2TlD8ZgO1niuibbOks=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpDIe8xnsPR9iMo6Jt4SggMvqEQxmfALJYg0MEY
 ImjhNTu+HKJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQyHvAAKCRARpy6gFHHX
 cvO1EACyxVnNV7Un2A3ha+eMjxYTSDaQ2uctC4w6/Ev+VBpYvLdlTnvDPo/sB+hLmRXuqXbZGtU
 C5bn03Gj5c2w83a6qONL0f+hfuYlXVMbgfNNorlw7CCwBlrRoS5cc8l5Ehv5cf9JbPh97Epy8FC
 PzxRdrwMerl1doQ+OmSHB+EIiFI6HRHf16aI9812MlvE6UYb3jRG/xqdVLB3Cj+t+JeuDk6E/EX
 GAoFcK0zlvZ0dtbbrfYvShzUWEjc6fL3sgPu/7EmtI2iFVS8U/htge9AGLndQk288dLTKR49Faz
 MBXbfyvzvNi+nee295FJZ1e72m1aLVkeRoTfIgKSIhkGtm2gkYRd6GFouYXRLX/N4GFBLsyO0ED
 KEfMslFAdJqBzjsojG9gkRD//1LSFWQMaYGpawINGnGbgZBGlQ9jysUJS8BlQ6RM+Af82GNN81q
 LTCc4vfCHzwcrXE7zrJF5B7z19cC4ImgYkCNvk6lcW6Xn596ekZZsUR4JuxfsvjwmdmdGi2BeTb
 2P73eawDofP3rPh261amr2K7PbvN8RnAuMkczrjXkMQiebPwk1fuVOwXXgDBo3EvtLRe/Jq1xdk
 xa1PLHeYj0aXy0clKX3kSRqMxgFOVOk9sQzlb9XQH3BaCIYC231iu5QZAYut9oiC/jxMbme3HAp
 bieH1BdGh2InEuQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The header defines a struct embedding struct crypto_queue whose size
needs to be known and which is defined in crypto/algapi.h. Move the
inclusion from core.c to core.h.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/crypto/qce/core.c | 1 -
 drivers/crypto/qce/core.h | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index e95e84486d9aefe4b9af09a27631f0f9e7ad231f..3114b7f458de0c1cd8527e602b408958f224a7d0 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -13,7 +13,6 @@
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
-#include <crypto/algapi.h>
 #include <crypto/internal/hash.h>
 
 #include "core.h"
diff --git a/drivers/crypto/qce/core.h b/drivers/crypto/qce/core.h
index eb6fa7a8b64a81daf9ad5304a3ae4e5e597a70b8..f092ce2d3b04a936a37805c20ac5ba78d8fdd2df 100644
--- a/drivers/crypto/qce/core.h
+++ b/drivers/crypto/qce/core.h
@@ -8,6 +8,7 @@
 
 #include <linux/mutex.h>
 #include <linux/workqueue.h>
+#include <crypto/algapi.h>
 
 #include "dma.h"
 

-- 
2.51.0


