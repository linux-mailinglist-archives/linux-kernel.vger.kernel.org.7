Return-Path: <linux-kernel+bounces-804008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8C6B4689D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 05:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC8235A467E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 03:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD1722D780;
	Sat,  6 Sep 2025 03:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3ZvQsRI"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3F3238C33
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 03:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757128900; cv=none; b=KWnQAihtseYbTvq+NFxuppDjhxiA7B0vflPTFGrn8lRyDVG8tOixyX1cb3OrjHmB+i1dcCrYsO7MbmE9gr7c5n8sHlGT0Netm5NgsOc3G8xwj9LrENH1d4gU5f8yYp0WG2MTLKvQLlvXytPETwDH1rnIfhYouW3DBPWQ+l9mSV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757128900; c=relaxed/simple;
	bh=wvydw5DGPXse+1/MJhAeAfjtwWbGLryMTnQ9WvMojlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KEN+NrUADakMrDgu9/e6h1Q1LUH9iUjgbXf5SCERMkesh95oGmNVAWdRN/0VqctZExc/L1MCSRQ45hL7MluKblUFh2+3YsMt/sPQuo7UTNpMfvPEUurFyrS0EEZzTBFMdfvb+OVplFv7VKvuFr3BYAMTELkAv4qDyTZt1LAP+bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3ZvQsRI; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-25221fa3c9bso149085ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 20:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757128898; x=1757733698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0joNrAGADZgtCnbGHtr8kEwpaDCWrFPdhfYx7W9o2I=;
        b=P3ZvQsRIHmoqYF5CMrKUzFfPRNSPqMPy+uUkChMbIjtoaN9gXgvXGbX/w8sSbs7XHd
         ryUAqsBr5i1IDEGQbQWpd05D8Eq3JLrEAnjcfdbqufbABS2Yh1C+pqgd4DJ7iWO2YOix
         PMtg4q53PD8yT6L9xVKxCqj5DeEGRbujXqxMr2AEE0Usa/hFzcke9/N/wDC/j3DDSP8p
         9r1OfIAWw+KIrSSiEL2107CyguVnloxCXpDfwx9UV+VNzv1OeVwtdVV8pXDvyW/Q3hG7
         owkXkOZYpgvgHU4wTwM57dhZegUMKAc4P15b1ra4DDd/11wqYYUGW/gGKC0fqk2vfmWa
         XzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757128898; x=1757733698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t0joNrAGADZgtCnbGHtr8kEwpaDCWrFPdhfYx7W9o2I=;
        b=ituXYEIzavgjKC6UjohuEgll1F5MbcYuFhu5eHqBf3vt+/CD077tNc4uJf8SJuosp0
         0oVl4qqKtDN6ntUYa0iVkzxWfEqsfQx6lVCu/pQNMkwne2bdDM2mi842jrAn0NToE+fJ
         +CWPencFt9dSfowe/Y7ATHju8U9gI9pyGQB5B+5Uojs/mJ10flALXlv5ySKE3rwnME8i
         i1EY8F42LyQiTo3yfd31MhciPxVc/EYaugIstUAUNd1ndXexDWIh6uH2BjeC4klr5tHX
         +NXYEAHDwxFgOJCNTarLGNOMaGm64NpGk4APbaYvfz+t5puR8rwAaCfrsHaZ658Y1NkJ
         9wtw==
X-Gm-Message-State: AOJu0Yxiycxj1v37yfVqWFWCNkBw/46vDhpqZhWxi733W6ks2kp6rCHU
	uhYPbhdw50uP9jgvTwLHPoxfNGooWJZI6/uh1MIvom7YGKyeEfBJaaD9LBPz6g==
X-Gm-Gg: ASbGncuhL1PmRLfZZYGnO9CObE2+vn3y+eVB3cyZRRcZXdOY0iAX4pYk6GvEfGnyatb
	q3+EU8E9uJQClgTqgwjN9fYTSbp25NkF7dLDWM3B+uPX/TyIFniIJ2egf106u/Ey2GC5zyv93a7
	p//BTgdULy4VWzFXcKL2L3T4Pa31MCGT1ZwCoqMvc7A48fNzOI6VFlZgP8f0/ZprgVqORCGG/pB
	YdpwgAMqkOvRD4WBMXqDhkYWqQeyuWlSuQzl2yWXAroj4eLkrzqOOhLFcD0gvGu3QwzW+ZeeRHq
	9R/zA+uBHyfzpwgsD7mB58rToX8xgQvV8ID1L3ru2bf2qbBvTFTiEhqtSpBjeH/Q+KG2eLc6WGc
	5fgIuhx5JCR5AGXkdsdw7vDd8ypHSecxFsf99HoHxizirLx1tKaN75x964CjcJ1+YZoOE0ly84B
	F7c6E=
X-Google-Smtp-Source: AGHT+IGqpyAjwDuPm5mtRO2smv3Mt604heGenk/LVWXi8tow5xBAj/uXk3a60yXM6KKIeIWs5IEXFA==
X-Received: by 2002:a17:902:c40b:b0:248:fbba:964b with SMTP id d9443c01a7336-24cedfa7ab9mr68673025ad.12.1757128897749;
        Fri, 05 Sep 2025 20:21:37 -0700 (PDT)
Received: from localhost.localdomain (36-231-187-52.dynamic-ip.hinet.net. [36.231.187.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24905da2896sm228127265ad.81.2025.09.05.20.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 20:21:37 -0700 (PDT)
From: Nick Huang <sef1548@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Nick Huang <sef1548@gmail.com>,
	Johnson Huang <kusogame68@gmail.com>
Subject: [PATCH v2 1/3] dt-bindings: mfd: rohm,bd71847-pmic: Fix typo in documentation
Date: Sat,  6 Sep 2025 11:21:21 +0800
Message-ID: <20250906032123.21534-2-sef1548@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250906032123.21534-1-sef1548@gmail.com>
References: <20250906032123.21534-1-sef1548@gmail.com>
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


