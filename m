Return-Path: <linux-kernel+bounces-804004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AE4B46896
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 05:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C33A7C38C2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 03:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCCD23A9A0;
	Sat,  6 Sep 2025 03:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OE41wgey"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803A022F74D
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 03:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757128827; cv=none; b=IocDnbTH3TLlqU1iFRF84OSnRaWpkaSvUzbvVKWAoFtYIXKT4ad0ZSI6TmWISmeWPAhaB3IRwP5qEdVziaohw+FDvEFDufwwn1m9C8XVeiZ2mSR9hyf6Ak6YMEMz3sHlSb4rcAlZ6ocg15U0XWcglF9j5NweOoasOPQFNQRhZQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757128827; c=relaxed/simple;
	bh=0UkOEfi1IjDESIwDt6iP/LhJT/HeeTfKdMfFoCECOPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PnZgre6Lq0aUEpDfQDFKrDhU+ki0OhDvgsW9+WTb6fWw0v3IurMvoeNLnY8D3gv8sVofxo1jbffZhcNiSItQcShaNaFn824U78k/e5J2RtXckzYJAf9p1Oizyh3TERzwrMzuKv1fGxwHSS7T2SK+Ws8DsPyCyKt9uX6OXnVJcqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OE41wgey; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b520c9c291dso1093486a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 20:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757128825; x=1757733625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z2cCU7dJci4fXTg8GbK2CWuzrGsJs5uLLD5TZBvmXm8=;
        b=OE41wgeycrtDDnUwx9ZeV/B/vtSdV1iVYyGcV8N+loRWuTduqLwXmD7hg4qbjtCWRg
         dsJQmFFH2MP1oeSKmY+EYiO+NcXqaiO5HM7VCHiwJw+3GLPwAZbUSnKebQxFMwGRTvda
         2BjrFgzix5TlGLFHtZ/ZY/WHB7D9HP4wKXbtSsyzRQRI2T5Y+/zGwkxxuCuGEJY8dM12
         pOCEArD3aizJE8r8DY2Fxwolfs1TVVhLaqmoNaKmdG3Diy4/A612ita6i/sHqCglzQJx
         tUL7lfaCd2PoUheStJXwwQ9s0nccG+05VE6qHqavO5Z4NtmQeRre7E6inzVOu1vWiVtb
         YNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757128825; x=1757733625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z2cCU7dJci4fXTg8GbK2CWuzrGsJs5uLLD5TZBvmXm8=;
        b=r6XxYFpR33E303HZIAD4y08DFuBDnYcnMr+X4RwB8MZ3XgbKriBhhCFJT259+pYKM2
         0YTIxqQd8wkbEEFaj3NcQmTg0NnqBkFHitiC+uE/PckiA9LIW27dpa7gdJAIZ9t96CdJ
         Rs7GZodWPlCjpOJllz05fUwaBQ2gQ8rTOtdD7UML+RyZBUiOH9gVEbJO86ZYhP6BSNNt
         E4vLXKbmzg+/xra1ZAK/YXoFtvl3MSAyE8MtVMqQrTNZUcF8XMZGg5JPtM5LKhYHqfjT
         UJodkG6oDZKEw7HGkWaw+AL5InKHs0JQW1vgXjS+KfXgZ0ktvM9q8UhIHkoLWc77XzOt
         t9Yw==
X-Gm-Message-State: AOJu0YwBHWIkqXQdJwbBPuUifFIL1/mT/Yo7igDUmTyr5X7kQd5dt8OX
	JAkyhqNdrVdpWkrkBu3vhse74AknW5QCsa8t5tUeUqIINUGZ1wZpvTX8uVsxCg==
X-Gm-Gg: ASbGncuJRWuc3wAmZB3ZBmmIgC7SwJdled8nUrqeuNFsmVyaQ0P1W1jyX8Ec82b41Fp
	XSIQkGK6N2zxOf7vOXx3WZFGkxlgVtAC37HI0kau5rtV0t5j4yK2Dx9AH0PtrXE5oOYE4vxDDjG
	mYpAQK+uhAgLh0kYfOGVntYfAk52139LevLz2c1VtgPEgQZgiiAObOsfrJ7jPRwUHj4HF6HxSR4
	yVUQ2Mx+/ztD8jVnaLnGb1CgZg10ks5ERAZcUorLbwtytlsXW3QFDMAEMGUm0OnhVusOZB/k94O
	IxW3oJI1/ifSQbqg29yOq9nO3r72dRU4u1s7zI4lTx/gyIGQAmBnCvCMwicmd/iXwZ3YMglWZaH
	/yRpC4AGVOLyOApOMJNFDQhFI6fG0tQBAE+dYpOaSGlE4D+/j/JzV/5/6bQkV6du8y1gsPQMX+d
	zfUgU=
X-Google-Smtp-Source: AGHT+IHzhBRn6ljOuN+XLc/wjnlq4r9G3WRizspaAijTrTrL/os/NAeNNyszjlVHKQq0erZxWEjobg==
X-Received: by 2002:a05:6a20:939e:b0:24c:c33e:8df2 with SMTP id adf61e73a8af0-25345579959mr1633105637.45.1757128825193;
        Fri, 05 Sep 2025 20:20:25 -0700 (PDT)
Received: from localhost.localdomain (36-231-187-52.dynamic-ip.hinet.net. [36.231.187.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a090c77sm23093074b3a.0.2025.09.05.20.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 20:20:24 -0700 (PDT)
From: Nick Huang <sef1548@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: maintainers-if-needed@example.com,
	Nick Huang <sef1548@gmail.com>
Subject: [PATCH v2 2/3] dt-bindings: mfd: rohm,bd96802-pmic: Fix typo in documentation
Date: Sat,  6 Sep 2025 11:19:54 +0800
Message-ID: <20250906031955.21338-3-sef1548@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250906031955.21338-1-sef1548@gmail.com>
References: <20250906031955.21338-1-sef1548@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct a misspelling in comment: "contolling" should be "controlling"
which refers to shutting down the SOC and controlling the PMIC

Signed-off-by: Nick Huang <sef1548@gmail.com>
---
 Documentation/devicetree/bindings/mfd/rohm,bd96802-pmic.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd96802-pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd96802-pmic.yaml
index 6cbea796d1..9772d43b39 100644
--- a/Documentation/devicetree/bindings/mfd/rohm,bd96802-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd96802-pmic.yaml
@@ -27,7 +27,7 @@ properties:
     description:
       The PMIC provides intb and errb IRQ lines. The errb IRQ line is used
       for fatal IRQs which will cause the PMIC to shut down power outputs.
-      In many systems this will shut down the SoC contolling the PMIC and
+      In many systems this will shut down the SoC controlling the PMIC and
       connecting/handling the errb can be omitted. However, there are cases
       where the SoC is not powered by the PMIC or has a short time backup
       energy to handle shutdown of critical hardware. In that case it may be
-- 
2.48.1


