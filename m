Return-Path: <linux-kernel+bounces-871936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF146C0EE24
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18C9319C3AE7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4585695;
	Mon, 27 Oct 2025 15:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJ7ja//h"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C068C749C
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577795; cv=none; b=UU81fft/cwdaqbDgEafan/EgqbPontbQpzwJI5S4ptXHtqP1u7ZWDnzx3IJwhXFqrBHmwnWeoOoWIHzlt2Vfo3r9dkwbWYvIZA93NEu0hlUv44+fvLOTgkv5TEPlTyy9BliYtGBENz9zZcpKR1RUZFv4z/wgIL9hfEC01wIMQQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577795; c=relaxed/simple;
	bh=ZsCPFXC9R6NQL97nYWlCY006QYpTpfOsDxb5I2LLUOE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a8GEsvofGVGa2yHFN40Z+g7cgqHmydVYGulsZbTeSQ+QwD25cquSwGwqnJE+T+2m7NTHxCwbGuSs/bvbi5iypxMUcqiWQwA9oCBN18gV4PaqpuPAhWbQ9xxgyMXZVUP6Z/ytLIIsmozieBZyjPsM+xbCEyVmxR/0PjejgWHHTQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJ7ja//h; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b6ceb3b68eeso3603505a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761577793; x=1762182593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bOWeTrE1BXy5AjZlTLFESliT17UYj7Zas8RzdCqx+Q0=;
        b=kJ7ja//h1GuoShmdPrCSmyeJEW9lvcDD9TjI7HmOoqCiqUww61jtinmFyFPki9aVRB
         XgmaLqmysom2tx/vUAfxD79ODDCZbfnnqYwHvIdnK+vcABfymOOvyqqiRRWun8hkXVRI
         qDrCOxp8pXBPb9o1Fp9D4isFqnu7mMnHnCgLIusz7m/+j+WpKQUQ87HEx13fi3u9jl6t
         X1ltlZ5Mlk6tDKI5MOpscQiB+XZk86RFKweU6kmzejVblEu4mf+QL1gDbijVQ+1Q0mwP
         HKTrnEPib67AbFuJ961hiJsyReugDUHr7V+/RynxjsSbG0jpyGhGRQN+ZEM/vxRzEh5E
         ODVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761577793; x=1762182593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bOWeTrE1BXy5AjZlTLFESliT17UYj7Zas8RzdCqx+Q0=;
        b=QUNmSnxtjaamcS24+YWKZQ5ZfHyTx7rVBG6md/8CpVr0luGYljDSIImCgh5g+D/cyY
         i378x/cJLELWXdcG29VYE6Tlb5MaIfSIFwSi7L/0lfh86vclzQzQqZEdPt+J/qpyQbwQ
         v9QJo24/WzcMkRt7JrAa4S5lF2EqRfK0tUSP7V6+7Fgjns2pLJEZRPbQd6ZtWH2S1yWt
         vwjzx87dIXWrxKiACYwSx352kYyuIVCDIWYUOJgoT+AOdMRd1G8rmdyoesLk67zAB5f+
         cwO37hrDyJE1HCJP+04NGqLNzGLWSp07CNTxDMslUqPQIiKS3Wr+ZVv5O0hjoWT4zkWc
         2Xqw==
X-Forwarded-Encrypted: i=1; AJvYcCX/8r5DC2i9JsJ2yFV1OelT1SfOK/u/4lFLGlCnzLIN55DsxQuYmx47AMXAydBxUqr8ogyQcktxitq0bs0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywld97+idK2zf1o4SXID5bHLgbwuJwYuFAVEBLcwMxhF8J1WnZv
	DcQWxHe7HV6rloYdiLHDOti5TyYv9FdzPREKqF1AfGr5yYtvZtip2kTj
X-Gm-Gg: ASbGncv48/hrVE+UTNglz/lDyCESo0YR/3VpGvw+JPHyaO0wwVeA5wbpMNu6rHS1evd
	SyBzW2Fj4CdI/yKKXdanQ74dyvpDOwpIHPcDk7JPOQL/V7LXZt6iNAyMGTkYg27mtkVEPBoX51p
	Gk7Vu7UWS4ZhrnMj9fO7+DqqaP7Wfe8MjYzyF0Ig6IkwVCq7gS6Z9N4Iutq3NY6qsG7Ej9mbfm1
	x+xMVTQj0csK3YaKJabsixpvBg78fJDnwNpK1NE+KaGLZ/Px9I6Vwhpc7F9oz7y82MBbn3ysNS6
	ret3N5h2xcJmi2BLcrTYWTUFkFYf++R3Pjcjr503FLD2jen7QYJD7le21VObkBgyyPGrIxAzXQ0
	DDJIZK3hP+75N9hYWOWHemJRIzEGCS6pQ7WjSaD9PSYRGGYpARQS7UBBPPeGzp+JdRqG/NVwZ6P
	lEOmxPXE9RaNu+dumYGeETlS7OkSodwtog
X-Google-Smtp-Source: AGHT+IHm+qmEs3k8KDkI28OdIfpmmkZKiOOzJFODhG9t1YR8Za920Qncpnz3yBINujjAHcwPpw/fHQ==
X-Received: by 2002:a17:902:ea01:b0:252:a80c:3cc5 with SMTP id d9443c01a7336-294cb3d6169mr3033825ad.22.1761577792933;
        Mon, 27 Oct 2025 08:09:52 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29498e4113fsm84234275ad.90.2025.10.27.08.09.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Oct 2025 08:09:51 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Weili Qian <qianweili@huawei.com>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Kai Ye <yekai13@huawei.com>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] crypto: hisilicon/qm - Fix device reference leak in qm_get_qos_value
Date: Mon, 27 Oct 2025 23:09:34 +0800
Message-Id: <20251027150934.60013-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The qm_get_qos_value() function calls bus_find_device_by_name() which
increases the device reference count, but fails to call put_device()
to balance the reference count and lead to a device reference leak.

Add put_device() calls in both the error path and success path to
properly balance the reference count.

Found via static analysis.

Fixes: 22d7a6c39cab ("crypto: hisilicon/qm - add pci bdf number check")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/crypto/hisilicon/qm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index a5b96adf2d1e..3b391a146635 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -3871,10 +3871,12 @@ static ssize_t qm_get_qos_value(struct hisi_qm *qm, const char *buf,
 	pdev = container_of(dev, struct pci_dev, dev);
 	if (pci_physfn(pdev) != qm->pdev) {
 		pci_err(qm->pdev, "the pdev input does not match the pf!\n");
+		put_device(dev);
 		return -EINVAL;
 	}
 
 	*fun_index = pdev->devfn;
+	put_device(dev);
 
 	return 0;
 }
-- 
2.39.5 (Apple Git-154)


