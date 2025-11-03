Return-Path: <linux-kernel+bounces-883713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C38A9C2E2C5
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 22:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5D1A3BC6D9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 21:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6032D47E6;
	Mon,  3 Nov 2025 21:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qkq+0Hyz"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7510423EAB8
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 21:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762205845; cv=none; b=UJU6Gn4V8XYW6ManAXTyFaLdg6xEOQs6QTtyrIq+QUcSrHsWgu8Kj+Sm/EzG/2nb6jgHQMmuV9s4MuxIBk4WaVUGZwoFuS9KSK2W3LHBBspLJwVkLFnKb2PVyolmx/pjyewiVIaa1/7hXl9CGMZJSOc1xfJv/l1M1lpOR2LMn5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762205845; c=relaxed/simple;
	bh=bwUE0AEViMrnJrT5BeW1KiTVprJIxhRAE5QIy+9RaNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hGgEIw09/PADMf58pqLue6zsZ1lSilGJh4DBoiRBK5UNTdZihGKjrnonKc69xDzbUpYhuHFF/PXQse7GXyBhYpaDxL5Px//rkRfIVpfexi1tJ4wWs7m/OLBJlD6R8LUwSeiBoQ/Kz5g/tfsVAFZ9smcjdJHDrM+9b+T3rvnFQRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qkq+0Hyz; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-57e8e67aa3eso8264448e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 13:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762205841; x=1762810641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TIEasfEoWnWNY2LVqMGpsjYcqvlGlAzvdVLw5KGeMSc=;
        b=Qkq+0HyzzZHZ3N0QBhGwGsiRqaT2CPys0HVoW27xzp7zyMiPgBAzI1Ln45rbCnUB0S
         ZGhx0E5SHxqTwGXQD9MPEnQCnKYDYCVUv+rPgRxxM+fUrQjqdUle+HHFprRNlHXZzqAv
         wpeW0kZL7pamoPy0KFOSoStpQtHz3dfyA1b0LhQzcvGK6YYTruBYY3Q/JCpyFa+KDlUs
         st/MO+PYL9OjlHIhVvMGAxgfIX6dkD9TDSBrzk4ZLkxwpMjSYqV/n+39FCvEw4YwbmlL
         j8hj+7C1UKZGZ4qAF8DEfYYKykzXRDXWR/m3Xp51EI+gqqQ8xMNRI1GJO8Rmt1KSQdL/
         bSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762205841; x=1762810641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TIEasfEoWnWNY2LVqMGpsjYcqvlGlAzvdVLw5KGeMSc=;
        b=KXCCp1fVhMIwA95mlQxgztufejyliF2K4Ifcab0RZddWxLfC6fpYJf9UNR1ZDYHr/R
         RF+p1QYKaUfEDx6i0uGUBuEsbAQMaMtk9DWnABHWQOCbDTYcmjU49V8rMcTPURFIeidC
         JI+7GAlOOiu4YyBd7NeANinuQzB95DKN+Wa/YU5UAd/8MIbgNaB/BUsYGCP7Qsou9nkM
         Ww3jCPWZuEVu5O0I7zswYYtqtPGIKYrv8Eay4bzBnWlrzcWH5YUJhG8rcs780tCBQSll
         X0bJ96JF9RcnMNeVeviwPWCUI2G0neoJB1JE8uaeTzzCsxDik8ptMPWn7djBi8rzvvbY
         nGkw==
X-Forwarded-Encrypted: i=1; AJvYcCWe4MWCRRgtJo1EDhGvvZctANVXyrvwD8KDjwhO/qMoaBYu3cN/O+uicnIPfxgsGfHHftIBGlnRttZDbkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvryfyLmwrzLCzdhQXwZ+fnDo0YRCnksJiCay5MGjX6iOfm1MP
	VuhR8ma8p5JMSPO78GxzOq4AaKxzinhSUsBMcUsCeKdtIVhMUi6h86d8
X-Gm-Gg: ASbGncshipUDlvHW0XulIa0tVpb4Qku9pZXjNjB4EBP9jsUn1zaXWb2Y0nzTg4QU5LY
	QX+f+dRKetoHYUP+v0qu0oOjgTGxfT6E5xPu6wiCMkboBm3wJm1Ue4mUJlCrQpF4lw8OTm5s3F/
	ySseOjZpEK+WfGe+3/B3cufYxBD2weNsn4eqP3PX1aqKdfZ2pkKsfYWZK1t7mT26fs4Qrmzv5Sp
	f6b0jlmZmDZyNjIDiVq2akwTJvd5K9RhTrHcqyhW4ffECy2EjfxZITZLY/F1wEQdcRuTTikUzuO
	j8UA0V3wt4TifNn+P3aItdB4ph8PC1I5WOGQMt8DTS1mDq9QUhXjfvSfhbSALcX1ewB0bfpQl6E
	A+ZuZhGtUJcP+N1ziasp2XQm35TWdXGAvALO+apXhdOtgT9HAX61zoUc0IIYlLoS4Mzy7jvqBG5
	M+ynn9W1ai6RHsmQ8CWqQe0hX/bNYjDzDemP2mtkoc3PNhCUyKzSmPrA0lO2sEr44=
X-Google-Smtp-Source: AGHT+IFnY7fYmvQfsaRaYtsmIIsqU4wi13OWjaEny68FhNPEI5uvWjpUlhgkcUsa48OnkmrLA3SS6g==
X-Received: by 2002:a05:6512:3b0d:b0:591:c8ef:f838 with SMTP id 2adb3069b0e04-594348c3813mr250049e87.17.1762205841300;
        Mon, 03 Nov 2025 13:37:21 -0800 (PST)
Received: from buildhost.darklands.se (h-94-254-104-176.A469.priv.bahnhof.se. [94.254.104.176])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5943444170bsm200518e87.80.2025.11.03.13.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 13:37:20 -0800 (PST)
From: Magnus Lindholm <linmag7@gmail.com>
To: richard.henderson@linaro.org,
	mattst88@gmail.com,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: glaubitz@physik.fu-berlin.de,
	Magnus Lindholm <linmag7@gmail.com>
Subject: [PATCH] Alpha: MAINTAINERS
Date: Mon,  3 Nov 2025 22:23:50 +0100
Message-ID: <20251103213656.25912-1-linmag7@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Magnus Lindholm to MAINTAINERS (Alpha port)

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 46bd8e033042..49ada25357e7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -915,6 +915,7 @@ F:	drivers/staging/media/sunxi/cedrus/
 ALPHA PORT
 M:	Richard Henderson <richard.henderson@linaro.org>
 M:	Matt Turner <mattst88@gmail.com>
+M:	Magnus Lindholm <linmag7@gmail.com>
 L:	linux-alpha@vger.kernel.org
 S:	Odd Fixes
 F:	arch/alpha/
-- 
2.49.0


