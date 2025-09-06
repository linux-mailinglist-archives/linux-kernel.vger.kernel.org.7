Return-Path: <linux-kernel+bounces-804003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC2AB46897
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 05:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D8487BE0B9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 03:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004A92367DF;
	Sat,  6 Sep 2025 03:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ES2gYRB8"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB18722DFA3
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 03:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757128826; cv=none; b=W2/4pbqfBBErZPn9+5fqD9b1BeNE4Stozhk5dF+JqVeO3RzeNlGQW0WqSM7fEl7it6Dp/3D+eTmlot66sfioy27wTx09E49Uj+bfsGwKVcmtaK8xSCifpva8VM8LRcA1gDlqXuvNDmbsqhNsSnvsx93doLAn+myLC0Lm2bXF+6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757128826; c=relaxed/simple;
	bh=wvydw5DGPXse+1/MJhAeAfjtwWbGLryMTnQ9WvMojlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ieEAWGLGmvaAPz8RxvYzE53xTTLoMI1yJnjTKw9RwG3J90ScWUx8bVHVP6bNw+BmCembqJqpfFhZVpMgTss4eRr/9acPG7lQtIo3KFNaG/d9Iyzx469+nFk9vDNfDBG+7GEXwPe/i4eGvUdRbEca87yOkpQeiYCq2ogKwxSXtrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ES2gYRB8; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7722c8d2694so2536125b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 20:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757128824; x=1757733624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0joNrAGADZgtCnbGHtr8kEwpaDCWrFPdhfYx7W9o2I=;
        b=ES2gYRB8j2cvfNSHTmw2FRegfSpUTPWPp8ypE9pE5uEXNG3CI3I3XouEsp2V+DY7oV
         63W6yxL1af67vxZKflnRRzbk9wE2Diwwek6+tkjkyelEKPxW7gC81MxZHNwuhu5KbMYJ
         5rJtXhJ80yvQxASCprJApsDliLTXvTYrQ/C+eo6GdV/93GxfFc6OeF0oys8V8yj4bvdZ
         fo+ybfRLtj90kBuSc99X8OZPMdaVbgUJxn9qz890cQFWJDhXu0iGsIZqi42cZa85l+A7
         hq0q3ZrmLFED3SeD97HUpH7ynIhLKEnZErbpaq3qfkU6WZJE0hBp/3YxmmBbRUvHf4nH
         gtfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757128824; x=1757733624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t0joNrAGADZgtCnbGHtr8kEwpaDCWrFPdhfYx7W9o2I=;
        b=G7wxTrhIsYqsvJxpUgcX7HWn2UcTOSv6WN/38UsQ/GK7pcwepdRoM8oSHmXlA+TMYH
         uoCJD/BSlnzD6EA+KKyXzG9QH/FZisGX1HEW5RjjltkT/j13pVzZADk5vojU6J+5FM/S
         G+6fadSS1D8dowczpdtOOYvLlN+tdhtaO/d3J8pph5W76vJp2bCSY0iWG0/00zCFCikw
         9MnyDF3GupYWg2BfAjP6lz75zqdcH1s6Lx3oM9VXGOQWGECirE/yJnKNPxz4O5lxz7d1
         heltsDk4aVHaVlL+hAePjrrgTLt+dgtT9j1DxYPL4LSRQWSL54DkfzWy/LwTxwHzw0d9
         XDgg==
X-Gm-Message-State: AOJu0YxFLdGtdTGvth7Y+1lu3/jAlnR52QMdP5GgLbCBn/aRdjpIU5cb
	HZWwZfL1AwZqtMF1x14902NwUXthRTmDMaxM07HFKl9NNDjOq8ySSVEhQziB650G
X-Gm-Gg: ASbGncvObO7nNXq/QJVP0gXFMqzrOqzId8xBpP4C8fV129Glm+hVsETCxYPQUKZquhd
	J94JfUMRtvlyoay7YhdanHMlloYf+DjCgwXoub0v9xi8Eg0MDu06KRVlm804OHp9a8zf0jY0kXx
	tEll8Nop/J4NqEqX7TS/3tcLJYQlH/FOrJuJKqw0D4LxK+oxHEEOf2BtKGNQQlaphy5ihD46icz
	c8J/6vv7m74hSI3ndfVjcP+2NfXXGTezb9ywyyWe3IPff9UEo7TGq4047UWpP8haZi9cF7m/7qX
	h+6obteY7HAwANAnJGCHQ2uapjHy8YmKVQy5YNtFshln2LGFOSOsYLIYLclN857BGS3bBTuxOlF
	0Ew/SVzPnk2KORlui/eDP2KgM3dNN1YeyHvl45Ogtzr7Mc7RAgeKZDQuTxfYFReGyoZUCck10RF
	44JGI=
X-Google-Smtp-Source: AGHT+IHmmB5AkJitV6FUgDMqWSe9Ast/37UvOMQmeKnF6ugx0TIGdFL2VJC+riMJYW/4UJscEJ9kxA==
X-Received: by 2002:a05:6a00:84c:b0:772:3f03:f3f4 with SMTP id d2e1a72fcca58-7742dd52bfcmr1329663b3a.14.1757128823796;
        Fri, 05 Sep 2025 20:20:23 -0700 (PDT)
Received: from localhost.localdomain (36-231-187-52.dynamic-ip.hinet.net. [36.231.187.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a090c77sm23093074b3a.0.2025.09.05.20.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 20:20:23 -0700 (PDT)
From: Nick Huang <sef1548@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: maintainers-if-needed@example.com,
	Nick Huang <sef1548@gmail.com>,
	Johnson Huang <kusogame68@gmail.com>
Subject: [PATCH v2 1/3] dt-bindings: mfd: rohm,bd71847-pmic: Fix typo in documentation
Date: Sat,  6 Sep 2025 11:19:53 +0800
Message-ID: <20250906031955.21338-2-sef1548@gmail.com>
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

Correct a typo in the documentation by replacing "abd" with the correct word "and".
This improves readability and avoids confusion in the description.

Co-developed-by: Nick Huang <sef1548@gmail.com>
Signed-off-by: Nick Huang <sef1548@gmail.com>
Signed-off-by: Johnson Huang <kusogame68@gmail.com>
---
 Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
index d783cc4e4e..d16c82e398 100644
--- a/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
@@ -41,7 +41,7 @@ properties:
   clock-output-names:
     maxItems: 1
 
-# The BD71847 abd BD71850 support two different HW states as reset target
+# The BD71847 and BD71850 support two different HW states as reset target
 # states. States are called as SNVS and READY. At READY state all the PMIC
 # power outputs go down and OTP is reload. At the SNVS state all other logic
 # and external devices apart from the SNVS power domain are shut off. Please
-- 
2.48.1


