Return-Path: <linux-kernel+bounces-838603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D34BAFB89
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 10:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CF83189E609
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 08:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931CB2877E2;
	Wed,  1 Oct 2025 08:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngSsctkV"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757A1287255
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 08:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759308489; cv=none; b=jY5VdUrZFBnmiJ1sRN50ubG7VoiTBZOZrSsGTUqVELKqrMmJQXHIweVwU3kZPY9YPTmISqqG2pSs/nT70nuG5qEYYassX7M1Zd0Tik6++QM8KcpmgcDxpfVw6Yf0+OY8+OFgeXNG3mhdy0ksga4i8PKqkSKMeJjNOL6PuVrbhQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759308489; c=relaxed/simple;
	bh=YB1a54MMJXi5nKTH9gbuafJV6b8bO8PW9GeT78qICUA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iwvutdt7UcWy58PqBBQU0KcgkXEVuxtfTgXKXSXdc1Yhm3vOg4uGnnZFtLoKnGcPygc4FLN2S6ULfVCI2vuQwvtXITCitsWMDcZh7/8vVzT08Gq9rC9Ot/mRsqGOqLl8VjmkF0Q47AcZuRusExgNPOr5/SPKy8ZLWx1O1lzOhBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngSsctkV; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-273a0aeed57so8799705ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 01:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759308486; x=1759913286; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I7ZUVg/Nr4pBk2YqBecru/L6TvemL+I2eAgpr8B6DmM=;
        b=ngSsctkV+orETuTs/jHKwV3b0NfEvAZJvMRZrYO6TrNNhZOMCiSovUW4wHZGEwbjD3
         xt92lRtYuS+5u8jAL9m8hYxqC5L/hnPAl4ZkCyOQn7oojbz4ZaSt4aeQ/Rb5CmdD+00T
         37PwGpGf3n5hqiHy8TNGMVPtCR3K8Xa6prfVoj13LJBK/sEH56Bu8PCwQxF5Ef2zT1nB
         k5MWJduRl3xecqnpq9WUhFKUfUziJXT16XlCCxpyv8+raJBFc//mXV2R4Ps/j0eoaIQn
         wrYJfdvKFftMYe+1XVsP91dyoCmyzF7MdO6pLZxbSnICqHwpWD5SiJ3XgB+6i56KRl/t
         haMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759308486; x=1759913286;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I7ZUVg/Nr4pBk2YqBecru/L6TvemL+I2eAgpr8B6DmM=;
        b=nwY5tRvYXD3orNY1bHPQdSBIV1XFE2MD6xDXveMCCghncKf73Om36uUxOCmD960NwK
         x4+BzT+9ze7JqgJwQIt2GtAfr9mv3XkkmbE+s3fqXuazwgYHc7CbmVzqbhJOe21qD8GY
         SqSyNh+0zeTcUWyqyic61/fHCKl8cGFuRpUz4FbIXftDLs8oT0UeMRcq3ck4wuG+IKzN
         BSWmtVjX2/Te2S2MzPpMuc6eKP1SJ6qNhk3T7Isp2rD4mOKTiK62hNtE5WsVwEUMhzSC
         YB02bAsNjzJREOSdmKBeVxa5PaIdGnpu9Si5MgbBWj3MqqfS+gyusFAspo33fl6ZeeT0
         crRA==
X-Forwarded-Encrypted: i=1; AJvYcCV8cD/R9aA55jpUKMUps0W0JNLSUGQRZvteZSK6l8DJP4NuAu5d+fBEBNNdyrEPC5YpktevKXCBBCGkwqw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh44G/HMuYI9xCbQ22eo35mAzCaXoanLXPyQLMtBMvjriCCpYy
	yctiIHyEYywhBqVMRnIGLR5juyoyI4bd9QFiqzArKW7K6jPpD+Q3s9Lq
