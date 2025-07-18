Return-Path: <linux-kernel+bounces-737354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D37DB0AB45
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 23:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D61C87A24F7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 21:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F24321C9ED;
	Fri, 18 Jul 2025 21:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQHaEj/H"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B67E18E20
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 21:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752872932; cv=none; b=k7x15bjkByllXzaposAhnVhg/AKrA1Lx7jtB8SaEHr91TtcxRSFqcy5mNKi8Acq2WY4Z4jC2vYd5AMwQQfJSk82iLO7npyiN8Ta5cQZOmJK3sKEhStoXX7I2ta3CD2zXKU962MONwpd96ZnOPvQhHtEkLZRqEfnhW7YY5EP3r+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752872932; c=relaxed/simple;
	bh=Nu5mtZ4NwfZ8rujMonQHI4GrQ8sbEhrMWC62SCFw1Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XcwSeYMI2Ej6UdNBWJW4sr6a/UHNwnzXnmcyXL3bibJKTEUpDsuncj3vn0HKY/1D7WZFiMluHlcE3UvZ2LjpBVBe3YD7cJzF7Jk4imYygulR0QYANcscvUIfg1TGpRBLtp0Y4S4wgGAphRuPWLP19eWqGLCkdkIOSh0CiggzRTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQHaEj/H; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-615bb20b741so638368eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 14:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752872929; x=1753477729; darn=vger.kernel.org;
        h=user-agent:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pSULKMzrr8h3J6cHGwQRnm1S6z9BixXJHjAlFAzTitk=;
        b=MQHaEj/Hz5RioU18r3BR9Dxjr1MF7TQnfgt/nXV4Q54j9ZYN/zAuAnnPoScqELyiqa
         18Hgla32jlVUGa5IJh8bqGCGRsW4gxCJSyJiC5MsEAVS2DUdBrMpgXfHN5a/mpxAV4z0
         qLck8DTvMzzNtMRSBP5ao+AD5xVYTGBKsBegN24a9k8Wklh7nkPPIx5FCz1W5r4dy4Nc
         ZkLgPjfJP6pMuEu1gwPpTVH2Hj6L0C7ozX7iIkbX86rtIYQDnlu3mvQvSnIZWtlk1N9v
         BJFysht/0WOh7az2jXOb2hOLien/GxOambK7wmVkCNZzZgso72zzY/a7qRFHcblpps7D
         xHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752872929; x=1753477729;
        h=user-agent:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pSULKMzrr8h3J6cHGwQRnm1S6z9BixXJHjAlFAzTitk=;
        b=r9UAEo0lFkjzEixvstwFert6AG2BqKMP8jhZcRwSUQRr82btgpgDr6QgFmr6UxgZd+
         qkZnKozZJ4ctOrUATk/vpT45gX8vQSnZVsZfp5PaNK8RIPP9VdI4o4sDsmJhSUxLhH35
         VsNQ21UgOvUEcImyhJWAdYm2e/a1tuAN5jda92mVOXRliWYTtGgOMdCbjePaRLBBbakP
         0RyA3+BooSlt+935rk/Pss3Pby3GuTVedpWf70DIBWgysIdFFohk8mSOqL9Jv6vITO02
         xu66h1PTd/REFdsrsvKo1i6BArf3Lq6cd0sjDQtnFZXTlDOfybKpNHfvYRN4JWyNPkqW
         1LHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeSOZNnI6mL2GbL2mqDi5gtOjLEoHDHP56sRtdalhx0RkRjqQsRx7xicdQg+TREp65DfHfGzX6KwpGGgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNe1ku4usMu1ep7wPHD0jsBg2kZb7kBDyPirxzvlqKTd0mQOyK
	3Ue4AnC6a69FZIxh0HPR6FXxZSyJXF2Z17xEiMLRVz0ERl86AwEXuy8yOVAV7XmChok=
X-Gm-Gg: ASbGncuwkAQYAPf9FnvRppYHA/yzGZx9uf6/N+UCr1CEHhcd1NAkQXhaPdcRVVbjx6V
	0lEvAVWw5MZ0PU3EUTu0iX5TeJOGSrIXk55lFiTt9zB03S3ogrC0pY5prbwNN6TcwaOmMTObHAN
	DzikGznwJu0j1ffFk9VwKJ56ZhrhkSFl6FIJeKC3IwnrN9WxSqdDY9nfl12mohtpHJlxdyRbzTi
	GG7FAHGF0l8dnnKjLAWzdTrxEA0wZKIRq53A3P3RWCY1lY4xspFOVoxTdTVKwtP6W6FDl0gOM8b
	WP7cUf6Wp1zWuplOk5HUL6iR/ojY3xeAT5hg0BTLImTLXXrzlXjLxJdrYp9VY+j/hUd+4ql6+zT
	y/gBlTrJKSaypkAPPj/57x+CcGxvtFJfNXbqMJ04cREnCFXqbNCLRCmrWUc8YXg==
X-Google-Smtp-Source: AGHT+IHx0kDpjfV8SxDOWW+9C9/fEq/WS+qbThQ/XaDA0IiNPkWI3p28qTBXAzs9RbnlCTE0ZgP4Tg==
X-Received: by 2002:a05:6820:201a:b0:615:c2af:de7 with SMTP id 006d021491bc7-615c2af11b9mr2147349eaf.4.1752872929294;
        Fri, 18 Jul 2025 14:08:49 -0700 (PDT)
Received: from MacBook-Pro-de-Ignacio.local ([181.161.11.224])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73e8369a85dsm935936a34.27.2025.07.18.14.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 14:08:48 -0700 (PDT)
Date: Fri, 18 Jul 2025 17:08:46 -0400
From: Ignacio =?utf-8?B?UGXDsWE=?= <ignacio.pena87@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v4] staging: sm750fb: make fixId array static const char *
 const
Message-ID: <aHq33vXh0F481FB-@MacBook-Pro-de-Ignacio.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.x.x (Linux)

Fix checkpatch warning for the fixId array only:
"WARNING: static const char * array should probably be
 static const char * const"

The g_fbmode array cannot be made const as it is modified at runtime
in lynxfb_setup() and lynx_alloc().

Signed-off-by: Ignacio Peña <ignacio.pena87@gmail.com>
---
v4: Sorry for the confusion. Previous versions had wrong line numbers
    or included changes to g_fbmode. This version ONLY changes fixId
    at the correct line number (734) against current mainline.

v3: Apologies for the confusion. v2 accidentally included changes to 
    g_fbmode which breaks the build. This version ONLY changes fixId
    which is never modified.

 drivers/staging/sm750fb/sm750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 1d929aca3..82e01f114 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -734,7 +734,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 		"kernel HELPERS prepared vesa_modes",
 	};
 
-	static const char *fixId[2] = {
+	static const char * const fixId[2] = {
 		"sm750_fb1", "sm750_fb2",
 	};
 
-- 
2.39.5

