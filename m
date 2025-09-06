Return-Path: <linux-kernel+bounces-804050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27555B46935
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 07:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 676C1A436B4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 05:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E622A27BF7E;
	Sat,  6 Sep 2025 05:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKHtgUAF"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54D427A904;
	Sat,  6 Sep 2025 05:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757135461; cv=none; b=oTKZdolfbgFACfmnCDJAiGQ1YFTe6RL7eWLAXE0/L1e8hWh4w2MaxWgCTZRtDtwqEKjuPRw6txU+9txGnJ0y77ixgF1HHaRe06Tj50WFC7S33x1bWayuIKemyGfpaJ6s5/CjJOqGMOMIlFULD9u5gQ7EF0I/OqkIhnxWqCj45JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757135461; c=relaxed/simple;
	bh=wvydw5DGPXse+1/MJhAeAfjtwWbGLryMTnQ9WvMojlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V1jDc6OgIzqMQLuAAB1CUMvKNMjLPnqZGLxESvfR3pcOfErNKYulc0W6qIzNPOhi2k8S2CPIg5pzhyLvatD/R/kfiWXIjFBePTsTJUc2aZglfWFieDj4pzNaUp7QPmK4cxjRsuod368BZtpbpDA+E0TIpAZM27oXVOJMUUu9gtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKHtgUAF; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24456ce0b96so29605485ad.0;
        Fri, 05 Sep 2025 22:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757135459; x=1757740259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0joNrAGADZgtCnbGHtr8kEwpaDCWrFPdhfYx7W9o2I=;
        b=nKHtgUAFk4SKDwLxzdgRaHj9YtqRAXrHzb+HT+vouBOzSBjhNtlxg/AxsjMz0EvTP3
         YYUht58uAUWNVICwKQRz4WJPj9nD1c5dkwCvzq2TCFo6M16SDwVDwHeeQbRCZNMSH7K3
         FoKnJfuUvVBzNCuiAeRvRBoN49/L8x+M+WqOEw4TdRZleVxv9cPyIocnOI6p0Vtdxb14
         cLqmtDHqHAWfl85PTQRCXwRDL5wzXQNJ/NOzBYnnNFDdX/bmlj1Mx2WPn4aK/J+dKOM6
         hXQXy78xesgZNnkGjeneFwTj4cgd1AYEgvGAW5fUBiZqUlJ8wtc9ACsO6hdmnCgsbOmX
         vqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757135459; x=1757740259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t0joNrAGADZgtCnbGHtr8kEwpaDCWrFPdhfYx7W9o2I=;
        b=uURmlTUusVn+eRvA58uUD3kPwkEr4hxZhPLOCi6PsnSp+mfjFtE5s3mwC4ccCRXQZ0
         rLqKEpzwzOxG5TI6eGCTdDJ6qG43sSoReDvW6raFGBqX1bqCPwuoRR6ZoDTHNe+JSRvN
         DoP7fYjyshDdniEkt1K1/1bx+ZbuPVD5D5DhINTwV8EqP5UxmUO4LlU4+OAWOWQT+BRN
         ibHofj9BcQksvX9jO3jS6uaGUEvZG3OlAQh5LN3iNCjytuZK0+6awtScKPOI+bGK9473
         fJJGlb+CgxRR+qhrdpniZiZjen3VatJpVxJbR0VPhREBTQo8i4jiB0N8eCN04h308z1K
         XLNA==
X-Forwarded-Encrypted: i=1; AJvYcCWzZS4D0J9ef67VmvMoOoX4UDcsT3VOM7Be4iTmYwaA8mnkuUpX4gO2Z3FWQo1Q8JhhHnQJ3Aa5CMfl@vger.kernel.org, AJvYcCXD7XpyJoVewC2P+WcR1lDBO8ECJgEzPYUyTbunlNrJuMYPkkK4A3FhNPXOGSeIivbU7EcAJHmhhNV5sd//@vger.kernel.org
X-Gm-Message-State: AOJu0YywIaw1XNo0YLh0ugAFSUVrQWeph1f15dpFAVPgdEQndiN1ANlB
	EBqRwJFSEysZ9dAXFYqLY2uJRO+cZP/ZhTcCtddppLZyhR4MxwAhMDzt
X-Gm-Gg: ASbGncv/8GRK45rxSreVWuVMyNQEMbW/nyEMEfvMkONHay8Rm1tdzwp7Wg+snHOKuLS
	c6X71gXLeoH0dvr4BR+7p1RLXjgkeQ3CY05CxjdxBcFo7qUD5UQAwlI6VG/mszfn1i+6JL3uxmm
	gCdYliwSU2nAZjsQMG4xNETYVo2AmH761CHJVfqi8yERM4ZC3zPDihgfO3VcOhrLLSWUrSSr5Rl
	JigzwV36iapUkZQrIGcSdqDSrnMxQoMs9AVKvDpRMglxkb8alu9UR9OzlERfgR2g8jyckOIMAf8
	dCyqtOCGrtY8CtBVFsfKv60tQWreN57LV134qSZXlTDqrT3qBaXiqjVFddLM/u2scp4RwyVzWKp
	XUDOurNb8H+2KC0J7Pxi/7GwO4ofdTqlFY2Kp0vk3FwlmvLLgVO2vJKsjqTHldyvNrW3FdBQplB
	3AigE=
X-Google-Smtp-Source: AGHT+IEMK0yj3vrUfC/BBXC/17h55sC7CycQAJoqJqYv8w1sIXthghrB3GKaQ6SM+8FmHr6VOCZTuw==
X-Received: by 2002:a17:902:d4c9:b0:24c:e211:daed with SMTP id d9443c01a7336-24cefe2272emr73503995ad.26.1757135459077;
        Fri, 05 Sep 2025 22:10:59 -0700 (PDT)
Received: from localhost.localdomain (36-231-187-52.dynamic-ip.hinet.net. [36.231.187.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-329d8ca7aa0sm13118020a91.19.2025.09.05.22.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 22:10:58 -0700 (PDT)
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
Subject: [PATCH v2 1/3] dt-bindings: mfd: rohm,bd71847-pmic: Fix typo in documentation
Date: Sat,  6 Sep 2025 13:10:38 +0800
Message-ID: <20250906051040.22944-2-sef1548@gmail.com>
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