X-Gm-Gg: ASbGncv02AbtHFso81u4klbIXNbUKNOh+TXnK8oS90pgPm5Fu+2QkwHYqEyfU5hkTTY
	TkwXh763mKdRA8exZ6mhLXFTCCoOd4ztPvo2fU+0qK4aEeZjc+4EgBKia1/CcguE9kElduOwnuD
	vlWe74YWcGO9uJJTSjjmHBWBSFItQuVcPnjM8hZeCACj9QVlZm7cMFJ9Bs53YUm3KtTr4aI8/k4
	WkgK7Wx3qKwqsjEbftolk+hJDvWW7lGHC7yI02c16CsWxJ8v+hpODXTwczeCJNcKZWf9SCfVPBA
	di8Mr6TyXhv/64penPhkJ0KwQF/an10bTkDHOLZoBJ6UQp5iMolvDR5s3q8ZIfNdq01yZNfGUe+
	JwJPMP4aHzM0u41FoKfLpoQdKO0YY+i5g2I5T+lJphxT1TyVDE9l8FztvnBgPKoiafWNOjILk+H
	t0/LUTnoHzGaIq/z14N1gRU/HEgrdHwwh9DZV9ZMjLuHq45o0RHRNDsOY6E2hr58tDc8U/4Ll+8
	EXNnlwF6/yLMTRzD72kDTE/u5K74gIiJFcrgs1Ulwvri4w=
X-Google-Smtp-Source: AGHT+IFBY/scw80qunl2/T9Vu6PBaPWzoOPWOZLXzt1OOaGSVwS1oF91+HBdH7KtkzG6z1iTX3repQ==
X-Received: by 2002:a17:902:f689:b0:27e:f03e:c6b7 with SMTP id d9443c01a7336-28d16e89030mr90619895ad.10.1759308485671;
        Wed, 01 Oct 2025 01:48:05 -0700 (PDT)
Received: from 2001-b400-e387-f8be-46e6-cc88-b318-45e6.emome-ip6.hinet.net (2001-b400-e387-f8be-46e6-cc88-b318-45e6.emome-ip6.hinet.net. [2001:b400:e387:f8be:46e6:cc88:b318:45e6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6e9d22bsm1789250a91.3.2025.10.01.01.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 01:48:05 -0700 (PDT)
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Date: Wed, 01 Oct 2025 16:47:50 +0800
Subject: [PATCH v3 1/2] dt-bindings: arm: aspeed: add Meta Yosemite5 board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-yv5_add_dts-v3-1-54190fbc0785@gmail.com>
References: <20251001-yv5_add_dts-v3-0-54190fbc0785@gmail.com>
In-Reply-To: <20251001-yv5_add_dts-v3-0-54190fbc0785@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, Amithash Prasasd <amithash@meta.com>, 
 Kevin Tung <Kevin.Tung@quantatw.com>, Ken Chen <Ken.Chen@quantatw.com>, 
 Leo Yang <Leo-Yang@quantatw.com>, Kevin Tung <kevin.tung.openbmc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759308478; l=886;
 i=kevin.tung.openbmc@gmail.com; s=20250924; h=from:subject:message-id;
 bh=YB1a54MMJXi5nKTH9gbuafJV6b8bO8PW9GeT78qICUA=;
 b=9gzrykNcBM16KdVMIcgRlrKvmyEZmO4QeUAovkAYB+AyBN+PsDPZv3TANn7fES73RwX8lDO9T
 vVHS1f30eGtApZ+9z9igVVO00ELz8Jd0iYfWzrFWVfjKYXrdqQTH9bu
X-Developer-Key: i=kevin.tung.openbmc@gmail.com; a=ed25519;
 pk=PjAss0agA0hiuLfIBlA9j/qBmJaPCDP+jmQIUB6SE7g=

Document the new compatibles used on Meta Yosemite5.

Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 456dbf7b5ec8f4442be815284e1ad085287dc443..6f2b12f96bd6ce31b4175e109a78d931dffdfe28 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -89,6 +89,7 @@ properties:
               - facebook,minerva-cmc
               - facebook,santabarbara-bmc
               - facebook,yosemite4-bmc
+              - facebook,yosemite5-bmc
               - ibm,blueridge-bmc
               - ibm,everest-bmc
               - ibm,fuji-bmc

-- 
2.51.0


