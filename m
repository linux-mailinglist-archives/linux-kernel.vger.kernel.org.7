Return-Path: <linux-kernel+bounces-871935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3667BC0EE08
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFBFA19C34A5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EA4611E;
	Mon, 27 Oct 2025 15:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAzgYODE"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE17B23958A
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577773; cv=none; b=arlF5X/QLkL2mYu1eCuadjso4Yzl2M4/DfpbRB0NjgoPOVl6tzxq6UD8xcFxFhElEeqO3KU4G6hEWxeZPvWLM9Tydff/Qq6V6EL1l8xNG/sEFoZSUTjQrCNoZtr3UmAhUp1sUwJik07N0mbWb8lU2dGbeSH1acUR/ST1kGcYJeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577773; c=relaxed/simple;
	bh=eIQuMzndX2IaXQQgsZY7X9rDiT2WkLqj/57iQwR1pfI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TrjVCujMiDMH5hwGk6bvK535pXO8fb35lxaoAFboJHI+CK5/48dZr7FnQEDYHHZ8cyEYQDyfitSTiEOGc8EbvbWNdzACTvyvyLAF5vU3Hohbf5E7Ao2gu8n8lxunQ8Xc1gEN3QUkRcwlnWioKvibuHm2dSz9OBYvUpfmUw2SMc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZAzgYODE; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7a26dab3a97so2904179b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761577771; x=1762182571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=du5oJpRBhJlPxSiwoBeavUKOwQ5aDhNDZOqlYr8mmsc=;
        b=ZAzgYODEEsVcYhLKjQrvV+DCv995CnSx7BzeDU552u5LZtpXxRnB0cmT3d+N9EmvAc
         IYGDKITFlrCwxBHAppQL0SWpZHv5zi14fsEa1XiPHtBcxuUw1Szq6CBSdesnWlPZO9gh
         ZgLsCY4UZvnRlscVp+aBmmY6xOZLoI1YPNzqIuN10HmgjDKdpWecc7Ki23iGxcsRvp5U
         /JbLSdu9IRsztd8K1bne3+WM0n9Q7k20Q7mxecZqS8WJ4n5msdGbb2pM0pSQsHHwBw1j
         Ep68pWKqdS3tFnsTEy5gCPYndNSfIHsljQ0H/mnlNWhZARHnQ5+PTPBpSQoxfIFyzQXp
         qN+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761577771; x=1762182571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=du5oJpRBhJlPxSiwoBeavUKOwQ5aDhNDZOqlYr8mmsc=;
        b=HbObpGurv7WHgi2sKhDR+SYu41gyVQt8IS0byd36aJWT4Y6L077jPlMGXr6kyTgy9P
         6UUWImgKL0HDGJb4Ek1gAL/gBaR2D8iK/C/kUPRNF1B/et7xUoQ/7MvYsUcakdTH+OIO
         d60dv19upZxHMzH+awAtuYWbLKI6//VJc68fFVPddm16qvOuBF/67xakTtB3fJ22vLxv
         Mi5wkT6eLTY4d8JqnM16tlMsO3Nc/prawLhtt9M18mWFvn1h0cTWPKAhyrbUhRf8AMk7
         0R8Fp3l07TglZzh5cfUUI5E/R6+sQ2mG/p6k0NMjEo4X9sg8YfyUHMpB2LWgN1zi7vj0
         MoDA==
X-Forwarded-Encrypted: i=1; AJvYcCW6tf0QipsR3dDOhIJ7WglDqPzfVToRRneSG6y7t4D0AUFX7cDjchxStoCGk7yZ2Lxj14F6CYLo5JH1WTs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Xhk9c4RGIuOw6Bx9z1eii4KZRDXH49SdCN+t5fAzsVl1gjyl
	XlWTwfa5Sm8Kc/kSe1JfNNsbiMQKmNsIm8rCyCEH0V5Py5J+65tG5L2a
X-Gm-Gg: ASbGncvH/uYy+Hf5i5e7RXeXkcQgFUtNJocGP8Ra7u59PTk+MCofK8NzuT9PiTM1tYa
	lcoEr6CVI+ang7G0FD9ydQbtN/qd0fM2H29a1gqrMUgkTP7ABdduhtE76whgXhDsLrLy3k+Oen0
	khCDDw990wtZ32VH+EC+TgKDpzvXwvV7Jms5ExAFJGXN/UnrPdggHNiccXOsZz7+75vNqAYgszT
	oC325heZsCaPew9qyBmVEBsoW/Fu0tMmqeek34CHujHiDYVfF9RVR1P2cVHUYg4GqKuQ6k14uW9
	suREDZLWZOaNYZOi8I6D5SjYAB1xbyLc7c086bcqlZvmWPoUGqgvP47ewSSfbgCeJrI57hHV6o5
	51RTXddAIXumJ7toTbuJBxoftC8xAL1cJNYxDEVfO8rKGVhC6Yrkfy3RbCjcFZd1h7X5TehvJ7X
	DbAbL9IBp3DM2I2sURxcaOhw==
X-Google-Smtp-Source: AGHT+IFScmYX6R3rthmA7m7QRURybKZunKqeR6Hr6fFU6rVxiKPR6zlKhkOB5h4TP+qYA1pWCaz3NA==
X-Received: by 2002:a05:6a00:390b:b0:7a3:455e:3fa5 with SMTP id d2e1a72fcca58-7a441a6b2d6mr397621b3a.0.1761577770926;
        Mon, 27 Oct 2025 08:09:30 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7a41c70ea64sm6929565b3a.3.2025.10.27.08.09.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Oct 2025 08:09:29 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Albert Herranz <albert_herranz@yahoo.es>,
	Grant Likely <grant.likely@secretlab.ca>,
	Segher Boessenkool <segher@kernel.crashing.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] powerpc/flipper-pic: Fix device node reference leak in flipper_pic_init
Date: Mon, 27 Oct 2025 23:09:11 +0800
Message-Id: <20251027150914.59811-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The flipper_pic_init() function calls of_get_parent() which increases
the device node reference count, but fails to call of_node_put() to
balance the reference count.

Add calls to of_node_put() in all paths to fix the leak.

Found via static analysis.

Fixes: 028ee972f032 ("powerpc: gamecube/wii: flipper interrupt controller support")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/powerpc/platforms/embedded6xx/flipper-pic.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/flipper-pic.c b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
index 91a8f0a7086e..cf6f795c8d76 100644
--- a/arch/powerpc/platforms/embedded6xx/flipper-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
@@ -135,13 +135,13 @@ static struct irq_domain * __init flipper_pic_init(struct device_node *np)
 	}
 	if (!of_device_is_compatible(pi, "nintendo,flipper-pi")) {
 		pr_err("unexpected parent compatible\n");
-		goto out;
+		goto out_put_node;
 	}
 
 	retval = of_address_to_resource(pi, 0, &res);
 	if (retval) {
 		pr_err("no io memory range found\n");
-		goto out;
+		goto out_put_node;
 	}
 	io_base = ioremap(res.start, resource_size(&res));
 
@@ -154,9 +154,12 @@ static struct irq_domain * __init flipper_pic_init(struct device_node *np)
 					      &flipper_irq_domain_ops, io_base);
 	if (!irq_domain) {
 		pr_err("failed to allocate irq_domain\n");
+		of_node_put(pi);
 		return NULL;
 	}
 
+out_put_node:
+	of_node_put(pi);
 out:
 	return irq_domain;
 }
-- 
2.39.5 (Apple Git-154)


