Return-Path: <linux-kernel+bounces-876833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E94C1C819
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A2324E1757
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C68350D75;
	Wed, 29 Oct 2025 17:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aplHp2DU"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C130E32D45C
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 17:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759448; cv=none; b=t5ywdklGrwIuL+C3W7FslcMy6HiRmByUGkZGsj3E4B/FKE4Pjp8PZ8Ek5fu+fxkRNg5GlAvNHKYNimmGSgU9SohydzZYtSbxQTHVjD0ipOUoy/bU/XZC3d9jTDLmtkK5p6y8VMzq58QEjxJ/E055cA9zuQ8EqyEEoK502nz1Sys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759448; c=relaxed/simple;
	bh=xm6eA2ggIWwm5+4MUGHVf4nEyQcxRC2xoi9GmupvDA4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KhjIee1sDH0lNYkzCWuY+NCjyDxTRLOQ8lZLhtu57nb2UGnBZ0I5eLL1t+b7V9WcZcJkvZqFomNTxLq+46ibX+nhQx5+KUo4Ij0oU0mzfrHDTFBzBOxL4BqejwF44tj5AcvOmooVQLK+3/jpzCpz5B2zzyDSaZV6k9w068xBN94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aplHp2DU; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-427007b1fe5so90312f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761759445; x=1762364245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NhUi6h4m6Y5VXT2vKK+q0h3TDlsz5Xrrk0iweaBViQE=;
        b=aplHp2DUoyQJqkjzelNeGoAjqmLAE1pbnGXVSj5lnsHowxGQcrE/OFi//MhG0si0Um
         AaX8vWY0d+WOnMR94jt3MgEMRnvjxQJ+tohXxcXbknv5Q0wbD8OZffNq1pmOFc3tPcER
         W2kSg+31eX87uZfOrVFlpG8l1V0gh8QP4BGWaRTItMTJUahKRNBWOiK14Z3tyZQSmn6C
         tU9ABam2FINKbPzGecAPqfb/QXAxqL2oRkVNpKUVAfMqbIbjRA+/pICpcVApgKYnhjVe
         8Z07gQW7+tNM3T1ePmGtpZ7B7qkhg0yJ1+zuRDn5P8FWkS/ugw3Pwc+fxY+slfFdBx1z
         WLfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761759445; x=1762364245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NhUi6h4m6Y5VXT2vKK+q0h3TDlsz5Xrrk0iweaBViQE=;
        b=Z1N8k6JBQRrUm35lqBRlqsoQx/cZduJbw1kaDarRVmye0ZZmDXDuGhq+1nCio0KJ3b
         m7qhYpckgoaAAYYi9O6Ot3AJYuM9Xy/Cf0UC9tmjHssDWwLmA1utRpWqwfFZgbJCqxHL
         FKuVCS+MmC0WdAfzjpT6j+FdDP/ym+Mc/Xaos/5K9uvojPyj9Tteo3NummZAOuZV/sFO
         uEGuAb/sdWnGPWNK2ZsK9f6zIBs+9p01mUMJ15zgMJsm88t1BzgL7UmTmyeDRZhx89JD
         V4Tb7Mw/3k8PM8xt86H/LvkkqMiXurv8lWKOYvZlYOO2bal7J1YPKA6+BuaelEbSCTWG
         mg7A==
X-Forwarded-Encrypted: i=1; AJvYcCUI1cSlgGYaFF/5Z7jfqOTiZ5337Ci7pOqERHUjmF0OkwgPe13YrRj1bNnJZpcit/DK99YtUpMWWbRTJ8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYyhkZFSB5BBjNCTgxN+aGyYMWUP4tW/yalzbNtn2s4kEGV9kZ
	mswAiWefS/84wrfrtOYj92w6hg8rZQXrYX41DMHOI7O5vWTtst0zftaY
X-Gm-Gg: ASbGnct87p2kmvL+zzc9zFkoBoOJK8j6hy2+uGPHdoffsZ3adrf9mMAsSqhzMm6x0yO
	rjSxSS8aPGQ0yrPShYR6ORdE1chJvj/IjyH1PzWWov/vqUHZJRU9J897OkOTM3FS4STJwWGW1ch
	UGQsJwSHrNWwWtSpD2DYgRah2txAIwS0a7ZDeM3IWC7GD/NBJ4mc9kFmv1l9FFEOiaAZiHMsonj
	eqmWvgtzOpafnuJtO6h+AlglcGCU4hVy05Qh/oSPnh4uQ9xh7sq8DXFH8oyVi8788aUTe/1bA8G
	yZm0GzXRCEKcp/wCFNw8lE3ca/pC33RciUR2GXQxDMfEAnnJkoe1ff7OESld5t8cadMyn+OqmMS
	RCap7/AjUk3aUz+LtCedoyS3tp2okOK2uNmcjnV49SnIdlNBrw4E3MvXcz6pkva+Ruj+AYshRI7
	wee+MdD3MlTN5M3DNloJqVvaTLETaesQ==
X-Google-Smtp-Source: AGHT+IHzbLzBMCG4vRWavhz0gR3MN2E4QK6PUFiHctEW/nKzQ6EVw44MxYOuM0Le4svI/Ot02aqVPg==
X-Received: by 2002:a05:6000:2c0e:b0:427:632:cd3f with SMTP id ffacd0b85a97d-429aef88c52mr3318335f8f.28.1761759445032;
        Wed, 29 Oct 2025 10:37:25 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-429952d9e80sm27493844f8f.28.2025.10.29.10.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 10:37:24 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] dt-bindings: soc: Add bindings for Airoha SCU Serdes lines
Date: Wed, 29 Oct 2025 18:37:09 +0100
Message-ID: <20251029173713.7670-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029173713.7670-1-ansuelsmth@gmail.com>
References: <20251029173713.7670-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Airoha AN7581 SoC can configure the SCU serdes lines for multiple
purpose. For example the Serdes for the USB1 port can be both
used for USB 3.0 operation or for Ethernet. Or the USB2 serdes can both
used for USB 3.0 operation or for PCIe.

The PCIe Serdes can be both used for PCIe operation or for Ethernet.

Add bindings to permit correct reference of the different ports in DT,
mostly to differentiate the different supported modes internally to the
drivers.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 include/dt-bindings/soc/airoha,scu-ssr.h | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 include/dt-bindings/soc/airoha,scu-ssr.h

diff --git a/include/dt-bindings/soc/airoha,scu-ssr.h b/include/dt-bindings/soc/airoha,scu-ssr.h
new file mode 100644
index 000000000000..33c64844ada3
--- /dev/null
+++ b/include/dt-bindings/soc/airoha,scu-ssr.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef __DT_BINDINGS_AIROHA_SCU_SSR_H
+#define __DT_BINDINGS_AIROHA_SCU_SSR_H
+
+#define AIROHA_SCU_SERDES_PCIE1		0
+#define AIROHA_SCU_SERDES_PCIE2		1
+#define AIROHA_SCU_SERDES_USB1		2
+#define AIROHA_SCU_SERDES_USB2		3
+
+#endif /* __DT_BINDINGS_AIROHA_SCU_SSR_H */
-- 
2.51.0


