Return-Path: <linux-kernel+bounces-730139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5648B040A5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB19A1884EAE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256AD2550AD;
	Mon, 14 Jul 2025 13:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BA30JU8Z"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7923253957;
	Mon, 14 Jul 2025 13:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752501287; cv=none; b=aMqu2ji/X+YtQ1JqmN7LOLvkKTd27boa5PjwLkq0fXYV09qHFS5LxvU2ACkf8Pib35v/S18o7NlvG63utKzHN0LXgu5VV1UWi2Gg+1oCcVZ9h5ZTwEe2/F0C1G+N+wwzxCYmjS3i4hI/ANEv1X408iA6TV3QnZeFlMWCahilyQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752501287; c=relaxed/simple;
	bh=d02pZDTCm099yrd+393e3eBxQw9Dcbzh+p3ugOAgB6Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GQE2o7eMayWwEd7RpARsSdcfZRwaq7ahu8hhON9iO70RUzahggWf6GLGQ42Mn9DfkXBrF03XzCj4zD6kCnyYAm69yS8LoKi+C+3v7JlBQm8LO9SXYGvaEljnB0Pe3lbcGMSwIKePb6ZqV3zqytSfCYWWCWzqipe0VHmefua2wcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BA30JU8Z; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4530921461aso28066795e9.0;
        Mon, 14 Jul 2025 06:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752501284; x=1753106084; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pcqleVpMtucnbrU4qqD3CqHSTuUaJLwoNghGZhsgkT0=;
        b=BA30JU8ZiVA2pt1p0UULT9iN7eb2a1yD1YGeLOUFeVkq2Zla4zml9FiZYKK3cOAD8e
         fEuwebvSQyEg8eaxN7V5g1yKIBQ7t+4RGirjBTIerJQNCSD1TfpqfBoiBw+0sjPhXj21
         T+nnT0t8oYZGwwKKubnydJ+5WAjnBagx4Z15XFEBWpu+pojiIta6lQS2tXBs+LLt11Ks
         h85lL/Y0vlux73+dv8udhXzLkJJf5uYOIRkc+nwEV3HZquHDkUBgwwl9KiZAy6Gakx7x
         qK6fecJjjZw/p48J3X8UjpBPC3/v7Oj/XMqOnC3zVLhfALHHdMReugaPlKIDXcenJ53q
         uW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752501284; x=1753106084;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pcqleVpMtucnbrU4qqD3CqHSTuUaJLwoNghGZhsgkT0=;
        b=JOOah/XJURKFwriCoq/yRo7RD2XgN03z3mojod1Cg4Si9RJHdiZdU1k6yraRS3ttMl
         jet+YHBRUyfWYx5KOTXKaJBXL8Q3lwbo/DE3NDIU0sp/EpxwBDje+pkEK8yy1C5FFDC1
         Y3OZWYs5hUK1KjnvGYL1CrYX6/zpY8WemOskaiQjMkjoG3C9YmVe74Fh1K+xM41lp3y7
         Mg5M68M7THekRjCk4Ax7X78pW46j7kC0NV/3qS5mpVMrIce0+1oTsPU+Re14fr2JwfTv
         M65hIDZXVrztkC7xzEBSCmi6PjH7MeOleQDN8cCl2rZuPQx94SibwfXJl/q40nT0rfTb
         xUVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXumXp9jaBYXcyzARssr65rlPWKjgQvTtiUavsG+6IInfhv9b1aZFvQUWC/wiuatsVQtffSVnUKS8on8yY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEcgoR7JdXWuCKxpBw+lCl1nkXGArvQN9X8bsjZY51ytBCQBVc
	SZriVT4hs2jX+BsOZEOlP2fivAP29axb83EAgCPS7apTeEA4dto1HISf
X-Gm-Gg: ASbGncvzmzvjYI/gl4rXi4ltJcTEv82J9O5LoOgyIPpX0Z1KADMHGRgeDzQkkD01sWY
	0avT7l4ReZqM7j29dBP0F1fceTQu6LPtkXqZA6ydxkcBIUABVuaCwU40s+aewhRc6j58mzKa87Q
	G2uIlAvZ5W3hLn0ZL3DRa6AhjDyrm6RD1A19Inl1fZVqCadDFwKEXwkbeXOW4P4vw3JBrv+Osec
	LFvEtvfNi/LINdgan8E6JaYBhfMw1V/mBs5NDCRImPXnk4n3cSeuxrAw3reZLPAbgxJsakUyJco
	IjWK8yN9Gy88+IsCaQAZxiCrRnYwZk7tS71F/OabC8VWdQGKelSsIzWCj2YcaR96v/eLUxkOCIQ
	DKA+YH2o4nMw6z2UoNthMR74=
X-Google-Smtp-Source: AGHT+IGX4nZxTd71nlcw2Kk+v9/hfjfQlnt9nodc7wlfOD+cS1bfZJPMYAqLuDznPo73eEAn9miMeg==
X-Received: by 2002:a05:600c:4f07:b0:456:24aa:9586 with SMTP id 5b1f17b1804b1-45624aa96fdmr1209585e9.21.1752501283902;
        Mon, 14 Jul 2025 06:54:43 -0700 (PDT)
