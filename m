Return-Path: <linux-kernel+bounces-736228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A5FB09A44
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 05:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEC3E1C43E86
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 03:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA971CBEB9;
	Fri, 18 Jul 2025 03:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUwQEYwk"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD69E1C861A
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 03:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752810563; cv=none; b=Sipa3A09ss+Fr4ip7ZhGoPFcqQ+QKDMbzC9LSOagP9Bna1bxL3A4LbsYxI9BEGgrLqvY7BGl4TUEPNZqWafZ+nunUY3UbRnuxf+wncU6jB8W67Nq2qsqqW/6mVJ4FSN1DngagKJ0yScXfA0Y9RUvGXpfM8c2+yUlQ3ZEGB77Czo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752810563; c=relaxed/simple;
	bh=TUYntXoe7RxxZnZMgxLkh3iZOefyIpODGMo4hHDC1ec=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=AQSYr6aeMPOS6voch44Eur90C0+kisw9S8hG7gO56yJjXM7j2Xe+HHUKxRM3ZsITq9x/cUS0XZHtrvD0IaH1vgLozeAg07wl8/FMR21zBa9jPA/89ixqx93D8iGApzoAIf3Z8M0z8jufR2HqNYVXEsZ0b7HU8cSuNRp2t7lO9GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUwQEYwk; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7dfd667e539so188509885a.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 20:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752810561; x=1753415361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/ahzSbzOVkCgO0V1iipUMnKt+g1BWb60GhxM8vm63ng=;
        b=NUwQEYwkeckJmkpZahOp6mlcIDXFmRJ/Dc6ydpxjYLgtAol8sMxywHeXdNkYIJxV4L
         yE8ON77oLB0rXyTfDIfx0ACPJGwA5+UJzyFccxNZjQIdZn8wdGh3TRpUH1y8IsjCgdv1
         oOObQW2vHXsvaYTZOHXHaz+VNkOM/PxKoWpC2xmYK+QLcHG3sLlBbqz4gue/FKt3eh6q
         CWDxMld8FhcWzNlURqtZcNCte5xW4ePQJgV6eYlKky3rGaEIBTNHs7XRjYynI0KulpkK
         TJVd2hLZ8gXa+fMB2D/L3NRVXQBGT0Utf2e8pcy7NVlLo127K38b5DFOfQX5PegopVby
         tKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752810561; x=1753415361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ahzSbzOVkCgO0V1iipUMnKt+g1BWb60GhxM8vm63ng=;
        b=bSUyHSbbY+pVOqa5UZecNkYmhv4eLzo98UBXXYiekr0VLxACTPJC2axqQIcxxY7HEw
         lDGQpeU0fVK5pOJ4tjn0uK6+oJQRVGkfI6afn0qR+19DBXTuM3EblIWLpAWR6heiAGJY
         JIqrNWw0ECuEQ9qIQorChiTbpyrs6+SwWxOZ5bNq41vNZPzx7n6NU3zHZCSl39EoHU0N
         m5AYG32OPFocCjg/OF+4Kxm8SuJ5ECSdTwJxARxkgJK/ytnPyjtSMrJ8irdLLr6K7DAG
         5ddJpP8FqL4NSVFHvhck1LuZSUKbTEqdtMcwKOKMzXro7APRtRlev+Q4YszAFcZ/wRyN
         Pl6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUpOdxZ8VjDaJ/wfJBuhtb1pL3KjZj+mS1BNr4tAi7AvxO2Esn9b6u6yu5oUC91b/bEmZHS012xvzm4a58=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxq71Eb10ThXpJTRRpim4SpNySiAfbPZ35nbumFuzgZ21eg2Pv
	0KuF51VqNrk7ocS4itsVEzJuaj4ep638RxG3FbCUmukVDauDT3ZknibK
X-Gm-Gg: ASbGncuM6Q92eCws6VsTArB8EPliFpqEyyisdD8ABSp+h7y0WNSGYlyaU9OIEKnaHyG
	mI1QsCLCmXVEyoazRLFkr2HKQHlZfKdCL1ecucawLpe7gaqo0avJygio7ADTJJM5S5s6868aAZ2
	kB4oAz4AcjtQI4cxTs/MXvMzaLdZOrvnz4WiMa2ey/vyO27AnDwpa5eKw81cSmxGIhpFt/m3dPx
	AZBIpANeT/ssNH8Sxy37TjmNCj14WTB4EtLCYWzWJvO5zWnflSZS1fFuhKVv3Txy3AEIfFVeXC+
	MS+5NZze6wp36oKI8LcyeM0iqslUlaawB6B+ijk8mdG1kB4W2A/ThkFIsous0rXWVwd+0o7g1lo
	FqRXrZEeIZypSrX+NGj59fWu/X+EieqYFi4y+ajcyObfV08has2cE
X-Google-Smtp-Source: AGHT+IHwz2ZQ9UVQsUrHY6uima8WLEW793ry54aYseMx0tESu7LoYKDH8an0Vh/LM1hsaavk7gb6eQ==
X-Received: by 2002:a05:620a:4726:b0:7db:e87:918b with SMTP id af79cd13be357-7e3435ead7dmr1235595585a.33.1752810560690;
        Thu, 17 Jul 2025 20:49:20 -0700 (PDT)
Received: from localhost.localdomain ([181.161.11.224])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356b47f8esm41183885a.33.2025.07.17.20.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 20:49:20 -0700 (PDT)
From: =?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
Subject: [PATCH 1/2] staging: sm750fb: make const arrays static const char * const
Date: Thu, 17 Jul 2025 23:49:13 -0400
Message-Id: <20250718034913.49300-1-ignacio.pena87@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix checkpatch warning:
"WARNING: static const char * array should probably be
 static const char * const"

This makes both the array and its contents immutable, which is the
intended behavior for these constant string arrays:
- g_fbmode: array of framebuffer mode strings
- fixId: array of framebuffer device names

Signed-off-by: Ignacio Peña <ignacio.pena87@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 1d929aca3..82e01f114 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -33,7 +33,7 @@
 static int g_hwcursor = 1;
 static int g_noaccel;
 static int g_nomtrr;
-static const char *g_fbmode[] = {NULL, NULL};
+static const char * const g_fbmode[] = {NULL, NULL};
 static const char *g_def_fbmode = "1024x768-32@60";
 static char *g_settings;
 static int g_dualview;
@@ -731,7 +731,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 		"kernel HELPERS prepared vesa_modes",
 	};
 
-	static const char *fixId[2] = {
+	static const char * const fixId[2] = {
 		"sm750_fb1", "sm750_fb2",
 	};
 
-- 
2.39.5 (Apple Git-154)


