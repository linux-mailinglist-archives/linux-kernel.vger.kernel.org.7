Return-Path: <linux-kernel+bounces-891757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E517C43684
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 00:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52F5B3B05E2
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 23:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F97C1AF0B6;
	Sat,  8 Nov 2025 23:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWvix6CO"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAC534D39A
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 23:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762645654; cv=none; b=j5jkUe9hF4Nz2EOM3WIV7eBPQhNPfyGwFJSzGoQIqRZ0mXkQtS2ijhEkiroc0a85nIjAEVLaSe+gijVqrWEDf1IH66ycRA949WFrYMqVwucEDY/Reo6ChE0s1vWfJ90T/ET3St3KG4SzhPJAVJS8U0oInzpnUwkPSRxHYTBjcoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762645654; c=relaxed/simple;
	bh=BUOtEMPYyYt+t1FKzyd/ATWiFVRc6UFC0g6MEt7nCRo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dwwoSSaTlGaLVuv9KRWfMDpG2NEbfRclAv7CeKoYYCQhy7Jo0pmaJ6qrdpUAu/SOamxcTn7ypaiq/FmzZs2cd5BmvOkOCuo5hDr0SAXm8SZohpbJKxmFoTcWkoW8x0uFarzfY/DHuVJclr/HxP80e7s5At23zvKyk6tpPCWd0JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWvix6CO; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-948673fdc47so66651439f.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 15:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762645652; x=1763250452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JuW/Q/BTw0tC4748Q+Q7F14J0Kz+4gQfN3nZoPIn47w=;
        b=GWvix6COMNXxJKSrXWbU1hdIpb7zYE3tsSC17yOElaPl0P3GEh6zTgw8HT2fPaSs6N
         GyQQqJHjOrQr98PGP4PiyzxqF6Q64AP1znvdkwCSQBjxskGKTrCUjAgTW82RDoO5WGTf
         EXfFNCzOGOwugrBHV/X33mMKYU0Hqkkfd8qLZV2xGb+6KGuu5lZfHKb4ixI9e1Cyjn41
         AFXzUuAZ8bQuFOwKbXr8SUhkS4gjN6EerFr/mouRgfD3zLLHMyo4tbvk2uxGY5nxVui7
         T1loXSypTS4GrnBesuMwojtCIvHGa+K/Hp+ZHLqU/LN9yDfXFmdQLxonWB6KeHmpG0Rn
         P7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762645652; x=1763250452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JuW/Q/BTw0tC4748Q+Q7F14J0Kz+4gQfN3nZoPIn47w=;
        b=lRSJDUTKX7NmRmEYVqDz+Punw4zZ7EixWb5+LLNHoBN33qe9ZsGbQZCdiYbd/wKxMS
         sH4wh6oZUQSTuqzXzFcxO766+O8vHSTj4AeuodL9INDDy2ymkH6PKxDMhBgX2A68YvBe
         9PsUpcZSyWugcuKWrfKpE9RG3/qofuuYo/y0vWOlGLNh8dgImB931efFn1Gq9FA9dfNK
         0e9Cx+rlMjWj7jcgPzHICEKzpmREKcF2sAsFHYZ0Lpc1g1HAmloIjvh7HwIIZSo/khQB
         BHbfxeiGXGZMG+7xDwRJm4ejkc6gZ7cOlXhhU0fbqL1uN9jgquLAEovzbpwZyCGiX3Ri
         HaWA==
X-Gm-Message-State: AOJu0YyC/wLghB33jpo9ANdDL56cj6CLAkLvbVgKaEDRxqCZdYR26Zuk
	CEP3qaq4udAOIvsvlEvm7a8WppAYiqSVjFE4t0SL3/hCJTi6y7fCBhSMx6VKqYM1
X-Gm-Gg: ASbGncsAKHC64njFzzCF3M5zxHpQzsCF+v0AMQQsNOIsap9y5fPoYMDlg63TewnB6d9
	0s7a9E30QPOJ9kif88cYork5sM3Tc/Azk6CXOdND5/8/I88dny7xeb4JopJHUK05AAeiu/4PPc4
	bxsxlLBDaYX1QOzFSjTkFnb6CnkJCWCC4XzXeBJY+J2eHfFxHMLSunkDH75nea5DXWJ3WizFT40
	UN+Aa/TAEBXUxeaF/m1I8mFyiuPzcYHVuHUwX5/X5cXDMEH+fiW68spHz1SkRN0czk6kzXuxj6k
	7Tr2hxI3V6PDQZh0OLgm+RL+6Uj90sLiw1a6fq1Lqx2Q/reubLuc/dJN+2sht376Alg/FkndLl3
	j/WTz7md3pwG/oyMUHqiBXp8BvKHeS32KtkdWQdQ7UC6dxBA10o3CMV6qtNQ6w/NaXUJug4515m
	7ucEhSiCFtHKV3bcZ5tZzfaJfBhPSR0jGcF0KYB1L3QNZyuul2aKPDLS5/FiSaC17vx8o=
X-Google-Smtp-Source: AGHT+IG3TJ2O078pID8TO0sMv9gH/WEEFwwLZBFprPDLToMAagoUArMpoyqW1bfTo+J4R+8yDYXcag==
X-Received: by 2002:a05:6602:2dd2:b0:945:a189:d683 with SMTP id ca18e2360f4ac-94896039224mr649340439f.15.1762645651676;
        Sat, 08 Nov 2025 15:47:31 -0800 (PST)
Received: from godzilla.raven-morpho.ts.net (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-5b7467d48d3sm3494218173.10.2025.11.08.15.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 15:47:30 -0800 (PST)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linuxfoundation.org,
	Jim Cromie <jim.cromie@gmail.com>,
	kernel test robot <lkp@intel.com>,
	Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 1/1] checkpatch: add MA_STATE to declaration_macros
Date: Sat,  8 Nov 2025 16:47:24 -0700
Message-ID: <20251108234725.1650246-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MA_STATE is used repeatedly as a declaration, add it to the list.

I left out the $Storage regex component, since I saw no cases wanting
it, via: $> grep -r -B1 '\bMA_STATE' .

This change fixes the following, reproduced locally.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202511071306.OJpTf7fK-lkp@intel.com/

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e722dd6fa8ef..4b5e2e64dece 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1096,7 +1096,8 @@ our $declaration_macros = qr{(?x:
 	(?:$Storage\s+)?(?:[A-Z_][A-Z0-9]*_){0,2}(?:DEFINE|DECLARE)(?:_[A-Z0-9]+){1,6}\s*\(|
 	(?:$Storage\s+)?[HLP]?LIST_HEAD\s*\(|
 	(?:SKCIPHER_REQUEST|SHASH_DESC|AHASH_REQUEST)_ON_STACK\s*\(|
-	(?:$Storage\s+)?(?:XA_STATE|XA_STATE_ORDER)\s*\(
+	(?:$Storage\s+)?(?:XA_STATE|XA_STATE_ORDER)\s*\(|
+	(?:MA_STATE)\s*\(
 )};
 
 our %allow_repeated_words = (
-- 
2.51.1


