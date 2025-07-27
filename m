Return-Path: <linux-kernel+bounces-747187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DF6B130D0
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 18:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C73E3B72A7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 16:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8823421FF57;
	Sun, 27 Jul 2025 16:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYASbCX5"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CAC21CFE0;
	Sun, 27 Jul 2025 16:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753635535; cv=none; b=EvPuH+ni/E2QJS39xc2imxDtIF77doWRfqn6FIwcw72vW8z+c5VjwsfOV5BIxgWUgRASXOWYe9+3YFa8OGhHB1nOEZga4UzekcYfQ0Ffx2SiFZUYkaQNUonxQubkh+a+KOoIfcttVOh9RKgqKMh5fTNKTb8hGGkhaI6tknCYlW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753635535; c=relaxed/simple;
	bh=R5wd8/oMEQ9QXd9WSk8RdlzxAMdu6de1rpwcvGq7Cb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F8iPln4JSWjRmku7toPj9/YKYkBOMxFSivrW+es6CG/S19zK5N2E6WGayaUDqLOvqcQWU50IcCJ9rjDC80iuCO4b2pDD2N6TabSit854xXhWIYG7dCixQc79pIPZ089Et1BP9iAoNb/7C935iwisWwZ9ZWSa4Ojijr1vILA9T8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYASbCX5; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4561a4a8bf2so41952345e9.1;
        Sun, 27 Jul 2025 09:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753635533; x=1754240333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OSNmwFYper35EjFwmUUh2UbfVWPJvEUcZ2PjzDYJk18=;
        b=EYASbCX5KQaLBySqG2MHjKnLxsux51R1LmioZ8n1KEPOOhjf8BbsZ5RURQ163QYG4N
         wyx9Ue2QtKeY0m2jbQuqWx+K58FCYtVjqfQi5BvUCRrNgPcbr4S8t3OlBDNwycZPtVAq
         gTjf1Dx1psxWZhoy/mPCfLJnFlv55eXGRJgTLzcxWqonZMkWJqKocprpdLokunXFCfTB
         qb5hnHelyEsNgXJS03mVnAWhEC8wUOX32Ym32YtBg//pPxE1NjKB67rYLgKPQAYfGhJ/
         tFotm254Y59VAkt07PUmAhDHxKmq1nb+Jo/mE3tJj0V5N1X/LQnI0O6+QeAoFiLZDXZP
         lZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753635533; x=1754240333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OSNmwFYper35EjFwmUUh2UbfVWPJvEUcZ2PjzDYJk18=;
        b=MFO+Ti+Nb6/ZOkSFNh+77UdDeZAJSE4Brp1eLzBmlcTYmCIXjwuX26mbaF3wvhZadB
         AyIItOo/UEFRBD8Q1CngdbKTJbrRGkpd7Z4eL1HAdG0jLaW+LD+0R/pUnK+iEcAhcOHT
         AyDFcfE9z42Dmc3rGazLITlrrvH4XkZBpflen2tfejNZQwo97M3dSuhnsSjWpG2Rqg1B
         R4uFqrnPldaawhvgC4fm3yQsk7GLuKDZ89g4mS7ouZ+QUFcf/Bpzfvjx611/7OI/YcJ+
         erhioTVmdzVR07y7RANbS5LOjAi1oQx0AxgWQZO206390b0WSoDLX4KPwPQfhyHOjREO
         rpdA==
X-Forwarded-Encrypted: i=1; AJvYcCVAR/Hxjb8K/7OXumw/mBOZ8IU6OGqtV7f8w9leXkHIQ05x2B974FGfD69OyOsUkwZJRSlVP/hwzeYi@vger.kernel.org, AJvYcCWWQPyldY/wzTPp958UH4vXLuHHFakXMEGlhEkvh4ziJF2a/RP4iLV+ZvvF0OTujeMfH+etIGmwTq2hhEAk@vger.kernel.org
X-Gm-Message-State: AOJu0YzoUkieeOS8OY2hdkgqBiW9a8c07O+Wd5XUl+IB62KG7HHgOu9w
	yyB5Zn2OHJ8FUHRkShPY4P3Vr6QxMBLPkMMp1fQtI6godSsxflRSqV+2E265b+Q=
