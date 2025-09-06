Return-Path: <linux-kernel+bounces-804051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F13AB46937
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 07:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87D551670D9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 05:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F89B279DAC;
	Sat,  6 Sep 2025 05:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3SdvB54"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E33A27BF85;
	Sat,  6 Sep 2025 05:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757135463; cv=none; b=DN2vcX0ObXmLcB7Vt9/5OP+YKlO9tXCIG2aJbFjNR6vTN68humKnT1DwPlKB5JWRRV+NMm87E233xEHEKfwozjbdv1x4bZPTriSoxFLM9spCjW9BBJwUkIjb+PLGluELkuv3qRcb7igzaY9a5R8PkHXmX92E40L8QvG7qLTCoXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757135463; c=relaxed/simple;
	bh=0UkOEfi1IjDESIwDt6iP/LhJT/HeeTfKdMfFoCECOPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NOE0vH8xgTI3MyM79Aw1yWMoaQCDEGJD0eoDJP/2YbGapUcBsd8+J1GU64CCIOJ3ywJhFADHNyKVdfWcJCW4V6QMFREG3sj6ujTrLs4LkqYWp3hSTSil+emTjwG6ZkDzYkvgp1qQe7CYo9hQa08In0MubrIhs//gg+IDeDDz0xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3SdvB54; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-327f87275d4so2855550a91.1;
        Fri, 05 Sep 2025 22:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757135461; x=1757740261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z2cCU7dJci4fXTg8GbK2CWuzrGsJs5uLLD5TZBvmXm8=;
        b=V3SdvB54wjUe1wDHBg7skvbo18WylwyTjYIchej8mqQvUk0+fUrqQqerMTiskTWX2s
         iKenTTvpGHmp0LJTmLSKxNVrryBFRZU8ppM3sCu4j6br0Am+Xtz4UyU5MIqZLgEhR+MY
         SHSfvBDxyJNz69wYKIdB1GmhfMAS0WA56rciHICtoRc3rAgeor0azPlVshd6k1mvgnGk
         Q9KhHXfJPnA7f8yo/NCXr9LfwlaHKOEw6EJwQfwaoJAaQA7KCWzoGhSTdGbMRwj8SlQW
         JfPEKms4Sx6N3dJBeGJpdoMQ41lU/6lzkm7G8seK1n+MCVCk85OOwS/aa+BADsZr8kxb
         m94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757135461; x=1757740261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z2cCU7dJci4fXTg8GbK2CWuzrGsJs5uLLD5TZBvmXm8=;
        b=jnYkbZB/X7MkHdKu5aJeATDD6qXIUrJI4AuBq/saRznV1kHVFsnTiQPSauYCfKWF4F
         ewXJ4v7cKzS4EsvZrQAguiRqpc6COLHNUiFOPr1gEBJuITtF8lt79rVoqmMaCxfnFvrn
         73ZOfX0czPkd9y6uw2FZ3FzMUHadc2ExRGq1oKK7Xeyn0MJSr6XUO7Kfu/j5mzYU09p1
         CeZMBbg/jJf671kgnk6BLVPGUX81u2EwvxHVITTwhHVrbdD3OiB+HPKGv+XceKkHs2gb
         O7y6qIT+x3wU9+Jign29U6TvY0srJ5SDNuS5apiv7DU/D5DyydyPs0gPGAmsvk2ld2tK
         01sw==
X-Forwarded-Encrypted: i=1; AJvYcCU/Ic+XOSHf4DAli8HUdgu8e0XnLrjSfGOEa/TjLsKfjV24NQSnJnedru329Cl34A+fIKuAWIn0Jos9MdTG@vger.kernel.org, AJvYcCVJw9YQQ9Nhq3dbQCxxCPFYlBnuYlzO+I3dm4wZF1JFZezz9pTIZeR9RiQut37beA2nFhI2KPA4Ry1o@vger.kernel.org
X-Gm-Message-State: AOJu0YzhTlXsP0cYBof+GKF4ke+tI6W8/l8kGkL0PChwlxBLGV25m25W
	iY4x7IO3b2ZMvQvd2bpmoU7OlYH6MdWOV1GK2StHjg4UV24GyZ+IwfIX
X-Gm-Gg: ASbGncvJqOHXAKt94yzVQNLKg+FfodDmfghEYJRvodpmWwYPDKfUTG7Zl5Fq7bEjk5i
	QTsY5M+ZtwmlhfHeVP3gBZBblbuodW+07mS+4ZBAyL8b5cbu6f5KoQHXnP/HpDAW4xvOfywKRwp
	TOaxcXvRs+F8lGVDRy+2o3G+e6UICV/0/qu0K9Yho+jfSpJCUddxNFeLN3Dlsrq82FMnhln+EDX
	ihkU05mc3/SR018iXoKWLUyi5sHzg8i1+2XOczUpfaJ1nV4/efBeDDQ17hC1LyW4EHwnvrwPY8Y
	kknA9I+WAJDFsYxn8DbNANiRlziNNhg7xgtEIrKbAV2aMZ38jxgbkGz0vY+EjDd/asS+0eUur76
	TLVmlmisUKNeRVAfbrERVN+cWbf2QDsh6MyXFg7x71yU3MN6fIv1/V6JGyAzXW7LIcovULdW1UF
	SNWU8=
X-Google-Smtp-Source: AGHT+IGx4czY+uSQ31TheeBdvMG1DMr9gDJ9jVORHiwX6binA9I0EJBe8F+WDLP35ZsDtnQGWqSsWA==
X-Received: by 2002:a17:90b:4fd1:b0:32d:43d3:8cb4 with SMTP id 98e67ed59e1d1-32d43f182a8mr1667267a91.14.1757135461392;
        Fri, 05 Sep 2025 22:11:01 -0700 (PDT)
Received: from localhost.localdomain (36-231-187-52.dynamic-ip.hinet.net. [36.231.187.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-329d8ca7aa0sm13118020a91.19.2025.09.05.22.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 22:11:01 -0700 (PDT)
From: Nick Huang <sef1548@gmail.com>
To: lee@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org
Cc: kusogame68@gmail.com,
	pumeining@gmail.com,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	n1136402@ntub.edu.tw,
	good@ntub.edu.tw,
	Nick Huang <sef1548@gmail.com>
Subject: [PATCH v2 2/3] dt-bindings: mfd: rohm,bd96802-pmic: Fix typo in documentation
Date: Sat,  6 Sep 2025 13:10:39 +0800
Message-ID: <20250906051040.22944-3-sef1548@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250906051040.22944-1-sef1548@gmail.com>
References: <20250906051040.22944-1-sef1548@gmail.com>
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