Received: from localhost ([2001:861:3385:e20:2acd:89a8:83d9:4be5])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-456084873b0sm73656355e9.39.2025.07.14.06.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 06:54:43 -0700 (PDT)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
Date: Mon, 14 Jul 2025 15:49:15 +0200
Subject: [PATCH v2 2/3] ARM: sti: removal of stih415/stih416 related
 entries
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-sti-rework-v2-2-f4274920858b@gmail.com>
References: <20250714-sti-rework-v2-0-f4274920858b@gmail.com>
In-Reply-To: <20250714-sti-rework-v2-0-f4274920858b@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Alain Volmat <avolmat@me.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2325; i=rgallaispou@gmail.com;
 h=from:subject:message-id; bh=ipzPiez7hh5J1Pn5le5PfVDV0631DokeqQWJXnEH7lw=;
 b=owEBbQKS/ZANAwAKAechimjUEsK1AcsmYgBodQwg1NtKf3vjzP23TWLMiNSkGQX3dchxNjkrM
 f+ceEjrLBKJAjMEAAEKAB0WIQQgmXv2E+fvbV/9ui/nIYpo1BLCtQUCaHUMIAAKCRDnIYpo1BLC
 tRdeD/9xLXRor76BApIiv+yXhvqUfSD1+nJ6F+mjzAIql19wBWphKwRyhbhgyO6twGz2aN9erTK
 m9KQyxS/+Xq58lt+rCfJ9tgfvWP6fgaNB5uVStjomdd+zo3q8JBP/VOPmTmeCV5ryWpNNyBzTEm
 YnmiA7tJzB6W7rTlo1gukHV6LiqYwS2M/EnnbcT8vX3ezYzICw3H5T1cfm848OvxJF+kw7m7TQ2
 VEjrW5N/uqQtJYUpQ/KElmiCoNUB+8fFwUsilqdSU9PJN+YCNDo4dXEKMkVUyzMEh9ZKk2wqsKd
 wGRQ3wLspch1ISRcwmw9tewruuFB8dE618E6P+qORJr+4uHlVS1Rvn/DFcUiXRQqhdQCd/hPVQb
 MTZm+flaHf30NMvDiSd1LfyP8UnoxZ9n9MJMD/WRtHDiWm01mUm6D2k8mI6GffyBJlFpZZIWUmd
 GaDaVWXPFM2JRU/pOBPlSB2pFujJbE7uTtSiPTTrWLKXB20yIVuEwk1218IeubfZpv14PkOZKzq
 56m5bGehlfk0+zcZUM4QPmUE8wTjbTK5nprjgXJUhXZ6hNwq7OeaHMA+KMYeUXwPv5UaI2NpWoA
 Ua+zzv1Yvv2ff8xoOecEgIYXHNBQGMjWa/USjsELCOYawZB2qwTugz6tarDonEw+NZCIv/ALnaD
 EWG3rCVXSN7W/Pw==
X-Developer-Key: i=rgallaispou@gmail.com; a=openpgp;
 fpr=20997BF613E7EF6D5FFDBA2FE7218A68D412C2B5

From: Alain Volmat <avolmat@me.com>

ST's STiH415 and STiH416 platforms have already been removed since
a while.  Remove some remaining bits within the mach-sti.

Signed-off-by: Alain Volmat <avolmat@me.com>
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
 arch/arm/mach-sti/Kconfig    | 20 +-------------------
 arch/arm/mach-sti/board-dt.c |  2 --
 2 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/arch/arm/mach-sti/Kconfig b/arch/arm/mach-sti/Kconfig
index b3842c971d31b80edaf88ab907f4377bea0a2af5..e58699e13e1a55ce46e68908c7ef51e18b040dc9 100644
--- a/arch/arm/mach-sti/Kconfig
+++ b/arch/arm/mach-sti/Kconfig
@@ -19,31 +19,13 @@ menuconfig ARCH_STI
 	select PL310_ERRATA_769419 if CACHE_L2X0
 	select RESET_CONTROLLER
 	help
-	  Include support for STMicroelectronics' STiH415/416, STiH407/10 and
+	  Include support for STMicroelectronics' STiH407/10 and
 	  STiH418 family SoCs using the Device Tree for discovery.  More
 	  information can be found in Documentation/arch/arm/sti/ and
 	  Documentation/devicetree.
 
 if ARCH_STI
 
-config SOC_STIH415
-	bool "STiH415 STMicroelectronics Consumer Electronics family"
-	default y
-	help
-	  This enables support for STMicroelectronics Digital Consumer
-	  Electronics family StiH415 parts, primarily targeted at set-top-box
-	  and other digital audio/video applications using Flattned Device
-	  Trees.
-
-config SOC_STIH416
-	bool "STiH416 STMicroelectronics Consumer Electronics family"
-	default y
-	help
-	  This enables support for STMicroelectronics Digital Consumer
-	  Electronics family StiH416 parts, primarily targeted at set-top-box
-	  and other digital audio/video applications using Flattened Device
-	  Trees.
-
 config SOC_STIH407
 	bool "STiH407 STMicroelectronics Consumer Electronics family"
 	default y
diff --git a/arch/arm/mach-sti/board-dt.c b/arch/arm/mach-sti/board-dt.c
index 488084b61b4acafb569ee9c51f5769393d55a9ce..1aaf61184685d754de57b487aef9a6b45a759b23 100644
--- a/arch/arm/mach-sti/board-dt.c
+++ b/arch/arm/mach-sti/board-dt.c
@@ -10,8 +10,6 @@
 #include "smp.h"
 
 static const char *const stih41x_dt_match[] __initconst = {
-	"st,stih415",
-	"st,stih416",
 	"st,stih407",
 	"st,stih410",
 	"st,stih418",

-- 
2.50.1