X-Gm-Gg: ASbGncsAEIpQqQINx+6nygYDRumP2MwgZbVCZjcS9HLyHkPavKoHjWexD+uh4Uorlnv
	L80kBlHWMCR7AoaTYzMANiTouQNIGjnJnf9gpCVH4t3BXBv8ecTChQm/baz4iQi9EIS9Y0iVr4L
	NKAa/EqjBFgFEfwysJ+TCC+sfnqWcZ4Ut7u85YC6ZnE2D5Rz/cUmM8Xcp5QTJbCh+PJPnGffDx/
	uWfJJb5IEGCi1n7XAkxlVDmuB/9vm2TVBPxeUCbJPYvtwQwn2MS5hS0pbCNOyRYuWOU0Z7KKitX
	VkUOOOs7i8V6FKQKRugMGQjGNWfaQJ5ywFHTaQRump2SmRnre+fSXA30ijHvo0/kl0W7SlmRK7U
	PA47rDAEwT7KWCOFvhC0Uvgnq4cTHhJ1c8i45dAiH
X-Google-Smtp-Source: AGHT+IFikEiKDy+6gL3L5K9C6PuqVBZ9IqjJUfuTz+zzyU0E6yfyNyRSgG35GbsusVUWoP9az6O5Nw==
X-Received: by 2002:a05:600c:6995:b0:456:dc0:7d4e with SMTP id 5b1f17b1804b1-4587ff28b4fmr34996805e9.18.1753635532248;
        Sun, 27 Jul 2025 09:58:52 -0700 (PDT)
Received: from alex-x1e.localdomain ([84.226.118.249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458704aaf20sm128545745e9.0.2025.07.27.09.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 09:58:51 -0700 (PDT)
From: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
To: Douglas Anderson <dianders@chromium.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Subject: [PATCH v1 1/3] dt-bindings: display: panel: samsung,atna40cu11: document ATNA40CU11
Date: Sun, 27 Jul 2025 18:50:24 +0200
Message-ID: <20250727165846.38186-2-alex.vinarskis@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250727165846.38186-1-alex.vinarskis@gmail.com>
References: <20250727165846.38186-1-alex.vinarskis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Samsung ATNA40CU11 panel is a 14" AMOLED eDP panel. It is
similar to the ATNA33XC20 except that it is larger and has a
different resolution. It is found in some arm64 laptops, eg.
Asus Zenbook A14 UX3407RA.

Raw panel edid:

00 ff ff ff ff ff ff 00 4c 83 9d 41 00 00 00 00
00 20 01 04 b5 1e 13 78 03 cf d1 ae 51 3e b6 23
0b 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 cb fe 40 64 b0 08 38 77 20 08
88 00 2e bd 10 00 00 1b 00 00 00 fd 00 30 78 da
da 42 01 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fe
00 41 54 4e 41 34 30 43 55 31 31 2d 30 20 01 2a

70 20 79 02 00 20 00 0c 4c 83 00 9d 41 00 00 00
00 00 20 00 21 00 1d b8 0b 6c 07 40 0b 08 07 00
ee ea 50 ec d3 b6 3d 42 0b 01 45 54 40 5e d0 60
18 10 23 78 26 00 09 07 06 03 00 00 00 50 00 00
22 00 14 e7 f3 09 85 3f 0b 63 00 1f 00 07 00 07
07 17 00 07 00 07 00 81 00 1f 73 1a 00 00 03 03
30 78 00 a0 74 02 60 02 78 00 00 00 00 8d e3 05
80 00 e6 06 05 01 74 60 02 00 00 00 00 00 91 90

Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
---
 .../devicetree/bindings/display/panel/samsung,atna33xc20.yaml   | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.yaml b/Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.yaml
index e36659340ef3..5e2ce200025f 100644
--- a/Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.yaml
+++ b/Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.yaml
@@ -21,6 +21,8 @@ properties:
           - enum:
               # Samsung 13" 3K (2880×1920 pixels) eDP AMOLED panel
               - samsung,atna30dw01
+              # Samsung 14" WQXGA+ (2880x1800 pixels) eDP AMOLED panel
+              - samsung,atna40cu11
               # Samsung 14" WQXGA+ (2880×1800 pixels) eDP AMOLED panel
               - samsung,atna40yk20
               # Samsung 14.5" WQXGA+ (2880x1800 pixels) eDP AMOLED panel
-- 
2.48.1


